local CanteenPassTablePop = class("CanteenPassTablePop", ReduxView)

function CanteenPassTablePop:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamPassTablePop"
end

function CanteenPassTablePop:UIParent()
	return manager.ui.uiPop.transform
end

function CanteenPassTablePop:Init()
	self:InitUI()
	self:AddUIListener()
end

function CanteenPassTablePop:ExitOnCanteenModeChange()
	self.onSelect = nil
	self.onCanceled = nil

	self:Back()
end

function CanteenPassTablePop:OnEnter()
	self.passtableEntityEid = CanteenAIFunction:GetAllEIDNameSpace((CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable)))[1]
	self.passtableData = CanteenAIFunction:GetEntityData(self.passtableEntityEid)
	self.foodList = nullable(self.passtableData, "foodList")
	self.playerEID = self.params_.playerEID
	self.onSelect = self.params_.onSelect
	self.onCanceled = self.params_.onCanceled

	self.foodListScroll_:StartScroll((self.foodList or nil) and (#self.foodList or 0))

	self.select = false

	local var_5_0 = handler(self, self.ExitOnCanteenModeChange)

	self:RegistEventListener(DORM_RESTAURANT_START_AUTO, var_5_0)
	self:RegistEventListener(DORM_RESTAURANT_START_MANUAL, var_5_0)
end

function CanteenPassTablePop:InitUI()
	self:BindCfgUI()

	self.foodListScroll_ = LuaList.New(handler(self, self.foodItem), self.foodlistUilist_, CanteenPassTableFoodItem)
end

function CanteenPassTablePop:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self.select = false

		JumpTools.Back()
	end)
end

function CanteenPassTablePop:foodItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshItem(self.foodList[arg_9_1])
	arg_9_2:RegistCallBack(function(arg_10_0)
		CanteenAIFunction:SetCharacterTarget(self.playerEID, arg_10_0)

		self.select = true

		JumpTools.Back()
	end)
end

function CanteenPassTablePop:OnExit()
	self:RemoveAllEventListener()

	if self.select then
		if self.onSelect then
			self.onSelect()
		end
	elseif self.onCanceled then
		self.onCanceled()
	end
end

function CanteenPassTablePop:Dispose()
	if self.foodListScroll_ then
		self.foodListScroll_:Dispose()

		self.foodListScroll_ = nil
	end
end

return CanteenPassTablePop
