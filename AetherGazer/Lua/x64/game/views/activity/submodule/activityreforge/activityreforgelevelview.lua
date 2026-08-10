local var_0_0 = class("ActivityReforgeLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeLevelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.isShowRewardPanel_ = false
	arg_3_0.isSelectLevel_ = false
	arg_3_0.levelID_ = 0
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.levelItemList_ = {}
	arg_4_0.levelItemClickHandler_ = handler(arg_4_0, arg_4_0.OnLevelItemClick)

	for iter_4_0 = 1, 6 do
		arg_4_0.levelItemList_[iter_4_0] = ActivityReforgeLevelViewItem.New(arg_4_0["levelItemGo" .. iter_4_0 .. "_"], arg_4_0.levelItemClickHandler_)
	end

	arg_4_0.isPassController_ = arg_4_0.controllerEx_:GetController("ispass")
	arg_4_0.isBattlingController_ = arg_4_0.controllerEx_:GetController("isbattling")
	arg_4_0.isSelectController_ = arg_4_0.controllerEx_:GetController("isselect")
	arg_4_0.isGetAllRewardController_ = arg_4_0.controllerEx_:GetController("isGetAllReward")
	arg_4_0.levelIndexController_ = arg_4_0.controllerEx_:GetController("levelIndex")
	arg_4_0.timeInfoItem_ = ActivityReforgeLevelFinishItem.New(arg_4_0.timeInfoGo_)
	arg_4_0.pointInfoItem_ = ActivityReforgeLevelFinishItem.New(arg_4_0.pointInfoGo_)
	arg_4_0.goldInfoItem_ = ActivityReforgeLevelFinishItem.New(arg_4_0.goldInfoGo_)
end

function var_0_0.OnLevelItemClick(arg_5_0, arg_5_1)
	arg_5_0.curLevelItemIndex_ = arg_5_1
	arg_5_0.levelID_ = arg_5_0.cfg_.level_list[arg_5_0.curLevelItemIndex_]
	arg_5_0.isSelectLevel_ = true

	arg_5_0.isSelectController_:SetSelectedState("true")
	arg_5_0:RefreshLevelItemSelect()
	arg_5_0:RefreshLevelInfoUI()
end

function var_0_0.RefreshLevelItem(arg_6_0)
	for iter_6_0 = 1, 6 do
		if iter_6_0 <= #arg_6_0.cfg_.level_list then
			arg_6_0.levelItemList_[iter_6_0]:SetActive(true)
			arg_6_0.levelItemList_[iter_6_0]:SetData(iter_6_0, arg_6_0.chapterActivityID_, arg_6_0.cfg_.level_list[iter_6_0])
			arg_6_0.levelItemList_[iter_6_0]:RefreshSelect(arg_6_0.curLevelItemIndex_)
		else
			arg_6_0.levelItemList_[iter_6_0]:SetActive(false)
		end
	end
end

function var_0_0.RefreshLevelItemSelect(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.cfg_.level_list do
		arg_7_0.levelItemList_[iter_7_0]:RefreshSelect(arg_7_0.curLevelItemIndex_)
	end
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.goldInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeGoldInfoView")
	end)
	arg_8_0:AddBtnListener(arg_8_0.startBtn_, nil, function()
		if ActivityReforgeData:GetCurLevel() ~= 0 then
			ShowMessageBox({
				content = GetTips("ACTIVITY_REFORGE_RESTART_LEVEL_TIPS"),
				OkCallback = function()
					ActivityReforgeAction.StartLevel(arg_8_0.chapterActivityID_, arg_8_0.levelID_, function()
						JumpTools.OpenPageByJump("/activityReforgeWaveView", {
							activityID = arg_8_0.activityID_,
							chapterActivityID = arg_8_0.chapterActivityID_,
							levelID = arg_8_0.levelID_
						})
					end)
				end
			})
		else
			ActivityReforgeAction.StartLevel(arg_8_0.chapterActivityID_, arg_8_0.levelID_, function()
				JumpTools.OpenPageByJump("/activityReforgeWaveView", {
					activityID = arg_8_0.activityID_,
					chapterActivityID = arg_8_0.chapterActivityID_,
					levelID = arg_8_0.levelID_
				})
			end)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.giveUpBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_IS_GIVEUP_CURLEVEL"),
			OkCallback = function()
				ActivityReforgeAction.GiveUpCurLevel(arg_8_0.chapterActivityID_, arg_8_0.cfg_.level_list[arg_8_0.curLevelItemIndex_])
			end
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.continueBtn_, nil, function()
		local var_16_0 = ActivityReforgeLevelCfg[arg_8_0.levelID_].wave_list
		local var_16_1 = ActivityReforgeData:GetCurLastWinWaveID()

		if ActivityReforgeData:GetCurLevel() ~= 0 and var_16_1 == 0 then
			JumpTools.OpenPageByJump("/activityReforgeWaveView", {
				activityID = arg_8_0.activityID_,
				chapterActivityID = arg_8_0.chapterActivityID_,
				levelID = arg_8_0.levelID_
			})
		elseif var_16_0[#var_16_0] == var_16_1 then
			JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
				activityID = arg_8_0.activityID_,
				chapterActivityID = arg_8_0.chapterActivityID_,
				levelID = arg_8_0.levelID_,
				waveID = var_16_1
			})
		else
			JumpTools.OpenPageByJump("/activityReforgeTrimView", {
				activityID = arg_8_0.activityID_,
				chapterActivityID = arg_8_0.chapterActivityID_,
				levelID = arg_8_0.levelID_
			})
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.rewardBtn_, nil, function()
		if arg_8_0.isShowRewardPanel_ then
			arg_8_0.isShowRewardPanel_ = false
		else
			arg_8_0.isShowRewardPanel_ = true
		end

		SetActive(arg_8_0.rewardPanel_, arg_8_0.isShowRewardPanel_)
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		if arg_8_0.isSelectLevel_ then
			arg_8_0.curLevelItemIndex_ = 0
			arg_8_0.levelID_ = 0
			arg_8_0.isSelectLevel_ = false

			arg_8_0.isSelectController_:SetSelectedState("false")
			arg_8_0:RefreshLevelItemSelect()
		end
	end)
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.activityID_ = arg_19_0.params_.activityID
	arg_19_0.chapterActivityID_ = arg_19_0.params_.chapterActivityID
	arg_19_0.cfg_ = ActivityReforgeChapterCfg[arg_19_0.chapterActivityID_]
	arg_19_0.curLevelItemIndex_ = 0
	arg_19_0.levelID_ = 0
	arg_19_0.isSelectLevel_ = false

	arg_19_0.isSelectController_:SetSelectedState("false")
	arg_19_0:RefreshUI()
	arg_19_0:CheckCacheAddGoldNum()
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_REFORGE_GAMEHELPKEY")
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:StopAddGoldNumTimer()
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0.goldMaxNum_.text = ActivityReforgeData:GetGoldMaxNum(arg_22_0.activityID_)
	arg_22_0.rewardNum_.text = "+" .. arg_22_0.cfg_.reward_money

	local var_22_0 = ActivityReforgeData:GetChapterFinishLevelNum(arg_22_0.chapterActivityID_)

	arg_22_0.passSlider_.value = var_22_0 / #arg_22_0.cfg_.level_list
	arg_22_0.passNum_.text = var_22_0 .. "/" .. #arg_22_0.cfg_.level_list
	arg_22_0.chapterName_.text = arg_22_0.cfg_.chapter_name

	if var_22_0 >= #arg_22_0.cfg_.level_list then
		arg_22_0.isGetAllRewardController_:SetSelectedState("true")
	else
		arg_22_0.isGetAllRewardController_:SetSelectedState("false")
	end

	arg_22_0:RefreshLevelItem()
	arg_22_0:RefreshLevelInfoUI()
