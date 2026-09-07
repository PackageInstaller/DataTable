ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleAttr
local var_0_2 = ys.Battle.BattleDataFunction
local var_0_3 = ys.Battle.BattleConst
local var_0_5 = ys.Battle.BattleConst.EquipmentType
local BattleUnitDetailView = class("BattleUnitDetailView")

ys.Battle.BattleUnitDetailView = BattleUnitDetailView
BattleUnitDetailView.__name = "BattleUnitDetailView"
BattleUnitDetailView.DefaultActive = {
	"attr_panels",
	"attr_panels/buff"
}
BattleUnitDetailView.EnemyMarkList = {}
BattleUnitDetailView.HIGH_LIGHT_BUFF = {}
BattleUnitDetailView.PrimalAttr = {
	"cannonPower",
	"torpedoPower",
	"airPower",
	"antiAirPower",
	"antiSubPower",
	"loadSpeed",
	"dodgeRate",
	"attackRating",
	"velocity"
}
BattleUnitDetailView.BaseEnhancement = {
	damageRatioByBulletTorpedo = "damage/damageRatioByBulletTorpedo",
	injureRatioByBulletTorpedo = "injure/injureRatioByBulletTorpedo",
	damageRatioByCannon = "damage/damageRatioByCannon",
	injureRatioByCannon = "injure/injureRatioByCannon",
	damageRatioBullet = "damage/damageRatioBullet",
	injureRatio = "injure/injureRatio",
	injureRatioByAir = "injure/injureRatioByAir",
	damageRatioByAir = "damage/damageRatioByAir"
}
BattleUnitDetailView.SecondaryAttrListener = {}

function BattleUnitDetailView:Ctor()
	pg.DelegateInfo.New(self)

	return
end

