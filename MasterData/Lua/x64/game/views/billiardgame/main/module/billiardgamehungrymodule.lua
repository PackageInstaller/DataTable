local BilliardGameHungryModuel = class("BilliardGameHungryModuel", ReduxView)

function BilliardGameHungryModuel:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameHungryModuel:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.foodItemController = {}

	for iter_2_0 = 1, 6 do
		self.foodItemController[iter_2_0] = self[string.format("itemControl%d_", iter_2_0)]:GetController("status")
	end
end

function BilliardGameHungryModuel:AddUIListener()
	return
end

function BilliardGameHungryModuel:RefreshHungry()
	local var_4_0 = BilliardGameMgr:GetLogicData().hungryVal

	for iter_4_0 = 1, 6 do
		self.foodItemController[iter_4_0]:SetSelectedState(var_4_0 <= iter_4_0 and "on" or "off")
	end
end

function BilliardGameHungryModuel:Dispose()
	BilliardGameHungryModuel.super.Dispose(self)
end

return BilliardGameHungryModuel
