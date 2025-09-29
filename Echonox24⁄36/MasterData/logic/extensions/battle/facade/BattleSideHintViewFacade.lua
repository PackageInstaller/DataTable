-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleSideHintViewFacade.lua

module("logic.extensions.battle.facade.BattleSideHintViewFacade", package.seeall)

local BattleSideHintViewFacade = class("BattleSideHintViewFacade", BaseFacade)

function BattleSideHintViewFacade:ctor()
	self._sideHintView = false
end

function BattleSideHintViewFacade:registerView(view)
	self._sideHintView = view
end

function BattleSideHintViewFacade:unregisterView()
	self._sideHintView = false
end

function BattleSideHintViewFacade:showHint(dungeonStarCode)
	if not self:checkView() then
		return
	end

	return self._sideHintView:showHint(dungeonStarCode)
end

function BattleSideHintViewFacade:checkView()
	if not self._sideHintView then
		if enableErrorLog then
			printError("BattleSideHintViewFacade::need to register view first!")
		end

		return false
	end

	return true
end

function BattleSideHintViewFacade:registerTagView(view)
	self._tagSideHintView = view
end

function BattleSideHintViewFacade:unregisterTagView()
	self._tagSideHintView = false
end

function BattleSideHintViewFacade:showTagHint(tagId, continuousIndex)
	if not self._tagSideHintView then
		return
	end

	return self._tagSideHintView:showHint(tagId, continuousIndex)
end

function BattleSideHintViewFacade:hideTagHint()
	if not self._tagSideHintView then
		return
	end

	return self._tagSideHintView:hideTagHint()
end

BattleSideHintViewFacade.instance = BattleSideHintViewFacade.New()

return BattleSideHintViewFacade
