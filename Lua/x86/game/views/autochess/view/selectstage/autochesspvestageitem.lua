local var_0_0 = class("AutoChessPVEStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.selectFunc_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitController()

	arg_3_0.stageID_ = 0
	arg_3_0.isChoosing_ = false
end

function var_0_0.InitController(arg_4_0)
	arg_4_0.btnController_ = arg_4_0.mainControllerEx_:GetController("btn")
	arg_4_0.lockController_ = arg_4_0.mainControllerEx_:GetController("lock")
	arg_4_0.colorController_ = arg_4_0.mainControllerEx_:GetController("Color")
	arg_4_0.progressingController_ = arg_4_0.mainControllerEx_:GetController("Progressing")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		if not AutoChessTools.IsStageUnlock(arg_5_0.stageID_) then
			ShowTips("AUTO_CHESS_LATTER_LEVEL_LOCKED")

			return
		end

		local var_6_0 = false
		local var_6_1 = AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE)

		if var_6_1 ~= AutoChessConst.GAME_STATUS.NONE then
			local var_6_2 = AutoChessData:GetPlayerData(AutoChessConst.GAME_TYPE.PVE)
			local var_6_3 = GameSetting.auto_chess_2_tutorial_stage_id.value[1]

			if var_6_2.stageID == var_6_3 then
				var_6_0 = true
			elseif var_6_2.stageID ~= arg_5_0.stageID_ then
				ShowTips("AUTO_CHESS_TIP_ONGOING_GAME")

				return
			end
		end

		if arg_5_0.isChoosing_ then
			saveData("auto_chess_pve_stage", "stage_id", arg_5_0.stageID_)

			if var_6_0 or var_6_1 == AutoChessConst.GAME_STATUS.NONE then
				arg_5_0:GotoStage()
			else
				AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.PVE, false, true)
			end
		elseif arg_5_0.selectFunc_ then
			arg_5_0.selectFunc_(arg_5_0.stageID_)

			if arg_5_0.index_ == 3 then
				arg_5_0.stageAnim_:Play("U_xuanzhong", 0, 0)
			else
				arg_5_0.stageAnim_:Play("U_xuanzhong_0", 0, 0)
			end
		end
	end)
end

function var_0_0.GotoStage(arg_7_0)
	local var_7_0 = AutoChessStageCfg[arg_7_0.stageID_]

	if var_7_0.pre_story and var_7_0.pre_story ~= 0 then
		manager.story:StartStoryById(var_7_0.pre_story, function(arg_8_0)
			JumpTools.OpenPageByJump("/autoChessPVEDialogueView", {
				stageID = arg_7_0.stageID_
			})
		end)
	else
		JumpTools.OpenPageByJump("/autoChessPVEDialogueView", {
			stageID = arg_7_0.stageID_
		})
	end
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.stageID_ = arg_9_1
	arg_9_0.index_ = arg_9_2

	arg_9_0:RefreshView()
end

function var_0_0.SelectDifficult(arg_10_0, arg_10_1)
	arg_10_0.firstDiff_ = true

	arg_10_0.btnController_:SetSelectedState("lock")

	arg_10_0.afterSelectFunc_ = arg_10_1
end

