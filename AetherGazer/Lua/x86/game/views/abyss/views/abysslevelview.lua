local var_0_0 = class("AbyssLevelView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.isBossController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "isBoss")
	arg_3_0.difficultyController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "difficulty")
	arg_3_0.resetGrayedController_ = ControllerUtil.GetController(arg_3_0.resetBtn_.transform, "grayed")
	arg_3_0.completeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "complete")
	arg_3_0.lockList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexLockItem), arg_3_0.lockListGo_, AbyssHeroItemView)
	arg_3_0.abandonList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexAbandonItem), arg_3_0.abandonListGo_, AbyssHeroItemView)
	arg_3_0.monsterList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexMonsterItem), arg_3_0.monsterListGo_, AbyssMonsterItemView)
end

function var_0_0.IndexLockItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.lockedHeroList_[arg_4_1])
end

function var_0_0.IndexAbandonItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.abandonHeroList_[arg_5_1])
end

function var_0_0.IndexMonsterItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.monsterIdList_[arg_6_1])
	arg_6_2:RegisterClickListener(handler(arg_6_0, arg_6_0.OnMonsterClick))
end

function var_0_0.OnMonsterClick(arg_7_0)
	JumpTools.OpenPageByJump("abyssBossDetail", {
		bossIdList = arg_7_0.monsterIdList_
	})
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bossHeadBtn_, nil, function()
		JumpTools.OpenPageByJump("abyssBossDetail", {
			bossIdList = arg_8_0.monsterIdList_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.challengeBtn_, nil, function()
		local var_10_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.ABYSS, arg_8_0.stageCfg_[2], arg_8_0:GetTeamIndex(), {
			stageType = BattleConst.STAGE_TYPE_NEW.ABYSS,
			stageID = arg_8_0.stageCfg_[2],
			layer = arg_8_0.layer_
		})

		gameContext:Go("/sectionSelectHero", {
			section = arg_8_0.stageCfg_[2],
			sectionType = BattleConst.STAGE_TYPE_NEW.ABYSS,
			layer = arg_8_0.layer_,
			stageIndex = arg_8_0.stageIndex_,
			curActivityID = AbyssData:GetActivityId(),
			activityID = arg_8_0.stageCfg_[2],
			reserveParams = var_10_0
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.resetBtn_, nil, function()
		if AbyssData:GetStageResetTime() <= 0 then
			ShowTips("ABYSS_STAGE_RESET_CLICK_TIP")

			return
		end

		local var_11_0 = AbyssData:GetCurrentLayer()

		if AbyssData:HaveUpperLevelChallenging(arg_8_0.layer_) then
			local var_11_1 = var_11_0

			if AbyssData:GetLayerStatus(var_11_0) == 1 then
				var_11_1 = var_11_0 - 1
			end

			ShowTips(string.format(GetTips("ABYSS_STAGE_CHALLENGING_RESET_TIP"), var_11_1))

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ABYSS_STAGE_RESET_TIP"),
			SecondTip = GetTips("ABYSS_STAGE_RESET_TIMES"),
			SecondValue = AbyssData:GetStageResetTime() .. "/" .. AbyssData:GetStageResetLimit(),
			OkCallback = function(arg_12_0)
				if arg_12_0 ~= AbyssData:GetActivityId() then
					ShowTips("ERROR_ACTIVITY_NOT_OPEN")

					return
				end

				AbyssAction.ResetStage(arg_8_0.layer_, arg_8_0.stageIndex_, arg_8_0.battleAbyssCfg_.id)
			end,
			CancelCallback = function()
				return
			end,
			Param = AbyssData:GetActivityId()
		})
	end)
end

function var_0_0.AddEventListeners(arg_14_0)
	arg_14_0:RegistEventListener(ABYSS_LAYER_RESET_TIME_UPDATE, function(arg_15_0)
		if arg_15_0 == arg_14_0.layer_ then
			arg_14_0:UpdateView()
		end
	end)
	arg_14_0:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function(arg_16_0, arg_16_1)
		if arg_16_0 == arg_14_0.layer_ and arg_16_1 == arg_14_0.stageCfg_[2] then
			ShowTips("ABYSS_RESET_STAGE_FINISH_TIP")
			arg_14_0:UpdateView()
		end
	end)
end

