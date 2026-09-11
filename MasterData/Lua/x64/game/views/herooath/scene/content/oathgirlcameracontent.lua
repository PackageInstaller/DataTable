local OathGirlCameraContent = class("OathGirlCameraContent", ReduxView)

function OathGirlCameraContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function OathGirlCameraContent:InitUI()
	self:BindCfgUI()
	self:AddTouchHelper()
end

function OathGirlCameraContent:AddTouchHelper()
	self.mutiTouchHelper_ = self.gameObject_:GetComponent("MutiTouchHelper")

	function self.mutiTouchHelper_.OnIdle()
		self:TouchHelpIdle()
	end

	function self.mutiTouchHelper_.OnSingleDrag(arg_5_0, arg_5_1)
		self:TouchHelpSingleDrag(arg_5_0, arg_5_1)
	end

	function self.mutiTouchHelper_.OnMutiDrag(arg_6_0)
		self:TouchHelpMutiDrag(arg_6_0)
	end
end

function OathGirlCameraContent:OnExit()
	return
end

function OathGirlCameraContent:LoadModel(arg_8_1)
	self.model = arg_8_1

	self:LoadCamera()
end

function OathGirlCameraContent:LoadCamera()
	self.cameraManager_ = self.model.transform:GetComponentInChildren(typeof(CharacterCameraManager))

	self:InitCamera()
	self:UpdateCameraParams()
end

function OathGirlCameraContent:InitCamera()
	self.cameraManager_.touchHelper = self.mutiTouchHelper_
end

function OathGirlCameraContent:UpdateCameraParams()
	if not self.cameraManager_ then
		return
	end

	self.cameraManager_:SetCameraParams(self:GetViewDirect())
	self:SetSelfCamera(0)
end

function OathGirlCameraContent:GetViewDirect()
	return PosterGirlConst.ViewDirect.center
end

function OathGirlCameraContent:SetSelfCamera(arg_13_1, arg_13_2)
	if arg_13_1 == -1 then
		self.cameraManager_:RemoveActiveCamera()
	else
		self.cameraManager_:SetActiveCamera(arg_13_1, arg_13_2 or false)
	end

	self:ResetCameraPos()
end

function OathGirlCameraContent:ResetCameraPos()
	self.cameraManager_:ResetCameraDefaultCfg()
end

function OathGirlCameraContent:TouchHelpIdle()
	self.cameraManager_:TweenToDefaultCameraPos()
end

function OathGirlCameraContent:TouchHelpSingleDrag(arg_16_1, arg_16_2)
	self.cameraManager_:RotateCamera(arg_16_1, arg_16_2)
end

function OathGirlCameraContent:TouchHelpMutiDrag(arg_17_1)
	self:DefaultZoomToCameraImpl(arg_17_1, 1, 0)
end

function OathGirlCameraContent:DefaultZoomToCameraImpl(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = nullable(GameSetting.delta_to_zoom, "value", 1) or 10

	if var_18_0 < arg_18_1 then
		self.cameraManager_:SetActiveCamera(arg_18_2)
	elseif arg_18_1 < -1 * var_18_0 then
		self.cameraManager_:SetActiveCamera(arg_18_3)
	end
end

function OathGirlCameraContent:Dispose()
	self.model = nil
	self.mutiTouchHelper_ = nil
	self.cameraManager_ = nil

	OathGirlCameraContent.super.Dispose(self)
end

return OathGirlCameraContent
