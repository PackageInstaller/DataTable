local var_0_0 = class("MatrixHeroAttributePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.attackTypeController_ = ControllerUtil.GetController(arg_3_0.transform_, "attackType")
	arg_3_0.campController_ = ControllerUtil.GetController(arg_3_0.transform_, "camp")

	local var_3_0 = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}

	arg_3_0.propItemList = {}

	for iter_3_0 = 1, 4 do
		local var_3_1 = {}
		local var_3_2 = arg_3_0["m_propItem" .. iter_3_0]

		ComponentBinder.GetInstance():BindCfgUI(var_3_1, var_3_2)

		local var_3_3 = var_3_0[iter_3_0]
		local var_3_4, var_3_5, var_3_6 = SkillTools.GetAttr({
			var_3_3,
			0
		})

		var_3_1.m_name.text = GetI18NText(var_3_4)
		var_3_1.m_icon.sprite = var_3_6
		var_3_1.attribute = var_3_0[iter_3_0]

		table.insert(arg_3_0.propItemList, var_3_1)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.racebtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_moreAttributeBtn, nil, function()
		JumpTools.OpenPageByJump("heroCommonAttribute", {
			attribute = arg_4_0.att_
		})
	end)
end

function var_0_0.SetMatirxHeroInfo(arg_7_0, arg_7_1)
	arg_7_0.heroId_ = arg_7_1
	arg_7_0.matrixHeroData = arg_7_0:GetHeroData(arg_7_1)

	local var_7_0 = arg_7_0.matrixHeroData:GetStandardId()
	local var_7_1
	local var_7_2

	if arg_7_0.matrixHeroData:GetIsOwnerHero() then
		var_7_1, var_7_2 = GetPracticalData(arg_7_0.matrixHeroData:GetEntrySnapShot())
	else
		var_7_1, var_7_2 = GetVirtualData(var_7_0)
	end

	arg_7_0.heroInfo_ = var_7_1
	arg_7_0.heroCfg_ = HeroCfg[arg_7_1]

	local var_7_3 = GetMatrixtHeroPracticalAttr(var_7_1, var_7_2, var_7_0, arg_7_0.matrix_activity_id, arg_7_0.matrixHeroData)
	local var_7_4 = var_7_3[HeroConst.HERO_ATTRIBUTE.ATK]
	local var_7_5 = var_7_3[HeroConst.HERO_ATTRIBUTE.ARM]
	local var_7_6 = var_7_3[HeroConst.HERO_ATTRIBUTE.STA]

	var_7_3[HeroConst.HERO_ATTRIBUTE.ATK] = var_7_4 * (1 + var_7_3[11] / 1000 + var_7_3[13] / 1000) + var_7_3[12]
	var_7_3[HeroConst.HERO_ATTRIBUTE.ARM] = var_7_5 * (1 + var_7_3[21] / 1000) + var_7_3[22]
	arg_7_0.att_ = var_7_3

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.m_nameLab.text = GetI18NText(arg_8_0.heroCfg_.name)
	arg_8_0.m_suffixLab.text = GetI18NText(arg_8_0.heroCfg_.suffix)

	arg_8_0.campController_:SetSelectedState(tostring(arg_8_0.heroCfg_.race))

	local var_8_0 = HeroStarCfg[arg_8_0.heroInfo_.star]

	arg_8_0.m_starImg.sprite = getSprite("Atlas/Common", "star_" .. var_8_0.star)
	arg_8_0.m_rangeTypeLab.text = CharactorParamCfg[arg_8_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	arg_8_0.m_desLab.text = GetI18NText(arg_8_0.heroCfg_.hero_desc)

	local var_8_1 = arg_8_0.matrixHeroData:GetHeroHP()
	local var_8_2 = arg_8_0.matrixHeroData:GetHeroMaxHP()

	arg_8_0.m_hpLab.text = var_8_1 .. "/" .. var_8_2
	arg_8_0.m_hpProgress.value = var_8_2 == 0 and 0 or var_8_1 / var_8_2

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.propItemList) do
		local var_8_3 = iter_8_1.attribute
		local var_8_4 = PublicAttrCfg[var_8_3].percent == 1
		local var_8_5 = arg_8_0.att_[var_8_3]

		if var_8_4 then
			iter_8_1.m_number.text = string.format("%.2f", var_8_5 / 10) .. "%"
		else
			iter_8_1.m_number.text = math.floor(var_8_5)
		end
	end

	arg_8_0:RefreshChargeType()
	arg_8_0:RefreshAttackType()
end

function var_0_0.RefreshChargeType(arg_9_0)
	arg_9_0.chargeType_.text = HeroTools.GetChargeTextByType(arg_9_0.heroCfg_.mechanism_type[1])
end

function var_0_0.RefreshAttackType(arg_10_0)
	if #arg_10_0.heroCfg_.ATK_attribute > 1 then
		arg_10_0.attackTypeController_:SetSelectedState(-1)
	else
		local var_10_0 = arg_10_0.heroCfg_.ATK_attribute[1]

		arg_10_0.attackTypeController_:SetSelectedState(var_10_0)
	end
end

function var_0_0.Hide(arg_11_0)
	SetActive(arg_11_0.gameObject_, false)
end

function var_0_0.Show(arg_12_0)
	SetActive(arg_12_0.gameObject_, true)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	arg_13_0.handler_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.GetHeroData(arg_14_0, arg_14_1)
	return MatrixData:GetHeroData(arg_14_1)
end

return var_0_0
