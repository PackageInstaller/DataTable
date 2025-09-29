-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompPianoTerrainModel.lua

module("logic.battle.unit.comp.BattleUnitCompPianoTerrainModel", package.seeall)

local M = class("BattleUnitCompPianoTerrainModel", UnitComponentBase, IBattleUnitComponent)

function M:onInit()
	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
	self.goEffect_loop = nil
	self.goEffect_appear = nil
end

function M:onEnable()
	return
end

function M:onDestroy()
	M.super.onDestroy(self)
end

function M:clear()
	if self.goEffect_loop then
		goutil.destroy(self.goEffect_loop)
	end

	self.goEffect_loop = nil

	if self.goEffect_appear then
		goutil.destroy(self.goEffect_appear)
	end

	self.goEffect_appear = nil
end

function M:addEffectLoop(go)
	self.goEffect_loop = go

	goutil.addChildToParent(go, self._goAvatar)
end

function M:removeEffectLoop()
	if self.goEffect_loop then
		goutil.destroy(self.goEffect_loop)
	end

	self.goEffect_loop = nil
end

function M:removeEffectAppear()
	if self.goEffect_appear then
		goutil.destroy(self.goEffect_appear)
	end

	self.goEffect_appear = nil
end

function M:addEffectAppear(go)
	self.goEffect_appear = go

	goutil.addChildToParent(go, self._goAvatar)
end

function M:setVisibleEffectLoop(v)
	if not self.goEffect_loop then
		return
	end

	goutil.setActive(self.goEffect_loop, v)
end

function M:setVisibleEffectAppear(v)
	if not self.goEffect_appear then
		return
	end

	goutil.setActive(self.goEffect_appear, v)
end

function M:addDoneCallback_appear(callback)
	if self._animation_appear then
		self._animation_appear:AddListener(callback)
	end
end

return M
