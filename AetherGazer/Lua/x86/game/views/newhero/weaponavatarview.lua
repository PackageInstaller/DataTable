local var_0_0 = class("WeaponAvatarView", ReduxView)
local var_0_1 = {
	weapon = 2,
	hero = 1
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.playable_ = arg_3_0:FindCom(typeof(PlayableDirector), "")
	arg_3_0.backGo_ = arg_3_0:FindGo("back")
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.backGo_ then
		arg_4_0:AddDragListener(arg_4_0.backGo_, function()
			if arg_4_0.weaponModel_ and arg_4_0.rotateNode_ then
				arg_4_0.startRot_ = arg_4_0.rotateNode_.localEulerAngles
			else
				arg_4_0.startRot_ = Vector3.zero
			end

			arg_4_0.lastRotateY_ = nil
			arg_4_0.lastDeltaX_ = 0
		end, function(arg_6_0, arg_6_1)
			if arg_4_0.weaponModel_ and arg_4_0.rotateNode_ then
				local var_6_0 = arg_4_0.lastRotateY_ or arg_4_0.rotateNode_.localEulerAngles.y
				local var_6_1 = var_6_0 + (arg_6_0 - (arg_4_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_6_0
				local var_6_2 = var_6_1

				if var_6_1 < -HeroConst.MAX_RORATE_ANGLE then
					var_6_2 = -HeroConst.MAX_RORATE_ANGLE
				elseif var_6_1 > HeroConst.MAX_RORATE_ANGLE then
					var_6_2 = HeroConst.MAX_RORATE_ANGLE
				end

				arg_4_0.lastRotateY_ = var_6_0 + var_6_2
				arg_4_0.lastDeltaX_ = arg_6_0
				arg_4_0.rotateNode_.localRotation = Quaternion.RotateTowards(arg_4_0.rotateNode_.localRotation, Quaternion.Euler(arg_4_0.startRot_.x, var_6_0 + var_6_2, arg_4_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
			end
		end)
	end
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	arg_7_0.type_ = arg_7_1

	arg_7_0:InitBackScene(arg_7_1)
end

function var_0_0.OnExit(arg_8_0)
	if arg_8_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_8_0.backGround_, ASSET_TYPE.SCENE)
	end

	arg_8_0:Finish()
end

function var_0_0.SetWeaponID(arg_9_0, arg_9_1)
	local var_9_0 = SkinCfg[arg_9_1].id

	if arg_9_0.weaponID_ == var_9_0 then
		return
	end

	arg_9_0:Finish()
	arg_9_0:LoadModel(var_9_0)

	arg_9_0.weaponID_ = var_9_0
end

function var_0_0.ShowWeaponModel(arg_10_0, arg_10_1)
	if arg_10_0.weaponModel_ then
		SetActive(arg_10_0.weaponModel_, arg_10_1)
	end

	SetActive(arg_10_0.backGo_, arg_10_1)
end

function var_0_0.InitBackScene(arg_11_0, arg_11_1)
	if arg_11_1 == var_0_1.hero then
		return
	end

	local var_11_0 = "UI/Common/BackgroundQuad"

	arg_11_0.backGround_ = manager.resourcePool:Get(var_11_0, ASSET_TYPE.SCENE)
	arg_11_0.backGroundTrs_ = arg_11_0.backGround_.transform

	arg_11_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_11_1
	local var_11_2

	if arg_11_1 == var_0_1.weapon then
		var_11_1 = GameDisplayCfg.weapon_background_pos.value
		var_11_2 = CameraCfg.weapon.pictureName
	elseif arg_11_1 == var_0_1.hero then
		var_11_1 = GameDisplayCfg.hero_modelld_background_pos.value
		var_11_2 = CameraCfg.hero.pictureName
	end

	arg_11_0.backGroundTrs_.localPosition = Vector3(var_11_1[1], var_11_1[2], var_11_1[3])
	arg_11_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	arg_11_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. var_11_2)
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

	arg_12_0.weaponID_ = nil

	if arg_12_0.weaponModel_ then
		manager.resourcePool:DestroyOrReturn(arg_12_0.weaponModel_, ASSET_TYPE.WEAPON)

		arg_12_0.weaponModel_ = nil
		arg_12_0.animator_ = nil
		arg_12_0.actionTimer_ = nil
		arg_12_0.actioning_ = false
		arg_12_0.weapomNode_ = nil
		arg_12_0.weapomNode2_ = nil
		arg_12_0.weapomNode3_ = nil
	end
end

function var_0_0.InitModel(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.weaponModel_ = arg_13_1

	local var_13_0 = HeroCfg[arg_13_2]

	arg_13_0.animator_ = arg_13_0:FindCom(typeof(Animator), "", arg_13_0.weaponModel_.transform)

	if arg_13_0.animator_ == nil then
		-- block empty
	end

	arg_13_0.rotateNode_ = arg_13_0.weaponModel_.transform
	arg_13_0.rotateNode_.localEulerAngles = Vector3.zero
end

function var_0_0.LoadModel(arg_14_0, arg_14_1)
	local var_14_0 = SkinCfg[arg_14_1]
	local var_14_1 = manager.resourcePool:Get("Weapon/" .. var_14_0.weapon_modelId, ASSET_TYPE.WEAPON)
	local var_14_2
	local var_14_3

	if arg_14_0.type_ == 1 then
		var_14_2 = GameDisplayCfg.weapon_pos1.value
		var_14_3 = GameDisplayCfg.weapon_rot1.value
	elseif arg_14_0.type_ == 2 then
		var_14_2 = GameDisplayCfg.weapon_pos1.value
		var_14_3 = GameDisplayCfg.weapon_rot1.value
	end

	var_14_1.transform.localPosition = Vector3(var_14_2[1], var_14_2[2], var_14_2[3])
	var_14_1.transform.localEulerAngles = Vector3(var_14_3[1], var_14_3[2], var_14_3[3])
	var_14_1.transform.localScale = Vector3(1, 1, 1)

	arg_14_0:InitModel(var_14_1, var_14_0.id)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	arg_15_0:Finish()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
