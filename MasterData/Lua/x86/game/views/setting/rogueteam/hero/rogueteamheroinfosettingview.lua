local RogueTeamHeroInfoSettingView = class("RogueTeamHeroInfoSettingView", ReduxView)

function RogueTeamHeroInfoSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		self.showController:SetSelectedIndex(0)
		SetActive(self.gameObject_, arg_1_1)
	end
end

function RogueTeamHeroInfoSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.stageData = arg_2_3

	self:Init()

	local var_2_0, var_2_1, var_2_2, var_2_3 = ChallengeRogueTeamData:GetReserveHeroList()

	self.teamHeroList_ = var_2_0
	self.trialHeroList_ = var_2_3
	self.heroTeamCnt_ = 0

	for iter_2_0 = 3, 1, -1 do
		if var_2_0[iter_2_0] ~= 0 or var_2_3[iter_2_0] ~= 0 then
			self.heroTeamCnt_ = iter_2_0

			break
		end
	end

	self.selectIndex_ = 1

	self:RefreshUI()
end

function RogueTeamHeroInfoSettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueTeamHeroInfoSettingView:InitUI()
	self:BindCfgUI()

	self.hero_list = LuaList.New(handler(self, self.IndexHeroItem), self.m_heroList, RogueTeamSetHeroItem)
	self.servantItem = WeaponServantHeadItem.New(self.m_servant)
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.leaderController = ControllerUtil.GetController(self.transform_, "leader")
	self.showController = ControllerUtil.GetController(self.transform_, "show")
	self.astrolabeItems = {}
	self.skillItems = {}
	self.equipItems = {}

	self.showController:SetSelectedIndex(0)
end

function RogueTeamHeroInfoSettingView:AddUIListener()
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
		self.hero_list:StartScroll(self.heroTeamCnt_)
	end)
	self:AddBtnListener(self.m_mask, nil, function()
		self.showController:SetSelectedIndex(0)
	end)
end

