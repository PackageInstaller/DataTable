ys = ys or {}

local BattleScoreBarView = class("BattleScoreBarView")

ys.Battle.BattleScoreBarView = BattleScoreBarView
BattleScoreBarView.__name = "BattleScoreBarView"

function BattleScoreBarView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform

	self:init()

	return
end

function BattleScoreBarView:init()
	self._scoreTF = self._tf:Find("bg/Text")
	self._comboTF = self._tf:Find("comboMark")
	self._comboText = self._tf:Find("comboMark/value")

	return
end

function BattleScoreBarView:SetActive(arg_3_1)
	SetActive(self._tf, arg_3_1)

	return
end

function BattleScoreBarView:UpdateScore(arg_4_1)
	setText(self._scoreTF, arg_4_1)

	return
end

function BattleScoreBarView:UpdateCombo(arg_5_1)
	if arg_5_1 > 1 then
		SetActive(self._comboTF, true)
	else
		SetActive(self._comboTF, false)
	end

	setText(self._comboText, arg_5_1)

	return
end

return
