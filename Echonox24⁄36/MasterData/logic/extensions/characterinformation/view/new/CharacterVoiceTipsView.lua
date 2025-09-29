-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterVoiceTipsView.lua

module("logic.extensions.characterinformation.view.new.CharacterVoiceTipsView", package.seeall)

local M = class("CharacterVoiceTipsView", ViewComponent)

function M:buildUI()
	self._cellVoice = {}
	self._goEmpty = self:getGo("empty_unit_-1401348703")
	self._goNormal = self:getGo("role_voice_tips_copy_-1958082757")
	self._scroll = self:getUIComponent("role_voice_tips_copy_-1911347742", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self:getGo("role_voice_tips_copy_-1911347742"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._txtName = self:getText("role_voice_tips_copy_-1758345571")
	self._txtContent = self:getUIComponent("role_voice_tips_copy_1525118230", UIComponentType.TextMeshProUGUI)
	self._txtLockInfo = self:getText("role_voice_tips_copy_-1534818078")
	self._goSlider = self:getGo("role_voice_tips_copy_-1147814077")
	self._sliderProcess = UIComponentType.SliderAdapter(self._goSlider)
	self._txtCurTime = self:getText("role_voice_tips_copy_-1483700139")
	self._txtMaxTime = self:getText("role_voice_tips_copy_2125438165")
	self._animTape = self:getUIComponent("role_voice_tips_copy_1727311940", ComponentType.Animation)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
	self._sliderProcess = nil

	for _, cell in pairs(self._cellVoice or {}) do
		cell.destroyUI()
	end

	self._cellVoice = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonType)
	self:setEvent(true)

	local info = self:getFirstParam()

	self._heroId = info.heroId

	printWarn("heroId:", self._heroId)

	local heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	if not heroData then
		self:close()

		return
	end

	if Astral.OSDef.isEditor then
		printWarn(string.format("角色[%s]", self._heroId))
		TableUtil.dump(CharacterInformationModel.instance:getNewVoiceLst(heroData:getId(), true))
		TableUtil.dump(CharacterInformationModel.instance:getNewVoiceLst(heroData:getId(), false))
	end

	self._txtName.text = heroData:getName()

	self:_setSelectIndex(nil)
	self:refreshLst(true, true)
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	self:setEvent(false)
	self:_setSelectIndex(nil)
	self:_playItemOpenAni(false)
	self._animTape:Stop()
	AnimationUtils.ResetAnimation(self._animTape)
end

function M:onExitFinished()
	self._loopList:ClearCells()
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:getIsVoiceResExist(heroId, audioId)
	return CharacterInformationModel.instance:getIsVoiceResExist(heroId, audioId)
end

function M:refreshLst(resetPos, playOpenAni)
	local cgfList = CharacterAudioConfig.instance:getCharacterAudiosById(self._heroId) or {}

	self._voiceUnlockLst = {}
	self._voiceNoResMap = {}
	self._voiceLst = {}

	for _, _cfg in pairs(cgfList) do
		local isUnlock = CharacterInformationModel.instance:getUnlockVoice(self._heroId, _cfg.audioId, false)
		local resExist = self:getIsVoiceResExist(self._heroId, _cfg.audioId)

		if not resExist then
			isUnlock = false
			self._voiceNoResMap[_cfg.audioId] = 1
		end

		self._voiceUnlockLst[_cfg.audioId] = isUnlock

		table.insert(self._voiceLst, _cfg)
	end

	table.sort(self._voiceLst, function(a, b)
		local aIsUnlock = self._voiceUnlockLst[a.audioId] and 1 or 0
		local bIsUnlock = self._voiceUnlockLst[b.audioId] and 1 or 0

		if aIsUnlock ~= bIsUnlock then
			return bIsUnlock < aIsUnlock
		else
			local aSort = CharacterAudioConfig.instance:getSoundSort(a.audioId)
			local bSort = CharacterAudioConfig.instance:getSoundSort(b.audioId)

			return aSort < bSort
		end
	end)

	self._needPlayItemCellOpenAni = playOpenAni
	self._needPlayItemAniMaxIndex = 7
	self._itemShowerCache = {}

	local len = self._voiceLst and #self._voiceLst or 0
	local show = len > 0

	if show then
		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end

	self:_playItemOpenAni(playOpenAni)
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		local maxDelay = 0.1

		self._scroll.enabled = false

		for index, shower in ipairs(self._itemShowerCache or {}) do
			local delay = index * 0.05

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay < delay and delay or maxDelay

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				shower.playEntry(true)
			end)

			table.insert(self._cacheTweenLst, tweenDelay)
		end

		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay + 0.1, function()
			self._scroll.enabled = true
		end))
	else
		for index, shower in ipairs(self._itemShowerCache or {}) do
			shower.playEntry(false)
		end

		self._cacheTweenLst = nil
		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false
		self._scroll.enabled = true
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("role_voice_item_copy")

	self:_updateCellVoice(item.gameObject, curIndex)

	return item
