-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backdoortool/BackDoorToolView.lua

module("logic.extensions.backdoortool.BackDoorToolView", package.seeall)

local M = class("BackDoorToolView", ViewComponent)

M.cacheKey = "BackDoorTool"

function M:buildUI()
	self._goPassWord = self:getGo("backdoortoolview_2138099473")
	self._goOther = self:getGo("backdoortoolview_-2099621691")
	self._inputPassWord = self:getInput("backdoortoolview_-1309437193")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("6&btn_right_1251431307"), CommButton)
	self._btnClose = self:getBtn("backdoortoolview_-952211709")
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("7&btn_left_-1571983320"), CommButton)
	self._txtDebug = self:getText("backdoortoolview_1204118236")
	self._toggleDebug = self:getUIComponent("backdoortoolview_-953478204", UIComponentType.SpaceXToggle)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._toggleDebug:AddListener(self._onToggleChange, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._toggleDebug:RemoveListener()
end

function M:onEnter()
	goutil.setActive(self._goPassWord, not enableDebug)
	goutil.setActive(self._goOther, enableDebug)
	self._inputPassWord:SetText("")

	self._toggleDebug.IsOn = enableDebug
	self._curStatus = enableDebug

	self:_updateText()
end

function M:_updateText()
	local strTemp = enableDebug and "True" or "False"

	self._txtDebug.text = "当前Deubg状态为：" .. strTemp
end

function M:_onToggleChange(index, isOn)
	if self._curStatus == isOn then
		return
	end

	self._curStatus = isOn

	GameUtils.changeDebugState(isOn)
	self:_updateText()
	GlobalDispatcher:dispatchEvent(EventType.ENABLE_DEBUG_STATUS_CHANGE, isOn)
	GameUtils.setLocalInt(BackDoorToolView.cacheKey, isOn and 1 or 0)

	if isOn then
		self:_openRemoteTool()
	end
end

function M:_onClickConfirm()
	local password = self._inputPassWord:GetText()

	if password == "" then
		FloatWordMgr.instance:show("请输入密码")

		return
	end

	if password ~= "spacex2023" then
		FloatWordMgr.instance:show("密码错误")

		return
	end

	goutil.setActive(self._goPassWord, false)
	goutil.setActive(self._goOther, true)
end

function M:_openRemoteTool()
	local go = goutil.find("AstralUnityStarter")

	if go then
		goutil.addComponentOnce(go, typeof(DebugToolServerComponent))
	end
end

function M:destroyUI()
	return
end

return M
