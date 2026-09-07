ys = ys or {}

local var_0_0 = ys
local BattleSubmarineFuncButton = class("BattleSubmarineFuncButton", ys.Battle.BattleWeaponButton)

ys.Battle.BattleSubmarineFuncButton = BattleSubmarineFuncButton
BattleSubmarineFuncButton.__name = "BattleSubmarineFuncButton"

function BattleSubmarineFuncButton:Ctor()
	var_0_0.EventListener.AttachEventListener(self)

	self.eventTriggers = {}

	return
end

function BattleSubmarineFuncButton:OnfilledEffect()
	SetActive(self._filledEffect, true)

	return
end

function BattleSubmarineFuncButton:SetProgressInfo(arg_3_1)
	self._progressInfo = arg_3_1

	self._progressInfo:RegisterEventListener(self, var_0_0.Battle.BattleEvent.WEAPON_COUNT_PLUS, self.OnfilledEffect)
	self._progressInfo:RegisterEventListener(self, var_0_0.Battle.BattleEvent.OVER_LOAD_CHANGE, self.OnOverLoadChange)
	self:OnOverLoadChange()
	self:SetControllerActive(true)

	return
end

function BattleSubmarineFuncButton:Update()
	if self._progressInfo:GetCurrent() < self._progressInfo:GetMax() then
		self:updateProgressBar()
	end

	return
end

function BattleSubmarineFuncButton:Dispose()
	if self.eventTriggers then
		for iter_5_0, iter_5_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_5_0)
		end

		self.eventTriggers = nil
	end

	self._progress = nil
	self._progressBar = nil

	self._progressInfo:UnregisterEventListener(self, var_0_0.Battle.BattleEvent.OVER_LOAD_CHANGE)
	self._progressInfo:UnregisterEventListener(self, var_0_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)
	var_0_0.EventListener.DetachEventListener(self)

	return
end

return
