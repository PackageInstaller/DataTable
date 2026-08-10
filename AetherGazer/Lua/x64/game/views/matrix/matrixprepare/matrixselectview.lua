local var_0_0 = class("MatrixSelectView", ReduxView)
local var_0_1 = {
	AI = "AI",
	CAPTAIN = "CAPTAIN",
	AFFIX = "AFFIX",
	BEACON = "BEACON",
	DIFFICULTY = "DIFFICULTY"
}

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Prepare/MatrixSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.MAXSELECT = 2
	arg_3_0.viewState = var_0_1.DIFFICULTY
	arg_3_0.openDifficultyLv = -1

	for iter_3_0, iter_3_1 in ipairs(MatrixTerminalLevelCfg.all) do
		local var_3_0 = MatrixTerminalLevelCfg[iter_3_1]

		if table.indexof(var_3_0.difficulty_open_list, 2) then
			arg_3_0.openDifficultyLv = iter_3_1

			break
		end
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.viewStateController_ = ControllerUtil.GetController(arg_4_0.m_viewStateController, "state")
	arg_4_0.tHero = {}

	ComponentBinder.GetInstance():BindCfgUI(arg_4_0.tHero, arg_4_0.m_hero)

	arg_4_0.tDifficulty = {}

	ComponentBinder.GetInstance():BindCfgUI(arg_4_0.tDifficulty, arg_4_0.m_difficulty)

	arg_4_0.tBeacon = {}

	ComponentBinder.GetInstance():BindCfgUI(arg_4_0.tBeacon, arg_4_0.m_beacon)

	arg_4_0.heroList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.tHero.m_heroList, MatrixSelectHeroItem)
	arg_4_0.difficultyList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDifficultyItem), arg_4_0.tDifficulty.m_difficultyList, MatrixSelectDifficultyItem)
	arg_4_0.selectAfiifxView = MatrixSelectAffixView.New(arg_4_0.m_affix)
	arg_4_0.beaconList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBeaconItem), arg_4_0.tBeacon.m_list, MatrixSelectBeaconItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.tHero.m_confirmBtn, nil, function()
		if var_0_1.CAPTAIN == arg_5_0.viewState then
			if arg_5_0.captainId == 0 then
				return
			end

			if arg_5_0:HaveLoneWolf() then
				if arg_5_0.selectDifficulty == 1 then
					arg_5_0:StartMatrix()
				else
					arg_5_0.viewState = var_0_1.AFFIX

					arg_5_0:Refresh()
				end
			else
				arg_5_0.viewState = var_0_1.AI

				arg_5_0:Refresh()
			end
		else
			if arg_5_0.captainId == 0 or #arg_5_0.selectHeroList ~= 2 then
				return
			end

			if arg_5_0.selectDifficulty == 1 then
				arg_5_0:StartMatrix()
			else
				arg_5_0.viewState = var_0_1.AFFIX

				arg_5_0:Refresh()
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.tDifficulty.m_okBtn, nil, function()
		arg_5_0.viewState = var_0_1.BEACON

		arg_5_0:Refresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.selectAfiifxView.m_okBtn, nil, function()
		arg_5_0:StartMatrix()
	end)
	arg_5_0:AddBtnListener(arg_5_0.tBeacon.m_okBtn, nil, function()
		if #arg_5_0.selectBeaconList == 0 then
			ShowTips(GetTips("MATRIX_SELECT_BEACON"))

			return
		end

		arg_5_0.viewState = var_0_1.CAPTAIN

		arg_5_0:Refresh()
	end)
end

function var_0_0.HaveLoneWolf(arg_10_0)
	return table.indexof(arg_10_0.selectBeaconList, 10)
end

function var_0_0.StartMatrix(arg_11_0)
	local var_11_0 = clone(arg_11_0.selectHeroList)

	table.insert(var_11_0, 1, arg_11_0.captainId)

	local var_11_1 = arg_11_0.selectDifficulty == 1 and {} or arg_11_0.selectAfiifxView.customData

	MatrixAction.QueryStartMatrix(var_11_0, arg_11_0.selectDifficulty, var_11_1, arg_11_0.selectBeaconList)
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if var_0_1.AI == arg_12_0.viewState then
			arg_12_0.viewState = var_0_1.CAPTAIN
			arg_12_0.selectHeroList = {}

			arg_12_0:Refresh()
		elseif var_0_1.CAPTAIN == arg_12_0.viewState then
			arg_12_0.viewState = var_0_1.BEACON

			arg_12_0:Refresh()
		elseif var_0_1.AFFIX == arg_12_0.viewState then
			if arg_12_0:HaveLoneWolf() then
				arg_12_0.viewState = var_0_1.CAPTAIN
			else
				arg_12_0.viewState = var_0_1.AI
			end

			arg_12_0:Refresh()
		elseif var_0_1.BEACON == arg_12_0.viewState then
			arg_12_0.viewState = var_0_1.DIFFICULTY

			arg_12_0:Refresh()
		else
			arg_12_0:Back(1)
		end
	end)
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:UpdateBar()
	arg_14_0:Refresh()
