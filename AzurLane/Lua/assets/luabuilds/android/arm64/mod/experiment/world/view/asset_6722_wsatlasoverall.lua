class = var_0_10000

local var_0_0 = "WSAtlasOverall"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WSAtlas"))

Vector2 = var_0_10001
var_0_1.windowSize = var_0_10001(1747, 776)
var_0_1.Fields = {
	tfMarkScene = "userdata",
	tfActiveMarkRect = "userdata"
}
var_0_1.Listeners = {
	onUpdateActiveEntrance = "OnUpdateActiveEntrance"
}

function var_0_1.Dispose(arg_1_0)
	if arg_1_0.tfActiveMarkRect then
		arg_1_0:RemoveExtraMarkPrefab(arg_1_0.tfActiveMarkRect)

		Destroy = var_1

		var_1(arg_1_0.tfActiveMarkRect)
	end

	arg_1_0:RemoveExtraMarkPrefab(arg_1_0.tfMarkScene)
	var_0_1.super.Dispose(arg_1_0)

	return
end

function var_0_1.LoadScene(arg_2_0, arg_2_1)
	gcAll = var_1_10002

	var_1_10002(true)

	SceneOpMgr = var_1_10002

	local var_2_0 = var_1_10002.Inst
	local var_2_1 = var_2.LoadSceneAsync
	local var_2_2 = "scenes/worldoverview"
	local var_2_3 = "WorldOverview"

	LoadSceneMode = var_1_10007

	var_2_1(var_2_0, var_2_2, var_2_3, var_1_10007.Additive, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		tf = var_2_10003
		var_3_0.transform = var_2_10003(arg_3_0:GetRootGameObjects()[0])
		setActive = var_3_0

		var_3_0(arg_2_0.transform, false)

		local var_3_1 = arg_2_0
		local var_3_2 = arg_2_0.transform

		var_3_1.tfEntity = var_3.Find(var_3_2, "entity")

		local var_3_3 = arg_2_0
		local var_3_4 = arg_2_0.tfEntity

		var_3_3.tfMapScene = var_3.Find(var_3_4, "map_scene")

		local var_3_5 = arg_2_0
		local var_3_6 = arg_2_0.tfMapScene

		var_3_5.tfMapSelect = var_3.Find(var_3_6, "selected_layer")

		local var_3_7 = arg_2_0
		local var_3_8 = arg_2_0.tfEntity

		var_3_7.tfSpriteScene = var_3.Find(var_3_8, "sprite_scene")

		local var_3_9 = arg_2_0
		local var_3_10 = arg_2_0.tfEntity

		var_3_9.tfMarkScene = var_3.Find(var_3_10, "mark_scene")

		local var_3_11 = arg_2_0
		local var_3_12 = arg_2_0.tfEntity
		local var_3_13 = var_3.Find(var_3_12, "decolation_layer/edge")

		var_3_11.defaultSprite = var_3.GetComponent(var_3_13, "SpriteRenderer").material

		local var_3_14 = arg_2_0
		local var_3_15 = arg_2_0.tfEntity
		local var_3_16 = var_3.Find(var_3_15, "map_scene/mask_layer")

		var_3_14.addSprite = var_3.GetComponent(var_3_16, "SpriteRenderer").material

		local var_3_17 = arg_2_0

		var_2.UpdateCenterEffectDisplay(var_3_17)

		local var_3_18 = arg_2_0

		var_2.BuildActiveMark(var_3_18)

		local var_3_19 = arg_2_0
		local var_3_20 = arg_2_0.tfEntity
		local var_3_21 = var_3.Find(var_3_20, "Plane")
		local var_3_22 = var_3.GetComponent

		typeof = var_6
		PointerInfo = var_2_10008
		var_3_19.cmPointer = var_3_22(var_3_21, var_6(var_2_10008))
		nowWorld = var_3_19

		local var_3_23 = var_3_19()
		local var_3_24 = arg_2_0.cmPointer

		var_3.AddColorMaskClickListener(var_3_24, function(arg_4_0, arg_4_1)
			local var_4_0 = var_3_23

			if var_2.ColorToEntrance(var_4_0, arg_4_0) then
				arg_2_0.onClickColor(var_2, arg_4_1.position)
			end

			return
		end)

		local var_3_25 = arg_2_0
		local var_3_26 = arg_2_0.transform

		var_3_25.tfCamera = var_4.Find(var_3_26, "Main Camera")
		CameraFittingSettin = var_3_25

		var_3_25(arg_2_0.tfCamera)

		existCall = var_3_25

		return var_3_25(arg_2_1)
	end)

	return