end

function M:_updateCellVoice(go, index)
	local key = go:GetInstanceID()
	local theItem = self._cellVoice[key]

	if not theItem then
		theItem = {
			index = index,
			go = go
		}
		theItem.isLock = false
		theItem.canvasGroup = goutil.findChildComponent(go, "click/content", ComponentType.CanvasGroup)
		theItem.rectTrClick = goutil.findChildComponent(go, "click", UIComponentType.RectTransform)
		theItem.canvasGroupClick = goutil.findChildComponent(go, "click", ComponentType.CanvasGroup)
		theItem.goSelect = goutil.findChild(go, "click/select").gameObject
		theItem.goNew = goutil.findChild(go, "click/new_sigh").gameObject
		theItem.goLock = goutil.findChild(go, "click/content/lock").gameObject
		theItem.goStop = goutil.findChild(go, "click/content/play").gameObject
		theItem.goPlaying = goutil.findChild(go, "click/content/playing").gameObject
		theItem.txtName = goutil.findChildTextComponent(go, "click/content/txtInfo")
		theItem.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.setPlaying(playing)
			local isSelect = self:_getSelectIndex() == theItem.getIndex()

			goutil.setActive(theItem.goStop, isSelect and not playing and not theItem.isLock)
			goutil.setActive(theItem.goPlaying, isSelect and playing and not theItem.isLock)
		end

		function theItem.updatePlaying()
			local isPlaying = self:_getPlayingIndex() == theItem.getIndex()

			theItem.setPlaying(isPlaying)
		end

		function theItem.setIsLock(isLock)
			theItem.isLock = isLock

			goutil.setActive(theItem.goLock, isLock)

			if isLock then
				goutil.setActive(theItem.goStop, false)
				goutil.setActive(theItem.goPlaying, false)
			end

			theItem.canvasGroup.alpha = isLock and 0.5 or 1
		end

		function theItem.setIsSelect(isSelect)
			goutil.setActive(theItem.goSelect, isSelect)
		end

		function theItem.updateSelect()
			local isSelect = self:_getSelectIndex() == theItem.getIndex()

			theItem.setIsSelect(isSelect)
		end

		function theItem.setIsNew(isNew)
			goutil.setActive(theItem.goNew, isNew)
		end

		function theItem.playEntry(play)
			theItem.rectTrClick:DOKill(false)
			theItem.canvasGroupClick:DOKill(false)

			if play then
				local duraion = 0.3

				theItem.canvasGroupClick.alpha = 0

				RectTransformUtils.SetAnchoredPosition(theItem.rectTrClick, 0, 84 * (index - 1))
				theItem.rectTrClick:DOAnchorPosY(0, duraion):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
				theItem.canvasGroupClick:DOFade(1, duraion):SetEase(DG.Tweening.Ease.InCubic):SetAutoKill(true)
			else
				theItem.canvasGroupClick.alpha = 1

				RectTransformUtils.SetAnchoredPosition(theItem.rectTrClick, 0, 0)
			end
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellClick(theItem, theItem.index)
		end, self)

		function theItem.destroyUI()
			theItem.btnClick:RemoveClickListener()
		end

		self._cellVoice[key] = theItem
	end

	theItem.index = index

	local data = self._voiceLst[index]
	local isUnlock = self._voiceUnlockLst[data.audioId]
	local isNew = CharacterInformationModel.instance:getIsNewVoice(self._heroId, data.audioId)
	local isResExist = self:getIsVoiceResExist(self._heroId, data.audioId)

	theItem.txtName.text = data.audioName

	theItem.setIsLock(not isUnlock)
	theItem.setIsNew(isNew and isResExist)
	theItem.updateSelect()
	theItem.updatePlaying()

	if self._needPlayItemCellOpenAni and index <= self._needPlayItemAniMaxIndex then
		self._itemShowerCache[index] = theItem
		theItem.canvasGroupClick.alpha = 0
	else
		theItem.canvasGroupClick.alpha = 1
	end
end

function M:_onCellClick(cell, index)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_yinxiangyuyinbofang, nil, nil, nil)

	local data = self._voiceLst[index]
	local VoiceEnumRes = CharacterInfoEnum.VoiceRes[data.audioId]
	local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, self._heroId) or data.voiceId
	local isBlackBox = data.audioId == CharacterInfoEnum.VoiceResKey.heihezi
	local isUnlock = self._voiceUnlockLst[data.audioId]
	local orgIsNew = CharacterInformationModel.instance:getIsNewVoice(self._heroId, data.audioId)

	self:_setSelectIndex(index)

	if orgIsNew and isUnlock then
		CharacterInformationModel.instance:setReadVoice(self._heroId, data.audioId)
		cell.setIsNew(false)
	end

	for _, _cell in pairs(self._cellVoice) do
		_cell.updateSelect()
		_cell.updatePlaying()
	end