function RogueTeamHeroInfoSettingView:RefreshUI()
	self.showController:SetSelectedIndex(0)

	local var_12_0 = self.teamHeroList_[self.selectIndex_]
	local var_12_1 = self.trialHeroList_[self.selectIndex_]

	self.m_heroName.text = HeroCfg[self.teamHeroList_[self.selectIndex_]].name
	self.m_heroSuffix.text = HeroCfg[self.teamHeroList_[self.selectIndex_]].suffix
	self.m_campImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[self.teamHeroList_[self.selectIndex_]].race].icon)

	local var_12_2
	local var_12_3

	if self.selectIndex_ == 1 then
		self.leaderController:SetSelectedIndex(1)
	else
		self.leaderController:SetSelectedIndex(0)
	end

	local var_12_4

	if var_12_1 ~= 0 then
		var_12_2, var_12_3 = GetVirtualData(var_12_1)
		var_12_4 = var_12_2.using_skin
	else
		local var_12_5 = ChallengeRogueTeamData:GetHeroData(var_12_0, nil, true)

		var_12_2 = var_12_5
		var_12_3 = var_12_5.equip_list or {}
		var_12_4 = ChallengeRogueTeamData:GetHeroUsingSkinInfo(var_12_0).id
	end

	self.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", var_12_4)

	local var_12_6 = 1

	self.using_astrolabe = var_12_2.using_astrolabe

	for iter_12_0, iter_12_1 in ipairs(self.using_astrolabe) do
		if iter_12_1 and iter_12_1 ~= 0 then
			self.astrolabeItems[var_12_6] = self.astrolabeItems[var_12_6] or RogueTeamSetAstrolabeItem.New((Object.Instantiate(self.m_astrolabeItem, self.m_astrolabeContent)))

			self.astrolabeItems[var_12_6]:SetActive(true)
			self.astrolabeItems[var_12_6]:SetData(iter_12_1, var_12_0, var_12_1)

			var_12_6 = var_12_6 + 1
		end
	end

	for iter_12_2 = var_12_6, #self.astrolabeItems do
		self.astrolabeItems[iter_12_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_astrolabeContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_astrolabeContent)

	self.suitList = self:GetEquipSuit(var_12_2, var_12_3)

	local var_12_7 = 1

	for iter_12_3, iter_12_4 in ipairs(self.suitList) do
		self.equipItems[var_12_7] = self.equipItems[var_12_7] or RogueTeamSetEquipItem.New((Object.Instantiate(self.m_equipItem, self.m_equipContent)))

		self.equipItems[var_12_7]:SetActive(true)
		self.equipItems[var_12_7]:SetData(iter_12_4.id)

		var_12_7 = var_12_7 + 1
	end

	for iter_12_5 = var_12_7, #self.equipItems do
		self.equipItems[iter_12_5]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_equipContent)

	if var_12_2.servantInfo then
		self.servant_id = var_12_2.servantInfo.id or 0
	end

	if var_12_2.servantInfo then
		self.servant_level = var_12_2.servantInfo.stage or 1
	end

	self.servantItem:OnRender({
		id = self.servant_id
	})
	self.servantItem:RenderEquipStatus(false)
	self.servantItem:ShowLock(false)

	self.m_servantCamp.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", WeaponServantCfg[self.servant_id].race))
	self.m_servantName.text = ItemTools.getItemName(self.servant_id)
	self.m_servantDes.text = GetCfgDescription(WeaponEffectCfg[WeaponServantCfg[self.servant_id].effect[1]].description[1], self.servant_level + HeroTools.GetHeroWeaponAddLevel(var_12_2))

	local var_12_8 = {}

	for iter_12_6, iter_12_7 in ipairs(ChallengeRogueTeamData:GetHeroData(var_12_0, nil, true).skill) do
		var_12_8[iter_12_7.skill_id] = iter_12_7.skill_level
	end

	self.skillList_ = {}

	for iter_12_8, iter_12_9 in ipairs(HeroCfg[var_12_0].skills) do
		table.insert(self.skillList_, {
			isCanUp = false,
			addSkillLv = 0,
			id = iter_12_9,
			heroId = var_12_0,
			lv = var_12_8[iter_12_9]
		})
	end

	if var_12_1 == 0 then
		self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM)
	else
		self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)

		self.heroViewProxy_:SetTempHeroList({
			var_12_1
		})
	end

	local var_12_9 = self.heroViewProxy_:GetHeroSkillInfo(var_12_0)

	for iter_12_10, iter_12_11 in ipairs(var_12_9) do
		self.skillItems[iter_12_10] = self.skillItems[iter_12_10] or RogueTeamSetSkillItem.New((Object.Instantiate(self.m_skillItem, self.m_skillContent)))

		self.skillItems[iter_12_10]:SetActive(true)
		self.skillItems[iter_12_10]:SetData(self.heroViewProxy_, iter_12_11)
	end

	for iter_12_12 = #self.skillItems, #var_12_9 + 1, -1 do
		self.skillItems[var_12_7]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_skillContent)
end

function RogueTeamHeroInfoSettingView:GetEquipSuit(arg_13_1, arg_13_2)
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

function RogueTeamHeroInfoSettingView:IndexHeroItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.teamHeroList_[arg_14_1], self.trialHeroList_[arg_14_1], arg_14_1)
	arg_14_2:RegistCallBack(function(arg_15_0)
		self:OnHeroClick(arg_15_0)
	end)
end

function RogueTeamHeroInfoSettingView:OnHeroClick(arg_16_1)
	self.selectIndex_ = arg_16_1

	self:RefreshUI()
	self.showController:SetSelectedIndex(0)
end

function RogueTeamHeroInfoSettingView:Dispose()
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

	RogueTeamHeroInfoSettingView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return RogueTeamHeroInfoSettingView
