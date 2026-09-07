ys = ys or {}

local var_0_0 = ys.Battle.BattleVariable
local BattleInkView = class("BattleInkView")

ys.Battle.BattleInkView = BattleInkView
BattleInkView.__name = "BattleInkView"
BattleInkView.ANIMATION_STATE_INITIAL = "intial"
BattleInkView.ANIMATION_STATE_IDLE = "idle"
BattleInkView.ANIMATION_STATE_FINALE = "int"

function BattleInkView:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()

	return
end

function BattleInkView:init()
	self._tf = self._go.transform
	self._hollowTpl = self._tf:Find("ink_tpl")
	self._hollowContainer = self._tf:Find("container")
	self._unitHollowList = {}
	self._state = BattleInkView.ANIMATION_STATE_IDLE

	return
end

function BattleInkView:IsActive()
	return self._isActive
end

function BattleInkView:Update()
	for iter_4_0, iter_4_1 in pairs(self._unitHollowList) do
		if iter_4_0:IsAlive() then
			iter_4_1.hollow.position = var_0_0.CameraPosToUICamera(iter_4_1.pos:Copy(iter_4_0:GetPosition()) + Vector3(0, 0, 0))
		else
			self:RemoveHollow(iter_4_0)
		end
	end

	return
end

function BattleInkView:SetActive(arg_5_1, arg_5_2)
	self._isActive = arg_5_1

	if arg_5_1 then
		self._state = BattleInkView.ANIMATION_STATE_INITIAL

		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			self:AddHollow(iter_5_1)
		end

		setActive(self._go, true)
	else
		local var_5_0 = true

		for iter_5_2, iter_5_3 in pairs(self._unitHollowList) do
			self.doHollowScaleAnima(iter_5_3.hollow, 125, 0.3, var_5_0 and function()
				self:RemoveHollow(iter_5_2)
				setActive(self._go, false)

				self._state = BattleInkView.ANIMATION_STATE_IDLE

				return
			end or nil)

			var_5_0 = false
		end
	end

	return
end

function BattleInkView:AddHollow(arg_7_1)
	local var_7_0 = arg_7_1:GetAttrByName("blindedHorizon")

	if self._unitHollowList[arg_7_1] then
		if self._unitHollowList[arg_7_1].range ~= var_7_0 then
			self.doHollowScaleAnima(self._unitHollowList[arg_7_1].hollow, var_7_0)
		end

		self._unitHollowList[arg_7_1].range = var_7_0

		return
	elseif var_7_0 == 0 then
		return
	end

	local var_7_1 = {}
	local var_7_2 = cloneTplTo(self._hollowTpl, self._hollowContainer)

	var_7_2.localScale = Vector3(125, 125, 0)

	self.doHollowScaleAnima(var_7_2, var_7_0)
	Vector3.zero:Copy(arg_7_1:GetPosition())

	var_7_1.range = var_7_0
	var_7_1.hollow = var_7_2
	var_7_1.pos = Vector3.zero
	self._unitHollowList[arg_7_1] = var_7_1

	return
end

function BattleInkView:RemoveHollow(arg_8_1, arg_8_2)
	LeanTween.cancel(self._unitHollowList[arg_8_1].hollow.gameObject)
	Destroy(self._unitHollowList[arg_8_1].hollow.gameObject)

	self._unitHollowList[arg_8_1] = nil

	return
end

function BattleInkView:UpdateHollow(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		self:AddHollow(iter_9_1)
	end

	return
end

function BattleInkView:doHollowScaleAnima(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2 or 0.5

	LeanTween.cancel(go(self))

	if arg_10_3 then
		LeanTween.scale(self, Vector3(arg_10_1, arg_10_1, 0), var_10_0):setOnComplete(System.Action(function()
			arg_10_3()

			return
		end))
	end

	return
end

function BattleInkView:Dispose()
	self:SetActive(false)

	for iter_12_0, iter_12_1 in pairs(self._unitHollowList) do
		LeanTween.cancel(iter_12_1.hollow.gameObject)
		Destroy(iter_12_1.hollow.gameObject)
	end

	self._go = nil
	self._tf = nil
	self._unitHollowList = nil

	return
end

return