end

function M:_setSelectIndex(index)
	self._selectIndex = index

	goutil.setActive(self._goEmpty, not index)
	goutil.setActive(self._goNormal, index)

	if not index then
		self:_playVoice(false)

		return
	end

	local data = self._voiceLst[index]
	local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(self._heroId, data.audioId)
	local isUnlock = self._voiceUnlockLst[data.audioId]

	if isUnlock then
		if self:_getPlayingIndex() == index then
			self:_playVoice(false)

			self._txtContent.text = lang("tip_click_play_again")
		else
			self:_playVoice(true, index)

			local str = cfg and cfg.qipaoContent or ""

			if not string.nilorempty(str) then
				str = StringUtil.replaceTMPBlackBlock(str)
			end

			self._txtContent.text = str
		end
	else
		self:_playVoice(false)

		local lockStr

		if self._voiceNoResMap[data.audioId] then
			lockStr = lang("tip_system_open_not_online")
		else
			local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstVoice(self._heroId, data.audioId)

			lockStr = CharacterInformationController.instance:getConditionUnlockDesc(conditionLst)
		end

		self._txtLockInfo.text = lockStr
	end

	goutil.setActive(self._goSlider, isUnlock)
	goutil.setActive(self._txtName.gameObject, isUnlock)
	goutil.setActive(self._txtContent.gameObject, isUnlock)
	goutil.setActive(self._txtLockInfo.gameObject, not isUnlock)

	if Astral.OSDef.isEditor then
		printWarn(string.format("select[%s] index[%s] audioId[%s] heroID[%s]", self._selectIndex, index, data.audioId, self._heroId))
	end
end

function M:_getSelectIndex()
	return self._selectIndex
end

function M:_getPlayingIndex()
	return self._playingIndex
end

function M:_playVoice(play, index)
	self._sliderProcess.slider:DOKill(false)
	self._sliderProcess:SetValue(0)

	self._txtCurTime.text = self:_formatMusicTime(0)

	if self._voiceRes then
		CriwareAudioFacade.instance:stopSoundByName(self._voiceRes)
	end

	if play then
		self._playingIndex = index

		local data = self._voiceLst[index]
		local VoiceEnumRes = CharacterInfoEnum.VoiceRes[data.audioId]

		self._voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, self._heroId) or data.voiceId

		local wwiseCo = CriwareAudioConfig.instance:getCOByName(self._voiceRes)

		if not wwiseCo then
			self._txtMaxTime.text = self:_formatMusicTime(0)

			if Astral.OSDef.isEditor then
				FloatWordMgr.instance:show(string.format("角色[%s]audioId[%s]无法找到资源", self._heroId, data.audioId))
			elseif enableErrorLog then
				printError(string.format("角色[%s]audioId[%s]无法找到资源", self._heroId, data.audioId))
			end

			return
		end

		CriwareAudioFacade.instance:playSEByName(self._voiceRes, self.mainGO, nil, nil)

		self._voiceTotalTime = CriwareAudioFacade.instance:getCueTotalTimeByName(self._voiceRes)

		self._sliderProcess.slider:DOValue(1, self._voiceTotalTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnUpdate(self._onSliderUpdate, self):OnComplete(self._playVoiceFinish, self)

		self._txtMaxTime.text = self:_formatMusicTime(self._voiceTotalTime)

		self._animTape:Stop()
		self._animTape:Play("quan")
	else
		self._voiceTotalTime = nil
		self._playingIndex = nil
		self._voiceRes = nil

		self._animTape:Stop()
		AnimationUtils.ResetAnimation(self._animTape)
	end
end

function M:_formatMusicTime(time)
	if time < 0.5 then
		time = 1
	end

	time = MathUtil.roundingBy456(time)

	local sec = time % 60
	local min = math.floor(time / 60)

	return string.format("%02d:%02d", min, sec)
end

function M:_onSliderUpdate()
	local val = self._sliderProcess:GetValue()
	local time = self._voiceTotalTime * val

	self._txtCurTime.text = self:_formatMusicTime(time)
end

function M:_playVoiceFinish()
	self:_playVoice(false)
	goutil.setActive(self._txtName.gameObject, false)
	goutil.setActive(self._goSlider, false)

	self._txtContent.text = lang("tip_click_play_again")

	for _, _cell in pairs(self._cellVoice) do
		_cell.updatePlaying()
	end
end

return M