function BattleUnitDetailView:SetUnit(arg_2_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._unit = arg_2_1

	if self._unit:GetUnitType() == var_0_3.UnitType.PLAYER_UNIT then
		setImageSprite(self._icon, (var_0_0.Battle.BattleResourceManager.GetInstance():GetCharacterQIcon(self._unit:GetTemplate().painting)))

		for iter_2_0 = 1, self._unit:GetTemplate().star do
			setActive(cloneTplTo(self._starTpl, self._stars), true)
		end
	end

	setText(self._templateID, self._unit:GetTemplate().id)
	setText(self._name, self._unit:GetTemplate().name)
	setText(self._lv, self._unit:GetAttrByName("level"))

	self._preAttrList = {}

	for iter_2_1, iter_2_2 in ipairs(BattleUnitDetailView.PrimalAttr) do
		local var_2_0 = var_0_1.GetBase(self._unit, iter_2_2)

		setText(self._attrView:Find(iter_2_2 .. "/base"), var_2_0)

		self._preAttrList[iter_2_2] = var_2_0
	end

	self._baseEhcList = {}

	for iter_2_3, iter_2_4 in pairs(BattleUnitDetailView.BaseEnhancement) do
		self._baseEhcList[iter_2_3] = 0
	end

	self._secondaryAttrList = {}
	self._buffList = {}
	self._aaList = {}
	self._weaponList = {}
	self._skillList = {}

	self:updateWeaponList()

	return
end

function BattleUnitDetailView:Update()
	for iter_3_0, iter_3_1 in ipairs(BattleUnitDetailView.PrimalAttr) do
		self:updatePrimalAttr(iter_3_1)
	end

	for iter_3_2, iter_3_3 in pairs(BattleUnitDetailView.BaseEnhancement) do
		self:updateBaseEnhancement(iter_3_2, iter_3_3)
	end

	for iter_3_4, iter_3_5 in pairs((self._unit:GetAttr())) do
		if string.find(iter_3_4, "DMG_TAG_EHC_") or string.find(iter_3_4, "DMG_FROM_TAG_") or table.contains(BattleUnitDetailView.SecondaryAttrListener, iter_3_4) then
			self:updateSecondaryAttr(iter_3_4, iter_3_5)
		end
	end

	self:updateHP()
	self:updateBuffList()
	self:updateWeaponProgress()
	self:updateSkillList()

	return
end

function BattleUnitDetailView:ConfigSkin(arg_4_1)
	self._go = arg_4_1
	self._tf = arg_4_1.transform
	self._iconView = arg_4_1.transform:Find("icon")
	self._icon = self._iconView:Find("icon")
	self._stars = self._iconView:Find("stars")
	self._starTpl = self._stars:Find("star_tpl")
	self._templateView = arg_4_1.transform:Find("template")
	self._templateID = self._templateView:Find("template/text")
	self._name = self._templateView:Find("name/text")
	self._lv = self._templateView:Find("level/text")
	self._totalHP = self._templateView:Find("totalHP/text")
	self._currentHP = self._templateView:Find("currentHP/text")
	self._shield = self._templateView:Find("shield/text")
	self._attrView = arg_4_1.transform:Find("attr_panels/primal_attr")
	self._baseEnhanceView = arg_4_1.transform:Find("attr_panels/basic_ehc")
	self._secondaryAttrView = arg_4_1.transform:Find("attr_panels/tag_ehc")
	self._secondaryAttrContainer = self._secondaryAttrView:Find("tag_container")
	self._secondaryAttrTpl = self._secondaryAttrView:Find("tag_attr_tpl")
	self._buffView = arg_4_1.transform:Find("attr_panels/buff")
	self._buffContainer = self._buffView:Find("buff_container")
	self._buffTpl = self._buffView:Find("buff_tpl")
	self._weaponView = arg_4_1.transform:Find("panel_container/weapon_panels")
	self._weaponContainer = self._weaponView:Find("weapon_container")
	self._weaponTpl = self._weaponView:Find("weapon_tpl")
	self._skillView = arg_4_1.transform:Find("panel_container/skill_panel")
	self._skillContainer = self._skillView:Find("skill_container")
	self._skillTpl = self._skillView:Find("skill_tpl")

	SetActive(self._go, true)

	for iter_4_0, iter_4_1 in ipairs(BattleUnitDetailView.DefaultActive) do
		SetActive(arg_4_1.transform:Find(iter_4_1), true)
	end

	return
end

function BattleUnitDetailView:updateHP()
	local var_5_0, var_5_1 = self._unit:GetHP()
	local var_5_2 = self._unit:GetHPRate()

	setText(self._totalHP, var_5_1)
	setText(self._currentHP, var_5_0)

	local var_5_3 = 0

	for iter_5_0, iter_5_1 in pairs((self._unit:GetBuffList())) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1:GetEffectList()) do
			if iter_5_3.__name == "BattleBuffShield" or iter_5_3.__name == "BattleBuffRecordShield" then
				var_5_3 = var_5_3 + math.max(0, iter_5_3:GetEffectAttachData())
			end
		end
	end

	setText(self._shield, var_5_3)

	return
end

function BattleUnitDetailView:updatePrimalAttr(arg_6_1)
	local var_6_0 = self._unit:GetAttrByName(arg_6_1)

	setText(self._attrView:Find(arg_6_1 .. "/current"), var_6_0)

	if var_6_0 - self._preAttrList[arg_6_1] ~= 0 then
		BattleUnitDetailView.setDeltaText(self._attrView:Find(arg_6_1 .. "/change"), var_6_0 - self._preAttrList[arg_6_1])

		self._preAttrList[arg_6_1] = var_6_0
	end

	local var_6_1 = var_6_0 - var_0_1.GetBase(self._unit, arg_6_1)

	if var_6_1 ~= 0 then
		BattleUnitDetailView.setDeltaText(self._attrView:Find(arg_6_1 .. "/delta"), var_6_1)
	end

	return
end

