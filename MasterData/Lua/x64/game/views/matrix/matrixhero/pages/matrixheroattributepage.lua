local MatrixHeroAttributePage = class("MatrixHeroAttributePage", ReduxView)

function MatrixHeroAttributePage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function MatrixHeroAttributePage:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixHeroAttributePage:InitUI()
	self:BindCfgUI()

	self.attackTypeController_ = ControllerUtil.GetController(self.transform_, "attackType")
	self.campController_ = ControllerUtil.GetController(self.transform_, "camp")

	local var_3_0 = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}

	self.propItemList = {}

	for iter_3_0 = 1, 4 do
		local var_3_1 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_1, self["m_propItem" .. iter_3_0])

		local var_3_2, var_3_3, var_3_4 = SkillTools.GetAttr({
			var_3_0[iter_3_0],
			0
		})

		var_3_1.m_name.text = GetI18NText(var_3_2)
		var_3_1.m_icon.sprite = var_3_4
		var_3_1.attribute = var_3_0[iter_3_0]

		table.insert(self.propItemList, var_3_1)
	end
end

function MatrixHeroAttributePage:AddUIListener()
	self:AddBtnListener(self.racebtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	self:AddBtnListener(self.m_moreAttributeBtn, nil, function()
		JumpTools.OpenPageByJump("heroCommonAttribute", {
			attribute = self.att_
		})
	end)
end

function MatrixHeroAttributePage:SetMatirxHeroInfo(arg_7_1)
	self.heroId_ = arg_7_1
	self.matrixHeroData = self:GetHeroData(arg_7_1)

	local var_7_0 = self.matrixHeroData:GetStandardId()
	local var_7_1
	local var_7_2

	if self.matrixHeroData:GetIsOwnerHero() then
		var_7_1, var_7_2 = GetPracticalData(self.matrixHeroData:GetEntrySnapShot())
	else
		var_7_1, var_7_2 = GetVirtualData(var_7_0)
	end

	self.heroInfo_ = var_7_1
	self.heroCfg_ = HeroCfg[arg_7_1]

	local var_7_3 = GetMatrixtHeroPracticalAttr(var_7_1, var_7_2, var_7_0, self.matrix_activity_id, self.matrixHeroData)

	var_7_3[HeroConst.HERO_ATTRIBUTE.ATK] = var_7_3[HeroConst.HERO_ATTRIBUTE.ATK] * (1 + var_7_3[11] / 1000 + var_7_3[13] / 1000) + var_7_3[12]
	var_7_3[HeroConst.HERO_ATTRIBUTE.ARM] = var_7_3[HeroConst.HERO_ATTRIBUTE.ARM] * (1 + var_7_3[21] / 1000) + var_7_3[22]
	self.att_ = var_7_3

	self:UpdateView()
end

function MatrixHeroAttributePage:UpdateView()
	self.m_nameLab.text = GetI18NText(self.heroCfg_.name)
	self.m_suffixLab.text = GetI18NText(self.heroCfg_.suffix)

	self.campController_:SetSelectedState(tostring(self.heroCfg_.race))

	self.m_starImg.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[self.heroInfo_.star].star)
	self.m_rangeTypeLab.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	self.m_desLab.text = GetI18NText(self.heroCfg_.hero_desc)

	local var_8_1 = self.matrixHeroData:GetHeroHP()
	local var_8_2 = self.matrixHeroData:GetHeroMaxHP()

	self.m_hpLab.text = var_8_1 .. "/" .. var_8_2
	self.m_hpProgress.value = var_8_2 == 0 and 0 or var_8_1 / var_8_2

	for iter_8_0, iter_8_1 in ipairs(self.propItemList) do
		iter_8_1.m_number.text = PublicAttrCfg[iter_8_1.attribute].percent == 1 and string.format("%.2f", self.att_[iter_8_1.attribute] / 10) .. "%" or math.floor(self.att_[iter_8_1.attribute])
	end

	self:RefreshChargeType()
	self:RefreshAttackType()
end

function MatrixHeroAttributePage:RefreshChargeType()
	self.chargeType_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function MatrixHeroAttributePage:RefreshAttackType()
	if #self.heroCfg_.ATK_attribute > 1 then
		self.attackTypeController_:SetSelectedState(-1)
	else
		self.attackTypeController_:SetSelectedState(self.heroCfg_.ATK_attribute[1])
	end
end

function MatrixHeroAttributePage:Hide()
	SetActive(self.gameObject_, false)
end

function MatrixHeroAttributePage:Show()
	SetActive(self.gameObject_, true)
end

function MatrixHeroAttributePage:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	MatrixHeroAttributePage.super.Dispose(self)
end

function MatrixHeroAttributePage:GetHeroData(arg_14_1)
	return MatrixData:GetHeroData(arg_14_1)
end

return MatrixHeroAttributePage
