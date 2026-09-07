local BeachGuardAsset = class("BeachGuardAsset")

BeachGuardAsset.card_asset_path = "beachguardgameassets/char_icon"
BeachGuardAsset.cardQ_asset_path = "beachguardgameassets/char_Qicon"
BeachGuardAsset.map_asset_path = "beachguardgameassets/map"
BeachGuardAsset.char_asset_path = "beachguardgameassets/char"
BeachGuardAsset.bullet_asset_path = "beachguardgameassets/bullet"
BeachGuardAsset.effect_asset_path = "beachguardgameassets/effect"

function BeachGuardAsset:Ctor(arg_1_1)
	self._tf = arg_1_1

	return
end

function BeachGuardAsset:getCardIcon()
	return GetSpriteFromAtlas(BeachGuardAsset.card_asset_path, self)
end

function BeachGuardAsset:getCardQIcon()
	return GetSpriteFromAtlas(BeachGuardAsset.cardQ_asset_path, self)
end

function BeachGuardAsset:getBeachMap()
	return GetSpriteFromAtlas(BeachGuardAsset.map_asset_path, self)
end

BeachGuardAsset.clearName = {}

function BeachGuardAsset:getChar()
	local var_5_0

	PoolMgr.GetInstance():GetPrefab(BeachGuardAsset.char_asset_path, self, false, function(arg_6_0)
		var_5_0 = arg_6_0

		if not table.contains(BeachGuardAsset.clearName, self) then
			table.insert(BeachGuardAsset.clearName, self)
		end

		return
	end)

	return tf(nil)
end

function BeachGuardAsset:getBullet()
	local var_7_0

	PoolMgr.GetInstance():GetPrefab(BeachGuardAsset.bullet_asset_path, self, false, function(arg_8_0)
		var_7_0 = arg_8_0

		if not table.contains(BeachGuardAsset.clearName, self) then
			table.insert(BeachGuardAsset.clearName, self)
		end

		GetOrAddComponent(var_7_0, typeof(CanvasGroup)).blocksRaycasts = false

		return
	end)

	return tf(nil)
end

function BeachGuardAsset:getEffect()
	local var_9_0

	PoolMgr.GetInstance():GetPrefab(BeachGuardAsset.effect_asset_path, self, false, function(arg_10_0)
		var_9_0 = arg_10_0

		if not table.contains(BeachGuardAsset.clearName, self) then
			table.insert(BeachGuardAsset.clearName, self)
		end

		GetOrAddComponent(var_9_0, typeof(CanvasGroup)).blocksRaycasts = false

		return
	end)

	return tf(nil)
end

function BeachGuardAsset.clear()
	for iter_11_0 = 1, #BeachGuardAsset.clearName do
		PoolMgr.GetInstance():DestroyPrefab(BeachGuardAsset.char_asset_path, BeachGuardAsset.clearName[iter_11_0])
	end

	BeachGuardAsset.clearName = {}

	return
end

return BeachGuardAsset