function BattleUnitDetailView:updateBaseEnhancement(arg_7_1, arg_7_2)
	local var_7_0 = self._baseEnhanceView:Find(arg_7_2)
	local var_7_1 = self._unit:GetAttrByName(arg_7_1)

	setText(var_7_0:Find("current"), var_7_1)

	if var_7_1 - self._baseEhcList[arg_7_1] ~= 0 then
		BattleUnitDetailView.setDeltaText(var_7_0:Find("change"), var_7_1 - self._baseEhcList[arg_7_1])
	end

	return
end

function BattleUnitDetailView:updateSecondaryAttr(arg_8_1, arg_8_2)
	if not self._secondaryAttrList[arg_8_1] then
		local var_8_0 = cloneTplTo(self._secondaryAttrTpl, self._secondaryAttrContainer)

		Canvas.ForceUpdateCanvases()
		setText(var_8_0:Find("tag_name"), arg_8_1)
		setActive(var_8_0, true)

		self._secondaryAttrList[arg_8_1] = {
			value = 0,
			tf = var_8_0
		}
	end

	local var_8_1 = self._secondaryAttrList[arg_8_1].tf

	if self._secondaryAttrList[arg_8_1].value ~= arg_8_2 then
		setText(var_8_1:Find("current"), arg_8_2)
		BattleUnitDetailView.setDeltaText(var_8_1:Find("delta"), self._unit:GetAttrByName(arg_8_1) - self._secondaryAttrList[arg_8_1].value)
	end

	return
end

function BattleUnitDetailView:updateBuffList()
	local var_9_0 = self._unit:GetBuffList()

	for iter_9_0, iter_9_1 in pairs(self._buffList) do
		if not var_9_0[iter_9_0] then
			GameObject.Destroy(iter_9_1.gameObject)

			self._buffList[iter_9_0] = nil
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		if not self._buffList[iter_9_2] then
			self:addBuff(iter_9_2, iter_9_3)
		elseif iter_9_3._stack > 1 then
			local var_9_1 = self._buffList[iter_9_2]:Find("buff_stack")

			setActive(var_9_1, true)
			setText(var_9_1, "x" .. iter_9_3._stack)
		end
	end

	for iter_9_4, iter_9_5 in pairs(var_9_0) do
		for iter_9_6, iter_9_7 in ipairs((iter_9_5:GetEffectList())) do
			if iter_9_7.__name == var_0_0.Battle.BattleBuffCastSkill.__name and (not self._skillList[iter_9_7._skill_id] or not table.contains(self._skillList[iter_9_7._skill_id].effectList, iter_9_7)) then
				self:addSkillCaster(iter_9_7)
			end
		end
	end

	return
end

function BattleUnitDetailView:updateWeaponList()
	local var_10_0 = self._unit:GetAirAssistList()

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_1 = cloneTplTo(self._weaponTpl, self._weaponContainer)

			Canvas.ForceUpdateCanvases()
			GetImageSpriteFromAtlasAsync("skillicon/2130", "", (var_10_1:Find("common/icon")))
			setText(var_10_1:Find("common/index"), "空袭")
			setText(var_10_1:Find("common/templateID"), iter_10_1:GetStrikeSkillID())

			self._aaList[iter_10_1] = var_10_1
		end
	end

	for iter_10_2, iter_10_3 in ipairs((self._unit:GetAllWeapon())) do
		local var_10_2 = iter_10_3:GetType()

		if var_10_2 ~= var_0_5.STRIKE_AIRCRAFT and var_10_2 ~= var_0_5.FLEET_ANTI_AIR then
			local var_10_3 = cloneTplTo(self._weaponTpl, self._weaponContainer)

			Canvas.ForceUpdateCanvases()
			setText(var_10_3:Find("common/index"), iter_10_3:GetEquipmentIndex())
			setText(var_10_3:Find("common/templateID"), iter_10_3:GetTemplateData().id)

			local var_10_4 = iter_10_3:GetSrcEquipmentID()
			local var_10_5 = var_10_3:Find("common/icon")

			if var_10_4 then
				GetImageSpriteFromAtlasAsync("equips/" .. var_0_2.GetWeaponDataFromID(var_10_4).icon, "", var_10_5)
			else
				setActive(var_10_5, false)
			end

			self._weaponList[iter_10_3] = {
				tf = var_10_3,
				data = {}
			}

			onToggle(self, var_10_3:Find("common/sector"), function(arg_11_0)
				self._unit:ActiveWeaponSectorView(iter_10_3, arg_11_0)

				return
			end)
			self:updateBulletAttrBuff(iter_10_3)
		end
	end

	local var_10_6 = self._unit:GetFleetRangeAAWeapon()

	if var_10_6 then
		local var_10_7 = cloneTplTo(self._weaponTpl, self._weaponContainer)

		Canvas.ForceUpdateCanvases()
		GetImageSpriteFromAtlasAsync("skillicon/2130", "", (var_10_7:Find("common/icon")))
		setText(var_10_7:Find("common/index"), "远程防空")
		setText(var_10_7:Find("common/templateID"), "N/A")
		onToggle(self, var_10_7:Find("common/sector"), function(arg_12_0)
			self._unit:ActiveWeaponSectorView(var_10_6, arg_12_0)

			return
		end)
	end

	return
