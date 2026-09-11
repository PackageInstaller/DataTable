local ChessCurrentModel = class("ChessCurrentModel")
local var_0_1 = {
	[0] = {
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}

function ChessCurrentModel:Ctor()
	self.currentEvent_ = false
	self.isShow_ = false
	self.isDetector_ = false
	self.aboutToSlide_ = false
	self.bugFix_ = false
	self.aboutToDie_ = false
end

function ChessCurrentModel:SetUp(arg_2_1)
	self.blockerManager_ = arg_2_1
end

function ChessCurrentModel:ExtendSetup()
	local var_3_0 = WarChessData:GetDetectorPos()

	if #var_3_0 > 0 then
		self.isDetector_ = true

		ChessLuaBridge.LayDownChildBoatWithoutAnimation(var_3_0[1], var_3_0[2])
	end
end

function ChessCurrentModel:SlideByDirection(arg_4_1)
	self.blockerManager_:ShowBlocker()
	ChessLuaBridge.SlideByDirection(arg_4_1, 4)
	ChessLuaBridge.LookAtPlayer()

	self.currentEvent_ = true
end

function ChessCurrentModel:SlideByDirectionInCurrentState(arg_5_1)
	ChessLuaBridge.SlideByDirection(arg_5_1, 4)
end

function ChessCurrentModel:CurrentPatch()
	self.bugFix_ = true
end

function ChessCurrentModel:IsCurrentPatch()
	self.bugFix_ = false

	return self.bugFix_
end

function ChessCurrentModel:CurrentEnd()
	self.currentEvent_ = false

	self.blockerManager_:HideBlocker()
end

function ChessCurrentModel:SetDetector(arg_9_1)
	self.isDetector_ = arg_9_1
end

function ChessCurrentModel:IsDetector()
	return self.isDetector_
end

function ChessCurrentModel:IsCurrentState()
	return self.currentEvent_
end

function ChessCurrentModel:LayDownOrUpShip(arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_1 then
		self.blockerManager_:ShowBlocker()

		local var_12_1 = ChessLuaBridge.GetPlayerDirection()

		WarChessData:SetCharacterDirection(var_12_1)

		var_12_0 = ChessLuaBridge.LayDownChildBoat(1, function()
			arg_12_2()
			self.blockerManager_:HideBlocker()
		end)

		if not var_12_0 then
			self.blockerManager_:HideBlocker()
			ShowTips("ACTIVITY_WARCHESS_RELIEVE")
		else
			self:SetDetector(true)
			WarChessAction.SwitchShipControl(2)

			local var_12_2 = WarChessData:GetCurrentIndex()
			local var_12_3 = var_0_1[math.fmod(var_12_1 + 3, 6)]

			WarChessData:SetDetectorPos(var_12_2.x + var_12_3[1], var_12_2.z + var_12_3[2])
		end
	else
		self.blockerManager_:ShowBlocker()

		var_12_0 = ChessLuaBridge.PutUpChildBoat(function()
			arg_12_2()
			self.blockerManager_:HideBlocker()
		end)

		if not var_12_0 then
			self.blockerManager_:HideBlocker()
			ShowTips("ACTIVITY_WARCHESS_RECOVER")
		else
			self:SetDetector(false)
			WarChessAction.SwitchShipControl(1)
			WarChessData:SetDetectorPos()
		end
	end

	return var_12_0
end

function ChessCurrentModel:AboutToSlide(arg_15_1)
	self.aboutToSlide_ = arg_15_1
end

function ChessCurrentModel:IsAboutToSlide()
	self.aboutToSlide_ = false

	return self.aboutToSlide_ or false
end

function ChessCurrentModel:ShipImmediatelyDie()
	local var_17_0 = WarChessData:GetShipHp()

	if var_17_0 and var_17_0 <= 0 then
		self.blockerManager_:ShowBlocker()
		ChessLuaBridge.PlayRoleAnimation("dead", function()
			manager.notify:CallUpdateFunc(SHIP_DIE)
			TimeTools.StartAfterSeconds(2, function()
				self.blockerManager_:HideBlocker()
				OnExitChessScene(true)
			end, {})
		end)

		return true
	end
end

function ChessCurrentModel:ChessSuccess()
	self.blockerManager_:ShowBlocker()
	manager.notify:CallUpdateFunc(CHESS_SUCCESS)
	TimeTools.StartAfterSeconds(2, function()
		self.blockerManager_:HideBlocker()
		OnExitChessScene(true)
	end, {})
end

function ChessCurrentModel:AboutToDie(arg_22_1)
	if arg_22_1 == 1 then
		self.aboutToDie_ = true
	elseif arg_22_1 == 2 and self.aboutToDie_ then
		self:ShipImmediatelyDie()
	else
		self.aboutToDie_ = false
	end
end

function ChessCurrentModel:Dispose()
	self.currentEvent_ = false
	self.isShow_ = false
	self.isDetector_ = false
	self.aboutToSlide_ = false
	self.bugFix_ = false
	self.aboutToDie_ = false
end

return ChessCurrentModel
