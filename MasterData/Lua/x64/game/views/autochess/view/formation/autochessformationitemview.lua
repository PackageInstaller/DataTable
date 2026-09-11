local AutoChessFormationItemView = class("AutoChessFormationItemView", ReduxView)

function AutoChessFormationItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.gameType_ = AutoChessConst.GAME_TYPE.PVE
	self.posViewDic = {}
	self.chessItemList = {}
	self.playerType_ = AutoChessConst.PLAYER_TYPE.SELF

	self:Init()
end

function AutoChessFormationItemView:Init()
	self:BindCfgUI()
	self:InitChessContainer()
	self:InitChessItemContainer()
end

function AutoChessFormationItemView:InitChessContainer()
	for iter_3_0 = 1, self.posPanelTrans_.childCount do
		self.posViewDic[iter_3_0] = AutoChessFormationPosView.New(self.posPanelTrans_:Find("formationPos_" .. iter_3_0).gameObject)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.posPanelTrans_)
end

function AutoChessFormationItemView:SetGameType(arg_4_1)
	self.gameType_ = arg_4_1
end

function AutoChessFormationItemView:SetPlayerType(arg_5_1)
	self.playerType_ = arg_5_1
end

function AutoChessFormationItemView:InitChessItemContainer()
	for iter_6_0 = 1, self.chessPanelTrans_.childCount do
		local var_6_0 = AutoChessTeamItem.New(self.chessPanelTrans_:GetChild(iter_6_0 - 1).gameObject)

		var_6_0.transform_.position = self.posViewDic[iter_6_0]:GetChessContainerTrans().position

		table.insert(self.chessItemList, var_6_0)
	end
end

function AutoChessFormationItemView:GetPosItem(arg_7_1)
	return self.posViewDic[arg_7_1]
end

function AutoChessFormationItemView:GetChessContainerTrans(arg_8_1)
	return self.posViewDic[arg_8_1]:GetChessContainerTrans()
end

function AutoChessFormationItemView:GetChessPos(arg_9_1)
	return self.chessPanelTrans_:InverseTransformPoint(self:GetChessContainerTrans(arg_9_1).position)
end

function AutoChessFormationItemView:GetChessPanelTrans()
	return self.chessPanelTrans_
end

function AutoChessFormationItemView:GetChessItem(arg_11_1)
	return self.chessItemList[arg_11_1]
end

function AutoChessFormationItemView:GetChessItemByUniqueId(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.chessItemList) do
		if iter_12_1.chessItemData_ and iter_12_1.chessItemData_.uniqueId == arg_12_1 then
			return iter_12_1
		end
	end
end

function AutoChessFormationItemView:RemoveChessItemByUniqueId(arg_13_1)
	for iter_13_0 = 1, #self.chessItemList do
		if self.chessItemList[iter_13_0].chessItemData_ and self.chessItemList[iter_13_0].chessItemData_.uniqueId == arg_13_1 then
			self:ClearPosData(self.chessItemList[iter_13_0].chessItemData_)

			break
		end
	end
end

function AutoChessFormationItemView:GetChessItemList()
	return self.chessItemList
end

function AutoChessFormationItemView:GetChessNum()
	return self.chessNum_
end

function AutoChessFormationItemView:UpdatePrepareTeamInfo(arg_16_1)
	self.chessTeamDataList = arg_16_1
	self.prepareNum_ = tonumber(AutoChessTools.GetPrepareNum(self.gameType_))
	self.chessNum_ = 0

	for iter_16_0 = 1, self.prepareNum_ do
		local var_16_0 = self.chessTeamDataList[iter_16_0]
		local var_16_1 = self.chessItemList[iter_16_0]

		if self.chessTeamDataList[iter_16_0] ~= nil then
			self.chessNum_ = self.chessNum_ + 1 or self.chessNum_
		end

		var_16_1:SetPlayerType(self.playerType_)
		var_16_1:SetData(var_16_0 or {
			index = iter_16_0
		})
		var_16_1:SetGameType(self.gameType_)
	end
end

function AutoChessFormationItemView:BeginDragFunc(arg_17_1)
	self:BuyChess(arg_17_1)
end

function AutoChessFormationItemView:BeginPropDragFunc(arg_18_1)
	self:BuyProp(arg_18_1)
