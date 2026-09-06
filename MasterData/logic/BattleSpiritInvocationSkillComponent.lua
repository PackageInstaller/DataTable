-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleSpiritInvocationSkillComponent.lua

module("logic.extensions.battle.view.BattleSpiritInvocationSkillComponent", package.seeall)

local BattleSpiritInvocationSkillComponent = class("BattleSpiritInvocationSkillComponent")

function BattleSpiritInvocationSkillComponent:ctor(mainGO, view, teamId)
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

function BattleSpiritInvocationSkillComponent:onEnter()
	if self.mainGO then
		self.mainGO:SetActive(false)
		self:_setProgress(0, true)
	end
end

function BattleSpiritInvocationSkillComponent:onExit()
	if self.mainGO then
		self.mainGO:SetActive(false)
	end

	self:_stopMaxProgressEff()
end

function BattleSpiritInvocationSkillComponent:setInfo(info)
	if not self.mainGO then
		return
	end

	if not info or info.spiritInvocationSkillId <= 0 or info.minTriggerProgress <= 0 then
		self.mainGO:SetActive(false)
		self:_stopMaxProgressEff()

		return
	end

	self.mainGO:SetActive(true)

	self._txtValue.text = tostring(info.curProgress)

	local curProgress = info.curProgress / info.minTriggerProgress

	self:_setProgress(curProgress)
end

function BattleSpiritInvocationSkillComponent:updateProgress(deltaTime)
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
		self:_tryPlayMaxProgressEff(preVal, self._barValue)
	end
end

function BattleSpiritInvocationSkillComponent:_playProgressEff()
	if self._effProgress then
		return
	end

	self._effProgress = UIEffectManager.instance:playEffect(self._view, "20220318/tonglingshi/fx_ui_tonglingshi_jindutiao2.prefab", self._effectGo, 0, 0, true)

	self._effProgress:setParent(self._effectGo.transform)
	self._effProgress:setLocalPos(0, 0, 0)
	self._effProgress:setScale(self._teamId == GameEnum.BattleTeam.Left and 1 or -1)
end

function BattleSpiritInvocationSkillComponent:_stopProgressEff()
	if self._effProgress then
		UIEffectManager.instance:stopEffect(self._effProgress)

		self._effProgress = nil
	end
end

function BattleSpiritInvocationSkillComponent:_updateProgressEff(curProgress)
	return
end

function BattleSpiritInvocationSkillComponent:_setProgress(curProgress, isForce)
	if isForce then
		local preVal = self._barValue

		self._barValue = curProgress
		self._barDestValue = curProgress

		self._slider:SetValue(curProgress)
		self:_tryPlayMaxProgressEff(preVal, curProgress)
	else
		self._barDestValue = curProgress
	end
end

function BattleSpiritInvocationSkillComponent:_tryPlayMaxProgressEff(preVal, curProgress)
	if curProgress < 1 then
		self:_stopMaxProgressEff()

		return
	end

	if preVal < 1 and curProgress >= 1 then
		self:_playMaxProgressEff()
	end
end

function BattleSpiritInvocationSkillComponent:_playMaxProgressEff()
	if self._effMaxProgress then
		return
	end

	self._effMaxProgress = UIEffectManager.instance:playEffect(self._view, "20220318/tonglingshi/fx_ui_tonglingshi_gaoliang.prefab", self._effectGao, 0, 0, true)

	self._effMaxProgress:setParent(self._effectGao.transform)
	self._effMaxProgress:setLocalPos(0, 0, 0)
	self._effMaxProgress:setScaleXYZ(self._teamId == GameEnum.BattleTeam.Left and 0.55 or -0.55, 1, 1)
end

function BattleSpiritInvocationSkillComponent:_stopMaxProgressEff()
	if self._effMaxProgress then
		UIEffectManager.instance:stopEffect(self._effMaxProgress)

		self._effMaxProgress = nil
	end
end

return BattleSpiritInvocationSkillComponent
