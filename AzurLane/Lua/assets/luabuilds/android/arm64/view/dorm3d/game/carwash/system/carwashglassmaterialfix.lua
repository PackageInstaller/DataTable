local var_0_0 = class("CarWashGlassMaterialFix", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_0.MATERIAL_INDEX = 0
var_0_0.OPAQUE_INDEX = 1
var_0_0.TRANSPARENT_INDEX = 0
var_0_0.GLASS_CONFIG = {
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
var_0_0.PHASE_2_VFX = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01/vfx_nxmfglass02"
var_0_0.PHASE_2_RENDER = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01"

function var_0_0.OnInit(arg_1_0)
	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(CarWashGameFlowSystem.SET_STAINS_COUNT_MAX, function(arg_3_0, arg_3_1)
		arg_2_0:InitSceneRefs()
		arg_2_0:RefreshAllGlassMaterialByRegion()

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.DECREASE_STAINS_COUNT, function(arg_4_0, arg_4_1)
		onNextTick(function()
			arg_2_0:RefreshAllGlassMaterialByRegion(true)

			return
		end)

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function(arg_6_0)
		arg_2_0:SetAllGlassTransparent()

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function(arg_7_0)
		arg_2_0:RefreshAllGlassMaterialByRegion()

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_8_0, arg_8_1)
		if arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			arg_2_0:SetAllGlassTransparent()
		elseif arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_1 then
			arg_2_0:RefreshAllGlassMaterialByRegion()
		end

		arg_2_0:EnablePhase2(arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_2)

		return
	end)

	return
end

function var_0_0.OnDispose(arg_9_0)
	arg_9_0.glassInfos = nil

	return
end

function var_0_0.InitSceneRefs(arg_10_0)
	arg_10_0.glassInfos = {}

	for iter_10_0, iter_10_1 in ipairs(var_0_0.GLASS_CONFIG) do
		local var_10_0 = GameObject.Find(iter_10_1.path)

		assert(var_10_0, "CarWash glass object not found: " .. tostring(iter_10_1.path))

		local var_10_1 = var_10_0:GetComponent(typeof(MaterialSwitcher))

		assert(var_10_1, "MaterialSwitcher component not found on " .. tostring(iter_10_1.path))

		local var_10_2 = GameObject.Find(iter_10_1.region)

		assert(var_10_2, "CarWash glass decal region not found: " .. tostring(iter_10_1.region))

		local var_10_3 = var_10_0.transform:Find(iter_10_1.vfx)

		assert(var_10_3, "CarWash glass vfx not found: " .. tostring(iter_10_1.vfx))
		setActive(var_10_3, false)
		table.insert(arg_10_0.glassInfos, {
			switcher = var_10_1,
			regionTF = var_10_2.transform,
			vfxTF = var_10_3
		})
	end

	arg_10_0.phase2VFX = GameObject.Find(var_0_0.PHASE_2_VFX)
	arg_10_0.phase2Render = GameObject.Find(var_0_0.PHASE_2_RENDER):GetComponent(typeof(MeshRenderer))

	return
end

function var_0_0.RefreshAllGlassMaterialByRegion(arg_11_0, arg_11_1)
	if not arg_11_0.glassInfos then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.glassInfos) do
		arg_11_0:SetGlassTransparent(iter_11_1, iter_11_1.regionTF.childCount == 0, arg_11_1)
	end

	return
end

function var_0_0.SetAllGlassTransparent(arg_12_0)
	if not arg_12_0.glassInfos then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.glassInfos) do
		arg_12_0:SetGlassTransparent(iter_12_1, true)
	end

	return
end

function var_0_0.SetGlassTransparent(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 and arg_13_2 and not arg_13_1.isTransparent then
		setActive(arg_13_1.vfxTF, true)
	end

	if arg_13_2 then
		local var_13_0 = var_0_0.TRANSPARENT_INDEX or var_0_0.OPAQUE_INDEX

		arg_13_1.switcher:ReplaceMaterial(var_0_0.MATERIAL_INDEX, var_13_0)

		arg_13_1.isTransparent = arg_13_2

		return
	end
end

function var_0_0.EnablePhase2(arg_14_0, arg_14_1)
	if arg_14_0.phase2VFX then
		setActive(arg_14_0.phase2VFX, arg_14_1)
	end

	if arg_14_0.phase2Render then
		arg_14_0.phase2Render.enabled = not arg_14_1
	end

	return
end

return var_0_0
