local var_0_0 = class("BeachGuardAsset")

var_0_0.card_asset_path = "beachguardgameassets/char_icon"
var_0_0.cardQ_asset_path = "beachguardgameassets/char_Qicon"
var_0_0.map_asset_path = "beachguardgameassets/map"
var_0_0.char_asset_path = "beachguardgameassets/char"
var_0_0.bullet_asset_path = "beachguardgameassets/bullet"
var_0_0.effect_asset_path = "beachguardgameassets/effect"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	return
end

function var_0_0.getCardIcon(arg_2_0)
	return GetSpriteFromAtlas(BeachGuardAsset.card_asset_path, arg_2_0)
end

function var_0_0.getCardQIcon(arg_3_0)
	return GetSpriteFromAtlas(BeachGuardAsset.cardQ_asset_path, arg_3_0)
end

function var_0_0.getBeachMap(arg_4_0)
	return GetSpriteFromAtlas(BeachGuardAsset.map_asset_path, arg_4_0)
end

var_0_0.clearName = {}

function var_0_0.getChar(arg_5_0)
	local var_5_0

	PoolMgr.GetInstance():GetPrefab(BeachGuardAsset.char_asset_path, arg_5_0, false, function(arg_6_0)
		var_5_0 = arg_6_0

		if not table.contains(var_0_0.clearName, arg_5_0) then
			table.insert(var_0_0.clearName, arg_5_0)
		end

		return
	end)

	return tf(nil)
end

function var_0_0.getBullet(arg_7_0)
	local var_7_0

	PoolMgr.GetInstance():GetPrefab(BeachGuardAsset.bullet_asset_path, arg_7_0, false, function(arg_8_0)
		var_7_0 = arg_8_0

		if not table.contains(var_0_0.clearName, arg_7_0) then
			table.insert(var_0_0.clearName, arg_7_0)
		end

		GetOrAddComponent(var_7_0, typeof(CanvasGroup)).blocksRaycasts = false

		return
	end)

	return tf(nil)
end

function var_0_0.getEffect(arg_9_0)
	local var_9_0

	PoolMgr.GetInstance():GetPrefab(BeachGuardAsset.effect_asset_path, arg_9_0, false, function(arg_10_0)
		var_9_0 = arg_10_0

		if not table.contains(var_0_0.clearName, arg_9_0) then
			table.insert(var_0_0.clearName, arg_9_0)
		end

		GetOrAddComponent(var_9_0, typeof(CanvasGroup)).blocksRaycasts = false

		return
	end)

	return tf(nil)
end

function var_0_0.clear()
	for iter_11_0 = 1, #var_0_0.clearName do
		PoolMgr.GetInstance():DestroyPrefab(BeachGuardAsset.char_asset_path, var_0_0.clearName[iter_11_0])
	end

	var_0_0.clearName = {}

	return
end

return var_0_0
