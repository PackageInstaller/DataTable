local var_0_0 = class("AutoChessHeroUpgradePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_UpgradePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.upgradeHandler = handler(arg_3_0, arg_3_0.OnUpgradeHero)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.btnController_ = arg_4_0.controllerEx_:GetController("btnStatus")
	arg_4_0.lastLvController_ = arg_4_0.controllerEx_:GetController("lastLv")
	arg_4_0.nowLvController_ = arg_4_0.controllerEx_:GetController("nowLv")
	arg_4_0.showController_ = arg_4_0.controllerEx_:GetController("show")
	arg_4_0.attrItemList_ = {}
	arg_4_0.attrItemCout_ = arg_4_0.attrContain_.childCount

	for iter_4_0 = 1, arg_4_0.attrItemCout_ do
		local var_4_0 = arg_4_0.attrContain_:GetChild(iter_4_0 - 1).gameObject
		local var_4_1 = AutoChessHeroUpgradePopItem.New(var_4_0)

		table.insert(arg_4_0.attrItemList_, var_4_1)
	end

	arg_4_0.buffItemList_ = {}
	arg_4_0.buffItemCout_ = arg_4_0.buffContain_.childCount

	for iter_4_1 = 1, arg_4_0.buffItemCout_ do
		local var_4_2 = arg_4_0.buffContain_:GetChild(iter_4_1 - 1).gameObject
		local var_4_3 = AutoChessHeroUpgradePopItem.New(var_4_2)

		table.insert(arg_4_0.buffItemList_, var_4_3)
	end

	arg_4_0.playerChessItem_ = AutoChessTeamItem.New(arg_4_0.playerChessGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.upgradeBtn_, nil, function()
		arg_5_0.upgradeHandler()
	end)
	arg_5_0:AddBtnListener(arg_5_0.notEnoughBtn_, nil, function()
		ShowTips("AUTO_CHESS_ADMIN_UPGRADE_CONFIRM")
	end)
	arg_5_0:AddBtnListener(arg_5_0.hideBtn_, nil, function()
		if not arg_5_0.isHide then
			arg_5_0.isHide = true

			arg_5_0.showController_:SetSelectedState("hide")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.showBtn_, nil, function()
		if arg_5_0.isHide then
			arg_5_0.isHide = false

			arg_5_0.showController_:SetSelectedState("show")
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.info_ = arg_10_0.params_.heroUpgradeInfo

	arg_10_0:UpdateUI()
	manager.notify:Invoke(AUTO_CHESS_IS_IN_SKILL_POP, true)
end

function var_0_0.UpdateUI(arg_11_0)
	arg_11_0.showController_:SetSelectedState("show")
	arg_11_0.lastLvController_:SetSelectedState(arg_11_0.info_.oldLevel - 1)
	arg_11_0.nowLvController_:SetSelectedState(arg_11_0.info_.newLevel - 1)

	local var_11_0 = AutoChessData:GetPlayerChessData(arg_11_0.params_.gameType)

	arg_11_0.playerChessItem_:SetData(var_11_0)

	for iter_11_0 = 1, arg_11_0.attrItemCout_ do
		local var_11_1 = arg_11_0.info_.heroAttrs[iter_11_0]
		local var_11_2 = arg_11_0.attrItemList_[iter_11_0]

		if var_11_1 then
			var_11_2:SetData(true, iter_11_0, var_11_1, arg_11_0.info_.newLevel, var_11_0)
			var_11_2:SetClickCb(handler(arg_11_0, arg_11_0.ClickFunc))
			SetActive(var_11_2.gameObject_, true)
		else
			SetActive(var_11_2.gameObject_, false)
		end
	end

	for iter_11_1 = 1, arg_11_0.buffItemCout_ do
		local var_11_3 = arg_11_0.info_.heroBuffs[iter_11_1]
		local var_11_4 = arg_11_0.buffItemList_[iter_11_1]

		if var_11_3 then
			var_11_4:SetData(false, iter_11_1, var_11_3, arg_11_0.info_.newLevel, var_11_0)
			var_11_4:SetClickCb(handler(arg_11_0, arg_11_0.ClickFunc))
			SetActive(var_11_4.gameObject_, true)
		else
			SetActive(var_11_4.gameObject_, false)
		end
	end
end

function var_0_0.ClickFunc(arg_12_0, arg_12_1)
	if arg_12_1.isAttr_ then
		if arg_12_0.selectedAttrItem then
			arg_12_0.selectedAttrItem:SetSelect(false)

			if arg_12_0.selectedAttrItem.index_ == arg_12_1.index_ then
				arg_12_0.selectedAttrItem = nil

				arg_12_0.btnController_:SetSelectedState("grey")

				return
			end
		end

		arg_12_0.selectedAttrItem = arg_12_1

		arg_12_0.selectedAttrItem:SetSelect(true)
	else
		if arg_12_0.selectedBuffItem then
			arg_12_0.selectedBuffItem:SetSelect(false)

			if arg_12_0.selectedBuffItem.index_ == arg_12_1.index_ then
				arg_12_0.selectedBuffItem = nil

				arg_12_0.btnController_:SetSelectedState("grey")

				return
			end
		end

		arg_12_0.selectedBuffItem = arg_12_1

		arg_12_0.selectedBuffItem:SetSelect(true)
	end

	arg_12_0.btnController_:SetSelectedState(arg_12_0.selectedAttrItem and arg_12_0.selectedBuffItem and "normal" or "grey")
end

function var_0_0.OnUpgradeHero(arg_13_0)
	if arg_13_0.selectedAttrItem and arg_13_0.selectedBuffItem then
		AutoChessTools.PlayerCheesUpgrade(arg_13_0.params_.gameType, arg_13_0.selectedAttrItem.index_, arg_13_0.selectedBuffItem.index_)
	end
end

function var_0_0.OnExit(arg_14_0)
	if arg_14_0.selectedAttrItem then
		arg_14_0.selectedAttrItem:SetSelect(false)

		arg_14_0.selectedAttrItem = nil
	end

	if arg_14_0.selectedBuffItem then
		arg_14_0.selectedBuffItem:SetSelect(false)

		arg_14_0.selectedBuffItem = nil
	end

	arg_14_0.btnController_:SetSelectedState("grey")
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.playerChessItem_ then
		arg_15_0.playerChessItem_:Dispose()

		arg_15_0.playerChessItem_ = nil
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.attrItemList_) do
		iter_15_1:Dispose()
	end

	arg_15_0.attrItemList_ = {}

	for iter_15_2, iter_15_3 in pairs(arg_15_0.buffItemList_) do
		iter_15_3:Dispose()
	end

	arg_15_0.buffItemList_ = {}

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
