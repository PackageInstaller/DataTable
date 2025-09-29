-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/message/AirWorkShopMsgLogView.lua

module("logic.extensions.airworkshop.view.message.AirWorkShopMsgLogView", package.seeall)

local M = class("AirWorkShopMsgLogView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtId = self:getUIComponent("air_workshop_message_log_view_-1266079795", UIComponentType.Text)
	self._imgLevel = self:getImage("air_workshop_message_log_view_-511611298")
	self._txtContent = self:getUIComponent("air_workshop_message_log_view_-1634334970", UIComponentType.TextMeshProUGUI)
	self._imgEmoji = self:getImage("air_workshop_message_log_view_1250171220")

	local goLeaveMsg = goutil.findChild(self.mainGO, "objRight/message_panel").gameObject

	self._msgView = Astral.SimpleLuaComponentContainer.Add(goLeaveMsg, LeaveMsgPanel)

	self._msgView:setClickSaveFunction(self._onClickSave, self)
	self._msgView:setClickResetFunction(self._onClickReset, self)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)

	local info = self:getFirstParam()

	self._mapId = info.mapId
	self._cover = info.cover

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
	end

	self._txtId.text = string.format("ID:%s", self._mapId)
	self._messageMO = LeaveMsgMO.New()

	self._msgView:setContext(self._messageMO)
	self:_updateSceneImage(self._cover)
	self:refreshView()
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	else
		GlobalDispatcher:removeEventListener(LeaveMsgEventType.ON_EDIT_ALL_PREVIEW, self._handleEditAllPreview, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	end
end

function M:_handleEditAllPreview(e, isAllFinish, previewStr, emoji)
	self._txtContent.text = previewStr

	if emoji and emoji > 0 then
		goutil.setActive(self._imgEmoji.gameObject, true)

		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
	else
		goutil.setActive(self._imgEmoji.gameObject, false)
	end
end

function M:_onClickSave(leaveMsgMO)
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
		FloatWordMgr.instance:show(lang("tip_leave_msg_not_all_finish"))

		return
	end

	self:_onConfirmMsgSave(leaveMsgMO)
end

function M:_onConfirmMsgSave(leaveMsgMO)
	local mapId = self._mapId

	AirWorkShopDefAgent.instance:sendCommentRequest(mapId, leaveMsgMO)
	ViewMgr.instance:close(ViewName.AirWorkShopMessageLogTipsView)
	self:close()
end

function M:_onClickReset()
	self._messageMO:clear()
	self._msgView:setContext(self._messageMO)
	self:refreshView()
end

function M:refreshView()
	self._txtContent.text = self._messageMO:getPreviewMsg()

	local emoji = self._messageMO:getEmoji()

	if emoji and emoji > 0 then
		goutil.setActive(self._imgEmoji.gameObject, true)

		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
	else
		goutil.setActive(self._imgEmoji.gameObject, false)
	end
end

function M:_onSceneImageUpdate(_, cover)
	if self._cover == cover then
		self:_updateSceneImage(cover)
	end
end

function M:_updateSceneImage(cover)
	AirWorkShopUtil.loadSceneImage(self._imgLevel, cover, true)
end

return M
