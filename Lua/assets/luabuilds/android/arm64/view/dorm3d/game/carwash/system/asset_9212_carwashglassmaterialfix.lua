local CarWashGlassMaterialFix = class("CarWashGlassMaterialFix", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashGlassMaterialFix.MATERIAL_INDEX = 0
CarWashGlassMaterialFix.OPAQUE_INDEX = 1
CarWashGlassMaterialFix.TRANSPARENT_INDEX = 0
CarWashGlassMaterialFix.GLASS_CONFIG = {
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
CarWashGlassMaterialFix.PHASE_2_VFX = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01/vfx_nxmfglass02"
CarWashGlassMaterialFix.PHASE_2_RENDER = "/[MainBlock]/[Model]/scene_root/no_bake/pre_db_cw_car/pre_db_cw_car01/all/fbx_db_cw_car01_glass01"

function CarWashGlassMaterialFix:OnInit()
	return
end

function CarWashGlassMaterialFix:RegisterEvents()
	self:Bind(CarWashGameFlowSystem.SET_STAINS_COUNT_MAX, function(arg_3_0, arg_3_1)
		self:InitSceneRefs()
		self:RefreshAllGlassMaterialByRegion()

		return
	end)
	self:Bind(CarWashGameFlowSystem.DECREASE_STAINS_COUNT, function(arg_4_0, arg_4_1)
		onNextTick(function()
			self:RefreshAllGlassMaterialByRegion(true)

			return
		end)

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function(arg_6_0)
		self:SetAllGlassTransparent()

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function(arg_7_0)
		self:RefreshAllGlassMaterialByRegion()

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_8_0, arg_8_1)
		if arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			self:SetAllGlassTransparent()
		elseif arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_1 then
			self:RefreshAllGlassMaterialByRegion()
		end

		self:EnablePhase2(arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_2)

		return
	end)

	return
end

function CarWashGlassMaterialFix:OnDispose()
	self.glassInfos = nil

	return
end

function CarWashGlassMaterialFix:InitSceneRefs()
	self.glassInfos = {}

	for iter_10_0, iter_10_1 in ipairs(CarWashGlassMaterialFix.GLASS_CONFIG) do
		local var_10_0 = GameObject.Find(iter_10_1.path)

		assert(var_10_0, "CarWash glass object not found: " .. tostring(iter_10_1.path))

		local var_10_1 = var_10_0:GetComponent(typeof(MaterialSwitcher))

		assert(var_10_1, "MaterialSwitcher component not found on " .. tostring(iter_10_1.path))

		local var_10_2 = GameObject.Find(iter_10_1.region)

		assert(var_10_2, "CarWash glass decal region not found: " .. tostring(iter_10_1.region))

		local var_10_3 = var_10_0.transform:Find(iter_10_1.vfx)

		assert(var_10_3, "CarWash glass vfx not found: " .. tostring(iter_10_1.vfx))
		setActive(var_10_3, false)
		table.insert(self.glassInfos, {
			switcher = var_10_1,
			regionTF = var_10_2.transform,
			vfxTF = var_10_3
		})
	end

	self.phase2VFX = GameObject.Find(CarWashGlassMaterialFix.PHASE_2_VFX)
	self.phase2Render = GameObject.Find(CarWashGlassMaterialFix.PHASE_2_RENDER):GetComponent(typeof(MeshRenderer))

	return
end

function CarWashGlassMaterialFix:RefreshAllGlassMaterialByRegion(arg_11_1)
	if not self.glassInfos then
		return
	end

	for iter_11_0, iter_11_1 in pairs(self.glassInfos) do
		self:SetGlassTransparent(iter_11_1, iter_11_1.regionTF.childCount == 0, arg_11_1)
	end

	return
end

function CarWashGlassMaterialFix:SetAllGlassTransparent()
	if not self.glassInfos then
		return
	end

	for iter_12_0, iter_12_1 in pairs(self.glassInfos) do
		self:SetGlassTransparent(iter_12_1, true)
	end

	return
end

function CarWashGlassMaterialFix:SetGlassTransparent(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 and arg_13_2 and not arg_13_1.isTransparent then
		setActive(arg_13_1.vfxTF, true)
	end

	arg_13_1.switcher:ReplaceMaterial(CarWashGlassMaterialFix.MATERIAL_INDEX, (arg_13_2 or nil) and (CarWashGlassMaterialFix.TRANSPARENT_INDEX or CarWashGlassMaterialFix.OPAQUE_INDEX))

	arg_13_1.isTransparent = arg_13_2

	return
end

function CarWashGlassMaterialFix:EnablePhase2(arg_14_1)
	if self.phase2VFX then
		setActive(self.phase2VFX, arg_14_1)
	end

	if self.phase2Render then
		self.phase2Render.enabled = not arg_14_1
	end

	return
end

return CarWashGlassMaterialFix
