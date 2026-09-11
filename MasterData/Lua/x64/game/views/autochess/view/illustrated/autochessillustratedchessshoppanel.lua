local AutoChessIllustratedChessShopPanel = class("AutoChessIllustratedChessShopPanel", ReduxView)

function AutoChessIllustratedChessShopPanel:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessIllustratedChessShopPanel:Init()
	self:InitUI()
	self:AddUIListener()

	self.chessCardList = {}
	self.propCardList = {}
end

function AutoChessIllustratedChessShopPanel:InitUI()
	self:BindCfgUI()

	self.switchController_ = self.switchController_:GetController("switch")
	self.selectController_ = self.controllerEx_:GetController("selectState")
	self.selectQualityController_ = self.selectInfoControllerEx_:GetController("QualityBg")
	self.selectLvInfoItemList = {}

	for iter_3_0 = 1, 3 do
		self.selectLvInfoItemList[iter_3_0] = AutoChessLvInfoItem.New(self[string.format("selectTips%s_", iter_3_0)])
	end

	self.propDescrichText_ = self:FindCom("RichText", "", self.propDescTrs_)

	TerminologyTools.AddTerminologyHandler(self, self.propDescrichText_, self.button_, nil)
end

function AutoChessIllustratedChessShopPanel:AddUIListener()
	for iter_4_0 = 1, 4 do
		self:AddBtnListener(self[string.format("switchBtn%s_", iter_4_0)], nil, function()
			self:ChangeSwitchStar(iter_4_0)
		end)
	end

	self:AddBtnListener(self.detailBtn_, nil, function()
		if AutoChessCardCfg.get_id_list_by_group_id[self.selectItemID] == nil or #AutoChessCardCfg.get_id_list_by_group_id[self.selectItemID] == 0 then
			return
		end

		table.sort(AutoChessCardCfg.get_id_list_by_group_id[self.selectItemID], function(arg_7_0, arg_7_1)
			return AutoChessCardCfg[arg_7_0].type > AutoChessCardCfg[arg_7_1].type
		end)

		local var_6_0 = AutoChessCardCfg.get_id_list_by_group_id[self.selectItemID][1]

		for iter_6_0, iter_6_1 in ipairs(AutoChessCardCfg.get_id_list_by_group_id[self.selectItemID]) do
			if AutoChessCardData:GetCardNum(iter_6_1) > 0 then
				var_6_0 = iter_6_1

				break
			end
		end

		JumpTools.OpenPageByJump("/autoChessCardDetailView", {
			cardId = var_6_0
		})
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_item_homepage_touch",
			activity_id = AutoChessData:GetActivityID(),
			item_id = self.selectItemID
		})
	end)
end

function AutoChessIllustratedChessShopPanel:ChangeSwitchStar(arg_8_1)
	if self.selectSwitchStar == arg_8_1 then
		return
	end

	self:RefreshStarUI(arg_8_1)
	self.switchController_:SetSelectedIndex(arg_8_1 - 1)

	self.selectSwitchStar = arg_8_1

	saveData("AutoChess", "IllustratedShopSwitch", self.selectSwitchStar)
end

