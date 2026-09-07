local CrossRoadCar = class("CrossRoadCar")

function CrossRoadCar:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._tf = arg_1_1
	self._runningData = arg_1_4
	self.id = arg_1_2.id
	self.trackId = arg_1_3
	self.carMsg = arg_1_2
	self.speed = arg_1_2.speed
	self.width = arg_1_2.width
	self.length = arg_1_2.length
	self.spineTF = self._tf:Find("spine")
	self.spineAnimUI = GetComponent(self.spineTF, "SpineAnimUI")
	self.playingStatus = CrossRoadGameConst.CAR_STATE.showBack
	self.playingTrack = CrossRoadGameConst.BACK_ROAD_NAME
	self.playingAction = "normal"
	self.target = nil
	self.pos = nil
	self.needDispose = false
	self.carCarshList = {}
	self.direct = {
		0,
		1
	}

	self:setActionNormal()

	return
end

function CrossRoadCar:GetCarRectPoint()
	local var_2_0 = self:GetPosition()

	return var_2_0.x - self._tf.rect.width / 2, var_2_0.y, var_2_0.x + self._tf.rect.width / 2, var_2_0.y + self._tf.rect.height
end

function CrossRoadCar:SetParent(arg_3_1)
	setParent(self._tf, arg_3_1, false)

	return
end

function CrossRoadCar:SetPosition(arg_4_1)
	self._tf.anchoredPosition = arg_4_1

	return
end

function CrossRoadCar:SetDispose(arg_5_1)
	self.needDispose = arg_5_1

	return
end

function CrossRoadCar:GetNeedDispose()
	return self.needDispose
end

function CrossRoadCar:GetId()
	return self.id
end

function CrossRoadCar:SetCarCrashList(arg_8_1)
	arg_8_1:SetParent(self._tf)
	arg_8_1:SetScale(Vector3(-1 / self._tf.localScale.x, 1 / self._tf.localScale.x, 1))
	arg_8_1:SetPosition(Vector2(arg_8_1:GetPosition().x - self._tf.anchoredPosition.x, 0))
	table.insert(self.carCarshList, arg_8_1)

	return
end

function CrossRoadCar:GetPosition()
	return self._tf.anchoredPosition
end

function CrossRoadCar:SetDirect(arg_10_1)
	self.direct = arg_10_1

	return
end

function CrossRoadCar:GetDirect()
	return self.direct
end

function CrossRoadCar:SetTarget(arg_12_1)
	self.target = arg_12_1

	return
end

function CrossRoadCar:GetTarget()
	return self.target
end

function CrossRoadCar:SetScale(arg_14_1)
	self._tf.localScale = arg_14_1

	return
end

function CrossRoadCar:SetActive(arg_15_1)
	setActive(self._tf, arg_15_1)

	return
end

function CrossRoadCar:SetState(arg_16_1)
	self.playingStatus = arg_16_1

	return
end

function CrossRoadCar:GetSpeed()
	local var_17_0 = math.min(self._runningData:GetRoundCnt(), #CrossRoadGameConst.CAR_SPEED_SCALE)

	return self.speed * (1 + (var_17_0 < 1 and 0 or CrossRoadGameConst.CAR_SPEED_SCALE[var_17_0]))
end

function CrossRoadCar:GetState()
	return self.playingStatus
end

function CrossRoadCar:GetTrack()
	return self.playingTrack
end

function CrossRoadCar:SetTrack(arg_20_1)
	self.playingTrack = arg_20_1

	return
end

function CrossRoadCar:GetTrackID()
	return self.trackId
end

function CrossRoadCar:SetAction(arg_22_1, arg_22_2)
	if self.playingAction == arg_22_1 then
		return
	end

	self.playingAction = arg_22_1

	self.spineAnimUI:SetAction(arg_22_1, arg_22_2)

	return
end

function CrossRoadCar:SetActionCallBack(arg_23_1)
	self._spineAnimUI:SetActionCallBack(arg_23_1)

	return
end

function CrossRoadCar:setActionNormal()
	self:SetAction("normal", 0)

	return
end

function CrossRoadCar:SetSpCarAction(arg_25_1)
	self.spineAnimUI:SetActionCallBack(function(arg_26_0)
		if arg_26_0 == "finish" then
			self.spineAnimUI:SetActionCallBack(nil)
			self:setActionNormal()

			if arg_25_1 then
				arg_25_1()
			end
		end

		return
	end)
	self:SetAction("action", 0)

	return
end

function CrossRoadCar:SetSpTrackId(arg_27_1)
	self.spTrackId = arg_27_1

	return
end

function CrossRoadCar:GetSpTrackId()
	return self.spTrackId
end

function CrossRoadCar:SetSpCarState(arg_29_1)
	self.spCarState = arg_29_1

	return
end

function CrossRoadCar:GetSpCarState()
	return self.spCarState
end

function CrossRoadCar:Clear()
	return
end

function CrossRoadCar:Dispose()
	if self.carCarshList then
		for iter_32_0, iter_32_1 in pairs(self.carCarshList) do
			if iter_32_1 ~= nil then
				iter_32_1:Clear()
			end
		end
	end

	self.carCarshList = {}

	if self._tf then
		destroy(self._tf)

		self._tf = nil
	end

	self.playingAction = nil

	if self.spineAnimUI then
		self.spineAnimUI:SetActionCallBack(nil)

		self.spineAnimUi = nil
	end

	self.target = nil

	return
end

return CrossRoadCar
