ys = ys or {}
ys.Battle.BattleMainDamagedView = class("BattleMainDamagedView")

local BattleMainDamagedView = class("BattleMainDamagedView")

ys.Battle.BattleMainDamagedView = BattleMainDamagedView
BattleMainDamagedView.__name = "BattleMainDamagedView"

function BattleMainDamagedView:Ctor(arg_1_1)
	self._go = arg_1_1

	self:Init()

	return
end

function BattleMainDamagedView:Init()
	self._tf = self._go.transform
	self._bleedView = findTF(self._tf, "mainUnitDamaged")
	self._bleedAnimation = self._bleedView:GetComponent(typeof(Animator))

	self._bleedView:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_3_0)
		setActive(self._bleedView, false)

		self._isPlaying = false

		return
	end)
	setActive(self._bleedView, false)

	self._isPlaying = false

	return
end

function BattleMainDamagedView:Play()
	if not self._isPlaying then
		setActive(self._bleedView, true)
	end

	self._isPlaying = true

	return
end

function BattleMainDamagedView:Dispose()
	self._bleedView = nil
	self._bleedAnimation = nil
	self._tf = nil
	self._go = nil

	return
end

return
