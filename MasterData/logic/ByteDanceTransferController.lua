-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zijiedatatransfer/controller/ByteDanceTransferController.lua

module("logic.extensions.zijiedatatransfer.controller.ByteDanceTransferController", package.seeall)

local ByteDanceTransferController = class("ByteDanceTransferController", BaseController)

ByteDanceTransferController.ON_MAIN_VIEW_RES = "ByteDanceTransferController.ON_MAIN_VIEW_RES"
ByteDanceTransferController.ON_WEB_VIEW_RES = "ByteDanceTransferController.ON_WEB_VIEW_RES"

function ByteDanceTransferController:ctor()
	ByteDanceTransferController.super.ctor(self)
end

function ByteDanceTransferController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(ByteDanceTransferController.ON_WEB_VIEW_RES, self.onOpenWebView, self)
end

function ByteDanceTransferController:onReset()
	self.mainTimeRcd = 0
	self.webTimeRcd = 0
	self.mainMsg = nil
end

function ByteDanceTransferController:tryOpenMainView()
	if ServerTime.now() - self.mainTimeRcd > 5 then
		self.mainTimeRcd = ServerTime.now()

		ByteDanceTransferAgent.instance:sendPM_ByteDanceTransferInfoReq()
		TipsFacade.instance:openCommonTips(lang("数据请求中，请稍等"))
	end
end

function ByteDanceTransferController:getMainMsg()
	return self.mainMsg
end

function ByteDanceTransferController:onSetMainMsg(msg)
	self.mainMsg = msg
end

function ByteDanceTransferController:tryOpenInnerWeb()
	if ServerTime.now() - self.webTimeRcd > 5 then
		self.webTimeRcd = ServerTime.now()

		ByteDanceTransferAgent.instance:sendPM_ByteDanceTransferCreateTokenReq()
		TipsFacade.instance:openCommonTips(lang("数据请求中，请稍等"))
	end
end

function ByteDanceTransferController:clearWebTime()
	self.webTimeRcd = 0

	self:onSetMainMsg(nil)
end

function ByteDanceTransferController:onOpenWebView(msg)
	self.webTimeRcd = 0

	UIStateManager.instance:push(ViewName.ZijiedatawebView, msg)
end

ByteDanceTransferController.instance = ByteDanceTransferController.New()

return ByteDanceTransferController
