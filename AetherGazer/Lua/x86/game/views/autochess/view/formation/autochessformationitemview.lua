local var_0_0 = class("AutoChessFormationItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.gameType_ = AutoChessConst.GAME_TYPE.PVE
	arg_1_0.posViewDic = {}
	arg_1_0.chessItemList = {}
	arg_1_0.playerType_ = AutoChessConst.PLAYER_TYPE.SELF

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitChessContainer()
	arg_2_0:InitChessItemContainer()
end

function var_0_0.InitChessContainer(arg_3_0)
	local var_3_0 = arg_3_0.posPanelTrans_.childCount

	for iter_3_0 = 1, var_3_0 do
		arg_3_0.posViewDic[iter_3_0] = AutoChessFormationPosView.New(arg_3_0.posPanelTrans_:Find("formationPos_" .. iter_3_0).gameObject)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.posPanelTrans_)
end

function var_0_0.SetGameType(arg_4_0, arg_4_1)
	arg_4_0.gameType_ = arg_4_1
end

function var_0_0.SetPlayerType(arg_5_0, arg_5_1)
	arg_5_0.playerType_ = arg_5_1
end

function var_0_0.InitChessItemContainer(arg_6_0)
	for iter_6_0 = 1, arg_6_0.chessPanelTrans_.childCount do
		local var_6_0 = AutoChessTeamItem.New(arg_6_0.chessPanelTrans_:GetChild(iter_6_0 - 1).gameObject)

		var_6_0.transform_.position = arg_6_0.posViewDic[iter_6_0]:GetChessContainerTrans().position

		table.insert(arg_6_0.chessItemList, var_6_0)
	end
end

function var_0_0.GetPosItem(arg_7_0, arg_7_1)
	return arg_7_0.posViewDic[arg_7_1]
end

function var_0_0.GetChessContainerTrans(arg_8_0, arg_8_1)
	return arg_8_0.posViewDic[arg_8_1]:GetChessContainerTrans()
end

