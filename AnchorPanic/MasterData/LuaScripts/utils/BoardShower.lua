-- --[[ 
-- -----------------------------------------------------
-- @filename       : BoardShower
-- @Description    : 背景板，用于最一开始的背景图或视频展示用
-- @date           : 2021-05-12 17:00:26
-- @Author         : Zzz
-- @copyright      : (LY) 2021 雷焰网络
-- -----------------------------------------------------
-- ]]
-- module("BoardShower", Class.impl())

-- BoardShower.BoardState = {
-- 	None = nil,
-- 	ImgBg = 2,
-- 	VideoBg = 3,
-- }

-- function ctor(self)
-- 	self.mBoardLayer = nil
-- 	self.mTrans = nil
-- 	self.mChildGos = nil
-- 	self.mChildTrans = nil
	
-- 	self.mSafetyTimer = nil
-- 	self.mBoardState = nil

-- 	self.mImgActionTimerSn = nil
-- 	self.mBgTweener = nil

-- 	self.mAutoActionTimes = 5
-- 	self.mClickActionTime = nil
-- 	self.mIsActionInit = nil
-- 	self.mImgActionIndex = nil
-- 	self.mImgActionList = {}
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_1.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_2.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_3.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_4.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_5.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_6.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_7.jpg"))
-- 	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_8.jpg"))
-- end

-- function configUI(self)
-- 	self.mGoImgBg = self.mChildGos["mImgBg"]
-- 	self.mGoVideo = self.mChildGos["mAVProVideo"]
-- 	self.mAvproPlayer = self.mChildGos["MediaPlayer"]:GetComponent(ty.MediaPlayer)

-- 	self.mImgBottom = self.mChildGos["mImgActionBottom"]:GetComponent(ty.AutoRefImage)
-- 	self.mImgTop = self.mChildGos["mImgActionTop"]:GetComponent(ty.AutoRefImage)
-- 	self.mCanvasGroupBottom = self.mChildGos["mImgActionBottom"]:GetComponent(ty.CanvasGroup)
-- 	self.mCanvasGroupTop = self.mChildGos["mImgActionTop"]:GetComponent(ty.CanvasGroup)
-- 	self.mClick = self.mChildGos["mClick"]

-- 	self:addAllUIEvent()
-- end

-- function addAllUIEvent(self)
-- 	self:addOnClick(self.mClick, self.__onClickHandler)
-- 	sdk.SdkManager:addEventListener(sdk.SdkManager.DEVICE_DP_CHANGE, self.onDeviceDpChangeHandler, self)
-- end

-- function removeAllUIEvent(self)
-- 	self:removeOnClick(self.mClick)
-- 	sdk.SdkManager:removeEventListener(sdk.SdkManager.DEVICE_DP_CHANGE, self.onDeviceDpChangeHandler, self)
-- end

-- -- 为组件加入侦听点击事件
-- function addOnClick(self, obj, callBack, soundPath, ...)
--     if obj == nil then
--         error('obj is nil', 2)
--     end
--     if obj == "" then
--         obj = self.UIObject
--     end
--     local params = nil
--     if select("#", ...) > 0 then
--         params = { ... }
--     end
--     local func = function()
--         if soundPath == "" then
--             -- 不播音效
--         elseif (soundPath == nil) then
--             AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
--         else
--             AudioManager:playSoundEffect(soundPath)
--         end
--         if params then
--             callBack(self, unpack(params))
--         else
--             callBack(self)
--         end
--     end
--     gs.UIComponentProxy.AddListener(obj, func)
-- end

-- -- 为组件移除侦听点击事件
-- function removeOnClick(self, obj)
--     gs.UIComponentProxy.RemoveListener(obj)
-- end

-- function onDeviceDpChangeHandler(self, args)
-- 	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
-- 		if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
-- 			VideoAdaptUtil:updateSize(self.mGoVideo:GetComponent(ty.RectTransform), 3)
-- 		end
-- 	end
-- end

-- function getBoardLayer(self)
-- 	if(not self.mBoardLayer)then
-- 		self.mBoardLayer = CS.UnityEngine.GameObject.Find("[UI_ROOT]").transform:Find("POP")
-- 	end
-- 	return self.mBoardLayer
-- end

-- function getBoardPrefabName(self)
-- 	return "UpdateResBgBoard"
-- end

-- function getBoardPrefabPath(self)
-- 	return UrlManager:getPrefabPath(string.format("updateRes/%s.prefab", self:getBoardPrefabName()))
-- end

-- function getBoardImgSource(self)
-- 	return UrlManager:getBgPath("updateRes/update_res_loading_bg.jpg")
-- end

-- function getBoardImgAudioSource(self)
-- 	return UrlManager:getMusicPath("music_login.ogg")
-- end

