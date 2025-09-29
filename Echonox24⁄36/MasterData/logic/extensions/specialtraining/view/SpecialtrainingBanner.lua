-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/view/SpecialtrainingBanner.lua

module("logic.extensions.specialtraining.view.SpecialtrainingBanner", package.seeall)

local M = class("SpecialtrainingBanner", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._btnGoTo = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "btnSummoncard"))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnGoTo:AddClickListener(self._onClickGo, self)
end

function M:unbindEvents()
	self._btnGoTo:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:onExitFinished()
	return
end

function M:_onClickGo()
	self:close()

	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Lottery, true) then
		return
	end

	RetrieveController.instance:enterScene()
end

return M
