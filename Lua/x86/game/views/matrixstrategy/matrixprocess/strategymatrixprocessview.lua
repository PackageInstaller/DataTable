local var_0_0 = class("StrategyMatrixProcessView", MatrixProcessView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/MatrixlUI/StrategyMatrixProcessUI"
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexRewardItem), arg_3_0.m_rewardList, StrategyMatrixProcessRewardItem)
	arg_3_0.incidentList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexIncidentItem), arg_3_0.m_incidentList, MatrixProcessIncidentItem)
	arg_3_0.phaseController_ = ControllerUtil.GetController(arg_3_0.m_phaseController, "phase")
	arg_3_0.hasGiveUpRewadController_ = ControllerUtil.GetController(arg_3_0.m_phaseController, "hasGiveUpRewad")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_rewardCommon, nil, function()
		StrategyMatrixAction.QueryNextProgress(arg_4_0.matrix_activity_id, {})
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_rewardBtn, nil, function()
		arg_4_0:OnRewardAction()
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				StrategyMatrixAction.QueryMatrixGiveUp(arg_4_0.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_incidentBtn, nil, function()
		if arg_4_0.selectItemIndex == -1 then
			return
		end

		local var_10_0 = arg_4_0.incidentData[arg_4_0.selectItemIndex]

		StrategyMatrixAction.QueryNextProgress(arg_4_0.matrix_activity_id, {
			var_10_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_infoBtn, nil, function()
		local var_11_0 = StrategyMatrixData:GetMatrixHeroTeam(arg_4_0.matrix_activity_id)

		JumpTools.OpenPageByJump("/strategyMatrixHero_new", {
			isEnter = true,
			matrix_activity_id = arg_4_0.matrix_activity_id,
			type = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX,
			tempHeroList = var_11_0,
			hid = var_11_0[1]
		})
	end)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(arg_12_0.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_12_0.matrix_activity_id)
end

function var_0_0.OnEnter(arg_13_0)
	manager.ui:SetMainCamera("hero")

	arg_13_0.matrix_activity_id = arg_13_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_13_0)
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function var_0_0.Refresh(arg_15_0, arg_15_1)
	arg_15_0.phaseData = arg_15_0:GetMatrixPhaseData()
	arg_15_0.phasesParams = clone(arg_15_0.phaseData:GetParams())
	arg_15_0.matrixGiveUpItemId = arg_15_0.phaseData:GetGiveUpItemId()
	arg_15_0.incidentData = {}
	arg_15_0.selectItemIndex = -1
	arg_15_0.m_rewardBtn.interactable = false
	arg_15_0.m_eventBtn.interactable = false
	arg_15_0.m_incidentBtn.interactable = false

	local var_15_0 = arg_15_0.phaseData:GetPhase()

	if var_15_0 == 1 then
		arg_15_0.phaseController_:SetSelectedIndex(1)
	elseif var_15_0 == 2 then
		local var_15_1 = arg_15_0.phasesParams[1]
		local var_15_2 = StrategyMatrixEventTemplateCfg[var_15_1]

		if MatrixConst.EVENT_TYPE.INCIDENT == var_15_2.event_type then
			local var_15_3 = arg_15_0.phaseData:GetData()

			arg_15_0.incidentData = {}

			local var_15_4 = StrategyMatrixChanceCfg.get_id_list_by_title_id[var_15_3]

			for iter_15_0, iter_15_1 in ipairs(var_15_4) do
				local var_15_5 = StrategyMatrixChanceCfg[iter_15_1]

				table.insert(arg_15_0.incidentData, var_15_5.option)
			end

			arg_15_0.m_incidentTitle.text = MatrixDescCfg[var_15_3] and GetI18NText(MatrixDescCfg[var_15_3].desc) or ""

			arg_15_0.phaseController_:SetSelectedIndex(3)
			arg_15_0.incidentList_:StartScroll(#arg_15_0.incidentData)
		elseif not arg_15_1 then
			arg_15_0.phaseController_:SetSelectedIndex(0)
		end
	elseif var_15_0 == 3 then
		if arg_15_0.matrixGiveUpItemId and arg_15_0.matrixGiveUpItemId ~= 0 then
			arg_15_0.hasGiveUpRewadController_:SetSelectedIndex(1)

			local var_15_6 = MatrixItemCfg[arg_15_0.matrixGiveUpItemId]

			if MatrixConst.ITEM_TYPE.ITEM == var_15_6.matrix_item_type and #var_15_6.params > 0 then
				local var_15_7 = var_15_6.params[1][1]
				local var_15_8 = var_15_6.params[1][2]

				if var_15_7 == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN then
					var_15_8 = var_15_8 * (1 + arg_15_0:GetGiveUpRewardAddition())
				end

				arg_15_0.m_rewardCommonText.text = string.format(GetTips("MATRIX_GET"), var_15_8, GetI18NText(var_15_6.name))
			else
				arg_15_0.m_rewardCommonText.text = GetI18NText(var_15_6.desc)
			end
		else
			arg_15_0.hasGiveUpRewadController_:SetSelectedIndex(0)
		end

		arg_15_0.phaseController_:SetSelectedIndex(2)
		arg_15_0.rewardList_:StartScroll(#arg_15_0.phasesParams)
	else
		arg_15_0.phaseController_:SetSelectedIndex(0)
	end

	local var_15_9 = arg_15_0:GetDifficulty()

	arg_15_0.m_difficultyLab.text = var_15_9 == 1 and GetTips("HARDLEVEL_EASY") or GetTips("HARDLEVEL_HARD")
	arg_15_0.m_tierLab.text = arg_15_0:GetTierDes()
end

function var_0_0.OnRewardAction(arg_16_0)
	if arg_16_0.selectItemIndex == -1 then
		return
	end

	local var_16_0 = arg_16_0.phasesParams[arg_16_0.selectItemIndex]
	local var_16_1 = var_16_0 and MatrixItemCfg[var_16_0]

	if not var_16_1 then
		print("MatrixItemCfg cant find item by id :" .. var_16_0)

		return
	end

	local var_16_2 = var_16_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_16_2 then
		local var_16_3 = math.floor(var_16_1.params[1] / 1000)
		local var_16_4 = arg_16_0:GetHeroData(var_16_3)
		local var_16_5 = var_16_4:GetAstrolabeList()

		if var_16_4:GetAstrolabeNum(var_16_1.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if arg_16_0:GetAstrolabeMaxCount() <= #var_16_5 then
			JumpTools.OpenPageByJump("strategyMatrixProcessAstrolabeReplace", {
				heroId = var_16_3,
				astrolabeId = var_16_0,
				callback = function(arg_17_0)
					StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
						var_16_0,
						arg_17_0,
						var_16_4:GetStandardId()
					})
				end
			})
		else
			StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
				var_16_0,
				0,
				var_16_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_16_2 then
		local var_16_6 = arg_16_0:GetMatrixHeroTeam()

		if #var_16_6 == 1 then
			local var_16_7 = var_16_6[1]
			local var_16_8 = arg_16_0:GetHeroData(var_16_7)
			local var_16_9 = var_16_8:GetEquipList()

			if arg_16_0:GetHeroEquipMaxCount() <= #var_16_9 then
				JumpTools.OpenPageByJump("strategyMatrixProcessEquipReplace", {
					heroId = var_16_7,
					equipId = var_16_0,
					callback = function(arg_18_0)
						StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
							var_16_0,
							arg_18_0,
							var_16_8:GetStandardId()
						})
					end
				})
			else
				StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
					var_16_0,
					0,
					var_16_8:GetStandardId()
				})
			end
		else
			JumpTools.OpenPageByJump("strategyMatrixProcessSelectHero", {
				id = var_16_0
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_16_2 then
		local var_16_10 = MatrixTools.GetWeaponSpecHero(var_16_1.params[1])
		local var_16_11 = arg_16_0:GetMatrixHeroTeam()

		if var_16_10 == 0 and #var_16_11 == 1 then
			var_16_10 = var_16_11[1]
		end

		if var_16_10 == 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessSelectHero", {
				id = var_16_0
			})
		else
			local var_16_12 = arg_16_0:GetHeroData(var_16_10)
			local var_16_13 = var_16_12:GetWeaponServant()

			if var_16_13 ~= 0 then
				JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
					heroId = var_16_10,
					weaponId = var_16_0,
					callback = function()
						StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
							var_16_0,
							var_16_13,
							var_16_12:GetStandardId()
						})
					end
				})
			else
				StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
					var_16_0,
					0,
					var_16_12:GetStandardId()
				})
			end
		end
	else
		StrategyMatrixAction.QueryNextProgress(arg_16_0.matrix_activity_id, {
			var_16_0
		})
	end