-- function getBoardVideoSource(self)
-- 	if(self:isForceBoardImg())then
-- 		return nil
-- 	else
-- 		return gs.PathUtil.GetExistFullPath("extra/video/ui/update_res_cg.mp4")
-- 		-- return gs.PathUtil.GetExistFullPath("extra/video/ui/aoyi_cg.mp4")
-- 		-- return gs.PathUtil.GetExistFullPath("extra/video/story/story_video_0001.mp4")
-- 		-- return nil
-- 	end
-- end

-- -- 是否强制只能图片背景板，减少内存占用（苹果型号对照：https://www.jianshu.com/p/96e7374e6b17）
-- function isForceBoardImg(self)
-- 	if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
-- 		local systemGBSize = math.ceil(gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024)
-- 		-- local usedGBSize = math.ceil(gs.SdkManager:GetMemorySize("GameUsedMemory") / 1024)
-- 		if(systemGBSize < 4)then
-- 			return true
-- 		end
-- 	elseif (web.WebManager.platform == web.DEVICE_TYPE.IOS) then -- 运存<3G强制图片背景板
-- 		local deviceModel, count = string.gsub(string.lower(CS.UnityEngine.SystemInfo.deviceModel), " ", "")
-- 		local paramList = string.split(deviceModel, ",")
-- 		local model = paramList[1]
-- 		local id = 0
-- 		local subId = paramList[2] and tonumber(paramList[2]) or 0
-- 		if (string.find(model, "iphone") ~= nil) then
-- 			local iphoneId, _count = string.gsub(model, "iphone", "")
-- 			id = tonumber(iphoneId)
-- 			model = "iphone"
-- 		elseif (string.find(model, "ipa") ~= nil) then
-- 			model = "ipa"
-- 		end

-- 		if (model == "iphone") then
-- 			if(id <= 8)then -- iphoneSE
-- 				return true
-- 			elseif(id == 9)then -- iphone7
-- 				if(subId ~= 2 and subId ~= 4)then -- 非plus
-- 					return true
-- 				end
-- 			elseif(id == 10)then
-- 				if(subId ~= 2 and subId ~= 5 and subId ~= 3 and subId ~= 6)then -- 非iphone8plus 和 非iphonex
-- 					return true
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return false
-- end

-- function setBoardState(self, state)
-- 	self.mBoardState = state
-- end

-- function getBoardState(self)
-- 	return self.mBoardState
-- end

-- function checkLoadBoardObj(self, finishCall)
-- 	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
-- 		finishCall()
-- 	else
-- 		if(BoardShower:getBoardState() ~= BoardShower.BoardState.None)then
-- 			local boardTrans = self:getBoardLayer():Find(self:getBoardPrefabName())
-- 			-- gs.GameObject.Destroy(boardTrans.gameObject)
-- 			-- 复用之前残留旧的
-- 			self.mChildGos, self.mChildTrans = GoUtil.GetChildHash(boardTrans.gameObject)
-- 			self.mTrans = boardTrans
-- 			self:configUI()
-- 			finishCall()
-- 			return
-- 		end

-- 		if(not self.mTrans)then
-- 			local prefabName = self:getBoardPrefabPath()
-- 			AssetLoader.PreLoadAsyn(prefabName, 
-- 			function()
-- 				local uiObject = AssetLoader.GetGO(prefabName)
-- 				uiObject.name = self:getBoardPrefabName()
-- 				self.mChildGos, self.mChildTrans = GoUtil.GetChildHash(uiObject)
-- 				self.mTrans = uiObject.transform
-- 				self.mTrans:SetParent(self:getBoardLayer(), false)
-- 				-- self.mTrans:SetSiblingIndex(0)
-- 				self:configUI()
-- 				finishCall()
-- 			end, self)
-- 		end
-- 	end
-- end

-- function showBoard(self, imgSource, imgAudioSource, videoSource, isMute, volume, callFun)
-- 	local removeSafetyTimer = function()
-- 		if(self.mSafetyTimer)then
-- 			LoopManager:removeTimerByIndex(self.mSafetyTimer)
-- 			self.mSafetyTimer = nil
-- 		end
-- 	end

