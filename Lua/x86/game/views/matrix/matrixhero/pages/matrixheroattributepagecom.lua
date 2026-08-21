local var_0_0 = class("MatrixHeroAttributePageCom", ReduxView)

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
	arg_7_0.standardId_ = arg_7_1
	arg_7_0.heroId_ = HeroStandardSystemCfg[arg_7_1].hero_id
	arg_7_0.heroCfg_ = HeroCfg[arg_7_0.heroId_]

	local var_7_0, var_7_1 = GetVirtualData(arg_7_1)

	arg_7_0.heroInfo_ = var_7_0
	arg_7_0.att_ = arg_7_0:GetMatrixtSelectHeroAttr(var_7_0, var_7_1, arg_7_1)

	arg_7_0:UpdateView()
end

function var_0_0.GetMatrixtSelectHeroAttr(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HeroTools.GetHeroAttribute(arg_8_1)
	local var_8_1 = HeroStandardSystemCfg[arg_8_3].hero_attrib

	if type(var_8_1) == "table" then
		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			var_8_0[iter_8_1[1]] = iter_8_1[2]
		end
	end

	local var_8_2 = MatrixData:CalMatrixSelectHeroAttribute()

	for iter_8_2, iter_8_3 in pairs(var_8_2) do
		var_8_0[iter_8_2] = HeroTools.AttributeAdd(iter_8_2, var_8_0[iter_8_2], iter_8_3)
	end

	HeroTools.CalFinalAttribute(var_8_0)

	return var_8_0
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.m_nameLab.text = GetI18NText(arg_9_0.heroCfg_.name)
	arg_9_0.m_suffixLab.text = GetI18NText(arg_9_0.heroCfg_.suffix)

	arg_9_0.campController_:SetSelectedState(tostring(arg_9_0.heroCfg_.race))

	local var_9_0 = HeroStarCfg[arg_9_0.heroInfo_.star]

	arg_9_0.m_starImg.sprite = getSprite("Atlas/Common", "star_" .. var_9_0.star)
	arg_9_0.m_rangeTypeLab.text = CharactorParamCfg[arg_9_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	arg_9_0.m_desLab.text = GetI18NText(arg_9_0.heroCfg_.hero_desc)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.propItemList) do
		local var_9_1 = iter_9_1.attribute
		local var_9_2 = PublicAttrCfg[var_9_1].percent == 1
		local var_9_3 = arg_9_0.att_[var_9_1]

		if var_9_2 then
			iter_9_1.m_number.text = string.format("%.2f", var_9_3 / 10) .. "%"
		else
			iter_9_1.m_number.text = math.floor(var_9_3)
		end
	end

	arg_9_0:RefreshChargeType()
	arg_9_0:RefreshAttackType()
end

function var_0_0.RefreshChargeType(arg_10_0)
	arg_10_0.chargeType_.text = HeroTools.GetChargeTextByType(arg_10_0.heroCfg_.mechanism_type[1])
end

function var_0_0.RefreshAttackType(arg_11_0)
	if #arg_11_0.heroCfg_.ATK_attribute > 1 then
		arg_11_0.attackTypeController_:SetSelectedState(-1)
	else
		local var_11_0 = arg_11_0.heroCfg_.ATK_attribute[1]

		arg_11_0.attackTypeController_:SetSelectedState(var_11_0)
	end
end

function var_0_0.PlayEnterAni(arg_12_0)
	return
end

function var_0_0.Hide(arg_13_0)
	SetActive(arg_13_0.gameObject_, false)
end

function var_0_0.Show(arg_14_0)
	SetActive(arg_14_0.gameObject_, true)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()

	arg_15_0.handler_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