end

function BattleUnitDetailView:updateWeaponProgress()
	for iter_13_0, iter_13_1 in pairs(self._weaponList) do
		self.updateBarProgress(iter_13_1.tf, (iter_13_0:GetReloadRate()))
		setText(iter_13_1.tf:Find("sum/damageSum"), iter_13_0:GetDamageSUM())
		setText(iter_13_1.tf:Find("sum/CTRate"), string.format("%.2f", iter_13_0:GetCTRate() * 100) .. "%")
		setText(iter_13_1.tf:Find("sum/ACCRate"), string.format("%.2f", iter_13_0:GetACCRate() * 100) .. "%")
		self:updateBulletAttrBuff(iter_13_0)
	end

	for iter_13_2, iter_13_3 in pairs(self._aaList) do
		self.updateBarProgress(iter_13_3, (iter_13_2:GetReloadRate()))

		local var_13_0, var_13_1 = iter_13_2:GetDamageSUM()

		setText(iter_13_3:Find("sum/damageSum"), var_13_0 .. " + " .. var_13_1)
	end

	return
end

function BattleUnitDetailView:updateBarProgress(arg_14_1)
	local var_14_0 = self:Find("common/reload_progress/blood"):GetComponent(typeof(Image))

	var_14_0.fillAmount = 1 - arg_14_1
	var_14_0.color = arg_14_1 == 0 and Color.green or Color.red

	return
end

function BattleUnitDetailView:updateBulletAttrBuff(arg_15_1)
	local var_15_0 = self._weaponList[arg_15_1].tf:Find("weapon_attr_tpl")
	local var_15_1 = self._weaponList[arg_15_1].tf:Find("weapon_attr_container")
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(self._weaponList[arg_15_1].data) do
		var_15_2[iter_15_0] = true
	end

	for iter_15_2, iter_15_3 in pairs(self._unit:GetBuffList()) do
		for iter_15_4, iter_15_5 in ipairs(iter_15_3:GetEffectList()) do
			if iter_15_5.__name == var_0_0.Battle.BattleBuffAddBulletAttr.__name and iter_15_5:equipIndexRequire((arg_15_1:GetEquipmentIndex())) then
				local var_15_3 = self._weaponList[arg_15_1].data[iter_15_5]

				if not self._weaponList[arg_15_1].data[iter_15_5] then
					var_15_3 = cloneTplTo(var_15_0, var_15_1)

					setText(var_15_3:Find("tag_name"), iter_15_5._attr)
					setText(var_15_3:Find("src_buff"), iter_15_3:GetID())
					Canvas.ForceUpdateCanvases()

					var_15_3:Find("src_buff"):GetComponent(typeof(Text)).color = Color.green
					self._weaponList[arg_15_1].data[iter_15_5] = var_15_3
				end

				setText(var_15_3:Find("current"), iter_15_5._number)

				var_15_2[iter_15_5] = false
			end
		end
	end

	for iter_15_6, iter_15_7 in pairs(var_15_2) do
		if iter_15_7 then
			SetActive(self._weaponList[arg_15_1].data[iter_15_6]:Find("expire"), true)
		end
	end

	return
