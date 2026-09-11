local PolyhedronHeroInfoSettingView = class("PolyhedronHeroInfoSettingView", ReduxView)

function PolyhedronHeroInfoSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function PolyhedronHeroInfoSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.stageData = arg_2_3

	self:Init()

	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	self.fight_hero_id_list = self.polyhedronInfo:GetFightHeroList()
	self.selectHeroId = self.fight_hero_id_list[1]

	self:RefreshUI()
end

function PolyhedronHeroInfoSettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronHeroInfoSettingView:InitUI()
	self:BindCfgUI()

	self.hero_list = LuaList.New(handler(self, self.IndexHeroItem), self.m_heroList, PolyhedronSetHeroItem)
	self.servantItem = WeaponServantHeadItem.New(self.m_servant)
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.leaderController = ControllerUtil.GetController(self.transform_, "leader")
	self.showController = ControllerUtil.GetController(self.transform_, "show")
	self.astrolabeItems = {}
	self.skillItems = {}
	self.equipItems = {}

	self.showController:SetSelectedIndex(0)
end

function PolyhedronHeroInfoSettingView:AddUIListener()
	self:AddBtnListener(self.m_skillBtn, nil, function()
		self.selectController:SetSelectedIndex(0)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.m_weaponBtn, nil, function()
		self.selectController:SetSelectedIndex(1)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.m_equipBtn, nil, function()
		self.selectController:SetSelectedIndex(2)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.m_astrolabeBtn, nil, function()
		self.selectController:SetSelectedIndex(3)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.m_heroBtn, nil, function()
		self.showController:SetSelectedIndex(1)

		self.heroList = {}
		self.fight_hero_id_list = self.polyhedronInfo:GetHeroList()

		for iter_10_0, iter_10_1 in ipairs(self.fight_hero_id_list) do
			if iter_10_1 ~= self.selectHeroId then
				table.insert(self.heroList, iter_10_1)
			end
		end

		self.hero_list:StartScroll(#self.heroList)
	end)
	self:AddBtnListener(self.m_mask, nil, function()
		self.showController:SetSelectedIndex(0)
	end)
end

function PolyhedronHeroInfoSettingView:RefreshUI()
	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	local var_12_0 = self.selectHeroId

	self.m_heroName.text = HeroCfg[self.selectHeroId].name
	self.m_heroSuffix.text = HeroCfg[self.selectHeroId].suffix
	self.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[self.selectHeroId].race].icon)

	local var_12_1
	local var_12_2

	if var_12_0 == self.polyhedronInfo:GetLeaderHeroId() then
		var_12_1, var_12_2 = self.polyhedronInfo:GetPolyhedronLeader():GetVirtualData()

		self.leaderController:SetSelectedIndex(1)
	else
		var_12_1, var_12_2 = GetVirtualData(PolyhedronHeroCfg[self.selectHeroId].standard_id)

		self.leaderController:SetSelectedIndex(0)
	end

	self.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", PolyhedronData:GetHeroUsingSkinInfo(var_12_0).id)

	local var_12_3 = 1

	self.using_astrolabe = var_12_1.using_astrolabe

	for iter_12_0, iter_12_1 in ipairs(self.using_astrolabe) do
		if iter_12_1 and iter_12_1 ~= 0 then
			self.astrolabeItems[var_12_3] = self.astrolabeItems[var_12_3] or PolyhedronSetAstrolabeItem.New((Object.Instantiate(self.m_astrolabeItem, self.m_astrolabeContent)))

			self.astrolabeItems[var_12_3]:SetActive(true)
			self.astrolabeItems[var_12_3]:SetData(iter_12_1)

			var_12_3 = var_12_3 + 1
		end
	end

	for iter_12_2 = var_12_3, #self.astrolabeItems do
		self.astrolabeItems[iter_12_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_astrolabeContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_astrolabeContent)

	self.suitList = self:GetEquipSuit(var_12_1, var_12_2)

	local var_12_4 = 1

	for iter_12_3, iter_12_4 in ipairs(self.suitList) do
		self.equipItems[var_12_4] = self.equipItems[var_12_4] or PolyhedronSetEquipItem.New((Object.Instantiate(self.m_equipItem, self.m_equipContent)))

		self.equipItems[var_12_4]:SetActive(true)
		self.equipItems[var_12_4]:SetData(iter_12_4.id)

		var_12_4 = var_12_4 + 1
	end

	for iter_12_5 = var_12_4, #self.equipItems do
		self.equipItems[iter_12_5]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_equipContent)

	if var_12_1.servantInfo then
		self.servant_id = var_12_1.servantInfo.id or 0
	end

	if var_12_1.servantInfo then
		self.servant_level = var_12_1.servantInfo.stage or 1
	end

	self.servantItem:OnRender({
		id = self.servant_id
	})
	self.servantItem:RenderEquipStatus(false)
	self.servantItem:ShowLock(false)

	self.m_servantCamp.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", WeaponServantCfg[self.servant_id].race))
	self.m_servantName.text = ItemTools.getItemName(self.servant_id)
	self.m_servantDes.text = GetCfgDescription(WeaponEffectCfg[WeaponServantCfg[self.servant_id].effect[1]].description[1], self.servant_level + HeroTools.GetHeroWeaponAddLevel(var_12_1))

	local var_12_5 = {}

	for iter_12_6, iter_12_7 in ipairs(TempHeroData:GetTempHeroDataByTempID(PolyhedronHeroCfg[var_12_0].standard_id).skill) do
		var_12_5[iter_12_7.skill_id] = iter_12_7.skill_level
	end

	self.skillList_ = {}

	for iter_12_8, iter_12_9 in ipairs(HeroCfg[var_12_0].skills) do
		table.insert(self.skillList_, {
			isCanUp = false,
			addSkillLv = 0,
			id = iter_12_9,
			heroId = var_12_0,
			lv = var_12_5[iter_12_9]
		})
	end

	local var_12_6 = 1

	for iter_12_10, iter_12_11 in ipairs(self.skillList_) do
		self.skillItems[var_12_6] = self.skillItems[var_12_6] or PolyhedronSetSkillItem.New((Object.Instantiate(self.m_skillItem, self.m_skillContent)))

		self.skillItems[var_12_6]:SetActive(true)
		self.skillItems[var_12_6]:SetData(iter_12_11)

		var_12_6 = var_12_6 + 1
	end

	for iter_12_12 = var_12_6, #self.skillItems do
		self.skillItems[iter_12_12]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_skillContent)
