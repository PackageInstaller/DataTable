local AutoChessIllustatedShopItem = class("AutoChessIllustatedShopItem", ReduxView)

function AutoChessIllustatedShopItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform
	self.scrollView_ = arg_1_3

	self:Init()
end

function AutoChessIllustatedShopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessIllustatedShopItem:AddUIListener()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(self, self.PointerClick)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.OnBeginDrag)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.OnEndDrag)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.OnDrag)))
end

function AutoChessIllustatedShopItem:OnBeginDrag(arg_4_1, arg_4_2)
	self.scrollView_:OnBeginDrag(arg_4_2)
end

function AutoChessIllustatedShopItem:OnEndDrag(arg_5_1, arg_5_2)
	self.scrollView_:OnEndDrag(arg_5_2)
end

function AutoChessIllustatedShopItem:OnDrag(arg_6_1, arg_6_2)
	self.scrollView_:OnDrag(arg_6_2)
end

function AutoChessIllustatedShopItem:PointerClick()
	if self:CheckIsLock() then
		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_MAIN then
			ShowTips("AUTO_CHESS_INDEX_LOCKED")

			return
		end

		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
			ShowTips("AUTO_CHESS_2_INDEX_UNLOCK_TIP")

			return
		end
	end

	manager.notify:Invoke(AUTO_CHESS_ILLUSTATED_CLICK, self.id, self.chessType)
end

function AutoChessIllustatedShopItem:InitUI()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.originalGo_)

	self.qualityController = self.shopControllerEx_:GetController("QualityBg")
	self.selectController = self.shopControllerEx_:GetController("illustratedSelect")
	self.illustratedBgController = self.shopControllerEx_:GetController("illustratedBg")
	self.lockController = self.shopControllerEx_:GetController("lock")
	self.moneyController_ = self.shopControllerEx_:GetController("money")
	self.bottomController = self.controllerEx_:GetController("Bottom")

	self.illustratedBgController:SetSelectedState("state1")
	self:UpdateSelectState(false)
end

function AutoChessIllustatedShopItem:RefreshUI(arg_9_1, arg_9_2)
	self.chessType = arg_9_2
	self.id = arg_9_1.id
	self.isLock = arg_9_1.isLock

	if self.chessType == AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP then
		self:RefreshChessUI(self.id)
	elseif self.chessType == AutoChessConst.ILLUSTRATE_TYPE.PROP_SHOP then
		self:RefreshPropUI(self.id)
	end
end

function AutoChessIllustatedShopItem:CheckIsLock()
	local var_10_0 = self.lockController:GetSelectedState()
	local var_10_1 = false

	if var_10_0 == "on" then
		var_10_1 = true
	elseif var_10_0 == "off" then
		var_10_1 = false
	end

	return var_10_1
end

function AutoChessIllustatedShopItem:RefreshChessUI()
	self.bottomController:SetSelectedState("on")
	self.qualityController:SetSelectedIndex(AutoChessCfg[self.id].star - 1)

	self.attactkText_.text = AutoChessCfg[self.id].body[1] or 0
	self.hpText_.text = AutoChessCfg[self.id].body[2] or 0
	self.iconImage_.sprite = AutoChessTools.GetChessBody(self.id)

	if self.isLock then
		self.lockController:SetSelectedState("on")
		self.bottomController:SetSelectedState("off")
	else
		self.lockController:SetSelectedState("off")
	end
end

function AutoChessIllustatedShopItem:RefreshPropUI()
	self.bottomController:SetSelectedState("off")
	self.qualityController:SetSelectedIndex(AutoChessItemCfg[self.id].star - 1)

	self.iconImage_.sprite = AutoChessTools.GetPropIcon(AutoChessItemCfg[self.id].icon)

	if self.isLock then
		self.lockController:SetSelectedState("on")
	else
		self.lockController:SetSelectedState("off")
		self.moneyController_:SetSelectedState("on")

		self.money_.text = AutoChessItemCfg[self.id].shop_price
	end
end

function AutoChessIllustatedShopItem:UpdateSelectState(arg_13_1)
	self.isSelect = arg_13_1

	if arg_13_1 then
		self.selectController:SetSelectedState("state1")
	else
		self.selectController:SetSelectedState("state0")
	end
end

function AutoChessIllustatedShopItem:GetSelectState()
	return self.isSelect
end

function AutoChessIllustatedShopItem:IsMeetIDAndType(arg_15_1, arg_15_2)
	if arg_15_1 == self.id and arg_15_2 == self.chessType then
		return true
	else
		return false
	end
end

function AutoChessIllustatedShopItem:Show(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)
end

function AutoChessIllustatedShopItem:Dispose()
	AutoChessIllustatedShopItem.super.Dispose(self)
end

return AutoChessIllustatedShopItem
