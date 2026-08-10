local var_0_0 = {
	EASY = 1,
	HARD = 2
}
local var_0_1 = class("AreaBattleMapView", ReduxView)

function var_0_1.UIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.params_.mainActivityID) .. "NormalfightingMapUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.proxy = HeroViewDataProxy.New(1)
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.easyController = arg_4_0.easyController_:GetController("lock")
	arg_4_0.hardController = arg_4_0.hardController_:GetController("lock")
	arg_4_0.easySelectController = arg_4_0.easyController_:GetController("select")
	arg_4_0.hardSelectController = arg_4_0.hardController_:GetController("select")
	arg_4_0.difficultController = arg_4_0.mainController_:GetController("difficult")
	arg_4_0.pass1Controller = arg_4_0.passController1_:GetController("pass")
	arg_4_0.select1Controller = arg_4_0.passController1_:GetController("select")
	arg_4_0.pass2Controller = arg_4_0.passController2_:GetController("pass")
	arg_4_0.select2Controller = arg_4_0.passController2_:GetController("select")
	arg_4_0.pass3Controller = arg_4_0.passController3_:GetController("pass")
	arg_4_0.select3Controller = arg_4_0.passController3_:GetController("select")
	arg_4_0.rankController = arg_4_0.rankController_:GetController("haveRecord")
	arg_4_0.moveController = arg_4_0.mainController_:GetController("move")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.listGo_, AreaBattleBuffItem)
	arg_4_0.difficultList = {}
end

function var_0_1.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.cfg.debuff_list[arg_5_1])
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		if arg_6_0.isOpen then
			return
		end

		arg_6_0.selectIndex = nil

		TaskTools:ShowActivityTaskPop(arg_6_0.activityID, ActivityAreaBattleData:GetPrefabByActivityID(arg_6_0.mainActivityID) .. "NormalfightingSeizuresTipsUI")
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		SetActive(arg_6_0.tipsGo_, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.resetBtn_, nil, function()
		if arg_6_0.isOpen then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_AREA_BATTLE_RESETTING_CONFIRM_TIP2"),
			OkCallback = function()
				local var_10_0 = arg_6_0.data.difficultList[arg_6_0.difficult] or {}
				local var_10_1 = {}

				for iter_10_0, iter_10_1 in pairs(var_10_0) do
					table.insert(var_10_1, iter_10_0)
				end

				if #var_10_1 == 0 then
					ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_FAIL")

					return
				end

				arg_6_0.selectIndex = nil

				AreaBattleAction.ResetBattleData(arg_6_0.activityID, var_10_1)
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.normalBtn_, nil, function()
		if arg_6_0.isOpen then
			return
		end

		if arg_6_0.difficult == var_0_0.EASY then
			return
		end

		arg_6_0.difficult = var_0_0.EASY
		arg_6_0.selectIndex = nil

		SetActive(arg_6_0.tipsGo_, false)
		arg_6_0.animator_:Play("NormalfightingMapUI", 0, 0)
		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.hardBtn_, nil, function()
		if arg_6_0.isOpen then
			return
		end

		if arg_6_0.difficult == var_0_0.HARD then
			return
		end

		arg_6_0.difficult = var_0_0.HARD

		arg_6_0.animator_:Play("NormalfightingMapUI", 0, 0)

		arg_6_0.selectIndex = nil

		SetActive(arg_6_0.tipsGo_, false)
		arg_6_0:UpdateView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.rankBtn_, nil, function()
		if arg_6_0.isOpen then
			return
		end

		JumpTools.GoToSystem("/AreaBattleRankView", {
			activityID = arg_6_0.activityID,
			mainActivityID = arg_6_0.mainActivityID
		})

		arg_6_0.selectIndex = nil
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		if arg_6_0.isOpen then
			arg_6_0.Back()
		end
	end)

	for iter_6_0 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["area" .. iter_6_0 .. "Btn_"], nil, function()
			if arg_6_0["select" .. iter_6_0 .. "Controller"]:GetSelectedState() == "lock" then
				local var_15_0 = BattleAreaBattleCfg[arg_6_0.cfg.stage_id[arg_6_0.difficult][iter_6_0]].unlock_condition

				if var_15_0 == "" or #var_15_0 == 0 then
					return
				end

				local var_15_1 = ConditionCfg[var_15_0[1]]

				ShowTips(var_15_1.desc)

				return
			end

			SetActive(arg_6_0.tipsGo_, false)
			JumpTools.OpenPageByJump("AreaBattleChapterSectionView", {
				stageID = arg_6_0.cfg.stage_id[arg_6_0.difficult][iter_6_0],
				activityID = arg_6_0.activityID,
				mainActivityID = arg_6_0.mainActivityID,
				difficult = arg_6_0.difficult,
				parent = arg_6_0
			})

			for iter_15_0 = 1, 3 do
				if iter_15_0 == iter_6_0 then
					arg_6_0["select" .. iter_15_0 .. "Controller"]:SetSelectedState("true")
				else
					arg_6_0["select" .. iter_15_0 .. "Controller"]:SetSelectedState("false")
				end

				local var_15_2 = BattleAreaBattleCfg[arg_6_0.cfg.stage_id[arg_6_0.difficult][iter_15_0]].unlock_condition
				local var_15_3 = true

				if var_15_2 ~= "" and #var_15_2 > 0 then
					for iter_15_1 = 1, #var_15_2 do
						local var_15_4 = tonumber(var_15_2[iter_15_1])

						if not IsConditionAchieved(var_15_4) then
							var_15_3 = false

							break
						end
					end
				end

				if not var_15_3 then
					arg_6_0["select" .. iter_15_0 .. "Controller"]:SetSelectedState("lock")
				end
			end

			arg_6_0.selectIndex = tostring(iter_6_0)
			arg_6_0.stageID = arg_6_0.cfg.stage_id[arg_6_0.difficult][iter_6_0]

			arg_6_0.moveController:SetSelectedState(arg_6_0.selectIndex)

			if arg_6_0.isOpen then
				manager.notify:CallUpdateFunc(AREA_BATTLE_AREA_REFRESH, arg_6_0.cfg.stage_id[arg_6_0.difficult][iter_6_0])
			end

			arg_6_0.isOpen = true
		end)
	end
