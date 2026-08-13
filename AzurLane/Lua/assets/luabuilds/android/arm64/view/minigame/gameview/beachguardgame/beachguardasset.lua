class = var_0_10000

local var_0_0 = var_0_10000("BeachGuardAsset")

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
	GetSpriteFromAtlas = var_1_10001
	BeachGuardAsset = var_1_10003

	return var_1_10001(var_1_10003.card_asset_path, arg_2_0)
end

function var_0_0.getCardQIcon(arg_3_0)
	GetSpriteFromAtlas = var_1_10001
	BeachGuardAsset = var_1_10003

	return var_1_10001(var_1_10003.cardQ_asset_path, arg_3_0)
end

function var_0_0.getBeachMap(arg_4_0)
	GetSpriteFromAtlas = var_1_10001
	BeachGuardAsset = var_1_10003

	return var_1_10001(var_1_10003.map_asset_path, arg_4_0)
end

var_0_0.clearName = {}

function var_0_0.getChar(arg_5_0)
	local var_5_0

	PoolMgr = var_1_10002

	local var_5_1 = var_1_10002.GetInstance()
	local var_5_2 = var_2.GetPrefab

	BeachGuardAsset = var_1_10005

	var_5_2(var_5_1, var_1_10005.char_asset_path, arg_5_0, false, function(arg_6_0)
		var_5_0 = arg_6_0
		table = var_2_10001

		if not var_2_10001.contains(var_0_0.clearName, arg_5_0) then
			table = var_1

			var_1.insert(var_0_0.clearName, arg_5_0)
		end

		return
	end)

	tf = var_5_2

	return var_5_2(var_5_0)
end

function var_0_0.getBullet(arg_7_0)
	local var_7_0

	PoolMgr = var_1_10002

	local var_7_1 = var_1_10002.GetInstance()
	local var_7_2 = var_2.GetPrefab

	BeachGuardAsset = var_1_10005

	var_7_2(var_7_1, var_1_10005.bullet_asset_path, arg_7_0, false, function(arg_8_0)
		var_7_0 = arg_8_0
		table = var_2_10001

		if not var_2_10001.contains(var_0_0.clearName, arg_7_0) then
			table = var_1

			var_1.insert(var_0_0.clearName, arg_7_0)
		end

		GetOrAddComponent = var_1

		local var_8_0 = var_7_0

		typeof = var_4
		CanvasGroup = var_2_10006
		var_1(var_8_0, var_4(var_2_10006)).blocksRaycasts = false

		return
	end)

	tf = var_7_2

	return var_7_2(var_7_0)
end

function var_0_0.getEffect(arg_9_0)
	local var_9_0

	PoolMgr = var_1_10002

	local var_9_1 = var_1_10002.GetInstance()
	local var_9_2 = var_2.GetPrefab

	BeachGuardAsset = var_1_10005

	var_9_2(var_9_1, var_1_10005.effect_asset_path, arg_9_0, false, function(arg_10_0)
		var_9_0 = arg_10_0
		table = var_2_10001

		if not var_2_10001.contains(var_0_0.clearName, arg_9_0) then
			table = var_1

			var_1.insert(var_0_0.clearName, arg_9_0)
		end

		GetOrAddComponent = var_1

		local var_10_0 = var_9_0

		typeof = var_4
		CanvasGroup = var_2_10006
		var_1(var_10_0, var_4(var_2_10006)).blocksRaycasts = false

		return
	end)

	tf = var_9_2

	return var_9_2(var_9_0)
end

function var_0_0.clear()
	for iter_11_0 = 1, #var_0_0.clearName do
		PoolMgr = var_1_10004

		local var_11_0 = var_1_10004.GetInstance()

		var_1_10004 = var_1_10004.DestroyPrefab
		BeachGuardAsset = var_1_10007

		var_1_10004(var_11_0, var_1_10007.char_asset_path, var_0_0.clearName[iter_11_0])
	end

	var_0_0.clearName = {}

	return
end

return var_0_0
