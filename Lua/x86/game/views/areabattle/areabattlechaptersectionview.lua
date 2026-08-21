local var_0_0 = class("AreaBattleChapterSectionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.params_.mainActivityID) .. "NormalfightingChapterSectionInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController = arg_4_0.controller_:GetController("state")
	arg_4_0.head1Controller = arg_4_0.head1Controller_:GetController("show")
	arg_4_0.head2Controller = arg_4_0.head2Controller_:GetController("show")
	arg_4_0.head3Controller = arg_4_0.head3Controller_:GetController("show")
	arg_4_0.reward1Controller = arg_4_0.reward1Controller_:GetController("show")
	arg_4_0.reward2Controller = arg_4_0.reward2Controller_:GetController("show")
	arg_4_0.reward3Controller = arg_4_0.reward3Controller_:GetController("show")

	for iter_4_0 = 1, 6 do
		arg_4_0["condition" .. iter_4_0 .. "Controller"] = arg_4_0["condition" .. iter_4_0 .. "Controller_"]:GetController("default0")
	end

	arg_4_0.proxy = HeroViewDataProxy.New(1)
	arg_4_0.rewardItemList_ = {}

	for iter_4_1 = 1, 3 do
		item = CommonItemView.New(arg_4_0["itemGo_" .. iter_4_1], true)
		arg_4_0.rewardItemList_[iter_4_1] = item
	end
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
	arg_5_0:UpdateBar()
end

function var_0_0.OnAreaBattleAreaRefresh(arg_6_0, arg_6_1)
	arg_6_0.params_.stageID = arg_6_1

	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()
end

function var_0_0.UpdateBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.params_.parent.rewardBtn_.interactable = true
	arg_8_0.params_.parent.isOpen = nil

	arg_8_0.params_.parent.moveController:SetSelectedState("0")

	arg_8_0.params_.selectIndex = nil

	arg_8_0.super.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.startBtn_, nil, function()
		local var_10_0 = ActivityAreaBattleCfg[arg_9_0.activityID]
		local var_10_1 = false

		for iter_10_0, iter_10_1 in pairs(var_10_0.stage_id) do
			if iter_10_1[#iter_10_1] == arg_9_0.stageID then
				var_10_1 = true
			end
		end

		if var_10_1 then
			JumpTools.GoToSystem("/AreaBattleSelectView", {
				stageID = arg_9_0.stageID,
				activityID = arg_9_0.activityID,
				mainActivityID = arg_9_0.mainActivityID,
				difficult = arg_9_0.difficult
			})
		else
			gameContext:Go("/sectionSelectHero", {
				section = arg_9_0.stageID,
				sectionType = BattleConst.STAGE_TYPE_NEW.AREA_BATTLE,
				activityID = arg_9_0.activityID,
				mainActivityID = arg_9_0.mainActivityID,
				difficult = arg_9_0.difficult
			})
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_AREA_BATTLE_RESETTING_CONFIRM_TIP1"),
			OkCallback = function()
				local var_13_0 = {
					arg_9_0.stageID
				}

				if #var_13_0 == 0 then
					ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_FAIL")

					return
				end

				AreaBattleAction.ResetBattleData(arg_9_0.activityID, var_13_0)
			end
		})
	end)
end

function var_0_0.OnAreaBattleAreaReset(arg_14_0)
	arg_14_0:RefreshData()
	arg_14_0:RefreshUI()
end

function var_0_0.RefreshData(arg_15_0)
	arg_15_0.stageID = arg_15_0.params_.stageID or arg_15_0.stageID

	local var_15_0 = BattleAreaBattleCfg[arg_15_0.stageID].drop_lib_id

	if DropCfg[var_15_0] then
		arg_15_0.rewardItemList = DropCfg[var_15_0].base_drop
	else
		arg_15_0.rewardItemList = {}
	end

	arg_15_0.params_.parent.isOpen = true
	arg_15_0.activityID = arg_15_0.params_.activityID
	arg_15_0.mainActivityID = arg_15_0.params_.mainActivityID
	arg_15_0.difficult = arg_15_0.params_.difficult
	arg_15_0.cfg = BattleAreaBattleCfg[arg_15_0.stageID]
	arg_15_0.data = ActivityAreaBattleData:GetDataByActivityID(arg_15_0.mainActivityID)[arg_15_0.activityID]
	arg_15_0.maxPoint = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.data.difficultList[arg_15_0.difficult] or {}) do
		if iter_15_0 ~= arg_15_0.stageID then
			arg_15_0.maxPoint = arg_15_0.maxPoint + iter_15_1.point
		end
	end

	local var_15_1 = 0

	if arg_15_0.data.difficultList[arg_15_0.difficult] and arg_15_0.data.difficultList[arg_15_0.difficult][arg_15_0.stageID] then
		var_15_1 = arg_15_0.data.difficultList[arg_15_0.difficult][arg_15_0.stageID].point
	end

	for iter_15_2 = 1, 6 do
		arg_15_0["condition" .. iter_15_2 .. "Controller"]:SetSelectedState(var_15_1 < iter_15_2 and "state0" or "state1")
	end

	for iter_15_3 = 1, 3 do
		arg_15_0["condition" .. iter_15_3 .. "Txt_"].text = string.format(GetTips("ACTIVITY_AREA_BATTLE_STAGE_CONDITION"), GameSetting.activity_area_battle_point_arg.value[4 - iter_15_3][1])
	end
