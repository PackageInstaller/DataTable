-- chunkname: @IQIGame\\UI\\Story\\StoryUIMoviePanel.lua

local StoryUIMoviePanel = class(nil, BaseChildrenPanel)

function StoryUIMoviePanel.New(go, mainView)
	local o = Clone(StoryUIMoviePanel)

	o:Initialize(go, mainView)

	return o
end

function StoryUIMoviePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryUIMoviePanel:InitComponent()
	self.MediaMB = self.MediaPlayer:GetComponent(typeof(MediaMB))
end

function StoryUIMoviePanel:InitDelegate()
	function self.OnMoviePlayEndDelegate()
		self:OnMoviePlayEnd()
	end

	function self.OnMovieErrorDelegate(v, message)
		logError("视频播放失败：" .. message)
		self:OnMoviePlayEnd()
	end
end

function StoryUIMoviePanel:AddListener()
	UIEventUtil.AddClickEventListener_Button(self, "JumpBtnRoot", self.__OnJumpBtnClick)
end

function StoryUIMoviePanel:RemoveListener()
	UIEventUtil.ClearEventListener(self)
end

function StoryUIMoviePanel:OnOpen()
	self.mainView:SetTopRootShow(false)
end

function StoryUIMoviePanel:OnClose()
	self.mainView:SetTopRootShow(true)
end

function StoryUIMoviePanel:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	LuaUtility.UnLoadAsset(self)
end

function StoryUIMoviePanel:__OnJumpBtnClick()
	self:OnMoviePlayEnd()
end

function StoryUIMoviePanel:PlayMovie(resourceID, PlayMovieTask)
	self.JumpBtnRoot.gameObject:SetActive(false)

	local path = CfgUtil.GetStoryResourceWithID(resourceID)

	self.videoPath = AssetPath.GetRealVideoPath(path)
	self.VideoPlayer = self.VideoRoot:GetComponent(typeof(UnityEngine.Video.VideoPlayer))
	self.VideoPlayer.loopPointReached = self.VideoPlayer.loopPointReached + self.OnMoviePlayEndDelegate
	self.VideoPlayer.errorReceived = self.VideoPlayer.errorReceived + self.OnMovieErrorDelegate
	self.VideoPlayer.url = self.videoPath

	self.VideoPlayer:Play()
	self.VideoRoot:SetActive(true)
	self.AVProRoot:SetActive(false)

	self.PlayMovieTask = PlayMovieTask

	local timer = Timer.New(function()
		self.JumpBtnRoot.gameObject:SetActive(true)
	end, 3)

	timer:Start()
end

function StoryUIMoviePanel:OnMoviePlayEnd(error)
	self.JumpBtnRoot.gameObject:SetActive(false)
	self.VideoPlayer:Stop()
	self:Close()
	self.PlayMovieTask:SetIsComplete()
end

return StoryUIMoviePanel
