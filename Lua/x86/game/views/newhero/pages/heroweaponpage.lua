local var_0_0 = class("HeroWeaponPage", HeroPageBase)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.weaponInfo_ = {}
	arg_2_0.heroInfo_ = {}
	arg_2_0.servantInfo_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.lockController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.isSelfController_ = arg_2_0.controller_:GetController("isSelf")
end

function var_0_0.SetHeroInfo(arg_3_0, arg_3_1)
	arg_3_0.type_ = arg_3_0.heroViewProxy_:GetViewDataType()
	arg_3_0.heroInfo_ = arg_3_1

	if arg_3_0.heroViewProxy_.showRedPoint then
		local var_3_0 = RedPointConst.HERO_WEAPON_BREAK_ID .. arg_3_0.heroInfo_.id

		manager.redPoint:bindUIandKey(arg_3_0.weaponstrengthTrs_, var_3_0)
	end
end

function var_0_0.UpdateView(arg_4_0)
	arg_4_0.servantInfo_ = arg_4_0.heroViewProxy_:GetHeroServantInfo(arg_4_0.heroInfo_.id)

	arg_4_0:RefreshServant(arg_4_0.servantInfo_)
	arg_4_0:RefreshWeapon()
	arg_4_0:RefreshStrengthText()

	if not isNil(arg_4_0.servantcontentBtn_) and not isNil(arg_4_0.servantcontentBtn_.gameObject) then
		LuaForUtil.ActiveHoverEffect(arg_4_0.servantcontentBtn_.gameObject, not arg_4_0.heroViewProxy_.isSelf)
	end
end

