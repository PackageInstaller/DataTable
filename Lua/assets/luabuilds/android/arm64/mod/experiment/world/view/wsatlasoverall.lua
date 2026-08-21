local var_0_0 = class("WSAtlasOverall", import(".WSAtlas"))

var_0_0.windowSize = Vector2(1747, 776)
var_0_0.Fields = {
	tfMarkScene = "userdata",
	tfActiveMarkRect = "userdata"
}
var_0_0.Listeners = {
	onUpdateActiveEntrance = "OnUpdateActiveEntrance"
}

function var_0_0.Dispose(arg_1_0)
	if arg_1_0.tfActiveMarkRect then
		arg_1_0:RemoveExtraMarkPrefab(arg_1_0.tfActiveMarkRect)
		Destroy(arg_1_0.tfActiveMarkRect)
	end

	arg_1_0:RemoveExtraMarkPrefab(arg_1_0.tfMarkScene)
	var_0_0.super.Dispose(arg_1_0)

	return
end

function var_0_0.LoadScene(arg_2_0, arg_2_1)
	gcAll(true)
	SceneOpMgr.Inst:LoadSceneAsync("scenes/worldoverview", "WorldOverview", LoadSceneMode.Additive, function(arg_3_0, arg_3_1)
		arg_2_0.transform = tf(arg_3_0:GetRootGameObjects()[0])

		setActive(arg_2_0.transform, false)

		arg_2_0.tfEntity = arg_2_0.transform:Find("entity")
		arg_2_0.tfMapScene = arg_2_0.tfEntity:Find("map_scene")
		arg_2_0.tfMapSelect = arg_2_0.tfMapScene:Find("selected_layer")
		arg_2_0.tfSpriteScene = arg_2_0.tfEntity:Find("sprite_scene")
		arg_2_0.tfMarkScene = arg_2_0.tfEntity:Find("mark_scene")
		arg_2_0.defaultSprite = arg_2_0.tfEntity:Find("decolation_layer/edge"):GetComponent("SpriteRenderer").material
		arg_2_0.addSprite = arg_2_0.tfEntity:Find("map_scene/mask_layer"):GetComponent("SpriteRenderer").material

		arg_2_0:UpdateCenterEffectDisplay()
		arg_2_0:BuildActiveMark()

		arg_2_0.cmPointer = arg_2_0.tfEntity:Find("Plane"):GetComponent(typeof(PointerInfo))

		local var_3_0 = nowWorld()

		arg_2_0.cmPointer:AddColorMaskClickListener(function(arg_4_0, arg_4_1)
			local var_4_0 = var_3_0:ColorToEntrance(arg_4_0)

			if var_4_0 then
				arg_2_0.onClickColor(var_4_0, arg_4_1.position)
			end

			return
		end)

		arg_2_0.tfCamera = arg_2_0.transform:Find("Main Camera")

		CameraFittingSettin(arg_2_0.tfCamera)

		return existCall(arg_2_1)
	end)

	return
end

function var_0_0.ReturnScene(arg_5_0)
	if arg_5_0.tfEntity then
		SceneOpMgr.Inst:UnloadSceneAsync("scenes/worldoverview", "WorldOverview")

		arg_5_0.cmPointer = nil
	end

	return
end

function var_0_0.BuildActiveMark(arg_6_0)
	var_0_0.super.BuildActiveMark(arg_6_0)
	arg_6_0:DoUpdatExtraMark(arg_6_0.tfActiveMark, "overview_player", true)

	arg_6_0.tfActiveMarkRect = tf(GameObject.New())
	arg_6_0.tfActiveMarkRect.gameObject.layer = Layer.UI
	arg_6_0.tfActiveMarkRect.name = "active_mark_rect"

	arg_6_0.tfActiveMarkRect:SetParent(arg_6_0.tfSpriteScene, false)
	setActive(arg_6_0.tfActiveMarkRect, false)
	arg_6_0:DoUpdatExtraMark(arg_6_0.tfActiveMarkRect, "overview_player_rect", true)

	return
end

function var_0_0.OnUpdateActiveEntrance(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.super.OnUpdateActiveEntrance(arg_7_0, arg_7_1, arg_7_2, arg_7_3)

	if arg_7_3 then
		arg_7_0.tfActiveMarkRect.localPosition = arg_7_0.tfActiveMark.localPosition
	end

	setActive(arg_7_0.tfActiveMarkRect, arg_7_3)

	return
end

function var_0_0.UpdateStaticMark(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RemoveExtraMarkPrefab(arg_8_0.tfMarkScene)

	for iter_8_0, iter_8_1 in pairs(arg_8_1 or {}) do
		if iter_8_1 then
			local var_8_0 = arg_8_0.atlas:GetEntrance(iter_8_0)

			if var_8_0:HasPort() then
				local var_8_1 = arg_8_2[1] or arg_8_2[2]

				if var_8_1 then
					arg_8_0:LoadExtraMarkPrefab(arg_8_0.tfMarkScene, var_8_1, function(arg_9_0)
						tf(arg_9_0).localPosition = WorldConst.CalcModelPosition(var_8_0, arg_8_0.spriteBaseSize)

						return
					end)
				end
			end
		end
	end

	var_0_0.super.UpdateStaticMark(arg_8_0, arg_8_1)

	return
end

function var_0_0.UpdateTargetEntrance(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.atlas:GetEntrance(arg_10_1)
	local var_10_1 = arg_10_0.atlas:GetActiveEntrance()

	arg_10_0.tfActiveMark.localEulerAngles = Vector3(0, calcPositionAngle(var_10_0.config.area_pos[1] - var_10_1.config.area_pos[1], var_10_0.config.area_pos[2] - var_10_1.config.area_pos[2]), 0)

	return
end

return var_0_0
