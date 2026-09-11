local PolyhedronOverHeroItem = class("PolyhedronOverHeroItem", ReduxView)

function PolyhedronOverHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronOverHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronOverHeroItem:InitUI()
	self:BindCfgUI()

	self.leaderController = ControllerUtil.GetController(self.transform_, "leader")
end

function PolyhedronOverHeroItem:AddUIListener()
	self:AddBtnListener(self.m_servantBtn, nil, function()
		if self.servant_id == 0 then
			return
		end

		if self.clickFunc then
			self.clickFunc(ItemTools.getItemName(self.servant_id), WeaponEffectCfg[WeaponServantCfg[self.servant_id].effect[1]].simple_description, Vector3(0, self.m_servantGo.transform.position.y + 0.1, self.m_servantGo.transform.position.z))
		end
	end)
	self:AddBtnListener(self.m_astrolabeBtn1, nil, function()
		self.clickFunc(HeroAstrolabeCfg[self.using_astrolabe[1]].name, GetCfgDescription(AstrolabeEffectCfg[self.using_astrolabe[1]].desc[1], 1), Vector3(0, self.m_astrolabeGo1.transform.position.y, self.m_astrolabeGo1.transform.position.z))
	end)
	self:AddBtnListener(self.m_astrolabeBtn2, nil, function()
		self.clickFunc(HeroAstrolabeCfg[self.using_astrolabe[2]].name, GetCfgDescription(AstrolabeEffectCfg[self.using_astrolabe[2]].desc[1], 1), Vector3(0, self.m_astrolabeGo2.transform.position.y, self.m_astrolabeGo2.transform.position.z))
	end)
	self:AddBtnListener(self.m_astrolabeBtn3, nil, function()
		self.clickFunc(HeroAstrolabeCfg[self.using_astrolabe[3]].name, GetCfgDescription(AstrolabeEffectCfg[self.using_astrolabe[3]].desc[1], 1), Vector3(0, self.m_astrolabeGo3.transform.position.y, self.m_astrolabeGo3.transform.position.z))
	end)
	self:AddBtnListener(self.m_equipBtn1, nil, function()
		if self.suitList[1] then
			self.clickFunc(EquipSuitCfg[self.suitList[1].id].name, EquipTools.GetEffectDesc(EquipSuitCfg[self.suitList[1].id].suit_effect[1]), Vector3(0, self.m_equipGo1.transform.position.y, self.m_equipGo1.transform.position.z))
		end
	end)
	self:AddBtnListener(self.m_equipBtn2, nil, function()
		if self.suitList[2] then
			self.clickFunc(EquipSuitCfg[self.suitList[2].id].name, EquipTools.GetEffectDesc(EquipSuitCfg[self.suitList[2].id].suit_effect[1]), Vector3(0, self.m_equipGo2.transform.position.y, self.m_equipGo2.transform.position.z))
		end
	end)
	self:AddBtnListener(self.m_equipBtn3, nil, function()
		if self.suitList[3] then
			self.clickFunc(EquipSuitCfg[self.suitList[3].id].name, EquipTools.GetEffectDesc(EquipSuitCfg[self.suitList[3].id].suit_effect[1]), Vector3(0, self.m_equipGo3.transform.position.y, self.m_equipGo3.transform.position.z))
		end
	end)
end

function PolyhedronOverHeroItem:SetData(arg_12_1, arg_12_2)
	local var_12_0
	local var_12_1

	if arg_12_2 == arg_12_1:GetLeaderHeroId() then
		var_12_0, var_12_1 = arg_12_1:GetPolyhedronLeader():GetVirtualData()

		self.leaderController:SetSelectedIndex(1)
	else
		var_12_0, var_12_1 = GetVirtualData(PolyhedronHeroCfg[arg_12_2].standard_id)

		self.leaderController:SetSelectedIndex(0)
	end

	self.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", PolyhedronData:GetHeroUsingSkinInfo(arg_12_2).id)
	self.using_astrolabe = var_12_0.using_astrolabe

	for iter_12_0 = 1, 3 do
		if self.using_astrolabe[iter_12_0] and self.using_astrolabe[iter_12_0] ~= 0 then
			SetActive(self["m_astrolabeGo" .. iter_12_0], true)

			self["m_astrolabeIcon" .. iter_12_0].sprite = HeroAstrolabeCfg[self.using_astrolabe[iter_12_0]].hero_astrolabe_suit_id % 10 == 1 and getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00097") or HeroAstrolabeCfg[self.using_astrolabe[iter_12_0]].hero_astrolabe_suit_id % 10 == 2 and getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00098") or getSprite("Atlas/Polyhedron_BattleAtlas", "PolyhedronBattle_00096")
		else
			SetActive(self["m_astrolabeGo" .. iter_12_0], false)
		end
	end

	self.suitList = self:GetEquipSuit(var_12_0, var_12_1)

	for iter_12_1 = 1, 3 do
		local var_12_2 = self.suitList[iter_12_1] and self.suitList[iter_12_1].id

		if var_12_2 and var_12_2 ~= 0 then
			SetActive(self["m_equipGo" .. iter_12_1], true)

			self["m_equipIcon" .. iter_12_1].sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[var_12_2].icon)
		else
			SetActive(self["m_equipGo" .. iter_12_1], false)
		end
	end

	if var_12_0.servantInfo then
		self.servant_id = var_12_0.servantInfo.id or 0
	end

	if var_12_0.servantInfo then
		self.servant_level = var_12_0.servantInfo.stage or 1
	end

	if self.servant_id == 0 then
		SetActive(self.m_servantGo, false)
	else
		SetActive(self.m_servantGo, true)

		self.m_servantIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon438x238/" .. self.servant_id)
	end
end

function PolyhedronOverHeroItem:GetEquipSuit(arg_13_1, arg_13_2)
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

function PolyhedronOverHeroItem:Dispose()
	PolyhedronOverHeroItem.super.Dispose(self)
end

function PolyhedronOverHeroItem:RegistCallBack(arg_15_1)
	self.clickFunc = arg_15_1
end

return PolyhedronOverHeroItem
