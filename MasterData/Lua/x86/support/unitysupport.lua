function getSprite(arg_1_0, arg_1_1)
	return AtlasManager.GetSprite(arg_1_0, arg_1_1)
end

function getSpriteWithoutAtlas(arg_2_0)
	return arg_2_0
end

function pureGetSpriteWithoutAtlas(arg_3_0)
	return arg_3_0
end

function getSpriteWithoutAtlasAsync(arg_4_0, arg_4_1)
	AtlasManager.GetSpriteWithoutAtlasAsync(arg_4_0, arg_4_1)
end

function unloadSpriteWithoutAtlas(arg_5_0)
	AtlasManager.UnloadSpriteWithoutAtlas(arg_5_0)
end

function SetSpriteWithoutAtlasAsync(arg_6_0, arg_6_1)
	if isNil(arg_6_0) then
		return
	end

	AtlasManager.GetSpriteWithoutAtlasAsyncNew(arg_6_0, arg_6_1)
end

function getSpriteViaConfig(arg_7_0, arg_7_1)
	local var_7_0 = nullable(SpritePathCfg, arg_7_0, "path")

	if var_7_0 then
		return getSpriteWithoutAtlas(var_7_0 .. arg_7_1)
	end
end

function getSpritePathViaConfig(arg_8_0, arg_8_1)
	local var_8_0 = nullable(SpritePathCfg, arg_8_0, "path")

	if var_8_0 then
		return var_8_0 .. arg_8_1
	end
end
