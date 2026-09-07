ys = ys or {}

local var_0_0 = ys
local BattleSimulationBuffCountView = class("BattleSimulationBuffCountView")

ys.Battle.BattleSimulationBuffCountView = BattleSimulationBuffCountView
BattleSimulationBuffCountView.__name = "BattleSimulationBuffCountView"

function BattleSimulationBuffCountView:Ctor(arg_1_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._timer = self._tf:Find("buff_count/Text")
	self._text = self._timer:GetComponent(typeof(Text))

	return
end

function BattleSimulationBuffCountView:SetActive(arg_2_1)
	setActive(self._go, arg_2_1)

	return
end

function BattleSimulationBuffCountView:SetCountDownText(arg_3_1)
	self._text.text = i18n("simulation_advantage_counting", math.floor(arg_3_1))

	return
end

function BattleSimulationBuffCountView:SetEnhancedText()
	self._text.text = i18n("simulation_enhanced")

	return
end

function BattleSimulationBuffCountView:Dispose()
	self._rateBarList = nil
	self._progressList = nil

	return
end

return
