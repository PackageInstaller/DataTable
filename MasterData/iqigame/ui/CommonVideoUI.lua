-- chunkname: @IQIGame\\UI\\CommonVideoUI.lua

local CommonVideoUI = {}

CommonVideoUI = Base:Extend("CommonVideoUI", "IQIGame.Onigao.UI.CommonVideoUI", CommonVideoUI)

function CommonVideoUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.delegateOnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	end

	self.MediaMBCom = self.mediaPlayer:GetComponent(typeof(MediaMB))
end

function CommonVideoUI:GetPreloadAssetPaths()
	return nil
end

function CommonVideoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonVideoUI:IsManualShowOnOpen(userData)
	return false
end

function CommonVideoUI:GetBGM(userData)
	return nil
end

function CommonVideoUI:OnOpen(userData)
	self:ShowVideo(userData.storySrc, userData.callback)
end

function CommonVideoUI:OnClose(userData)
	return
end

function CommonVideoUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.MediaMBCom:AddListener(self.delegateOnMediaPlayerEvent)
end

function CommonVideoUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.MediaMBCom:RemoveListener(self.delegateOnMediaPlayerEvent)
end

function CommonVideoUI:OnPause()
	return
end

function CommonVideoUI:OnResume()
	return
end

function CommonVideoUI:OnCover()
	return
end

function CommonVideoUI:OnReveal()
	return
end

function CommonVideoUI:OnRefocus(userData)
	return
end

function CommonVideoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonVideoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonVideoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonVideoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonVideoUI:OnDestroy()
	self.MediaMBCom = nil

	AssetUtil.UnloadAsset(self)
end

function CommonVideoUI:OnClickCloseBtn()
	self:PlayFinish()
end

function CommonVideoUI:ShowVideo(storySrc, callback)
	self.finishCallback = callback

	self.MediaMBCom:Rewind(false)
	self.MediaMBCom:OpenVideoFromFile(storySrc, true)

	self.MediaMBCom.Volume = SettingModule.currentMusicVolume
	self.MediaMBCom.Loop = false

	self.MediaMBCom:Play()
end

function CommonVideoUI:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		self:PlayFinish()

		return
	end

	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying then
		self:PlayFinish()
	end
end

function CommonVideoUI:PlayFinish()
	if self.finishCallback ~= nil then
		self.finishCallback()

		self.finishCallback = nil
	end

	UIModule.Close(Constant.UIControllerName.CommonVideoUI)
end

return CommonVideoUI
