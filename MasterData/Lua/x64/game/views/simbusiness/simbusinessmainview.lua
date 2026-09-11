local SimBusinessMainView = class("SimBusinessMainView", ReduxView)

function SimBusinessMainView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessMainUI"
end

function SimBusinessMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SimBusinessMainView:OnCtor()
	self.inGameGuestItem = {}
end

function SimBusinessMainView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.clientInfoPage = SimBusinessClientPage.New(self.clientGo)
	self.clientInfoShowController = self.controller:GetController("showClient")
	self.shopLevelController = self.controller:GetController("shopTop")
	self.gameStateController = self.controller:GetController("gameState")
	self.clientList = LuaList.New(handler(self, self.indexClientItem), self.uilistGo_, SimBusinessGuestInfoItem)
	self.logPanelDisplayController = self.logPanelControllers_:GetController("state")
end

function SimBusinessMainView:AddUIListener()
	self:AddBtnListenerScale(self.editBtn_, nil, function()
		self:SetClearObstacleTipsVisible(true)
		self:SetShelfGoodsBubbleVisible(false)
		JumpTools.OpenPageByJump("/activitySummerSimBusinessDeploy")
	end)
	self:AddBtnListenerScale(self.customerInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("simBusinessExplainView")
	end)
	self:AddBtnListenerScale(self.infoBtn_, nil, function()
		SimBusinessTools.SetStageRedPoint(self.stageID, false)
		SimBusinessTools.MarkSpecialStageRedPointNeverShowAgain(self.stageID)
		JumpTools.OpenPageByJump("simBusinessChooseStageView", {
			stageID = self.stageID
		})
	end)
	self:AddBtnListenerScale(self.sellBtn_, nil, function()
		JumpTools.OpenPageByJump("simBusinessSpecialStageView")
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		if self.clientInfoShowController:GetSelectedState() == "true" then
			self.clientInfoShowController:SetSelectedState("false")

			self.selectClientID = nil

			self.clientList:Refresh()
		end
	end)
	self:AddBtnListenerScale(self.switchSpeedBtn_, nil, function()
		SimBusinessGame.GetInstance():SwitchGameGlobalSpeed()
		self:RefreshSwitchSpeedBtn()
	end)
	self:AddBtnListenerScale(self.logBtn_, nil, function()
		self.logPanelDisplayController:SetSelectedState(self.logPanelDisplayController:GetSelectedState() ~= "fold" and "fold" or "unfold")
	end)
end

function SimBusinessMainView:OnEnter()
	self.gameStateController:SetSelectedState("prepare")
	self:RegisterEvents()
	self:RefreshView()
	self:BindRedPoint()
	self:SetClearObstacleTipsVisible(false)
	SimBusinessData:CleanupEditCache()
end

function SimBusinessMainView:OnUpdate()
	self:RefreshView()
end

function SimBusinessMainView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:UnBindRedPoint()
	self:RemoveAllEventListener()
end

function SimBusinessMainView:BindRedPoint()
	if SimBusinessTools.IsDailyLevel(self.stageID) then
		manager.redPoint:bindUIandKey(self.infoBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_NORMAL_STAGE)
		manager.redPoint:bindUIandKey(self.sellBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_SPECIAL_STAGE)
	else
		manager.redPoint:bindUIandKey(self.infoBtn_.transform, SimBusinessTools.GetSpStageRedPoint(self.stageID))
	end

	manager.redPoint:bindUIandKey(self.customerInfoBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_EXPLAN)
end

function SimBusinessMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.infoBtn_.transform)
	manager.redPoint:unbindUIandKey(self.sellBtn_.transform)
	manager.redPoint:unbindUIandKey(self.customerInfoBtn_.transform, RedPointConst.ACTIVITY_SIM_BUSINESS_EXPLAN)
end

function SimBusinessMainView:OnTop()
	self:SetWindowBar()
	self:RefreshShopLevel()
	self:SetShelfGoodsBubbleVisible(true)
	self:RefreshShelfSellAbilityPreview()

	if ActivityTools.IsFirstEnterActivity(SimBusinessData.activityID) then
		ActivityTools.MarkHasEnterActivity(SimBusinessData.activityID)
		manager.windowBar:ShowGameHelp()
	end
end

function SimBusinessMainView:OnBehind()
	manager.windowBar:HideBar()
end

function SimBusinessMainView:SetWindowBar()
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