end

function AutoChessFormationItemView:BuyProp(arg_19_1)
	local var_19_0 = AutoChessItemCfg[arg_19_1.chessId]

	for iter_19_0 = 1, self.prepareNum_ do
		if self.chessTeamDataList[iter_19_0] then
			if var_19_0.relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER and AutoChessTools.IsPlayerChess(self.chessTeamDataList[iter_19_0].chessId) or not AutoChessTools.CheckUseProp(arg_19_1.chessId, self.gameType_, self.chessTeamDataList[iter_19_0]) then
				self.posViewDic[iter_19_0]:SetStatus("red")
			else
				self.posViewDic[iter_19_0]:SetStatus("green")
			end
		else
			self.posViewDic[iter_19_0]:SetStatus("white")
		end
	end
end

function AutoChessFormationItemView:BuyChess(arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = 1, self.prepareNum_ do
		if self.chessTeamDataList[iter_20_0] and self.chessTeamDataList[iter_20_0].chessId == arg_20_1.chessId then
			table.insert(var_20_0, iter_20_0)
		end
	end

	for iter_20_1 = 1, self.prepareNum_ do
		self.posViewDic[iter_20_1]:SetStatus((self.chessNum_ < self.prepareNum_ or table.indexof(var_20_0, iter_20_1)) and "green" or "red")
	end
end

function AutoChessFormationItemView:EndDragFunc()
	if self.prepareNum_ then
		for iter_21_0 = 1, self.prepareNum_ do
			self.posViewDic[iter_21_0]:SetStatus("white")
		end
	end
end

function AutoChessFormationItemView:CheckIndexIsEmpty(arg_22_1)
	return self.chessTeamDataList[arg_22_1] == nil
end

function AutoChessFormationItemView:CheckIndexIsPalyer(arg_23_1)
	return self.chessTeamDataList[arg_23_1] and AutoChessTools.IsPlayerChess(self.chessTeamDataList[arg_23_1].chessId)
end

function AutoChessFormationItemView:RefreshEnterStatus(arg_24_1, arg_24_2)
	self.posViewDic[arg_24_1]:SetEnter(arg_24_2)
end

function AutoChessFormationItemView:ClickShopItemFunc(arg_25_1)
	self:BuyChess(arg_25_1)
end

function AutoChessFormationItemView:ClickPropItemFunc(arg_26_1)
	self:BuyProp(arg_26_1)
end

function AutoChessFormationItemView:ClickChessItemFunc(arg_27_1)
	for iter_27_0, iter_27_1 in pairs(self.chessItemList) do
		if arg_27_1 and arg_27_1.index == iter_27_0 then
			iter_27_1:SetSelectChessState(true)
		else
			iter_27_1:SetSelectChessState(false)
		end
	end
end

function AutoChessFormationItemView:ClearPosData(arg_28_1)
	self.chessTeamDataList[arg_28_1.index] = nil

	self.chessItemList[arg_28_1.index]:SetData({
		index = arg_28_1.index
	})

	self.chessNum_ = self.chessNum_ - 1
end

function AutoChessFormationItemView:ChangeItemPos(arg_29_1, arg_29_2, arg_29_3)
	if self.chessNum_ >= self.prepareNum_ then
		return
	end

	local var_29_0 = arg_29_1.index
	local var_29_1 = 0
	local var_29_2 = 0

	for iter_29_0, iter_29_1 in ipairs({
		(arg_29_3 == 0 or var_29_0 < arg_29_3) and 1 or -1,
		-((arg_29_3 == 0 or var_29_0 < arg_29_3) and 1 or -1)
	}) do
		for iter_29_2 = var_29_0, (iter_29_1 == 1 or nil) and (self.prepareNum_ or 1), iter_29_1 do
			if not self.chessTeamDataList[iter_29_2] then
				var_29_1 = iter_29_2
				var_29_2 = iter_29_1

				break
			end
		end

		if var_29_1 ~= 0 then
			break
		end
	end

	local var_29_4 = self.chessItemList[var_29_1]

	self.isMoving_ = true

	self:RefreshItemMoveStatus(true)

	for iter_29_3 = var_29_1, var_29_0 + var_29_2, -var_29_2 do
		LeanTween.move(self.chessItemList[iter_29_3 - var_29_2].gameObject_, self.posViewDic[iter_29_3]:GetChessContainerTrans().position, 0.1):setOnComplete(LuaHelper.VoidAction(function()
			if iter_29_3 == var_29_0 + var_29_2 then
				self.isMoving_ = false

				self:RefreshItemMoveStatus(false)
			end
		end))

		self.chessTeamDataList[iter_29_3] = self.chessTeamDataList[iter_29_3 - var_29_2]
		self.chessItemList[iter_29_3] = self.chessItemList[iter_29_3 - var_29_2]

		self.chessItemList[iter_29_3]:SetIndex(iter_29_3)
	end

	self.chessTeamDataList[var_29_0] = nil
	self.chessItemList[var_29_0] = var_29_4

	self.chessItemList[var_29_0]:SetIndex(var_29_0)

	self.chessItemList[var_29_0].transform_.position = self.posViewDic[var_29_0]:GetChessContainerTrans().position

	if arg_29_2.shopType == nil then
		self:SendChangeTeam(arg_29_2, var_29_0)
	else
		self:SendChangeTeam()
	end
end

function AutoChessFormationItemView:SetItemToTargetIndex(arg_31_1, arg_31_2)
	local var_31_0 = clone(arg_31_1)

	if var_31_0.shopType == AutoChessConst.SHOP_TYPE.PROP then
		return
	end

	if var_31_0.shopType == nil then
		self:SendChangeTeam(var_31_0, arg_31_2)
	end
end

function AutoChessFormationItemView:PlayMerge(arg_32_1, arg_32_2)
	if self.chessTeamDataList[arg_32_1] then
		if self.chessTeamDataList[arg_32_1].chessId == arg_32_2.chessId and arg_32_2.shopType ~= AutoChessConst.SHOP_TYPE.PROP and AutoChessCfg[self.chessTeamDataList[arg_32_1].chessId].exp ~= "" and not self.chessTeamDataList[arg_32_1].attributeData.isMaxLevel then
			self:OnMergeChessBackCall(arg_32_1, arg_32_2)
		end
	end
end

function AutoChessFormationItemView:MergeChessItem(arg_33_1, arg_33_2)
	if arg_33_1.chessId == self.chessTeamDataList[arg_33_2].chessId then
		self:OnMergeChessBackCall(arg_33_2, arg_33_1)

		self.chessTeamDataList[arg_33_2].attributeData.exp = self.chessTeamDataList[arg_33_2].attributeData.exp + arg_33_1.attributeData.exp

		AutoChessTools.MergeChess(self.gameType_, self.chessTeamDataList[arg_33_2].uniqueId, arg_33_1.uniqueId)
	end
end

function AutoChessFormationItemView:OnMergeChessBackCall(arg_34_1, arg_34_2)
	if self.chessItemList[arg_34_1] then
		self.chessItemList[arg_34_1]:playLevelUpAnim(arg_34_2)
	end
end

function AutoChessFormationItemView:SendChangeTeam(arg_35_1, arg_35_2)
	local var_35_0 = clone(self.chessTeamDataList) or {}
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

	AutoChessTools.ChangeChessTeam(self.gameType_, var_35_1)
end

function AutoChessFormationItemView:GetIsMoving()
	return self.isMoving_
end

function AutoChessFormationItemView:RefreshChessLvAnim(arg_37_1, arg_37_2)
	self.chessItemList[arg_37_1]:UpdateLvUp(arg_37_2)
end

function AutoChessFormationItemView:RefreshItemMoveStatus(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self.chessItemList) do
		iter_38_1:SetIsMoving(arg_38_1)
	end
end

function AutoChessFormationItemView:OnExit()
	return
end

function AutoChessFormationItemView:Dispose()
	for iter_40_0, iter_40_1 in pairs(self.posViewDic) do
		iter_40_1:Dispose()
	end

	self.posViewDic = nil

	for iter_40_2, iter_40_3 in pairs(self.chessItemList) do
		iter_40_3:Dispose()
	end

	self.chessItemList = nil

	AutoChessFormationItemView.super.Dispose(self)
end

return AutoChessFormationItemView