-- 	self:checkLoadBoardObj(
-- 		function()
-- 			self.mGoImgBg:GetComponent(ty.AutoRefImage):SetImg(imgSource, false)

-- 			VideoAdaptUtil:updateSize(self.mGoVideo:GetComponent(ty.RectTransform), 3)
-- 			self.mAvproPlayer:Stop()
-- 			self.mAvproPlayer:CloseVideo()
-- 			self.mAvproPlayer.Events:RemoveAllListeners()

-- 			if(videoSource and videoSource ~= "")then
-- 				self.mGoImgBg:SetActive(false)
-- 				self.mGoVideo:SetActive(true)
				
-- 				-- 安全机制：视频出任何意外报错等无法播放时，5s一到就跳过视频模式
-- 				removeSafetyTimer()
-- 				self.mSafetyTimer = LoopManager:addTimer(5, 1, self, 
-- 				function()
-- 					self.mAvproPlayer:Stop()
-- 					self.mAvproPlayer:CloseVideo()
-- 					self.mAvproPlayer.Events:RemoveAllListeners()
-- 					if(callFun)then
-- 						callFun()
-- 					end
-- 				end)

-- 				self:setBoardState(BoardShower.BoardState.VideoBg)
-- 				self.mAvproPlayer.Events:AddListener(
-- 					function(mediaPlayer, eventType, errorCode)
-- 						if(eventType == gs.MediaPlayerEventType.FirstFrameReady)then        -- 渲染第一帧时触发
-- 							removeSafetyTimer()
-- 							if(callFun)then
-- 								callFun()
-- 							end
-- 						elseif(eventType == gs.MediaPlayerEventType.Error)then              -- 发生错误时触发
-- 							removeSafetyTimer()
-- 							if(callFun)then
-- 								LoopManager:addFrame(2, 1, self, callFun)
-- 							end
-- 						end
-- 					end
-- 				)
-- 				AvproUtil:init(self.mAvproPlayer)
-- 				self.mAvproPlayer:OpenVideoFromFile(gs.MediaPlayer.FileLocation.AbsolutePathOrURL, videoSource, false)
-- 				self.mAvproPlayer:Play()
-- 				if(volume ~= nil)then
-- 					AvproUtil:setVolume(self.mAvproPlayer, volume)
-- 				end
-- 				AvproUtil:muteAudio(self.mAvproPlayer, isMute)
-- 			else
-- 				self.mGoImgBg:SetActive(true)
-- 				self.mGoVideo:SetActive(false)

-- 				self:setBoardState(BoardShower.BoardState.ImgBg)
-- 				if(imgAudioSource and imgAudioSource ~= "")then
-- 					gs.AudioManager:PlayMusic(imgAudioSource)
-- 				else
-- 					gs.AudioManager:StopMusic()
-- 				end
-- 				if(volume ~= nil)then
-- 					gs.AudioManager.MusicVolume = volume
-- 				end
-- 				if(isMute)then
-- 					gs.AudioManager:PauseMusic()
-- 				else
-- 					gs.AudioManager:UnPauseMusic()
-- 				end

-- 				if(callFun)then
-- 					LoopManager:addFrame(2, 1, self, callFun)
-- 				end
-- 			end
-- 		end
-- 	)
-- end

-- function updateBoard(self, isMute, volume, callFun)
-- 	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
-- 		if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
-- 			if(volume ~= nil)then
-- 				AvproUtil:setVolume(self.mAvproPlayer, volume)
-- 			end
-- 			AvproUtil:muteAudio(self.mAvproPlayer, isMute)
-- 		else
-- 			if(volume ~= nil)then
-- 				gs.AudioManager.MusicVolume = volume
-- 			end
-- 			if(isMute)then
-- 				gs.AudioManager:PauseMusic()
-- 			else
-- 				gs.AudioManager:UnPauseMusic()
-- 			end
-- 		end
-- 	end

-- 	if(callFun)then
-- 		callFun()
-- 	end
-- end

-- function hideBoard(self, callFun)
-- 	local isExit = GameManager:getIsExiting()
-- 	if(isExit)then
-- 		-- 正在退出登录中理应保持显示，不隐藏
-- 		return
-- 	end
-- 	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
-- 		self:removeAllUIEvent()
-- 		gs.AudioManager:StopMusic()
-- 		if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
-- 			self.mAvproPlayer:Stop()
-- 			self.mAvproPlayer:CloseVideo()
-- 			self.mAvproPlayer.Events:RemoveAllListeners()
-- 		else
-- 			self:removeBoardAction()
-- 		end
-- 		gs.GameObject.Destroy(self.mTrans.gameObject)
-- 	end
	
-- 	-- 再次安全检测销毁
-- 	local boardTrans = self:getBoardLayer():Find(self:getBoardPrefabName())
-- 	if(boardTrans)then
-- 		gs.GameObject.Destroy(boardTrans.gameObject)
-- 	end
	
-- 	self.mTrans = nil
-- 	self.mChildGos = nil
-- 	self.mChildTrans = nil
-- 	self:setBoardState(BoardShower.BoardState.None)
-- 	if(callFun)then
-- 		callFun()
-- 	end
-- end