function SimBusinessMainView:OnSimBusinessGameStart()
	self.gameStateController:SetSelectedState("game")
	self:RefreshInGameGuestInfo()
	self:ClearGuestBuyLog()
	self:RefreshSwitchSpeedBtn()
	manager.windowBar:SwitchBar({
		BACK_BAR
	}, true)
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SIM_BUSINESS_ASK_ABORT_GAME"),
			OkCallback = function()
				SimBusinessGame.GetInstance():EndGame(false)
				self.gameStateController:SetSelectedState("prepare")
			end
		})
	end)
end

function SimBusinessMainView:OnSimBusinessStageChanged()
	self:RefreshView()
end

function SimBusinessMainView:RegisterEvents()
	self:RegistEventListener("ON_FURNITURE_CLICKED", function(arg_26_0)
		if self.gameStateController:GetSelectedState() == "game" then
			return
		end

		JumpTools.OpenPageByJump("/activitySummerSimBusinessSetGoods", {
			eid = arg_26_0
		})
	end)
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == SimBusinessCfg[SimBusinessData.activityID].exp_id then
			self:RefreshShopLevel()
		end
	end)
	self:RegistEventListener("SIM_BUSINESS_GUEST_SPAWN", handler(self, self.OnGuestEnter))
	self:RegistEventListener("SIM_BUSINESS_GUEST_EXIT", handler(self, self.OnGuestExit))
	self:RegistEventListener("SIM_BUSINESS_GUEST_HP_CHANGE", handler(self, self.OnGuestBuy))
	self:RegistEventListener("SIM_BUSINESS_SET_GOODS", handler(self, self.RefreshShelfSellAbilityPreview))
end

function SimBusinessMainView:RefreshView()
	self.stageID = SimBusinessGame.GetInstance().stage
	self.satgeType = SimBusinessStageCfg[self.stageID].type

	self.clientInfoShowController:SetSelectedState("false")
	self:RefreshStageInfo()
	self:RefreshShopLevel()
end

function SimBusinessMainView:RefreshStageInfo()
	self:RefreshClientList()
end

function SimBusinessMainView:RefreshClientList()
	if self.stageID then
		local var_30_0 = SimBusinessGame.GetInstance().genCustomerInfo

		self.clientInfoList = var_30_0

		self.clientList:StartScroll(#var_30_0)
	end
end

function SimBusinessMainView:RefreshSwitchSpeedBtn()
	local var_31_0 = Time.timeScale

	self.switchSpeedIcon_.sprite = Time.timeScale == 1 and getSprite("Atlas/SummerUI_3_5Atlas", "SummerUI3_5_00979") or getSprite("Atlas/SummerUI_3_5Atlas", "SummerUI3_5_00980")
	self.switchSpeedLable_.text = GetTipsF("SIM_BUSINESS_GAME_SPEED", var_31_0)
end

function SimBusinessMainView:indexClientItem(arg_32_1, arg_32_2)
	local var_32_0 = SimBusinessGame.GetInstance().genCustomerInfo[arg_32_1]
	local var_32_1 = var_32_0.id

	arg_32_2:RefreshData(var_32_0, arg_32_1, var_32_0.id == self.selectClientID, true)
	arg_32_2:RegisterClickFunc(handler(self, self.ClientClickFunc))

	if SimBusinessTools.CheckIsStageNewGuest(var_32_1) then
		arg_32_2:SetNewRedpoint(true)
	else
		arg_32_2:SetNewRedpoint(false)
	end
end

function SimBusinessMainView:ClientClickFunc(arg_33_1)
	self.clientInfoShowController:SetSelectedState("true")

	self.selectClientID = arg_33_1.guestID

	SimBusinessTools.MarkGuestShown(arg_33_1.guestID)
	arg_33_1:SetNewRedpoint(false)
	self.clientList:Refresh()
	self.clientInfoPage:RefreshView(self.selectClientID, self.clientInfoList[arg_33_1.index].remain)
end

function SimBusinessMainView:RefreshShopLevel()
	if self.satgeType == 0 then
		self.levelName_.text = SimBusinessStageCfg[self.stageID].name

		self.shopLevelController:SetSelectedState("exp")
	elseif self.satgeType == 1 then
		self.shopLevelController:SetSelectedState("category")
	end
end

function SimBusinessMainView:Dispose()
	self.clientList:Dispose()
	self.clientInfoPage:Dispose()

	for iter_37_0, iter_37_1 in ipairs(self.inGameGuestItem) do
		iter_37_1:Dispose()
	end

	SimBusinessMainView.super.Dispose(self)
end

function SimBusinessMainView:SetClearObstacleTipsVisible(arg_38_1)
	local var_38_0 = SimBusinessData:GetSimBusinessLevel()

	for iter_38_0 = 1, SimBusinessData:GetSimBusinessMaxLevel() - 1 do
		SimBusinessBridge:LevelObstacleTipsSetVisible(iter_38_0, arg_38_1 and var_38_0 <= iter_38_0)
	end
end

function SimBusinessMainView:SetShelfGoodsBubbleVisible(arg_39_1)
	for iter_39_0, iter_39_1 in SimBusinessGame.EnumerateShelves() do
		local var_39_0 = SimBusinessBridge.bubbleView:GetBubble(iter_39_1)

		if var_39_0 then
			var_39_0:SetData(iter_39_1)
			var_39_0:SetActive(arg_39_1)
		end
	end
end

function SimBusinessMainView:ClearGuestBuyLog()
	self.logText_.text = ""
end

function SimBusinessMainView:AppendGuestBuyLog(arg_41_1)
	self.logText_.text = self.logText_.text ~= "" and self.logText_.text .. "\n\n" .. arg_41_1 or arg_41_1

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.logScroll_.transform)

	self.logScroll_.verticalNormalizedPosition = 0
