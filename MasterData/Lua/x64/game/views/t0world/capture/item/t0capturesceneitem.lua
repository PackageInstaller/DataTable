local T0CaptureSceneItem = class("T0CaptureSceneItem", ReduxView)

function T0CaptureSceneItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function T0CaptureSceneItem:Init()
	self:InitUI()
end

function T0CaptureSceneItem:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.controller = self.controllerEx_:GetController("state")
end

function T0CaptureSceneItem:AddListener()
	self:AddBtnListener(self.button_, nil, function()
		manager.transition:OnlyShowEffect(true, function()
			T0WorldMgr:SetCaptureScene(self.sceneType)
			manager.transition:OnlyShowEffect(false)
		end)
	end)
end

function T0CaptureSceneItem:RefreshUI(arg_7_1)
	self.sceneType = arg_7_1
	self.nameText_.text = GetTips((T0WorldMgr:GetCaptureSceneName(arg_7_1)))

	self:SetActive(true)
end

function T0CaptureSceneItem:SetActive(arg_8_1)
	if arg_8_1 then
		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

function T0CaptureSceneItem:Dispose()
	T0CaptureSceneItem.super.Dispose(self)
end

return T0CaptureSceneItem
