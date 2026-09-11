local HodurChallengeHeroModule = class("HodurChallengeHeroModule", ReduxView)

function HodurChallengeHeroModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurChallengeHeroModule:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}

	for iter_2_0 = 1, 3 do
		self.heroItemList_[iter_2_0] = HodurChallengeHeroItem.New(self["heroGo_" .. iter_2_0])
	end

	self.itemList_ = {}
end

function HodurChallengeHeroModule:SetData(arg_3_1)
	self.chapterID_ = arg_3_1

	local var_3_0 = HodurTools.GetChallengeAffix()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = self.itemList_[#self.itemList_ + 1]

		if not self.itemList_[#self.itemList_ + 1] then
			var_3_1 = HodurChallengeSelectAffixItem.New(Object.Instantiate(self.affixGo_, self.affixContentTrs_))
			self.itemList_[#self.itemList_ + 1] = var_3_1
		end

		var_3_1:SetData(iter_3_1)
		var_3_1:SetActive(true)
		var_3_1:SetClickHandler(function(arg_4_0)
			self:OnClickAffixItem(arg_4_0, var_3_1)
		end)
	end

	for iter_3_2 = #var_3_0 + 1, #self.itemList_ do
		self.itemList_[iter_3_2]:SetActive(false)
	end

	self:RefreshHero()
	self:ShowTips(false)

	for iter_3_3, iter_3_4 in ipairs(self.itemList_) do
		if iter_3_4.selected_ then
			iter_3_4:SetSelected(false)
		end
	end
end

function HodurChallengeHeroModule:OnClickAffixItem(arg_5_1, arg_5_2)
	if arg_5_2.selected_ then
		arg_5_2:SetSelected(false)
		self:ShowTips(false)
	else
		arg_5_2:SetSelected(true)
		self:ShowTips(true, arg_5_1)

		for iter_5_0, iter_5_1 in ipairs(self.itemList_) do
			if iter_5_1 ~= arg_5_2 and iter_5_1.selected_ then
				iter_5_1:SetSelected(false)
			end
		end
	end
end

function HodurChallengeHeroModule:ShowTips(arg_6_1, arg_6_2)
	self.showTips_ = arg_6_1

	SetActive(self.tipsGo_, arg_6_1)

	if arg_6_1 then
		self.affixNameText_.text = AffixTypeCfg[arg_6_2].name
		self.affixDesText_.text = DescriptionCfg[AffixTypeCfg[arg_6_2].description[1]].description
	end
end

function HodurChallengeHeroModule:RefreshHero()
	self.heroList_ = HodurTools.GetChallengeHero()

	for iter_7_0, iter_7_1 in ipairs(self.heroItemList_) do
		local var_7_0
		local var_7_1

		if self.heroList_[iter_7_0] then
			var_7_0, var_7_1 = HodurTools.GetChallengeHeroHP(self.heroList_[iter_7_0])
		end

		iter_7_1:SetData(self.heroList_[iter_7_0], var_7_0, var_7_1)
	end
end

function HodurChallengeHeroModule:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.itemList_) do
		iter_8_1:Dispose()
	end

	for iter_8_2, iter_8_3 in ipairs(self.heroItemList_) do
		iter_8_3:Dispose()
	end

	HodurChallengeHeroModule.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurChallengeHeroModule
