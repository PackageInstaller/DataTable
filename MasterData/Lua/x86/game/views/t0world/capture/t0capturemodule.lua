local T0CaptureModule = class("T0CaptureModule", ReduxView)
local var_0_1 = "Widget/System/Main_T0SceneGame/%s/FilterModule"
local var_0_2 = "Widget/System/Main_T0SceneGame/%s/PoseModule"

function T0CaptureModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_2 == 3 and Asset.Load(string.format(var_0_1, T0WorldMgr:GetHeroID())) or Asset.Load(string.format(var_0_2, T0WorldMgr:GetHeroID())), arg_1_1)
	self.transform_ = self.gameObject_.transform
	self.switchType = arg_1_2

	self:Init()
end

function T0CaptureModule:Init()
	self:InitUI()
end

function T0CaptureModule:InitUI()
	self:BindCfgUI()

	self.scrollHelper = self.switchType == 3 and LuaList.New(handler(self, self.RenderItem), self.uiList_, T0CapturePoseItem) or LuaList.New(handler(self, self.RenderItem), self.poseList_, T0CapturePoseItem)
end

function T0CaptureModule:OnEnter()
	SetActive(self.gameObject_, true)
	self:Render()
end

function T0CaptureModule:Render()
	self:InitList()
	self.scrollHelper:StartScroll(#self.switchList)
end

function T0CaptureModule:InitList()
	self.switchList = T0WorldMgr:GetCaptureSwitchList(T0WorldMgr:GetUseSceneType(), self.switchType, (T0WorldMgr:GetHeroID()))
end

function T0CaptureModule:RenderItem(arg_7_1, arg_7_2)
	arg_7_2:Render(self.switchList[arg_7_1])
end

function T0CaptureModule:OnExit()
	SetActive(self.gameObject_, false)
end

function T0CaptureModule:Dispose()
	self.scrollHelper:Dispose()
	T0CaptureModule.super.Dispose(self)
end

return T0CaptureModule
