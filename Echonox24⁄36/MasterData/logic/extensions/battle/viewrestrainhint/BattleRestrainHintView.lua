-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewrestrainhint/BattleRestrainHintView.lua

module("logic.extensions.battle.viewrestrainhint.BattleRestrainHintView", package.seeall)

local BattleRestrainHintView = class("BattleRestrainHintView", ViewComponent)

function BattleRestrainHintView:buildUI()
	self._btnConfirm = self:getBtnByPath("allContent/btnConfirm")
	self._btnClose = self:getBtnByPath("small_tips_common_bg/btnClose")
end

function BattleRestrainHintView:destroyUI()
	self._btnConfirm = nil
	self._btnClose = nil
end

function BattleRestrainHintView:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function BattleRestrainHintView:unbindEvents()
	self._btnConfirm:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function BattleRestrainHintView:_onClickClose()
	self:close()
end

function BattleRestrainHintView:onExit()
	return
end

return BattleRestrainHintView