end

function var_0_1.ReturnScene(arg_5_0)
	if arg_5_0.tfEntity then
		SceneOpMgr = var_1

		local var_5_0 = var_1.Inst

		var_1.UnloadSceneAsync(var_5_0, "scenes/worldoverview", "WorldOverview")

		arg_5_0.cmPointer = nil
	end

	return
end

function var_0_1.BuildActiveMark(arg_6_0)
	var_0_1.super.BuildActiveMark(arg_6_0)

	local var_6_0 = arg_6_0

	arg_6_0.DoUpdatExtraMark(var_6_0, arg_6_0.tfActiveMark, "overview_player", true)

	tf = var_1
	GameObject = var_6_0
	arg_6_0.tfActiveMarkRect = var_1(var_6_0.New())

	local var_6_1 = arg_6_0.tfActiveMarkRect.gameObject

	Layer = var_1_10002
	var_6_1.layer = var_1_10002.UI
	arg_6_0.tfActiveMarkRect.name = "active_mark_rect"

	local var_6_2 = arg_6_0.tfActiveMarkRect

	var_1.SetParent(var_6_2, arg_6_0.tfSpriteScene, false)

	setActive = var_1

	var_1(arg_6_0.tfActiveMarkRect, false)
	arg_6_0:DoUpdatExtraMark(arg_6_0.tfActiveMarkRect, "overview_player_rect", true)

	return
end

function var_0_1.OnUpdateActiveEntrance(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_1.super.OnUpdateActiveEntrance(arg_7_0, arg_7_1, arg_7_2, arg_7_3)

	local var_7_0

	if arg_7_3 then
		var_7_0 = arg_7_0.tfActiveMarkRect
		var_7_0.localPosition = arg_7_0.tfActiveMark.localPosition
	end

	setActive = var_7_0

	var_7_0(arg_7_0.tfActiveMarkRect, arg_7_3)

	return
end

function var_0_1.UpdateStaticMark(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RemoveExtraMarkPrefab(arg_8_0.tfMarkScene)

	pairs = var_3

	for iter_8_0, iter_8_1 in var_3(arg_8_1 or {}) do
		if iter_8_1 then
			local var_8_0 = arg_8_0.atlas
			local var_8_1 = var_8.GetEntrance(var_8_0, iter_8_0)
			local var_8_2

			if not var_8.HasPort(var_8_1) or not arg_8_2[1] then
				var_8_2 = arg_8_2[2]
			end

			if var_8_2 then
				arg_8_0:LoadExtraMarkPrefab(arg_8_0.tfMarkScene, var_8_2, function(arg_9_0)
					tf = var_2_10001

					local var_9_0 = var_2_10001(arg_9_0)

					WorldConst = var_2_10002
					var_9_0.localPosition = var_2_10002.CalcModelPosition(var_0, arg_8_0.spriteBaseSize)

					return
				end)
			end
		end
	end

	var_0_1.super.UpdateStaticMark(arg_8_0, arg_8_1)

	return
end

function var_0_1.UpdateTargetEntrance(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.atlas
	local var_10_1 = var_2.GetEntrance(var_10_0, arg_10_1)
	local var_10_2 = arg_10_0.atlas
	local var_10_3 = var_3.GetActiveEntrance(var_10_2)

	calcPositionAngle = var_10_0

	local var_10_4 = var_10_0(var_10_1.config.area_pos[1] - var_10_3.config.area_pos[1], var_10_1.config.area_pos[2] - var_10_3.config.area_pos[2])
	local var_10_5 = arg_10_0.tfActiveMark

	Vector3 = var_6
	var_10_5.localEulerAngles = var_6(0, var_10_4, 0)

	return
end

return var_0_1
