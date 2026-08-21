module("frameworkext.scene.zone.SceneZoneMgr", package.seeall)

local var_0_0 = class("SceneZoneMgr", SceneComponentBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._curZoneId = 0
	arg_1_0._activeZones = nil
	arg_1_0._firstZones = nil
	arg_1_0._zoneCache = FifoCache.New(0)
	arg_1_0._tempBounds = BoundingBox2D.New()
	arg_1_0._curSceneId = 0
	arg_1_0._tempEmpty = {}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._container = arg_2_0._scene:getContainer()
	arg_2_0._sceneCfgFinder = arg_2_0._scene.cfgFinder
	arg_2_0._unitFactory = arg_2_0._scene.unitFactory
end

function var_0_0.getActiveZone(arg_3_0, arg_3_1)
	return arg_3_0._activeZones[arg_3_1]
end

function var_0_0.onEnterScene(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._activeZones = {}
	arg_4_0._curSceneId = arg_4_1
	arg_4_0._firstZones = {}

	local var_4_0 = arg_4_0:_findZoneId(arg_4_2, arg_4_3)

	if var_4_0 == 0 then
		printError("cannot find zone for pos=", arg_4_2, arg_4_3)

		return
	end

	local var_4_1 = arg_4_0._sceneCfgFinder:findZoneNeighbors(var_4_0)

	if not var_4_1 then
		return
	end

	table.insert(arg_4_0._firstZones, var_4_0)
	table.insertto(arg_4_0._firstZones, var_4_1)
end

function var_0_0._testInZone(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 == 0 then
		return false
	end

	local var_5_0 = arg_5_0._activeZones[arg_5_1]
	local var_5_1

	if not var_5_0 then
		local var_5_2, var_5_3, var_5_4, var_5_5 = arg_5_0._sceneCfgFinder:findBounds(arg_5_1)

		arg_5_0._tempBounds:setBorders(var_5_2, var_5_3, var_5_4, var_5_5)

		if arg_5_0._tempBounds:contains(arg_5_2, arg_5_3) then
			return true
		end
	elseif var_5_0:contains(arg_5_2, arg_5_3) then
		return true
	end

	return false
end

function var_0_0._findZoneId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_0._curZoneId > 0 then
		if arg_6_0:_testInZone(arg_6_0._curZoneId, arg_6_1, arg_6_2) then
			return arg_6_0._curZoneId
		end

		local var_6_1 = arg_6_0._sceneCfgFinder:findZoneNeighbors(arg_6_0._curZoneId)
		local var_6_2 = #var_6_1

		for iter_6_0 = 1, var_6_2 do
			if arg_6_0:_testInZone(var_6_1[iter_6_0], arg_6_1, arg_6_2) then
				return var_6_1[iter_6_0]
			end
		end
	end

	local var_6_3 = arg_6_0._sceneCfgFinder:findSceneZones(arg_6_0._curSceneId)
	local var_6_4 = #var_6_3

	for iter_6_1 = 1, var_6_4 do
		if arg_6_0:_testInZone(var_6_3[iter_6_1], arg_6_1, arg_6_2) then
			return var_6_3[iter_6_1]
		end
	end

	return 0
end

function var_0_0.onExitScene(arg_7_0)
	if arg_7_0._activeZones then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._activeZones) do
			iter_7_1:onExit()
			iter_7_1:onDestroy()
		end

		arg_7_0._activeZones = nil
	end

	local var_7_0 = arg_7_0._zoneCache:fetchAll()
	local var_7_1 = #var_7_0

	for iter_7_2 = 1, var_7_1 do
		var_7_0[iter_7_2]:onDestroy()
	end

	arg_7_0._firstZones = nil
	arg_7_0._curZoneId = 0
	arg_7_0._curSceneId = 0
end

function var_0_0._getOrCreateZone(arg_8_0, arg_8_1)
	return arg_8_0._zoneCache:fetchObject(arg_8_1) or SceneZone.New(arg_8_1, arg_8_0._container, arg_8_0._sceneCfgFinder, arg_8_0._onTerrainLoaded, arg_8_0._onTerrainDestroyed, arg_8_0)
end

function var_0_0.onTargetPosUpdate(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:_findZoneId(arg_9_1, arg_9_2)

	if var_9_0 == 0 then
		printError("cannot find zone for pos=", arg_9_1, arg_9_2)

		return
	end

	if arg_9_0._curZoneId == var_9_0 then
		-- block empty
	else
		local var_9_1 = arg_9_0._sceneCfgFinder:findZoneNeighbors(var_9_0) or arg_9_0._tempEmpty

		table.insert(var_9_1, 1, var_9_0)

		local var_9_2 = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_0._activeZones) do
			if not table.indexof(var_9_1, iter_9_0) then
				table.insert(var_9_2, iter_9_0)
			end
		end

		local var_9_3 = #var_9_2
		local var_9_4
		local var_9_5

		for iter_9_2 = 1, var_9_3 do
			local var_9_6 = var_9_2[iter_9_2]
			local var_9_7 = arg_9_0._activeZones[var_9_6]

			var_9_7:onExit()
			arg_9_0:dispatch(SceneNotify.ExitZone, var_9_6)

			arg_9_0._activeZones[var_9_6] = nil

			local var_9_8 = arg_9_0._zoneCache:putObject(var_9_6, var_9_7)

			if var_9_8 then
				var_9_8:onDestroy()
			end
		end

		local var_9_9 = #var_9_1

		for iter_9_3 = 1, var_9_9 do
			local var_9_10 = var_9_1[iter_9_3]

			if not arg_9_0._activeZones[var_9_10] then
				local var_9_11 = arg_9_0:_getOrCreateZone(var_9_10)

				arg_9_0._activeZones[var_9_10] = var_9_11

				var_9_11:onEnter()
				arg_9_0:dispatch(SceneNotify.EnterZone, var_9_10)
			end
		end

		table.remove(var_9_1, 1)

		arg_9_0._curZoneId = var_9_0
	end
end

function var_0_0._onTerrainDestroyed(arg_10_0, arg_10_1)
	arg_10_0:dispatch(SceneNotify.ZoneDestroyed, arg_10_1)
end

function var_0_0._onTerrainLoaded(arg_11_0, arg_11_1, arg_11_2)
	table.removebyvalue(arg_11_0._firstZones, arg_11_1)
	arg_11_0:dispatch(SceneNotify.ZoneLoaded, arg_11_1, arg_11_2)

	if arg_11_0._firstZones and #arg_11_0._firstZones <= 0 then
		arg_11_0:dispatch(SceneNotify.FirstZonesLoaded)
	end
end

return var_0_0
