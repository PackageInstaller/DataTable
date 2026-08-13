ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleAttr
local var_0_2 = var_0.Battle.BattleDataFunction
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleUnitEvent
local var_0_5 = var_0.Battle.BattleConst.EquipmentType

class = var_0_10006

local var_0_6 = var_0_10006("BattleUnitDetailView")

var_0.Battle.BattleUnitDetailView = var_0_6
var_0_6.__name = "BattleUnitDetailView"
var_0_6.DefaultActive = {
	"attr_panels",
	"attr_panels/buff"
}
var_0_6.EnemyMarkList = {}
var_0_6.HIGH_LIGHT_BUFF = {}
var_0_6.PrimalAttr = {
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
var_0_6.BaseEnhancement = {
	damageRatioByBulletTorpedo = "damage/damageRatioByBulletTorpedo",
	injureRatioByBulletTorpedo = "injure/injureRatioByBulletTorpedo",
	damageRatioByCannon = "damage/damageRatioByCannon",
	injureRatioByCannon = "injure/injureRatioByCannon",
	damageRatioBullet = "damage/damageRatioBullet",
	injureRatio = "injure/injureRatio",
	injureRatioByAir = "injure/injureRatioByAir",
	damageRatioByAir = "damage/damageRatioByAir"
}
var_0_6.SecondaryAttrListener = {}

function var_0_6.Ctor(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)

	return
end

function var_0_6.SetUnit(arg_2_0, arg_2_1)
	var_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._unit = arg_2_1

	local var_2_0 = arg_2_0._unit

	if var_2.GetUnitType(var_2_0) == var_0_3.UnitType.PLAYER_UNIT then
		local var_2_1 = var_0.Battle.BattleResourceManager.GetInstance()
		local var_2_2 = var_2.GetCharacterQIcon
		local var_2_3 = arg_2_0._unit
		local var_2_4 = var_2_2(var_2_1, var_6.GetTemplate(var_2_3).painting)

		setImageSprite = var_2_0

		var_2_0(arg_2_0._icon, var_2_4)

		local var_2_5 = 1
		local var_2_6 = arg_2_0._unit

		for iter_2_0 = var_2_5, var_5.GetTemplate(var_2_6).star do
			cloneTplTo = var_2_3
			var_2_3 = var_2_3(arg_2_0._starTpl, arg_2_0._stars)
			setActive = var_1_10009

			var_1_10009(var_2_3, true)
		end
	end

	setText = var_2

	local var_2_7 = arg_2_0._templateID
	local var_2_8 = arg_2_0._unit

	var_2(var_2_7, var_5.GetTemplate(var_2_8).id)

	setText = var_2

	local var_2_9 = arg_2_0._name
	local var_2_10 = arg_2_0._unit

	var_2(var_2_9, var_5.GetTemplate(var_2_10).name)

	setText = var_2

	local var_2_11 = arg_2_0._lv
	local var_2_12 = arg_2_0._unit

	var_2(var_2_11, var_5.GetAttrByName(var_2_12, "level"))

	arg_2_0._preAttrList = {}
	ipairs = var_2

	for iter_2_1, iter_2_2 in var_2(var_0_6.PrimalAttr) do
		local var_2_13 = var_0_1.GetBase(arg_2_0._unit, iter_2_2)

		setText = var_2_15

		local var_2_14 = arg_2_0._attrView

		var_2_15(var_10.Find(var_2_14, iter_2_2 .. "/base"), var_2_13)

		local var_2_15 = arg_2_0._preAttrList

		var_2_15[iter_2_2] = var_2_13
	end

	arg_2_0._baseEhcList = {}
	pairs = var_2

	for iter_2_3, iter_2_4 in var_2(var_0_6.BaseEnhancement) do
		arg_2_0._baseEhcList[iter_2_3] = 0
	end

	arg_2_0._secondaryAttrList = {}
	arg_2_0._buffList = {}
	arg_2_0._aaList = {}
	arg_2_0._weaponList = {}
	arg_2_0._skillList = {}

	arg_2_0:updateWeaponList()

	return
end

function var_0_6.Update(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(var_0_6.PrimalAttr) do
		arg_3_0:updatePrimalAttr(iter_3_1)
	end

	pairs = var_1

	for iter_3_2, iter_3_3 in var_1(var_0_6.BaseEnhancement) do
		arg_3_0:updateBaseEnhancement(iter_3_2, iter_3_3)
	end

	local var_3_0 = arg_3_0._unit
	local var_3_1 = var_1.GetAttr(var_3_0)

	pairs = var_2

	for iter_3_4, iter_3_5 in var_2(var_3_1) do
		string = var_1_10007

		if not var_1_10007.find(iter_3_4, "DMG_TAG_EHC_") then
			string = var_1_10007

			if not var_1_10007.find(iter_3_4, "DMG_FROM_TAG_") then
				table = var_1_10007

				if var_1_10007.contains(var_0_6.SecondaryAttrListener, iter_3_4) then
					arg_3_0:updateSecondaryAttr(iter_3_4, iter_3_5)
				end
			end
		end
	end

	arg_3_0:updateHP()
	arg_3_0:updateBuffList()
	arg_3_0:updateWeaponProgress()
	arg_3_0:updateSkillList()

	return
end

function var_0_6.ConfigSkin(arg_4_0, arg_4_1)
	arg_4_0._go = arg_4_1
	arg_4_0._tf = arg_4_1.transform
	arg_4_0._iconView = var_2:Find("icon")

	local var_4_0 = arg_4_0._iconView

	arg_4_0._icon = var_3.Find(var_4_0, "icon")

	local var_4_1 = arg_4_0._iconView

	arg_4_0._stars = var_3.Find(var_4_1, "stars")

	local var_4_2 = arg_4_0._stars

	arg_4_0._starTpl = var_3.Find(var_4_2, "star_tpl")
	arg_4_0._templateView = var_2:Find("template")

	local var_4_3 = arg_4_0._templateView

	arg_4_0._templateID = var_3.Find(var_4_3, "template/text")

	local var_4_4 = arg_4_0._templateView

	arg_4_0._name = var_3.Find(var_4_4, "name/text")

	local var_4_5 = arg_4_0._templateView

	arg_4_0._lv = var_3.Find(var_4_5, "level/text")

	local var_4_6 = arg_4_0._templateView

	arg_4_0._totalHP = var_3.Find(var_4_6, "totalHP/text")

	local var_4_7 = arg_4_0._templateView

	arg_4_0._currentHP = var_3.Find(var_4_7, "currentHP/text")

	local var_4_8 = arg_4_0._templateView

	arg_4_0._shield = var_3.Find(var_4_8, "shield/text")
	arg_4_0._attrView = var_2:Find("attr_panels/primal_attr")
	arg_4_0._baseEnhanceView = var_2:Find("attr_panels/basic_ehc")
	arg_4_0._secondaryAttrView = var_2:Find("attr_panels/tag_ehc")

	local var_4_9 = arg_4_0._secondaryAttrView

	arg_4_0._secondaryAttrContainer = var_3.Find(var_4_9, "tag_container")

	local var_4_10 = arg_4_0._secondaryAttrView

	arg_4_0._secondaryAttrTpl = var_3.Find(var_4_10, "tag_attr_tpl")
	arg_4_0._buffView = var_2:Find("attr_panels/buff")

	local var_4_11 = arg_4_0._buffView

	arg_4_0._buffContainer = var_3.Find(var_4_11, "buff_container")

	local var_4_12 = arg_4_0._buffView

	arg_4_0._buffTpl = var_3.Find(var_4_12, "buff_tpl")
	arg_4_0._weaponView = var_2:Find("panel_container/weapon_panels")

	local var_4_13 = arg_4_0._weaponView

	arg_4_0._weaponContainer = var_3.Find(var_4_13, "weapon_container")

	local var_4_14 = arg_4_0._weaponView

	arg_4_0._weaponTpl = var_3.Find(var_4_14, "weapon_tpl")
	arg_4_0._skillView = var_2:Find("panel_container/skill_panel")

	local var_4_15 = arg_4_0._skillView

	arg_4_0._skillContainer = var_3.Find(var_4_15, "skill_container")

	local var_4_16 = arg_4_0._skillView

	arg_4_0._skillTpl = var_3.Find(var_4_16, "skill_tpl")
	SetActive = var_3

	var_3(arg_4_0._go, true)

	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(var_0_6.DefaultActive) do
		SetActive = var_1_10008

		var_1_10008(var_2:Find(iter_4_1), true)
	end

	return
end

function var_0_6.updateHP(arg_5_0)
	local var_5_0 = arg_5_0._unit
	local var_5_1, var_5_2 = var_1.GetHP(var_5_0)
	local var_5_3 = arg_5_0._unit
	local var_5_4 = var_3.GetHPRate(var_5_3)

	setText = var_1_10004

	var_1_10004(arg_5_0._totalHP, var_5_2)

	setText = var_1_10004

	var_1_10004(arg_5_0._currentHP, var_5_1)

	local var_5_5 = arg_5_0._unit
	local var_5_6 = var_4.GetBuffList(var_5_5)
	local var_5_7 = 0

	pairs = var_5_5

	for iter_5_0, iter_5_1 in var_5_5(var_5_6) do
		ipairs = var_1_10011

		for iter_5_2, iter_5_3 in var_1_10011(iter_5_1:GetEffectList()) do
			if iter_5_3.__name == "BattleBuffShield" or iter_5_3.__name == "BattleBuffRecordShield" then
				math = var_16
				var_5_7 = var_5_7 + var_16.max(0, iter_5_3:GetEffectAttachData())
			end
		end
	end

	setText = var_6

	var_6(arg_5_0._shield, var_5_7)

	return
end

function var_0_6.updatePrimalAttr(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._unit
	local var_6_1 = var_2.GetAttrByName(var_6_0, arg_6_1)

	setText = var_1_10003

	local var_6_2 = arg_6_0._attrView

	var_1_10003(var_5.Find(var_6_2, arg_6_1 .. "/current"), var_6_1)

	if var_6_1 - arg_6_0._preAttrList[arg_6_1] ~= 0 then
		local var_6_3 = arg_6_0._attrView
		local var_6_4 = var_4.Find(var_6_3, arg_6_1 .. "/change")

		var_0_6.setDeltaText(var_6_4, var_3)

		arg_6_0._preAttrList[arg_6_1] = var_6_1
	end

	if var_6_1 - var_0_1.GetBase(arg_6_0._unit, arg_6_1) ~= 0 then
		local var_6_5 = arg_6_0._attrView
		local var_6_6 = var_6.Find(var_6_5, arg_6_1 .. "/delta")

		var_0_6.setDeltaText(var_6_6, var_5)
	end

	return
end

function var_0_6.updateBaseEnhancement(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._baseEnhanceView
	local var_7_1 = var_3.Find(var_7_0, arg_7_2)
	local var_7_2 = arg_7_0._unit
	local var_7_3 = var_4.GetAttrByName(var_7_2, arg_7_1) - arg_7_0._baseEhcList[arg_7_1]

	setText = var_7_2

	var_7_2(var_7_1:Find("current"), var_4)

	if var_7_3 ~= 0 then
		var_0_6.setDeltaText(var_7_1:Find("change"), var_7_3)
	end

	return
end

function var_0_6.updateSecondaryAttr(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._secondaryAttrList[arg_8_1] then
		cloneTplTo = var_3

		local var_8_0 = var_3(arg_8_0._secondaryAttrTpl, arg_8_0._secondaryAttrContainer)

		Canvas = var_1_10004

		var_1_10004.ForceUpdateCanvases()

		setText = var_4

		var_4(var_8_0:Find("tag_name"), arg_8_1)

		setActive = var_4

		var_4(var_8_0, true)

		local var_8_1 = {
			value = 0,
			tf = var_8_0
		}

		arg_8_0._secondaryAttrList[arg_8_1] = var_8_1
	end

	local var_8_2 = arg_8_0._secondaryAttrList[arg_8_1].tf
	local var_8_3 = arg_8_0._unit
	local var_8_4 = var_4.GetAttrByName(var_8_3, arg_8_1)

	if arg_8_0._secondaryAttrList[arg_8_1].value ~= arg_8_2 then
		setText = var_8_3

		var_8_3(var_8_2:Find("current"), arg_8_2)

		local var_8_5 = var_8_4 - var_5

		var_0_6.setDeltaText(var_8_2:Find("delta"), var_8_5)
	end

	return
end

function var_0_6.updateBuffList(arg_9_0)
	local var_9_0 = arg_9_0._unit
	local var_9_1 = var_1.GetBuffList(var_9_0)

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0._buffList) do
		if not var_9_1[iter_9_0] then
			GameObject = var_7

			var_7.Destroy(iter_9_1.gameObject)

			arg_9_0._buffList[iter_9_0] = nil
		end
	end

	pairs = var_2

	for iter_9_2, iter_9_3 in var_2(var_9_1) do
		if not arg_9_0._buffList[iter_9_2] then
			arg_9_0:addBuff(iter_9_2, iter_9_3)
		else
			local var_9_2 = arg_9_0._buffList[iter_9_2]

			var_1_10008 = iter_9_3._stack

			if 1 < var_1_10008 then
				var_1_10008 = var_9_2:Find("buff_stack")
				setActive = var_9

				var_9(var_1_10008, true)

				setText = var_9

				var_9(var_1_10008, "x" .. iter_9_3._stack)
			end
		end
	end

	pairs = var_2

	for iter_9_4, iter_9_5 in var_2(var_9_1) do
		local var_9_3 = iter_9_5:GetEffectList()

		ipairs = var_1_10008

		for iter_9_6, iter_9_7 in var_1_10008(var_9_3) do
			if iter_9_7.__name == var_0.Battle.BattleBuffCastSkill.__name then
				if arg_9_0._skillList[iter_9_7._skill_id] then
					table = var_13

					if not var_13.contains(arg_9_0._skillList[iter_9_7._skill_id].effectList, iter_9_7) then
						arg_9_0:addSkillCaster(iter_9_7)
					end
				end
			end
		end
	end

	return
end

function var_0_6.updateWeaponList(arg_10_0)
	local var_10_0 = arg_10_0._unit

	if var_1.GetAirAssistList(var_10_0) then
		ipairs = var_1_10002

		for iter_10_0, iter_10_1 in var_1_10002(var_1) do
			cloneTplTo = var_1_10007
			var_1_10007 = var_1_10007(arg_10_0._weaponTpl, arg_10_0._weaponContainer)
			Canvas = var_1_10008

			var_1_10008.ForceUpdateCanvases()

			var_1_10008 = var_1_10007:Find("common/icon")
			GetImageSpriteFromAtlasAsync = var_9

			var_9("skillicon/2130", "", var_1_10008)

			setText = var_9

			var_9(var_1_10007:Find("common/index"), "空袭")

			setText = var_9

			var_9(var_1_10007:Find("common/templateID"), iter_10_1:GetStrikeSkillID())

			arg_10_0._aaList[iter_10_1] = var_1_10007
		end
	end

	local var_10_1 = arg_10_0._unit
	local var_10_2 = var_2.GetAllWeapon(var_10_1)

	ipairs = var_10_0

	for iter_10_2, iter_10_3 in var_10_0(var_10_2) do
		local var_10_3 = iter_10_3

		if iter_10_3.GetType(var_10_3) ~= var_0_5.STRIKE_AIRCRAFT and var_8 ~= var_0_5.FLEET_ANTI_AIR then
			cloneTplTo = var_9

			local var_10_4 = var_9(arg_10_0._weaponTpl, arg_10_0._weaponContainer)

			Canvas = var_10_3

			var_10_3.ForceUpdateCanvases()

			setText = var_10

			var_10(var_10_4:Find("common/index"), iter_10_3:GetEquipmentIndex())

			setText = var_10

			var_10(var_10_4:Find("common/templateID"), iter_10_3:GetTemplateData().id)

			local var_10_5 = iter_10_3
			local var_10_6 = iter_10_3.GetSrcEquipmentID(var_10_5)
			local var_10_7 = var_10_4
			local var_10_8 = var_10_4.Find(var_10_7, "common/icon")

			if var_10_6 then
				var_10_5 = var_0_2.GetWeaponDataFromID(var_10_6).icon
				GetImageSpriteFromAtlasAsync = var_10_7

				var_10_7("equips/" .. var_10_5, "", var_10_8)
			else
				setActive = var_10_5

				var_10_5(var_10_8, false)
			end

			local var_10_9 = arg_10_0._weaponList

			var_10_9[iter_10_3] = {
				tf = var_10_4,
				data = {}
			}
			onToggle = var_10_9

			var_10_9(arg_10_0, var_10_4:Find("common/sector"), function(arg_11_0)
				local var_11_0 = arg_10_0._unit

				var_1.ActiveWeaponSectorView(var_11_0, iter_10_3, arg_11_0)

				return
			end)
			arg_10_0:updateBulletAttrBuff(iter_10_3)
		end
	end

	local var_10_10 = arg_10_0._unit

	if var_3.GetFleetRangeAAWeapon(var_10_10) then
		cloneTplTo = var_4

		local var_10_11 = var_4(arg_10_0._weaponTpl, arg_10_0._weaponContainer)

		Canvas = var_10_10

		var_10_10.ForceUpdateCanvases()

		local var_10_12 = var_10_11:Find("common/icon")

		GetImageSpriteFromAtlasAsync = var_6

		var_6("skillicon/2130", "", var_10_12)

		setText = var_6

		var_6(var_10_11:Find("common/index"), "远程防空")

		setText = var_6

		var_6(var_10_11:Find("common/templateID"), "N/A")

		onToggle = var_6

		var_6(arg_10_0, var_10_11:Find("common/sector"), function(arg_12_0)
			local var_12_0 = arg_10_0._unit

			var_1.ActiveWeaponSectorView(var_12_0, var_0, arg_12_0)

			return
		end)
	end

	return
end

function var_0_6.updateWeaponProgress(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0._weaponList) do
		local var_13_0 = iter_13_1.tf
		local var_13_1 = iter_13_0:GetReloadRate()

		arg_13_0.updateBarProgress(var_13_0, var_13_1)

		setText = var_8

		var_8(var_13_0:Find("sum/damageSum"), iter_13_0:GetDamageSUM())

		setText = var_8

		local var_13_2 = var_13_0:Find("sum/CTRate")

		string = var_11

		var_8(var_13_2, var_11.format("%.2f", iter_13_0:GetCTRate() * 100) .. "%")

		setText = var_8

		local var_13_3 = var_13_0:Find("sum/ACCRate")

		string = var_11

		var_8(var_13_3, var_11.format("%.2f", iter_13_0:GetACCRate() * 100) .. "%")
		arg_13_0:updateBulletAttrBuff(iter_13_0)
	end

	pairs = var_1

	for iter_13_2, iter_13_3 in var_1(arg_13_0._aaList) do
		local var_13_4 = iter_13_2:GetReloadRate()

		arg_13_0.updateBarProgress(iter_13_3, var_13_4)

		local var_13_5 = iter_13_2
		local var_13_6, var_13_7 = iter_13_2.GetDamageSUM(var_13_5)

		setText = var_13_5

		var_13_5(iter_13_3:Find("sum/damageSum"), var_13_6 .. " + " .. var_13_7)
	end

	return
end

function var_0_6.updateBarProgress(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:Find("common/reload_progress/blood")
	local var_14_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007

	local var_14_2 = var_14_1(var_14_0, var_5(var_1_10007))

	var_14_2.fillAmount = 1 - arg_14_1

	if arg_14_1 == 0 then
		Color = var_3
		var_14_2.color = var_3.green
	else
		Color = var_3
		var_14_2.color = var_3.red
	end

	return
end

function var_0_6.updateBulletAttrBuff(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._weaponList[arg_15_1].tf
	local var_15_1 = var_2.data
	local var_15_2 = var_15_0:Find("weapon_attr_tpl")
	local var_15_3 = var_15_0
	local var_15_4 = var_15_0.Find(var_15_3, "weapon_attr_container")
	local var_15_5 = {}

	pairs = var_15_3

	for iter_15_0, iter_15_1 in var_15_3(var_15_1) do
		var_15_5[iter_15_0] = true
	end

	pairs = var_8

	local var_15_6 = arg_15_0._unit

	for iter_15_2, iter_15_3 in var_8(var_10.GetBuffList(var_15_6)) do
		ipairs = var_1_10013

		for iter_15_4, iter_15_5 in var_1_10013(iter_15_3:GetEffectList()) do
			if iter_15_5.__name == var_0.Battle.BattleBuffAddBulletAttr.__name then
				local var_15_7 = arg_15_1
				local var_15_8 = arg_15_1.GetEquipmentIndex(var_15_7)
				local var_15_9 = iter_15_5

				if iter_15_5.equipIndexRequire(var_15_9, var_15_8) then
					local var_15_10

					if not var_15_1[iter_15_5] then
						cloneTplTo = var_15_7
						var_15_10 = var_15_7(var_15_2, var_15_4)
						setText = var_15_7

						var_15_7(var_15_10:Find("tag_name"), iter_15_5._attr)

						setText = var_15_7

						local var_15_11 = var_15_10:Find("src_buff")
						local var_15_12 = iter_15_3

						var_15_7(var_15_11, iter_15_3.GetID(var_15_12))

						Canvas = var_15_7

						var_15_7.ForceUpdateCanvases()

						local var_15_13 = var_15_10:Find("src_buff")

						var_15_7 = var_15_7.GetComponent
						typeof = var_23
						Text = var_15_12
						var_15_7 = var_15_7(var_15_13, var_23(var_15_12))
						Color = var_15_9
						var_15_7.color = var_15_9.green
						var_15_1[iter_15_5] = var_15_10
					end

					setText = var_15_7

					var_15_7(var_15_10:Find("current"), iter_15_5._number)

					var_15_5[iter_15_5] = false
				end
			end
		end
	end

	pairs = var_8

	for iter_15_6, iter_15_7 in var_8(var_15_5) do
		if iter_15_7 then
			local var_15_14 = var_15_1[iter_15_6]

			SetActive = var_1_10014

			var_1_10014(var_15_14:Find("expire"), true)
		end
	end

	return
end

function var_0_6.addBuff(arg_16_0, arg_16_1, arg_16_2)
	cloneTplTo = var_1_10003

	local var_16_0 = var_1_10003(arg_16_0._buffTpl, arg_16_0._buffContainer)

	Canvas = var_1_10004

	var_1_10004.ForceUpdateCanvases()

	setText = var_4

	var_4(var_16_0:Find("buff_id"), "buff_" .. arg_16_1)

	table = var_4

	if var_4.contains(var_0_6.HIGH_LIGHT_BUFF, arg_16_1) then
		local var_16_1 = var_16_0:Find("high_light")

		setActive = var_5

		var_5(var_16_1, true)
	end

	local var_16_2 = arg_16_2._stack

	if 1 < var_16_2 then
		var_16_2 = var_16_0:Find("buff_stack")
		setActive = var_5

		var_5(var_16_2, true)

		setText = var_5

		var_5(var_16_2, "x" .. arg_16_2._stack)
	end

	setActive = var_16_2

	var_16_2(var_16_0, true)

	arg_16_0._buffList[arg_16_1] = var_16_0

	return
end

function var_0_6.addSkillCaster(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1._skill_id
	local var_17_1 = arg_17_1._srcBuff
	local var_17_2 = var_3.GetLv(var_17_1)

	if not var_0.Battle.BattleSkillUnit.IsFireSkill(var_17_0, var_17_2) then
		return
	end

	local var_17_8

	if not arg_17_0._skillList[var_17_0] then
		cloneTplTo = var_17_1

		local var_17_3 = var_17_1(arg_17_0._skillTpl, arg_17_0._skillContainer)
		local var_17_4 = var_17_1.Find(var_17_3, "common")

		setText = var_7

		var_7(var_17_4:Find("skillID"), arg_17_1._skill_id)

		local var_17_5 = var_17_1
		local var_17_6 = var_17_1.Find(var_17_5, "common/icon")
		local var_17_7

		if not arg_17_1._srcBuff._tempData.icon then
			var_17_7 = 10120
		end

		GetImageSpriteFromAtlasAsync = var_17_5

		var_17_5("skillicon/" .. var_17_7, "", var_17_6)

		Canvas = var_17_5

		var_17_5.ForceUpdateCanvases()

		var_17_8 = {
			tf = var_17_1,
			effectList = {}
		}
		arg_17_0._skillList[var_17_0] = var_17_8
	end

	table = var_17_1

	var_17_1.insert(var_17_8.effectList, arg_17_1)
	arg_17_0:updateCastEffectTpl(var_17_0)

	return
end

function var_0_6.updateSkillList(arg_18_0)
	pairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0._skillList) do
		arg_18_0:updateCastEffectTpl(iter_18_0)
	end

	return
end

function var_0_6.updateCastEffectTpl(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._skillList[arg_19_1].tf
	local var_19_1 = var_2.effectList
	local var_19_2 = 0
	local var_19_3 = 0

	ipairs = var_1_10007

	for iter_19_0, iter_19_1 in var_1_10007(var_19_1) do
		var_19_2 = var_19_2 + iter_19_1:GetCastCount()
		var_19_3 = var_19_3 + iter_19_1:GetSkillFireDamageSum()
	end

	local var_19_4 = var_19_0:Find("common")

	setText = var_8

	var_8(var_19_4:Find("count"), var_19_2)

	setText = var_8

	var_8(var_19_4:Find("damageSum"), var_19_3)

	return
end

function var_0_6.Dispose(arg_20_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_20_0)

	arg_20_0._unit = nil
	arg_20_0._secondaryAttrList = nil
	arg_20_0._buffList = nil
	arg_20_0._weaponList = nil
	GameObject = var_1

	var_1.Destroy(arg_20_0._go)
	var_0.EventListener.DetachEventListener(arg_20_0)

	return
end

function var_0_6.setDeltaText(arg_21_0, arg_21_1)
	setText = var_1_10002

	var_1_10002(arg_21_0, arg_21_1)

	if 0 < arg_21_1 then
		Color = var_21_0

		local var_21_0

		if not var_21_0.green then
			Color = var_21_0
			var_21_0 = var_21_0.red
		end

		local var_21_1 = arg_21_0
		local var_21_2 = arg_21_0.GetComponent

		typeof = var_1_10006
		Text = var_1_10008
		var_21_2(var_21_1, var_1_10006(var_1_10008)).color = var_21_0

		return
	end
end

var_0_6.WeaponForger = {}
var_0_6.BulletForger = {}
var_0_6.BarrageForger = {}
var_0_6.AircraftForger = {}

return
