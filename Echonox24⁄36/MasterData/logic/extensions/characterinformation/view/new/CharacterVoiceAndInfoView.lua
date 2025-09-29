-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterVoiceAndInfoView.lua

module("logic.extensions.characterinformation.view.new.CharacterVoiceAndInfoView", package.seeall)

local M = class("CharacterVoiceAndInfoView", CharacterMainSystemSubViewBase)
local infoType = CharacterInfoEnum.UnlockTyp
local txtCloseAni = "information_main_panel_txttips_close"
local txtOpenAni = "information_main_panel_txttips_open"
local tabVoiceAni = "information_main_panel_rightpanel_open01voice"
local tabInfoAni = "information_main_panel_rightpanel_open02file"

function M:buildUI()
	M.super.buildUI(self)

	local voiceToggleGo = self._registry:getGo("information_main_panel_556059204")

	self._voiceTab = voiceToggleGo:GetComponent(UIComponentType.SpaceXToggle)

	local infoToggleGo = self._registry:getGo("information_main_panel_813022766")

	self._infoTab = infoToggleGo:GetComponent(UIComponentType.SpaceXToggle)
	self._scrollViewFile = self._registry:getGo("information_main_panel_1771616346")
	self._scrollViewVoice = self._registry:getGo("information_main_panel_1728532713")
	self._voiceRedPoint = goutil.findChild(voiceToggleGo.gameObject, "red_point")
	self._infoRedPoint = goutil.findChild(infoToggleGo.gameObject, "red_point")

	local animationTempGo = self._registry:getGo("information_main_panel_746126700")

	self._animationTab = animationTempGo.gameObject:GetComponent(ComponentType.Animation)
	self._cellVoice = {}
	self._loopList = LoopListHelper.New(self._scrollViewVoice)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._txtContent = self._registry:getUIComponent("information_main_panel_1456920112", UIComponentType.TextMeshProUGUI)

	goutil.setActive(self._txtContent.gameObject, false)

	local objMaskGo = self._registry:getGo("information_main_panel_-1122461096")

	self._shadow = goutil.findChild(objMaskGo.gameObject, "imgDi")

	goutil.setActive(self._shadow.gameObject, false)

	self._animationTxt = objMaskGo.gameObject:GetComponent(ComponentType.Animation)
	self._canvasGroup = self._scrollViewFile:GetComponent(ComponentType.CanvasGroup)
	self._imgCarrer = self._registry:getImage("information_main_panel_1963399371")
	self._txtInfo = {
		[infoType.OrganName] = self._registry:getUIComponent("information_main_panel_509659838", UIComponentType.TextMeshProUGUI),
		[infoType.Height] = self._registry:getUIComponent("information_main_panel_234144190", UIComponentType.TextMeshProUGUI),
		[infoType.Weight] = self._registry:getUIComponent("information_main_panel_-1595647530", UIComponentType.TextMeshProUGUI),
		[infoType.Birth] = self._registry:getUIComponent("information_main_panel_1338457538", UIComponentType.TextMeshProUGUI),
		[infoType.Ability] = self._registry:getUIComponent("information_main_panel_1504604971", UIComponentType.TextMeshProUGUI),
		[infoType.Area] = self._registry:getUIComponent("information_main_panel_1168752891", UIComponentType.TextMeshProUGUI),
		[infoType.BaseInfo] = self._registry:getUIComponent("information_main_panel_734431205", UIComponentType.TextMeshProUGUI)
	}
	self._txtGetTime = self._registry:getUIComponent("information_main_panel_853510777", UIComponentType.TextMeshProUGUI)
	self._txtActionTime = self._registry:getUIComponent("information_main_panel_1549415230", UIComponentType.TextMeshProUGUI)
	self._txtSpFileLst = {
		[infoType.SpFile1] = {
			txt = self._registry:getUIComponent("information_main_panel_684767653", UIComponentType.TextMeshProUGUI)
		},
		[infoType.SpFile2] = {
			txt = self._registry:getUIComponent("information_main_panel_1288532416", UIComponentType.TextMeshProUGUI)
		},
		[infoType.SpFile3] = {
			txt = self._registry:getUIComponent("information_main_panel_797764806", UIComponentType.TextMeshProUGUI)
		}
	}
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._voiceTab = nil
	self._infoTab = nil
	self._scrollViewFile = nil
	self._scrollViewVoice = nil

	self._loopList:Dispose()

	self._loopList = nil

	for _, cell in pairs(self._cellVoice or {}) do
		cell.destroyUI()
	end

	self._cellVoice = nil