-- function __onClickHandler(self)
-- 	if(BoardShower:getBoardState() ~= BoardShower.BoardState.VideoBg)then
-- 		if(self.mIsActionInit)then
-- 			local nowTime = web.__getTime()
-- 			local isCanClick = false
-- 			if(self.mClickActionTime == nil)then
-- 				self.mClickActionTime = nowTime
-- 				isCanClick = true
-- 			elseif(nowTime - self.mClickActionTime >= 1)then
-- 				self.mClickActionTime = nowTime
-- 				isCanClick = true
-- 			end
		
-- 			if(isCanClick)then
-- 				if(self.mImgActionTimerSn)then
-- 					LoopManager:removeTimerByIndex(self.mImgActionTimerSn)
-- 					self.mImgActionTimerSn = nil
-- 				end
-- 				self.mImgActionTimerSn = LoopManager:addTimer(self.mAutoActionTimes, 0, self, self.__onBoardActionHandler)
-- 				self:__onBoardActionHandler()
-- 			end
-- 		end
-- 	end
-- end

-- function addBoardAction(self)
-- 	if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
-- 		self.mImgBottom:SetImg("", false)
-- 		self.mImgTop:SetImg("", false)
-- 		self.mCanvasGroupBottom.alpha = 0
-- 		self.mCanvasGroupTop.alpha = 0
-- 	else
-- 		if(not self.mImgActionTimerSn)then
-- 			-- 首次轮播先延迟显示，保证和登录界面的背景图间隔一致，显示有规律
-- 			self.mImgActionTimerSn = LoopManager:addTimer(self.mAutoActionTimes, 0, self, 
-- 			function()
-- 				self.mImgActionIndex = 1
-- 				local actionImgSource = self.mImgActionList[self.mImgActionIndex]
-- 				self.mImgTop:SetImg(actionImgSource, false)
				
-- 				if (self.mBgTweener) then
-- 					self.mBgTweener:Kill()
-- 					self.mBgTweener = nil
-- 				end
-- 				self.mCanvasGroupBottom.alpha = 0
-- 				self.mCanvasGroupTop.alpha = 0
-- 				self.mBgTweener = TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupTop, 0, 1, 0.5, gs.DT.Ease.InExpo, 
-- 				function()
-- 					self.mIsActionInit = true
-- 				end)
	
-- 				if(self.mImgActionTimerSn)then
-- 					LoopManager:removeTimerByIndex(self.mImgActionTimerSn)
-- 					self.mImgActionTimerSn = nil
-- 				end
-- 				self.mImgActionTimerSn = LoopManager:addTimer(self.mAutoActionTimes, 0, self, 
-- 				function()
-- 					self:__onBoardActionHandler()
-- 				end)
-- 			end)
-- 		end
-- 	end
-- end

-- function __onBoardActionHandler(self)
-- 	if(self.mImgActionIndex >= #self.mImgActionList)then
-- 		self.mImgActionIndex = 1
-- 	else
-- 		self.mImgActionIndex = self.mImgActionIndex + 1
-- 	end
-- 	local actionImgSource = self.mImgActionList[self.mImgActionIndex]
-- 	self.mImgBottom:SetImg(actionImgSource, false)

-- 	if (self.mBgTweener) then
-- 		self.mBgTweener:Kill()
-- 		self.mBgTweener = nil
-- 	end
-- 	self.mCanvasGroupBottom.alpha = 1
-- 	self.mCanvasGroupTop.alpha = 1
--     self.mBgTweener = TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupTop, 1, 0, 0.5, gs.DT.Ease.InExpo,
--     function()
-- 		self.mImgTop:SetImg(actionImgSource, false)
--     end)
-- end

-- function removeBoardAction(self)
-- 	if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
-- 		self.mImgBottom:SetImg("", false)
-- 		self.mImgTop:SetImg("", false)
-- 		self.mCanvasGroupBottom.alpha = 0
-- 		self.mCanvasGroupTop.alpha = 0
-- 	else
-- 		self.mClickActionTime = nil
-- 		self.mIsActionInit = nil
-- 		if (self.mBgTweener) then
-- 			self.mBgTweener:Kill()
-- 			self.mBgTweener = nil
-- 		end
-- 		if(self.mImgActionTimerSn)then
-- 			LoopManager:removeTimerByIndex(self.mImgActionTimerSn)
-- 			self.mImgActionTimerSn = nil
-- 		end
-- 		self.mImgBottom:SetImg("", false)
-- 		self.mImgTop:SetImg("", false)
-- 		self.mCanvasGroupBottom.alpha = 0
-- 		self.mCanvasGroupTop.alpha = 0
-- 		self.mImgActionIndex = nil
-- 	end
-- end

-- return _M



