end

function var_0_0.RefreshLevelInfoUI(arg_23_0)
	if arg_23_0.isSelectLevel_ == false then
		return
	end

	if arg_23_0.levelID_ == ActivityReforgeData:GetCurLevel() then
		arg_23_0.isBattlingController_:SetSelectedState("true")
	else
		arg_23_0.isBattlingController_:SetSelectedState("false")
	end

	arg_23_0.isPassController_:SetSelectedState("false")

	if ActivityReforgeData:GetLevelIsFinish(arg_23_0.chapterActivityID_, arg_23_0.levelID_) then
		ActivityReforgeAction.RequestAllPlayerLevelData(arg_23_0.chapterActivityID_, arg_23_0.levelID_, function()
			arg_23_0:RefreshLevelFinishUI()
		end)
	end

	local var_23_0 = ActivityReforgeLevelCfg[arg_23_0.levelID_]

	arg_23_0.levelName_.text = var_23_0.name
	arg_23_0.levelDes_.text = var_23_0.description
	arg_23_0.levelRewardNum_.text = "+" .. var_23_0.reward_money

	arg_23_0.levelIndexController_:SetSelectedState(table.indexof(arg_23_0.cfg_.level_list, arg_23_0.levelID_))
end

function var_0_0.RefreshLevelFinishUI(arg_25_0)
	arg_25_0.isPassController_:SetSelectedState("true")

	local var_25_0 = ActivityReforgeGameSettingCfg[arg_25_0.activityID_].bar_num_min
	local var_25_1 = ActivityReforgeData:GetBestFinishLevelServerData(arg_25_0.levelID_)
	local var_25_2 = ActivityReforgeData:GetLevelAllPlayerServerData(arg_25_0.levelID_)

	arg_25_0.levelName_.text = ActivityReforgeLevelCfg[arg_25_0.levelID_].name

	arg_25_0.timeInfoItem_:SetData(1, var_25_0, arg_25_0.levelID_, var_25_1.minUseSeconds, var_25_2.minUseSeconds.rangeValue, var_25_2.minUseSeconds.rangeLength)
	arg_25_0.pointInfoItem_:SetData(2, var_25_0, arg_25_0.levelID_, var_25_1.minLosePoint, var_25_2.minLosePoint.rangeValue, var_25_2.minLosePoint.rangeLength)
	arg_25_0.goldInfoItem_:SetData(3, var_25_0, arg_25_0.levelID_, var_25_1.minUseGold, var_25_2.minUseGold.rangeValue, var_25_2.minUseGold.rangeLength)
