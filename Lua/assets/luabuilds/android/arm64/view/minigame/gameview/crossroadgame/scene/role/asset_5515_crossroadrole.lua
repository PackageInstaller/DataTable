local CrossRoadRole = class("CrossRoadRole")

function CrossRoadRole:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._tf = arg_1_1
	self._runningData = arg_1_4
	self._tpl = arg_1_3
	self.id = arg_1_2
	self.fa = arg_1_2
	self.startTime = 0
	self.speed = CrossRoadGameConst.CHILD_SPEED
	self.target = nil
	self.spineAnimUI = GetComponent(findTF(self._tf, "spine"), "SpineAnimUI")
	self.playingAction = nil
	self.arrowGroup = self._tf:Find("player_arrow/ad/arrow")
	self.selectTF = self.arrowGroup:Find("select")
	self.angryTF = self.arrowGroup:Find("angry")
	self.angryAni = self.angryTF:GetComponent(typeof(Animation))
	self.selectAni = self.selectTF:GetComponent(typeof(Animation))
	self.direct = {
		-1,
		0
	}
	self.trackName = CrossRoadGameConst.BACK_ROAD_NAME
	self.runState = nil
	self.playerHaveSelect = false
	self.angryTime = 0
	self.lastSelectTime = 0
	self.startAngryTime = 0
	self.lastAngryRollTime = 0
	self.lastXuanWoRollTime = 0

	self:setActionNormal()

	return
end

function CrossRoadRole:GetRoleRectPoint()
	local var_2_0 = self:GetPosition()

	return var_2_0.x - self._tf.rect.width / 2, var_2_0.y - self._tf.rect.height / 2, var_2_0.x + self._tf.rect.width / 2, var_2_0.y + self._tf.rect.height / 2
end

function CrossRoadRole:SetRoleActionByState(arg_3_1)
	if arg_3_1 == nil then
		arg_3_1 = self:GetRunState()
	end

	if arg_3_1 == CrossRoadGameConst.SHIP_STATE.stop then
		self:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.normal, 0)
	elseif arg_3_1 == CrossRoadGameConst.SHIP_STATE.walk then
		self:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.walk, 0)
	elseif arg_3_1 == CrossRoadGameConst.SHIP_STATE.crash then
		self:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.crash, 0)
	end

	return
end

function CrossRoadRole:RandomAngryTime()
	self.angryTime = math.random(CrossRoadGameConst.CHILD_ANGER_TIME[1], CrossRoadGameConst.CHILD_ANGER_TIME[2])

	return
end

function CrossRoadRole:CanAngryStart(arg_5_1)
	if self.id ~= self.fa or self.runState ~= CrossRoadGameConst.SHIP_STATE.stop then
		self:SetAngryActive(false)

		self.startAngryTime = nil

		return false
	end

	if self.startAngryTime ~= nil then
		return true
	end

	if arg_5_1 > self.lastSelectTime + CrossRoadGameConst.CAN_ANGRY_TIME then
		if arg_5_1 > self.lastAngryRollTime + CrossRoadGameConst.ONCE_ANGRY_TIME then
			if self:RollAngryState() then
				self.startAngryTime = arg_5_1

				self:SetAngryActive(true)
			else
				self.lastAngryRollTime = arg_5_1
			end
		end

		return true
	else
		self.startAngryTime = nil
	end

	return false
end

function CrossRoadRole:CanAngryMove(arg_6_1)
	if self.startAngryTime == nil then
		return
	end

	if arg_6_1 > self.startAngryTime + self.angryTime then
		return true
	end

	return
end

function CrossRoadRole:RollAngryState()
	return math.random(1, 100) < CrossRoadGameConst.ANGRY_PERCENT
end

function CrossRoadRole:SetSelectTime(arg_8_1)
	self.lastSelectTime = arg_8_1
	self.startAngryTime = nil

	return
end

function CrossRoadRole:SetAction(arg_9_1, arg_9_2)
	if self.playingAction == arg_9_1 then
		return
	end

	self.playingAction = arg_9_1

	self.spineAnimUI:SetAction(arg_9_1, arg_9_2)

	return
end

function CrossRoadRole:SetActionCallBack(arg_10_1)
	self._spineAnimUI:SetActionCallBack(arg_10_1)

	return
end

function CrossRoadRole:setActionNormal()
	self:SetAction("normal", 0)

	return
end

function CrossRoadRole:SetActive(arg_12_1)
	setActive(self._tf, arg_12_1)

	return
end

function CrossRoadRole:SetAngryActive(arg_13_1)
	if arg_13_1 then
		self.angryAni:Play("anim_CrossRoadGameUI_pac_angry")
	end

	setActive(self.angryTF, arg_13_1)

	return
end

function CrossRoadRole:SetSelectActive(arg_14_1)
	if arg_14_1 then
		self.selectAni:Play("anim_CrossRoadGameUI_pac_select")
	end

	setActive(self.selectTF, arg_14_1)

	return
end

function CrossRoadRole:SetParent(arg_15_1)
	setParent(self._tf, arg_15_1, false)

	return
end

function CrossRoadRole:SetScale(arg_16_1)
	self._tf.localScale = arg_16_1

	return
end

function CrossRoadRole:SetPosition(arg_17_1)
	self._tf.anchoredPosition = arg_17_1

	return
end

function CrossRoadRole:GetPosition()
	return self._tf.anchoredPosition
end

function CrossRoadRole:GetHW()
	return self._tf.rect.width, self._tf.rect.height
end

function CrossRoadRole:SetTarget(arg_20_1)
	self.target = arg_20_1

	return
end

function CrossRoadRole:GetTarget()
	return self.target
end

function CrossRoadRole:GetDirect()
	return self.direct
end

function CrossRoadRole:SetSpeed(arg_23_1)
	self.speed = arg_23_1

	return
end

function CrossRoadRole:GetSpeed()
	return self.speed
end

function CrossRoadRole:SetRunState(arg_25_1)
	self.runState = arg_25_1

	return
end

function CrossRoadRole:GetRunState()
	return self.runState
end

function CrossRoadRole:SetStartTime(arg_27_1)
	self.startTime = arg_27_1

	return
end

function CrossRoadRole:GetStartTime()
	return self.startTime
end

function CrossRoadRole:GetFatherID()
	return self.fa
end

function CrossRoadRole:SetFatherID(arg_30_1)
	self.fa = arg_30_1

	return
end

function CrossRoadRole:GetID()
	return self.id
end

function CrossRoadRole:SetID(arg_32_1)
	self.id = arg_32_1

	return
end

function CrossRoadRole:GetTrack()
	return self.trackName
end

function CrossRoadRole:SetTrack(arg_34_1)
	self.trackName = arg_34_1

	return
end

function CrossRoadRole:SetPlayerHaveSelect(arg_35_1)
	self.playerHaveSelect = arg_35_1

	return
end

function CrossRoadRole:GetXuanWoRollTime()
	return self.lastXuanWoRollTime
end

function CrossRoadRole:SetXuanWRollTime(arg_37_1)
	self.lastXuanWoRollTime = arg_37_1

	return
end

function CrossRoadRole:GetPlayerHaveSelect()
	return self.playerHaveSelect
end

function CrossRoadRole:Clear()
	self:SetParent(self._tpl)
	self._runningData:CrashDeadRole()

	return
end

return CrossRoadRole
