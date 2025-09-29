-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatTabView.lua

module("logic.extensions.chat.view.ChatTabView", package.seeall)

local M = class("ChatTabView")

M.Status = {
	Off = 2,
	On = 1,
	Disable = 3
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._handler = Handler.New()
	self._status = 0

	self:_buildUI()
	self:_bindEvent()
	self:_updateView()
end

function M:_buildUI()
	self._btnClick = Astral.ButtonAdapter.Get(self._mainGo)
	self._normalGo = goutil.findChild(self._mainGo, "normal")
	self._selectGo = goutil.findChild(self._mainGo, "select")
	self._lockGo = goutil.findChild(self._mainGo, "lock")
end

function M:_destroyUI()
	self._normalGo = nil
	self._selectGo = nil
	self._lockGo = nil
end

function M:OnDestroy()
	self:_unbindEvent()
	self:_destroyUI()
	self._handler:clear()
end

function M:_bindEvent()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvent()
	self._btnClick:RemoveClickListener()
end

function M:AddListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function M:RemoveListener()
	self._handler:clear()
end

function M:setStatus(status)
	if self._status == status then
		return
	end

	self._status = status

	self:_updateView()
end

function M:getStatus()
	return self._status
end

function M:_updateView()
	self._normalGo:SetActive(self._status == M.Status.Off)
	self._selectGo:SetActive(self._status == M.Status.On)
	self._lockGo:SetActive(self._status == M.Status.Disable)
end

function M:_onClickBtnClick()
	self._handler:call(self, self._status == M.Status.On)
end

return M
