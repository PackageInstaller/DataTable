-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkShopMessageSetView.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkShopMessageSetView", package.seeall)

local M = class("AirWorkShopMessageSetView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("title_view/layout/btnReturn_1")
	self._btnCondition = self:getBtnByPath("objLeft/messageGo/com_btn_2")
	self._txtCondition = self:getTextByPath("objLeft/messageGo/com_btn_2/Text")
	self._txtCoordinate = self:getTextByPath("objLeft/txtCoordinate")
	self._txtMessage = goutil.findChildComponent(self.mainGO, "objLeft/messageGo/messageContent/txtMessage", typeof(TMPro.TMP_Text))
	self._imgEmoji = goutil.findChildImageComponent(self.mainGO, "objLeft/messageGo/messageContent/imgEmoticon")
	self._buildHeadPanelGo = self:getGoByPath("objLeft/stateBuild")
	self._roleHeadPanelGo = self:getGoByPath("objLeft/stateRole")

	local buildHeadIconGo = self:getGoByPath("objLeft/stateBuild/air_workshop_building_item")
	local roleHeadIconGo = self:getGoByPath("objLeft/stateRole/hero_item")

	self._buildHeadItem = AirBuildingItem.New(buildHeadIconGo)
	self._roleHeadItem = AirHeroItem.New(roleHeadIconGo)
	self._rightMsgPanelGo = self:getGoByPath("objRight/message_panel")
	self._msgView = Astral.SimpleLuaComponentContainer.Add(self._rightMsgPanelGo, LeaveMsgPanel)

	self._msgView:setClickSaveFunction(self._onClickSave, self)
	self._msgView:setClickResetFunction(self._onClickReset, self)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCondition:AddClickListener(self._onClickChangeCondition, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCondition:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_MESSAGE_TRIGGER_UPDATE, self._onTriggerMessageUpdate, self)
		GlobalDispatcher:addEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_MESSAGE_TRIGGER_UPDATE, self._onTriggerMessageUpdate, self)
		GlobalDispatcher:removeEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
	end
end

function M:onEnter()
	self:_setEvents(true)

	self._unitMO = self:getFirstParam()
	self._messageMO = self._unitMO:getMsgMO()

	self:_init()
	self:_updateView()
end

function M:_init()
	self._triggerCondition = false
	self._triggerParam = false

	local leaveMsgMO

	if self._messageMO then
		self._triggerCondition = self._messageMO:getCondition()
		self._triggerParam = self._messageMO:getParams()

		local curMsgMO = self._messageMO:getLeaveMsgMO()

		leaveMsgMO = curMsgMO:deepCopy()
	else
		leaveMsgMO = LeaveMsgMO.New()
	end

	self._msgView:setContext(leaveMsgMO)
end

function M:_updateView()
	self:_updateHeadIcon()
	self:_refreshConditionTxt()
	self:_refreshMessageString()
end

function M:_updateHeadIcon()
	local id = self._unitMO:getId()

	if self._unitMO:getTabType() == AirWorkShopEnum.TabEnum.Hero then
		goutil.setActive(self._buildHeadPanelGo, false)
		goutil.setActive(self._roleHeadPanelGo, true)

		local heroData = HeroDepotModel.instance:getHeroInfoByID(id)

		self._roleHeadItem:setHeroMO(heroData)
	else
		goutil.setActive(self._buildHeadPanelGo, true)
		goutil.setActive(self._roleHeadPanelGo, false)
		self._buildHeadItem:setEnable(false)

		local buildCO = AirWorkShopConfig.instance:getBuildingCO(id)

		self._buildHeadItem:setBuildingCO(buildCO)
	end

	local x, y = self._unitMO:getPosition()

	self._txtCoordinate.text = string.format(lang("tip_airwork_message_position"), x, y)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickChangeCondition()
	local messageType = AirWorkShopEnum.MessageConditionType.Message

	if self._unitMO:getTabType() == AirWorkShopEnum.TabEnum.Hero then
		messageType = AirWorkShopEnum.MessageConditionType.Hero
	end

	ViewMgr.instance:open(ViewName.AirWorkShopDefTriggerConditionSelectView, messageType, self._triggerCondition, self._triggerParam)
