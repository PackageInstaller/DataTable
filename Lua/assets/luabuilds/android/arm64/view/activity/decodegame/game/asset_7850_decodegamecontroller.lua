local DecodeGameController = class("DecodeGameController")

function DecodeGameController:Ctor(arg_1_1)
	self.model = DecodeGameModel.New(self)
	self.view = DecodeGameView.New(self)

	return
end

function DecodeGameController:SetCallback(arg_2_1, arg_2_2, arg_2_3)
	self.exitCallBack = arg_2_1
	self.saveDataCallback = arg_2_2
	self.successCallback = arg_2_3

	return
end

function DecodeGameController:SetUp(arg_3_1)
	seriesAsync({
		function(arg_4_0)
			self.isIniting = true

			self.model:SetData(arg_3_1)
			self:UpdateProgress()
			self.view:UpdateCanUseCnt(self.model.canUseCnt)
			self:SwitchMap(self.model.map.id, arg_4_0())

			return
		end,
		function(arg_5_0)
			self:PlayVoice(DecodeGameConst.OPEN_DOOR_VOICE)
			self.view:DoEnterAnim(arg_5_0)

			return
		end,
		function(arg_6_0)
			pg.NewStoryMgr.GetInstance():Play(DecodeGameConst.STORYID, arg_6_0)

			return
		end,
		function(arg_7_0)
			self.view:ShowHelper(1, arg_7_0)

			return
		end,
		function(arg_8_0)
			self.isIniting = nil

			self:ShowTip()
			self.view:Inited(self.model.isFinished)

			return
		end
	})

	return
end

function DecodeGameController:ShowTip()
	local var_9_0 = self.model:GetUnlockMapCnt()
	local var_9_1

	if self.model.isFinished then
		var_9_1 = 0
	elseif var_9_0 < DecodeGameConst.MAX_MAP_COUNT and self.model.canUseCnt <= 0 then
		var_9_1 = 1
	elseif var_9_0 < DecodeGameConst.MAX_MAP_COUNT and self.model.canUseCnt > 0 then
		var_9_1 = 2
	elseif not self.isInDecodeMap and not self.isInComparison and var_9_0 == DecodeGameConst.MAX_MAP_COUNT then
		var_9_1 = 3
	elseif self.isInDecodeMap and not self.isInComparison and var_9_0 == DecodeGameConst.MAX_MAP_COUNT then
		var_9_1 = 4
	elseif self.isInDecodeMap and self.isInComparison and var_9_0 == DecodeGameConst.MAX_MAP_COUNT then
		var_9_1 = 5
	end

	self.view:ShowTip(var_9_1)

	return
end

function DecodeGameController:UpdateProgress(arg_10_1)
	local var_10_0, var_10_1 = self.model:GetPassWordProgress()

	arg_10_1 = arg_10_1 or function()
		return
	end

	if (self.finishCnt or 0) < var_10_1 and var_10_1 ~= #var_10_0 then
		self.finishCnt = var_10_1

		self:PlayVoice(DecodeGameConst.INCREASE_PASSWORD_PROGRESS_VOICE)
	end

	self.view:UpdateProgress(self.model:GetUnlockedCnt(), self.model:GetUnlockMapCnt(), var_10_0, arg_10_1)

	return
end

function DecodeGameController:SwitchMap(arg_12_1, arg_12_2)
	if self.inSwitching then
		return
	end

	if self.mapId ~= arg_12_1 then
		local function var_12_0(arg_13_0)
			parallelAsync({
				function(arg_14_0)
					if not self.isInDecodeMap then
						self.view:OnSwitchMap(arg_14_0)
					else
						arg_14_0()
					end

					return
				end,
				function(arg_15_0)
					if not self.mapId then
						arg_15_0()

						return
					end

					self.model:ExitMap()
					self.view:OnExitMap(self.mapId, self.isInDecodeMap, arg_15_0)

					return
				end,
				function(arg_16_0)
					self.mapId = nil

					self.model:SwitchMap(arg_12_1)
					self.view:UpdateMap(self.model.map)
					self.view:OnEnterMap(arg_12_1, self.isInDecodeMap, arg_16_0)

					return
				end
			}, arg_13_0)

			return
		end

		seriesAsync({
			function(arg_17_0)
				if not self.isIniting then
					self:PlayVoice(DecodeGameConst.SWITCH_MAP_VOCIE)
				end

				self.inSwitching = true

				var_12_0(arg_17_0)

				return
			end,
			function(arg_18_0)
				self.mapId = arg_12_1

				if not self.isInDecodeMap then
					arg_18_0()

					return
				end

				self.isInComparison = true

				self:PlayVoice(DecodeGameConst.SCAN_MAP_VOICE)
				self.view:OnDecodeMap(self.model.map, arg_18_0)

				return
			end,
			function(arg_19_0)
				self.inSwitching = nil

				if self.isInDecodeMap then
					self:ShowTip()
					self.view:ShowHelper(3, arg_19_0)
				else
					arg_19_0()
				end

				return
			end
		}, arg_12_2)
	end

	return
end

function DecodeGameController:Unlock(arg_20_1)
	if self.inSwitching then
		return
	end

	if self.isInDecodeMap then
		self:EnterPassWord(arg_20_1)
	else
		self:UnlockMapItem(arg_20_1)
	end

	return
end

