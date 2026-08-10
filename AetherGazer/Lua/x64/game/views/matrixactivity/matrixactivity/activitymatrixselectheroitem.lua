local var_0_0 = class("ActivityMatrixSelectHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.weaponController = ControllerUtil.GetController(arg_3_0.transform_, "weapon")
	arg_3_0.astrolabeController = ControllerUtil.GetController(arg_3_0.transform_, "astrolabe")
	arg_3_0.equipController = ControllerUtil.GetController(arg_3_0.transform_, "equip")
	arg_3_0.trialController = ControllerUtil.GetController(arg_3_0.transform_, "trial")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_clickBtn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.index)
		end
	end)
end

function var_0_0.SetStandardData(arg_6_0, arg_6_1)
	arg_6_0.trialController:SetSelectedIndex(1)

	local var_6_0 = HeroStandardSystemCfg[arg_6_1]
	local var_6_1 = TempHeroData:GetTempHeroDataByTempID(arg_6_1)
	local var_6_2 = var_6_0.hero_id
	local var_6_3 = HeroCfg[var_6_2]

	arg_6_0.m_name.text = GetI18NText(var_6_3.name)

	local var_6_4 = var_6_1.using_skin

	arg_6_0.m_img.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[var_6_4].picture_id)

	local var_6_5 = RaceEffectCfg[var_6_3.race]

	arg_6_0.m_raceImg.sprite = getSprite("Atlas/CampItemAtlas", var_6_5.icon)

	local var_6_6 = var_6_1.servantInfo

	if not var_6_6 or var_6_6.id == 0 then
		arg_6_0.weaponController:SetSelectedIndex(0)
	else
		arg_6_0.weaponController:SetSelectedIndex(1)

		arg_6_0.m_weaponImg.sprite = ItemTools.getItemSprite(var_6_6.id)
	end

	local var_6_7 = clone(var_6_1.using_astrolabe)

	table.sort(var_6_7, function(arg_7_0, arg_7_1)
		return arg_7_0 < arg_7_1
	end)

	local var_6_8 = math.min(3, #var_6_7)

	arg_6_0.astrolabeController:SetSelectedIndex(var_6_8)

	for iter_6_0 = 1, var_6_8 do
		local var_6_9 = arg_6_0["m_astrolabe" .. iter_6_0]
		local var_6_10 = var_6_7[iter_6_0]
		local var_6_11 = HeroAstrolabeCfg[var_6_10].hero_astrolabe_suit_id
		local var_6_12 = table.indexof(var_6_3.astrolabe, var_6_11) or 1

		if var_6_12 == 1 then
			var_6_9.sprite = getSprite("Atlas/Common", "icon_yellow_a")
		elseif var_6_12 == 2 then
			var_6_9.sprite = getSprite("Atlas/Common", "icon_red_a")
		elseif var_6_12 == 3 then
			var_6_9.sprite = getSprite("Atlas/Common", "icon_blue_a")
		end
	end

	local var_6_13 = var_6_1.equip_list
	local var_6_14 = HeroTools.GetIsSuitNumCut(var_6_1)
	local var_6_15 = {}

	for iter_6_1, iter_6_2 in pairs(var_6_13) do
		if iter_6_2.equip_id ~= 0 then
			local var_6_16 = EquipCfg[iter_6_2.prefab_id]

			if var_6_15[var_6_16.suit] then
				var_6_15[var_6_16.suit].num = var_6_15[var_6_16.suit].num + 1
			else
				var_6_15[var_6_16.suit] = {
					num = 1,
					id = var_6_16.suit
				}
			end
		end
	end

	local var_6_17 = {}

	for iter_6_3, iter_6_4 in pairs(var_6_15) do
		table.insert(var_6_17, iter_6_4)
	end

	for iter_6_5 = #var_6_17, 1, -1 do
		if var_6_17[iter_6_5].num < EquipTools.GetSuitNeedNum(var_6_17[iter_6_5].id, var_6_14) then
			table.remove(var_6_17, iter_6_5)
		end
	end

	local var_6_18 = math.min(3, #var_6_17)

	arg_6_0.equipController:SetSelectedIndex(var_6_18)

	for iter_6_6 = 1, var_6_18 do
		local var_6_19 = arg_6_0["m_equip" .. iter_6_6]
		local var_6_20 = var_6_17[iter_6_6].id

		var_6_19.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[var_6_20].icon)
	end
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.trialController:SetSelectedIndex(0)

	arg_8_0.heroId = arg_8_1

	local var_8_0 = HeroData:GetHeroData(arg_8_1)
	local var_8_1 = HeroCfg[arg_8_1]

	arg_8_0.m_name.text = GetI18NText(var_8_1.name)

	local var_8_2 = HeroTools.HeroUsingSkinInfo(arg_8_1).id

	arg_8_0.m_img.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[var_8_2].picture_id)

	local var_8_3 = RaceEffectCfg[var_8_1.race]

	arg_8_0.m_raceImg.sprite = getSprite("Atlas/CampItemAtlas", var_8_3.icon)

	local var_8_4 = WeaponServantData:GetServantDataByUID(var_8_0.servant_uid)

	if not var_8_4 then
		arg_8_0.weaponController:SetSelectedIndex(0)
	else
		arg_8_0.weaponController:SetSelectedIndex(1)

		arg_8_0.m_weaponImg.sprite = ItemTools.getItemSprite(var_8_4.id)
	end

	local var_8_5 = clone(var_8_0.using_astrolabe)

	table.sort(var_8_5, function(arg_9_0, arg_9_1)
		return arg_9_0 < arg_9_1
	end)

	local var_8_6 = math.min(3, #var_8_5)

	arg_8_0.astrolabeController:SetSelectedIndex(var_8_6)

	for iter_8_0 = 1, var_8_6 do
		local var_8_7 = arg_8_0["m_astrolabe" .. iter_8_0]
		local var_8_8 = var_8_5[iter_8_0]
		local var_8_9 = HeroAstrolabeCfg[var_8_8].hero_astrolabe_suit_id
		local var_8_10 = table.indexof(var_8_1.astrolabe, var_8_9) or 1

		if var_8_10 == 1 then
			var_8_7.sprite = getSprite("Atlas/Common", "icon_yellow_a")
		elseif var_8_10 == 2 then
			var_8_7.sprite = getSprite("Atlas/Common", "icon_red_a")
		elseif var_8_10 == 3 then
			var_8_7.sprite = getSprite("Atlas/Common", "icon_blue_a")
		end
	end

	local var_8_11 = var_8_0.equip
	local var_8_12 = HeroTools.GetIsSuitNumCut(var_8_0)
	local var_8_13 = EquipTools.CountActiveSuit(var_8_11)

	for iter_8_1 = #var_8_13, 1, -1 do
		if var_8_13[iter_8_1].num < EquipTools.GetSuitNeedNum(var_8_13[iter_8_1].id, var_8_12) then
			table.remove(var_8_13, iter_8_1)
		end
	end

	local var_8_14 = math.min(3, #var_8_13)

	arg_8_0.equipController:SetSelectedIndex(var_8_14)

	for iter_8_2 = 1, var_8_14 do
		local var_8_15 = arg_8_0["m_equip" .. iter_8_2]
		local var_8_16 = var_8_13[iter_8_2].id

		var_8_15.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[var_8_16].icon)
	end
end

function var_0_0.SetIndex(arg_10_0, arg_10_1)
	arg_10_0.index = arg_10_1
end

function var_0_0.SetSelect(arg_11_0, arg_11_1)
	arg_11_0.selectController:SetSelectedIndex(arg_11_0.index == arg_11_1 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_12_0, arg_12_1)
	arg_12_0.clickFunc = arg_12_1
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