function var_0_0.RefreshStrengthText(arg_5_0)
	local var_5_0 = ""

	if HeroData:GetHeroList()[arg_5_0.heroInfo_.id].weapon_info.level == HeroConst.WEAPON_LV_MAX then
		var_5_0 = GetTips("TIP_DETAIL")
	elseif GameSetting.weapon_exp_limit.value[arg_5_0.weaponInfo_.breakthrough + 1] == arg_5_0.weaponInfo_.level and arg_5_0.weaponInfo_.level ~= HeroConst.WEAPON_LV_MAX then
		var_5_0 = GetTips("TIP_BREAK")
	else
		var_5_0 = GetTips("TIP_STRENGTH")
	end

	arg_5_0.weaponstrengthText_.text = var_5_0
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.weaponstrengthBtn_, nil, function()
		if HeroData:GetHeroList()[arg_6_0.heroInfo_.id].weapon_info.level == HeroConst.WEAPON_LV_MAX then
			arg_6_0:Go("/weapon", {
				state = "detail",
				HeroID = arg_6_0.heroInfo_.id
			})

			return
		end

		arg_6_0:Go("/weapon", {
			state = "strength",
			HeroID = arg_6_0.heroInfo_.id
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.servantcontentBtn_, nil, function()
		if not arg_6_0.heroViewProxy_.isSelf then
			return
		end

		local var_8_0 = WeaponServantData:GetWeaponServantList()
		local var_8_1 = HeroCfg[arg_6_0.heroInfo_.id].race
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if WeaponServantCfg[iter_8_1.id].race == var_8_1 then
				table.insert(var_8_2, iter_8_1)
			end
		end

		local var_8_3 = #var_8_2
		local var_8_4 = HeroTools.GetHeroServantInfo(arg_6_0.heroInfo_.id)

		if var_8_4 then
			if arg_6_0:CheckCanEnterServant() then
				arg_6_0:Go("/weaponServant", {
					state = "onlydetail",
					HeroID = arg_6_0.heroInfo_.id,
					id = var_8_4.id
				})
			end
		elseif arg_6_0:CheckCanEnterServant() then
			arg_6_0:Go("/weaponServant", {
				state = "onlydetail",
				HeroID = arg_6_0.heroInfo_.id
			})
		end
	end)
end

function var_0_0.CheckCanEnterServant(arg_9_0)
	local var_9_0 = WeaponServantData:GetWeaponServantList()
	local var_9_1 = HeroCfg[arg_9_0.heroInfo_.id].race
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if WeaponServantCfg[iter_9_1.id].race == var_9_1 then
			table.insert(var_9_2, iter_9_1)
		end
	end

	if #var_9_2 == 0 then
		ShowTips("NO_SERVANT_CAN_BE_EQUIPED")

		return false
	end

	return true
end

function var_0_0.OnServantLock(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.servantInfo_ = HeroTools.GetHeroServantInfo(arg_10_0.heroInfo_.id)
end

function var_0_0.InitUI(arg_11_0)
	arg_11_0:BindCfgUI()

	arg_11_0.servanticonImg_.immediate = true
	arg_11_0.servantRareController_ = ControllerUtil.GetController(arg_11_0.servantGo_.transform, "servantrare")
	arg_11_0.servantController = ControllerUtil.GetController(arg_11_0.servantGo_.transform, "hasservant")
	arg_11_0.btnStatus_ = "MERGE"
end

function var_0_0.RefreshWeapon(arg_12_0)
	arg_12_0.weaponInfo_ = deepClone(arg_12_0.heroViewProxy_:GetHeroWeaponInfo(arg_12_0.heroInfo_.id))

	local var_12_0 = arg_12_0.heroInfo_.id
	local var_12_1, var_12_2 = WeaponTools.AddWeaponExp(arg_12_0.weaponInfo_.exp, arg_12_0.weaponInfo_.breakthrough, 0)

	SetActive(arg_12_0.servantGo_, not arg_12_0.heroViewProxy_.hideServant)

	arg_12_0.nameText_.text = HeroCfg[var_12_0].weapon_name
	arg_12_0.nowlvText_.text = var_12_2
	arg_12_0.toplvText_.text = "/" .. GameSetting.weapon_exp_limit.value[arg_12_0.weaponInfo_.breakthrough + 1] or HeroConst.WEAPON_LV_MAX

	if var_12_2 == HeroConst.WEAPON_LV_MAX then
		arg_12_0:RefreshExpBar(1)

		arg_12_0.expText_.text = "-/-"
	else
		local var_12_3 = GameLevelSetting[var_12_2].weapon_level_exp

		arg_12_0:RefreshExpBar(var_12_1 / var_12_3)

		arg_12_0.expText_.text = var_12_1 .. "/" .. var_12_3
	end

	local var_12_4 = WeaponTools.WeaponAtk(arg_12_0.weaponInfo_.level, arg_12_0.weaponInfo_.breakthrough)
	local var_12_5

	if arg_12_0.servantInfo_.id == 0 or arg_12_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		arg_12_0.atkText_.text = string.format("%d", var_12_4)
	else
		local var_12_6 = WeaponServantCfg[arg_12_0.servantInfo_.id].attrib_addition

		arg_12_0.atkText_.text = string.format("%d<color=#E78300>+%d</color>", var_12_4, var_12_6 * var_12_4 / 100)
	end

	local var_12_7, var_12_8 = SkillTools.GetAttr(HeroCfg[var_12_0].weapon_break_attribute[arg_12_0.weaponInfo_.breakthrough + 1])

	arg_12_0.criText_.text = var_12_8

	arg_12_0:CheckLocked()
end

function var_0_0.CheckLocked(arg_13_0)
	arg_13_0.lockController_:SetSelectedState(tostring(not arg_13_0.heroViewProxy_.isSelf))
end

function var_0_0.RefreshExpBar(arg_14_0, arg_14_1)
	arg_14_0.expSlider_.value = arg_14_1
end

function var_0_0.RefreshServantModel(arg_15_0)
	if not arg_15_0.servantInfo_ or not arg_15_0.servantInfo_.id or arg_15_0.servantInfo_.id == 0 then
		manager.heroRaiseTrack:PlayServantAnim("Fade")

		return
	end

	manager.heroRaiseTrack:PlayServantAnim("Gray")

	if arg_15_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		manager.heroRaiseTrack:SetWeaponServantID(nil)
	else
		manager.heroRaiseTrack:SetWeaponServantID(arg_15_0.servantInfo_.id)
	end
end

function var_0_0.RefreshServant(arg_16_0, arg_16_1)
	arg_16_0.isSelfController_:SetSelectedState(tostring(arg_16_0.heroViewProxy_.isSelf))

	if not arg_16_1 or arg_16_1.id == 0 then
		arg_16_0.servantController:SetSelectedState("false")

		return
	end

	arg_16_0.servantController:SetSelectedState("true")

	local var_16_0 = WeaponServantCfg[arg_16_1.id]

	arg_16_0.servantnameText_.text = ItemTools.getItemName(arg_16_1.id)

	arg_16_0.servantRareController_:SetSelectedState(tostring(var_16_0.starlevel))

	arg_16_0.servanticonImg_.spriteSync = SpritePathCfg.ServantIcon438.path .. arg_16_1.id

	local var_16_1 = WeaponServantCfg[arg_16_1.id].race
	local var_16_2 = string.format("icon_group_%d_c", var_16_1)

	arg_16_0.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", var_16_2)

	local var_16_3 = HeroTools.GetHeroWeaponAddLevel(arg_16_0.heroInfo_)
	local var_16_4 = arg_16_1.stage

	if var_16_3 > 0 then
		arg_16_0.refinetextText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), var_16_4, var_16_3)
	else
		arg_16_0.refinetextText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), var_16_4)
	end
end

function var_0_0.Hide(arg_17_0)
	SetActive(arg_17_0.gameObject_, false)
	HeroTools.StopTalk()
end

function var_0_0.Show(arg_18_0)
	var_0_0.super.Show(arg_18_0)
	SetActive(arg_18_0.gameObject_, true)
	arg_18_0:UpdateView()
end

function var_0_0.CameraEnter(arg_19_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		3,
		0,
		0
	}, arg_19_0.displayGo_)
	arg_19_0:RefreshServantModel()
end

function var_0_0.OnEnter(arg_20_0, arg_20_1)
	arg_20_0.heroViewProxy_ = arg_20_1
end

function var_0_0.Dispose(arg_21_0)
	manager.redPoint:unbindUIandKey(arg_21_0.weaponstrengthTrs_)
	arg_21_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
