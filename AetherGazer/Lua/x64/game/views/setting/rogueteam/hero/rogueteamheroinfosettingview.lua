local var_0_0 = class("RogueTeamHeroInfoSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		arg_1_0.showController:SetSelectedIndex(0)
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.stageData = arg_2_3

	arg_2_0:Init()

	local var_2_0, var_2_1, var_2_2, var_2_3 = ChallengeRogueTeamData:GetReserveHeroList()

	arg_2_0.teamHeroList_ = var_2_0
	arg_2_0.trialHeroList_ = var_2_3
	arg_2_0.heroTeamCnt_ = 0

	for iter_2_0 = 3, 1, -1 do
		if var_2_0[iter_2_0] ~= 0 or var_2_3[iter_2_0] ~= 0 then
			arg_2_0.heroTeamCnt_ = iter_2_0

			break
		end
	end

	arg_2_0.selectIndex_ = 1

	arg_2_0:RefreshUI()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.hero_list = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.m_heroList, RogueTeamSetHeroItem)
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
		arg_5_0.hero_list:StartScroll(arg_5_0.heroTeamCnt_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0.showController:SetSelectedIndex(0)
	end)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.showController:SetSelectedIndex(0)

	local var_12_0 = arg_12_0.teamHeroList_[arg_12_0.selectIndex_]
	local var_12_1 = arg_12_0.trialHeroList_[arg_12_0.selectIndex_]
	local var_12_2 = HeroCfg[var_12_0]

	arg_12_0.m_heroName.text = var_12_2.name
	arg_12_0.m_heroSuffix.text = var_12_2.suffix

	local var_12_3 = RaceEffectCfg[var_12_2.race]

	arg_12_0.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", var_12_3.icon)

	local var_12_4
	local var_12_5

	if arg_12_0.selectIndex_ == 1 then
		arg_12_0.leaderController:SetSelectedIndex(1)
	else
		arg_12_0.leaderController:SetSelectedIndex(0)
	end

	local var_12_6

	if var_12_1 ~= 0 then
		var_12_4, var_12_5 = GetVirtualData(var_12_1)
		var_12_6 = var_12_4.using_skin
	else
		local var_12_7 = ChallengeRogueTeamData:GetHeroData(var_12_0, nil, true)

		var_12_4 = var_12_7
		var_12_5 = var_12_7.equip_list or {}
		var_12_6 = ChallengeRogueTeamData:GetHeroUsingSkinInfo(var_12_0).id
	end

	arg_12_0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", var_12_6)

	local var_12_8 = 1

	arg_12_0.using_astrolabe = var_12_4.using_astrolabe

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.using_astrolabe) do
		if iter_12_1 and iter_12_1 ~= 0 then
			if not arg_12_0.astrolabeItems[var_12_8] then
				local var_12_9 = Object.Instantiate(arg_12_0.m_astrolabeItem, arg_12_0.m_astrolabeContent)

				arg_12_0.astrolabeItems[var_12_8] = RogueTeamSetAstrolabeItem.New(var_12_9)
			end

			arg_12_0.astrolabeItems[var_12_8]:SetActive(true)
			arg_12_0.astrolabeItems[var_12_8]:SetData(iter_12_1, var_12_0, var_12_1)

			var_12_8 = var_12_8 + 1
		end
	end

	local var_12_10 = #arg_12_0.astrolabeItems

	for iter_12_2 = var_12_8, var_12_10 do
		arg_12_0.astrolabeItems[iter_12_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_astrolabeContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_astrolabeContent)

	arg_12_0.suitList = arg_12_0:GetEquipSuit(var_12_4, var_12_5)

	local var_12_11 = 1

	for iter_12_3, iter_12_4 in ipairs(arg_12_0.suitList) do
		local var_12_12 = iter_12_4.id

		if not arg_12_0.equipItems[var_12_11] then
			local var_12_13 = Object.Instantiate(arg_12_0.m_equipItem, arg_12_0.m_equipContent)

			arg_12_0.equipItems[var_12_11] = RogueTeamSetEquipItem.New(var_12_13)
		end

		arg_12_0.equipItems[var_12_11]:SetActive(true)
		arg_12_0.equipItems[var_12_11]:SetData(var_12_12)

		var_12_11 = var_12_11 + 1
	end

	local var_12_14 = #arg_12_0.equipItems

	for iter_12_5 = var_12_11, var_12_14 do
		arg_12_0.equipItems[iter_12_5]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.m_equipContent)

	arg_12_0.servant_id = var_12_4.servantInfo and var_12_4.servantInfo.id or 0
	arg_12_0.servant_level = var_12_4.servantInfo and var_12_4.servantInfo.stage or 1

	arg_12_0.servantItem:OnRender({
		id = arg_12_0.servant_id
	})
	arg_12_0.servantItem:RenderEquipStatus(false)
	arg_12_0.servantItem:ShowLock(false)

	local var_12_15 = WeaponServantCfg[arg_12_0.servant_id]
	local var_12_16 = var_12_15.effect[1]
	local var_12_17 = WeaponEffectCfg[var_12_16].description[1]
	local var_12_18 = HeroTools.GetHeroWeaponAddLevel(var_12_4)
	local var_12_19 = GetCfgDescription(var_12_17, arg_12_0.servant_level + var_12_18)
	local var_12_20 = var_12_15.race

	arg_12_0.m_servantCamp.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", var_12_20))
	arg_12_0.m_servantName.text = ItemTools.getItemName(arg_12_0.servant_id)
	arg_12_0.m_servantDes.text = var_12_19

	local var_12_21 = ChallengeRogueTeamData:GetHeroData(var_12_0, nil, true)
	local var_12_22 = {}

	for iter_12_6, iter_12_7 in ipairs(var_12_21.skill) do
		var_12_22[iter_12_7.skill_id] = iter_12_7.skill_level
	end

	arg_12_0.skillList_ = {}

	for iter_12_8, iter_12_9 in ipairs(HeroCfg[var_12_0].skills) do
		table.insert(arg_12_0.skillList_, {
			isCanUp = false,
			addSkillLv = 0,
			id = iter_12_9,
			heroId = var_12_0,
			lv = var_12_22[iter_12_9]
		})
	end

	if var_12_1 == 0 then
		arg_12_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM)
	else
		arg_12_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)

		arg_12_0.heroViewProxy_:SetTempHeroList({
			var_12_1
		})
	end

	local var_12_23 = arg_12_0.heroViewProxy_:GetHeroSkillInfo(var_12_0)

	for iter_12_10, iter_12_11 in ipairs(var_12_23) do
		if not arg_12_0.skillItems[iter_12_10] then
			local var_12_24 = Object.Instantiate(arg_12_0.m_skillItem, arg_12_0.m_skillContent)

			arg_12_0.skillItems[iter_12_10] = RogueTeamSetSkillItem.New(var_12_24)
		end

		arg_12_0.skillItems[iter_12_10]:SetActive(true)
		arg_12_0.skillItems[iter_12_10]:SetData(arg_12_0.heroViewProxy_, iter_12_11)
	end

	for iter_12_12 = #arg_12_0.skillItems, #var_12_23 + 1, -1 do
		arg_12_0.skillItems[var_12_11]:SetActive(false)
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
	local var_14_0 = arg_14_0.teamHeroList_[arg_14_1]
	local var_14_1 = arg_14_0.trialHeroList_[arg_14_1]

	arg_14_2:SetData(var_14_0, var_14_1, arg_14_1)
	arg_14_2:RegistCallBack(function(arg_15_0)
		arg_14_0:OnHeroClick(arg_15_0)
	end)
end

function var_0_0.OnHeroClick(arg_16_0, arg_16_1)
	arg_16_0.selectIndex_ = arg_16_1

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
