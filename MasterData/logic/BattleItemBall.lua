-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/items/BattleItemBall.lua

module("logic.extensions.battle.model.items.BattleItemBall", package.seeall)

local BattleItemBall = class("BattleItemBall", BattleItemBase)

function BattleItemBall:ctor(itemCo, itemNum)
	BattleItemBall.super.ctor(self, itemCo, itemNum)
	self:_buildEffects()
end

function BattleItemBall:selectTargetEff()
	return self._selectTargetEff
end

function BattleItemBall:watingRespondEff()
	return self._watingRespondEff
end

function BattleItemBall:displaySuccessEff()
	return self._displaySuccessEff
end

function BattleItemBall:fullScreenSuccessEff()
	return self._fullScreenSuccessEff
end

function BattleItemBall:displayFailedEff()
	return self._displayFailedEff
end

function BattleItemBall:fullScreenFailedEff()
	return self._fullScreenFailedEff
end

function BattleItemBall:getItemModel()
	return "effect/prefabs/ui/fx_ui_jinglingbuzhuo/jinglingqiu/" .. self._itemCo.model .. ".prefab"
end

function BattleItemBall:_buildEffects()
	self._selectTargetEff = {
		path = "effect/prefabs/ui/fx_ui_buzhuo/fx_ui_kebuzhuo.prefab",
		hagPoint = UnitConst.spineCenterPointPath
	}
	self._watingRespondEff = {
		path = "effect/prefabs/ui/fx_ui_buzhuo/fx_ui_bejin.prefab",
		hagPoint = UnitConst.spineFootPointPath,
		layer = SceneLayer.SkillAnimation_Value
	}
	self._displaySuccessEff = {
		duration = 2,
		path = "effect/prefabs/ui/fx_ui_buzhuo/win/fx_ui_win.prefab",
		hagPoint = UnitConst.effectPointPath,
		layer = SceneLayer.SkillAnimation_Value
	}
	self._fullScreenSuccessEff = {
		duration = 1.7,
		path = "fx_ui_buzhuo/win/fx_ui_win_zi.prefab"
	}
	self._displayFailedEff = {
		duration = 1.5,
		path = "effect/prefabs/ui/fx_ui_buzhuo/lose/fx_ui_lose.prefab",
		hagPoint = UnitConst.effectPointPath,
		layer = SceneLayer.SkillAnimation_Value
	}
	self._fullScreenFailedEff = {
		posX = 0,
		isHit = true,
		posY = 5,
		duration = 1.7,
		posZ = 0,
		path = "effect/prefabs/ui/fx_ui_buzhuo/lose/fx_ui_lose_zi.prefab",
		layer = SceneLayer.SkillAnimation_Value
	}
end

return BattleItemBall