end

function var_0_1.UpdateData(arg_16_0)
	arg_16_0.activityID = arg_16_0.params_.activityID

	if arg_16_0.difficultList[arg_16_0.activityID] ~= nil then
		arg_16_0.difficult = arg_16_0.difficultList[arg_16_0.activityID]
	else
		arg_16_0.difficult = var_0_0.HARD
	end

	arg_16_0.rankActivityID = ActivityCfg[arg_16_0.activityID].sub_activity_list[1]
	arg_16_0.mainActivityID = arg_16_0.params_.mainActivityID
	arg_16_0.cfg = ActivityAreaBattleCfg[arg_16_0.activityID]
	arg_16_0.data = ActivityAreaBattleData:GetDataByActivityID(arg_16_0.mainActivityID)[arg_16_0.activityID]

	for iter_16_0, iter_16_1 in pairs(arg_16_0.cfg.stage_id[2]) do
		if iter_16_1 == arg_16_0.stageID then
			arg_16_0.difficult = var_0_0.HARD
		end
	end
end

function var_0_1.UpdateView(arg_17_0)
	arg_17_0.easySelectController:SetSelectedState(arg_17_0.difficult == var_0_0.EASY and "true" or "false")
	arg_17_0.difficultController:SetSelectedState(tostring(arg_17_0.difficult))

	if arg_17_0.cfg.reward_list and type(arg_17_0.cfg.reward_list) == "table" then
		arg_17_0.scoreTxt_.text = math.min(arg_17_0.data.allChallengeValue, arg_17_0.cfg.reward_list[#arg_17_0.cfg.reward_list][1]) .. "/" .. arg_17_0.cfg.reward_list[#arg_17_0.cfg.reward_list][1]
		arg_17_0.slider_.value = math.min(arg_17_0.data.allChallengeValue, arg_17_0.cfg.reward_list[#arg_17_0.cfg.reward_list][1]) / arg_17_0.cfg.reward_list[#arg_17_0.cfg.reward_list][1]
	end

	arg_17_0.areaNameTxt_.text = GetI18NText(arg_17_0.cfg.name)

	arg_17_0.list:StartScroll(#arg_17_0.cfg.debuff_list)

	if arg_17_0.selectIndex then
		arg_17_0.moveController:SetSelectedState(arg_17_0.selectIndex)
	end

	arg_17_0:UpdateAreaItemView()

	arg_17_0.difficultList[arg_17_0.activityID] = arg_17_0.difficult
end

function var_0_1.UpdateAreaItemView(arg_18_0)
	for iter_18_0 = 1, 3 do
		local var_18_0 = arg_18_0.cfg.stage_id[arg_18_0.difficult][iter_18_0]

		arg_18_0["area" .. iter_18_0 .. "NameTxt_"].text = GetI18NText(BattleAreaBattleCfg[var_18_0].name)

		for iter_18_1 = 1, 3 do
			SetActive(arg_18_0["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].gameObject, false)

			if arg_18_0.data.difficultList[arg_18_0.difficult] and arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0] and arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].usedHeroList[iter_18_1] then
				SetActive(arg_18_0["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].gameObject, true)

				local var_18_1 = arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].usedHeroList[iter_18_1] % 10000

				if HeroStandardSystemCfg[arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].usedHeroList[iter_18_1]] then
					arg_18_0["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].sprite = getSpriteViaConfig("HeroItemshead", HeroStandardSystemCfg[arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].usedHeroList[iter_18_1]].skin_id)
				else
					arg_18_0["lock" .. iter_18_0 .. iter_18_1 .. "Image_"].sprite = getSpriteViaConfig("HeroItemshead", arg_18_0.proxy:GetHeroUsingSkinInfo(var_18_1).id)
				end
			end
		end

		arg_18_0["select" .. iter_18_0 .. "Controller"]:SetSelectedState("false")

		if arg_18_0.data.difficultList[arg_18_0.difficult] == nil or arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0] == nil then
			arg_18_0["pass" .. iter_18_0 .. "Controller"]:SetSelectedState("false")

			if iter_18_0 < 3 then
				arg_18_0["area" .. iter_18_0 .. "1ScoreTxt_"].text = "0/6"
				arg_18_0["area" .. iter_18_0 .. "2ScoreTxt_"].text = "0/6"
			end
		else
			arg_18_0["pass" .. iter_18_0 .. "Controller"]:SetSelectedState("true")

			if iter_18_0 < 3 then
				arg_18_0["area" .. iter_18_0 .. "1ScoreTxt_"].text = arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].point .. "/6"
				arg_18_0["area" .. iter_18_0 .. "2ScoreTxt_"].text = arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].point .. "/6"
			else
				arg_18_0.highScoreTxt_.text = arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].point
			end

			if arg_18_0.data.difficultList[arg_18_0.difficult][var_18_0].point == 0 then
				arg_18_0["pass" .. iter_18_0 .. "Controller"]:SetSelectedState("false")
			end
		end

		local var_18_2 = BattleAreaBattleCfg[var_18_0].unlock_condition
		local var_18_3 = true

		if var_18_2 ~= "" and #var_18_2 > 0 then
			for iter_18_2 = 1, #var_18_2 do
				local var_18_4 = tonumber(var_18_2[iter_18_2])

				if not IsConditionAchieved(var_18_4) then
					var_18_3 = false

					break
				end
			end
		end

		if not var_18_3 then
			arg_18_0["select" .. iter_18_0 .. "Controller"]:SetSelectedState("lock")
		end
	end
end

function var_0_1.OnEnter(arg_19_0)
	arg_19_0.moveController:SetSelectedState("0")

	if arg_19_0.params_.selectIndex then
		arg_19_0.params_.selectIndex = nil
		arg_19_0.selectIndex = nil
	end

	if arg_19_0.params_.stageID then
		arg_19_0.stageID = arg_19_0.params_.stageID
		arg_19_0.params_.stageID = nil
	end

	arg_19_0:UpdateData()
	arg_19_0:UpdateView()
	arg_19_0:UpdateDefaultText()
	arg_19_0:BindRedPoint()
	RankAction.QueryActivityRank(arg_19_0.rankActivityID)
end

function var_0_1.DifficultFistEnter(arg_20_0)
	if arg_20_0.data.allChallengeValue ~= 0 and getData("areaBattle", "enter" .. arg_20_0.activityID) ~= "1" then
		saveData("areaBattle", "enter" .. arg_20_0.activityID, "1")
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_AREA_BATTLE_AREA_UNLOCK_TIPS"),
			OkCallback = function()
				arg_20_0.difficult = var_0_0.HARD
				arg_20_0.selectIndex = nil

				SetActive(arg_20_0.tipsGo_, false)
				arg_20_0:UpdateView()
			end
		})
	end
