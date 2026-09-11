local FireWorkShowView = class("FireWorkShowView", ReduxView)

function FireWorkShowView:UIName()
	return "UI/EmptyDream/Firework/FireworkUI"
end

function FireWorkShowView:UIParent()
	return manager.ui.uiMain.transform
end

function FireWorkShowView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FireWorkShowView:InitUI()
	self:BindCfgUI()

	self.criMovie_ = self.m_movie:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.criplayer_.statusChangeCallback = nil
end

function FireWorkShowView:AddUIListener()
	return
end

function FireWorkShowView:OnTop()
	manager.windowBar:SwitchBar({})
end

function FireWorkShowView:CirMovieStatusChange(arg_7_1)
	local var_7_0 = tostring(arg_7_1)

	if var_7_0 == "PlayEnd" or var_7_0 == "Stop" then
		self:ShowOver()
	end
end

function FireWorkShowView:ShowOver()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.criplayer_.statusChangeCallback = nil

	manager.story:StartStoryById(ActivityFireWorkCfg[self.activity_id].story_id, function(arg_9_0)
		JumpTools.OpenPageByJump("/fireWorkMain", {
			fire_activity_id = self.activity_id
		})
	end)
end

function FireWorkShowView:OnEnter()
	self.activity_id = self.params_.fire_activity_id
	self.timer = Timer.New(function()
		self:ShowOver()
	end, 20, 1)

	self.timer:Start()
	self.criplayer_:SetVolume((manager.audio:GetMusicVolume()))
	SetFile(self.criplayer_, nil, ActivityFireWorkCfg[self.activity_id].fireworks)
	self.criMovie_:Play()

	self.criplayer_.statusChangeCallback = handler(self, self.CirMovieStatusChange)
end

function FireWorkShowView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.criplayer_.statusChangeCallback = nil
end

function FireWorkShowView:Dispose()
	FireWorkShowView.super.Dispose(self)
end

return FireWorkShowView
