local var_0_0 = class("ActivityMatrixProcessView", MatrixProcessView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.eventList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexEventItem), arg_1_0.m_eventList, ActivityMatrixProcessEventItem)
	arg_1_0.rewardList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexRewardItem), arg_1_0.m_rewardList, ActivityMatrixProcessRewardItem)
	arg_1_0.incidentList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexIncidentItem), arg_1_0.m_incidentList, MatrixProcessIncidentItem)
	arg_1_0.phaseController_ = ControllerUtil.GetController(arg_1_0.m_phaseController, "phase")
	arg_1_0.hasGiveUpRewadController_ = ControllerUtil.GetController(arg_1_0.m_phaseController, "hasGiveUpRewad")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_rewardCommon, nil, function()
		ActivityMatrixAction.QueryNextProgress(arg_2_0.matrix_activity_id, {})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_rewardBtn, nil, function()
		arg_2_0:OnRewardAction()
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_eventBtn, nil, function()
		arg_2_0:OnEventAction()
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				ActivityMatrixAction.QueryMatrixGiveUp(arg_2_0.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_incidentBtn, nil, function()
		if arg_2_0.selectItemIndex == -1 then
			return
		end

		local var_9_0 = arg_2_0.incidentData[arg_2_0.selectItemIndex]

		ActivityMatrixAction.QueryNextProgress(arg_2_0.matrix_activity_id, {
			var_9_0
		})
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_10_0.matrix_activity_id)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.matrix_activity_id = arg_11_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_11_0)
end

function var_0_0.OnEventAction(arg_12_0)
	if arg_12_0.selectItemIndex == -1 then
		return
	end

	local var_12_0 = arg_12_0.phasesParams[arg_12_0.selectItemIndex]
	local var_12_1 = ActivityMatrixEventTemplateCfg[var_12_0]

	if not var_12_1 then
		print("ActivityMatrixEventTemplateCfg cant find event by id :" .. var_12_0)

		return
	end

	local var_12_2 = arg_12_0:GetMatrixPhaseData():GetPhase()

	if MatrixConst.EVENT_TYPE.SHOP == var_12_1.event_type or MatrixConst.EVENT_TYPE.INCIDENT == var_12_1.event_type then
		if var_12_2 == 2 then
			ActivityMatrixAction.DoEvent(arg_12_0.matrix_activity_id)
		else
			ActivityMatrixAction.QueryNextProgress(arg_12_0.matrix_activity_id, {
				var_12_0
			})
		end
	else
		local var_12_3 = var_12_1.params[1]

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX,
			section = var_12_3,
			eventId = var_12_0,
			matrix_activity_id = arg_12_0.matrix_activity_id,
			activityID = arg_12_0.matrix_activity_id
		})
	end
end

