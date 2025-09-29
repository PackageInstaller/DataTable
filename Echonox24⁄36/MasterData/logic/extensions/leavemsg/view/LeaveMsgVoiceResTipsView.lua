-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgVoiceResTipsView.lua

module("logic.extensions.leavemsg.view.LeaveMsgVoiceResTipsView", package.seeall)

local M = class("LeaveMsgVoiceResTipsView", ViewComponent)

function M:buildUI()
	self._btnCloseOutSide = self:getBtn("0&universal_second_tips_common_bg_-1467035629")
	self._btnClose = self:getBtn("0&universal_second_tips_common_bg_1201003252")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("1&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("2&btn_right_1251431307"), CommButton)
	self._txtPreview = self:getUIComponent("leave_message_voice_tips_-1618450266", UIComponentType.TextMeshProUGUI)
	self._scroll = self:getUIComponent("leave_message_voice_tips_1751976054", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	for _, value in pairs(self._itemData or {}) do
		value.destroyUI()
	end

	self._itemData = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnCloseOutSide:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnCloseOutSide:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:setSelectIndex(1)
	self:refreshView(true)
	self:refreshPreView()
end

function M:onExit()
	self:setEvent(false)
	CriwareAudioFacade.instance:stopVoice()
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickConfirm()
	local index = self:getSelectIndex()
	local audioId = self._moLst[index].audioId
	local info = self:getFirstParam()
	local heroId = info.context:getVoiceHero()

	heroId = heroId < 2000000 and heroId + 2000000 or heroId

	local checkRes = true
	local isUnlock = CharacterInformationModel.instance:getUnlockVoice(heroId, audioId, checkRes)

	if not isUnlock then
		FloatWordMgr.instance:show("尚未解锁")

		return
	end

	local id = self:_transAudioId2MsgVoiceId(audioId)

	info.context:setVoice(id)
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE, 1, LeaveMsgEnum.MsgPartType.VoiceHeroRes, id)
	info.context:dispatchCurPreview()
	self:close()
end

function M:getSelectIndex()
	return self._selectIndex
end

function M:setSelectIndex(index, refreshSelect)
	self._selectIndex = index

	if refreshSelect then
		for _, cell in pairs(self._itemData or {}) do
			cell.updateSelect()
		end

		self:refreshPreView()
	end
end

function M:_transAudioId2MsgVoiceId(cfgAudioId)
	local info = self:getFirstParam()
	local heroId = info.context:getVoiceHero()

	return heroId % 1000 * 1000 + cfgAudioId
end

function M:refreshPreView()
	local info = self:getFirstParam()
	local context = info.context
	local index = self:getSelectIndex()
	local previewStr

	if index and self._moLst[index] then
		local isUnLock = self._voiceUnlockLst[self._moLst[index].audioId]

		previewStr = isUnLock and self._moLst[index].qipaoContent or ""

		if not string.nilorempty(previewStr) then
			previewStr = StringUtil.replaceTMPBlackBlock(previewStr)
		end
	end

	self._txtPreview.text = previewStr
end

function M:getIsVoiceResExist(heroId, audioId)
	return CharacterInformationModel.instance:getIsVoiceResExist(heroId, audioId)
end

function M:refreshView(resetPos)
	local info = self:getFirstParam()
	local heroId = info.context:getVoiceHero()

	heroId = heroId < 2000000 and heroId + 2000000 or heroId

	local cgfList = CharacterAudioConfig.instance:getCharacterAudiosById(heroId) or {}

	self._voiceUnlockLst = {}
	self._voiceNoResMap = {}
	self._moLst = {}

	for _, _cfg in pairs(cgfList) do
		local isUnlock = CharacterInformationModel.instance:getUnlockVoice(heroId, _cfg.audioId, false)
		local resExist = self:getIsVoiceResExist(heroId, _cfg.audioId)

		if not resExist then
			isUnlock = false
			self._voiceNoResMap[_cfg.audioId] = 1
		end

		self._voiceUnlockLst[_cfg.audioId] = isUnlock

		table.insert(self._moLst, _cfg)
	end

	table.sort(self._moLst, function(a, b)
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

	local len = self._moLst and #self._moLst or 0

	if len > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local prefabName = "voiceItem"
	local item = self._loopList:NewListViewItem(prefabName)

	self:_updateCell(item.gameObject, curIndex)

	return item
end

function M:_updateCell(go, index)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.Text),
			goImgVoice = goutil.findChild(go, "imgVoice").gameObject,
			goLock = goutil.findChild(go, "imgLock").gameObject,
			goSelect = goutil.findChild(go, "select").gameObject,
			btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.updateSelect()
			goutil.setActive(theItem.goSelect, theItem.getIndex() == self:getSelectIndex())
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellClick(theItem.getIndex())
		end, self)

		function theItem.destroyUI()
			theItem.btnClick:RemoveClickListener()
		end

		self._itemData[key] = theItem
	end

	theItem.index = index
	theItem.txtContent.text = self._moLst[index].audioName

	local isUnLock = self._voiceUnlockLst[self._moLst[index].audioId]

	goutil.setActive(theItem.goLock, not isUnLock)
	goutil.setActive(theItem.goImgVoice, isUnLock)
	theItem.updateSelect()
end

function M:_onCellClick(index)
	self:setSelectIndex(index, true)
	self:_playVoice(index)
end

function M:_playVoice(index)
	local cfg = self._moLst[index]
	local isUnLock = self._voiceUnlockLst[cfg.audioId]

	if not isUnLock then
		CriwareAudioFacade.instance:stopVoice()

		return
	end

	local info = self:getFirstParam()
	local heroId = info.context:getVoiceHero()

	heroId = heroId < 2000000 and heroId + 2000000 or heroId

	local VoiceEnumRes = CharacterInfoEnum.VoiceRes[cfg.audioId]
	local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, heroId) or cfg.voiceId
	local wwiseCo = CriwareAudioConfig.instance:getCOByName(voiceRes)

	if wwiseCo then
		CriwareAudioFacade.instance:playVoiceByName(voiceRes)
	end
end

return M
