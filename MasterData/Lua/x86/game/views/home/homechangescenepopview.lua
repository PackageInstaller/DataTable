local HomeChangeScenePopView = class("HomeChangeScenePopView", ReduxView)

function HomeChangeScenePopView:UIName()
	return "Widget/System/Main/HomeSceneChangePopUI"
end

function HomeChangeScenePopView:UIParent()
	return manager.ui.uiPop.transform
end

function HomeChangeScenePopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HomeChangeScenePopView:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.collecter_:GetController("state")
end

function HomeChangeScenePopView:AddUIListeners()
	self:AddBtnListener(self.leftBtn_, nil, function()
		self.curIndex_ = 1

		self:RefreshState()
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self.curIndex_ = 2

		self:RefreshState()
	end)
	self:AddBtnListener(self.btn_, nil, function()
		saveData("scenePop", "sceneID_" .. self.leftID_, true)

		if self.curIndex_ == 2 then
			HomeSceneSettingAction.SetHomeScene(self.rightID_)
		else
			HomeSceneSettingData:SetDefaultScene(self.leftID_)
		end

		self:Back()
	end)
end

function HomeChangeScenePopView:OnEnter()
	self.curIndex_ = 1
	self.leftID_ = self.params_.left
	self.rightID_ = self.params_.right
	self.leftText_.text = HomeSceneSettingCfg[self.leftID_].title
	self.rightText_.text = HomeSceneSettingCfg[self.rightID_].title
	self.leftIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. self.leftID_)
	self.rightIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. self.rightID_)
	self.desc_.text = GetTips("HOME_SCENE_FORCE_CHANGE")

	self:RefreshState()
end

function HomeChangeScenePopView:RefreshState()
	self.stateCon_:SetSelectedState(self.curIndex_ == 1 and "left" or "right")
end

function HomeChangeScenePopView:OnExit()
	return
end

function HomeChangeScenePopView:Dispose()
	self:RemoveAllListeners()
	HomeChangeScenePopView.super.Dispose(self)
end

return HomeChangeScenePopView
