local var_0_0 = class("AbyssLevelItemView", ReduxView)

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

	arg_3_0.difficultyController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "difficulty")
	arg_3_0.unlockController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "unlock")
	arg_3_0.bossStatusController_ = ControllerUtil.GetController(arg_3_0.winGo_.transform, "Challengestatus")
	arg_3_0.challengeStatusController_ = ControllerUtil.GetController(arg_3_0.winGo_.transform, "Challengestatus1")
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.winGo_.transform, "select")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.lockListGo_, AbyssHeroItemView)
	arg_3_0.abandonUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexAbandonItem), arg_3_0.abandonListGo_, AbyssHeroItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = AbyssData:GetStageData(arg_4_0.cfg_.level, arg_4_0.index_)

	arg_4_2:SetData(arg_4_1, arg_4_0.lockHeroIDList_[arg_4_1])
end

function var_0_0.indexAbandonItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.abandonIdList_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function(arg_8_0, arg_8_1)
		if arg_7_0.cfg_ == nil then
			return
		end

		if arg_8_0 == arg_7_0.cfg_.level and arg_8_1 == arg_7_0.stageId_ then
			arg_7_0:UpdateView()
		end
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.cfg_ = arg_9_1
	arg_9_0.index_ = arg_9_2
	arg_9_0.stageCfg_ = arg_9_0.cfg_.stage_list[arg_9_2]
	arg_9_0.stageType_ = arg_9_0.stageCfg_[1]
	arg_9_0.stageId_ = arg_9_0.stageCfg_[2]
	arg_9_0.score_ = arg_9_0.stageCfg_[3]

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.difficultyController_:SetSelectedState(tostring(arg_10_0.stageCfg_[1]))

	if AbyssData:IsLayerUnlock(arg_10_0.cfg_.level) then
		arg_10_0.unlockController_:SetSelectedState("true")

		local var_10_0 = AbyssData:GetStageData(arg_10_0.cfg_.level, arg_10_0.index_)

		arg_10_0.scoreLabel_.text = AbyssData:GetStageScore(arg_10_0.cfg_.level, arg_10_0.index_)

		if var_10_0.is_completed then
			arg_10_0.challengeStatusController_:SetSelectedState("lock")

			if arg_10_0.index_ == 3 then
				CustomLog.Log(debug.traceback(string.format("3")))
			end

			arg_10_0.lockHeroIDList_ = AbyssTools.GetStageLockHeroList(arg_10_0.cfg_.level, arg_10_0.index_)

			arg_10_0.uiList_:StartScroll(#arg_10_0.lockHeroIDList_)
		else
			arg_10_0.challengeStatusController_:SetSelectedState("no")
		end

		if arg_10_0.stageType_ == 3 then
			local var_10_1 = AbyssData:GetStageData(arg_10_0.cfg_.level, arg_10_0.index_)
			local var_10_2 = AbyssData:ConvertPhaseBossHpToTotal(arg_10_0.stageId_, var_10_1.phase, var_10_1.boss_hp_rate) / AbyssData:GetBossTotalHp(arg_10_0.stageId_)

			arg_10_0.hpPercentLabel_.text = math.ceil(100 * var_10_2)
			arg_10_0.bossHpSlider_.value = var_10_2
			arg_10_0.abandonIdList_ = AbyssTools.GetStageBanHeroList(arg_10_0.cfg_.level, arg_10_0.index_)

			if #arg_10_0.abandonIdList_ > 0 then
				arg_10_0.abandonUIList_:StartScroll(#arg_10_0.abandonIdList_)
				arg_10_0.bossStatusController_:SetSelectedState("boss")
			else
				arg_10_0.bossStatusController_:SetSelectedState("boss_1")
			end
		else
			arg_10_0.bossStatusController_:SetSelectedState("normal")
		end
	else
		arg_10_0.unlockController_:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.SetSelect(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.selectController_:SetSelectedState("select_1")
	else
		arg_14_0.selectController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.data_ = nil

	if arg_15_0.uiList_ then
		arg_15_0.uiList_:Dispose()

		arg_15_0.uiList_ = nil
	end

	if arg_15_0.abandonUIList_ then
		arg_15_0.abandonUIList_:Dispose()

		arg_15_0.abandonUIList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