end

function M:bindEvents()
	self._voiceTab:AddListener(function(_, isOn)
		goutil.setActive(self._scrollViewVoice.gameObject, isOn)
		goutil.setActive(self._scrollViewFile.gameObject, not isOn)

		if isOn then
			self._animationTab:Stop()
			self._animationTab:Play(tabVoiceAni)
		end
	end, nil)
	self._infoTab:AddListener(function(_, isOn)
		goutil.setActive(self._scrollViewFile.gameObject, isOn)
		goutil.setActive(self._scrollViewVoice.gameObject, not isOn)

		if isOn then
			self:setCloseVoice()
			self._animationTab:Stop()
			self._animationTab:Play(tabInfoAni)
		end
	end, nil)
end

function M:unbindEvents()
	self._voiceTab:RemoveListener()
	self._infoTab:RemoveListener()
end

function M:onEnter(reasonType)
	self:setEvent(true)
	M.super.onEnter(self)
	self:_showInfoAndVoice()
end

function M:onExit(reasonType)
	self:setEvent(false)
	self:setCloseVoice()
	goutil.setActive(self._txtContent.gameObject, false)
	goutil.setActive(self._shadow.gameObject, false)

	self._pastInfoContent = nil

	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = nil
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	return viewPageMo and viewPageMo.hero or false
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._showInfoAndVoice, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._showInfoAndVoice, self)
	end
end

function M:_showInfoAndVoice()
	local heroData = self:getCurHeroData()

	self._heroId = heroData and heroData:getId() or 2000022

	self:_showRedPoint()
	self:_setSelectIndex(nil)
	self:refreshLst(true, true)

	self._pastInfoContent = nil

	self:_blockKey(false)
	self:refreshView()
	settimer(1, self._handleViewAniDoneEvent, self, false)
end

function M:_showRedPoint()
	local hasNewPastInfo = #CharacterInformationModel.instance:getNewPastInfoLst(self._heroId, false) > 0
	local hasNewVoice = #CharacterInformationModel.instance:getNewVoiceLst(self._heroId, true) > 0

	goutil.setActive(self._voiceRedPoint.gameObject, hasNewVoice)
	goutil.setActive(self._infoRedPoint.gameObject, hasNewPastInfo)
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
			local aIsNew = CharacterInformationModel.instance:getIsNewVoice(self._heroId, a.audioId) and 1 or 0
			local bIsNew = CharacterInformationModel.instance:getIsNewVoice(self._heroId, b.audioId) and 1 or 0

			if aIsNew ~= bIsNew then
				return bIsNew < aIsNew
			end

			local aSort = CharacterAudioConfig.instance:getSoundSort(a.audioId)
			local bSort = CharacterAudioConfig.instance:getSoundSort(b.audioId)

			return aSort < bSort
		end
	end)

	local len = self._voiceLst and #self._voiceLst or 0
	local show = len > 0

	if show then
		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()

		if resetPos then
			self._loopList:MoveToItemIndex(0)
		end
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("role_voice_item")

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
		theItem.goLock = goutil.findChild(go, "click/content/stateLock").gameObject
		theItem.goStop = goutil.findChild(go, "click/content/stateNormal").gameObject
		theItem.goPlaying = goutil.findChild(go, "click/content/statePlaying").gameObject
		theItem.iconPlay = goutil.findChild(go, "click/content/statePlaying/img1").gameObject
		theItem.txtName = goutil.findChildTextComponent(go, "click/content/objContent/txtInfo")
		theItem.rectTrPlayLine = goutil.findChildComponent(go, "click/content/statePlaying/img3", UIComponentType.RectTransform)
		theItem.txtLockCondition = goutil.findChildTextComponent(go, "click/content/objContent/txtCondition")
		theItem.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.setPlaying(playing)
			local isSelect = self:_getSelectIndex() == theItem.getIndex()

			goutil.setActive(theItem.goStop, not playing and not theItem.isLock)
			goutil.setActive(theItem.goPlaying, isSelect and playing and not theItem.isLock)

			if isSelect and playing and not theItem.isLock then
				local data = self._voiceLst[theItem.index]
				local VoiceEnumRes = CharacterInfoEnum.VoiceRes[data.audioId]
				local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, self._heroId) or data.voiceId
				local voiceTotalTime = CriwareAudioFacade.instance:getCueTotalTimeByName(voiceRes)

				RectTransformUtils.SetAnchoredPosition(theItem.rectTrPlayLine, 20, 0)
				theItem.rectTrPlayLine:DOAnchorPosX(210, voiceTotalTime):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
			else
				theItem.rectTrPlayLine:DOKill(false)
			end
		end

		function theItem.updatePlaying()
			local isPlaying = self:_getPlayingIndex() == theItem.getIndex()

			theItem.setPlaying(isPlaying)
		end

		function theItem.setIsLock(isLock)
			theItem.isLock = isLock

			goutil.setActive(theItem.goLock, isLock)
			goutil.setActive(theItem.txtLockCondition.gameObject, isLock)

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

	if not isUnlock then
		local lockStr

		if self._voiceNoResMap[data.audioId] then
			lockStr = lang("tip_system_open_not_online")
		else
			local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstVoice(self._heroId, data.audioId)

			lockStr = CharacterInformationController.instance:getConditionUnlockDesc(conditionLst)
		end

		theItem.txtLockCondition.text = lockStr
	end

	theItem.setIsLock(not isUnlock)
	theItem.setIsNew(isNew and isResExist)
	theItem.updateSelect()
	theItem.updatePlaying()
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
		CharacterInformationController.instance:checkRedPoint(self._heroId)
		self:_showRedPoint()
		cell.setIsNew(false)
	end

	for _, _cell in pairs(self._cellVoice) do
		_cell.updateSelect()
		_cell.updatePlaying()
	end
