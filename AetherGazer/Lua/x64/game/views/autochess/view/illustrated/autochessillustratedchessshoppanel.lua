local var_0_0 = class("AutoChessIllustratedChessShopPanel", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.chessCardList = {}
	arg_2_0.propCardList = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.switchController_ = arg_3_0.switchController_:GetController("switch")
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("selectState")
	arg_3_0.selectQualityController_ = arg_3_0.selectInfoControllerEx_:GetController("QualityBg")
	arg_3_0.selectLvInfoItemList = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = string.format("selectTips%s_", iter_3_0)

		arg_3_0.selectLvInfoItemList[iter_3_0] = AutoChessLvInfoItem.New(arg_3_0[var_3_0])
	end

	arg_3_0.propDescrichText_ = arg_3_0:FindCom("RichText", "", arg_3_0.propDescTrs_)

	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.propDescrichText_, arg_3_0.button_, nil)
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0 = 1, 4 do
		local var_4_0 = string.format("switchBtn%s_", iter_4_0)

		arg_4_0:AddBtnListener(arg_4_0[var_4_0], nil, function()
			arg_4_0:ChangeSwitchStar(iter_4_0)
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.detailBtn_, nil, function()
		local var_6_0 = AutoChessCardCfg.get_id_list_by_group_id[arg_4_0.selectItemID]

		if var_6_0 == nil or #var_6_0 == 0 then
			return
		end

		table.sort(var_6_0, function(arg_7_0, arg_7_1)
			local var_7_0 = AutoChessCardCfg[arg_7_0]
			local var_7_1 = AutoChessCardCfg[arg_7_1]

			return var_7_0.type > var_7_1.type
		end)

		local var_6_1 = var_6_0[1]

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if AutoChessCardData:GetCardNum(iter_6_1) > 0 then
				var_6_1 = iter_6_1

				break
			end
		end

		JumpTools.OpenPageByJump("/autoChessCardDetailView", {
			cardId = var_6_1
		})
		OperationRecorder.RecordButtonTouch({
			source = 1,
			button_name = "activity_autochess_item_homepage_touch",
			activity_id = AutoChessData:GetActivityID(),
			item_id = arg_4_0.selectItemID
		})
	end)
end

function var_0_0.ChangeSwitchStar(arg_8_0, arg_8_1)
	if arg_8_0.selectSwitchStar == arg_8_1 then
		return
	end

	arg_8_0:RefreshStarUI(arg_8_1)
	arg_8_0.switchController_:SetSelectedIndex(arg_8_1 - 1)

	arg_8_0.selectSwitchStar = arg_8_1

	saveData("AutoChess", "IllustratedShopSwitch", arg_8_0.selectSwitchStar)
end

