local CrossRoadPlayerMgr = class("CrossRoadPlayerMgr")

function CrossRoadPlayerMgr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tpl = arg_1_1
	self._runningData = arg_1_2
	self._event = arg_1_3
	self.playingAction = "normal"
	self._tf = self._tpl:Find("zhihui_tpl")
	self.spineAnimUI = GetComponent(findTF(self._tf, "spine"), "SpineAnimUI")
	self.frontRoadTF = arg_1_2:GetRoadTF(CrossRoadGameConst.FRONT_ROAD_NAME):Find("content")
	self.frontRoadList = arg_1_2:GetRoadList(CrossRoadGameConst.FRONT_ROAD_NAME)
	self.joyData = {
		go = false,
		stop = false,
		left = false,
		right = false
	}
	self.state = CrossRoadGameConst.PLAYER_STATE.normal
	self.roleList = arg_1_2:GetRoleList()
	self.speed = CrossRoadGameConst.PLAYER_SPEED
	self.carshChangePos = true
	self.hongCha = self._runningData:GetHongChaTpl()

	self:setActionNormal()

	self.itemList = self._runningData:GetItemGoList()

	return
end

function CrossRoadPlayerMgr:Prepare()
	setParent(self._tf, self.frontRoadTF, false)
	self:SetPosition(self.frontRoadList.lightTF.anchoredPosition)
	self._runningData:SetPlayerPosition(self:GetPosition())
	self.spineAnimUI:SetActionCallBack(function(arg_3_0)
		if arg_3_0 == "finish" and self.state == CrossRoadGameConst.PLAYER_STATE.crash then
			self:SetAction("recover2", 0)

			self.state = CrossRoadGameConst.PLAYER_STATE.recover

			return
		elseif arg_3_0 == "action" and self.state == CrossRoadGameConst.PLAYER_STATE.recover then
			self.state = CrossRoadGameConst.PLAYER_STATE.normal
			self.carshChangePos = true

			self:setActionNormal()

			return
		end

		return
	end)

	return
end

function CrossRoadPlayerMgr:Step(arg_4_1)
	self.joyData = self._runningData:GetJoyData()
	self.roleList = self._runningData:GetRoleList()

	self:UpdateAction()
	self:UpdateMove(arg_4_1)
	self:CheckAndClearBin()

	return
end

function CrossRoadPlayerMgr:UpdateAction()
	if self:GetCrashState() then
		return
	end

	local var_5_0 = self.joyData
	local var_5_2
	local var_5_3

	if not self.joyData.left == self.joyData.right then
		var_5_2 = CrossRoadGameConst.PLAYER_STATE.walk
	end

	if not var_5_0.stop == var_5_0.go then
		var_5_3 = var_5_0.stop and CrossRoadGameConst.PLAYER_STATE.stop or CrossRoadGameConst.PLAYER_STATE.sign
	end

	self.state = var_5_2 == CrossRoadGameConst.PLAYER_STATE.walk and (var_5_3 and (var_5_0.stop and CrossRoadGameConst.PLAYER_STATE.stop_walk or CrossRoadGameConst.PLAYER_STATE.sign_walk) or var_5_2) or var_5_3 or CrossRoadGameConst.PLAYER_STATE.normal

	self:SetAction(self.state, 0)

	return
end

function CrossRoadPlayerMgr:UpdateMove(arg_6_1)
	if self:GetCrashState() then
		if self.carshChangePos then
			self:SetPlayerCarshPos(self._runningData:GetPlayerCrashDir(), (self._runningData:GetPlayerCarshSize()))
		end

		return
	end

	if not self.joyData.left == self.joyData.right then
		local var_6_1 = self.joyData.left and {
			-1,
			0
		} or {
			1,
			0
		}

		self:SetFaceDir(var_6_1[1])
		self:SetPlayerPositionByDir(var_6_1, arg_6_1)
	end

	return
end

function CrossRoadPlayerMgr:SetPlayerPositionByDir(arg_7_1, arg_7_2)
	local var_7_0 = self:GetPosition()
	local var_7_1 = Vector2(var_7_0.x + self.speed * arg_7_1[1] * arg_7_2, var_7_0.y)
	local var_7_2 = self._runningData:GetSceneWidth()

	if isActive(self.hongCha) and CrossRoadGameHelper:CheckPlayerInItem(self._tf, self.hongCha) then
		self._event(CrossRoadGameConst.GET_HONGCHA)
		setActive(self.hongCha, false)
	end

	if var_7_1.x > -var_7_2 / 2 and var_7_1.x < var_7_2 / 2 then
		self:SetPosition(var_7_1)
	end

	self._runningData:SetPlayerPosition(self:GetPosition())

	return
end

function CrossRoadPlayerMgr:SetPlayerCarshPos(arg_8_1, arg_8_2)
	local var_8_0 = self:GetPosition()

	self:SetFaceDir(-arg_8_1[1])

	local var_8_1 = Vector2(var_8_0.x + arg_8_2 * arg_8_1[1], var_8_0.y)
	local var_8_2 = self._runningData:GetSceneWidth()

	if var_8_1.x > -var_8_2 / 2 and var_8_1.x < var_8_2 / 2 then
		self:SetPosition(var_8_1)
	end

	self.carshChangePos = false

	self._runningData:SetPlayerPosition(self:GetPosition())

	return
end

function CrossRoadPlayerMgr:SetFaceDir(arg_9_1)
	if arg_9_1 == 0 then
		return
	end

	local var_9_0 = self._tf.localScale

	var_9_0.x = math.abs(self._tf.localScale.x) * arg_9_1
	self._tf.localScale = var_9_0

	return
end

function CrossRoadPlayerMgr:GetCrashState()
	return self.state == CrossRoadGameConst.PLAYER_STATE.crash or self.state == CrossRoadGameConst.PLAYER_STATE.recover
end

function CrossRoadPlayerMgr:PlayZhihuiHit()
	if self:GetCrashState() then
		return
	end

	self.state = CrossRoadGameConst.PLAYER_STATE.crash

	self:SetAction(CrossRoadGameConst.PLAYER_STATE.crash, 0)

	return
end

function CrossRoadPlayerMgr:CheckAndClearBin()
	self.itemList = self._runningData:GetItemGoList()

	for iter_12_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		if self.itemList[iter_12_0] ~= nil and self.itemList[iter_12_0].id == CrossRoadGameConst.BING_MIAN and CrossRoadGameHelper:CheckPlayerInItem(self._tf, self.itemList[iter_12_0].go) then
			self._event(CrossRoadGameConst.DISPOSE_BIN, iter_12_0)
		end
	end

	return
end

function CrossRoadPlayerMgr:SetAction(arg_13_1, arg_13_2)
	if self.playingAction == arg_13_1 then
		return
	end

	self.playingAction = arg_13_1

	self.spineAnimUI:SetAction(arg_13_1, arg_13_2)

	return
end

function CrossRoadPlayerMgr:setActionNormal()
	self:SetAction("normal", 0)

	return
end

function CrossRoadPlayerMgr:SetPosition(arg_15_1)
	self._tf.anchoredPosition = arg_15_1

	return
end

function CrossRoadPlayerMgr:GetPosition()
	return self._tf.anchoredPosition
end

function CrossRoadPlayerMgr:Clear()
	self:setActionNormal()
	setParent(self._tf, self._tpl, false)

	if self.spineAnimUI then
		self.spineAnimUI:SetActionCallBack(nil)
	end

	return
end

function CrossRoadPlayerMgr:Dispose()
	return
end

return CrossRoadPlayerMgr
