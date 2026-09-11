local CapturePoseItemModule = class("CapturePoseItemModule", ReduxView)

function CapturePoseItemModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CapturePoseItemModule:Init()
	self:InitUI()
end

function CapturePoseItemModule:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.controller = self.controllerEx_:GetController("state")
end

function CapturePoseItemModule:AddListener()
	self:AddBtnListener(self.button_, nil, function()
		self:OnPoseItemClick()
	end)
end

function CapturePoseItemModule:Render(arg_6_1)
	self.animId = arg_6_1
	self.name_.text = ActivitySwimSkinAnimationCfg[arg_6_1].title

	self.controller:SetSelectedState(CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId())):IsInAnim(arg_6_1) and "select" or "false")
	self.isLike_:SetActive(CaptureGameMgr:GetTaskMgr():AnimIsRecommend(arg_6_1))
end

function CapturePoseItemModule:OnPoseItemClick()
	local var_7_0 = CaptureGameMgr:GetEntityMgr():GetEntity((CaptureGameMgr:GetCurRoleId()))

	if not var_7_0:IsInAnim(self.animId) then
		var_7_0:PlayAnimation(self.animId)
	else
		var_7_0:PlayAnimation(-1)
	end

	manager.notify:Invoke(CAPTURE_GAME_INGAME_ANIM_UPDATE)
end

function CapturePoseItemModule:Dispose()
	CapturePoseItemModule.super.Dispose(self)
end

return CapturePoseItemModule
