local DrawProbabilityItem = class("DrawProbabilityItem", ReduxView)

function DrawProbabilityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function DrawProbabilityItem:RefreshData(arg_2_1)
	self:Show(true)

	self.labName_.text = GetI18NText(arg_2_1.name)
	self.labRate_.text = GetI18NText(arg_2_1.probability)
	self.labRate2_.text = ""

	local var_2_0

	if arg_2_1.probability2 then
		self.labRate2_.text = GetI18NText(arg_2_1.probability2)
		var_2_0 = ""
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_1.itemid_) do
		local var_2_1 = DrawItemCfg[iter_2_1].item_id or 0

		if var_2_1 ~= 0 then
			var_2_0 = var_2_0 == "" and ItemTools.getItemName(var_2_1) or var_2_0 .. "/" .. ItemTools.getItemName(var_2_1)
		end
	end

	self.labContent_.text = GetI18NText(var_2_0)
end

function DrawProbabilityItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

return DrawProbabilityItem
