local T0SceneChangeView = class("T0SceneChangeView", ReduxView)

function T0SceneChangeView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function T0SceneChangeView:Init()
	self:InitUI()
end

function T0SceneChangeView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.expandController = self.controller_:GetController("expand")
	self.expandsceneList = {}

	self:Render()
end

function T0SceneChangeView:AddListener()
	self:AddBtnListener(self.changeBtn_, nil, function()
		self:SetExpandState(true)
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:SetExpandState(false)
	end)
end

function T0SceneChangeView:SetExpandState(arg_7_1)
	if arg_7_1 then
		self.expandController:SetSelectedState("expand")
	else
		self.expandController:SetSelectedState("normal")
	end
end

function T0SceneChangeView:Render()
	local var_8_0 = T0WorldMgr:GetUseSceneType()

	self.useSceneName_.text = GetTips((T0WorldMgr:GetCaptureSceneName(var_8_0)))

	for iter_8_0, iter_8_1 in pairs(self.expandsceneList or {}) do
		if iter_8_1 then
			iter_8_1:SetActive(false)
		end
	end

	for iter_8_2, iter_8_3 in pairs((T0WorldTools.GetCaptureSceneList())) do
		if iter_8_2 ~= var_8_0 then
			local var_8_1 = self.expandsceneList[1]

			if not self.expandsceneList[1] then
				var_8_1 = self:CreateSceneItem()
				self.expandsceneList[1] = var_8_1
			end

			var_8_1:RefreshUI(iter_8_2)
		end
	end
end

function T0SceneChangeView:CreateSceneItem()
	return (T0CaptureSceneItem.New((Object.Instantiate(self.sceneObj_, self.selectContent_))))
end

function T0SceneChangeView:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.expandsceneList) do
		if iter_10_1 then
			iter_10_1:Dispose()

			iter_10_1 = nil
		end
	end

	T0SceneChangeView.super.Dispose(self)
end

return T0SceneChangeView
