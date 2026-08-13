class = var_0_10000

local var_0_0 = "CarWashGlassMaterialFix"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.MATERIAL_INDEX = 0
var_0_1.OPAQUE_INDEX = 1
var_0_1.TRANSPARENT_INDEX = 0
var_0_1.GLASS_CONFIG = {
	{
		vfx = "vfx_nxmfdoorglass01_l",
		region = "/[DECALROOT]/[DECAL GENERATOR]/[RandomDecals]/Region_18",
		path = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_doorglass01_l"
	},
	{
		vfx = "vfx_nxmfdoorglass01_r",
		region = "/[DECALROOT]/[DECAL GENERATOR]/[RandomDecals]/Region_19",
		path = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_doorglass01_r"
	},
	{
		vfx = "vfx_nxmfglass01",
		region = "/[DECALROOT]/[DECAL GENERATOR]/[RandomDecals]/Region_17",
		path = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01"
	}
}
var_0_1.PHASE_2_VFX = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01/vfx_nxmfglass02"
var_0_1.PHASE_2_RENDER = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01"

function var_0_1.OnInit(arg_1_0)
	return
end

function var_0_1.RegisterEvents(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.Bind

	CarWashGameFlowSystem = var_1_10004

	var_2_1(var_2_0, var_1_10004.SET_STAINS_COUNT_MAX, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.InitSceneRefs(var_3_0)

		local var_3_1 = arg_2_0

		var_2.RefreshAllGlassMaterialByRegion(var_3_1)

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_3(var_2_2, var_4.DECREASE_STAINS_COUNT, function(arg_4_0, arg_4_1)
		onNextTick = var_2_10002

		var_2_10002(function()
			local var_5_0 = arg_2_0

			var_0.RefreshAllGlassMaterialByRegion(var_5_0, true)

			return
		end)

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_5(var_2_4, var_4.TIMELINE_SEQUENCE_BEGIN, function(arg_6_0)
		local var_6_0 = arg_2_0

		var_1.SetAllGlassTransparent(var_6_0)

		return
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_7(var_2_6, var_4.TIMELINE_SEQUENCE_END, function(arg_7_0)
		local var_7_0 = arg_2_0

		var_1.RefreshAllGlassMaterialByRegion(var_7_0)

		return
	end)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_9(var_2_8, var_4.UPDATE_GAME_STATE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1.newValue

		CarWashConst = var_2_10003

		if var_8_0 == var_2_10003.GAME_STATE.PHASE_2 then
			local var_8_1 = arg_2_0

			var_2.SetAllGlassTransparent(var_8_1)
		else
			local var_8_2 = arg_8_1.newValue

			CarWashConst = var_3

			if var_8_2 == var_3.GAME_STATE.PHASE_1 then
				local var_8_3 = arg_2_0

				var_2.RefreshAllGlassMaterialByRegion(var_8_3)
			end
		end

		local var_8_4 = arg_2_0
		local var_8_5 = var_2.EnablePhase2
		local var_8_6 = arg_8_1.newValue

		CarWashConst = var_2_10006

		var_8_5(var_8_4, var_8_6 == var_2_10006.GAME_STATE.PHASE_2)

		return
	end)

	return
end

function var_0_1.OnDispose(arg_9_0)
	arg_9_0.glassInfos = nil

	return
end

function var_0_1.InitSceneRefs(arg_10_0)
	arg_10_0.glassInfos = {}
	ipairs = var_1

	for iter_10_0, iter_10_1 in var_1(var_0_1.GLASS_CONFIG) do
		GameObject = var_1_10006
		var_1_10006 = var_1_10006.Find(iter_10_1.path)
		assert = var_1_10007

		local var_10_0 = var_1_10006
		local var_10_1 = "CarWash glass object not found: "

		tostring = var_1_10011

		var_1_10007(var_10_0, var_10_1 .. var_1_10011(iter_10_1.path))

		var_1_10007 = var_1_10006.transform

		local var_10_2 = var_1_10006
		local var_10_3 = var_1_10006.GetComponent

		typeof = var_1_10011
		MaterialSwitcher = var_13

		local var_10_4 = var_10_3(var_10_2, var_1_10011(var_13))

		assert = var_10_0
		var_1_10011 = var_10_4

		local var_10_5 = "MaterialSwitcher component not found on "

		tostring = var_13

		var_10_0(var_1_10011, var_10_5 .. var_13(iter_10_1.path))

		GameObject = var_10_0

		local var_10_6 = var_10_0.Find(iter_10_1.region)

		assert = var_10_2

		local var_10_7 = var_10_6
		local var_10_8 = "CarWash glass decal region not found: "

		tostring = var_1_10014

		var_10_2(var_10_7, var_10_8 .. var_1_10014(iter_10_1.region))

		local var_10_9 = var_1_10007:Find(iter_10_1.vfx)

		assert = var_1_10011

		local var_10_10 = var_10_9

		var_1_10014 = "CarWash glass vfx not found: "
		tostring = var_15

		var_1_10011(var_10_10, var_1_10014 .. var_15(iter_10_1.vfx))

		setActive = var_1_10011

		var_1_10011(var_10_9, false)

		table = var_1_10011

		var_1_10011.insert(arg_10_0.glassInfos, {
			switcher = var_10_4,
			regionTF = var_10_6.transform,
			vfxTF = var_10_9
		})
	end

	GameObject = var_1
	arg_10_0.phase2VFX = var_1.Find(var_0_1.PHASE_2_VFX)
	GameObject = var_1

	local var_10_11 = var_1.Find(var_0_1.PHASE_2_RENDER)
	local var_10_12 = var_1.GetComponent

	typeof = iter_10_0
	MeshRenderer = var_1_10006
	arg_10_0.phase2Render = var_10_12(var_10_11, iter_10_0(var_1_10006))

	return
end

function var_0_1.RefreshAllGlassMaterialByRegion(arg_11_0, arg_11_1)
	if not arg_11_0.glassInfos then
		return
	end

	pairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_0.glassInfos) do
		arg_11_0:SetGlassTransparent(iter_11_1, iter_11_1.regionTF.childCount == 0, arg_11_1)
	end

	return
end

function var_0_1.SetAllGlassTransparent(arg_12_0)
	if not arg_12_0.glassInfos then
		return
	end

	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.glassInfos) do
		arg_12_0:SetGlassTransparent(iter_12_1, true)
	end

	return
end

function var_0_1.SetGlassTransparent(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 and arg_13_2 and not arg_13_1.isTransparent then
		setActive = var_4

		var_4(arg_13_1.vfxTF, true)
	end

	local var_13_0

	if not arg_13_2 or not var_0_1.TRANSPARENT_INDEX then
		var_13_0 = var_0_1.OPAQUE_INDEX
	end

	local var_13_1 = arg_13_1.switcher

	var_5.ReplaceMaterial(var_13_1, var_0_1.MATERIAL_INDEX, var_13_0)

	arg_13_1.isTransparent = arg_13_2

	return
end

function var_0_1.EnablePhase2(arg_14_0, arg_14_1)
	if arg_14_0.phase2VFX then
		setActive = var_2

		var_2(arg_14_0.phase2VFX, arg_14_1)
	end

	if arg_14_0.phase2Render then
		arg_14_0.phase2Render.enabled = not arg_14_1
	end

	return
end

return var_0_1
