local SectionRandomAttributeTipsView = class("SectionRandomAttributeTipsView", ReduxView)

function SectionRandomAttributeTipsView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SectionRandomAttributeTipsView:Init()
	self:BindCfgUI()
	self:UpdateTips()

	self.attributeItemList_ = {}
end

function SectionRandomAttributeTipsView:OnExit()
	SetActive(self.gameObject_, false)
end

function SectionRandomAttributeTipsView:SetData(arg_4_1)
	self.sectionProxy_ = arg_4_1

	SetActive(self.gameObject_, true)
	self:UpdateView()
end

function SectionRandomAttributeTipsView:UpdateView()
	self:UpdateAttributeList()
end

function SectionRandomAttributeTipsView:UpdateTips()
	self.titleText_.text = GetTips("RANDOM_ATTRIBUTE_DESC")
	self.descText_.text = GetTips("RANDOM_ATTRIBUTE_DESC_1")
	self.randomTitleText_.text = GetTips("RANDOM_ATTRUBUTE_TITLE")
end

function SectionRandomAttributeTipsView:UpdateAttributeList()
	local var_7_0 = self:GetAttributeIDList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = self.attributeItemList_[iter_7_0]

		if not self.attributeItemList_[iter_7_0] then
			var_7_1 = self:CreateAttributeItem()
			self.attributeItemList_[iter_7_0] = var_7_1
		end

		var_7_1:SetData(iter_7_1)
		var_7_1:Show(true)
	end

	for iter_7_2 = #var_7_0 + 1, #self.attributeItemList_ do
		self.attributeItemList_[iter_7_2]:Show(false)
	end
end

function SectionRandomAttributeTipsView:GetAttributeIDList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs((self.sectionProxy_:GetHeroIDList())) do
		if iter_8_1 ~= 0 then
			if type(HeroCfg[iter_8_1].ATK_attribute) == "table" then
				for iter_8_2, iter_8_3 in ipairs(HeroCfg[iter_8_1].ATK_attribute) do
					if HeroTools.IsNormalAtkAttributeId(iter_8_3) then
						table.insert(var_8_0, iter_8_3)
					end
				end
			end
		end
	end

	if #var_8_0 == 0 then
		var_8_0 = CommonFilterConst.GetDefaultHeroAttributeIdList({
			HeroConst.HERO_ATTACK_TYPE.RANDOM
		})
	end

	return var_8_0
end

function SectionRandomAttributeTipsView:CreateAttributeItem()
	return (HeroSkillAttributeItem.New((GameObject.Instantiate(self.attributeItemPrefab_, self.attributeItemParent_))))
end

function SectionRandomAttributeTipsView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.attributeItemList_) do
		iter_10_1:Dispose()
	end

	SectionRandomAttributeTipsView.super.Dispose(self)
end

function SectionRandomAttributeTipsView:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

return SectionRandomAttributeTipsView