end

function var_0_0.OnEnter(arg_15_0)
	MatrixData:SetCacheCustomAffix({})

	arg_15_0.heroData = MatrixData:GetReadyHeroList()
	arg_15_0.viewState = var_0_1.DIFFICULTY
	arg_15_0.selectDifficulty = -1
	arg_15_0.captainId = 0
	arg_15_0.selectHeroList = {}
	arg_15_0.selectBeaconList = {}

	arg_15_0.selectAfiifxView:Reset()
	arg_15_0:Refresh()
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_17_0)
	if var_0_1.CAPTAIN == arg_17_0.viewState then
		arg_17_0.viewStateController_:SetSelectedIndex(0)

		arg_17_0.tHero.m_tip.text = GetTips("MATRIX_SELECT_TEAM_LEADER")
		arg_17_0.tHero.m_confirmBtn.interactable = arg_17_0.captainId ~= 0

		arg_17_0.heroList_:StartScroll(#arg_17_0.heroData)
	elseif var_0_1.AI == arg_17_0.viewState then
		arg_17_0.viewStateController_:SetSelectedIndex(0)

		arg_17_0.tHero.m_tip.text = GetTips("MATRIX_SELECT_TEAM")
		arg_17_0.tHero.m_confirmBtn.interactable = #arg_17_0.selectHeroList == 2

		arg_17_0.heroList_:StartScroll(#arg_17_0.heroData)
	elseif var_0_1.DIFFICULTY == arg_17_0.viewState then
		arg_17_0.viewStateController_:SetSelectedIndex(1)
		arg_17_0.difficultyList_:StartScroll(2)

		arg_17_0.affixCustomData = {}

		if arg_17_0.selectDifficulty == -1 then
			arg_17_0.tDifficulty.m_okBtn.interactable = false
		else
			arg_17_0.tDifficulty.m_okBtn.interactable = true
		end
	elseif var_0_1.AFFIX == arg_17_0.viewState then
		arg_17_0.viewStateController_:SetSelectedIndex(2)
		arg_17_0.selectAfiifxView:SetData(arg_17_0.selectDifficulty)
	elseif var_0_1.BEACON == arg_17_0.viewState then
		arg_17_0.viewStateController_:SetSelectedIndex(3)

		local var_17_0 = MatrixData:GetTerminalLevel()

		arg_17_0.maxBeaconSelect = MatrixTerminalLevelCfg[var_17_0].beacon_number
		arg_17_0.beaconData = MatrixData:GetUnlockBeaconList()

		local var_17_1 = #arg_17_0.beaconData

		arg_17_0.beaconList_:StartScroll(var_17_1)

		arg_17_0.tBeacon.m_numLab.text = #arg_17_0.selectBeaconList .. "/" .. arg_17_0.maxBeaconSelect

		if #arg_17_0.selectBeaconList > 0 then
			arg_17_0.tBeacon.m_okBtn.interactable = true
		else
			arg_17_0.tBeacon.m_okBtn.interactable = false
		end
	end
end

function var_0_0.IndexItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.heroData[arg_18_1]
	local var_18_1 = 0

	if var_0_1.CAPTAIN == arg_18_0.viewState then
		if var_18_0 == arg_18_0.captainId then
			var_18_1 = 1
		end
	else
		var_18_1 = var_18_0 == arg_18_0.captainId and 3 or table.indexof(arg_18_0.selectHeroList, var_18_0) and 1 or arg_18_0.MAXSELECT > #arg_18_0.selectHeroList and 0 or 2
	end

	local var_18_2 = var_18_0 == arg_18_0.captainId
	local var_18_3 = arg_18_0.selectDifficulty

	arg_18_2:Refresh(var_18_0, var_18_1, var_18_2, var_18_3)
	arg_18_2:RegistCallBack(function()
		arg_18_0:OnHeroItemClick(var_18_0)
	end)
end

function var_0_0.OnHeroItemClick(arg_20_0, arg_20_1)
	if var_0_1.CAPTAIN == arg_20_0.viewState then
		if arg_20_1 == arg_20_0.captainId then
			arg_20_0.captainId = 0
		else
			arg_20_0.captainId = arg_20_1
		end
	elseif arg_20_1 ~= arg_20_0.captainId then
		local var_20_0 = table.indexof(arg_20_0.selectHeroList, arg_20_1)

		if var_20_0 then
			table.remove(arg_20_0.selectHeroList, var_20_0)
		elseif arg_20_0.MAXSELECT > #arg_20_0.selectHeroList then
			table.insert(arg_20_0.selectHeroList, arg_20_1)
		end
	end

	arg_20_0:Refresh()
end

function var_0_0.IndexDifficultyItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 == arg_21_0.selectDifficulty

	arg_21_2:Refresh(arg_21_1, var_21_0)
	arg_21_2:RegistCallBack(function()
		arg_21_0:OnDifficultyItemClick(arg_21_1)
	end)
end

function var_0_0.OnDifficultyItemClick(arg_23_0, arg_23_1)
	if arg_23_1 == 2 then
		local var_23_0 = MatrixData:GetTerminalLevel()
		local var_23_1 = MatrixTerminalLevelCfg[var_23_0]

		if not table.indexof(var_23_1.difficulty_open_list, 2) then
			ShowTips(string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), arg_23_0.openDifficultyLv))

			return
		end

		if not IsConditionAchieved(MatrixConst.MATRIX_UNLOCK_DIFFICULTY_CONDITION) then
			ShowTips(GetTips("MATRIX_CLEARANCE_DIFFICULTY_UNLOCK"))

			return
		end
	end

	if arg_23_1 == arg_23_0.selectDifficulty then
		return
	else
		arg_23_0.selectDifficulty = arg_23_1
	end

	arg_23_0:Refresh()
