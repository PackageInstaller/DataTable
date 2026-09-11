local SectionInfoAffixBar = class("SectionInfoAffixBar", ReduxView)

function SectionInfoAffixBar:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	for iter_1_0 = 1, 3 do
		self["affixController" .. iter_1_0 .. "_"] = self["affixControllerEx" .. iter_1_0 .. "_"]:GetController("lcok")
	end

	self:AddUIListener()
end

function SectionInfoAffixBar:AddUIListener()
	for iter_2_0 = 1, 3 do
		self:AddBtnListener(self["affixBtn" .. iter_2_0 .. "_"], nil, function()
			if self.isMain_ == false or self.affix_[iter_2_0].isLock == false then
				return
			end

			local var_3_0

			if iter_2_0 == 1 then
				var_3_0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "A")
			elseif iter_2_0 == 2 then
				var_3_0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "B")
			elseif iter_2_0 == 3 then
				var_3_0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "C")
			end

			ShowTips(var_3_0)
		end)
	end
end

function SectionInfoAffixBar:Dispose()
	SectionInfoAffixBar.super.Dispose(self)
end

function SectionInfoAffixBar:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.isMain_ = arg_5_1
	self.affix_ = arg_5_2
	self.titleText_.text = arg_5_3

	local var_5_1 = self.isMain_ and 3 or 1

	for iter_5_0 = 1, 3 do
		if iter_5_0 <= var_5_1 then
			SetActive(self["affixGo" .. iter_5_0 .. "_"], true)

			if self.isMain_ then
				if arg_5_2[iter_5_0].isLock then
					self["affixController" .. iter_5_0 .. "_"]:SetSelectedState("true")
				else
					self["affixController" .. iter_5_0 .. "_"]:SetSelectedState("false")
				end
			else
				self["affixController" .. iter_5_0 .. "_"]:SetSelectedState("false")
			end

			self["affixImage" .. iter_5_0 .. "_"].sprite = getAffixSprite(arg_5_2[iter_5_0])
			self["affixName" .. iter_5_0 .. "_"].text = getAffixName(arg_5_2[iter_5_0])
			self["affixDes" .. iter_5_0 .. "_"].text = getAffixDesc(arg_5_2[iter_5_0])
		else
			SetActive(self["affixGo" .. iter_5_0 .. "_"], false)
		end
	end
end

return SectionInfoAffixBar
