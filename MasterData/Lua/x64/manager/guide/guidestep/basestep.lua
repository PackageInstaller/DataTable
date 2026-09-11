local BaseStep = class("BaseStep")

function BaseStep:Ctor(arg_1_1, arg_1_2)
	self._starTime = 0
	self._guide = arg_1_1
	self._stepId = arg_1_2
	self._stepCfg = GuideStepCfg[self._stepId]
	self._isFinish = self._stepCfg.is_finish or false

	self:Init()
end

function BaseStep:Init()
	return
end

function BaseStep:Check()
	return true
end

function BaseStep:Play()
	return
end

function BaseStep:OnStepEnd()
	if self._guide ~= nil then
		self._guide:OnStepEnd(self)
	end

	self._guide = nil
end

function BaseStep:Guide()
	return self._guide
end

function BaseStep:IsFinish()
	return self._isFinish
end

function BaseStep:GetStepId()
	return self._stepId
end

function BaseStep:GetShowMask()
	return false
end

function BaseStep:Click()
	return
end

function BaseStep:EventTrigger(arg_11_1, arg_11_2)
	return
end

function BaseStep:BattleFinish(arg_12_1)
	return
end

function BaseStep:UpdateStarTime()
	self._starTime = Time.realtimeSinceStartup
end

function BaseStep:GetStarTime()
	return self._starTime
end

function BaseStep:ShowTalk()
	manager.guide.view:SetTalkItem(self._stepCfg, self._guide)
	manager.guide.view:ShowTalk(self._stepCfg)
end

return BaseStep
