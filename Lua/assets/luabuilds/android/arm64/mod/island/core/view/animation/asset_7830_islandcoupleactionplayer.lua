local IslandCoupleActionPlayer = class("IslandCoupleActionPlayer", import("..IslandBaseUnit"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function IslandCoupleActionPlayer:Ctor(arg_1_1)
	IslandCoupleActionPlayer.super.Ctor(self, arg_1_1)

	self.playing = false
	self.phase = var_0_1

	self:Init()

	return
end

function IslandCoupleActionPlayer:IsPlaying()
	return self.playing
end

function IslandCoupleActionPlayer:Stop()
	if not self:IsPlaying() then
		return
	end

	if self.phase == var_0_1 then
		return
	end

	if self.phase == var_0_2 and self.playData then
		self:NotifiyCore(ISLAND_EVT.REMOVE_PATH_FINDER, {
			unitId = self.playData[2].id,
			unitType = self.playData[2].unitType
		})
		self:ResetAnimation()
	elseif self.phase == var_0_3 and self.playData then
		self:ResetAnimation()
	end

	self:WillExit(self.playData[2], self.playData[1])
	self:Exit(self.playData[2], self.playData[1])

	return
end

function IslandCoupleActionPlayer:ResetAnimation()
	local var_4_0 = self:GetView():GetUnitModuleWithType(self.playData[1].unitType, self.playData[1].id)

	if var_4_0 then
		var_4_0:CheckMovement()
	end

	local var_4_1 = self:GetView():GetUnitModuleWithType(self.playData[2].unitType, self.playData[2].id)

	if var_4_1 then
		var_4_1:CheckMovement()
	end

	return
end

function IslandCoupleActionPlayer:Play(arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2 or not arg_5_1 then
		return
	end

	self.playData = {
		arg_5_2,
		arg_5_1
	}

	self:EnableOrDisablePlayerOp(arg_5_2, arg_5_1, false)
	self:EnableOrDisableUnitSyn(arg_5_2, arg_5_1, false)

	self.playing = true

	self:SendStartEvent(arg_5_2, arg_5_1)
	self:ShowOrHideCancelableBtn(arg_5_2, arg_5_1, true)

	local var_5_0 = false
	local var_5_1 = Vector3(0, 0, 0)

	seriesAsync({
		function(arg_6_0)
			var_5_0, var_5_1 = self:NavigateToPoint(arg_5_2, arg_5_1, arg_5_3, arg_6_0)

			return
		end,
		function(arg_7_0)
			onNextTick(arg_7_0)

			return
		end,
		function(arg_8_0)
			if not self.playing then
				return
			end

			self:EnableOrDisablePlayerSyn(arg_5_1, false)

			if not var_5_0 then
				arg_8_0()

				return
			end

			self:Face2Face(var_5_1, arg_5_2, arg_5_1, arg_8_0)

			return
		end,
		function(arg_9_0)
			if not self.playing then
				return
			end

			if not var_5_0 then
				arg_9_0()

				return
			end

			self:PlayCoupleActions(arg_5_2, arg_5_1, arg_5_3, arg_9_0)

			return
		end,
		function(arg_10_0)
			if not self.playing then
				return
			end

			IslandTaskHelper.OnActionEnd(arg_5_3.id)
			self:WillExit(arg_5_1, arg_5_2)
			arg_10_0()

			return
		end
	}, function()
		self:Exit(arg_5_1, arg_5_2, arg_5_3)

		return
	end)

	return
end

function IslandCoupleActionPlayer:WillExit(arg_12_1, arg_12_2)
	if arg_12_1 then
		self:EnableOrDisablePlayerSyn(arg_12_1, true)
	end

	if arg_12_2 and arg_12_1 then
		self:EnableOrDisableUnitSyn(arg_12_2, arg_12_1, true)
		self:EnableOrDisablePlayerOp(arg_12_2, arg_12_1, true)
	end

	return
end

function IslandCoupleActionPlayer:Exit(arg_13_1, arg_13_2)
	if arg_13_2 and arg_13_1 then
		self:ShowOrHideCancelableBtn(arg_13_2, arg_13_1, false)
		self:SendEndEvent(arg_13_2, arg_13_1)
	end

	self.playing = false
	self.phase = var_0_1
	self.playData = nil

	return
end

function IslandCoupleActionPlayer:ShowOrHideCancelableBtn(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self:GetView():IsPlayer(arg_14_1.id)

	var_14_0 = var_14_0 or self:GetView():IsPlayer(arg_14_2.id)

	if not var_14_0 then
		return
	end

	if arg_14_3 then
		self:NotifiyCore(ISLAND_EVT.START_DO_COUPLE_ACTION)
	else
		self:NotifiyCore(ISLAND_EVT.END_DO_COUPLE_ACTION)
	end

	return
end

function IslandCoupleActionPlayer:SendStartEvent(arg_15_1, arg_15_2)
	local var_15_0 = self:GetView():IsPlayer(arg_15_1.id)

	var_15_0 = var_15_0 or self:GetView():IsPlayer(arg_15_2.id)

	if var_15_0 then
		self:NotifiyCore(ISLAND_EVT.START_COUPLE_ACTION)
	end

	return
end

function IslandCoupleActionPlayer:SendEndEvent(arg_16_1, arg_16_2)
	local var_16_0 = self:GetView():IsPlayer(arg_16_1.id)

	var_16_0 = var_16_0 or self:GetView():IsPlayer(arg_16_2.id)

	if var_16_0 then
		self:NotifiyCore(ISLAND_EVT.END_COUPLE_ACTION)
	end

	return
end

function IslandCoupleActionPlayer:NavigateToPoint(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self.phase = var_0_2

	local var_17_0 = arg_17_3.respond_point and arg_17_3.respond_point ~= "" and BuildVector3(arg_17_3.respond_point) or Vector3(0, 0, 2)
	local var_17_1 = IslandCalcUtil.GetCanReachOptPoint(arg_17_2._go.transform.position, var_17_0.magnitude, arg_17_1.agent, arg_17_1._tf.position, arg_17_1._go.transform.position + arg_17_1._go.transform.rotation * var_17_0, 36)
	local var_17_2

	if not var_17_1 then
		arg_17_4()

		if not self:GetView():IsPlayer(arg_17_1.id) then
			if self:GetView():IsPlayer(arg_17_2.id) then
				self:OnNavigateToPointFailed()
			end
		end

		do return false end

		var_17_2 = {}
	end

	var_17_2.navData = {
		speed = 5,
		hide = false,
		waitUntilDone = true,
		unitId = arg_17_2.id,
		unitType = arg_17_2.unitType,
		position = {
			var_17_1.x,
			var_17_1.y,
			var_17_1.z
		}
	}
	var_17_2.callback = arg_17_4

	self:NotifiyCore(ISLAND_EVT.GEN_PATH_FINDER, var_17_2)

	return true, (IslandCalcUtil.RotationOffset(arg_17_1._go.transform.position, arg_17_1._go.transform.position + arg_17_1._go.transform.rotation * var_17_0, var_17_1))
end

function IslandCoupleActionPlayer:OnNavigateToPointFailed()
	pg.TipsMgr.GetInstance():ShowTips(i18n("island_no_position_to_reponse_action"))

	return
end

function IslandCoupleActionPlayer:Face2Face(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_3._go.transform.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_19_2._go.transform.position - arg_19_3._go.transform.position).eulerAngles.y, 0)
	arg_19_2._go.transform.rotation = arg_19_1 * arg_19_2._go.transform.rotation

	if isa(arg_19_3, IslandPlayerUnit) then
		arg_19_3.targetRotation = arg_19_3._go.transform.rotation
	end

	if isa(arg_19_2, IslandPlayerUnit) then
		arg_19_2.targetRotation = arg_19_2._go.transform.rotation
	end

	arg_19_4()

	return
end

function IslandCoupleActionPlayer:PlayCoupleActions(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	self.phase = var_0_3

	parallelAsync({
		function(arg_21_0)
			arg_20_2:PlayAnimation(arg_20_3.responder_feedback, 0.25, arg_21_0)

			return
		end,
		function(arg_22_0)
			arg_20_1:PlayAnimation(arg_20_3.resource .. "_end", 0.25, arg_22_0)

			return
		end
	}, arg_20_4)

	return
end

function IslandCoupleActionPlayer:EnableOrDisablePlayerSyn(arg_23_1, arg_23_2)
	if isa(arg_23_1, IslandPlayerUnit) then
		arg_23_1:ActiveOrDisactive(arg_23_2)
	end

	return
end

function IslandCoupleActionPlayer:EnableOrDisablePlayerOp(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = self:GetView():IsPlayer(arg_24_1.id)

	var_24_0 = var_24_0 or self:GetView():IsPlayer(arg_24_2.id)

	if var_24_0 then
		if arg_24_3 then
			self:GetView():EnablePlayerOp()
		else
			self:GetView():DisablePlayerOp()
			IslandCameraMgr.instance.gameObject:GetComponent(typeof(InputController)):EnablePlayerLook()
		end
	end

	return
end

function IslandCoupleActionPlayer:EnableOrDisableUnitSyn(arg_25_1, arg_25_2, arg_25_3)
	local function var_25_0(arg_26_0, arg_26_1)
		if arg_26_1 then
			arg_26_0:WakeUp()
		else
			arg_26_0:Sleep()
		end

		return
	end

	if isa(arg_25_1, IslandVisitorUnit) then
		var_25_0(arg_25_1, arg_25_3)
	end

	if isa(arg_25_2, IslandVisitorUnit) then
		var_25_0(arg_25_2, arg_25_3)
	end

	return
end

return IslandCoupleActionPlayer