end

function var_0_0.RefreshUI(arg_16_0)
	for iter_16_0 = 1, 3 do
		arg_16_0["reward" .. iter_16_0 .. "Controller"]:SetSelectedState("false")
	end

	local var_16_0 = ActivityAreaBattleCfg[arg_16_0.activityID]
	local var_16_1 = false

	for iter_16_1, iter_16_2 in pairs(var_16_0.stage_id) do
		if iter_16_2[#iter_16_2] == arg_16_0.stageID then
			var_16_1 = true
		end
	end

	arg_16_0.stateController:SetSelectedState(var_16_1 and "hard" or "normal")

	arg_16_0.params_.parent.rewardBtn_.interactable = false
	arg_16_0.totalTxt_.text = arg_16_0.maxPoint .. "/12"

	SetActive(arg_16_0.noTxt_.gameObject, arg_16_0.data.allChallengeValue == 0)
	SetActive(arg_16_0.highScoreTxt_.gameObject, arg_16_0.data.allChallengeValue ~= 0)

	if arg_16_0.data.difficultList[arg_16_0.difficult] and arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID] then
		arg_16_0.highScoreTxt_.text = arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID].point
	else
		arg_16_0.highScoreTxt_.text = 0
	end

	if arg_16_0.data.difficultList[arg_16_0.difficult] == nil or arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID] == nil then
		for iter_16_3 = 1, 3 do
			arg_16_0["head" .. iter_16_3 .. "Controller"]:SetSelectedState("false")
		end
	else
		for iter_16_4 = 1, 3 do
			if arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID].usedHeroList[iter_16_4] then
				local var_16_2 = arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID].usedHeroList[iter_16_4] % 10000

				if HeroStandardSystemCfg[arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID].usedHeroList[iter_16_4]] then
					arg_16_0["icon" .. iter_16_4 .. "Image_"].sprite = getSpriteViaConfig("HeroLittleIcon", HeroStandardSystemCfg[arg_16_0.data.difficultList[arg_16_0.difficult][arg_16_0.stageID].usedHeroList[iter_16_4]].skin_id)
				else
					arg_16_0["icon" .. iter_16_4 .. "Image_"].sprite = getSpriteViaConfig("HeroLittleIcon", arg_16_0.proxy:GetHeroUsingSkinInfo(var_16_2).id)
				end

				arg_16_0["head" .. iter_16_4 .. "Controller"]:SetSelectedState("true")
			else
				arg_16_0["head" .. iter_16_4 .. "Controller"]:SetSelectedState("false")
			end
		end
	end

	for iter_16_5 = 1, #arg_16_0.rewardItemList do
		arg_16_0["reward" .. iter_16_5 .. "Controller"]:SetSelectedState("true")
	end

	arg_16_0:RefreshTitleDesc()
	arg_16_0:RefreshReward()
end

function var_0_0.RefreshReward(arg_17_0)
	SetActive(arg_17_0.firstGo_, #arg_17_0.rewardItemList > 0)

	local var_17_0 = ActivityAreaBattleData:GetStageIdList()

	for iter_17_0 = 1, #arg_17_0.rewardItemList do
		local var_17_1 = arg_17_0.rewardItemList[iter_17_0]
		local var_17_2 = clone(ItemTemplateData)

		var_17_2.id = var_17_1[1]
		var_17_2.number = var_17_1[2]

		for iter_17_1, iter_17_2 in pairs(var_17_0) do
			if iter_17_1 == arg_17_0.stageID then
				var_17_2.completedFlag = true

				break
			end

			var_17_2.completedFlag = false
		end

		function var_17_2.clickFun(arg_18_0)
			ShowPopItemOnly(POP_OTHER_ITEM, {
				arg_18_0.id,
				arg_18_0.number
			})
		end

		arg_17_0.rewardItemList_[iter_17_0]:SetData(var_17_2)
	end
end

function var_0_0.RefreshTitleDesc(arg_19_0)
	arg_19_0.nameTxt_.text = arg_19_0.cfg.name
	arg_19_0.bgIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleAreaBattleCfg[arg_19_0.stageID].background_1))
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.rewardItemList_) do
		iter_20_1:Dispose()
	end

	arg_20_0.rewardItemList_ = nil
end

return var_0_0