end

function M:_setSelectIndex(index)
	self._selectIndex = index

	goutil.setActive(self._goNormal, index)

	if not index then
		self:_playVoice(false)

		return
	end

	local data = self._voiceLst[index]
	local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(self._heroId, data.audioId)
	local isUnlock = self._voiceUnlockLst[data.audioId]

	if isUnlock then
		goutil.setActive(self._txtContent.gameObject, isUnlock)
		goutil.setActive(self._shadow.gameObject, isUnlock)

		if self:_getPlayingIndex() == index then
			self:_playVoice(false)
			self._animationTxt:Stop()
			self._animationTxt:Play(txtCloseAni)
		else
			self:_playVoice(true, index)

			local str = cfg and cfg.qipaoContent or ""

			if not string.nilorempty(str) then
				str = StringUtil.replaceTMPBlackBlock(str)
			end

			goutil.setActive(self._shadow.gameObject, true)
			self._animationTxt:Stop()

			self._txtContent.text = str

			self._animationTxt:Play(txtOpenAni)
		end
	else
		if self._playingIndex then
			self._animationTxt:Stop()
			self._animationTxt:Play(txtCloseAni)
		end

		self:_playVoice(false)

		local lockStr

		if self._voiceNoResMap[data.audioId] then
			lockStr = lang("tip_system_open_not_online")
		else
			local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstVoice(self._heroId, data.audioId)

			lockStr = CharacterInformationController.instance:getConditionUnlockDesc(conditionLst)
		end

		FloatWordMgr.instance:show(lockStr)
	end

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

function M:_playVoiceFinish()
	self:_playVoice(false)
	self._animationTxt:Stop()
	self._animationTxt:Play(txtCloseAni)

	for _, _cell in pairs(self._cellVoice or {}) do
		_cell.updatePlaying()
	end
end