end

function PolyhedronHeroInfoSettingView:GetEquipSuit(arg_13_1, arg_13_2)
	local var_13_0 = HeroTools.GetIsSuitNumCut(arg_13_1)
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_2) do
		if iter_13_1.equip_id ~= 0 then
			if var_13_1[EquipCfg[iter_13_1.prefab_id].suit] then
				var_13_1[EquipCfg[iter_13_1.prefab_id].suit].num = var_13_1[EquipCfg[iter_13_1.prefab_id].suit].num + 1
			else
				var_13_1[EquipCfg[iter_13_1.prefab_id].suit] = {
					num = 1,
					id = EquipCfg[iter_13_1.prefab_id].suit
				}
			end
		end
	end

	local var_13_2 = {}

	for iter_13_2, iter_13_3 in pairs(var_13_1) do
		table.insert(var_13_2, iter_13_3)
	end

	for iter_13_4 = #var_13_2, 1, -1 do
		if var_13_2[iter_13_4].num < EquipTools.GetSuitNeedNum(var_13_2[iter_13_4].id, var_13_0) then
			table.remove(var_13_2, iter_13_4)
		end
	end

	return var_13_2
end

function PolyhedronHeroInfoSettingView:IndexHeroItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.polyhedronInfo, self.heroList[arg_14_1])
	arg_14_2:RegistCallBack(function(arg_15_0)
		self:OnHeroClick(arg_15_0)
	end)
end

function PolyhedronHeroInfoSettingView:OnHeroClick(arg_16_1)
	self.selectHeroId = arg_16_1

	self:RefreshUI()
	self.showController:SetSelectedIndex(0)
end

function PolyhedronHeroInfoSettingView:Dispose()
	self.hero_list:Dispose()
	self.servantItem:Dispose()

	for iter_17_0, iter_17_1 in ipairs(self.astrolabeItems) do
		iter_17_1:Dispose()
	end

	self.astrolabeItems = {}

	for iter_17_2, iter_17_3 in ipairs(self.skillItems) do
		iter_17_3:Dispose()
	end

	self.skillItems = {}

	for iter_17_4, iter_17_5 in ipairs(self.equipItems) do
		iter_17_5:Dispose()
	end

	self.equipItems = {}

	PolyhedronHeroInfoSettingView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return PolyhedronHeroInfoSettingView
