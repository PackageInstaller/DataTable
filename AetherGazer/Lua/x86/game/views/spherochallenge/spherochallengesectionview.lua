SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("SPHeroChallengeSectionView", SectionBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
	arg_1_0.hideStageDescController_:SetSelectedState("false")

	arg_1_0.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(arg_1_0.threeStarGo_)
end

function var_0_0.AddListeners(arg_2_0)
	var_0_0.super.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.timeInfoBtn, nil, function()
		if arg_2_0.challengeTimeController_:GetSelectedState() == "show" then
			arg_2_0.challengeTimeController_:SetSelectedState("showTip")

			arg_2_0.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			arg_2_0.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.info = SPHeroChallengeData:GetCurActivityInfo()

	var_0_0.super.OnEnter(arg_4_0)
	arg_4_0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_CHALLENGE, function()
		arg_4_0:RefreshPlayTime()
	end)
end

function var_0_0.UpdateBar(arg_6_0)
	return
end

function var_0_0.RefreshData(arg_7_0)
	arg_7_0.cfg_ = BattleStageTools.GetStageCfg(arg_7_0.params_.sectionType, arg_7_0.params_.section)

	arg_7_0.hideFatigueController_:SetSelectedState("close")
	arg_7_0.btnWebController_:SetSelectedState("close")

	if arg_7_0.params_.challengeType == SpHeroChallengeConst.ChapterType.story then
		if SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(arg_7_0.params_.section) then
			arg_7_0.challengeTimeController_:SetSelectedState("close")
		else
			arg_7_0.challengeTimeController_:SetSelectedState("show")
		end
	elseif arg_7_0.params_.sectionType == SpHeroChallengeConst.ChapterType.train then
		arg_7_0.challengeTimeController_:SetSelectedState("show")
	elseif arg_7_0.params_.sectionType == SpHeroChallengeConst.ChapterType.boss then
		arg_7_0.challengeTimeController_:SetSelectedState("show")
		arg_7_0.refreshTimeController_:SetSelectedState("show")
	end

	arg_7_0.lock_, arg_7_0.lockTips_ = SPHeroChallengeTools:CheckStageIsOpen(arg_7_0.params_.section)
	arg_7_0.cost_ = 0
	arg_7_0.isFirstClear_ = arg_7_0:CheckStageIsFirstClear(arg_7_0.params_.section)
	arg_7_0.dropLibID_ = BattleVerthandiExclusiveCfg[arg_7_0.params_.section].drop_lib_id

	arg_7_0:RefreshPlayTime()
end

function var_0_0.RefreshPlayTime(arg_8_0)
	if SPHeroChallengeTools:CheckScheduleNeedCostTime(arg_8_0.params_.section) then
		arg_8_0.challengeTimeController_:SetSelectedState("close")

		arg_8_0.totalNum = 0
		arg_8_0.curNum = 0
	else
		local var_8_0 = BattleVerthandiExclusiveCfg[arg_8_0.params_.section].sub_type

		arg_8_0.totalNum, arg_8_0.curNum = SPHeroChallengeData:GetCurActivityInfo():GetChallengeTimes()

		arg_8_0.challengeTimeController_:SetSelectedState("show")

		local var_8_1 = arg_8_0.totalNum - arg_8_0.curNum
		local var_8_2

		if var_8_1 <= 0 then
			var_8_2 = string.format("<color='#FF000B'>%d</color>", tostring(var_8_1))
		else
			var_8_2 = tostring(var_8_1)
		end

		arg_8_0.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), var_8_2, tonumber(1))
	end
end

function var_0_0.CheckStageIsFirstClear(arg_9_0, arg_9_1)
	if BattleVerthandiExclusiveCfg[arg_9_1].sub_type == SpHeroChallengeConst.ScheduleSubType.story then
		return not table.indexof(arg_9_0.info.storyFinStageList, arg_9_1)
	else
		return true
	end
end

function var_0_0.RefreshStageInfo(arg_10_0)
	arg_10_0.btnWebController_:SetSelectedState("notshow")

	arg_10_0.cfg_ = BattleStageTools.GetStageCfg(arg_10_0.params_.sectionType, arg_10_0.params_.section)

	if arg_10_0.cfg_ and arg_10_0.oldCfgID_ ~= arg_10_0.cfg_.id then
		arg_10_0.sectionName_.text = GetI18NText(arg_10_0.cfg_.name)
		arg_10_0.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, arg_10_0.cfg_.background_1)
		arg_10_0.oldCfgID_ = arg_10_0.cfg_.id
		arg_10_0.multiple_ = 1

		arg_10_0.hideThreeStarController_:SetSelectedState("true")

		arg_10_0.storyText_.text = BattleVerthandiExclusiveCfg[arg_10_0.params_.section].tips

		if arg_10_0.params_.challengeType == SpHeroChallengeConst.ChapterType.story then
			arg_10_0.hideThreeStarController_:SetSelectedState("false")

			local var_10_0 = SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(arg_10_0.params_.section)

			arg_10_0.threeStarDataList_ = {
				{
					var_10_0,
					{
						8
					}
				},
				{
					false
				},
				{
					false
				}
			}

			arg_10_0.sectionInfoThreeStarBar_:SetData(arg_10_0.threeStarDataList_)
		end
	end
end

function var_0_0.OnClickBtn(arg_11_0)
	local var_11_0, var_11_1 = SPHeroChallengeTools:CheckStoryStageCanBattle(arg_11_0.params_.section)

	if var_11_0 then
		ShowTips(var_11_1)

		return
	end

	arg_11_0:GoToSelectHero()
end

function var_0_0.GoToSelectHero(arg_12_0)
	if not SPHeroChallengeTools:CheckActivityCloseWithTips() then
		if (arg_12_0.params_.challengeType == SpHeroChallengeConst.ChapterType.train or arg_12_0.params_.challengeType == SpHeroChallengeConst.ChapterType.boss) and arg_12_0.totalNum - arg_12_0.curNum <= 0 then
			local var_12_0 = ""

			if arg_12_0.params_.challengeType == SpHeroChallengeConst.ChapterType.train then
				var_12_0 = "ACTIVITY_HERO_CHALLENGE_NONE_TRAIN"
			elseif arg_12_0.params_.challengeType == SpHeroChallengeConst.ChapterType.boss then
				var_12_0 = "ACTIVITY_HERO_CHALLENGE_NONE_BOSS"
			end

			ShowMessageBox({
				content = GetTips(var_12_0),
				OkCallback = function()
					arg_12_0:Go("/sectionSelectHero", {
						section = arg_12_0.params_.section,
						sectionType = arg_12_0.params_.sectionType,
						activityID = arg_12_0.params_.activityId,
						multiple = arg_12_0.multiple_,
						dest = arg_12_0.params_.index
					})
				end,
				CancelCallback = function()
					return
				end
			})
		else
			arg_12_0:Go("/sectionSelectHero", {
				section = arg_12_0.params_.section,
				sectionType = arg_12_0.params_.sectionType,
				activityID = arg_12_0.params_.activityId,
				multiple = arg_12_0.multiple_,
				dest = arg_12_0.params_.index
			})
		end
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.sectionInfoThreeStarBar_:Dispose()

	arg_15_0.sectionInfoThreeStarBar_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
