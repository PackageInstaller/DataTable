local PopFukubukuroProbabilityItem = class("PopFukubukuroProbabilityItem", ReduxView)

function PopFukubukuroProbabilityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PopFukubukuroProbabilityItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PopFukubukuroProbabilityItem:InitUI()
	self:BindCfgUI()
end

function PopFukubukuroProbabilityItem:AddUIListener()
	return
end

function PopFukubukuroProbabilityItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.m_name.text = ItemTools.getItemName(arg_5_1[1]) .. "x" .. arg_5_1[2]

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if iter_5_1[1] ~= arg_5_1[1] then
			var_5_1 = arg_5_1[3] / arg_5_3 / (1 - arg_5_1[3] / arg_5_3) * (iter_5_1[3] / arg_5_3) + iter_5_1[3] / arg_5_3 / (1 - iter_5_1[3] / arg_5_3) * (arg_5_1[3] / arg_5_3) + var_5_1
		end
	end

	self.m_probability.text = string.format("%.2f", math.floor(var_5_1 * 10000) / 100) .. "%"
end

function PopFukubukuroProbabilityItem:Dispose()
	PopFukubukuroProbabilityItem.super.Dispose(self)
end

return PopFukubukuroProbabilityItem
