-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/dialog/BaseDialog.lua

module("logic.common.viewlib.dialog.BaseDialog", package.seeall)

local M = class("BaseDialog", AbstractGlobalReusable)

M.url = false
M.viewRootType = ViewRootType.TopMost

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))

	local _trClose = goutil.findChild(self.mainGO, "small_tips_common_bg/btnClose")

	if _trClose then
		goutil.setActive(_trClose.gameObject, true)

		self._btnCloseOutSide = UIComponentType.ButtonAdapter(_trClose)

		self._btnCloseOutSide:AddClickListener(self.onClickOutSideClose, self)
	end

	self._toggleTodayTipGo = goutil.findChild(self.mainGO, "allContent/btnAgree")

	if not goutil.isNil(self._toggleTodayTipGo) then
		self._toggleTodayTip = goutil.addComponentOnce(self._toggleTodayTipGo, UIComponentType.SpaceXToggle)
	end

	if self._toggleTodayTip and not goutil.isNil(self._toggleTodayTip) then
		self._toggleTodayTip:AddListener(self._onTodayWarnToggleChange, self)
	end
end

function M:destroyUI()
	self._guiAnimation:RemoveListener()
	self._guiAnimation:StopTimelineAni()

	self._guiAnimation = nil

	if self._btnCloseOutSide then
		self._btnCloseOutSide:RemoveClickListener()
	end

	if self._toggleTodayTip then
		self._toggleTodayTip:RemoveListener()
	end

	self._btnCloseOutSide = nil
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.ALL_DIALOG_FORCE_CLOSE, self.forceClose, self)

	if self._blurBgView then
		self._blurBgView:onEnter()
	end

	if self._viewData then
		goutil.setActive(self._toggleTodayTipGo, true)

		self._toggleTodayTip.IsOn = self._viewData.toggleState
	else
		goutil.setActive(self._toggleTodayTipGo, false)
	end

	self:_playGuiAni(true)
end

function M:onExit()
	self:setNeedBlockKeyWhileAni(false)
	GlobalDispatcher:removeEventListener(EventType.ALL_DIALOG_FORCE_CLOSE, self.forceClose, self)

	if self._blurBgView then
		self._blurBgView:onExit()
		self._blurBgView:onExitFinished()
	end

	self._todayWarnHandler:clear()
end

function M:ctor()
	self.mainGO = false
	self._todayWarnHandler = Handler.New()
end

function M:reset()
	if self.mainGO then
		self:onExit()

		self.viewRootType = BaseDialog.viewRootType

		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:SetAniTime(0)
		self._guiAnimation:ClearAllBinding()
		goutil.addChildToParent(self.mainGO, Dialog.dialogRoot)
	else
		GameObjectCache.instance:cancelLoadGameObject(self.url, self._onLoadGameObject, self)
	end
end

function M:destroy()
	if self.mainGO then
		self:onExit()
		self:destroyUI()
		GameObjectCache.instance:releaseGameObject(self.url, self.mainGO)

		self.mainGO = false
	else
		GameObjectCache.instance:cancelLoadGameObject(self.url, self._onLoadGameObject, self)
	end
end

function M:show()
	if self.mainGO then
		self:_activeView()
	else
		GameObjectCache.instance:loadGameObject(self.url, self._onLoadGameObject, self)
	end
end

function M:close()
	if self.mainGO and self.mainGO.activeSelf then
		self:_playGuiAni(false)
	else
		self:returnSelf()
	end
end

function M:forceClose()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:RemoveListener()

	self._playingAniName = nil

	self:returnSelf()
end

function M:onClickOutSideClose()
	printWarn("子类自行复写")
end

function M:setContentAlignment(alignment)
	printWarn("子类自行复写")
end

function M:setViewRootType(viewRootType)
	self.viewRootType = viewRootType

	if self.mainGO then
		self:_changeViewRoot()
	end
end

function M:setNeedBlockKeyWhileAni(block)
	self._needBlockKeyWhileAni = block

	return self
end

function M:_onLoadGameObject(go)
	self.mainGO = go

	self:buildUI()
	self:_tryGetBlur()
	self:_activeView()
end

function M:_activeView()
	self:_changeViewRoot()
	self:onEnter()
end

function M:_changeViewRoot()
	local root = ViewMgr.instance:getRoot(self.viewRootType)

	goutil.addChildToParent(self.mainGO, root)
	self:onViewRootChanged()
end

function M:onViewRootChanged()
	return
end

function M:_tryGetBlur()
	local blurPath = "common_blur_rt"

	if not goutil.findChild(self.mainGO, blurPath) then
		blurPath = "content/common_blur_rt"
	end

	if not goutil.findChild(self.mainGO, blurPath) then
		blurPath = nil
	end

	if blurPath then
		self._blurBgView = BlurBgView.New(blurPath)
		self._blurBgView.mainGO = self.mainGO

		self._blurBgView:buildUI()
		self._blurBgView:bindEvents()
	end
end

function M:_playGuiAni(open)
	local name = open and "open" or "close"

	if name == self._playingAniName then
		return
	end

	self._playingAniName = name

	self._guiAnimation:RemoveListener()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:SetAniTime(0)
	removetimer(self._releaseBlockClick, self)
	self:_blockKey(true)

	if open then
		settimer(0.36, self._releaseBlockClick, self, false)
	else
		self._guiAnimation:AddListener(self._handleViewAniDoneEvent, self)
	end

	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:PlayAniByName(self._playingAniName)
end

function M:_handleViewAniDoneEvent(tagName, reason)
	if tagName == "close" then
		self._guiAnimation:RemoveListener()
		self:returnSelf()
		self:_releaseBlockClick()
	end
end

function M:_blockKey(block)
	if not self._needBlockKeyWhileAni then
		block = false
	end

	self._canvasGroup.interactable = not block
end

function M:_releaseBlockClick()
	self:_blockKey(false)
	removetimer(self._releaseBlockClick, self)
end

function M:setToggleChangeCallback(callback, callbackSelf)
	self._todayWarnHandler:setListener(callback, callbackSelf)
end

function M:_onTodayWarnToggleChange(_, isOn)
	self._todayWarnHandler:call(isOn)
end

function M:setTodayWarn(luaTable)
	self._viewData = luaTable

	if luaTable then
		self:setToggleChangeCallback(luaTable.togChangeCallBack, luaTable.togChangeCallBackHandle)
	end

	return self
end

function M:setBtnVisiableInfo(btnVisiableInfo)
	self._btnVisiableInfo = btnVisiableInfo

	return self
end

return M
