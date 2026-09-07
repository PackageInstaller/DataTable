local MainConcealablePanel = class("MainConcealablePanel", import(".MainBasePanel"))

function MainConcealablePanel:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainConcealablePanel.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self.initPosition = {}

	for iter_1_0, iter_1_1 in ipairs(self.btns) do
		if not iter_1_1:IsFixed() then
			table.insert(self.initPosition, iter_1_1._tf.localPosition)
		end
	end

	self.isChanged = false

	return
end

function MainConcealablePanel:Init()
	MainConcealablePanel.super.Init(self)
	self:CalcLayout()

	return
end

function MainConcealablePanel:Refresh()
	MainConcealablePanel.super.Refresh(self)
	self:CalcLayout()

	return
end

function MainConcealablePanel:CalcLayout()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.btns) do
		if not iter_4_1:IsFixed() and isActive(iter_4_1._tf) then
			table.insert(var_4_0, iter_4_1._tf)
		end
	end

	local var_4_1 = #var_4_0 >= #self.initPosition

	if #var_4_0 >= #self.initPosition and not self.isChanged then
		return
	end

	self:FillEmptySlot(var_4_0)

	self.isChanged = not var_4_1

	return
end

function MainConcealablePanel:FillEmptySlot(arg_5_1)
	for iter_5_0 = #arg_5_1, 1, -1 do
		arg_5_1[iter_5_0].localPosition = self.initPosition[#self.initPosition]
	end

	return
end

return MainConcealablePanel
