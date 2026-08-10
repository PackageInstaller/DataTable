local var_0_0 = class("MatrixProcessView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/Matrix/Process/MatrixProcessUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.eventList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexEventItem), arg_5_0.m_eventList, MatrixProcessEventItem)
	arg_5_0.rewardList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexRewardItem), arg_5_0.m_rewardList, MatrixProcessRewardItem)
	arg_5_0.incidentList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexIncidentItem), arg_5_0.m_incidentList, MatrixProcessIncidentItem)
	arg_5_0.phaseController_ = ControllerUtil.GetController(arg_5_0.m_phaseController, "phase")
	arg_5_0.hasGiveUpRewadController_ = ControllerUtil.GetController(arg_5_0.m_phaseController, "hasGiveUpRewad")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_rewardCommon, nil, function()
		MatrixAction.QueryNextProgress({})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rewardBtn, nil, function()
		arg_6_0:OnRewardAction()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_eventBtn, nil, function()
		arg_6_0:OnEventAction()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				MatrixAction.QueryMatrixGiveUp(function(arg_12_0)
					return
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_incidentBtn, nil, function()
		if arg_6_0.selectItemIndex == -1 then
			return
		end

		local var_14_0 = arg_6_0.incidentData[arg_6_0.selectItemIndex]

		MatrixAction.QueryNextProgress({
			var_14_0
		})
	end)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:Refresh()
end