function var_0_0.SetData(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.layer_ = arg_17_1
	arg_17_0.stageIndex_ = arg_17_2
	arg_17_0.abyssCfg_ = AbyssData:GetAbyssCfg(arg_17_1)
	arg_17_0.stageCfg_ = arg_17_0.abyssCfg_.stage_list[arg_17_0.stageIndex_]
	arg_17_0.stageId_ = arg_17_0.stageCfg_[2]
	arg_17_0.battleAbyssCfg_ = BattleAbyssCfg[arg_17_0.stageCfg_[2]]
	arg_17_0.monsterIdList_ = arg_17_0.abyssCfg_.stage_target[arg_17_0.stageIndex_]

	arg_17_0:UpdateView()
end

function var_0_0.UpdateView(arg_18_0)
	if arg_18_0.stageCfg_[1] == 3 then
		arg_18_0.abandonHeroList_ = AbyssTools.GetStageBanHeroList(arg_18_0.layer_, arg_18_0.stageIndex_)
	end

	arg_18_0.monsterList_:StartScroll(#arg_18_0.monsterIdList_)
	arg_18_0.difficultyController_:SetSelectedState(tostring(arg_18_0.stageCfg_[1]))

	arg_18_0.descLabel_.text = GetI18NText(arg_18_0.battleAbyssCfg_.tips)

	if arg_18_0.stageCfg_[1] == 3 then
		local var_18_0 = AbyssUICfg[arg_18_0.monsterIdList_[1]]

		arg_18_0.bossImage_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_18_0.enemy_id)

		if var_18_0 ~= nil then
			if var_18_0.icon_pos ~= nil and var_18_0.icon_pos ~= "" and #var_18_0.icon_pos > 0 then
				arg_18_0.bossImage_.transform.anchoredPosition = Vector3(var_18_0.icon_pos[1], var_18_0.icon_pos[2], var_18_0.icon_pos[3])
			end

			if var_18_0.icon_scale ~= nil and var_18_0.icon_scale ~= "" and #var_18_0.icon_scale > 0 then
				arg_18_0.bossImage_.transform.localScale = Vector3(var_18_0.icon_scale[1], var_18_0.icon_scale[2], var_18_0.icon_scale[3])
			end

			if var_18_0.icon_rot ~= nil and var_18_0.icon_rot ~= "" and #var_18_0.icon_rot > 0 then
				arg_18_0.bossImage_.transform.localEulerAngles = Vector3(var_18_0.icon_rot[1], var_18_0.icon_rot[2], var_18_0.icon_rot[3])
			end
		end

		arg_18_0.isBossController_:SetSelectedState("true")
	else
		arg_18_0.isBossController_:SetSelectedState("false")
	end

	if AbyssData:IsLayerUnlock(arg_18_0.layer_) then
		arg_18_0.stageData_ = AbyssData:GetStageData(arg_18_0.abyssCfg_.level, arg_18_0.stageIndex_)
		arg_18_0.lockedHeroList_ = AbyssTools.GetStageLockHeroList(arg_18_0.abyssCfg_.level, arg_18_0.stageIndex_)

		if arg_18_0.stageData_.is_completed then
			arg_18_0.completeController_:SetSelectedState("true")

			arg_18_0.scoreLabel_.text = AbyssData:GetStageScore(arg_18_0.abyssCfg_.level, arg_18_0.stageIndex_)
		elseif arg_18_0.stageCfg_[1] == 3 then
			if #arg_18_0.abandonHeroList_ > 0 then
				arg_18_0.completeController_:SetSelectedState("challenging")
			else
				arg_18_0.completeController_:SetSelectedState("false")
			end
		else
			arg_18_0.completeController_:SetSelectedState("false")
		end

		if arg_18_0.stageCfg_[1] == 3 then
			arg_18_0.abandonList_:StartScroll(#arg_18_0.abandonHeroList_)

			local var_18_1 = AbyssData:GetStageData(arg_18_0.layer_, arg_18_0.stageIndex_)
			local var_18_2 = AbyssData:ConvertPhaseBossHpToTotal(arg_18_0.stageId_, var_18_1.phase, var_18_1.boss_hp_rate) / AbyssData:GetBossTotalHp(arg_18_0.stageId_)

			arg_18_0.hpPercentLabel_.text = math.ceil(100 * var_18_2)
			arg_18_0.bossHpSlider_.value = var_18_2
		else
			arg_18_0.isBossController_:SetSelectedState("false")
		end

		arg_18_0.lockList_:StartScroll(#arg_18_0.lockedHeroList_)
	else
		arg_18_0.abandonList_:StartScroll(0)

		if arg_18_0.stageCfg_[1] == 3 then
			arg_18_0.hpPercentLabel_.text = math.ceil(100)
			arg_18_0.bossHpSlider_.value = 1
		end

		arg_18_0.completeController_:SetSelectedState("not_open")
	end

	if AbyssData:GetStageResetTime() <= 0 then
		arg_18_0.resetGrayedController_:SetSelectedState("true")
	else
		arg_18_0.resetGrayedController_:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0:AddEventListeners()
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_21_0)
	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.data_ = nil

	if arg_22_0.lockList_ then
		arg_22_0.lockList_:Dispose()

		arg_22_0.lockList_ = nil
	end

	if arg_22_0.abandonList_ then
		arg_22_0.abandonList_:Dispose()

		arg_22_0.abandonList_ = nil
	end

	if arg_22_0.monsterList_ then
		arg_22_0.monsterList_:Dispose()

		arg_22_0.monsterList_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.GetTeamIndex(arg_23_0)
	return AbyssTools.GetTeamIndex(arg_23_0.layer_, arg_23_0.stageIndex_)
end

return var_0_0
