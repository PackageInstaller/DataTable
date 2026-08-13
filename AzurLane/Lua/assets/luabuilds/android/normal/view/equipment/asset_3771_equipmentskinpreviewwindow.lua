class = var_0_10000

local var_0_0 = "EquipmentSkinPreviewWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.ship.ShipPreviewLayer"))

function var_0_1.getUIName(arg_1_0)
	return "EquipSkinPreviewUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.buttonList = var_1.Find(var_2_0, "left_panel/Buttons")

	local var_2_1 = arg_2_0.buttonList

	arg_2_0.hitToggle = var_1.Find(var_2_1, "HitEffect")

	local var_2_2 = arg_2_0.buttonList

	arg_2_0.spawnToggle = var_1.Find(var_2_2, "SpawnEffect")

	var_0_1.super.init(arg_2_0)

	setText = var_1

	local var_2_3 = arg_2_0.hitToggle
	local var_2_4 = var_2.Find(var_2_3, "Text")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("hit_preview"))

	setText = var_1

	local var_2_5 = arg_2_0.spawnToggle
	local var_2_6 = var_2.Find(var_2_5, "Text")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("shoot_preview"))

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.equip_skin_template[arg_3_0.equipSkinId].hit_fx_name ~= ""
	local var_3_1 = {}

	EquipType = var_1_10004
	var_3_1[1] = var_1_10004.CannonQuZhu
	EquipType = var_4
	var_3_1[2] = var_4.CannonQingXun
	EquipType = var_4
	var_3_1[3] = var_4.CannonZhongXun
	EquipType = var_4
	var_3_1[4] = var_4.Torpedo
	EquipType = var_4
	var_3_1[5] = var_4.SubmarineTorpedo

	if var_3_0 then
		_ = var_4
		var_3_0 = var_4.any(var_1.equip_type, function(arg_4_0)
			table = var_2_10001

			return var_2_10001.contains(var_3_1, arg_4_0)
		end)
	end

	setActive = var_4

	var_4(arg_3_0.hitToggle, var_3_0)

	if var_3_0 then
		local var_3_2 = arg_3_0.contextData

		defaultValue = var_5
		var_3_2.hitEffect = var_5(arg_3_0.contextData.hitEffect, true)
		triggerToggle = var_3_2

		var_3_2(arg_3_0.hitToggle, arg_3_0.contextData.hitEffect)

		onToggle = var_3_2

		var_3_2(arg_3_0, arg_3_0.hitToggle, function(arg_5_0)
			arg_3_0.contextData.hitEffect = arg_5_0

			local var_5_0 = arg_3_0

			var_1.RefreshFXMode(var_5_0)

			return
		end)
	else
		local var_3_3 = arg_3_0.contextData

		defaultValue = var_5
		var_3_3.hitEffect = var_5(arg_3_0.contextData.hitEffect, false)
	end

	local var_3_4 = var_1.fire_fx_name ~= ""

	setActive = var_5

	var_5(arg_3_0.spawnToggle, var_3_4)

	if var_3_4 then
		local var_3_5 = arg_3_0.contextData

		defaultValue = var_6
		var_3_5.spawnEffect = var_6(arg_3_0.contextData.spawnEffect, true)
		triggerToggle = var_3_5

		var_3_5(arg_3_0.spawnToggle, arg_3_0.contextData.spawnEffect)

		onToggle = var_3_5

		var_3_5(arg_3_0, arg_3_0.spawnToggle, function(arg_6_0)
			arg_3_0.contextData.spawnEffect = arg_6_0

			local var_6_0 = arg_3_0

			var_1.RefreshFXMode(var_6_0)

			return
		end)
	else
		local var_3_6 = arg_3_0.contextData

		defaultValue = var_6
		var_3_6.spawnEffect = var_6(arg_3_0.contextData.spawnEffect, true)
	end

	var_0_1.super.didEnter(arg_3_0)

	return
end

function var_0_1.RefreshFXMode(arg_7_0)
	if not arg_7_0.previewer then
		return
	end

	local var_7_0 = arg_7_0.previewer

	var_1.SetFXMode(var_7_0, arg_7_0.contextData.spawnEffect, arg_7_0.contextData.hitEffect)

	local var_7_1 = arg_7_0.previewer

	var_1.onWeaponUpdate(var_7_1)

	return
end

function var_0_1.showBarrage(arg_8_0)
	var_0_1.super.showBarrage(arg_8_0)

	local var_8_0 = arg_8_0.previewer

	var_1.SetFXMode(var_8_0, arg_8_0.contextData.spawnEffect, arg_8_0.contextData.hitEffect)

	return
end

function var_0_1.playLoadingAni(arg_9_0)
	var_0_1.super.playLoadingAni(arg_9_0)

	setActive = var_1

	var_1(arg_9_0.buttonList, false)

	return
end

function var_0_1.stopLoadingAni(arg_10_0)
	var_0_1.super.stopLoadingAni(arg_10_0)

	setActive = var_1

	var_1(arg_10_0.buttonList, true)

	return
end

return var_0_1