end

function SimBusinessMainView:OnGuestEnter(arg_44_1)
	local var_44_0 = DormUtils.GetEntityData(arg_44_1)

	if SimBusinessGuestCfg[var_44_0.cfgID] then
		self:AppendGuestBuyLog((GetTipsF("SIM_BUSINESS_GUEST_SPAWN_LOG", SimBusinessGuestCfg[var_44_0.cfgID].name, GetTips(SimBusinessConst.GoodTypeDesc[SimBusinessGuestCfg[var_44_0.cfgID].love_type]), var_44_0.hp)))
	end
end

function SimBusinessMainView:OnGuestExit(arg_45_1)
	local var_45_0 = DormUtils.GetEntityData(arg_45_1)

	if SimBusinessGuestCfg[var_45_0.cfgID] and var_45_0.hp == var_45_0.max then
		self:AppendGuestBuyLog((GetTipsF("SIM_BUSINESS_GUEST_BUY_NOTHING_EXIT_LOG", SimBusinessGuestCfg[var_45_0.cfgID].name, (GetTips(SimBusinessConst.GoodTypeDesc[SimBusinessGuestCfg[var_45_0.cfgID].love_type])))))
	end
end

function SimBusinessMainView:OnGuestBuy(arg_46_1, arg_46_2)
	local var_46_0 = DormUtils.GetEntityData(arg_46_1)

	if SimBusinessGuestCfg[var_46_0.cfgID] then
		self:AppendGuestBuyLog(var_46_0.hp > 0 and GetTipsF("SIM_BUSINESS_GUEST_BUY_LOG", SimBusinessGuestCfg[var_46_0.cfgID].name, SimBusinessGoodsCfg[arg_46_2.goods].name, arg_46_2.buyCount, var_46_0.hp) or GetTipsF("SIM_BUSINESS_GUEST_COMPLETE_LOG", SimBusinessGuestCfg[var_46_0.cfgID].name, SimBusinessGoodsCfg[arg_46_2.goods].name, arg_46_2.buyCount))
	end
end

local var_0_4 = "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/GuestHeadItem"

function SimBusinessMainView:RefreshInGameGuestInfo()
	for iter_47_0 = #self.inGameGuestItem + 1, #self.clientInfoList do
		local var_47_0 = Asset.Instantiate(var_0_4)

		var_47_0.transform:SetParent(self.inGameGuestInfoRoot_.transform)

		var_47_0.transform.localPosition = Vector3.zero
		var_47_0.transform.localScale = Vector3.one
		self.inGameGuestItem[iter_47_0] = SimBusinessGuestInfoItem.New(var_47_0)
	end

	for iter_47_1 = 1, #self.clientInfoList do
		self:indexClientItem(iter_47_1, self.inGameGuestItem[iter_47_1])
		self.inGameGuestItem[iter_47_1]:SetSelected(false)
	end

	for iter_47_2 = #self.clientInfoList + 1, #self.inGameGuestItem do
		self.inGameGuestItem[iter_47_2]:Dispose()
		GameObject.Destroy(self.inGameGuestItem[iter_47_2].gameObject_)

		self.inGameGuestItem[iter_47_2] = nil
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.inGameGuestInfoRoot_.transform)
end

function SimBusinessMainView:RefreshShelfSellAbilityPreview()
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
		self["sellAbilityPreview" .. iter_48_2 .. "_"].text = var_48_0[iter_48_2] or 0
	end
end

return SimBusinessMainView
