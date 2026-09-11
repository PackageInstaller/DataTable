baseModule = import("game.views.t0World.Capture.T0CaptureModule")

local OathCaptureModule = class("OathCaptureModule", baseModule)

function OathCaptureModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_2 == 3 and Asset.Load("Widget/System/Main_T0SceneGame/108502/FilterModule") or Asset.Load("Widget/System/Main_T0SceneGame/108502/PoseModule"), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.switchType = arg_1_2

	self:Init()
end

function OathCaptureModule:InitUI()
	self:BindCfgUI()

	self.scrollHelper = self.switchType == 3 and LuaList.New(handler(self, self.RenderItem), self.uiList_, OathCapturePoseItem) or LuaList.New(handler(self, self.RenderItem), self.poseList_, OathCapturePoseItem)
end

function OathCaptureModule:InitList()
	self.switchList = OathTools.GetCaptureSwitchList(OathToLuaBridge:GetUseOathCharacterID(), self.switchType)
end

return OathCaptureModule
