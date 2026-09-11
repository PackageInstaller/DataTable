local CharChipExtraItem = class("CharChipExtraItem", ReduxView)

function CharChipExtraItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.control_ = self.conEx_ and self.conEx_:GetController("lock") or nil
	self.condItems_ = {}

	SetActive(self.condItem_, false)
end

function CharChipExtraItem:AddListeners()
	return
end

function CharChipExtraItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.extraID_ = arg_3_1
	self.nextID_ = arg_3_2
	self.sectionProxy_ = arg_3_3

	self:RefreshUI()
end

function CharChipExtraItem:RefreshUI()
	self.gameObject_.name = self.extraID_
	self.desc_.text = ChipCfg[self.extraID_].desc

	if self.control_ then
		local var_4_0 = false
		local var_4_1 = true

		if self.sectionProxy_ then
			var_4_0 = self.sectionProxy_:IsCharChipExtraUnlock(self.extraID_)
			var_4_1 = self.sectionProxy_:IsCharChipCanOperate(self.extraID_)
		else
			var_4_0 = ChipTools.IsCharChipExtraUnlock(self.extraID_)
		end

		if var_4_0 then
			self.control_:SetSelectedState("done")
		elseif self.nextID_ == self.extraID_ and var_4_1 then
			self.control_:SetSelectedState("now")

			self.condList_ = ChipCfg[self.extraID_].module_condition

			self:RefreshCondList()
		else
			self.control_:SetSelectedState("lock")
		end
	end

	if self.cdInitText_ then
		self.cdInitText_.text = ChipCfg[self.extraID_].cooldown_first
		self.cdText_.text = ChipCfg[self.extraID_].cooldown_com
	end
end

function CharChipExtraItem:IndexItemCond(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.condList_[arg_5_1])
end

function CharChipExtraItem:RefreshCondList()
	local var_6_0 = #self.condList_

	for iter_6_0, iter_6_1 in ipairs(self.condItems_) do
		SetActive(iter_6_1.gameObject_, iter_6_0 <= var_6_0)
	end

	for iter_6_2 = 1, var_6_0 do
		local var_6_1 = self.condItems_[iter_6_2]

		if not self.condItems_[iter_6_2] then
			local var_6_2 = Object.Instantiate(self.condItem_, self.condListTrans_)

			SetActive(var_6_2, true)

			var_6_1 = CharChipCondItem.New(var_6_2)
			self.condItems_[iter_6_2] = var_6_1
		end

		self:IndexItemCond(iter_6_2, var_6_1)
	end
end

function CharChipExtraItem:Dispose()
	CharChipExtraItem.super.Dispose(self)

	for iter_7_0, iter_7_1 in ipairs(self.condItems_) do
		iter_7_1:Dispose()
	end
end

return CharChipExtraItem
