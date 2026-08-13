pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.MiniGameTileMgr = var_0_10001("MiniGameTileMgr")

local var_0_1 = var_0.MiniGameTileMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0.tileDatas = {}
	arg_1_0.tileDataDic = {}
	MiniGameTile = var_1

	local var_1_0 = var_1.tiles

	pairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_1_0) do
		MiniGameTileData = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1)
		table = var_1_10008

		var_1_10008.insert(arg_1_0.tileDatas, var_1_10007)

		var_1_10008 = arg_1_0.tileDataDic
		var_1_10008[iter_1_0] = var_1_10007
	end

	return
end

function var_0_1.getData(arg_2_0, arg_2_1)
	return arg_2_0.tileDataDic[arg_2_1]
end

function var_0_1.getDataLayers(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0:getData(arg_3_1) then
		return var_3:getTileDataLayer(arg_3_2)
	end

	return nil
end

function var_0_1.dumpDataLayers(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0:getData(arg_4_1) then
		var_4:dumpTileDataLayer(arg_4_2, arg_4_3)
	end

	return
end

return