end

function M:_onTriggerMessageUpdate(_, condition, param)
	self._triggerCondition = condition
	self._triggerParam = param

	self:_refreshConditionTxt()
end

function M:_refreshConditionTxt()
	local airMsgCO = AirWorkShopConfig.instance:getMessageConditionCO(self._triggerCondition)

	if not self._triggerCondition or self._triggerCondition <= 0 then
		self._txtCondition.text = lang("tip_airwork_trigger_condition_set")

		return
	end

	if airMsgCO.limit then
		self._txtCondition.text = string.format(airMsgCO.descStr, self._triggerParam)
	else
		self._txtCondition.text = airMsgCO.descStr
	end
end

function M:onExit()
	self:_setEvents(false)
end

function M:_onClickSave(leaveMsgMO)
	if not self._triggerCondition or self._triggerCondition <= 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_trigger_condition_set"))

		return
	end

	local emoji = leaveMsgMO:getEmoji()

	if emoji > 0 and not leaveMsgMO:getAllParagraphFinish(false) then
		local content = lang("tip_leave_msg_only_use_emoji")
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			self:_onConfirmMsgSave(leaveMsgMO)
			dialog:forceClose()
		end, self)

		return
	end

	if not leaveMsgMO:getAllParagraphFinish() then
		FloatWordMgr.instance:show(lang("tip_airwork_message_content_set"))

		return
	end

	self:_onConfirmMsgSave(leaveMsgMO)
end

function M:_onConfirmMsgSave(leaveMsgMO)
	if not self._messageMO then
		self._messageMO = AirWorkMessageMO.New()

		self._unitMO:setMsgMO(self._messageMO)
	end

	self._messageMO:setTime(self._triggerCondition)
	self._messageMO:setParams(self._triggerParam)
	self._messageMO:setLeaveMsgMO(leaveMsgMO)

	local entityId = self._unitMO:getEntityId()
	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr(entityId)
	local unit = unitMgr:getUnit(entityId)

	if unit then
		unit.uiProxy:refresh()
	end

	FloatWordMgr.instance:show(lang("tip_airwork_save_success"))
	self:close()
	GlobalDispatcher:dispatchEvent(LeaveMsgEventType.ON_EDIT_MSG_SAVE)
end

function M:_onClickReset()
	local leaveMsgMO

	if self._messageMO then
		leaveMsgMO = self._messageMO:getLeaveMsgMO()

		self._msgView:setContext(leaveMsgMO)

		self._txtMessage.text = self._msgView:getPreviewMsg()
	else
		leaveMsgMO = self._msgView:getContext()

		leaveMsgMO:clear()
		self._msgView:setContext(leaveMsgMO)

		self._txtMessage.text = self._msgView:getPreviewMsg()
	end

	self:_updateEmoji(leaveMsgMO:getEmoji())
end

function M:_handleEditAllPreview(e, isAllFinish, previewStr, emoji)
	self._txtMessage.text = previewStr

	self:_updateEmoji(emoji)
end

function M:_refreshMessageString()
	self._txtMessage.text = self._msgView:getPreviewMsg()

	local mo = self._msgView:getContext()
	local emoji = mo and mo:getEmoji() or false

	self:_updateEmoji(emoji)
end

function M:_updateEmoji(emoji)
	if emoji and emoji > 0 then
		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		if cfg then
			goutil.setActive(self._imgEmoji.gameObject, true)
			IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
		else
			goutil.setActive(self._imgEmoji.gameObject, false)
		end
	else
		goutil.setActive(self._imgEmoji.gameObject, false)
	end
end

function M:destroyUI()
	self._roleHeadItem:destroyUI()
end

return M
