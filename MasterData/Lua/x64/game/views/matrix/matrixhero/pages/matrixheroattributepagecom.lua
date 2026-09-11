local MatrixHeroAttributePageCom = class("MatrixHeroAttributePageCom", ReduxView)

function MatrixHeroAttributePageCom:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function MatrixHeroAttributePageCom:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixHeroAttributePageCom:InitUI()
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

function MatrixHeroAttributePageCom:AddUIListener()
	self:AddBtnListener(self.racebtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	self:AddBtnListener(self.m_moreAttributeBtn, nil, function()
		JumpTools.OpenPageByJump("heroCommonAttribute", {
			attribute = self.att_
		})
	end)
end

function MatrixHeroAttributePageCom:SetMatirxHeroInfo(arg_7_1)
	self.standardId_ = arg_7_1
	self.heroId_ = HeroStandardSystemCfg[arg_7_1].hero_id
	self.heroCfg_ = HeroCfg[self.heroId_]

	local var_7_0, var_7_1 = GetVirtualData(arg_7_1)

	self.heroInfo_ = var_7_0
	self.att_ = self:GetMatrixtSelectHeroAttr(var_7_0, var_7_1, arg_7_1)

	self:UpdateView()
end

function MatrixHeroAttributePageCom:GetMatrixtSelectHeroAttr(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HeroTools.GetHeroAttribute(arg_8_1)

	if type(HeroStandardSystemCfg[arg_8_3].hero_attrib) == "table" then
		for iter_8_0, iter_8_1 in pairs(HeroStandardSystemCfg[arg_8_3].hero_attrib) do
			var_8_0[iter_8_1[1]] = iter_8_1[2]
		end
	end

	for iter_8_2, iter_8_3 in pairs((MatrixData:CalMatrixSelectHeroAttribute())) do
		var_8_0[iter_8_2] = HeroTools.AttributeAdd(iter_8_2, var_8_0[iter_8_2], iter_8_3)
	end

	HeroTools.CalFinalAttribute(var_8_0)

	return var_8_0
end

function MatrixHeroAttributePageCom:UpdateView()
	self.m_nameLab.text = GetI18NText(self.heroCfg_.name)
	self.m_suffixLab.text = GetI18NText(self.heroCfg_.suffix)

	self.campController_:SetSelectedState(tostring(self.heroCfg_.race))

	self.m_starImg.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[self.heroInfo_.star].star)
	self.m_rangeTypeLab.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	self.m_desLab.text = GetI18NText(self.heroCfg_.hero_desc)

	for iter_9_0, iter_9_1 in ipairs(self.propItemList) do
		iter_9_1.m_number.text = PublicAttrCfg[iter_9_1.attribute].percent == 1 and string.format("%.2f", self.att_[iter_9_1.attribute] / 10) .. "%" or math.floor(self.att_[iter_9_1.attribute])
	end

	self:RefreshChargeType()
	self:RefreshAttackType()
end

function MatrixHeroAttributePageCom:RefreshChargeType()
	self.chargeType_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function MatrixHeroAttributePageCom:RefreshAttackType()
	if #self.heroCfg_.ATK_attribute > 1 then
		self.attackTypeController_:SetSelectedState(-1)
	else
		self.attackTypeController_:SetSelectedState(self.heroCfg_.ATK_attribute[1])
	end
end

function MatrixHeroAttributePageCom:PlayEnterAni()
	return
end

function MatrixHeroAttributePageCom:Hide()
	SetActive(self.gameObject_, false)
end

function MatrixHeroAttributePageCom:Show()
	SetActive(self.gameObject_, true)
end

function MatrixHeroAttributePageCom:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	MatrixHeroAttributePageCom.super.Dispose(self)
end

return MatrixHeroAttributePageCom
