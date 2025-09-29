-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleCampAdjustmentViewFacade.lua

module("logic.extensions.battle.facade.BattleCampAdjustmentViewFacade", package.seeall)

local BattleCampAdjustmentViewFacade = class("BattleCampAdjustmentViewFacade", BaseFacade)

function BattleCampAdjustmentViewFacade:ctor()
	self._mainView = false
	self._heroInfoView = false
end

function BattleCampAdjustmentViewFacade:registerView(view)
	self._isRegistered = true
	self._mainView = view
end

function BattleCampAdjustmentViewFacade:unregisterView()
	self._isRegistered = false
	self._mainView = false
end

function BattleCampAdjustmentViewFacade:registerHeroInfoView(view)
	self._heroInfoView = view
end

function BattleCampAdjustmentViewFacade:unregisterHeroInfoView()
	self._heroInfoView = false
end

function BattleCampAdjustmentViewFacade:setLeftTopVisible(visible)
	if not self:_checkView() then
		return false
	end

	self._mainView:setLeftTopVisible(visible)
end

function BattleCampAdjustmentViewFacade:cancelSelectedCharacter()
	if not self:_checkView() then
		return false
	end

	self._mainView:cancelSelectedCharacter()
	self._heroInfoView:setHeroInfo(false)
end

function BattleCampAdjustmentViewFacade:setHeroInfo(heroId)
	if not self:_checkView() then
		return false
	end

	self._heroInfoView:setHeroInfo(heroId)
end

function BattleCampAdjustmentViewFacade:setOperatorUnit(unit)
	if not self:_checkView() then
		return false
	end

	self._heroInfoView:setOperateUnit(unit)
end

function BattleCampAdjustmentViewFacade:getHeroPhotoPanelGo()
	if not self:_checkView() then
		return false
	end

	return self._heroInfoView:getHeroPhotoPanelGo()
end

function BattleCampAdjustmentViewFacade:_checkView()
	if not self._isRegistered then
		if enableWarnLog then
			printWarn("Need to register view first!")
		end

		return false
	end

	return true
end

BattleCampAdjustmentViewFacade.instance = BattleCampAdjustmentViewFacade.New()

return BattleCampAdjustmentViewFacade
