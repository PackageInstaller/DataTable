-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/events/BattleEvtUseSkillItem.lua

module("logic.extensions.battle.model.events.BattleEvtUseSkillItem", package.seeall)

local BattleEvtUseSkillItem = class("BattleEvtUseSkillItem", BattleEvtCharactorAttack)

function BattleEvtUseSkillItem:ctor()
	self.oneRoundUserActionResult = nil
end

function BattleEvtUseSkillItem:handleEvt()
	if self.isPause then
		return
	end

	self.isToggled = true
	self._isOutFinished = nil
	self._isPlayingSkill = nil

	self:_toOneRoundCharactorResult()
	BattleItemsModel.instance:updateBattleItemEnergy(self.oneRoundUserActionResult.curBtlItemEnergy)
	BattleItemsModel.instance:updateItem(self.oneRoundUserActionResult.itemView)

	self.battleFlow = self._unit.battleFlow
	self._unit.battleFlow.attackEvt = self

	self._unit.attrs:setAnimation(true)

	local skillPath = GameUrl.getSkillAnimTakePath(BattleAnimationPlayer.skillItemIn)

	self._skillAnimPlayer = BattleAnimationPlayer.New(self._unit)

	self._skillAnimPlayer:play(skillPath, nil, self._onPlaySkillInEvent, self)
end

function BattleEvtUseSkillItem:_onPlaySkillInEvent(evt)
	if evt == "stop" or evt == "break" then
		self._isPlayingSkill = true

		self._unit.attrs:setAnimation(false)
		self:_startSkill()
	end
end

function BattleEvtUseSkillItem:update()
	if self._isPlayingSkill then
		if not BattleEvtUseSkillItem.super.isDone(self) then
			return
		end

		self._isPlayingSkill = nil

		self._unit.attrs:setAnimation(true)

		local skillPath = GameUrl.getSkillAnimTakePath(BattleAnimationPlayer.skillItemOut)

		self._skillAnimPlayer = BattleAnimationPlayer.New(self._unit)

		self._skillAnimPlayer:play(skillPath, nil, self._onPlaySkillOutEvent, self)
	end
end

function BattleEvtUseSkillItem:_onPlaySkillOutEvent(evt)
	if evt == "stop" or evt == "break" then
		self._unit:setVisible(false)
		self._unit.attrs:setAnimation(false)

		local x, y, z = self._unit.attrs:getBirthPoint()

		self._unit.transform:setPos(x, y, z)

		self._isOutFinished = true
	end
end

function BattleEvtUseSkillItem:clear()
	BattleEvtUseSkillItem.super.clear(self)

	self.oneRoundUserActionResult = nil
	self._isOutFinished = nil
	self._isPlayingSkill = nil
	self._unit = nil
end

function BattleEvtUseSkillItem:isDone()
	return self._isOutFinished
end

function BattleEvtUseSkillItem:_toOneRoundCharactorResult()
	if self.oneRoundCharacterResult then
		return
	end

	local itemId = self.oneRoundUserActionResult.itemView.itemId
	local teamId = self.oneRoundUserActionResult.operator.targetTeamId
	local item = BattleItemsModel.instance:getBattleItemById(itemId)
	local petId = item:getPetId()
	local skillId = item:getSkillId()
	local battleScene = SceneMgr.instance:getCurScene()

	self._unit = battleScene.unitFactory:getUnit(teamId, petId)

	self._unit:setVisible(true)

	local oneRoundCharacterResult = {}

	oneRoundCharacterResult.caster = {}
	oneRoundCharacterResult.caster.targetTeamId = teamId
	oneRoundCharacterResult.caster.targetPlayerId = 0
	oneRoundCharacterResult.caster.targetCharacterId = petId
	oneRoundCharacterResult.curRound = BattleModel.instance.currRoundNum
	oneRoundCharacterResult.skillId = skillId
	oneRoundCharacterResult.skillExecuteState = GameEnum.SkillExecuteState.CanExecute
	oneRoundCharacterResult.targetPlayerResults = self.oneRoundUserActionResult.targetPlayerResults
	oneRoundCharacterResult.targetCharacterResults = self.oneRoundUserActionResult.targetCharacterResults
	self.oneRoundCharacterResult = oneRoundCharacterResult
end

return BattleEvtUseSkillItem
