-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/controller/SystemOpenController.lua

module("logic.extensions.systemopen.controller.SystemOpenController", package.seeall)

local M = class("SystemOpenController", BaseController, IMainPopItem)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN_HINT_SHOW, self._handleOnSystemOpenHintShow, self)

	for _, code in ipairs(self._listenCodeLst or {}) do
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, code), self._handleOnSystemOpen, self)
	end

	for _, code in ipairs(self._listenMainViewCodeLst or {}) do
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, code), self._handleOnMainViewSysOpen, self)
	end

	self._listenCodeLst = {}
	self._listenMainViewCodeLst = {}
end

function M:onSystemOpenStateInit()
	local cfgLst = SystemOpenConfig.instance:getSystemOpenHintLst()

	for code, cfg in pairs(cfgLst) do
		if cfg.typ == SystemOpenEnum.ControlType.Auto then
			local isOpen = SystemOpenFacade.instance:isOpen(code)

			if not isOpen then
				table.insert(self._listenCodeLst, code)
				GlobalDispatcher:addEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, cfg.code), self._handleOnSystemOpen, self)
			end
		elseif cfg.typ == SystemOpenEnum.ControlType.Manual and cfg.sysType == SystemOpenEnum.SystemType.Chapter then
			local isOpen = SystemOpenFacade.instance:isOpen(code)

			if not isOpen then
				table.insert(self._listenMainViewCodeLst, code)
				GlobalDispatcher:addEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, cfg.code), self._handleOnMainViewSysOpen, self)
			end
		end
	end

	if #self._listenCodeLst > 0 then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN_HINT_SHOW, self._handleOnSystemOpenHintShow, self)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN_INIT)
end

function M:getCacheWaitCodeLstLength()
	local hintIds = SystemOpenModel.instance:getSystemOpenHintLst()

	return #hintIds
end

function M:_handleOnSystemOpenHintShow(e, showCode)
	GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, showCode), self._handleOnSystemOpen, self)

	if #self._listenCodeLst > 0 then
		local t = {}

		for _, code in ipairs(self._listenCodeLst) do
			if code ~= showCode then
				table.insert(t, code)
			end
		end

		self._listenCodeLst = t
	end
end

function M:_handleOnSystemOpen(e, code)
	if #self._listenCodeLst == 0 then
		return
	end

	printWarn(string.format("<color=#45e6f9>handle system open [%s]</color>", code))
	SystemOpenModel.instance:addSystemOpenHint(code)
	self:_popUpSystemOpenHint()
end

function M:_handleOnMainViewSysOpen(_, code)
	if not table.indexof(self._listenMainViewCodeLst, code) then
		table.insert(self._listenMainViewCodeLst, code)
	end

	SystemOpenModel.instance:addMainViewSysHint(code)
end

function M:_popUpSystemOpenHint()
	local hintIds = SystemOpenModel.instance:getSystemOpenHintLst()

	if #hintIds > 0 then
		local hint = hintIds[1]

		if not ViewMgr.instance:isOpen(ViewName.OpenFunctionsHintTips) then
			ToolTipsMgr.showOpenFunctionsHintTips(hint, true)
		end
	end
end

function M:_onMainViewHintClose()
	self:_tryPopMainViewHint()
end

function M:_tryPopMainViewHint()
	settimer(0, function()
		local codeList = SystemOpenModel.instance:getMainViewSysHints()

		if #codeList == 0 then
			MainPopController.instance:showNext()
		else
			local code = table.remove(codeList, 1)
			local cfg = SystemOpenConfig.instance:getSystemOpenHint(code)

			if cfg.sysType == SystemOpenEnum.SystemType.Chapter then
				ToolTipsMgr.showOpenChapterTips(code, self._onMainViewHintClose, self)
			else
				ToolTipsMgr.showOpenFunctionsHintTips(code, false, self._onMainViewHintClose, self, true)
			end
		end
	end, self, false)
end

function M:getMainPopType()
	return MainPopEnum.Type.SystemOpenPopUps
end

function M:onTriggerMainPop()
	self:_tryPopMainViewHint()
end

function M:hasPopUpData()
	local hints = SystemOpenModel.instance:getMainViewSysHints()
	local len = hints and #hints or 0

	return len > 0
end

M.instance = M.New()

return M
