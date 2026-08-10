local var_0_0 = class("PolyhedronHeroInfoSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.stageData = arg_2_3

	arg_2_0:Init()

	arg_2_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	arg_2_0.fight_hero_id_list = arg_2_0.polyhedronInfo:GetFightHeroList()
	arg_2_0.selectHeroId = arg_2_0.fight_hero_id_list[1]

	arg_2_0:RefreshUI()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.hero_list = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.m_heroList, PolyhedronSetHeroItem)
	arg_4_0.servantItem = WeaponServantHeadItem.New(arg_4_0.m_servant)
	arg_4_0.selectController = ControllerUtil.GetController(arg_4_0.transform_, "select")
	arg_4_0.leaderController = ControllerUtil.GetController(arg_4_0.transform_, "leader")
	arg_4_0.showController = ControllerUtil.GetController(arg_4_0.transform_, "show")
	arg_4_0.astrolabeItems = {}
	arg_4_0.skillItems = {}
	arg_4_0.equipItems = {}

	arg_4_0.showController:SetSelectedIndex(0)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_skillBtn, nil, function()
		arg_5_0.selectController:SetSelectedIndex(0)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_weaponBtn, nil, function()
		arg_5_0.selectController:SetSelectedIndex(1)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_equipBtn, nil, function()
		arg_5_0.selectController:SetSelectedIndex(2)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_astrolabeBtn, nil, function()
		arg_5_0.selectController:SetSelectedIndex(3)
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_heroBtn, nil, function()
		arg_5_0.showController:SetSelectedIndex(1)

		arg_5_0.heroList = {}
		arg_5_0.fight_hero_id_list = arg_5_0.polyhedronInfo:GetHeroList()

		for iter_10_0, iter_10_1 in ipairs(arg_5_0.fight_hero_id_list) do
			if iter_10_1 ~= arg_5_0.selectHeroId then
				table.insert(arg_5_0.heroList, iter_10_1)
			end
		end

		arg_5_0.hero_list:StartScroll(#arg_5_0.heroList)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0.showController:SetSelectedIndex(0)
	end)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	local var_12_0 = arg_12_0.selectHeroId
	local var_12_1 = HeroCfg[var_12_0]

	arg_12_0.m_heroName.text = var_12_1.name
	arg_12_0.m_heroSuffix.text = var_12_1.suffix

	local var_12_2 = RaceEffectCfg[var_12_1.race]

	arg_12_0.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", var_12_2.icon)

	local var_12_3 = arg_12_0.polyhedronInfo:GetLeaderHeroId()
	local var_12_4 = arg_12_0.polyhedronInfo:GetPolyhedronLeader()
	local var_12_5 = PolyhedronHeroCfg[arg_12_0.selectHeroId]
	local var_12_6
	local var_12_7

	if var_12_0 == var_12_3 then
		var_12_6, var_12_7 = var_12_4:GetVirtualData()

		arg_12_0.leaderController:SetSelectedIndex(1)
	else
		var_12_6, var_12_7 = GetVirtualData(var_12_5.standard_id)

		arg_12_0.leaderController:SetSelectedIndex(0)
	end

	local var_12_8 = PolyhedronData:GetHeroUsingSkinInfo(var_12_0).id

	arg_12_0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", var_12_8)

	local var_12_9 = 1

	arg_12_0.using_astrolabe = var_12_6.using_astrolabe

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.using_astrolabe) do
		if iter_12_1 and iter_12_1 ~= 0 then
			if not arg_12_0.astrolabeItems[var_12_9] then
				local var_12_10 = Object.Instantiate(arg_12_0.m_astrolabeItem, arg_12_0.m_astrolabeContent)

				arg_12_0.astrolabeItems[var_12_9] = PolyhedronSetAstrolabeItem.New(var_12_10)
			end

			arg_12_0.astrolabeItems[var_12_9]:SetActive(true)
			arg_12_0.astrolabeItems[var_12_9]:SetData(iter_12_1)

			var_12_9 = var_12_9 + 1
		end
	end

	local var_12_11 = #arg_12_0.astrolabeItems

	for iter_12_2 = var_12_9, var_12_11 do
		arg_12_0.astrolabeItems[iter_12_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_astrolabeContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_astrolabeContent)

	arg_12_0.suitList = arg_12_0:GetEquipSuit(var_12_6, var_12_7)

	local var_12_12 = 1

	for iter_12_3, iter_12_4 in ipairs(arg_12_0.suitList) do
		local var_12_13 = iter_12_4.id

		if not arg_12_0.equipItems[var_12_12] then
			local var_12_14 = Object.Instantiate(arg_12_0.m_equipItem, arg_12_0.m_equipContent)

			arg_12_0.equipItems[var_12_12] = PolyhedronSetEquipItem.New(var_12_14)
		end

		arg_12_0.equipItems[var_12_12]:SetActive(true)
		arg_12_0.equipItems[var_12_12]:SetData(var_12_13)

		var_12_12 = var_12_12 + 1
	end

	local var_12_15 = #arg_12_0.equipItems

	for iter_12_5 = var_12_12, var_12_15 do
		arg_12_0.equipItems[iter_12_5]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_equipContent)

	arg_12_0.servant_id = var_12_6.servantInfo and var_12_6.servantInfo.id or 0
	arg_12_0.servant_level = var_12_6.servantInfo and var_12_6.servantInfo.stage or 1

	arg_12_0.servantItem:OnRender({
		id = arg_12_0.servant_id
	})
	arg_12_0.servantItem:RenderEquipStatus(false)
	arg_12_0.servantItem:ShowLock(false)

	local var_12_16 = WeaponServantCfg[arg_12_0.servant_id]
	local var_12_17 = var_12_16.effect[1]
	local var_12_18 = WeaponEffectCfg[var_12_17].description[1]
	local var_12_19 = HeroTools.GetHeroWeaponAddLevel(var_12_6)
	local var_12_20 = GetCfgDescription(var_12_18, arg_12_0.servant_level + var_12_19)
	local var_12_21 = var_12_16.race

	arg_12_0.m_servantCamp.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", var_12_21))
	arg_12_0.m_servantName.text = ItemTools.getItemName(arg_12_0.servant_id)
	arg_12_0.m_servantDes.text = var_12_20

	local var_12_22 = PolyhedronHeroCfg[var_12_0]
	local var_12_23 = TempHeroData:GetTempHeroDataByTempID(var_12_22.standard_id)
	local var_12_24 = {}

	for iter_12_6, iter_12_7 in ipairs(var_12_23.skill) do
		var_12_24[iter_12_7.skill_id] = iter_12_7.skill_level
	end

	arg_12_0.skillList_ = {}

	for iter_12_8, iter_12_9 in ipairs(HeroCfg[var_12_0].skills) do
		table.insert(arg_12_0.skillList_, {
			isCanUp = false,
			addSkillLv = 0,
			id = iter_12_9,
			heroId = var_12_0,
			lv = var_12_24[iter_12_9]
		})
	end

	local var_12_25 = 1

	for iter_12_10, iter_12_11 in ipairs(arg_12_0.skillList_) do
		if not arg_12_0.skillItems[var_12_25] then
			local var_12_26 = Object.Instantiate(arg_12_0.m_skillItem, arg_12_0.m_skillContent)

			arg_12_0.skillItems[var_12_25] = PolyhedronSetSkillItem.New(var_12_26)
		end

		arg_12_0.skillItems[var_12_25]:SetActive(true)
		arg_12_0.skillItems[var_12_25]:SetData(iter_12_11)

		var_12_25 = var_12_25 + 1
	end

	local var_12_27 = #arg_12_0.skillItems

	for iter_12_12 = var_12_25, var_12_27 do
		arg_12_0.skillItems[iter_12_12]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_skillContent)
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

function var_0_0.IndexHeroItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.heroList[arg_14_1]

	arg_14_2:SetData(arg_14_0.polyhedronInfo, var_14_0)
	arg_14_2:RegistCallBack(function(arg_15_0)
		arg_14_0:OnHeroClick(arg_15_0)
	end)
end

function var_0_0.OnHeroClick(arg_16_0, arg_16_1)
	arg_16_0.selectHeroId = arg_16_1

	arg_16_0:RefreshUI()
	arg_16_0.showController:SetSelectedIndex(0)
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.hero_list:Dispose()
	arg_17_0.servantItem:Dispose()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.astrolabeItems) do
		iter_17_1:Dispose()
	end

	arg_17_0.astrolabeItems = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.skillItems) do
		iter_17_3:Dispose()
	end

	arg_17_0.skillItems = {}

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.equipItems) do
		iter_17_5:Dispose()
	end

	arg_17_0.equipItems = {}

	var_0_0.super.Dispose(arg_17_0)

	arg_17_0.transform_ = nil
	arg_17_0.gameObject_ = nil
end

return var_0_0
