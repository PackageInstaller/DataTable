local var_0_0 = class("PolyhedronDifficultyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronDifficultyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.difficultyGroupList = {}
	arg_4_0.lockGoDict = {}

	local var_4_0 = table.keys(PolyhedronDifficultyCfg.get_id_list_by_unlock_difficulty)

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	local var_4_1 = handler(arg_4_0, arg_4_0.DifficultyClick)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1 ~= 0 then
			local var_4_2 = Object.Instantiate(arg_4_0.m_lockTip, arg_4_0.m_content)

			SetActive(var_4_2, true)

			arg_4_0:FindCom("Text", "text", var_4_2.transform).text = string.format(GetTips("POLYHEDRON_DIFFICULTY_UNLOCK"), iter_4_1)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(var_4_2.transform)

			arg_4_0.lockGoDict[iter_4_1] = var_4_2
		end

		local var_4_3 = PolyhedronDifficultyCfg.get_id_list_by_unlock_difficulty[iter_4_1]

		for iter_4_2, iter_4_3 in ipairs(var_4_3) do
			local var_4_4 = Object.Instantiate(arg_4_0.m_groupItem, arg_4_0.m_content)

			SetActive(var_4_4, true)

			local var_4_5 = PolyhedronDifficultyGroupItem.New(var_4_4, iter_4_3)

			var_4_5:RegistCallBack(var_4_1)
			table.insert(arg_4_0.difficultyGroupList, var_4_5)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.m_content)

	arg_4_0.overviewList = {}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_difficultybtn, nil, function()
		local var_7_0 = PolyhedronData:GetCacheSelectHero()
		local var_7_1

		if var_7_0 ~= 0 then
			var_7_1 = {
				arg_6_0.leader
			}
		else
			var_7_1 = {}
		end

		gameContext:Go("/heroTeamInfoPolyhedron", {
			selectHeroPos = 1,
			heroTeam = var_7_1,
			heroDataType = HeroConst.HERO_DATA_TYPE.POLYHEDRON
		})
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_9_0)
	manager.ui:SetMainCamera("hero")

	arg_9_0.maxDifficulty = PolyhedronData:GetClearMaxDifficulty()
	arg_9_0.selectDifficulty = PolyhedronData:GetCacheSelectDifficulty()

	arg_9_0:RefreshUI()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	PolyhedronData:SetCacheSelectDifficulty(arg_10_0.selectDifficulty)
end

function var_0_0.RefreshUI(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.difficultyGroupList) do
		iter_11_1:SetData(arg_11_0.maxDifficulty, arg_11_0.selectDifficulty)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(iter_11_1.gameObject_.transform)
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.lockGoDict) do
		if iter_11_2 > arg_11_0.maxDifficulty then
			SetActive(iter_11_3, true)
		else
			SetActive(iter_11_3, false)
		end
	end

	arg_11_0.m_curDifficultyLab.text = arg_11_0.selectDifficulty

	if arg_11_0.selectDifficulty == 0 then
		SetActive(arg_11_0.m_difficultybtnGo, false)

		for iter_11_4, iter_11_5 in ipairs(arg_11_0.overviewList) do
			iter_11_5:SetActive(false)
		end

		arg_11_0.m_scoreLab.text = "0%"
	else
		SetActive(arg_11_0.m_difficultybtnGo, true)

		local var_11_0 = PolyhedronDifficultyCfg[arg_11_0.selectDifficulty]

		arg_11_0.m_scoreLab.text = var_11_0.score / 10 .. "%"

		local var_11_1 = PolyhedronTools.GetPolyhedronDifficultyAffixDir(arg_11_0.selectDifficulty)
		local var_11_2 = {}

		PolyhedronTools.CalPolyhedronDifficultyAttr(var_11_2, arg_11_0.selectDifficulty)

		local var_11_3 = 1

		for iter_11_6, iter_11_7 in pairs(var_11_2) do
			if not arg_11_0.overviewList[var_11_3] then
				local var_11_4 = Object.Instantiate(arg_11_0.m_overviewItem, arg_11_0.m_overviewContent)

				SetActive(var_11_4, true)

				arg_11_0.overviewList[var_11_3] = PolyhedronDifficultyOverviewItem.New(var_11_4)
			end

			arg_11_0.overviewList[var_11_3]:SetActive(true)

			local var_11_5 = {
				iter_11_6,
				iter_11_7
			}

			arg_11_0.overviewList[var_11_3]:SetData(2, var_11_5)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.overviewList[var_11_3].gameObject_.transform)

			var_11_3 = var_11_3 + 1
		end

		for iter_11_8, iter_11_9 in pairs(var_11_1) do
			if not arg_11_0.overviewList[var_11_3] then
				local var_11_6 = Object.Instantiate(arg_11_0.m_overviewItem, arg_11_0.m_overviewContent)

				SetActive(var_11_6, true)

				arg_11_0.overviewList[var_11_3] = PolyhedronDifficultyOverviewItem.New(var_11_6)
			end

			arg_11_0.overviewList[var_11_3]:SetActive(true)
			arg_11_0.overviewList[var_11_3]:SetData(1, iter_11_9)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.overviewList[var_11_3].gameObject_.transform)

			var_11_3 = var_11_3 + 1
		end

		local var_11_7 = #arg_11_0.overviewList

		for iter_11_10 = var_11_3, var_11_7 do
			arg_11_0.overviewList[iter_11_10]:SetActive(false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_overviewContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_content)
end

function var_0_0.DifficultyClick(arg_12_0, arg_12_1)
	if PolyhedronDifficultyCfg[arg_12_1].unlock_difficulty > arg_12_0.maxDifficulty then
		return
	end

	arg_12_0.selectDifficulty = arg_12_1

	arg_12_0:RefreshUI()
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.difficultyGroupList) do
		iter_13_1:Dispose()
	end

	arg_13_0.difficultyGroupList = {}
	arg_13_0.lockGoDict = {}

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.overviewList) do
		iter_13_3:Dispose()
	end

	arg_13_0.overviewList = {}

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
