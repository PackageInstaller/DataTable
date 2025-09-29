-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleDamageHintFacade.lua

module("logic.extensions.battle.facade.BattleDamageHintFacade", package.seeall)

local BattleDamageHintFacade = class("BattleDamageHintFacade", BaseFacade)

function BattleDamageHintFacade:ctor()
	self._sideHintView = false
end

function BattleDamageHintFacade:registerView(view)
	self._sideHintView = view
end

function BattleDamageHintFacade:unregisterView()
	self._sideHintView = false
end

function BattleDamageHintFacade:showHint(num)
	if not self:checkView() then
		return
	end

	return self._sideHintView:showHint(num)
end

function BattleDamageHintFacade:setVisible(num)
	if not self:checkView() then
		return
	end

	return self._sideHintView:setVisible(num)
end

function BattleDamageHintFacade:checkView()
	if not self._sideHintView then
		return false
	end

	return true
end

BattleDamageHintFacade.instance = BattleDamageHintFacade.New()

return BattleDamageHintFacade
