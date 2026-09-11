local NewHeroChipPageItem = class("NewHeroChipPageItem", ReduxView)

function NewHeroChipPageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function NewHeroChipPageItem:SetData(arg_2_1, arg_2_2, arg_2_3)
	self.chipID_ = arg_2_1
	self.heroID_ = arg_2_2
	self.type_ = arg_2_3

	self:RefreshUI()
end

function NewHeroChipPageItem:InitUI()
	self:BindCfgUI()

	self.controller_ = self.itemCon_:GetController("ishavechip")
	self.iconController_ = self.itemCon_:GetController("icon")
end

function NewHeroChipPageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:Go("/newHeroChipView", {
			heroID = self.heroID_,
			type = self.type_,
			chipID = self.chipID_
		})
	end)
end

function NewHeroChipPageItem:RefreshUI()
	self.iconController_:SetSelectedState(self.type_)

	self.typeText_.text = GetTips("CHIP_HERO_TYPE_" .. self.type_)

	if self.chipID_ and self.chipID_ > 0 then
		self.scrollRect_.verticalNormalizedPosition = 1

		self.controller_:SetSelectedState("on")

		self.nameText_.text = ChipCfg[self.chipID_].suit_name
		self.desText_.text = ChipCfg[self.chipID_].desc

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

		self.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.chipID_].picture_id)
	else
		self.controller_:SetSelectedState("off")
	end
end

function NewHeroChipPageItem:SetIsShow(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function NewHeroChipPageItem:BindRedPoint()
	if self.extra_ then
		SetActive(self.redGo_, false)
	else
		local var_8_0 = RedPointConst.CHIP_HERO_CHIP .. "_all_" .. self.heroID_ .. "_" .. self.type_

		manager.redPoint:addGroup(RedPointConst.CHIP_HERO_CHIP .. "_all_" .. self.heroID_ .. "_" .. self.type_, {
			RedPointConst.CHIP_HERO_CHIP .. "_" .. self.heroID_ .. "_" .. self.type_,
			RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. self.heroID_ .. "_" .. self.type_
		})
		manager.redPoint:bindUIandKey(self.transform_, var_8_0)
	end
end

function NewHeroChipPageItem:UnBindRedPoint()
	if self.extra_ then
		-- block empty
	else
		manager.redPoint:unbindUIandKey(self.transform_)
	end
end

function NewHeroChipPageItem:Dispose()
	NewHeroChipPageItem.super.Dispose(self)
end

return NewHeroChipPageItem
