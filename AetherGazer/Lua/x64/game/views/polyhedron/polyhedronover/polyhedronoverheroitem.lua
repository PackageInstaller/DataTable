local var_0_0 = class("PolyhedronOverHeroItem", ReduxView)

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

	arg_3_0.leaderController = ControllerUtil.GetController(arg_3_0.transform_, "leader")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_servantBtn, nil, function()
		local var_5_0 = arg_4_0.m_servantGo.transform.position

		if arg_4_0.servant_id == 0 then
			return
		end

		local var_5_1 = ItemTools.getItemName(arg_4_0.servant_id)
		local var_5_2 = WeaponServantCfg[arg_4_0.servant_id].effect[1]
		local var_5_3 = WeaponEffectCfg[var_5_2].simple_description

		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(var_5_1, var_5_3, Vector3(0, var_5_0.y + 0.1, var_5_0.z))
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_astrolabeBtn1, nil, function()
		local var_6_0 = arg_4_0.m_astrolabeGo1.transform.position
		local var_6_1 = arg_4_0.using_astrolabe[1]
		local var_6_2 = AstrolabeEffectCfg[var_6_1].desc[1]
		local var_6_3 = GetCfgDescription(var_6_2, 1)
		local var_6_4 = HeroAstrolabeCfg[var_6_1]

		arg_4_0.clickFunc(var_6_4.name, var_6_3, Vector3(0, var_6_0.y, var_6_0.z))
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_astrolabeBtn2, nil, function()
		local var_7_0 = arg_4_0.m_astrolabeGo2.transform.position
		local var_7_1 = arg_4_0.using_astrolabe[2]
		local var_7_2 = AstrolabeEffectCfg[var_7_1].desc[1]
		local var_7_3 = GetCfgDescription(var_7_2, 1)
		local var_7_4 = HeroAstrolabeCfg[var_7_1]

		arg_4_0.clickFunc(var_7_4.name, var_7_3, Vector3(0, var_7_0.y, var_7_0.z))
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_astrolabeBtn3, nil, function()
		local var_8_0 = arg_4_0.m_astrolabeGo3.transform.position
		local var_8_1 = arg_4_0.using_astrolabe[3]
		local var_8_2 = AstrolabeEffectCfg[var_8_1].desc[1]
		local var_8_3 = GetCfgDescription(var_8_2, 1)
		local var_8_4 = HeroAstrolabeCfg[var_8_1]

		arg_4_0.clickFunc(var_8_4.name, var_8_3, Vector3(0, var_8_0.y, var_8_0.z))
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_equipBtn1, nil, function()
		local var_9_0 = arg_4_0.m_equipGo1.transform.position

		if arg_4_0.suitList[1] then
			local var_9_1 = arg_4_0.suitList[1].id
			local var_9_2 = EquipSuitCfg[var_9_1]

			arg_4_0.clickFunc(var_9_2.name, EquipTools.GetEffectDesc(var_9_2.suit_effect[1]), Vector3(0, var_9_0.y, var_9_0.z))
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_equipBtn2, nil, function()
		local var_10_0 = arg_4_0.m_equipGo2.transform.position

		if arg_4_0.suitList[2] then
			local var_10_1 = arg_4_0.suitList[2].id
			local var_10_2 = EquipSuitCfg[var_10_1]

			arg_4_0.clickFunc(var_10_2.name, EquipTools.GetEffectDesc(var_10_2.suit_effect[1]), Vector3(0, var_10_0.y, var_10_0.z))
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_equipBtn3, nil, function()
		local var_11_0 = arg_4_0.m_equipGo3.transform.position

		if arg_4_0.suitList[3] then
			local var_11_1 = arg_4_0.suitList[3].id
			local var_11_2 = EquipSuitCfg[var_11_1]

			arg_4_0.clickFunc(var_11_2.name, EquipTools.GetEffectDesc(var_11_2.suit_effect[1]), Vector3(0, var_11_0.y, var_11_0.z))
		end
	end)