function AutoChessIllustratedChessShopPanel:RefreshStarUI(arg_9_1)
	local var_9_0 = AutoChessTools.GetStarChessList(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0 or {}) do
		local var_9_1 = self.chessCardList[iter_9_0]

		if self.chessCardList[iter_9_0] == nil then
			var_9_1 = self:CreateChessItem(self.chessTrans_)
			self.chessCardList[iter_9_0] = var_9_1
		end

		var_9_1:RefreshUI(iter_9_1, AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP)
		var_9_1:UpdateSelectState(var_9_1:IsMeetIDAndType(self.selectItemID, self.selectItemType))
	end

	for iter_9_2, iter_9_3 in pairs(self.chessCardList or {}) do
		iter_9_3:Show(iter_9_2 <= #var_9_0)
	end

	local var_9_2 = AutoChessTools.GetStarPropList(arg_9_1)

	for iter_9_4, iter_9_5 in pairs(var_9_2 or {}) do
		local var_9_3 = self.propCardList[iter_9_4]

		if self.propCardList[iter_9_4] == nil then
			var_9_3 = self:CreateChessItem(self.propTrans_)
			self.propCardList[iter_9_4] = var_9_3
		end

		var_9_3:RefreshUI(iter_9_5, AutoChessConst.ILLUSTRATE_TYPE.PROP_SHOP)
		var_9_3:UpdateSelectState(var_9_3:IsMeetIDAndType(self.selectItemID, self.selectItemType))
	end

	for iter_9_6, iter_9_7 in pairs(self.propCardList or {}) do
		iter_9_7:Show(iter_9_6 <= #var_9_2)
	end

	self:ClickChessItem(var_9_0[1], AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP)
end

function AutoChessIllustratedChessShopPanel:CreateChessItem(arg_10_1)
	return AutoChessIllustatedShopItem.New(self.cardPrefab_, arg_10_1, self.scrollView_)
end

function AutoChessIllustratedChessShopPanel:ClickChessItem(arg_11_1, arg_11_2)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in pairs(self.chessCardList or {}) do
		if iter_11_1:IsMeetIDAndType(arg_11_1, arg_11_2) then
			local var_11_1 = iter_11_1:GetSelectState()

			iter_11_1:UpdateSelectState(not var_11_1)

			var_11_0 = not var_11_1
		else
			iter_11_1:UpdateSelectState(false)
		end
	end

	for iter_11_2, iter_11_3 in pairs(self.propCardList or {}) do
		if iter_11_3:IsMeetIDAndType(arg_11_1, arg_11_2) then
			local var_11_2 = iter_11_3:GetSelectState()

			iter_11_3:UpdateSelectState(not var_11_2)

			var_11_0 = not var_11_2
		else
			iter_11_3:UpdateSelectState(false)
		end
	end

	self.selectItemID = arg_11_1
	self.selectItemType = arg_11_2

	if var_11_0 then
		self:UpdateSelectInfo()
	else
		self.selectController_:SetSelectedState("normal")
	end
end

function AutoChessIllustratedChessShopPanel:UpdateSelectInfo()
	if self.selectItemType == AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP then
		self.selectController_:SetSelectedState("selectChess")
		self.selectQualityController_:SetSelectedIndex(AutoChessCfg[self.selectItemID].star - 1)

		self.chessIconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. AutoChessCardCfg[AutoChessCardCfg.get_id_list_by_group_id[AutoChessCfg[self.selectItemID].group_id][1]].pic)
		self.chessNameText_.text = GetI18NText(AutoChessCfg[self.selectItemID].name)

		for iter_12_0, iter_12_1 in pairs(self.selectLvInfoItemList) do
			iter_12_1:RefreshUI(self.selectItemID, iter_12_0)
		end
	else
		self.selectController_:SetSelectedState("selectProp")

		self.propIconImage_.sprite = AutoChessTools.GetPropIcon(AutoChessItemCfg[self.selectItemID].icon)
		self.propNameText_.text = GetI18NText(AutoChessItemCfg[self.selectItemID].name)

		RichTextTools.SetMixedTextWithImage(self.propDescrichText_, AutoChessItemCfg[self.selectItemID].desc)

		self.propDescrichText_.text = AutoChessItemCfg[self.selectItemID].desc
	end
end

function AutoChessIllustratedChessShopPanel:GetDefaultSwitch()
	return getData("AutoChess", "IllustratedShopSwitch") or 1
end

function AutoChessIllustratedChessShopPanel:OnEnter(arg_14_1, arg_14_2)
	self.selectSwitchStar = nil

	self:ChangeSwitchStar((self:GetDefaultSwitch()))

	if not arg_14_2 and (AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0) then
		SetActive(self.detailBtn_.gameObject, true)
	else
		SetActive(self.detailBtn_.gameObject, false)
	end
end

function AutoChessIllustratedChessShopPanel:OnExit()
	return
end

function AutoChessIllustratedChessShopPanel:Dispose()
	for iter_16_0, iter_16_1 in pairs(self.chessCardList or {}) do
		if iter_16_1 then
			iter_16_1:Dispose()

			iter_16_1 = nil
		end
	end

	for iter_16_2, iter_16_3 in pairs(self.propCardList or {}) do
		if iter_16_3 then
			iter_16_3:Dispose()

			iter_16_3 = nil
		end
	end

	for iter_16_4, iter_16_5 in pairs(self.selectLvInfoItemList or {}) do
		if iter_16_5 then
			iter_16_5:Dispose()

			iter_16_5 = nil
		end
	end

	AutoChessIllustratedChessShopPanel.super.Dispose(self)
end

return AutoChessIllustratedChessShopPanel
