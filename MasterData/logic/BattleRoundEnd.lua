-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundEnd.lua

module("logic.extensions.battle.model.round.BattleRoundEnd", package.seeall)

local BattleRoundEnd = class("BattleRoundEnd", BattleRoundBase)

function BattleRoundEnd:ctor()
	self.roundType = BattleRoundBase.End
	self.result = nil
end

function BattleRoundEnd:start()
	BattleRoundEnd.super.start(self)

	local scene = SceneMgr.instance:getCurScene()

	scene.resPreLoad:clearAll()
	scene.resQueue:clearAll()
	FmodBanksManager.instance:stopLoadBanks()
	SoloAudioMgr.instance:stopEvt()
	BattleController.instance:onReciveBattleEnd(self.result)
end

function BattleRoundEnd:finish()
	BattleRoundEnd.super.finish(self)
end

function BattleRoundEnd:isDone()
	return true
end

function BattleRoundEnd:onPass()
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
	local units = battleScene.unitFactory:getUnits()

	if units then
		for k, v in pairs(units) do
			for k1, v1 in pairs(v) do
				if v1.attrs:getCurHp() == 0 then
					v1.attrs:setDead(true)
				end
			end
		end
	end

	BattleController.instance:onReciveBattleEnd(self.result)
end

function BattleRoundEnd:onRetreat()
	BattleController.instance:onReciveBattleEnd(self.result)
end

return BattleRoundEnd