-- 以下添加切换按钮的逻辑测试没空测，先屏蔽
--[[ 
-----------------------------------------------------
@filename       : BoardShower
@Description    : 背景板，用于最一开始的背景图或视频展示用
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("BoardShower", Class.impl())

BoardShower.BoardState = {
	None = nil,
	ImgBg = 2,
	VideoBg = 3,
}

function ctor(self)
	self.mBoardLayer = nil
	self.mTrans = nil
	self.mChildGos = nil
	self.mChildTrans = nil

	self:setBoardImgSource(nil)
	self:setBoardImgAudioSource(nil)
	self:setBoardVideoSource(nil)
	
	self.mSafetyTimer = nil
	self.mBoardState = nil

	self.mImgActionTimerSn = nil
	self.mBgTweener = nil

	self.mAutoActionTimes = 5
	self.mClickActionTime = nil
	self.mIsActionInit = nil
	self.mImgActionIndex = nil
	self.mImgActionList = {}
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_1.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_2.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_3.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_4.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_5.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_6.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_7.jpg"))
	table.insert(self.mImgActionList, UrlManager:getBgPath("updateRes/update_res_action_bg_8.jpg"))
end

function configUI(self)
	self.mGoImgBg = self.mChildGos["mImgBg"]
	self.mGoVideo = self.mChildGos["mAVProVideo"]
	self.mAvproPlayer = self.mChildGos["MediaPlayer"]:GetComponent(ty.MediaPlayer)

	self.mImgBottom = self.mChildGos["mImgActionBottom"]:GetComponent(ty.AutoRefImage)
	self.mImgTop = self.mChildGos["mImgActionTop"]:GetComponent(ty.AutoRefImage)
	self.mCanvasGroupBottom = self.mChildGos["mImgActionBottom"]:GetComponent(ty.CanvasGroup)
	self.mCanvasGroupTop = self.mChildGos["mImgActionTop"]:GetComponent(ty.CanvasGroup)
	self.mClick = self.mChildGos["mClick"]
	
	self.mBtnSwitch = self.mChildGos["mBtnSwitch"]
	self.mBtnSwitch:SetActive(false)

	self:addAllUIEvent()
end

function addAllUIEvent(self)
	self:addOnClick(self.mClick, self.__onClickSwitchImgBgHandler)
	self:addOnClick(self.mBtnSwitch, self.onClickSwitchModeHandler)
	sdk.SdkManager:addEventListener(sdk.SdkManager.DEVICE_DP_CHANGE, self.onDeviceDpChangeHandler, self)
end

function removeAllUIEvent(self)
	self:removeOnClick(self.mClick)
	self:removeOnClick(self.mBtnSwitch)
	sdk.SdkManager:removeEventListener(sdk.SdkManager.DEVICE_DP_CHANGE, self.onDeviceDpChangeHandler, self)
end

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    if obj == "" then
        obj = self.UIObject
    end
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if soundPath == "" then
            -- 不播音效
        elseif (soundPath == nil) then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
        else
            AudioManager:playSoundEffect(soundPath)
        end
        if params then
            callBack(self, unpack(params))
        else
            callBack(self)
        end
    end
    gs.UIComponentProxy.AddListener(obj, func)
end

-- 为组件移除侦听点击事件
function removeOnClick(self, obj)
    gs.UIComponentProxy.RemoveListener(obj)
end

function onDeviceDpChangeHandler(self, args)
	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
		if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
			VideoAdaptUtil:updateSize(self.mGoVideo:GetComponent(ty.RectTransform), 3)
		end
	end
end

function getBoardLayer(self)
	if(not self.mBoardLayer)then
		self.mBoardLayer = CS.UnityEngine.GameObject.Find("[UI_ROOT]").transform:Find("POP")
	end
	return self.mBoardLayer
end

function getBoardPrefabName(self)
	return "UpdateResBgBoard"
end

function getBoardPrefabPath(self)
	return UrlManager:getPrefabPath(string.format("updateRes/%s.prefab", self:getBoardPrefabName()))
end

function setBoardImgSource(self, path)
	if(path == nil)then
		self.mBoardImgSource = UrlManager:getBgPath("updateRes/update_res_loading_bg.jpg")
	else
		self.mBoardImgSource = path
	end
end
function getBoardImgSource(self)
	return self.mBoardImgSource
end

function setBoardImgAudioSource(self, path)
	if(path == nil)then
		self.mBoardImgAudioSource = UrlManager:getMusicPath("music_login.ogg")
	else
		self.mBoardImgAudioSource = path
	end
end
function getBoardImgAudioSource(self)
	return self.mBoardImgAudioSource
end

function setBoardVideoSource(self, path)
	if(path == nil)then
		self.mBoardVideoSource = gs.PathUtil.GetExistFullPath("extra/video/ui/update_res_cg.mp4")
	else
		self.mBoardVideoSource = path
	end
end
function getBoardVideoSource(self)
	return self.mBoardVideoSource
end

function setStorageBoardType(self, type)
	StorageUtil:saveNumber0("BOARD_SHOWER_TYPE", type)
end

function getStorageBoardType(self)
	return StorageUtil:getNumber0("BOARD_SHOWER_TYPE") or BoardShower.BoardState.VideoBg
end

-- 是否强制只能图片背景板，减少内存占用（苹果型号对照：https://www.jianshu.com/p/96e7374e6b17）
function isForceBoardImg(self)
	if (web.WebManager.platform == web.DEVICE_TYPE.ANDROID) then
		local systemGBSize = math.ceil(gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024)
		-- local usedGBSize = math.ceil(gs.SdkManager:GetMemorySize("GameUsedMemory") / 1024)
		if(systemGBSize < 4)then
			return true
		end
	elseif (web.WebManager.platform == web.DEVICE_TYPE.IOS) then -- 运存<3G强制图片背景板
		local deviceModel, count = string.gsub(string.lower(CS.UnityEngine.SystemInfo.deviceModel), " ", "")
		local paramList = string.split(deviceModel, ",")
		local model = paramList[1]
		local id = 0
		local subId = paramList[2] and tonumber(paramList[2]) or 0
		if (string.find(model, "iphone") ~= nil) then
			local iphoneId, _count = string.gsub(model, "iphone", "")
			id = tonumber(iphoneId)
			model = "iphone"
		elseif (string.find(model, "ipa") ~= nil) then
			model = "ipa"
		end

		if (model == "iphone") then
			if(id <= 8)then -- iphoneSE
				return true
			elseif(id == 9)then -- iphone7
				if(subId ~= 2 and subId ~= 4)then -- 非plus
					return true
				end
			elseif(id == 10)then
				if(subId ~= 2 and subId ~= 5 and subId ~= 3 and subId ~= 6)then -- 非iphone8plus 和 非iphonex
					return true
				end
			end
		end
	end
	return false
end

function setBoardState(self, state)
	self.mBoardState = state
end

function getBoardState(self)
	return self.mBoardState
end

function checkLoadBoardObj(self, finishCall)
	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
		finishCall()
	else
		if(BoardShower:getBoardState() ~= BoardShower.BoardState.None)then
			local boardTrans = self:getBoardLayer():Find(self:getBoardPrefabName())
			-- gs.GameObject.Destroy(boardTrans.gameObject)
			-- 复用之前残留旧的
			self.mChildGos, self.mChildTrans = GoUtil.GetChildHash(boardTrans.gameObject)
			self.mTrans = boardTrans
			self:configUI()
			finishCall()
			return
		end

		if(not self.mTrans)then
			local prefabName = self:getBoardPrefabPath()
			AssetLoader.PreLoadAsyn(prefabName, 
			function()
				local uiObject = AssetLoader.GetGO(prefabName)
				uiObject.name = self:getBoardPrefabName()
				self.mChildGos, self.mChildTrans = GoUtil.GetChildHash(uiObject)
				self.mTrans = uiObject.transform
				self.mTrans:SetParent(self:getBoardLayer(), false)
				-- self.mTrans:SetSiblingIndex(0)
				self:configUI()
				finishCall()
			end, self)
		end
	end
end

function showBoard(self, imgSource, imgAudioSource, videoSource, isMute, volume, callFun)
	self:setBoardImgSource(imgSource)
	self:setBoardImgAudioSource(imgAudioSource)
	self:setBoardVideoSource(videoSource)

	self:checkLoadBoardObj(
		function()
			self.mAvproPlayer:Stop()
			self.mAvproPlayer:CloseVideo()
			self.mAvproPlayer.Events:RemoveAllListeners()

			gs.AudioManager:StopMusic()
			self:removeBoardAction()

			if(self:isForceBoardImg())then
				self:setBoardState(BoardShower.BoardState.ImgBg)
			else
				if(self:getStorageBoardType() == BoardShower.BoardState.ImgBg)then
					self:setBoardState(BoardShower.BoardState.ImgBg)
				else
					self:setBoardState(BoardShower.BoardState.VideoBg)
				end
			end
			self:_showBoard(imgSource, imgAudioSource, videoSource, isMute, volume, callFun)
		end
	)
end

function _showBoard(self, imgSource, imgAudioSource, videoSource, isMute, volume, callFun)
	local removeSafetyTimer = function()
		if(self.mSafetyTimer)then
			LoopManager:removeTimerByIndex(self.mSafetyTimer)
			self.mSafetyTimer = nil
		end
	end

	if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
		self.mGoImgBg:SetActive(false)
		self.mGoVideo:SetActive(true)
		
		-- 安全机制：视频出任何意外报错等无法播放时，5s一到就跳过视频模式
		removeSafetyTimer()
		self.mSafetyTimer = LoopManager:addTimer(5, 1, self, 
		function()
			self.mAvproPlayer:Stop()
			self.mAvproPlayer:CloseVideo()
			self.mAvproPlayer.Events:RemoveAllListeners()
			if(callFun)then
				callFun()
			end
		end)

		VideoAdaptUtil:updateSize(self.mGoVideo:GetComponent(ty.RectTransform), 3)
		
		self.mAvproPlayer.Events:AddListener(
			function(mediaPlayer, eventType, errorCode)
				if(eventType == gs.MediaPlayerEventType.FirstFrameReady)then        -- 渲染第一帧时触发
					removeSafetyTimer()
					if(callFun)then
						callFun()
					end
				elseif(eventType == gs.MediaPlayerEventType.Error)then              -- 发生错误时触发
					removeSafetyTimer()
					if(callFun)then
						LoopManager:addFrame(2, 1, self, callFun)
					end
				end
			end
		)
		AvproUtil:init(self.mAvproPlayer)
		self.mAvproPlayer:OpenVideoFromFile(gs.MediaPlayer.FileLocation.AbsolutePathOrURL, videoSource, false)
		self.mAvproPlayer:Play()
		if(volume ~= nil)then
			AvproUtil:setVolume(self.mAvproPlayer, volume)
		end
		AvproUtil:muteAudio(self.mAvproPlayer, isMute)
	else
		self.mGoImgBg:SetActive(true)
		self.mGoVideo:SetActive(false)

		self.mGoImgBg:GetComponent(ty.AutoRefImage):SetImg(imgSource, false)

		if(imgAudioSource and imgAudioSource ~= "")then
			gs.AudioManager:PlayMusic(imgAudioSource)
		else
			gs.AudioManager:StopMusic()
		end
		if(volume ~= nil)then
			gs.AudioManager.MusicVolume = volume
		end
		if(isMute)then
			gs.AudioManager:PauseMusic()
		else
			gs.AudioManager:UnPauseMusic()
		end

		if(callFun)then
			LoopManager:addFrame(2, 1, self, callFun)
		end
	end
end

function updateBoard(self, isMute, volume, callFun)
	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
		if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
			if(volume ~= nil)then
				AvproUtil:setVolume(self.mAvproPlayer, volume)
			end
			AvproUtil:muteAudio(self.mAvproPlayer, isMute)
		else
			if(volume ~= nil)then
				gs.AudioManager.MusicVolume = volume
			end
			if(isMute)then
				gs.AudioManager:PauseMusic()
			else
				gs.AudioManager:UnPauseMusic()
			end
		end
	end

	if(callFun)then
		callFun()
	end
end

function hideBoard(self, callFun)
	local isExit = GameManager:getIsExiting()
	if(isExit)then
		-- 正在退出登录中理应保持显示，不隐藏
		return
	end
	if(self.mTrans and not gs.GoUtil.IsTransNull(self.mTrans))then
		self:removeAllUIEvent()
		if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
			self.mAvproPlayer:Stop()
			self.mAvproPlayer:CloseVideo()
			self.mAvproPlayer.Events:RemoveAllListeners()
		else
			gs.AudioManager:StopMusic()
			self:removeBoardAction()
		end
		gs.GameObject.Destroy(self.mTrans.gameObject)
	end

	-- 再次安全检测销毁
	local boardTrans = self:getBoardLayer():Find(self:getBoardPrefabName())
	if(boardTrans)then
		gs.GameObject.Destroy(boardTrans.gameObject)
	end
	
	self.mTrans = nil
	self.mChildGos = nil
	self.mChildTrans = nil
	self:setBoardImgSource(nil)
	self:setBoardImgAudioSource(nil)
	
	if(sdk.SdkManager:getIsSimulator())then
		-- 模拟器重设一样的视频路径，如果视频有更新，则要等重运行或重启生效
		self:setBoardVideoSource(self:getBoardVideoSource())
	else
		-- 非模拟器自动重置为最新存在的视频路径（雷电模拟器下点击登录后再次运行此方法会直接卡死）
		self:setBoardVideoSource(nil)
	end
	self:setBoardState(BoardShower.BoardState.None)
	if(callFun)then
		callFun()
	end
end

function __onClickSwitchImgBgHandler(self)
	if(BoardShower:getBoardState() ~= BoardShower.BoardState.VideoBg)then
		if(self.mIsActionInit)then
			local nowTime = web.__getTime()
			local isCanClick = false
			if(self.mClickActionTime == nil)then
				self.mClickActionTime = nowTime
				isCanClick = true
			elseif(nowTime - self.mClickActionTime >= 1)then
				self.mClickActionTime = nowTime
				isCanClick = true
			end

			if(isCanClick)then
				if(self.mImgActionTimerSn)then
					LoopManager:removeTimerByIndex(self.mImgActionTimerSn)
					self.mImgActionTimerSn = nil
				end
				self.mImgActionTimerSn = LoopManager:addTimer(self.mAutoActionTimes, 0, self, self.__onBoardActionHandler)
				self:__onBoardActionHandler()
			end
		end
	end
end

function onClickSwitchModeHandler(self)
	if(BoardShower:getBoardState() == BoardShower.BoardState.VideoBg)then
		self:setStorageBoardType(BoardShower.BoardState.ImgBg)
		self:setBoardState(BoardShower.BoardState.ImgBg)
		self:_showBoard(BoardShower:getBoardImgSource(), BoardShower:getBoardImgAudioSource(), BoardShower:getBoardVideoSource(), false, nil, function()
			self.mAvproPlayer:Stop()
			self.mAvproPlayer:CloseVideo()
			self.mAvproPlayer.Events:RemoveAllListeners()
			self:addBoardAction()
		end)
	else
		if(not BoardShower:isForceBoardImg())then
			self:setStorageBoardType(BoardShower.BoardState.VideoBg)
			self:setBoardState(BoardShower.BoardState.VideoBg)
			self:_showBoard(BoardShower:getBoardImgSource(), BoardShower:getBoardImgAudioSource(), BoardShower:getBoardVideoSource(), false, nil, function()
				gs.AudioManager:StopMusic()
				self:removeBoardAction(BoardShower.BoardState.ImgBg)
			end)
		end
	end
end

function addBoardAction(self, boardState)
	boardState = boardState or BoardShower:getBoardState()
	if(boardState == BoardShower.BoardState.VideoBg)then
		self.mImgBottom:SetImg("", false)
		self.mImgTop:SetImg("", false)
		self.mCanvasGroupBottom.alpha = 0
		self.mCanvasGroupTop.alpha = 0
	else
		if(not self.mImgActionTimerSn)then
			-- 首次轮播先延迟显示，保证和登录界面的背景图间隔一致，显示有规律
			self.mImgActionTimerSn = LoopManager:addTimer(self.mAutoActionTimes, 0, self, 
			function()
				self.mImgActionIndex = 1
				local actionImgSource = self.mImgActionList[self.mImgActionIndex]
				self.mImgTop:SetImg(actionImgSource, false)
				
				if (self.mBgTweener) then
					self.mBgTweener:Kill()
					self.mBgTweener = nil
				end
				self.mCanvasGroupBottom.alpha = 0
				self.mCanvasGroupTop.alpha = 0
				self.mBgTweener = TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupTop, 0, 1, 0.5, gs.DT.Ease.InExpo, 
				function()
					self.mIsActionInit = true
				end)
	
				if(self.mImgActionTimerSn)then
					LoopManager:removeTimerByIndex(self.mImgActionTimerSn)
					self.mImgActionTimerSn = nil
				end
				self.mImgActionTimerSn = LoopManager:addTimer(self.mAutoActionTimes, 0, self, 
				function()
					self:__onBoardActionHandler()
				end)
			end)
		end
	end
end

function __onBoardActionHandler(self)
	if(self.mImgActionIndex >= #self.mImgActionList)then
		self.mImgActionIndex = 1
	else
		self.mImgActionIndex = self.mImgActionIndex + 1
	end
	local actionImgSource = self.mImgActionList[self.mImgActionIndex]
	self.mImgBottom:SetImg(actionImgSource, false)

	if (self.mBgTweener) then
		self.mBgTweener:Kill()
		self.mBgTweener = nil
	end
	self.mCanvasGroupBottom.alpha = 1
	self.mCanvasGroupTop.alpha = 1
    self.mBgTweener = TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupTop, 1, 0, 0.5, gs.DT.Ease.InExpo,
    function()
		self.mImgTop:SetImg(actionImgSource, false)
    end)
end

function removeBoardAction(self, boardState)
	boardState = boardState or BoardShower:getBoardState()
	if(boardState == BoardShower.BoardState.VideoBg)then
		self.mImgBottom:SetImg("", false)
		self.mImgTop:SetImg("", false)
		self.mCanvasGroupBottom.alpha = 0
		self.mCanvasGroupTop.alpha = 0
	else
		self.mImgBottom:SetImg("", false)
		self.mImgTop:SetImg("", false)
		self.mCanvasGroupBottom.alpha = 0
		self.mCanvasGroupTop.alpha = 0

		self.mIsActionInit = nil
		self.mImgActionIndex = nil
		self.mClickActionTime = nil

		if (self.mBgTweener) then
			self.mBgTweener:Kill()
			self.mBgTweener = nil
		end
		if(self.mImgActionTimerSn)then
			LoopManager:removeTimerByIndex(self.mImgActionTimerSn)
			self.mImgActionTimerSn = nil
		end
	end
end

return _M
