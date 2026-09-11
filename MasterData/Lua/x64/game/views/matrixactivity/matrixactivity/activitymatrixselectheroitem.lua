local ActivityMatrixSelectHeroItem = class("ActivityMatrixSelectHeroItem", ReduxView)

function ActivityMatrixSelectHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityMatrixSelectHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixSelectHeroItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.weaponController = ControllerUtil.GetController(self.transform_, "weapon")
	self.astrolabeController = ControllerUtil.GetController(self.transform_, "astrolabe")
	self.equipController = ControllerUtil.GetController(self.transform_, "equip")
	self.trialController = ControllerUtil.GetController(self.transform_, "trial")
end

function ActivityMatrixSelectHeroItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function ActivityMatrixSelectHeroItem:SetStandardData(arg_6_1)
	self.trialController:SetSelectedIndex(1)

	local var_6_0 = TempHeroData:GetTempHeroDataByTempID(arg_6_1)
	local var_6_1 = HeroCfg[HeroStandardSystemCfg[arg_6_1].hero_id]

	self.m_name.text = GetI18NText(HeroCfg[HeroStandardSystemCfg[arg_6_1].hero_id].name)
	self.m_img.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[var_6_0.using_skin].picture_id)
	self.m_raceImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_6_1.race].icon)

	if not var_6_0.servantInfo or var_6_0.servantInfo.id == 0 then
		self.weaponController:SetSelectedIndex(0)
	else
		self.weaponController:SetSelectedIndex(1)

		self.m_weaponImg.sprite = ItemTools.getItemSprite(var_6_0.servantInfo.id)
	end

	local var_6_2 = clone(var_6_0.using_astrolabe)

	table.sort(var_6_2, function(arg_7_0, arg_7_1)
		return arg_7_0 < arg_7_1
	end)

	local var_6_3 = math.min(3, #var_6_2)

	self.astrolabeController:SetSelectedIndex(var_6_3)

	for iter_6_0 = 1, var_6_3 do
		local var_6_4 = table.indexof(var_6_1.astrolabe, HeroAstrolabeCfg[var_6_2[iter_6_0]].hero_astrolabe_suit_id) or 1

		if var_6_4 == 1 then
			self["m_astrolabe" .. iter_6_0].sprite = getSprite("Atlas/Common", "icon_yellow_a")
		elseif var_6_4 == 2 then
			self["m_astrolabe" .. iter_6_0].sprite = getSprite("Atlas/Common", "icon_red_a")
		elseif var_6_4 == 3 then
			self["m_astrolabe" .. iter_6_0].sprite = getSprite("Atlas/Common", "icon_blue_a")
		end
	end

	local var_6_5 = HeroTools.GetIsSuitNumCut(var_6_0)
	local var_6_6 = {}

	for iter_6_1, iter_6_2 in pairs(var_6_0.equip_list) do
		if iter_6_2.equip_id ~= 0 then
			if var_6_6[EquipCfg[iter_6_2.prefab_id].suit] then
				var_6_6[EquipCfg[iter_6_2.prefab_id].suit].num = var_6_6[EquipCfg[iter_6_2.prefab_id].suit].num + 1
			else
				var_6_6[EquipCfg[iter_6_2.prefab_id].suit] = {
					num = 1,
					id = EquipCfg[iter_6_2.prefab_id].suit
				}
			end
		end
	end

	local var_6_7 = {}

	for iter_6_3, iter_6_4 in pairs(var_6_6) do
		table.insert(var_6_7, iter_6_4)
	end

	for iter_6_5 = #var_6_7, 1, -1 do
		if var_6_7[iter_6_5].num < EquipTools.GetSuitNeedNum(var_6_7[iter_6_5].id, var_6_5) then
			table.remove(var_6_7, iter_6_5)
		end
	end

	local var_6_8 = math.min(3, #var_6_7)

	self.equipController:SetSelectedIndex(var_6_8)

	for iter_6_6 = 1, var_6_8 do
		self["m_equip" .. iter_6_6].sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[var_6_7[iter_6_6].id].icon)
	end
end

function ActivityMatrixSelectHeroItem:SetData(arg_8_1)
	self.trialController:SetSelectedIndex(0)

	self.heroId = arg_8_1

	local var_8_0 = HeroData:GetHeroData(arg_8_1)
	local var_8_1 = HeroCfg[arg_8_1]

	self.m_name.text = GetI18NText(HeroCfg[arg_8_1].name)
	self.m_img.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[HeroTools.HeroUsingSkinInfo(arg_8_1).id].picture_id)
	self.m_raceImg.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_8_1.race].icon)

	local var_8_2 = WeaponServantData:GetServantDataByUID(var_8_0.servant_uid)

	if not var_8_2 then
		self.weaponController:SetSelectedIndex(0)
	else
		self.weaponController:SetSelectedIndex(1)

		self.m_weaponImg.sprite = ItemTools.getItemSprite(var_8_2.id)
	end

	local var_8_3 = clone(var_8_0.using_astrolabe)

	table.sort(var_8_3, function(arg_9_0, arg_9_1)
		return arg_9_0 < arg_9_1
	end)

	local var_8_4 = math.min(3, #var_8_3)

	self.astrolabeController:SetSelectedIndex(var_8_4)

	for iter_8_0 = 1, var_8_4 do
		local var_8_5 = table.indexof(var_8_1.astrolabe, HeroAstrolabeCfg[var_8_3[iter_8_0]].hero_astrolabe_suit_id) or 1

		if var_8_5 == 1 then
			self["m_astrolabe" .. iter_8_0].sprite = getSprite("Atlas/Common", "icon_yellow_a")
		elseif var_8_5 == 2 then
			self["m_astrolabe" .. iter_8_0].sprite = getSprite("Atlas/Common", "icon_red_a")
		elseif var_8_5 == 3 then
			self["m_astrolabe" .. iter_8_0].sprite = getSprite("Atlas/Common", "icon_blue_a")
		end
	end

	local var_8_6 = HeroTools.GetIsSuitNumCut(var_8_0)
	local var_8_7 = EquipTools.CountActiveSuit(var_8_0.equip)

	for iter_8_1 = #var_8_7, 1, -1 do
		if var_8_7[iter_8_1].num < EquipTools.GetSuitNeedNum(var_8_7[iter_8_1].id, var_8_6) then
			table.remove(var_8_7, iter_8_1)
		end
	end

	local var_8_8 = math.min(3, #var_8_7)

	self.equipController:SetSelectedIndex(var_8_8)

	for iter_8_2 = 1, var_8_8 do
		self["m_equip" .. iter_8_2].sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[var_8_7[iter_8_2].id].icon)
	end
end

function ActivityMatrixSelectHeroItem:SetIndex(arg_10_1)
	self.index = arg_10_1
end

function ActivityMatrixSelectHeroItem:SetSelect(arg_11_1)
	self.selectController:SetSelectedIndex(self.index == arg_11_1 and 1 or 0)
end

function ActivityMatrixSelectHeroItem:RegistCallBack(arg_12_1)
	self.clickFunc = arg_12_1
end

function ActivityMatrixSelectHeroItem:Dispose()
	ActivityMatrixSelectHeroItem.super.Dispose(self)
end

return ActivityMatrixSelectHeroItem
