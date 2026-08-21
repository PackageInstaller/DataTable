module("frameworkext.scene.zone.SceneZone", package.seeall)

local var_0_0 = class("SceneZone")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.id = arg_1_1
	arg_1_0._sceneCfgFinder = arg_1_3
	arg_1_0._container = arg_1_2
	arg_1_0._res = nil
	arg_1_0._inst = nil
	arg_1_0._bounds = BoundingBox2D.New()

	local var_1_0, var_1_1, var_1_2, var_1_3 = arg_1_0._sceneCfgFinder:findBounds(arg_1_1)

	arg_1_0._bounds:setBorders(var_1_0, var_1_1, var_1_2, var_1_3)

	arg_1_0._terrainResUrl = nil
	arg_1_0._loadedCallback = arg_1_4
	arg_1_0._destroyedCallback = arg_1_5
	arg_1_0._callbackObj = arg_1_6
end

function var_0_0.contains(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_0._bounds:contains(arg_2_1, arg_2_2)
end

function var_0_0.getZoneGo(arg_3_0)
	return arg_3_0._inst
end

function var_0_0._onTerrainLoaded(arg_4_0, arg_4_1)
	if arg_4_1.IsSuccess then
		arg_4_0._res = arg_4_1

		arg_4_0._res:Retain()

		local var_4_0 = arg_4_1:GetMainAsset()

		arg_4_0._inst = goutil.clone(var_4_0)

		goutil.addChildToParent(arg_4_0._inst, arg_4_0._container)

		if arg_4_0._loadedCallback then
			arg_4_0._loadedCallback(arg_4_0._callbackObj, arg_4_0.id, arg_4_0._inst)
		end
	end
end

function var_0_0.onEnter(arg_5_0)
	if not arg_5_0._terrainResUrl then
		arg_5_0._terrainResUrl = arg_5_0._sceneCfgFinder:findTerrainResUrl(arg_5_0.id)

		getres(arg_5_0._terrainResUrl, arg_5_0._onTerrainLoaded, arg_5_0, ResType.AssetBunble, true)
	end
end

function var_0_0.onExit(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	if arg_7_0._res == nil then
		if arg_7_0._terrainResUrl then
			rescache:RemoveListener(arg_7_0._terrainResUrl, arg_7_0._onTerrainLoaded, arg_7_0)
		end
	else
		goutil.destroy(arg_7_0._inst)

		arg_7_0._inst = nil

		arg_7_0._res:Release()

		arg_7_0._res = nil

		if arg_7_0._destroyedCallback then
			arg_7_0._destroyedCallback(arg_7_0._callbackObj, arg_7_0.id)
		end
	end

	arg_7_0._sceneCfgFinder = nil
	arg_7_0._container = nil
	arg_7_0._terrainResUrl = nil
end

return var_0_0
