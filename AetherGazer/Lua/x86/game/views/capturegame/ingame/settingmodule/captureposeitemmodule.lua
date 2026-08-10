local var_0_0 = class("CapturePoseItemModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListener()

	arg_3_0.controller = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		arg_4_0:OnPoseItemClick()
	end)
end

function var_0_0.Render(arg_6_0, arg_6_1)
	arg_6_0.animId = arg_6_1
	arg_6_0.name_.text = ActivitySwimSkinAnimationCfg[arg_6_1].title

	local var_6_0 = CaptureGameMgr:GetCurRoleId()
	local var_6_1 = CaptureGameMgr:GetEntityMgr():GetEntity(var_6_0):IsInAnim(arg_6_1)

	arg_6_0.controller:SetSelectedState(var_6_1 and "select" or "false")
	arg_6_0.isLike_:SetActive(CaptureGameMgr:GetTaskMgr():AnimIsRecommend(arg_6_1))
end

function var_0_0.OnPoseItemClick(arg_7_0)
	local var_7_0 = CaptureGameMgr:GetCurRoleId()
	local var_7_1 = CaptureGameMgr:GetEntityMgr():GetEntity(var_7_0)

	if not var_7_1:IsInAnim(arg_7_0.animId) then
		var_7_1:PlayAnimation(arg_7_0.animId)
	else
		var_7_1:PlayAnimation(-1)
	end

	manager.notify:Invoke(CAPTURE_GAME_INGAME_ANIM_UPDATE)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