function M:_playVoice(play, index)
	if self._voiceRes then
		CriwareAudioFacade.instance:stopVoice()
	end

	removetimer(self._playVoiceFinish, self)

	if play then
		self._playingIndex = index

		local data = self._voiceLst[index]
		local VoiceEnumRes = CharacterInfoEnum.VoiceRes[data.audioId]

		self._voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, self._heroId) or data.voiceId

		local wwiseCo = CriwareAudioConfig.instance:getCOByName(self._voiceRes)

		if not wwiseCo then
			if Astral.OSDef.isEditor then
				FloatWordMgr.instance:show(string.format("角色[%s]audioId[%s]无法找到资源", self._heroId, data.audioId))
			elseif enableErrorLog then
				printError(string.format("角色[%s]audioId[%s]无法找到资源", self._heroId, data.audioId))
			end

			return
		end

		local voiceTotalTime = CriwareAudioFacade.instance:getCueTotalTimeByName(self._voiceRes)

		settimer(voiceTotalTime, self._playVoiceFinish, self, false)
		CriwareAudioFacade.instance:playVoiceByName(self._voiceRes)
	else
		removetimer(self._playVoiceFinish, self)

		self._playingIndex = nil
		self._voiceRes = nil
	end
end

function M:getCurItemVoice()
	for _, _cell in pairs(self._cellVoice) do
		if _cell.getIndex() == self:_getSelectIndex() then
			return _cell
		end
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

function M:setCloseVoice()
	if self:_getPlayingIndex() then
		self._animationTxt:Stop()
		self._animationTxt:Play(txtCloseAni)
	end

	self:_setSelectIndex(nil)

	for _, _cell in pairs(self._cellVoice) do
		_cell.updateSelect()
		_cell.updatePlaying()
	end

	self:refreshLst(true, true)
end

function M:_blockKey(block)
	self._canvasGroup.interactable = not block
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	settimer(1, function()
		self:_setNewRead()
	end, self, false)
end

function M:getInfoStr(pastId, isLock)
	if not self._pastInfoContent then
		local heroData = self:getCurHeroData()
		local heroId = heroData:getId()
		local characterInfoCo = heroData:getCharacterInfoCo()
		local organizationCO = heroData:getOrganizationCO()
		local weight = string.format("%skg", CharacterInformationModel.instance:getHeroWeight(heroId))
		local birthdayStr = characterInfoCo.birthday or ""

		if string.match(birthdayStr, "#") then
			local arrSingleStep = string.split(birthdayStr, "#")

			birthdayStr = string.format(lang("tip_month_day"), arrSingleStep[1], arrSingleStep[2])
		end

		local titleColor = "<color=#FFFFFF>%s<space=-0.4em></color> "

		self._pastInfoContent = {
			[infoType.OrganName] = {
				normal = organizationCO and organizationCO.name or ""
			},
			[infoType.Height] = {
				normal = characterInfoCo and characterInfoCo.hight .. "cm" or ""
			},
			[infoType.Weight] = {
				normal = weight
			},
			[infoType.Birth] = {
				normal = birthdayStr
			},
			[infoType.Ability] = {
				normal = characterInfoCo and characterInfoCo.ability or ""
			},
			[infoType.Area] = {
				normal = characterInfoCo and characterInfoCo.state or ""
			},
			[infoType.BaseInfo] = {
				normal = characterInfoCo and string.format("%s%s", string.format(titleColor, lang("tip_character_baseInfo")), characterInfoCo.baseInfo) or ""
			}
		}

		for _, val in pairs(self._pastInfoContent) do
			val.normal = StringUtil.replaceTMPBlackBlock(val.normal, "#C5C5C5")
		end

		for i = infoType.OrganName, infoType.BaseInfo do
			local normalStr = self._pastInfoContent[i].normal
			local lockStr = string.nilorempty(normalStr) and "XXX" or normalStr

			lockStr = StringUtil.randomReplaceTMPToBlackBlock(lockStr, "#C5C5C5")
			self._pastInfoContent[i].lock = lockStr
		end

		for i = infoType.SpFile1, infoType.SpFile3 do
			local key = string.format("spfile%s", i - 100)
			local show = false

			if characterInfoCo and characterInfoCo[key] then
				show = true
			end

			if show then
				self._pastInfoContent[i] = {
					titleLock = StringUtil.replaceTMPBlackBlock(characterInfoCo[key][1].title, "#FFFFFF"),
					contentLock = StringUtil.replaceTMPBlackBlock(characterInfoCo[key][1].content, "#C5C5C5"),
					titleNormal = string.format(titleColor, characterInfoCo[key][2].title),
					contentNormal = characterInfoCo[key][2].content
				}
			end
		end
	end

	local data = self._pastInfoContent[pastId]

	if data then
		if isLock then
			if pastId >= infoType.SpFile1 then
				return data.titleLock .. data.contentLock
			else
				return data.lock
			end
		elseif pastId >= infoType.SpFile1 then
			return data.titleNormal .. data.contentNormal
		else
			return data.normal
		end
	end

	return nil
