-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgSubjectTipsView.lua

module("logic.extensions.leavemsg.view.LeaveMsgSubjectTipsView", package.seeall)

local M = class("LeaveMsgSubjectTipsView", ViewComponent)

function M:buildUI()
	self._txtTitle = self:getText("0&universal_second_tips_common_bg_-1535781828")
	self._txtTitle.text = lang("tip_leave_msg_title_subject")
	self._btnCloseOutSide = self:getBtn("0&universal_second_tips_common_bg_-1467035629")
	self._btnClose = self:getBtn("0&universal_second_tips_common_bg_1201003252")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("1&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("2&btn_right_1251431307"), CommButton)
	self._txtPreview = self:getUIComponent("leave_message_phrases_tips_-462749583", UIComponentType.TextMeshProUGUI)
	self._scroll = self:getUIComponent("leave_message_phrases_tips_328097953", UIComponentType.ScrollRect)
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
	self:refreshView(true)
	self:refreshPreView()
end

function M:onExit()
	self:setEvent(false)
	self._loopList:ClearCells()
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
	local id = self._moLst[index].id
	local info = self:getFirstParam()

	info.context:setMsgId(info.paragraphIndex, LeaveMsgEnum.MsgPartType.Subject, id)
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE, info.paragraphIndex, LeaveMsgEnum.MsgPartType.Subject, id)
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

function M:refreshPreView()
	local info = self:getFirstParam()
	local context = info.context
	local index = self:getSelectIndex()
	local id = index and self._moLst[index] and self._moLst[index].id or -1

	self._txtPreview.text = context:getPreviewMsgTmpRelpace(info.paragraphIndex, LeaveMsgEnum.MsgPartType.Subject, id)
end

function M:refreshView(resetPos)
	self._moLst = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioMessagePhrase)

	local len = self._moLst and #self._moLst or 0

	if len > 0 then
		local defaultIndex = 1
		local info = self:getFirstParam()
		local msgCO = info.context:getMsgCO(info.paragraphIndex, LeaveMsgEnum.MsgPartType.Subject)

		for _index, value in ipairs(self._moLst) do
			if value.id == msgCO.id then
				defaultIndex = _index
			end
		end

		self:setSelectIndex(defaultIndex)

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

	local prefabName = "wordItem"
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
			txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI),
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

	local co = AirWorkShopConfig.instance:getMsgCO(GameEnum.AirMsgTextEnum.Phrase, self._moLst[index].id)

	theItem.txtContent.text = co.tabContent

	theItem.updateSelect()
end

function M:_onCellClick(index)
	self:setSelectIndex(index, true)
end

return M
