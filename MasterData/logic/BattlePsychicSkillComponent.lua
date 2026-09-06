-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattlePsychicSkillComponent.lua

module("logic.extensions.battle.view.BattlePsychicSkillComponent", package.seeall)

local BattlePsychicSkillComponent = class("BattlePsychicSkillComponent")

function BattlePsychicSkillComponent:ctor(mainGO, view, teamId)
	self.mainGO = mainGO
	self._view = view
	self._teamId = teamId

	if self.mainGO then
		self._txtValue = goutil.findChildTextComponent(self.mainGO, "txtLevel")
		self._slider = Framework.SliderAdapter.GetFrom(self.mainGO, "slider")
		self._effectGo = goutil.findChild(self.mainGO, "effect")
		self._effectGao = goutil.findChild(self.mainGO, "effectGao")
	end

	self._barValue = 0
	self._barDestValue = 0
end

function BattlePsychicSkillComponent:onEnter()
	if self.mainGO then
		self.mainGO:SetActive(false)
		self:_setProgress(0, true)
	end
end

function BattlePsychicSkillComponent:onExit()
	if self.mainGO then
		self.mainGO:SetActive(false)
	end

	self:_stopProgressEff()
	self:_stopMaxProgressEff()
end

function BattlePsychicSkillComponent:setPsychicInfo(info)
	if not self.mainGO then
		return
	end

	if not info or info.hasTriggerCount >= info.maxTriggerCount then
		self.mainGO:SetActive(false)
		self:_stopProgressEff()

		return
	end

	self.mainGO:SetActive(true)

	self._txtValue.text = tostring(info.curProgress)

	local curProgress = info.curProgress / info.minTriggerProgress

	self:_playProgressEff()
	self:_setProgress(curProgress)
end

function BattlePsychicSkillComponent:updateProgress(deltaTime)
	if self._barValue ~= self._barDestValue then
		local preVal = self._barValue
		local bloodSpd = 0.6

		if self._barValue > self._barDestValue then
			self._barValue = self._barValue - bloodSpd * deltaTime

			if self._barValue < self._barDestValue then
				self._barValue = self._barDestValue
			end
		else
			self._barValue = self._barValue + bloodSpd * deltaTime

			if self._barValue > self._barDestValue then
				self._barValue = self._barDestValue
			end
		end

		self._slider:SetValue(self._barValue)
		self:_playProgressEff()
		self:_updateProgressEff(self._barValue)
		self:_tryPlayMaxProgressEff(preVal, self._barValue)
	end
end

function BattlePsychicSkillComponent:_playProgressEff()
	if self._effProgress then
		return
	end

	self._effProgress = UIEffectManager.instance:playEffect(self._view, "20220318/tonglingshi/fx_ui_tonglingshi_jindutiao.prefab", self._effectGo, 0, 0, true)

	self._effProgress:setParent(self._effectGo.transform)
	self._effProgress:setLocalPos(0, 0, 0)
	self._effProgress:setScale(self._teamId == GameEnum.BattleTeam.Left and 1 or -1)
end

function BattlePsychicSkillComponent:_stopProgressEff()
	if self._effProgress then
		UIEffectManager.instance:stopEffect(self._effProgress)

		self._effProgress = nil
	end
end

function BattlePsychicSkillComponent:_updateProgressEff(curProgress)
	return
end

function BattlePsychicSkillComponent:_setProgress(curProgress, isForce)
	if isForce then
		local preVal = self._barValue

		self._barValue = curProgress
		self._barDestValue = curProgress

		self._slider:SetValue(curProgress)
		self:_playProgressEff()
		self:_updateProgressEff(curProgress)
		self:_tryPlayMaxProgressEff(preVal, curProgress)
	else
		self._barDestValue = curProgress
	end
end

function BattlePsychicSkillComponent:_tryPlayMaxProgressEff(preVal, curProgress)
	if curProgress < 1 then
		self:_stopMaxProgressEff()

		return
	end

	if preVal < 1 and curProgress >= 1 then
		self:_playMaxProgressEff()
	end
end

function BattlePsychicSkillComponent:_playMaxProgressEff()
	if self._effMaxProgress then
		return
	end

	self._effMaxProgress = UIEffectManager.instance:playEffect(self._view, "20220318/tonglingshi/fx_ui_tonglingshi_gaoliang.prefab", self._effectGao, 0, 0, true)

	self._effMaxProgress:setParent(self._effectGao.transform)
	self._effMaxProgress:setLocalPos(0, 0, 0)
	self._effMaxProgress:setScaleXYZ(self._teamId == GameEnum.BattleTeam.Left and 1 or -1, 1, 1)
end

function BattlePsychicSkillComponent:_stopMaxProgressEff()
	if self._effMaxProgress then
		UIEffectManager.instance:stopEffect(self._effMaxProgress)

		self._effMaxProgress = nil
	end
end

return BattlePsychicSkillComponent
