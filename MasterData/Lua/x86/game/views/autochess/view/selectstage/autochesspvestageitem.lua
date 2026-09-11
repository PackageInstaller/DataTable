local AutoChessPVEStageItem = class("AutoChessPVEStageItem", ReduxView)

function AutoChessPVEStageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.selectFunc_ = arg_1_2

	self:Init()
end

function AutoChessPVEStageItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessPVEStageItem:InitUI()
	self:BindCfgUI()
	self:InitController()

	self.stageID_ = 0
	self.isChoosing_ = false
end

function AutoChessPVEStageItem:InitController()
	self.btnController_ = self.mainControllerEx_:GetController("btn")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.colorController_ = self.mainControllerEx_:GetController("Color")
	self.progressingController_ = self.mainControllerEx_:GetController("Progressing")
end

function AutoChessPVEStageItem:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not AutoChessTools.IsStageUnlock(self.stageID_) then
			ShowTips("AUTO_CHESS_LATTER_LEVEL_LOCKED")

			return
		end

		local var_6_0 = false
		local var_6_1 = AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE)

		if var_6_1 ~= AutoChessConst.GAME_STATUS.NONE then
			local var_6_2 = AutoChessData:GetPlayerData(AutoChessConst.GAME_TYPE.PVE)

			if var_6_2.stageID == GameSetting.auto_chess_2_tutorial_stage_id.value[1] then
				var_6_0 = true
			elseif var_6_2.stageID ~= self.stageID_ then
				ShowTips("AUTO_CHESS_TIP_ONGOING_GAME")

				return
			end
		end

		if self.isChoosing_ then
			saveData("auto_chess_pve_stage", "stage_id", self.stageID_)

			if var_6_0 or var_6_1 == AutoChessConst.GAME_STATUS.NONE then
				self:GotoStage()
			else
				AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVE, false, true)
			end
		elseif self.selectFunc_ then
			self.selectFunc_(self.stageID_)

			if self.index_ == 3 then
				self.stageAnim_:Play("U_xuanzhong", 0, 0)
			else
				self.stageAnim_:Play("U_xuanzhong_0", 0, 0)
			end
		end
	end)
end

function AutoChessPVEStageItem:GotoStage()
	if AutoChessStageCfg[self.stageID_].pre_story and AutoChessStageCfg[self.stageID_].pre_story ~= 0 then
		manager.story:StartStoryById(AutoChessStageCfg[self.stageID_].pre_story, function(arg_8_0)
			JumpTools.OpenPageByJump("/autoChessPVEDialogueView", {
				stageID = self.stageID_
			})
		end)
	else
		JumpTools.OpenPageByJump("/autoChessPVEDialogueView", {
			stageID = self.stageID_
		})
	end
end

function AutoChessPVEStageItem:SetData(arg_9_1, arg_9_2)
	self.stageID_ = arg_9_1
	self.index_ = arg_9_2

	self:RefreshView()
end

function AutoChessPVEStageItem:SelectDifficult(arg_10_1)
	self.firstDiff_ = true

	self.btnController_:SetSelectedState("lock")

	self.afterSelectFunc_ = arg_10_1
end