end

function var_0_0.OnActivityReforgeGiveUpLevel(arg_26_0)
	arg_26_0:RefreshLevelItem()
	arg_26_0:RefreshLevelInfoUI()
end

function var_0_0.CheckCacheAddGoldNum(arg_27_0)
	local var_27_0 = ActivityReforgeData:GetCacheAddGoldNum()

	if var_27_0 > 0 then
		arg_27_0.goldAddText_.text = "+" .. var_27_0

		SetActive(arg_27_0.goldAddGo_, true)
		arg_27_0:StopAddGoldNumTimer()

		arg_27_0.addGoldNumCacheTimer_ = Timer.New(function()
			arg_27_0:StopAddGoldNumTimer()
			SetActive(arg_27_0.goldAddGo_, false)

			arg_27_0.goldMaxNum_.text = ActivityReforgeData:SubGoldMaxNum(arg_27_0.activityID_, var_27_0)

			ActivityReforgeData:ClearCacheAddGoldNum()
		end, 2, 1)

		arg_27_0.addGoldNumCacheTimer_:Start()
	else
		SetActive(arg_27_0.goldAddGo_, false)
	end
end

function var_0_0.StopAddGoldNumTimer(arg_29_0)
	if arg_29_0.addGoldNumCacheTimer_ then
		arg_29_0.addGoldNumCacheTimer_:Stop()

		arg_29_0.addGoldNumCacheTimer_ = nil
	end
end

function var_0_0.Dispose(arg_30_0)
	for iter_30_0 = 1, 6 do
		arg_30_0.levelItemList_[iter_30_0]:Dispose()
	end

	arg_30_0.levelItemList_ = nil
	arg_30_0.levelItemClickHandler_ = nil

	arg_30_0.timeInfoItem_:Dispose()
	arg_30_0.pointInfoItem_:Dispose()
	arg_30_0.goldInfoItem_:Dispose()

	arg_30_0.timeInfoItem_ = nil
	arg_30_0.pointInfoItem_ = nil
	arg_30_0.goldInfoItem_ = nil

	arg_30_0:StopAddGoldNumTimer()
	arg_30_0.super.Dispose(arg_30_0)
end

return var_0_0
