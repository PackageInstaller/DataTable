local var_0_0 = class("WeaponServantDetailModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.controller = {
		comps = arg_2_0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			btnState = {
				beyond = "beyond",
				name = "btnState",
				equipped = "equipped",
				detail = "detail"
			}
		}
	}
	arg_2_0.data = {}
	arg_2_0.constVar = {
		rareBg = "",
		subDescColor = "#70767F",
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}
end

function var_0_0.InitContext(arg_3_0)
	arg_3_0.data = {
		servantAddLv = 0,
		heroId = 0,
		descType = 1,
		info = {}
	}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.detailBtn_, nil, function()
		arg_5_0:OnSwitchDescClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		arg_5_0:OnLockBtnClick()
	end)
	arg_5_0:RegistEventListener(SERVANT_LOCK, handler(arg_5_0, arg_5_0.OnServantLock))
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.OnRenderModule(arg_11_0, arg_11_1)
	arg_11_0:InitContext()

	local var_11_0 = arg_11_1.heroId
	local var_11_1 = clone(arg_11_1.servantData)

	arg_11_0.data.info = var_11_1

	local var_11_2 = var_11_1.stage
	local var_11_3 = 0

	arg_11_0.data.heroId = var_11_0

	if var_11_0 and var_11_0 > 0 then
		local var_11_4 = arg_11_0:GetHeroInfo(var_11_0)

		var_11_3 = HeroTools.GetHeroWeaponAddLevel(var_11_4)
	end

	arg_11_0.data.servantAddLv = var_11_3

	if var_11_3 > 0 then
		arg_11_0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), var_11_2, var_11_3)
	else
		arg_11_0.stageTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), var_11_2)
	end

	local var_11_5 = var_11_1.id
	local var_11_6 = WeaponServantCfg[var_11_5]
	local var_11_7 = ItemCfg[var_11_5]

	arg_11_0.nameTxt_.text = ItemTools.getItemName(var_11_7.id)

	local var_11_8 = string.format("com_white_icon_group_%d_c", var_11_6.race)

	arg_11_0.groupImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_11_8)
	arg_11_0.groupTitleImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_11_8)
	arg_11_0.groupTitleTxt_.text = string.format(GetTips("EQUIP_RACE"), GetI18NText(RaceEffectCfg[var_11_6.race].name))

	arg_11_0:RenderLock()
	arg_11_0:RefreshEffectText()
	arg_11_0:RefreshRecommend()

	arg_11_0.attackRatioTxt_.text = table.concat({
		"+",
		var_11_6.attrib_addition,
		"%"
	})

	local var_11_9, var_11_10, var_11_11 = SkillTools.GetAttr(var_11_6.attribute)

	arg_11_0.subAttrNameTxt_.text = var_11_9
	arg_11_0.subAttrTxt_.text = "+" .. var_11_10
	arg_11_0.subAttrIconImg_.sprite = var_11_11

	arg_11_0:RenderEquipStatus()
	arg_11_0:RenderLockObj()
end

function var_0_0.RenderLock(arg_12_0)
	if arg_12_0.data.info.locked == 1 then
		arg_12_0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", arg_12_0.constVar.lockImg.locked)
	else
		arg_12_0.lockImg_.sprite = getSprite("Atlas/SystemCommonAtlas", arg_12_0.constVar.lockImg.unlocked)
	end
end

function var_0_0.RenderLockObj(arg_13_0)
	if arg_13_0.data.info.uid then
		SetActive(arg_13_0.lockImg_.gameObject, true)
	else
		SetActive(arg_13_0.lockImg_.gameObject, false)
	end
end

function var_0_0.SwitchControllerState(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.controller.comps:GetController(arg_14_1)

	if var_14_0 then
		var_14_0:SetSelectedState(arg_14_2)
	end
end

function var_0_0.GetHeroInfo(arg_15_0, arg_15_1)
	return arg_15_0.constVar.proxy:GetHeroData(arg_15_1)
end

function var_0_0.RefreshEffectText(arg_16_0)
	local var_16_0 = arg_16_0.data.descType
	local var_16_1 = ""
	local var_16_2 = arg_16_0.data.info
	local var_16_3 = WeaponServantCfg[var_16_2.id]
	local var_16_4 = GetI18NText(var_16_3.desc)

	if var_16_0 == 1 then
		var_16_1 = arg_16_0.constVar.proxy:GetServantEffect(var_16_2.id, nil, true)
		arg_16_0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	else
		var_16_1 = arg_16_0.constVar.proxy:GetServantEffect(var_16_2.id, var_16_2.stage + arg_16_0.data.servantAddLv)
		arg_16_0.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	end

	arg_16_0.descTxt_.text = table.concat({
		GetI18NText(var_16_1),
		"\n<color=",
		arg_16_0.constVar.subDescColor,
		">",
		var_16_4,
		"</color>"
	})
end

function var_0_0.RefreshRecommend(arg_17_0)
	local var_17_0 = arg_17_0.data.info
	local var_17_1 = WeaponServantCfg[var_17_0.id].effect[1]
	local var_17_2 = 0

	if var_17_1 > 0 then
		var_17_2 = WeaponEffectCfg[var_17_1].spec_char[1]
	end

	if var_17_2 ~= nil and var_17_2 > 0 then
		SetActive(arg_17_0.recommendObj_, true)

		arg_17_0.heroImg_.sprite = HeroTools.GetSmallHeadSprite(var_17_2)
	else
		SetActive(arg_17_0.recommendObj_, false)
	end
end

function var_0_0.RenderEquipStatus(arg_18_0)
	local var_18_0 = ServantTools.GetServantMap()
	local var_18_1 = arg_18_0.data.info

	if var_18_1.uid then
		local var_18_2 = var_18_0[var_18_1.uid]

		if var_18_2 then
			SetActive(arg_18_0.equipObj_, true)

			arg_18_0.equipHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(var_18_2)
			arg_18_0.equipHeroTxt_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[var_18_2].name))
		else
			SetActive(arg_18_0.equipObj_, false)
		end
	else
		SetActive(arg_18_0.equipObj_, false)
	end
end

function var_0_0.OnSwitchDescClick(arg_19_0)
	arg_19_0.data.descType = (arg_19_0.data.descType + 1) % 2

	arg_19_0:RefreshEffectText()
end

function var_0_0.OnLockBtnClick(arg_20_0)
	if arg_20_0.data.info.uid and arg_20_0.data.info.uid ~= 0 then
		ServantAction.ServantLock(arg_20_0.data.info.uid)
	end
end

function var_0_0.OnServantLock(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.data.info.uid and arg_21_0.data.info.uid ~= 0 and arg_21_1 == arg_21_0.data.info.uid then
		arg_21_0.data.info.locked = arg_21_2

		arg_21_0:RenderLock()
	end
end

return var_0_0