function AutoChessPVEStageItem:RefreshView()
	local var_11_0 = AutoChessStageCfg[self.stageID_]

	if not AutoChessStageCfg[self.stageID_] then
		return
	end

	self.nameText_.text = var_11_0.name

	self.colorController_:SetSelectedIndex(var_11_0.is_challenge == 1 and 3 or var_11_0.area - 1)

	self.heroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Hero/OsirisHorus_Hero_" .. var_11_0.character)

	if AutoChessTools.IsStageUnlock(self.stageID_) then
		if var_11_0.is_challenge ~= 0 then
			if self.firstDiff_ then
				self.firstDiff_ = false
				self.unlockState_ = true

				self.unlockAnim_:Play("U_Nd_jiesuo", 0, 0)

				local var_11_1 = 1

				self.unlockDiffAnimTimer_ = Timer.New(function()
					if var_11_1 == 1 then
						self.stageAnim_:Play("U_difficulty_cx", 0, 0)

						var_11_1 = var_11_1 + 1
					else
						self:RefreshBtnView()
						Timer.New(function()
							if self.afterSelectFunc_ and var_11_0.area + 1 <= AutoChessAreaCfg.all[#AutoChessAreaCfg.all] then
								self.afterSelectFunc_(var_11_0.area + 1, true)
							end
						end, 0.8, 1):Start()
					end
				end, 0.8, 2)

				self.unlockDiffAnimTimer_:Start()
			else
				self.stageAnim_:Play("U_difficulty_cx", 0, 0)

				self.unlockState_ = true

				self:RefreshBtnView()
			end
		elseif (getData("auto_chess_stage_item", tostring(self.stageID_)) or 0) ~= 0 then
			self.unlockAnim_:Play("U_Nd_unlock", 0, 0)

			self.unlockState_ = true

			self:RefreshBtnView()
		else
			saveData("auto_chess_stage_item", tostring(self.stageID_), 1)

			local var_11_2 = 1

			self.unlockAnimTimer_ = Timer.New(function()
				if var_11_2 == 1 then
					var_11_2 = var_11_2 + 1
					self.unlockState_ = true

					self.unlockAnim_:Play("U_Nd_jiesuo", 0, 0)
				else
					self:RefreshBtnView()
				end
			end, 0.8, 2)

			self.unlockAnimTimer_:Start()
		end
	else
		self.unlockAnim_:Play("U_Nd_lock", 0, 0)
		self:RefreshBtnView()
	end
end

function AutoChessPVEStageItem:RefreshBtnView()
	local var_15_0 = AutoChessTools.GetStageState(self.stageID_)
	local var_15_1 = AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE)

	self.progressingController_:SetSelectedState("false")

	local var_15_2 = false

	if var_15_1 ~= AutoChessConst.GAME_STATUS.NONE then
		local var_15_3 = AutoChessData:GetPlayerData(AutoChessConst.GAME_TYPE.PVE)

		if var_15_3.stageID == self.stageID_ then
			self.progressingController_:SetSelectedState("true")
		elseif var_15_3.stageID ~= GameSetting.auto_chess_2_tutorial_stage_id.value[1] then
			var_15_2 = true
		end
	end

	if var_15_2 then
		self.btnController_:SetSelectedState("stop")
	elseif var_15_0 == AutoChessConst.STAGE_STATE.UNLOCK then
		if self.isChoosing_ then
			self.btnController_:SetSelectedState("twogo")
		elseif self.unlockState_ then
			self.btnController_:SetSelectedState("onego")
		else
			self.btnController_:SetSelectedState("lock")
		end
	elseif var_15_0 == AutoChessConst.STAGE_STATE.COMPLETED then
		if self.isChoosing_ then
			self.btnController_:SetSelectedState("twogo")
		elseif var_15_1 ~= AutoChessConst.GAME_STATUS.NONE then
			self.btnController_:SetSelectedState("onego")
		else
			self.btnController_:SetSelectedState("Completed")
		end
	elseif var_15_0 == AutoChessConst.STAGE_STATE.LOCK then
		self.btnController_:SetSelectedState("lock")
	end
end

function AutoChessPVEStageItem:SetSelect(arg_16_1)
	if self.stageID_ == arg_16_1 then
		self.isChoosing_ = true

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_level", "")
	else
		self.isChoosing_ = false
	end

	self:RefreshBtnView()
end

function AutoChessPVEStageItem:StopTimer()
	if self.unlockAnimTimer_ then
		self.unlockAnimTimer_:Stop()

		self.unlockAnimTimer_ = nil
	end

	if self.unlockDiffAnimTimer_ then
		self.unlockDiffAnimTimer_:Stop()

		self.unlockDiffAnimTimer_ = nil
	end
end

function AutoChessPVEStageItem:Dispose()
	self:StopTimer()
	AutoChessPVEStageItem.super.Dispose(self)
end

return AutoChessPVEStageItem