function var_0_0.GetChessPos(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetChessContainerTrans(arg_9_1)

	return arg_9_0.chessPanelTrans_:InverseTransformPoint(var_9_0.position)
end

function var_0_0.GetChessPanelTrans(arg_10_0)
	return arg_10_0.chessPanelTrans_
end

function var_0_0.GetChessItem(arg_11_0, arg_11_1)
	return arg_11_0.chessItemList[arg_11_1]
end

function var_0_0.GetChessItemByUniqueId(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.chessItemList) do
		if iter_12_1.chessItemData_ and iter_12_1.chessItemData_.uniqueId == arg_12_1 then
			return iter_12_1
		end
	end
end

function var_0_0.RemoveChessItemByUniqueId(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_0.chessItemList do
		if arg_13_0.chessItemList[iter_13_0].chessItemData_ and arg_13_0.chessItemList[iter_13_0].chessItemData_.uniqueId == arg_13_1 then
			arg_13_0:ClearPosData(arg_13_0.chessItemList[iter_13_0].chessItemData_)

			break
		end
	end
end

function var_0_0.GetChessItemList(arg_14_0)
	return arg_14_0.chessItemList
end

function var_0_0.GetChessNum(arg_15_0)
	return arg_15_0.chessNum_
end

function var_0_0.UpdatePrepareTeamInfo(arg_16_0, arg_16_1)
	arg_16_0.chessTeamDataList = arg_16_1
	arg_16_0.prepareNum_ = tonumber(AutoChessTools.GetPrepareNum(arg_16_0.gameType_))
	arg_16_0.chessNum_ = 0

	for iter_16_0 = 1, arg_16_0.prepareNum_ do
		local var_16_0 = arg_16_0.chessTeamDataList[iter_16_0]
		local var_16_1 = arg_16_0.chessItemList[iter_16_0]

		arg_16_0.chessNum_ = var_16_0 ~= nil and arg_16_0.chessNum_ + 1 or arg_16_0.chessNum_

		var_16_1:SetPlayerType(arg_16_0.playerType_)
		var_16_1:SetData(var_16_0 or {
			index = iter_16_0
		})
		var_16_1:SetGameType(arg_16_0.gameType_)
	end
end

function var_0_0.BeginDragFunc(arg_17_0, arg_17_1)
	arg_17_0:BuyChess(arg_17_1)
end

function var_0_0.BeginPropDragFunc(arg_18_0, arg_18_1)
	arg_18_0:BuyProp(arg_18_1)
end

function var_0_0.BuyProp(arg_19_0, arg_19_1)
	local var_19_0 = AutoChessItemCfg[arg_19_1.chessId]

	for iter_19_0 = 1, arg_19_0.prepareNum_ do
		if arg_19_0.chessTeamDataList[iter_19_0] then
			local var_19_1 = var_19_0.relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER and AutoChessTools.IsPlayerChess(arg_19_0.chessTeamDataList[iter_19_0].chessId)
			local var_19_2 = AutoChessTools.CheckUseProp(arg_19_1.chessId, arg_19_0.gameType_, arg_19_0.chessTeamDataList[iter_19_0])

			if var_19_1 or not var_19_2 then
				arg_19_0.posViewDic[iter_19_0]:SetStatus("red")
			else
				arg_19_0.posViewDic[iter_19_0]:SetStatus("green")
			end
		else
			arg_19_0.posViewDic[iter_19_0]:SetStatus("white")
		end
	end
end

function var_0_0.BuyChess(arg_20_0, arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = 1, arg_20_0.prepareNum_ do
		if arg_20_0.chessTeamDataList[iter_20_0] and arg_20_0.chessTeamDataList[iter_20_0].chessId == arg_20_1.chessId then
			table.insert(var_20_0, iter_20_0)
		end
	end

	for iter_20_1 = 1, arg_20_0.prepareNum_ do
		arg_20_0.posViewDic[iter_20_1]:SetStatus((arg_20_0.chessNum_ < arg_20_0.prepareNum_ or table.indexof(var_20_0, iter_20_1)) and "green" or "red")
	end
end

function var_0_0.EndDragFunc(arg_21_0)
	if arg_21_0.prepareNum_ then
		for iter_21_0 = 1, arg_21_0.prepareNum_ do
			arg_21_0.posViewDic[iter_21_0]:SetStatus("white")
		end
	end
end

function var_0_0.CheckIndexIsEmpty(arg_22_0, arg_22_1)
	return arg_22_0.chessTeamDataList[arg_22_1] == nil
end

function var_0_0.CheckIndexIsPalyer(arg_23_0, arg_23_1)
	return arg_23_0.chessTeamDataList[arg_23_1] and AutoChessTools.IsPlayerChess(arg_23_0.chessTeamDataList[arg_23_1].chessId)
end

function var_0_0.RefreshEnterStatus(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.posViewDic[arg_24_1]:SetEnter(arg_24_2)
end

function var_0_0.ClickShopItemFunc(arg_25_0, arg_25_1)
	arg_25_0:BuyChess(arg_25_1)
end

function var_0_0.ClickPropItemFunc(arg_26_0, arg_26_1)
	arg_26_0:BuyProp(arg_26_1)
end

function var_0_0.ClickChessItemFunc(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.chessItemList) do
		if arg_27_1 and arg_27_1.index == iter_27_0 then
			iter_27_1:SetSelectChessState(true)
		else
			iter_27_1:SetSelectChessState(false)
		end
	end
end

function var_0_0.ClearPosData(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.index

	arg_28_0.chessTeamDataList[var_28_0] = nil

	arg_28_0.chessItemList[var_28_0]:SetData({
		index = var_28_0
	})

	arg_28_0.chessNum_ = arg_28_0.chessNum_ - 1
end

function var_0_0.ChangeItemPos(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_0.chessNum_ >= arg_29_0.prepareNum_ then
		return
	end

	local var_29_0 = arg_29_1.index
	local var_29_1 = 0
	local var_29_2 = 0
	local var_29_3 = (arg_29_3 == 0 or var_29_0 < arg_29_3) and 1 or -1

	for iter_29_0, iter_29_1 in ipairs({
		var_29_3,
		-var_29_3
	}) do
		local var_29_4 = var_29_0
		local var_29_5 = iter_29_1 == 1 and arg_29_0.prepareNum_ or 1

		for iter_29_2 = var_29_4, var_29_5, iter_29_1 do
			if not arg_29_0.chessTeamDataList[iter_29_2] then
				var_29_1 = iter_29_2
				var_29_2 = iter_29_1

				break
			end
		end

		if var_29_1 ~= 0 then
			break
		end
	end

	local var_29_6 = arg_29_0.chessItemList[var_29_1]

	arg_29_0.isMoving_ = true

	arg_29_0:RefreshItemMoveStatus(true)

	for iter_29_3 = var_29_1, var_29_0 + var_29_2, -var_29_2 do
		LeanTween.move(arg_29_0.chessItemList[iter_29_3 - var_29_2].gameObject_, arg_29_0.posViewDic[iter_29_3]:GetChessContainerTrans().position, 0.1):setOnComplete(LuaHelper.VoidAction(function()
			if iter_29_3 == var_29_0 + var_29_2 then
				arg_29_0.isMoving_ = false

				arg_29_0:RefreshItemMoveStatus(false)
			end
		end))

		arg_29_0.chessTeamDataList[iter_29_3] = arg_29_0.chessTeamDataList[iter_29_3 - var_29_2]
		arg_29_0.chessItemList[iter_29_3] = arg_29_0.chessItemList[iter_29_3 - var_29_2]

		arg_29_0.chessItemList[iter_29_3]:SetIndex(iter_29_3)
	end

	arg_29_0.chessTeamDataList[var_29_0] = nil
	arg_29_0.chessItemList[var_29_0] = var_29_6

	arg_29_0.chessItemList[var_29_0]:SetIndex(var_29_0)

	arg_29_0.chessItemList[var_29_0].transform_.position = arg_29_0.posViewDic[var_29_0]:GetChessContainerTrans().position

	if arg_29_2.shopType == nil then
		arg_29_0:SendChangeTeam(arg_29_2, var_29_0)
	else
		arg_29_0:SendChangeTeam()
	end
end

function var_0_0.SetItemToTargetIndex(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = clone(arg_31_1)
	local var_31_1 = arg_31_2

	if var_31_0.shopType == AutoChessConst.SHOP_TYPE.PROP then
		return
	end

	if var_31_0.shopType == nil then
		arg_31_0:SendChangeTeam(var_31_0, var_31_1)
	end
end

function var_0_0.PlayMerge(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.chessTeamDataList[arg_32_1]

	if var_32_0 then
		local var_32_1 = var_32_0.chessId
		local var_32_2 = AutoChessCfg[var_32_1]

		if var_32_1 == arg_32_2.chessId and arg_32_2.shopType ~= AutoChessConst.SHOP_TYPE.PROP and var_32_2.exp ~= "" and not var_32_0.attributeData.isMaxLevel then
			arg_32_0:OnMergeChessBackCall(arg_32_1, arg_32_2)
		end
	end
end

function var_0_0.MergeChessItem(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1.chessId == arg_33_0.chessTeamDataList[arg_33_2].chessId then
		arg_33_0:OnMergeChessBackCall(arg_33_2, arg_33_1)

		arg_33_0.chessTeamDataList[arg_33_2].attributeData.exp = arg_33_0.chessTeamDataList[arg_33_2].attributeData.exp + arg_33_1.attributeData.exp

		AutoChessTools.MergeChess(arg_33_0.gameType_, arg_33_0.chessTeamDataList[arg_33_2].uniqueId, arg_33_1.uniqueId)
	end
end

function var_0_0.OnMergeChessBackCall(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.chessItemList[arg_34_1] then
		arg_34_0.chessItemList[arg_34_1]:playLevelUpAnim(arg_34_2)
	end
end

function var_0_0.SendChangeTeam(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = clone(arg_35_0.chessTeamDataList) or {}
	local var_35_1 = {}

	for iter_35_0, iter_35_1 in pairs(var_35_0) do
		if iter_35_1 and iter_35_1.uniqueId ~= nil then
			table.insert(var_35_1, {
				key = iter_35_1.uniqueId,
				value = iter_35_1.index
			})
		end
	end

	if arg_35_1 and arg_35_2 then
		local var_35_2 = false

		for iter_35_2, iter_35_3 in pairs(var_35_0) do
			if iter_35_3.uniqueId == arg_35_1.uniqueId then
				var_35_2 = true

				break
			end
		end

		if not var_35_2 then
			table.insert(var_35_1, {
				key = arg_35_1.uniqueId,
				value = arg_35_2
			})
		end
	end

	AutoChessTools.ChangeChessTeam(arg_35_0.gameType_, var_35_1)
end

function var_0_0.GetIsMoving(arg_36_0)
	return arg_36_0.isMoving_
end

function var_0_0.RefreshChessLvAnim(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.chessItemList[arg_37_1]:UpdateLvUp(arg_37_2)
end

function var_0_0.RefreshItemMoveStatus(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.chessItemList) do
		iter_38_1:SetIsMoving(arg_38_1)
	end
end

function var_0_0.OnExit(arg_39_0)
	return
end

function var_0_0.Dispose(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0.posViewDic) do
		iter_40_1:Dispose()
	end

	arg_40_0.posViewDic = nil

	for iter_40_2, iter_40_3 in pairs(arg_40_0.chessItemList) do
		iter_40_3:Dispose()
	end

	arg_40_0.chessItemList = nil

	var_0_0.super.Dispose(arg_40_0)
end

return var_0_0
