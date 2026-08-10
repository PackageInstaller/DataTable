local var_0_0 = class("SimBusinessMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.inGameGuestItem = {}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.clientInfoPage = SimBusinessClientPage.New(arg_4_0.clientGo)
	arg_4_0.clientInfoShowController = arg_4_0.controller:GetController("showClient")
	arg_4_0.shopLevelController = arg_4_0.controller:GetController("shopTop")
	arg_4_0.gameStateController = arg_4_0.controller:GetController("gameState")
	arg_4_0.clientList = LuaList.New(handler(arg_4_0, arg_4_0.indexClientItem), arg_4_0.uilistGo_, SimBusinessGuestInfoItem)
	arg_4_0.logPanelDisplayController = arg_4_0.logPanelControllers_:GetController("state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.editBtn_, nil, function()
		arg_5_0:SetClearObstacleTipsVisible(true)
		arg_5_0:SetShelfGoodsBubbleVisible(false)
		JumpTools.OpenPageByJump("/activitySummerSimBusinessDeploy")
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.customerInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("simBusinessExplainView")
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.infoBtn_, nil, function()
		SimBusinessTools.SetStageRedPoint(arg_5_0.stageID, false)
		SimBusinessTools.MarkSpecialStageRedPointNeverShowAgain(arg_5_0.stageID)
		JumpTools.OpenPageByJump("simBusinessChooseStageView", {
			stageID = arg_5_0.stageID
		})
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.sellBtn_, nil, function()
		JumpTools.OpenPageByJump("simBusinessSpecialStageView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		if arg_5_0.clientInfoShowController:GetSelectedState() == "true" then
			arg_5_0.clientInfoShowController:SetSelectedState("false")

			arg_5_0.selectClientID = nil

			arg_5_0.clientList:Refresh()
		end
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.switchSpeedBtn_, nil, function()
		SimBusinessGame.GetInstance():SwitchGameGlobalSpeed()
		arg_5_0:RefreshSwitchSpeedBtn()
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.logBtn_, nil, function()
		local var_12_0 = arg_5_0.logPanelDisplayController:GetSelectedState()

		arg_5_0.logPanelDisplayController:SetSelectedState(var_12_0 ~= "fold" and "fold" or "unfold")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.gameStateController:SetSelectedState("prepare")
	arg_13_0:RegisterEvents()
	arg_13_0:RefreshView()
	arg_13_0:BindRedPoint()
	arg_13_0:SetClearObstacleTipsVisible(false)
	SimBusinessData:CleanupEditCache()
end

function var_0_0.OnUpdate(arg_14_0)
	arg_14_0:RefreshView()
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:RemoveAllEventListener()
	arg_15_0:UnBindRedPoint()
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.BindRedPoint(arg_16_0)
	if SimBusinessTools.IsDailyLevel(arg_16_0.stageID) then
		manager.redPoint:bindUIandKey(arg_16_0.infoBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_NORMAL_STAGE)
		manager.redPoint:bindUIandKey(arg_16_0.sellBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_SPECIAL_STAGE)
	else
		manager.redPoint:bindUIandKey(arg_16_0.infoBtn_.transform, SimBusinessTools.GetSpStageRedPoint(arg_16_0.stageID))
	end

	manager.redPoint:bindUIandKey(arg_16_0.customerInfoBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_EXPLAN)
end

function var_0_0.UnBindRedPoint(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.infoBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_17_0.sellBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_17_0.customerInfoBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_EXPLAN)
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0:SetWindowBar()
	arg_18_0:RefreshShopLevel()
	arg_18_0:SetShelfGoodsBubbleVisible(true)
	arg_18_0:RefreshShelfSellAbilityPreview()

	if ActivityTools.IsFirstEnterActivity(SimBusinessData.activityID) then
		ActivityTools.MarkHasEnterActivity(SimBusinessData.activityID)
		manager.windowBar:ShowGameHelp()
	end
end

function var_0_0.OnBehind(arg_19_0)
	manager.windowBar:HideBar()
end

function var_0_0.SetWindowBar(arg_20_0)
	SimBusinessTools.SwitchBarWithFund({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(SimBusinessBridge.Back)
	manager.windowBar:SetGameHelpKey({
		view = "/gameHelpPro",
		type = "jump",
		params = {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = {
				"Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessDescription_1",
				"Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessDescription_2"
			}
		}
	})
end

function var_0_0.OnSimBusinessGameStart(arg_21_0)
	arg_21_0.gameStateController:SetSelectedState("game")
	arg_21_0:RefreshInGameGuestInfo()
	arg_21_0:ClearGuestBuyLog()
	arg_21_0:RefreshSwitchSpeedBtn()
	manager.windowBar:SwitchBar({
		BACK_BAR
	}, true)
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SIM_BUSINESS_ASK_ABORT_GAME"),
			OkCallback = function()
				SimBusinessGame.GetInstance():EndGame(false)
				arg_21_0.gameStateController:SetSelectedState("prepare")
			end
		})
	end)
end

function var_0_0.OnSimBusinessStageChanged(arg_24_0)
	arg_24_0:RefreshView()
end

function var_0_0.RegisterEvents(arg_25_0)
	arg_25_0:RegistEventListener("ON_FURNITURE_CLICKED", function(arg_26_0)
		if arg_25_0.gameStateController:GetSelectedState() == "game" then
			return
		end

		JumpTools.OpenPageByJump("/activitySummerSimBusinessSetGoods", {
			eid = arg_26_0
		})
	end)
	arg_25_0:RegistEventListener(CURRENCY_UPDATE, function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == SimBusinessCfg[SimBusinessData.activityID].exp_id then
			arg_25_0:RefreshShopLevel()
		end
	end)
	arg_25_0:RegistEventListener("SIM_BUSINESS_GUEST_SPAWN", handler(arg_25_0, arg_25_0.OnGuestEnter))
	arg_25_0:RegistEventListener("SIM_BUSINESS_GUEST_EXIT", handler(arg_25_0, arg_25_0.OnGuestExit))
	arg_25_0:RegistEventListener("SIM_BUSINESS_GUEST_HP_CHANGE", handler(arg_25_0, arg_25_0.OnGuestBuy))
	arg_25_0:RegistEventListener("SIM_BUSINESS_SET_GOODS", handler(arg_25_0, arg_25_0.RefreshShelfSellAbilityPreview))
end

function var_0_0.RefreshView(arg_28_0)
	arg_28_0.stageID = SimBusinessGame.GetInstance().stage
	arg_28_0.satgeType = SimBusinessStageCfg[arg_28_0.stageID].type

	arg_28_0.clientInfoShowController:SetSelectedState("false")
	arg_28_0:RefreshStageInfo()
	arg_28_0:RefreshShopLevel()
end

function var_0_0.RefreshStageInfo(arg_29_0)
	arg_29_0:RefreshClientList()
end

function var_0_0.RefreshClientList(arg_30_0)
	if arg_30_0.stageID then
		local var_30_0 = SimBusinessGame.GetInstance().genCustomerInfo

		arg_30_0.clientInfoList = var_30_0

		arg_30_0.clientList:StartScroll(#var_30_0)
	end
end

function var_0_0.RefreshSwitchSpeedBtn(arg_31_0)
	local var_31_0 = Time.timeScale

	if var_31_0 == 1 then
		arg_31_0.switchSpeedIcon_.sprite = getSprite("Atlas/SummerUI_3_5Atlas", "SummerUI3_5_00979")
	else
		arg_31_0.switchSpeedIcon_.sprite = getSprite("Atlas/SummerUI_3_5Atlas", "SummerUI3_5_00980")
	end

	arg_31_0.switchSpeedLable_.text = GetTipsF("SIM_BUSINESS_GAME_SPEED", var_31_0)
end

function var_0_0.indexClientItem(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = SimBusinessGame.GetInstance().genCustomerInfo[arg_32_1]
	local var_32_1 = var_32_0.id

	arg_32_2:RefreshData(var_32_0, arg_32_1, var_32_1 == arg_32_0.selectClientID, true)
	arg_32_2:RegisterClickFunc(handler(arg_32_0, arg_32_0.ClientClickFunc))

	if SimBusinessTools.CheckIsStageNewGuest(var_32_1) then
		arg_32_2:SetNewRedpoint(true)
	else
		arg_32_2:SetNewRedpoint(false)
	end
end

function var_0_0.ClientClickFunc(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.guestID
	local var_33_1 = arg_33_1.index

	arg_33_0.clientInfoShowController:SetSelectedState("true")

	arg_33_0.selectClientID = var_33_0

	SimBusinessTools.MarkGuestShown(var_33_0)
	arg_33_1:SetNewRedpoint(false)
	arg_33_0.clientList:Refresh()
	arg_33_0.clientInfoPage:RefreshView(arg_33_0.selectClientID, arg_33_0.clientInfoList[var_33_1].remain)
end

local function var_0_1(arg_34_0, arg_34_1)
	return arg_34_0 / arg_34_1 * 0.8 + 0.1
end

local function var_0_2(arg_35_0)
	local var_35_0 = 0

	while var_35_0 <= 0 do
		var_35_0 = var_35_0 + SimBusinessData:GetLevelUpNeedExp(arg_35_0)
		arg_35_0 = arg_35_0 + 1
	end

	return var_35_0
end

function var_0_0.RefreshShopLevel(arg_36_0)
	if arg_36_0.satgeType == 0 then
		arg_36_0.levelName_.text = SimBusinessStageCfg[arg_36_0.stageID].name

		arg_36_0.shopLevelController:SetSelectedState("exp")
	elseif arg_36_0.satgeType == 1 then
		arg_36_0.shopLevelController:SetSelectedState("category")
	end
end

function var_0_0.Dispose(arg_37_0)
	arg_37_0.clientList:Dispose()
	arg_37_0.clientInfoPage:Dispose()

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.inGameGuestItem) do
		iter_37_1:Dispose()
	end

	var_0_0.super.Dispose(arg_37_0)
end

function var_0_0.SetClearObstacleTipsVisible(arg_38_0, arg_38_1)
	local var_38_0 = SimBusinessData:GetSimBusinessLevel()
	local var_38_1 = SimBusinessData:GetSimBusinessMaxLevel()

	for iter_38_0 = 1, var_38_1 - 1 do
		local var_38_2 = var_38_0 <= iter_38_0

		SimBusinessBridge:LevelObstacleTipsSetVisible(iter_38_0, arg_38_1 and var_38_2)
	end
end

function var_0_0.SetShelfGoodsBubbleVisible(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in SimBusinessGame.EnumerateShelves() do
		local var_39_0 = SimBusinessBridge.bubbleView:GetBubble(iter_39_1)

		if var_39_0 then
			var_39_0:SetData(iter_39_1)
			var_39_0:SetActive(arg_39_1)
		end
	end
end

function var_0_0.ClearGuestBuyLog(arg_40_0)
	arg_40_0.logText_.text = ""
end

function var_0_0.AppendGuestBuyLog(arg_41_0, arg_41_1)
	if arg_41_0.logText_.text ~= "" then
		arg_41_0.logText_.text = arg_41_0.logText_.text .. "\n\n" .. arg_41_1
	else
		arg_41_0.logText_.text = arg_41_1
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_0.logScroll_.transform)

	arg_41_0.logScroll_.verticalNormalizedPosition = 0
end

local function var_0_3(arg_42_0)
	local var_42_0 = SimBusinessTools.SelectAvailableGoodsList(arg_42_0, function(arg_43_0)
		return SimBusinessGoodsCfg[arg_43_0].name
	end)

	return table.concat(var_42_0, ", ")
end

function var_0_0.OnGuestEnter(arg_44_0, arg_44_1)
	local var_44_0 = DormUtils.GetEntityData(arg_44_1)
	local var_44_1 = SimBusinessGuestCfg[var_44_0.cfgID]

	if var_44_1 then
		local var_44_2 = GetTips(SimBusinessConst.GoodTypeDesc[var_44_1.love_type])
		local var_44_3 = GetTipsF("SIM_BUSINESS_GUEST_SPAWN_LOG", var_44_1.name, var_44_2, var_44_0.hp)

		arg_44_0:AppendGuestBuyLog(var_44_3)
	end
end

function var_0_0.OnGuestExit(arg_45_0, arg_45_1)
	local var_45_0 = DormUtils.GetEntityData(arg_45_1)
	local var_45_1 = SimBusinessGuestCfg[var_45_0.cfgID]

	if var_45_1 and var_45_0.hp == var_45_0.max then
		local var_45_2 = GetTips(SimBusinessConst.GoodTypeDesc[var_45_1.love_type])
		local var_45_3 = GetTipsF("SIM_BUSINESS_GUEST_BUY_NOTHING_EXIT_LOG", var_45_1.name, var_45_2)

		arg_45_0:AppendGuestBuyLog(var_45_3)
	end
end

function var_0_0.OnGuestBuy(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = DormUtils.GetEntityData(arg_46_1)
	local var_46_1 = SimBusinessGuestCfg[var_46_0.cfgID]

	if var_46_1 then
		local var_46_2
		local var_46_3 = SimBusinessGoodsCfg[arg_46_2.goods].name

		if var_46_0.hp > 0 then
			var_46_2 = GetTipsF("SIM_BUSINESS_GUEST_BUY_LOG", var_46_1.name, var_46_3, arg_46_2.buyCount, var_46_0.hp)
		else
			var_46_2 = GetTipsF("SIM_BUSINESS_GUEST_COMPLETE_LOG", var_46_1.name, var_46_3, arg_46_2.buyCount)
		end

		arg_46_0:AppendGuestBuyLog(var_46_2)
	end
end

local var_0_4 = "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/GuestHeadItem"

function var_0_0.RefreshInGameGuestInfo(arg_47_0)
	local var_47_0 = arg_47_0.clientInfoList
	local var_47_1 = #arg_47_0.inGameGuestItem

	for iter_47_0 = var_47_1 + 1, #var_47_0 do
		local var_47_2 = Asset.Instantiate(var_0_4)

		var_47_2.transform:SetParent(arg_47_0.inGameGuestInfoRoot_.transform)

		var_47_2.transform.localPosition = Vector3.zero
		var_47_2.transform.localScale = Vector3.one
		arg_47_0.inGameGuestItem[iter_47_0] = SimBusinessGuestInfoItem.New(var_47_2)
	end

	for iter_47_1 = 1, #var_47_0 do
		arg_47_0:indexClientItem(iter_47_1, arg_47_0.inGameGuestItem[iter_47_1])
		arg_47_0.inGameGuestItem[iter_47_1]:SetSelected(false)
	end

	for iter_47_2 = #var_47_0 + 1, var_47_1 do
		local var_47_3 = arg_47_0.inGameGuestItem[iter_47_2].gameObject_

		arg_47_0.inGameGuestItem[iter_47_2]:Dispose()
		GameObject.Destroy(var_47_3)

		arg_47_0.inGameGuestItem[iter_47_2] = nil
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_0.inGameGuestInfoRoot_.transform)
end

function var_0_0.RefreshShelfSellAbilityPreview(arg_48_0)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in SimBusinessGame.EnumerateShelves() do
		local var_48_1 = DormUtils.GetEntityData(iter_48_1)
		local var_48_2 = nullable(SimBusinessGoodsCfg, var_48_1.goods, "type")

		if var_48_2 then
			local var_48_3, var_48_4 = SimBusinessTools.GetShelfSellAbility(var_48_1.cfgID, var_48_1.goods)

			var_48_0[var_48_2] = (var_48_0[var_48_2] or 0) + var_48_3 + var_48_4
		end
	end

	for iter_48_2 = 1, 4 do
		arg_48_0["sellAbilityPreview" .. iter_48_2 .. "_"].text = var_48_0[iter_48_2] or 0
	end
end

return var_0_0
