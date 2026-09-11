local SailShopItem = class("SailShopItem", ReduxView)

function SailShopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SailShopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailShopItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function SailShopItem:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SailGameAction.EventOperate(self.activityID_, SailGameData:GetCurGameData(self.activityID_).curStageIndex, self.index_)
	end)
end

function SailShopItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	SailShopItem.super.Dispose(self)
end

function SailShopItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.activityID_ = arg_7_1
	self.goodData_ = arg_7_2
	self.index_ = arg_7_3

	self:RefreshUI()
	self:UpdateStatus()
end

function SailShopItem:UpdateStatus()
	if self.goodData_.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT then
		self.statusController_:SetSelectedState("soldOut")
	elseif ItemTools.getItemNum(self.goodData_.costID) < self.goodData_.costNum then
		self.statusController_:SetSelectedState("off")
	else
		self.statusController_:SetSelectedState("normal")
	end
end

function SailShopItem:RefreshUI()
	if not self.commonItem_ then
		self.commonItem_ = CommonItem.New(self.commonItemGo_)

		self.commonItem_:RegistCallBack(function()
			if self.clickCallback_ then
				if self.clickCallback_() then
					ShowPopItem(POP_ITEM, self.costCfg_)
				end
			else
				ShowPopItem(POP_ITEM, self.costCfg_)
			end
		end)
	end

	self.costCfg_ = {
		self.goodData_.costID,
		self.goodData_.costNum
	}

	self.commonItem_:RefreshData(formatReward(self.costCfg_))
	self.commonItem_:SetBottomText(string.format("%s/%s", ItemTools.getItemNum(self.costCfg_[1]), self.costCfg_[2]))

	self.goodIcon_.sprite = ItemTools.getItemSprite(self.goodData_.goodID)
	self.goodNumText_.text = self.goodData_.goodNum
end

return SailShopItem