function var_0_0.RefreshStarUI(arg_9_0, arg_9_1)
	local var_9_0 = AutoChessTools.GetStarChessList(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0 or {}) do
		local var_9_1 = arg_9_0.chessCardList[iter_9_0]

		if var_9_1 == nil then
			var_9_1 = arg_9_0:CreateChessItem(arg_9_0.chessTrans_)
			arg_9_0.chessCardList[iter_9_0] = var_9_1
		end

		var_9_1:RefreshUI(iter_9_1, AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP)
		var_9_1:UpdateSelectState(var_9_1:IsMeetIDAndType(arg_9_0.selectItemID, arg_9_0.selectItemType))
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.chessCardList or {}) do
		iter_9_3:Show(iter_9_2 <= #var_9_0)
	end

	local var_9_2 = AutoChessTools.GetStarPropList(arg_9_1)

	for iter_9_4, iter_9_5 in pairs(var_9_2 or {}) do
		local var_9_3 = arg_9_0.propCardList[iter_9_4]

		if var_9_3 == nil then
			var_9_3 = arg_9_0:CreateChessItem(arg_9_0.propTrans_)
			arg_9_0.propCardList[iter_9_4] = var_9_3
		end

		var_9_3:RefreshUI(iter_9_5, AutoChessConst.ILLUSTRATE_TYPE.PROP_SHOP)
		var_9_3:UpdateSelectState(var_9_3:IsMeetIDAndType(arg_9_0.selectItemID, arg_9_0.selectItemType))
	end

	for iter_9_6, iter_9_7 in pairs(arg_9_0.propCardList or {}) do
		iter_9_7:Show(iter_9_6 <= #var_9_2)
	end

	arg_9_0:ClickChessItem(var_9_0[1], AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP)
end

function var_0_0.CreateChessItem(arg_10_0, arg_10_1)
	return AutoChessIllustatedShopItem.New(arg_10_0.cardPrefab_, arg_10_1, arg_10_0.scrollView_)
end

function var_0_0.ClickChessItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in pairs(arg_11_0.chessCardList or {}) do
		if iter_11_1:IsMeetIDAndType(arg_11_1, arg_11_2) then
			local var_11_1 = iter_11_1:GetSelectState()

			iter_11_1:UpdateSelectState(not var_11_1)

			var_11_0 = not var_11_1
		else
			iter_11_1:UpdateSelectState(false)
		end
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.propCardList or {}) do
		if iter_11_3:IsMeetIDAndType(arg_11_1, arg_11_2) then
			local var_11_2 = iter_11_3:GetSelectState()

			iter_11_3:UpdateSelectState(not var_11_2)

			var_11_0 = not var_11_2
		else
			iter_11_3:UpdateSelectState(false)
		end
	end

	arg_11_0.selectItemID = arg_11_1
	arg_11_0.selectItemType = arg_11_2

	if var_11_0 then
		arg_11_0:UpdateSelectInfo()
	else
		arg_11_0.selectController_:SetSelectedState("normal")
	end
end

function var_0_0.UpdateSelectInfo(arg_12_0)
	local var_12_0

	if arg_12_0.selectItemType == AutoChessConst.ILLUSTRATE_TYPE.CHESS_SHOP then
		arg_12_0.selectController_:SetSelectedState("selectChess")

		local var_12_1 = AutoChessCfg[arg_12_0.selectItemID]
		local var_12_2 = AutoChessCardCfg.get_id_list_by_group_id[var_12_1.group_id][1]
		local var_12_3 = AutoChessCardCfg[var_12_2]

		arg_12_0.selectQualityController_:SetSelectedIndex(var_12_1.star - 1)

		arg_12_0.chessIconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_12_3.pic)
		arg_12_0.chessNameText_.text = GetI18NText(var_12_1.name)

		for iter_12_0, iter_12_1 in pairs(arg_12_0.selectLvInfoItemList) do
			iter_12_1:RefreshUI(arg_12_0.selectItemID, iter_12_0)
		end
	else
		arg_12_0.selectController_:SetSelectedState("selectProp")

		local var_12_4 = AutoChessItemCfg[arg_12_0.selectItemID]

		arg_12_0.propIconImage_.sprite = AutoChessTools.GetPropIcon(var_12_4.icon)
		arg_12_0.propNameText_.text = GetI18NText(var_12_4.name)

		RichTextTools.SetMixedTextWithImage(arg_12_0.propDescrichText_, var_12_4.desc)

		arg_12_0.propDescrichText_.text = var_12_4.desc
	end
end

function var_0_0.GetDefaultSwitch(arg_13_0)
	return getData("AutoChess", "IllustratedShopSwitch") or 1
end

function var_0_0.OnEnter(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.selectSwitchStar = nil

	local var_14_0 = arg_14_0:GetDefaultSwitch()

	arg_14_0:ChangeSwitchStar(var_14_0)

	if not arg_14_2 and (AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0) then
		SetActive(arg_14_0.detailBtn_.gameObject, true)
	else
		SetActive(arg_14_0.detailBtn_.gameObject, false)
	end
end

function var_0_0.OnExit(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.chessCardList or {}) do
		if iter_16_1 then
			iter_16_1:Dispose()

			iter_16_1 = nil
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0.propCardList or {}) do
		if iter_16_3 then
			iter_16_3:Dispose()

			iter_16_3 = nil
		end
	end

	for iter_16_4, iter_16_5 in pairs(arg_16_0.selectLvInfoItemList or {}) do
		if iter_16_5 then
			iter_16_5:Dispose()

			iter_16_5 = nil
		end
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
