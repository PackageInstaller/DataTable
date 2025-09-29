-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgWordTipsView.lua

module("logic.extensions.leavemsg.view.LeaveMsgWordTipsView", package.seeall)

local M = class("LeaveMsgWordTipsView", ViewComponent)

function M:buildUI()
	self._btnCloseOutSide = self:getBtn("0&universal_second_tips_common_bg_-1467035629")
	self._btnClose = self:getBtn("0&universal_second_tips_common_bg_1201003252")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("1&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("2&btn_right_1251431307"), CommButton)
	self._txtPreview = self:getUIComponent("leave_message_words_tips_-926368789", UIComponentType.TextMeshProUGUI)
	self._scrollType = self:getUIComponent("leave_message_words_tips_1059969851", UIComponentType.ScrollRect)
	self._loopListType = LoopListHelper.New(self._scrollType.gameObject)

	self._loopListType:InitListView(0, self._onCellUpdateType, self)

	self._scrollWord = self:getUIComponent("leave_message_words_tips_1428755823", UIComponentType.ScrollRect)
	self._loopListWord = LoopListHelper.New(self._scrollWord.gameObject)

	self._loopListWord:InitListView(0, self._onCellUpdateWord, self)
end

function M:destroyUI()
	for _, value in pairs(self._itemTypeData or {}) do
		value.destroyUI()
	end

	for _, value in pairs(self._itemWordData or {}) do
		value.destroyUI()
	end

	self._itemTypeData = nil
	self._itemWordData = nil

	self._loopListType:Dispose()

	self._loopListType = nil

	self._loopListWord:Dispose()

	self._loopListWord = nil
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
	self:setSelectTypeIndex(1)
	self:_refreshView(true)
	self:_refreshWordScroll(true, true)
	self:refreshPreView()
end

function M:onExit()
	self:setEvent(false)
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
	local id = self:getSelectId()
	local info = self:getFirstParam()

	info.context:setMsgId(info.paragraphIndex, LeaveMsgEnum.MsgPartType.Word, id, 1)
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE, info.paragraphIndex, LeaveMsgEnum.MsgPartType.Word, id, 1)
	info.context:dispatchCurPreview()
	self:close()
end

function M:getSelectId()
	return self._selectId
end

function M:getSelectTypeIndex()
	return self._selectTypeIndex
end

function M:setSelectId(id, refreshSelect)
	self._selectId = id

	if refreshSelect then
		for _, cell in pairs(self._itemWordData or {}) do
			cell.updateSelect()
		end

		self:refreshPreView()
	end
end

function M:setSelectTypeIndex(index, refreshSelect)
	self._selectTypeIndex = index

	if refreshSelect then
		for _, cell in pairs(self._itemTypeData or {}) do
			cell.updateSelect()
		end
	end
end

function M:refreshPreView()
	local info = self:getFirstParam()
	local context = info.context
	local id = self:getSelectId()

	self._txtPreview.text = context:getPreviewMsgTmpRelpace(info.paragraphIndex, LeaveMsgEnum.MsgPartType.Word, id, 1)
end

function M:_refreshView(resetPos)
	self._moTypeLst = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioMessageWordType)

	local len = self._moTypeLst and #self._moTypeLst or 0

	if len > 0 then
		if resetPos then
			self._loopListType:ClearCells()
		end

		self._loopListType:SetListItemCount(len, resetPos)
		self._loopListType:RefreshAllShownItem()
	else
		self._loopListType:ClearCells()
	end
end

function M:_refreshWordScroll(resetPos, select)
	local typeIndex = self:getSelectTypeIndex()
	local wordType = self._moTypeLst[typeIndex].id

	self._moWordLst = AirWorkShopConfig.instance:getMsgWorkLstByTyp(wordType)

	local len = self._moWordLst and #self._moWordLst or 0

	if len > 0 then
		if resetPos then
			self._loopListWord:ClearCells()
		end

		self._loopListWord:SetListItemCount(len, resetPos)
		self._loopListWord:RefreshAllShownItem()
	else
		self._loopListWord:ClearCells()
	end

	if select then
		local id = len > 0 and self._moWordLst[1].id or nil

		self:setSelectId(id, true)
	end
end

function M:_onCellUpdateType(curIndex)
	curIndex = curIndex + 1

	local prefabName = "wordItem"
	local item = self._loopListType:NewListViewItem(prefabName)

	self:_updateCellType(item.gameObject, curIndex)

	return item
end

function M:_onCellUpdateWord(curIndex)
	curIndex = curIndex + 1

	local prefabName = "wordItem"
	local item = self._loopListWord:NewListViewItem(prefabName)

	self:_updateCellWord(item.gameObject, curIndex)

	return item
end

function M:_updateCellType(go, index)
	if not self._itemTypeData then
		self._itemTypeData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemTypeData[key]

	if not theItem then
		theItem = {
			go = go,
			txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI),
			goSelect = goutil.findChild(go, "select").gameObject,
			btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.updateSelect()
			goutil.setActive(theItem.goSelect, theItem.getIndex() == self:getSelectTypeIndex())
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellTypeClick(theItem.getIndex())
		end, self)

		function theItem.destroyUI()
			theItem.btnClick:RemoveClickListener()
		end

		self._itemTypeData[key] = theItem
	end

	theItem.index = index
	theItem.txtContent.text = self._moTypeLst[index].typName

	theItem.updateSelect()
end

function M:_onCellTypeClick(index)
	self:setSelectTypeIndex(index, true)
	self:_refreshWordScroll(true)
end

function M:_updateCellWord(go, index)
	if not self._itemWordData then
		self._itemWordData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemWordData[key]

	if not theItem then
		theItem = {
			go = go,
			txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI),
			goSelect = goutil.findChild(go, "select").gameObject,
			btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.getId()
			return theItem.id
		end

		function theItem.getWordType()
			return theItem.wordType
		end

		function theItem.updateSelect()
			goutil.setActive(theItem.goSelect, theItem.getId() == self:getSelectId())
		end

		theItem.btnClick:AddClickListener(function()
			self:_onCellWordClick(theItem.getId())
		end, self)

		function theItem.destroyUI()
			theItem.btnClick:RemoveClickListener()
		end

		self._itemWordData[key] = theItem
	end

	theItem.index = index
	theItem.id = self._moWordLst[index].id
	theItem.wordType = self._moWordLst[index].type
	theItem.txtContent.text = self._moWordLst[index].content

	theItem.updateSelect()
end

function M:_onCellWordClick(id)
	self:setSelectId(id, true)
end

return M