function var_0_0.Refresh(arg_18_0)
	arg_18_0.phaseData = arg_18_0:GetMatrixPhaseData()
	arg_18_0.phasesParams = clone(arg_18_0.phaseData:GetParams())
	arg_18_0.matrixGiveUpItemId = arg_18_0.phaseData:GetGiveUpItemId()
	arg_18_0.incidentData = {}
	arg_18_0.selectItemIndex = -1
	arg_18_0.m_rewardBtn.interactable = false
	arg_18_0.m_eventBtn.interactable = false
	arg_18_0.m_incidentBtn.interactable = false

	local var_18_0 = arg_18_0.phaseData:GetPhase()

	if var_18_0 == 1 then
		arg_18_0.phaseController_:SetSelectedIndex(1)
		arg_18_0.eventList_:StartScroll(#arg_18_0.phasesParams)
	elseif var_18_0 == 2 then
		local var_18_1 = arg_18_0.phasesParams[1]
		local var_18_2 = MatrixEventCfg[var_18_1]

		if MatrixConst.EVENT_TYPE.INCIDENT == var_18_2.event_type then
			local var_18_3 = arg_18_0.phaseData:GetData()

			arg_18_0.incidentData = {}

			local var_18_4 = MatrixChanceCfg.get_id_list_by_title_id[var_18_3]

			for iter_18_0, iter_18_1 in ipairs(var_18_4) do
				local var_18_5 = MatrixChanceCfg[iter_18_1]

				table.insert(arg_18_0.incidentData, var_18_5.option)
			end

			arg_18_0.m_incidentTitle.text = MatrixDescCfg[var_18_3] and GetI18NText(MatrixDescCfg[var_18_3].desc) or ""

			arg_18_0.phaseController_:SetSelectedIndex(3)
			arg_18_0.incidentList_:StartScroll(#arg_18_0.incidentData)
		else
			arg_18_0.phaseController_:SetSelectedIndex(1)
			arg_18_0.eventList_:StartScroll(#arg_18_0.phasesParams)
		end
	elseif var_18_0 == 3 then
		if arg_18_0.matrixGiveUpItemId and arg_18_0.matrixGiveUpItemId ~= 0 then
			arg_18_0.hasGiveUpRewadController_:SetSelectedIndex(1)

			local var_18_6 = MatrixItemCfg[arg_18_0.matrixGiveUpItemId]

			if MatrixConst.ITEM_TYPE.ITEM == var_18_6.matrix_item_type and #var_18_6.params > 0 then
				local var_18_7 = var_18_6.params[1][1]
				local var_18_8 = var_18_6.params[1][2]

				if var_18_7 == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN then
					var_18_8 = var_18_8 * (1 + arg_18_0:GetGiveUpRewardAddition())
				end

				arg_18_0.m_rewardCommonText.text = string.format(GetTips("MATRIX_GET"), var_18_8, GetI18NText(var_18_6.name))
			else
				arg_18_0.m_rewardCommonText.text = GetI18NText(var_18_6.desc)
			end
		else
			arg_18_0.hasGiveUpRewadController_:SetSelectedIndex(0)
		end

		arg_18_0.phaseController_:SetSelectedIndex(2)
		arg_18_0.rewardList_:StartScroll(#arg_18_0.phasesParams)
	else
		arg_18_0.phaseController_:SetSelectedIndex(0)
	end

	local var_18_9 = arg_18_0:GetDifficulty()

	if var_18_9 == 1 then
		arg_18_0.m_difficultyLab.text = GetTips("HARDLEVEL_EASY")
	elseif var_18_9 == 3 then
		arg_18_0.m_difficultyLab.text = GetTips("HARDLEVEL_SINGULARITY")
	else
		arg_18_0.m_difficultyLab.text = GetTips("HARDLEVEL_HARD")
	end

	arg_18_0.m_tierLab.text = arg_18_0:GetTierDes()
end

function var_0_0.indexEventItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.phasesParams[arg_19_1]

	arg_19_2:RegistCallBack(handler(arg_19_0, arg_19_0.OnEvengtItemClick))
	arg_19_2:Refresh(var_19_0, arg_19_1)
	arg_19_2:SetSelected(arg_19_1 == arg_19_0.selectItemIndex)
end

function var_0_0.indexRewardItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.phasesParams[arg_20_1]

	arg_20_2:RegistCallBack(handler(arg_20_0, arg_20_0.OnRewardItemClick))
	arg_20_2:Refresh(var_20_0, arg_20_1)
	arg_20_2:SetSelected(arg_20_1 == arg_20_0.selectItemIndex)
end

function var_0_0.indexIncidentItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.incidentData[arg_21_1]

	arg_21_2:RegistCallBack(handler(arg_21_0, arg_21_0.OnIncidentItemClick))
	arg_21_2:Refresh(var_21_0, arg_21_1)
	arg_21_2:SetSelected(arg_21_1 == arg_21_0.selectItemIndex)
end

function var_0_0.OnEvengtItemClick(arg_22_0, arg_22_1)
	if arg_22_1 == arg_22_0.selectItemIndex then
		return
	end

	arg_22_0.selectItemIndex = arg_22_1

	local var_22_0 = arg_22_0.eventList_:GetItemList()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_1 = iter_22_1:GetIndex()

		iter_22_1:SetSelected(var_22_1 == arg_22_0.selectItemIndex)
	end

	arg_22_0.m_eventBtn.interactable = true
end

function var_0_0.OnRewardItemClick(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == arg_23_0.selectItemIndex then
		return
	end

	arg_23_0.selectItemIndex = arg_23_1

	local var_23_0 = arg_23_0.rewardList_:GetItemList()

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		local var_23_1 = iter_23_1:GetIndex()

		iter_23_1:SetSelected(var_23_1 == arg_23_0.selectItemIndex)
	end

	arg_23_0.m_rewardBtn.interactable = true
end

function var_0_0.OnIncidentItemClick(arg_24_0, arg_24_1)
	if arg_24_1 == arg_24_0.selectItemIndex then
		return
	end

	arg_24_0.selectItemIndex = arg_24_1

	local var_24_0 = arg_24_0.incidentList_:GetItemList()

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_1 = iter_24_1:GetIndex()

		iter_24_1:SetSelected(var_24_1 == arg_24_0.selectItemIndex)
	end

	arg_24_0.m_incidentBtn.interactable = true
end

function var_0_0.OnEventAction(arg_25_0)
	if arg_25_0.selectItemIndex == -1 then
		return
	end

	local var_25_0 = arg_25_0.phasesParams[arg_25_0.selectItemIndex]
	local var_25_1 = MatrixEventCfg[var_25_0]

	if not var_25_1 then
		print("MatrixEventCfg cant find event by id :" .. var_25_0)

		return
	end

	local var_25_2 = arg_25_0:GetMatrixPhaseData():GetPhase()

	if MatrixConst.EVENT_TYPE.SHOP == var_25_1.event_type or MatrixConst.EVENT_TYPE.INCIDENT == var_25_1.event_type then
		if var_25_2 == 2 then
			MatrixAction.DoEvent()
		else
			MatrixAction.QueryNextProgress({
				var_25_0
			})
		end
	else
		local var_25_3 = var_25_1.params[1]

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX,
			section = var_25_3,
			eventId = var_25_0
		})
	end
end

function var_0_0.OnRewardAction(arg_26_0)
	if arg_26_0.selectItemIndex == -1 then
		return
	end

	local var_26_0 = arg_26_0.phasesParams[arg_26_0.selectItemIndex]
	local var_26_1 = var_26_0 and MatrixItemCfg[var_26_0]

	if not var_26_1 then
		print("MatrixItemCfg cant find item by id :" .. var_26_0)

		return
	end

	local var_26_2 = var_26_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_26_2 then
		local var_26_3 = math.floor(var_26_1.params[1] / 1000)
		local var_26_4 = arg_26_0:GetHeroData(var_26_3)
		local var_26_5 = var_26_4:GetAstrolabeList()

		if var_26_4:GetAstrolabeNum(var_26_1.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if arg_26_0:GetAstrolabeMaxCount() <= #var_26_5 then
			JumpTools.OpenPageByJump("matrixProcessAstrolabeReplace", {
				heroId = var_26_3,
				astrolabeId = var_26_0,
				callback = function(arg_27_0)
					MatrixAction.QueryNextProgress({
						var_26_0,
						arg_27_0,
						var_26_4:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				var_26_0,
				0,
				var_26_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_26_2 then
		JumpTools.OpenPageByJump("matrixProcessSelectHero", {
			id = var_26_0
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_26_2 then
		local var_26_6 = MatrixTools.GetWeaponSpecHero(var_26_1.params[1])

		if var_26_6 == 0 then
			JumpTools.OpenPageByJump("matrixProcessSelectHero", {
				id = var_26_0
			})
		else
			local var_26_7 = arg_26_0:GetHeroData(var_26_6)
			local var_26_8 = var_26_7:GetWeaponServant()

			if var_26_8 ~= 0 then
				JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
					heroId = var_26_6,
					weaponId = var_26_0,
					callback = function()
						MatrixAction.QueryNextProgress({
							var_26_0,
							var_26_8,
							var_26_7:GetStandardId()
						})
					end
				})
			else
				MatrixAction.QueryNextProgress({
					var_26_0,
					0,
					var_26_7:GetStandardId()
				})
			end
		end
	else
		MatrixAction.QueryNextProgress({
			var_26_0
		})
	end
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.eventList_ then
		arg_29_0.eventList_:Dispose()
	end

	if arg_29_0.rewardList_ then
		arg_29_0.rewardList_:Dispose()
	end

	if arg_29_0.incidentList_ then
		arg_29_0.incidentList_:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

function var_0_0.OnMatrixUserUpdate(arg_30_0)
	local var_30_0 = arg_30_0:GetGameState()

	if MatrixConst.STATE_TYPE.STARTED == var_30_0 then
		arg_30_0:Refresh(true)
	end
end

function var_0_0.GetGameState(arg_31_0)
	return MatrixData:GetGameState()
end

function var_0_0.GetHeroData(arg_32_0, arg_32_1)
	return MatrixData:GetHeroData(arg_32_1)
end

function var_0_0.GetAstrolabeMaxCount(arg_33_0)
	return MatrixData:GetAstrolabeMaxCount()
end

function var_0_0.GetMatrixPhaseData(arg_34_0)
	return MatrixData:GetMatrixPhaseData()
end

function var_0_0.GetDifficulty(arg_35_0)
	return MatrixData:GetDifficulty()
end

function var_0_0.GetGiveUpRewardAddition(arg_36_0)
	return MatrixData:GetGiveUpRewardAddition()
end

function var_0_0.GetTierDes(arg_37_0)
	local var_37_0 = MatrixData:GetTierID()
	local var_37_1 = MatrixTierCfg[var_37_0]

	return string.format("%s-%s", var_37_1.tier, var_37_1.level)
end

return var_0_0