function DecodeGameController:EnterPassWord(arg_21_1)
	if not self.model:IsMapKey(arg_21_1) then
		return
	end

	if self.model:IsUsedMapKey(arg_21_1) then
		return
	end

	if self.model:CheckIndex(arg_21_1) then
		self.model:InsertMapKey(arg_21_1)
		self.view:OnRightCode(arg_21_1, self.model:GetMapKeyStr(arg_21_1), (self.model:GetCurrMapKeyIndex(arg_21_1)))

		if self.model:IsSuccess() then
			self.model:Finish()
			self:PlayVoice(DecodeGameConst.GET_AWARD_DONE_VOICE)
			self.view:OnSuccess(function()
				pg.NewStoryMgr.GetInstance():Play(DecodeGameConst.LAST_STORYID)

				if self.successCallback then
					self.successCallback()
				end

				return
			end)
		else
			self:PlayVoice(DecodeGameConst.PASSWORD_IS_RIGHT_VOICE)
		end

		self:UpdateProgress()
	else
		self:PlayVoice(DecodeGameConst.PASSWORD_IS_FALSE_VOICE)
		self.view:OnFalseCode(arg_21_1)
	end

	return
end

function DecodeGameController:UnlockMapItem(arg_23_1)
	if self.model.canUseCnt > 0 and not self.model:IsUnlock(arg_23_1) then
		seriesAsync({
			function(arg_24_0)
				self.inSwitching = true

				self.model:UnlockMapItem(arg_23_1)
				self.view:UnlockMapItem(arg_23_1, arg_24_0)

				return
			end,
			function(arg_25_0)
				self:PlayStory(arg_25_0)

				return
			end,
			function(arg_26_0)
				self.view:UpdateCanUseCnt(self.model.canUseCnt)

				if self.model:IsUnlockMap(self.model.map.id) then
					self:RepairMap()
				else
					self:PlayVoice(DecodeGameConst.INCREASE_PROGRESS_VOICE)
					self:UpdateProgress()

					if self.saveDataCallback then
						self.saveDataCallback()
					end

					self.inSwitching = nil
				end

				self:ShowTip()
				arg_26_0()

				return
			end
		})
	end

	return
end

function DecodeGameController:PlayStory(arg_27_1)
	local var_27_0 = DecodeGameConst.UNLOCK_STORYID[self.model:GetUnlockedCnt()]

	if var_27_0 then
		pg.NewStoryMgr.GetInstance():Play(var_27_0, arg_27_1)
	else
		arg_27_1()
	end

	return
end

function DecodeGameController:RepairMap()
	seriesAsync({
		function(arg_29_0)
			self.model:OnRepairMap()
			self.view:OnMapRepairing(arg_29_0)

			return
		end,
		function(arg_30_0)
			if self.saveDataCallback then
				self.saveDataCallback(arg_30_0)
			else
				arg_30_0()
			end

			return
		end,
		function(arg_31_0)
			self:PlayVoice(DecodeGameConst.INCREASE_PROGRESS_VOICE)
			self.view:UpdateMap(self.model.map)
			self:UpdateProgress(arg_31_0)

			return
		end,
		function(arg_32_0)
			if self.model:GetUnlockMapCnt() == DecodeGameConst.MAX_MAP_COUNT then
				self.view:ShowHelper(2, arg_32_0)
			end

			self.inSwitching = nil

			return
		end
	})

	return
end

function DecodeGameController:CanSwitch()
	return not self.inSwitching
end

function DecodeGameController:SwitchToDecodeMap(arg_34_1)
	if self.inSwitching then
		return
	end

	if arg_34_1 then
		self:EnterDecodeMap()
	else
		self:ExitDeCodeMap()
	end

	return
end

function DecodeGameController:ExitDeCodeMap()
	self.isFirstSwitch = false

	seriesAsync({
		function(arg_36_0)
			self:PlayVoice(DecodeGameConst.PRESS_UP_PASSWORDBTN)

			self.finishCnt = 0
			self.isInComparison = nil
			self.inSwitching = true

			self.view:OnEnterNormalMapBefore(arg_36_0)

			return
		end,
		function(arg_37_0)
			parallelAsync({
				function(arg_38_0)
					self.view:OnEnterNormalMap(self.model.map, arg_38_0)

					return
				end,
				function(arg_39_0)
					self.mapId = self.model.map.id

					self.view:OnEnterMap(self.mapId, false, arg_39_0)

					return
				end
			}, arg_37_0)

			return
		end,
		function()
			self.model:ClearMapKeys()
			self:UpdateProgress()

			self.isInDecodeMap = nil
			self.inSwitching = nil

			self:ShowTip()

			return
		end
	})

	return
end

function DecodeGameController:EnterDecodeMap()
	self.isInDecodeMap = true
	self.isFirstSwitch = true

	seriesAsync({
		function(arg_42_0)
			self:PlayVoice(DecodeGameConst.PRESS_DOWN_PASSWORDBTN)

			self.inSwitching = true

			parallelAsync({
				function(arg_43_0)
					self.view:OnEnterDecodeMapBefore(arg_43_0)

					return
				end,
				function(arg_44_0)
					self.view:OnExitMap(self.mapId, true, arg_44_0)

					return
				end
			}, arg_42_0)

			return
		end,
		function(arg_45_0)
			self.mapId = nil

			self.view:OnEnterDecodeMap(self.model:GetMapKeyStrs(), arg_45_0)

			return
		end,
		function(arg_46_0)
			self:ShowTip()

			self.inSwitching = nil

			return
		end
	})

	return
end

function DecodeGameController:ExitGame()
	if self.inSwitching then
		return
	end

	if self.exitCallBack then
		self.exitCallBack()
	end

	return
end

function DecodeGameController:PlayVoice(arg_48_1)
	if arg_48_1 and arg_48_1 ~= "" then
		self.view:PlayVoice(arg_48_1)
	end

	return
end

function DecodeGameController:GetSaveData()
	return self.model.unlocks
end

function DecodeGameController:Dispose()
	self.model:Dispose()
	self.view:Dispose()

	return
end

return DecodeGameController
