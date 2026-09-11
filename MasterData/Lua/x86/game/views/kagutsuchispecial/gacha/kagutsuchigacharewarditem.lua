local KagutsuchiGachaRewardItem = class("KagutsuchiGachaRewardItem", ReduxView)

function KagutsuchiGachaRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function KagutsuchiGachaRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function KagutsuchiGachaRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardController_ = ControllerUtil.GetController(self.transform_, "reward")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function KagutsuchiGachaRewardItem:AddUIListeners()
	self.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			self.itemID_
		})
	end)
end

function KagutsuchiGachaRewardItem:OnEnter()
	return
end

function KagutsuchiGachaRewardItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.id_ = arg_7_3
	self.poolId_ = arg_7_2
	self.activityId_ = arg_7_1

	self:RefreshUI()
end

function KagutsuchiGachaRewardItem:RefreshUI()
	local var_8_0, var_8_1 = KagutsuchiGachaData:GetDrawItemReward(self.poolId_, self.id_)
	local var_8_2 = KagutsuchiGachaData:GetDrawItemRemainCount(self.poolId_, self.id_)
	local var_8_3 = var_8_2 .. "/" .. KagutsuchiGachaData:GetDrawItemTotalCount(self.poolId_, self.id_)

	self.itemID_ = var_8_0

	self.rewardController_:SetSelectedState(var_8_2 > 0 and "have" or "no")

	self.itemText_.text = var_8_3

	self.commonItem_:RefreshData({
		id = var_8_0,
		number = var_8_1
	})
end

function KagutsuchiGachaRewardItem:OnExit()
	return
end

function KagutsuchiGachaRewardItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	self.super.Dispose(self)
end

return KagutsuchiGachaRewardItem