function var_0_0.RefreshView(arg_11_0)
	local var_11_0 = AutoChessStageCfg[arg_11_0.stageID_]

	if not var_11_0 then
		return
	end

	arg_11_0.nameText_.text = var_11_0.name

	arg_11_0.colorController_:SetSelectedIndex(var_11_0.is_challenge == 1 and 3 or var_11_0.area - 1)

	arg_11_0.heroImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Hero/OsirisHorus_Hero_" .. var_11_0.character)

	if AutoChessTools.IsStageUnlock(arg_11_0.stageID_) then
		if var_11_0.is_challenge ~= 0 then
			if arg_11_0.firstDiff_ then
				arg_11_0.firstDiff_ = false
				arg_11_0.unlockState_ = true

				arg_11_0.unlockAnim_:Play("U_Nd_jiesuo", 0, 0)

				local var_11_1 = 1

				arg_11_0.unlockDiffAnimTimer_ = Timer.New(function()
					if var_11_1 == 1 then
						arg_11_0.stageAnim_:Play("U_difficulty_cx", 0, 0)

						var_11_1 = var_11_1 + 1
					else
						arg_11_0:RefreshBtnView()
						Timer.New(function()
							local var_13_0 = var_11_0.area + 1

							if arg_11_0.afterSelectFunc_ and var_13_0 <= AutoChessAreaCfg.all[#AutoChessAreaCfg.all] then
								arg_11_0.afterSelectFunc_(var_13_0, true)
							end
						end, 0.8, 1):Start()
					end
				end, 0.8, 2)

				arg_11_0.unlockDiffAnimTimer_:Start()
			else
				arg_11_0.stageAnim_:Play("U_difficulty_cx", 0, 0)

				arg_11_0.unlockState_ = true

				arg_11_0:RefreshBtnView()
			end
		elseif (getData("auto_chess_stage_item", tostring(arg_11_0.stageID_)) or 0) ~= 0 then
			arg_11_0.unlockAnim_:Play("U_Nd_unlock", 0, 0)

			arg_11_0.unlockState_ = true

			arg_11_0:RefreshBtnView()
		else
			saveData("auto_chess_stage_item", tostring(arg_11_0.stageID_), 1)

			local var_11_2 = 1

			arg_11_0.unlockAnimTimer_ = Timer.New(function()
				if var_11_2 == 1 then
					var_11_2 = var_11_2 + 1
					arg_11_0.unlockState_ = true

					arg_11_0.unlockAnim_:Play("U_Nd_jiesuo", 0, 0)
				else
					arg_11_0:RefreshBtnView()
				end
			end, 0.8, 2)

			arg_11_0.unlockAnimTimer_:Start()
		end
	else
		arg_11_0.unlockAnim_:Play("U_Nd_lock", 0, 0)
		arg_11_0:RefreshBtnView()
	end
end

function var_0_0.RefreshBtnView(arg_15_0)
	local var_15_0 = AutoChessTools.GetStageState(arg_15_0.stageID_)
	local var_15_1 = AutoChessData:GetGameStatus(AutoChessConst.GAME_TYPE.PVE)

	arg_15_0.progressingController_:SetSelectedState("false")

	local var_15_2 = false

	if var_15_1 ~= AutoChessConst.GAME_STATUS.NONE then
		local var_15_3 = AutoChessData:GetPlayerData(AutoChessConst.GAME_TYPE.PVE)

		if var_15_3.stageID == arg_15_0.stageID_ then
			arg_15_0.progressingController_:SetSelectedState("true")
		else
			local var_15_4 = GameSetting.auto_chess_2_tutorial_stage_id.value[1]

			if var_15_3.stageID ~= var_15_4 then
				var_15_2 = true
			end
		end
	end

	if var_15_2 then
		arg_15_0.btnController_:SetSelectedState("stop")
	elseif var_15_0 == AutoChessConst.STAGE_STATE.UNLOCK then
		if arg_15_0.isChoosing_ then
			arg_15_0.btnController_:SetSelectedState("twogo")
		elseif arg_15_0.unlockState_ then
			arg_15_0.btnController_:SetSelectedState("onego")
		else
			arg_15_0.btnController_:SetSelectedState("lock")
		end
	elseif var_15_0 == AutoChessConst.STAGE_STATE.COMPLETED then
		if arg_15_0.isChoosing_ then
			arg_15_0.btnController_:SetSelectedState("twogo")
		elseif var_15_1 ~= AutoChessConst.GAME_STATUS.NONE then
			arg_15_0.btnController_:SetSelectedState("onego")
		else
			arg_15_0.btnController_:SetSelectedState("Completed")
		end
	elseif var_15_0 == AutoChessConst.STAGE_STATE.LOCK then
		arg_15_0.btnController_:SetSelectedState("lock")
	end
end

function var_0_0.SetSelect(arg_16_0, arg_16_1)
	if arg_16_0.stageID_ == arg_16_1 then
		arg_16_0.isChoosing_ = true

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_level", "")
	else
		arg_16_0.isChoosing_ = false
	end

	arg_16_0:RefreshBtnView()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.unlockAnimTimer_ then
		arg_17_0.unlockAnimTimer_:Stop()

		arg_17_0.unlockAnimTimer_ = nil
	end

	if arg_17_0.unlockDiffAnimTimer_ then
		arg_17_0.unlockDiffAnimTimer_:Stop()

		arg_17_0.unlockDiffAnimTimer_ = nil
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:StopTimer()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