end

function var_0_0.indexRewardItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2:SetMatrixActivityId(arg_20_0.matrix_activity_id)
	var_0_0.super.indexRewardItem(arg_20_0, arg_20_1, arg_20_2)
end

function var_0_0.GetGameState(arg_21_0)
	return StrategyMatrixData:GetGameState(arg_21_0.matrix_activity_id)
end

function var_0_0.GetHeroData(arg_22_0, arg_22_1)
	return StrategyMatrixData:GetHeroDataNew(arg_22_1)
end

function var_0_0.GetAstrolabeMaxCount(arg_23_0)
	return StrategyMatrixData:GetAstrolabeMaxCount(arg_23_0.matrix_activity_id)
end

function var_0_0.GetMatrixPhaseData(arg_24_0)
	return StrategyMatrixData:GetMatrixPhaseData(arg_24_0.matrix_activity_id)
end

function var_0_0.GetDifficulty(arg_25_0)
	return 1
end

function var_0_0.GetTierID(arg_26_0)
	return StrategyMatrixData:GetTierID(arg_26_0.matrix_activity_id)
end

function var_0_0.GetTierDes(arg_27_0)
	local var_27_0 = StrategyMatrixData:GetTierID(arg_27_0.matrix_activity_id)
	local var_27_1 = StrategyMatrixTierTemplateCfg[var_27_0]

	return string.format("%s-%s", var_27_1.tier, var_27_1.level)
end

function var_0_0.GetMatrixHeroTeam(arg_28_0)
	return StrategyMatrixData:GetMatrixHeroTeam(arg_28_0.matrix_activity_id)
end

function var_0_0.GetHeroEquipMaxCount(arg_29_0)
	return StrategyMatrixData:GetHeroEquipMaxCount(arg_29_0.matrix_activity_id)
end

function var_0_0.GetGiveUpRewardAddition(arg_30_0)
	return StrategyMatrixData:GetGiveUpRewardAddition(arg_30_0.matrix_activity_id)
end

return var_0_0
