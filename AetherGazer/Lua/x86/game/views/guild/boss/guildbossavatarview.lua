local var_0_0 = class("GuildBossAvatarView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.playable_ = arg_3_0:FindCom(typeof(PlayableDirector), "")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:InitBackScene()
end

function var_0_0.OnExit(arg_6_0)
	if arg_6_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_6_0.backGround_, ASSET_TYPE.SCENE)
	end

	arg_6_0:Finish()
end

function var_0_0.SetBossID(arg_7_0, arg_7_1)
	if arg_7_0.bossID_ == arg_7_1 then
		return
	end

	arg_7_0:Finish()
	arg_7_0:LoadModel(arg_7_1)

	arg_7_0.bossID_ = arg_7_1
end

function var_0_0.ShowBossModel(arg_8_0, arg_8_1)
	if arg_8_0.bossModel_ then
		SetActive(arg_8_0.bossModel_, arg_8_1)
	end
end

function var_0_0.InitBackScene(arg_9_0)
	local var_9_0 = "UI/Common/BackgroundQuad"

	arg_9_0.backGround_ = manager.resourcePool:Get(var_9_0, ASSET_TYPE.SCENE)
	arg_9_0.backGroundTrs_ = arg_9_0.backGround_.transform

	arg_9_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_9_1
	local var_9_2
	local var_9_3 = GameDisplayCfg.club_boss_bg_pos.value
	local var_9_4 = CameraCfg.clubBoss.pictureName

	arg_9_0.backGroundTrs_.localPosition = Vector3(var_9_3[1], var_9_3[2], var_9_3[3])
	arg_9_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_9_5 = GameDisplayCfg.club_boss_bg_pos.scale

	arg_9_0.backGroundTrs_.localScale = Vector3(var_9_5[1], var_9_5[2], var_9_5[3])
	arg_9_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.ClubBossBg.path .. var_9_4)
end

function var_0_0.Finish(arg_10_0)
	if arg_10_0.animator_ then
		if arg_10_0.playable_ then
			arg_10_0.playable_:Stop()
		end

		local var_10_0 = arg_10_0.animator_.gameObject:GetComponent("LipSync")

		if var_10_0 then
			var_10_0:ResetEmotion(0)
		end
	end

	arg_10_0.bossID_ = nil

	if arg_10_0.bossModel_ then
		manager.resourcePool:DestroyOrReturn(arg_10_0.bossModel_, ASSET_TYPE.TPOSE)

		arg_10_0.bossModel_ = nil
		arg_10_0.animator_ = nil
		arg_10_0.actionTimer_ = nil
		arg_10_0.actioning_ = false
	end
end

function var_0_0.InitModel(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.bossModel_ = arg_11_1
	arg_11_0.animator_ = arg_11_0:FindCom(typeof(Animator), "", arg_11_0.bossModel_.transform)

	if arg_11_0.animator_ == nil then
		-- block empty
	end
end

function var_0_0.LoadModel(arg_12_0, arg_12_1)
	local var_12_0 = BossChallengeUICfg[arg_12_1]
	local var_12_1 = manager.resourcePool:Get("Char/" .. MonsterCfg[var_12_0.boss_id_list[1]].model_name, ASSET_TYPE.TPOSE)
	local var_12_2
	local var_12_3
	local var_12_4
	local var_12_5 = var_12_0.model_pos[1]
	local var_12_6 = var_12_0.model_rot[1]
	local var_12_7 = var_12_0.model_scale[1]

	var_12_1.transform.localPosition = Vector3(var_12_5[1], var_12_5[2], var_12_5[3])
	var_12_1.transform.localEulerAngles = Vector3(var_12_6[1], var_12_6[2], var_12_6[3])
	var_12_1.transform.localScale = Vector3(var_12_7[1], var_12_7[2], var_12_7[3])

	arg_12_0:InitModel(var_12_1, var_12_0.id)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	arg_13_0:Finish()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
