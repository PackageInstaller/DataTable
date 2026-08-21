local var_0_0 = class("EnemyAvatarView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	if var_0_0.outlinePropID == nil then
		var_0_0.outlinePropID = UnityEngine.Shader.PropertyToID("_OutlineThickness")
	end

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.playable_ = arg_3_0:FindCom(typeof(PlayableDirector), "")
	arg_3_0.backGo_ = arg_3_0:FindGo("back")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddDragListener(arg_4_0.backGo_, function()
		if arg_4_0.bossModel_ then
			arg_4_0.startRot_ = arg_4_0.rotaNote_.localEulerAngles
		else
			arg_4_0.startRot_ = Vector3.zero
		end

		arg_4_0.lastDeltaX_ = 0
	end, function(arg_6_0, arg_6_1)
		if arg_4_0.bossModel_ then
			local var_6_0 = arg_4_0.lastRotateY_ or arg_4_0.rotaNote_.localEulerAngles.y

			if var_6_0 > 180 then
				var_6_0 = var_6_0 - 360
			end

			local var_6_1 = var_6_0 + (arg_6_0 - (arg_4_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0
			local var_6_2 = var_6_1

			if var_6_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_6_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_6_1 > HeroConst.MAX_RORATE_ANGLE then
				var_6_2 = HeroConst.MAX_RORATE_ANGLE
			end

			local var_6_3 = var_6_0 + var_6_2

			if var_6_3 < arg_4_0.rot_limit_[1] then
				var_6_3 = arg_4_0.rot_limit_[1]
			elseif var_6_3 > arg_4_0.rot_limit_[2] then
				var_6_3 = arg_4_0.rot_limit_[2]
			end

			arg_4_0.lastRotateY_ = var_6_3
			arg_4_0.lastDeltaX_ = arg_6_0
			arg_4_0.rotaNote_.localRotation = Quaternion.RotateTowards(arg_4_0.rotaNote_.localRotation, Quaternion.Euler(arg_4_0.startRot_.x, var_6_3, arg_4_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:InitBackScene()
end

function var_0_0.OnExit(arg_8_0)
	if arg_8_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_8_0.backGround_, ASSET_TYPE.SCENE)
	end

	arg_8_0:Finish()

	arg_8_0.lastRotateY_ = nil
end

function var_0_0.SetBossID(arg_9_0, arg_9_1)
	if arg_9_0.bossID_ == arg_9_1 then
		return
	end

	arg_9_0:Finish()
	arg_9_0:LoadModel(arg_9_1)

	arg_9_0.bossID_ = arg_9_1
end

function var_0_0.ShowBossModel(arg_10_0, arg_10_1)
	if arg_10_0.bossModel_ then
		SetActive(arg_10_0.bossModel_, arg_10_1)
	end
end

function var_0_0.InitBackScene(arg_11_0)
	local var_11_0 = "UI/Common/BackgroundQuad"

	arg_11_0.backGround_ = manager.resourcePool:Get(var_11_0, ASSET_TYPE.SCENE)
	arg_11_0.backGroundTrs_ = arg_11_0.backGround_.transform

	arg_11_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_11_1
	local var_11_2
	local var_11_3 = GameDisplayCfg.collect_monster_background_pos.value
	local var_11_4 = CameraCfg.enemyFile.pictureName

	arg_11_0.backGroundTrs_.localPosition = Vector3(var_11_3[1], var_11_3[2], var_11_3[3])
	arg_11_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_11_5 = GameDisplayCfg.collect_monster_background_pos.scale

	arg_11_0.backGroundTrs_.localScale = Vector3(var_11_5[1], var_11_5[2], var_11_5[3])
	arg_11_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. var_11_4)
end

function var_0_0.Finish(arg_12_0)
	if arg_12_0.animator_ then
		if arg_12_0.playable_ then
			arg_12_0.playable_:Stop()
		end

		local var_12_0 = arg_12_0.animator_.gameObject:GetComponent("LipSync")

		if var_12_0 then
			var_12_0:ResetEmotion(0)
		end
	end

	arg_12_0.bossID_ = nil

	if arg_12_0.bossModel_ then
		manager.resourcePool:DestroyOrReturn(arg_12_0.bossModel_, ASSET_TYPE.TPOSE)

		arg_12_0.bossModel_ = nil
		arg_12_0.animator_ = nil
		arg_12_0.actionTimer_ = nil
		arg_12_0.actioning_ = false
	end
end

function var_0_0.AdjustOutlineThickness(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_0.outlinePropID

	if isNil(arg_13_1) or var_13_0 == nil then
		return
	end

	local var_13_1 = UnityEngine.MaterialPropertyBlock.New()
	local var_13_2 = arg_13_1:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_13_0 = 0, var_13_2.Length - 1 do
		local var_13_3 = var_13_2[iter_13_0]

		var_13_3:GetPropertyBlock(var_13_1)

		for iter_13_1 = 0, var_13_3.sharedMaterials.Length - 1 do
			local var_13_4 = var_13_3.sharedMaterials[iter_13_1]

			if var_13_4:HasProperty(var_13_0) then
				local var_13_5 = var_13_4:GetFloat(var_13_0)

				var_13_1:SetFloat(var_13_0, var_13_5 * arg_13_2)
				var_13_3:SetPropertyBlock(var_13_1, iter_13_1)
			end
		end
	end
end

function var_0_0.InitModel(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.bossModel_ = arg_14_1
	arg_14_0.rotaNote_ = arg_14_1.transform
	arg_14_0.animator_ = arg_14_0:FindCom(typeof(Animator), "", arg_14_0.bossModel_.transform)

	if arg_14_0.animator_ == nil then
		-- block empty
	end

	arg_14_0:FindCom(typeof(CharacterEffect), "", arg_14_0.bossModel_.transform):ForceUpdate()
end

function var_0_0.LoadModel(arg_15_0, arg_15_1)
	local var_15_0 = CollectMonsterCfg[arg_15_1]
	local var_15_1 = manager.resourcePool:Get("Char/" .. MonsterCfg[arg_15_1].model_name, ASSET_TYPE.TPOSE)
	local var_15_2
	local var_15_3
	local var_15_4
	local var_15_5 = var_15_0.model_pos[1]
	local var_15_6 = var_15_0.model_rot[1]
	local var_15_7 = var_15_0.model_scale[1]

	arg_15_0.rot_limit_ = var_15_0.model_rot_limit or {
		-180,
		180
	}
	var_15_1.transform.localPosition = Vector3(var_15_5[1], var_15_5[2], var_15_5[3])
	var_15_1.transform.localEulerAngles = Vector3(var_15_6[1], var_15_6[2], var_15_6[3])
	var_15_1.transform.localScale = Vector3(var_15_7[1], var_15_7[2], var_15_7[3])

	arg_15_0:InitModel(var_15_1, var_15_0.id)
	arg_15_0:AdjustOutlineThickness(var_15_1, var_15_7[1])
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
	arg_16_0:Finish()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
