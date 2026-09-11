local AutoChessShopItem = class("AutoChessShopItem", AutoChessItem)

function AutoChessShopItem:InitUI()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.originalGo_)
	self:InitController()
	self:InitBuffKeywordConfig()
end

function AutoChessShopItem:InitController()
	AutoChessShopItem.super.InitController(self)

	self.lockController_ = self.shopControllerEx_:GetController("lock")
	self.bgController_ = self.shopControllerEx_:GetController("QualityBg")
	self.dragController_ = self.shopControllerEx_:GetController("Drag")
	self.bottomController_ = self.controllerEx_:GetController("Bottom")
	self.bgController_ = self.shopControllerEx_:GetController("QualityBg")
	self.lvupController_ = self.shopControllerEx_:GetController("lvlup")
	self.moneyController_ = self.shopControllerEx_:GetController("money")
	self.deleteController_ = self.shopControllerEx_:GetController("Delete")
	self.levelController_ = self.shopControllerEx_:GetController("level")
end

function AutoChessShopItem:SetData(arg_3_1)
	self.super.SetData(self, arg_3_1)

	if not self.chessItemData_ or not self.chessItemData_.uniqueId then
		self.bgController_:SetSelectedState("off")
		self:SetActive(false)
	else
		self.atkChangeController_:SetSelectedState("none")
		self.hpChangeController_:SetSelectedState("none")
		self.levelController_:SetSelectedIndex(self.chessItemData_.attributeData.level - 1)
		self:SetActive(true)
		self:UpdateLevel()
		self:UpdateMoney()
		self.lockController_:SetSelectedState(self.chessItemData_.isLock == 0 and "off" or "on")
		self.dragController_:SetSelectedState("off")
	end
end

function AutoChessShopItem:UpdateLock()
	if self.chessItemData_ then
		if self.chessItemData_.isLock == 0 then
			self.lockController_:SetSelectedState("off")
			self.unlockAnim_:Play("ComCardItem_unlock", 0, 0)
		else
			self.lockController_:SetSelectedState("on")
			self.lockAnim_:Play("ComCardItem_lock", 0, 0)
		end
	end
end

function AutoChessShopItem:Refresh()
	if self.chessItemData_ and self.chessItemData_.isLock == 0 then
		self.refreshAnim_:Play("Refresh", 0, 0)
	end
end

function AutoChessShopItem:UpdateMoney()
	if self.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
		self.moneyController_:SetSelectedState("on")

		self.money_.text = AutoChessTools.GetAttrValue(self.gameType_, AutoChessConst.ATTR_KEY.SHOP_FREE_PROP_COUNT) > 0 and 0 or self.chessCfg_.shop_price
	else
		self.moneyController_:SetSelectedState("off")
	end
end

function AutoChessShopItem:UpdateLevel()
	self.bgController_:SetSelectedIndex(self.chessCfg_.star - 1)
end

function AutoChessShopItem:UpdateLvUp(arg_8_1)
	if arg_8_1 then
		self.lvupController_:SetSelectedState("on")
	else
		self.lvupController_:SetSelectedState("off")
	end
end

function AutoChessShopItem:UpdateAttribute()
	self.bottomController_:SetSelectedState(self.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP and "off" or "on")
end

function AutoChessShopItem:BeginDrag(arg_10_1)
	if AutoChessData:GetIsInBuyChess() then
		return
	end

	if not self.chessItemData_ or not self.chessItemData_.uniqueId then
		return
	end

	if self.chessItemData_.shopType ~= AutoChessConst.SHOP_TYPE.REWARD and not AutoChessTools.GetNowMoneyEnough(self.gameType_, self.chessCfg_.shop_price) then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

		return
	end

	self.dragController_:SetSelectedState("on")

	if self.beginDragFunc then
		self.beginDragFunc(self.chessItemData_)
	end
end

function AutoChessShopItem:EndDrag(arg_11_1)
	if not self.chessItemData_ or not self.chessItemData_.uniqueId then
		return
	end

	self.dragController_:SetSelectedState("off")

	if self.endDragFunc then
		self.endDragFunc()
	end
end

function AutoChessShopItem:SetSelect(arg_12_1)
	if arg_12_1 then
		self.dragController_:SetSelectedState("on")
	else
		self.dragController_:SetSelectedState("off")
	end
end

function AutoChessShopItem:SetDeleteState(arg_13_1, arg_13_2)
	if (self.chessItemData_ and self.chessItemData_.index == arg_13_1 or nil) and not arg_13_2 then
		self.deleteController_:SetSelectedState("on")
	else
		self.deleteController_:SetSelectedState("off")
	end
end

function AutoChessShopItem:UpdateExpChange()
	self.levelController_:SetSelectedIndex(self.chessItemData_.attributeData.level - 1)
end

function AutoChessShopItem:PlayGetEffectAnim(arg_15_1)
	if AutoChessBuffCfg[arg_15_1] then
		if AutoChessBuffCfg[arg_15_1].action_type == AutoChessConst.ACTION_EFFECT_TYPE.REFRESH_SHOP then
			self.refreshAnim_:Play("Ani_takeseffect", -1, 0)
			self.refreshAnim_:Update(0)
		else
			self.upLevelAnim_:Play("attackAni_buff", -1, 0)
			self.upLevelAnim_:Update(0)
		end
	end
end

function AutoChessShopItem:ResetUI()
	return
end

return AutoChessShopItem
