local var_0_0 = import("game.views.matrix.matrixTools.MatrixTreeItemGroup")
local var_0_1 = class("MatrixOriginView", ReduxView)
local var_0_2 = {
	MATRIX = 1,
	TERMINAL = 5,
	TREASURE = 3,
	SCORE = 7,
	AFFIX = 4,
	HERO = 2,
	ARTIFACT = 6
}

function var_0_1.UIBackCount(arg_1_0)
	return 2
end

function var_0_1.UIName(arg_2_0)
	return "UI/Matrix/Mend/MatrixOrigin"
end

function var_0_1.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.itemGroup_ = var_0_0.New(arg_5_0.m_itemGroup, arg_5_0.m_treeItemPrefab)

	arg_5_0.itemGroup_:SetSelectCallback(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_5_0.subIndex_ == arg_6_1 then
			return
		end

		arg_5_0:ShowSubIndex(arg_6_0, arg_6_1, arg_6_2)
	end)

	arg_5_0.toggles_ = {}

	local var_5_0 = arg_5_0.m_switchContainer.childCount

	for iter_5_0 = 1, var_5_0 do
		local var_5_1 = arg_5_0.m_switchContainer:GetChild(iter_5_0 - 1)

		table.insert(arg_5_0.toggles_, var_5_1:GetComponent(typeof(Toggle)))
	end
end

function var_0_1.AddUIListener(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.toggles_) do
		arg_7_0:AddToggleListener(iter_7_1, function(arg_8_0)
			if arg_8_0 then
				arg_7_0:SelectGroup(iter_7_0)
			end
		end)
	end
end

function var_0_1.SelectGroup(arg_9_0, arg_9_1, arg_9_2)
	if var_0_2.MATRIX == arg_9_1 then
		arg_9_0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixProcess")
	elseif var_0_2.HERO == arg_9_1 then
		arg_9_0.heroList = MatrixData:GetMatrixHeroTeam()

		arg_9_0:ShowTreeItems(arg_9_1, arg_9_2, arg_9_0.heroList)
	elseif var_0_2.TREASURE == arg_9_1 then
		arg_9_0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixTreasureMini")
	elseif var_0_2.AFFIX == arg_9_1 then
		arg_9_0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixAffixMini")
	elseif var_0_2.TERMINAL == arg_9_1 then
		arg_9_0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixTerminalTalentMini")
	elseif var_0_2.ARTIFACT == arg_9_1 then
		arg_9_0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixBeaconMini")
	elseif var_0_2.SCORE == arg_9_1 then
		arg_9_0:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixScoreExchangeMini")
	end
end

function var_0_1.ShowSubIndex(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0.heroList[arg_10_2]

	JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero", {
		heroId = var_10_0
	})
	arg_10_0.transform_:SetAsLastSibling()
end

function var_0_1.ShowTreeItems(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = arg_11_2 or 1
	arg_11_0.itemGroup_:GetContainer().parent = arg_11_0.m_switchContainer

	arg_11_0.itemGroup_:SetData(arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.itemGroup_:GetContainer():SetSiblingIndex(arg_11_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_switchContainer)
end

function var_0_1.HideTreeItems(arg_12_0)
	arg_12_0.subIndex_ = nil

	arg_12_0.itemGroup_:GetContainer():SetParent(arg_12_0.m_groupFreePlace)
end

function var_0_1.OnEnter(arg_13_0)
	manager.ui:SetMainCamera("hero")

	if MatrixData:GetDifficulty() == 1 then
		SetActive(arg_13_0.toggles_[var_0_2.AFFIX].gameObject, false)
	else
		SetActive(arg_13_0.toggles_[var_0_2.AFFIX].gameObject, true)
	end

	arg_13_0.toggles_[1].isOn = true

	arg_13_0:SelectGroup(1)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
	manager.redPoint:bindUIandKey(arg_13_0.toggles_[var_0_2.SCORE].transform, RedPointConst.MATRIX_EXCHANGE_BONUS, {
		x = 139.6,
		y = 112.6
	})
end

function var_0_1.OnTop(arg_15_0)
	arg_15_0.toggles_[1].isOn = true

	arg_15_0:SelectGroup(1)
end

function var_0_1.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(arg_16_0.toggles_[var_0_2.SCORE].transform, RedPointConst.MATRIX_EXCHANGE_BONUS)
end

function var_0_1.Dispose(arg_17_0)
	if arg_17_0.itemGroup_ then
		arg_17_0.itemGroup_:Dispose()

		arg_17_0.itemGroup_ = nil
	end

	var_0_1.super.Dispose(arg_17_0)
end

function var_0_1.OnMatrixUserUpdate(arg_18_0)
	local var_18_0 = MatrixData:GetGameState()

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_18_0 then
		local var_18_1 = true

		JumpTools.GoToSystem("/matrixBlank/matrixPrepare", {
			isTimeOut = var_18_1
		})
	elseif MatrixConst.STATE_TYPE.SUCCESS == var_18_0 or MatrixConst.STATE_TYPE.FAIL == var_18_0 then
		JumpTools.GoToSystem("/matrixBlank/matrixOver")
	end
end

return var_0_1
