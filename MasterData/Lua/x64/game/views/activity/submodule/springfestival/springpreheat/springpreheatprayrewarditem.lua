local SpringPreheatPrayRewardItem = class("SpringPreheatPrayRewardItem", ReduxView)
local var_0_1 = {
	GO_SELECT = 1,
	SELECTING = 2
}

function SpringPreheatPrayRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SpringPreheatPrayRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.id_ = 0

	self:SwitchToSelecting()
end

function SpringPreheatPrayRewardItem:InitUI()
	self:BindCfgUI()

	self.goSelectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.selectingController_ = ControllerUtil.GetController(self.transform_, "select")

	if self.commonItemGo_ then
		self.commonItem_ = CommonItem.New(self.commonItemGo_)
		self.hasCommonItem_ = true
	end
end

function SpringPreheatPrayRewardItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ then
			self:onClickHandler_()
		end
	end)

	if self.commonItem_ then
		self.commonItem_:RegistCallBack(function(arg_6_0)
			if self.onClickHandler_ then
				self:onClickHandler_()
			end
		end)
	end
end

function SpringPreheatPrayRewardItem:SetClickHandler(arg_7_1)
	if arg_7_1 then
		self.onClickHandler_ = arg_7_1
	end
end

function SpringPreheatPrayRewardItem:OnEnter()
	return
end

function SpringPreheatPrayRewardItem:OnExit()
	return
end

function SpringPreheatPrayRewardItem:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	self.super.Dispose(self)
end

function SpringPreheatPrayRewardItem:SwitchToGoSelect()
	self.mode_ = var_0_1.GO_SELECT
end

function SpringPreheatPrayRewardItem:SwitchToSelecting()
	self.mode_ = var_0_1.SELECTING
end

function SpringPreheatPrayRewardItem:SetSelected(arg_13_1)
	self.selected_ = arg_13_1

	return self.selected_
end

function SpringPreheatPrayRewardItem:SetSelectable(arg_14_1)
	self.selectable_ = arg_14_1

	return self.selectable_
end

function SpringPreheatPrayRewardItem:SetData(arg_15_1)
	self.id_ = arg_15_1
	self.poolId_ = SpringPreheatData:GetPoolId()

	self:RefreshUI()
end

function SpringPreheatPrayRewardItem:RefreshUI()
	if self.mode_ == var_0_1.GO_SELECT then
		self.goSelectController_:SetSelectedState(self:CanGoSelect() and "true" or "false")
	elseif self.selectable_ then
		self.selectingController_:SetSelectedState(self.selected_ and "clicked" or "selectable")
	else
		self.selectingController_:SetSelectedState("selected")
	end

	self:RefreshItemUI()
end

function SpringPreheatPrayRewardItem:RefreshItemUI()
	if self.id_ == 0 then
		self.itemID_ = 0

		if self.hasCommonItem_ then
			SetActive(self.commonItemGo_, false)
		end

		SetActive(self.iconGo_, false)

		return
	end

	local var_17_0, var_17_1 = KagutsuchiGachaData:GetDrawItemReward(self.poolId_, self.id_)

	self.itemID_ = var_17_0

	if self.hasCommonItem_ then
		self.commonItem_:RefreshData({
			id = var_17_0,
			number = var_17_1
		})
		SetActive(self.commonItemGo_, true)
	else
		self.icon_.sprite = ItemTools.getItemSprite(var_17_0)

		SetActive(self.iconGo_, true)
	end
end

function SpringPreheatPrayRewardItem:GetItemId()
	return self.itemID_
end

function SpringPreheatPrayRewardItem:CanGoSelect()
	return self.id_ ~= 0 and self.mode_ == var_0_1.GO_SELECT
end

return SpringPreheatPrayRewardItem