end

function var_0_0.SetData(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:GetLeaderHeroId()
	local var_12_1 = PolyhedronHeroCfg[arg_12_2]
	local var_12_2
	local var_12_3

	if arg_12_2 == var_12_0 then
		var_12_2, var_12_3 = arg_12_1:GetPolyhedronLeader():GetVirtualData()

		arg_12_0.leaderController:SetSelectedIndex(1)
	else
		var_12_2, var_12_3 = GetVirtualData(var_12_1.standard_id)

		arg_12_0.leaderController:SetSelectedIndex(0)
	end

	local var_12_4 = PolyhedronData:GetHeroUsingSkinInfo(arg_12_2).id

	arg_12_0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", var_12_4)
	arg_12_0.using_astrolabe = var_12_2.using_astrolabe

	for iter_12_0 = 1, 3 do
		local var_12_5 = arg_12_0["m_astrolabeGo" .. iter_12_0]
		local var_12_6 = arg_12_0["m_astrolabeIcon" .. iter_12_0]
		local var_12_7 = arg_12_0.using_astrolabe[iter_12_0]

		if var_12_7 and var_12_7 ~= 0 then
			SetActive(var_12_5, true)

			local var_12_8 = HeroAstrolabeCfg[var_12_7].hero_astrolabe_suit_id % 10

			if var_12_8 == 1 then
				var_12_6.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00097")
			elseif var_12_8 == 2 then
				var_12_6.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00098")
			else
				var_12_6.sprite = getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00096")
			end
		else
			SetActive(var_12_5, false)
		end
	end

	arg_12_0.suitList = arg_12_0:GetEquipSuit(var_12_2, var_12_3)

	for iter_12_1 = 1, 3 do
		local var_12_9 = arg_12_0["m_equipGo" .. iter_12_1]
		local var_12_10 = arg_12_0["m_equipIcon" .. iter_12_1]
		local var_12_11 = arg_12_0.suitList[iter_12_1] and arg_12_0.suitList[iter_12_1].id

		if var_12_11 and var_12_11 ~= 0 then
			SetActive(var_12_9, true)

			var_12_10.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[var_12_11].icon)
		else
			SetActive(var_12_9, false)
		end
	end

	arg_12_0.servant_id = var_12_2.servantInfo and var_12_2.servantInfo.id or 0
	arg_12_0.servant_level = var_12_2.servantInfo and var_12_2.servantInfo.stage or 1

	if arg_12_0.servant_id == 0 then
		SetActive(arg_12_0.m_servantGo, false)
	else
		SetActive(arg_12_0.m_servantGo, true)

		arg_12_0.m_servantIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon438x238/" .. arg_12_0.servant_id)
	end
end

function var_0_0.GetEquipSuit(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2
	local var_13_1 = HeroTools.GetIsSuitNumCut(arg_13_1)
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.equip_id ~= 0 then
			local var_13_3 = EquipCfg[iter_13_1.prefab_id]

			if var_13_2[var_13_3.suit] then
				var_13_2[var_13_3.suit].num = var_13_2[var_13_3.suit].num + 1
			else
				var_13_2[var_13_3.suit] = {
					num = 1,
					id = var_13_3.suit
				}
			end
		end
	end

	local var_13_4 = {}

	for iter_13_2, iter_13_3 in pairs(var_13_2) do
		table.insert(var_13_4, iter_13_3)
	end

	for iter_13_4 = #var_13_4, 1, -1 do
		if var_13_4[iter_13_4].num < EquipTools.GetSuitNeedNum(var_13_4[iter_13_4].id, var_13_1) then
			table.remove(var_13_4, iter_13_4)
		end
	end

	return var_13_4
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.RegistCallBack(arg_15_0, arg_15_1)
	arg_15_0.clickFunc = arg_15_1
end

return var_0_0
