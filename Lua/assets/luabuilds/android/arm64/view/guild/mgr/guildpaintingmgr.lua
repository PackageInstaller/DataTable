pg = pg or {}
pg.GuildPaintingMgr = singletonClass("GuildPaintingMgr")

function pg.GuildPaintingMgr.Enter(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	return
end

function pg.GuildPaintingMgr.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.isShipPainting = arg_2_3

	arg_2_0:Show()

	if arg_2_0.name == arg_2_1 then
		return
	end

	arg_2_0:Clear()

	if arg_2_0.isShipPainting then
		setPaintingPrefabAsync(arg_2_0._tf, arg_2_1, "chuanwu")
	else
		setGuildPaintingPrefabAsync(arg_2_0._tf, arg_2_1, "chuanwu")
	end

	arg_2_0.name = arg_2_1

	if arg_2_2 then
		arg_2_0._tf.localPosition = arg_2_2
	end

	return
end

function pg.GuildPaintingMgr.Show(arg_3_0)
	if not IsNil(arg_3_0._tf) then
		setActive(arg_3_0._tf, true)
	end

	return
end

function pg.GuildPaintingMgr.Hide(arg_4_0)
	if not IsNil(arg_4_0._tf) then
		setActive(arg_4_0._tf, false)
	end

	return
end

function pg.GuildPaintingMgr.Clear(arg_5_0)
	if arg_5_0.name then
		if arg_5_0.isShipPainting then
			retPaintingPrefab(arg_5_0._tf, arg_5_0.name)
		else
			retGuildPaintingPrefab(arg_5_0._tf, arg_5_0.name)
		end

		arg_5_0.name = nil
	end

	return
end

function pg.GuildPaintingMgr.Exit(arg_6_0)
	arg_6_0:Clear()

	return
end

return