end

function var_0_1.OnRankUpdate(arg_22_0)
	local var_22_0 = RankData:GetActivityRank(arg_22_0.rankActivityID)

	if var_22_0 then
		local var_22_1, var_22_2 = var_22_0:GetCurRankDes()

		if var_22_2 == GetTips("MATRIX_RANK_NO_INFO") then
			arg_22_0.rankController:SetSelectedState("false")
		else
			arg_22_0.rankScoreTxt_.text = var_22_2

			arg_22_0.rankController:SetSelectedState("true")
		end
	else
		arg_22_0.rankController:SetSelectedState("false")
	end
end

function var_0_1.UpdateDefaultText(arg_23_0)
	arg_23_0.lowLableTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_EASY_AREA")
	arg_23_0.hardLableTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_HARD_AREA")
	arg_23_0.scoreLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_AREA_SCORE")
	arg_23_0.resetLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_RESETTING")
	arg_23_0.rewardLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_REWARD")
	arg_23_0.rankLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_RANKING_LIST")
	arg_23_0.normal1LabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_GAIN_POINTS")
	arg_23_0.normal2LabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_GAIN_POINTS")
	arg_23_0.hardLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_MAX_SCORE_NON")
	arg_23_0.hardMaxLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_MAX_SCORE")
	arg_23_0.noRecordLabelTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_MAX_SCORE_NON")

	SetActive(arg_23_0.tipsGo_, false)
end

function var_0_1.BindRedPoint(arg_24_0)
	manager.redPoint:bindUIandKey(arg_24_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, arg_24_0.activityID))
end

function var_0_1.UnbindRedPoint(arg_25_0)
	manager.redPoint:unbindUIandKey(arg_25_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, arg_25_0.activityID))
end

function var_0_1.OnExit(arg_26_0)
	arg_26_0.difficult = nil

	manager.windowBar:HideBar()
	arg_26_0:UnbindRedPoint()
end

function var_0_1.OnTop(arg_27_0)
	arg_27_0.isOpen = false

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_AREA_BATTLE_DESCRIBE")
	arg_27_0:UpdateAreaItemView()
	AreaBattleAction.UpdateRewardRedPoint(arg_27_0.params_.mainActivityID)
end

function var_0_1.OnAreaBattleAreaReset(arg_28_0)
	arg_28_0:UpdateData()
	arg_28_0:UpdateView()
	ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_SUCCESS")
end

function var_0_1.Dispose(arg_29_0)
	if arg_29_0.list then
		arg_29_0.list:Dispose()

		arg_29_0.list = nil
	end

	var_0_1.super.Dispose(arg_29_0)
	Object.Destroy(arg_29_0.gameObject_)
end

return var_0_1