end

function BattleUnitDetailView:addBuff(arg_16_1, arg_16_2)
	local var_16_0 = cloneTplTo(self._buffTpl, self._buffContainer)

	Canvas.ForceUpdateCanvases()
	setText(var_16_0:Find("buff_id"), "buff_" .. arg_16_1)

	if table.contains(BattleUnitDetailView.HIGH_LIGHT_BUFF, arg_16_1) then
		setActive(var_16_0:Find("high_light"), true)
	end

	if arg_16_2._stack > 1 then
		local var_16_1 = var_16_0:Find("buff_stack")

		setActive(var_16_1, true)
		setText(var_16_1, "x" .. arg_16_2._stack)
	end

	setActive(var_16_0, true)

	self._buffList[arg_16_1] = var_16_0

	return
end

function BattleUnitDetailView:addSkillCaster(arg_17_1)
	if not var_0_0.Battle.BattleSkillUnit.IsFireSkill(arg_17_1._skill_id, (arg_17_1._srcBuff:GetLv())) then
		return
	end

	local var_17_0 = self._skillList[arg_17_1._skill_id]

	if not self._skillList[arg_17_1._skill_id] then
		local var_17_1 = cloneTplTo(self._skillTpl, self._skillContainer)

		setText(var_17_1:Find("common"):Find("skillID"), arg_17_1._skill_id)
		GetImageSpriteFromAtlasAsync("skillicon/" .. (arg_17_1._srcBuff._tempData.icon or 10120), "", (var_17_1:Find("common/icon")))
		Canvas.ForceUpdateCanvases()

		var_17_0 = {
			tf = var_17_1,
			effectList = {}
		}
		self._skillList[arg_17_1._skill_id] = var_17_0
	end

	table.insert(var_17_0.effectList, arg_17_1)
	self:updateCastEffectTpl(arg_17_1._skill_id)

	return
end

function BattleUnitDetailView:updateSkillList()
	for iter_18_0, iter_18_1 in pairs(self._skillList) do
		self:updateCastEffectTpl(iter_18_0)
	end

	return
end

function BattleUnitDetailView:updateCastEffectTpl(arg_19_1)
	local var_19_0 = 0
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in ipairs(self._skillList[arg_19_1].effectList) do
		var_19_0 = var_19_0 + iter_19_1:GetCastCount()
		var_19_1 = var_19_1 + iter_19_1:GetSkillFireDamageSum()
	end

	local var_19_2 = self._skillList[arg_19_1].tf:Find("common")

	setText(var_19_2:Find("count"), var_19_0)
	setText(var_19_2:Find("damageSum"), var_19_1)

	return
end

function BattleUnitDetailView:Dispose()
	pg.DelegateInfo.Dispose(self)

	self._unit = nil
	self._secondaryAttrList = nil
	self._buffList = nil
	self._weaponList = nil

	GameObject.Destroy(self._go)
	var_0_0.EventListener.DetachEventListener(self)

	return
end

function BattleUnitDetailView:setDeltaText(arg_21_1)
	setText(self, arg_21_1)

	if arg_21_1 > 0 then
		self:GetComponent(typeof(Text)).color = Color.green or Color.red
	end

	return
end

BattleUnitDetailView.WeaponForger = {}
BattleUnitDetailView.BulletForger = {}
BattleUnitDetailView.BarrageForger = {}
BattleUnitDetailView.AircraftForger = {}

return
