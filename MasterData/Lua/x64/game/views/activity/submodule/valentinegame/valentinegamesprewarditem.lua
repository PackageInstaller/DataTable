local ValentineGameSPRewardItem = class("ValentineGameSPRewardItem", ReduxView)

function ValentineGameSPRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ValentineGameSPRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameSPRewardItem:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItem.New(self.commonGo_)
end

function ValentineGameSPRewardItem:AddUIListeners()
	return
end

function ValentineGameSPRewardItem:SetData(arg_5_1)
	self.data_ = formatReward(arg_5_1)

	self.commonItem_:RefreshData((rewardToItemTemplate(arg_5_1)))
	self.commonItem_:RegistCallBack(function(arg_6_0)
		ShowPopItem(POP_ITEM, arg_6_0)
	end)
	self:RefreshText()
	SetActive(self.gameObject_, true)
end

function ValentineGameSPRewardItem:RefreshText()
	self.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.cntText_.text = GetI18NText(self.data_.num)
end

function ValentineGameSPRewardItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function ValentineGameSPRewardItem:OnExit()
	self.commonItem_:OnExit()
end

function ValentineGameSPRewardItem:Dispose()
	self:RemoveAllListeners()
	self.commonItem_:Dispose()
	self.super.Dispose(self)
end

return ValentineGameSPRewardItem