function var_0_0.OnRewardAction(arg_13_0)
	if arg_13_0.selectItemIndex == -1 then
		return
	end

	local var_13_0 = arg_13_0.phasesParams[arg_13_0.selectItemIndex]
	local var_13_1 = var_13_0 and MatrixItemCfg[var_13_0]

	if not var_13_1 then
		print("MatrixItemCfg cant find item by id :" .. var_13_0)

		return
	end

	local var_13_2 = var_13_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_13_2 then
		local var_13_3 = math.floor(var_13_1.params[1] / 1000)
		local var_13_4 = arg_13_0:GetHeroData(var_13_3)
		local var_13_5 = var_13_4:GetAstrolabeList()

		if var_13_4:GetAstrolabeNum(var_13_1.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if arg_13_0:GetAstrolabeMaxCount() <= #var_13_5 then
			JumpTools.OpenPageByJump("activityMatrixProcessAstrolabeReplace", {
				heroId = var_13_3,
				astrolabeId = var_13_0,
				callback = function(arg_14_0)
					ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
						var_13_0,
						arg_14_0,
						var_13_4:GetStandardId()
					})
				end
			})
		else
			ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
				var_13_0,
				0,
				var_13_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_13_2 then
		local var_13_6 = arg_13_0:GetMatrixHeroTeam()

		if #var_13_6 == 1 then
			local var_13_7 = var_13_6[1]
			local var_13_8 = arg_13_0:GetHeroData(var_13_7)
			local var_13_9 = var_13_8:GetEquipList()

			if arg_13_0:GetHeroEquipMaxCount() <= #var_13_9 then
				JumpTools.OpenPageByJump("activityMatrixProcessEquipReplace", {
					heroId = var_13_7,
					equipId = var_13_0,
					callback = function(arg_15_0)
						ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
							var_13_0,
							arg_15_0,
							var_13_8:GetStandardId()
						})
					end
				})
			else
				ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
					var_13_0,
					0,
					var_13_8:GetStandardId()
				})
			end
		else
			JumpTools.OpenPageByJump("activityMatrixProcessSelectHero", {
				id = var_13_0
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_13_2 then
		local var_13_10 = MatrixTools.GetWeaponSpecHero(var_13_1.params[1])
		local var_13_11 = arg_13_0:GetMatrixHeroTeam()

		if var_13_10 == 0 and #var_13_11 == 1 then
			var_13_10 = var_13_11[1]
		end

		if var_13_10 == 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessSelectHero", {
				id = var_13_0
			})
		else
			local var_13_12 = arg_13_0:GetHeroData(var_13_10)
			local var_13_13 = var_13_12:GetWeaponServant()

			if var_13_13 ~= 0 then
				JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
					heroId = var_13_10,
					weaponId = var_13_0,
					callback = function()
						ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
							var_13_0,
							var_13_13,
							var_13_12:GetStandardId()
						})
					end
				})
			else
				ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
					var_13_0,
					0,
					var_13_12:GetStandardId()
				})
			end
		end
	else
		ActivityMatrixAction.QueryNextProgress(arg_13_0.matrix_activity_id, {
			var_13_0
		})
	end
end

function var_0_0.indexRewardItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:SetMatrixActivityId(arg_17_0.matrix_activity_id)
	var_0_0.super.indexRewardItem(arg_17_0, arg_17_1, arg_17_2)
end

function var_0_0.indexEventItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.phasesParams[arg_18_1]

	arg_18_2:RegistCallBack(handler(arg_18_0, arg_18_0.OnEvengtItemClick))
	arg_18_2:Refresh(var_18_0, arg_18_1, arg_18_0.matrix_activity_id)
	arg_18_2:SetSelected(arg_18_1 == arg_18_0.selectItemIndex)
end

function var_0_0.GetGameState(arg_19_0)
	return ActivityMatrixData:GetGameState(arg_19_0.matrix_activity_id)
end

function var_0_0.GetHeroData(arg_20_0, arg_20_1)
	return ActivityMatrixData:GetHeroData(arg_20_0.matrix_activity_id, arg_20_1)
end

function var_0_0.GetAstrolabeMaxCount(arg_21_0)
	return ActivityMatrixData:GetAstrolabeMaxCount(arg_21_0.matrix_activity_id)
end

function var_0_0.GetMatrixPhaseData(arg_22_0)
	return ActivityMatrixData:GetMatrixPhaseData(arg_22_0.matrix_activity_id)
end

function var_0_0.GetDifficulty(arg_23_0)
	return 1
end

function var_0_0.GetTierID(arg_24_0)
	return ActivityMatrixData:GetTierID(arg_24_0.matrix_activity_id)
end

function var_0_0.GetTierDes(arg_25_0)
	local var_25_0 = ActivityMatrixData:GetTierID(arg_25_0.matrix_activity_id)
	local var_25_1 = ActivityMatrixTierTemplateCfg[var_25_0]

	return string.format("%s-%s", var_25_1.tier, var_25_1.level)
end

function var_0_0.GetMatrixHeroTeam(arg_26_0)
	return ActivityMatrixData:GetMatrixHeroTeam(arg_26_0.matrix_activity_id)
end

function var_0_0.GetHeroEquipMaxCount(arg_27_0)
	return ActivityMatrixData:GetHeroEquipMaxCount(arg_27_0.matrix_activity_id)
end

return var_0_0