end

function M:refreshView()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local characterCo = heroData:getCharacterCo()

	self._newIds = CharacterInformationModel.instance:getNewPastInfoLst(heroId, false)

	if #self._newIds > 0 then
		if Astral.OSDef.isEditor then
			printWarn("有new")
			TableUtil.dump(self._newIds)
		end

		self:_blockKey(true)
	end

	if characterCo then
		IconLoader.setSprite(self._imgCarrer, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[characterCo.camp])
	end

	self._txtGetTime.text = self:_gainTimeToStr(heroData:getGainHeroTime())
	self._txtActionTime.text = heroData:getPveWinTimes()

	for keyStr, valInt in pairs(infoType) do
		if self._txtInfo[valInt] then
			local unLock = CharacterInformationModel.instance:getUnlockPastInfo(heroId, valInt)
			local isNew = CharacterInformationModel.instance:getIsNewPastInfo(heroId, valInt)

			self._txtInfo[valInt].text = self:getInfoStr(valInt, not unLock or isNew)

			if self._txtInfo[valInt].transform.childCount > 0 then
				local _cg = goutil.addComponentOnce(self._txtInfo[valInt].transform:GetChild(0).gameObject, ComponentType.CanvasGroup)

				_cg.alpha = 1
			end
		end
	end

	for pastId, comps in pairs(self._txtSpFileLst) do
		local unLock = CharacterInformationModel.instance:getUnlockPastInfo(heroId, pastId)
		local isNew = CharacterInformationModel.instance:getIsNewPastInfo(heroId, pastId)
		local content = self:getInfoStr(pastId, not unLock or isNew)

		goutil.setActive(comps.go, content)

		if content then
			comps.txt.text = content

			if comps.txt.transform.childCount > 0 then
				for i = 0, comps.txt.transform.childCount - 1 do
					local _cg = goutil.addComponentOnce(comps.txt.transform:GetChild(i).gameObject, ComponentType.CanvasGroup)

					_cg.alpha = 1
				end
			end
		end
	end
end

function M:_gainTimeToStr(itemDataGainTimeStamp)
	local ts = math.floor(itemDataGainTimeStamp / 1000)
	local str = ServerTime.formatTimeServerLook(ts, "%Y-%m-%d %H:%M:%S")

	return str
end

function M:_setNewRead()
	if #self._newIds > 0 then
		self._cacheTweenLst = {}

		for _, tweener in ipairs(self._cacheTweenLst or {}) do
			if tweener then
				tweener:Kill(false)
			end
		end

		for _, _id in ipairs(self._newIds) do
			if _id >= infoType.SpFile1 then
				local comps = self._txtSpFileLst[_id]
				local content = self:getInfoStr(_id, false)

				self:_blackBlockFadeAni(comps.txt, content)
			else
				local txt = self._txtInfo[_id]

				self:_blackBlockFadeAni(txt, self:getInfoStr(_id, false))
			end
		end

		settimer(0.4, function()
			self:_blockKey(false)
		end, self, false)
		CharacterInformationModel.instance:setReadPastInfoIds(self._heroId, self._newIds)
		CharacterInformationController.instance:checkRedPoint(self._heroId)
		self:_showRedPoint()
	end
end

function M:_blackBlockFadeAni(txt, finalStr)
	if not txt then
		return
	end

	if txt.transform.childCount > 0 then
		for i = 0, txt.transform.childCount - 1 do
			local go = txt.transform:GetChild(i).gameObject

			if string.match(go.name, "TMP") then
				local _cg = goutil.addComponentOnce(txt.transform:GetChild(i).gameObject, ComponentType.CanvasGroup)

				if _cg then
					local tween = _cg:DOFade(0, 0.2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
						txt.text = finalStr

						_cg:DOFade(1, 0.2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
					end, self)

					table.insert(self._cacheTweenLst, tween)
				end
			end
		end
	else
		txt.text = finalStr
	end
end

return M
