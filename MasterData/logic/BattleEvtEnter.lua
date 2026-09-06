-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtEnter.lua

module("logic.extensions.battle.model.events.BattleEvtEnter", package.seeall)

local BattleEvtEnter = class("BattleEvtEnter", BattleEvtBase)

function BattleEvtEnter:handleEvt()
	self._isEvtDoing = false

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.unit.modelId) or {}

	if skinCfg and checknumber(skinCfg.enterSkillId) > 0 then
		local skill = SkillBase.New(checknumber(skinCfg.enterSkillId), self.unit)

		skill:setAnimEventHandler(self._handlerEvent, self)
		skill:addListener(self._onSkillEvtHandle, self)

		local list = {}

		table.insert(list, {
			unit = self.unit,
			result = {
				isSkillEffected = true,
				isHit = true,
				targetNum = {}
			}
		})
		skill:setSkillTargets(list)

		if skill:useSkill(GameEnum.SkillExecuteState.CanExecute) then
			self._isEvtDoing = true
			self.isToggled = true
		end

		self._curSkill = skill
	else
		self:_showUnit(true)

		self._isEvtDoing = false
	end
end

function BattleEvtEnter:update(deltaTime)
	if self._curSkill and self._curSkill:isPlaying() then
		self._curSkill:update(deltaTime)
	end
end

function BattleEvtEnter:isDone()
	if not self.isToggled then
		return
	end

	if self._isEvtDoing == false then
		self.unit.isShowedEnterSkill = true
		self._curSkill = nil

		return true
	else
		return false
	end
end

function BattleEvtEnter:_showUnit(isShow)
	if isShow then
		self.unit:setAlpha(1)
		self.unit.unitUI:setVisible(true)
		self.unit.shadow:setActive(true)
		self.unit.buffList:setVisible(true)
	else
		self.unit:setAlpha(0)
		self.unit.unitUI:setVisible(false)
		self.unit.shadow:setActive(false)
		self.unit.buffList:setVisible(false)
	end
end

function BattleEvtEnter:_onSkillEvtHandle(evtName)
	if evtName == "start" then
		self:_showUnit(false)
	end

	if evtName == "stop" then
		self:_showUnit(true)

		self._isEvtDoing = false
	end
end

function BattleEvtEnter:_handlerEvent(evtName, go, param1, param2, param3, param4, param5, param6)
	if evtName == "bullet" then
		self:_onCollision(go, param1, param2)
	elseif evtName == "hurt" then
		self:_onHurt(go, param1, param2, param3, param4, param5, param6)
	else
		return self.unit.skillPlayer._skillPlayer:_defaultHandlerEvent(evtName, go, param1, param2, param3, param4, param5, param6)
	end
end

function BattleEvtEnter:_onCollision(index, cData)
	if self._curSkill then
		self._curSkill:onCollision(index, cData)
		self:_showUnit(true)
	end
end

function BattleEvtEnter:_onHurt(effectName, hagPoint, playHit, damege, sound, index, count)
	if self._curSkill then
		local cData = BattleAnimEvevts.onHurt(effectName, hagPoint, playHit, damege, sound, count)

		self._curSkill:onCollision(index, cData)
		self:_showUnit(true)
	end
end

return BattleEvtEnter
