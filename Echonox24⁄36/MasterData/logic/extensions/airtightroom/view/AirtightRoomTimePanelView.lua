-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimePanelView.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimePanelView", package.seeall)

local M = class("AirtightRoomTimePanelView", ViewComponent)

function M:ctor(defaultHide)
	self._defaultHide = defaultHide
	self._btnGoSecretVisible = false
	self._btnGoInstanceVisible = false
end

function M:buildUI()
	return
end

function M:destroyUI()
	self._viewTimePanel = nil
end

function M:bindEvents()
	self:registerLocalNotify(EventType.SHOW_LOCAL_ARITIGHT_PANEL, self._handleShowLocalAritightPanel, self)
end

function M:unbindEvents()
	self:unregisterLocalNotify(EventType.SHOW_LOCAL_ARITIGHT_PANEL, self._handleShowLocalAritightPanel, self)
end

function M:onEnter()
	self:setEvent(true)
	self:refreshView()
end

function M:onExit()
	self:setEvent(false)

	if self._viewTimePanel then
		self._viewTimePanel:onExit()
	end

	self._btnGoSecretCallback = nil
	self._btnGoSecretTarget = nil
	self._btnGoInstanceCallback = nil
	self._btnGoInstanceTarget = nil
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:setBtnGoSecretCallback(callback, target)
	self._btnGoSecretCallback = callback
	self._btnGoSecretTarget = target
end

function M:setBtnGoInstanceCallback(callback, target)
	self._btnGoInstanceCallback = callback
	self._btnGoInstanceTarget = target
end

function M:_getResInst()
	local inst = self:getResInstance(ResName.Common_Airtight_TopPanel)

	if not inst then
		printError(string.format("界面[%s] 没有depend资源Common_Airtight_TopPanel,无法生成密室时间界面", self._viewPresentor:getViewName()))
	end

	return inst
end

function M:_handleShowLocalAritightPanel(e, show)
	if self._viewTimePanel then
		self._viewTimePanel:setActive(show)

		if show then
			self._viewTimePanel:onEnter()
		else
			self._viewTimePanel:onExit()
		end
	end
end

function M:refreshView()
	local panelGo

	if not self._viewTimePanel then
		panelGo = self:_getResInst()

		if panelGo then
			local parent = self.mainGO

			goutil.addChildToParent(panelGo, parent)

			self._viewTimePanel = Astral.SimpleLuaComponentContainer.Add(panelGo, AirtightRoomTimePanel)
		end
	end

	if self._viewTimePanel then
		self._viewTimePanel:setHandler(self)

		local show = not self._defaultHide

		self._viewTimePanel:setActive(show)

		if show then
			self._viewTimePanel:onEnter()
		else
			self._viewTimePanel:onExit()
		end

		self:_refreshBtn()
	end
end

function M:clickBtnGoSecret()
	if self._btnGoSecretCallback then
		self._btnGoSecretCallback(self._btnGoSecretTarget)
	end
end

function M:clickBtnGoInstance()
	if self._btnGoInstanceCallback then
		self._btnGoInstanceCallback(self._btnGoInstanceTarget)
	end
end

function M:setBtnGoSecretVisible(visible)
	self._btnGoSecretVisible = visible

	self:_refreshBtn()
end

function M:setBtnGoInstanceVisible(visible)
	self._btnGoInstanceVisible = visible

	self:_refreshBtn()
end

function M:_refreshBtn()
	if self._viewTimePanel then
		self._viewTimePanel:setBtnGoSecretVisible(self._btnGoSecretVisible)
		self._viewTimePanel:setBtnGoInstanceVisible(self._btnGoInstanceVisible)
	end
end

return M
