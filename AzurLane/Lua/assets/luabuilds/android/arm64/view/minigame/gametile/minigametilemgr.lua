pg = pg or {}
pg.MiniGameTileMgr = singletonClass("MiniGameTileMgr")

function pg.MiniGameTileMgr.Ctor(arg_1_0)
	arg_1_0.tileDatas = {}
	arg_1_0.tileDataDic = {}

	for iter_1_0, iter_1_1 in pairs(MiniGameTile.tiles) do
		local var_1_0 = MiniGameTileData.New(iter_1_1)

		table.insert(arg_1_0.tileDatas, var_1_0)

		arg_1_0.tileDataDic[iter_1_0] = var_1_0
	end

	return
end

function pg.MiniGameTileMgr.getData(arg_2_0, arg_2_1)
	return arg_2_0.tileDataDic[arg_2_1]
end

function pg.MiniGameTileMgr.getDataLayers(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getData(arg_3_1)

	if var_3_0 then
		return var_3_0:getTileDataLayer(arg_3_2)
	end

	return nil
end

function pg.MiniGameTileMgr.dumpDataLayers(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0:getData(arg_4_1)

	if var_4_0 then
		var_4_0:dumpTileDataLayer(arg_4_2, arg_4_3)
	end

	return
end

return
