-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/controller/MainUIController.lua

module("logic.extensions.mainui.controller.MainUIController", package.seeall)

local M = class("MainUIController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	self:onReset()
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OEPN_FULL_SCREEN_EVENT, self._dealOpenFullScreenHandler)
	GlobalDispatcher:addEventListener(EventType.REFRESH_CUR_MAIL, self._handleRefreshMail, self)
	GlobalDispatcher:addEventListener(EventType.UPDAET_READ_MAIL, self._handleRefreshMail, self)
	GlobalDispatcher:addEventListener(EventType.TAKE_MAIL_ATTACHMENT, self._handleRefreshMail, self)
	GlobalDispatcher:addEventListener(EventType.TAKE_ALL_MAIL_ATTACHMENT, self._handleRefreshMail, self)
	GlobalDispatcher:addEventListener(EventType.ON_NOTIFY_NEW_MAIL_PUSH, self._handleNotifyNewMailPush, self)

	if Astral.OSDef.isEditor then
		local ignoreView = {
			"login",
			"main_hack",
			"waiting_view",
			"loading",
			"marquee_view"
		}

		self._ignoreMap = TableUtil.arrayToMap(ignoreView)
	end
end

function M:onReset()
	self._notifyMailMap = {}
	self._notifyReadMailMap = {}
end

function M:_dealOpenFullScreenHandler(e, viewName)
	local isNeedShowCamera = not ViewSetting.instance:isOnlyFullScreen(viewName)

	MainCameraMgr.instance:setCameraVisible(isNeedShowCamera)
end

function M:_dealFullScreenTypeErrorOnNextFrame(e, viewName)
	settimer(0.1, function()
		M.instance:_dealFullScreenTypeError(viewName)
	end, M.instance, false)
end

function M:_dealFullScreenTypeError(viewName)
	if M.instance._ignoreMap[viewName] then
		return
	end

	local presenter = ViewMgr.instance._views[viewName]

	if presenter then
		local type = ViewSetting.instance:getViewWindowType(viewName)

		if type ~= WindowType.WindowShowType.FullScreenShowType and type ~= WindowType.WindowShowType.FullScreenHudShowType then
			local go = presenter.mainGO
			local fullScreenObjName = M.instance:_checkChildFullScreen(go.transform)

			if fullScreenObjName then
				FloatWordMgr.instance:show("当前前打开界面实为全屏界面，但设置成了非全屏，请更正，界面名字：" .. viewName .. ",全屏物体：" .. fullScreenObjName)
			end
		end

		return
	end
end

function M:_checkChildFullScreen(transform)
	local count = transform.childCount - 1

	for i = 0, count do
		local name = M.instance:_recursionCheckGoFullScreen(transform:GetChild(i))

		if name then
			return name
		end
	end

	return false
end

function M:_recursionCheckGoFullScreen(transform)
	local go = transform.gameObject
	local name = go.name

	if name ~= "common_blur_rt" then
		local com = go:GetComponent("Image")
		local imageName = false

		if not com then
			com = go:GetComponent("RawImage")
		else
			imageName = com.sprite and com.sprite.name
		end

		if com and not imageName or imageName and imageName ~= "tips_03" then
			local widMax = math.floor(ViewMgr.instance:getUIWidth())
			local heiMax = math.floor(ViewMgr.instance:getUIHeight())
			local goWid = RectTransformUtils.GetWidth(transform)
			local goHei = RectTransformUtils.GetHeight(transform)
			local scaleX, scaleY = RectTransformUtils.GetScale(transform, 0, 0)

			goWid = goWid * scaleX
			goHei = goHei * scaleY

			if widMax <= goWid and heiMax <= goHei then
				return name
			end
		end
	end

	local count = transform.childCount - 1

	for i = 0, count do
		M.instance:_recursionCheckGoFullScreen(transform:GetChild(i))
	end

	return false
end

function M:_handleNotifyNewMailPush(e, ids)
	for _, _mailId in ipairs(ids or {}) do
		self._notifyMailMap[_mailId] = 1
	end

	MainUIModel.instance:setShowMailTips(true)
	GlobalDispatcher:dispatchEvent(EventType.ON_NOTIFY_MAIL_CHANGE)
end

function M:_handleRefreshMail()
	local moList = MailMoList.instance:getCurMailList()
	local exitMailMap = {}

	for _, _mailMo in pairs(moList or {}) do
		if not _mailMo:isExpired() then
			local _id = _mailMo:getId()

			exitMailMap[_id] = 1

			if _mailMo:getIsRead() then
				self._notifyReadMailMap[_id] = 1
				self._notifyMailMap[_id] = nil
			end
		end
	end

	for _id, _ in pairs(self._notifyReadMailMap or {}) do
		if not exitMailMap[_id] then
			self._notifyReadMailMap[_id] = nil
		end
	end

	for _id, _ in pairs(self._notifyMailMap or {}) do
		if not exitMailMap[_id] then
			self._notifyMailMap[_id] = nil
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_NOTIFY_MAIL_CHANGE)
end

function M:getNotifyMailCount()
	return TableUtil.getLen(self._notifyMailMap or {})
end

M.instance = M.New()

return M
