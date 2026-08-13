pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.GuildPaintingMgr = var_0_10001("GuildPaintingMgr")
pg = var_0

local var_0_1 = var_0.GuildPaintingMgr

function var_0_1.Enter(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.isShipPainting = arg_2_3

	arg_2_0:Show()

	if arg_2_0.name == arg_2_1 then
		return
	end

	arg_2_0:Clear()

	if arg_2_0.isShipPainting then
		setPaintingPrefabAsync = var_4

		var_4(arg_2_0._tf, arg_2_1, "chuanwu")
	else
		setGuildPaintingPrefabAsync = var_4

		var_4(arg_2_0._tf, arg_2_1, "chuanwu")
	end

	arg_2_0.name = arg_2_1

	if arg_2_2 then
		arg_2_0._tf.localPosition = arg_2_2
	end

	return
end

function var_0_1.Show(arg_3_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_3_0._tf) then
		setActive = var_1

		var_1(arg_3_0._tf, true)
	end

	return
end

function var_0_1.Hide(arg_4_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_4_0._tf) then
		setActive = var_1

		var_1(arg_4_0._tf, false)
	end

	return
end

function var_0_1.Clear(arg_5_0)
	if arg_5_0.name then
		if arg_5_0.isShipPainting then
			retPaintingPrefab = var_1

			var_1(arg_5_0._tf, arg_5_0.name)
		else
			retGuildPaintingPrefab = var_1

			var_1(arg_5_0._tf, arg_5_0.name)
		end

		arg_5_0.name = nil
	end

	return
end

function var_0_1.Exit(arg_6_0)
	arg_6_0:Clear()

	return
end

return