end

function var_0_0.IndexBeaconItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.beaconData[arg_24_1]
	local var_24_1 = not not table.indexof(arg_24_0.selectBeaconList, var_24_0)

	arg_24_2:Refresh(var_24_0)
	arg_24_2:SetChoice(var_24_1)

	local var_24_2 = not var_24_1 and #arg_24_0.selectBeaconList >= arg_24_0.maxBeaconSelect

	arg_24_2:SetMask(var_24_2)
	arg_24_2:RegistCallBack(handler(arg_24_0, arg_24_0.OnBeaconItemClick))
end

function var_0_0.OnBeaconItemClick(arg_25_0, arg_25_1, arg_25_2)
	if table.indexof(arg_25_0.selectBeaconList, arg_25_1) then
		arg_25_0:UnSelectBeacon(arg_25_1)
	else
		if #arg_25_0.selectBeaconList >= arg_25_0.maxBeaconSelect then
			ShowTips("MATRIX_SELECT_BEACON_MAX")

			return
		end

		local var_25_0 = MatrixBeaconCfg[arg_25_1]
		local var_25_1 = {}
		local var_25_2 = MatrixData:GetTerminalGift() or {}

		for iter_25_0, iter_25_1 in ipairs(var_25_0.require_terminal_list or {}) do
			if not var_25_2[iter_25_1] or var_25_2[iter_25_1] == 0 then
				table.insert(var_25_1, iter_25_1)
			end
		end

		if #var_25_1 > 0 then
			local var_25_3 = ""

			for iter_25_2, iter_25_3 in ipairs(var_25_1) do
				local var_25_4 = MatrixTerminalGiftCfg[iter_25_3]

				if iter_25_2 == 1 then
					var_25_3 = var_25_4.name
				else
					var_25_3 = var_25_3 .. "," .. var_25_4.name
				end
			end

			ShowMessageBox({
				content = string.format(GetTips("ERROR_MATRIX_NOT_EFFECTIVE"), GetI18NText(var_25_0.name), GetI18NText(var_25_3)),
				OkCallback = function()
					arg_25_0:SelectBeacon(arg_25_1)
				end
			})

			return
		end

		arg_25_0:SelectBeacon(arg_25_1)
	end
end

function var_0_0.SelectBeacon(arg_27_0, arg_27_1)
	table.insert(arg_27_0.selectBeaconList, arg_27_1)

	local var_27_0 = #arg_27_0.selectBeaconList

	arg_27_0.tBeacon.m_numLab.text = var_27_0 .. "/" .. arg_27_0.maxBeaconSelect

	arg_27_0.beaconList_:Refresh()

	if var_27_0 > 0 then
		arg_27_0.tBeacon.m_okBtn.interactable = true
	else
		arg_27_0.tBeacon.m_okBtn.interactable = false
	end
end

function var_0_0.UnSelectBeacon(arg_28_0, arg_28_1)
	local var_28_0 = table.indexof(arg_28_0.selectBeaconList, arg_28_1)

	table.remove(arg_28_0.selectBeaconList, var_28_0)

	local var_28_1 = #arg_28_0.selectBeaconList

	arg_28_0.tBeacon.m_numLab.text = var_28_1 .. "/" .. arg_28_0.maxBeaconSelect

	arg_28_0.beaconList_:Refresh()

	if var_28_1 > 0 then
		arg_28_0.tBeacon.m_okBtn.interactable = true
	else
		arg_28_0.tBeacon.m_okBtn.interactable = false
	end
end

function var_0_0.Dispose(arg_29_0)
	var_0_0.super.Dispose(arg_29_0)
	arg_29_0.heroList_:Dispose()
	arg_29_0.difficultyList_:Dispose()
	arg_29_0.beaconList_:Dispose()
	arg_29_0.selectAfiifxView:Dispose()
end

function var_0_0.OnMatrixSystemOverdue(arg_30_0)
	arg_30_0:Back()
end

return var_0_0
