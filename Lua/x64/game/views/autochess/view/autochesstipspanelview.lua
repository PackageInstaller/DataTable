local var_0_0 = class("AutoChessTipsPanelView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.orignalPos = arg_1_0.transform_.position
	arg_1_0.BuffList_ = {}
	arg_1_0.SepcBuffList_ = {}
	arg_1_0.buffTipsWidth = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:InitController()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
		if arg_3_0.closeCallback_ then
			arg_3_0.closeCallback_()
		end

		arg_3_0:SetActive(false)
	end)
	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.playerDescText_, arg_3_0.playerButton_, nil)
	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.descText_, arg_3_0.descButton_, nil)
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.typeController_ = arg_5_0.controllerEx_:GetController("type")
	arg_5_0.tagListController_ = arg_5_0.normalContronllerEx_:GetController("tagList")
	arg_5_0.showCostController_ = arg_5_0.normalContronllerEx_:GetController("cost")
	arg_5_0.tipsStatusController_ = arg_5_0.tipsControllerEx_:GetController("status")
	arg_5_0.levelController_ = arg_5_0.tipsControllerEx_:GetController("level")

	arg_5_0.tipsStatusController_:SetSelectedState("hide")
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.buffTipsWidth = 0

	arg_6_0.tipsStatusController_:SetSelectedState("chess")

	arg_6_0.chessItemData_ = arg_6_1

	arg_6_0:CloseSubTips()

	if arg_6_1.shopType ~= AutoChessConst.SHOP_TYPE.PROP then
		arg_6_0.chessCfg_ = AutoChessCfg[arg_6_1.chessId]

		arg_6_0:UpdateChessUI()
	else
		arg_6_0:UpdateItemUI()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.tipsTrans_)
end

function var_0_0.SetGoldState(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.showCostController_:SetSelectedState("on")
	else
		arg_7_0.showCostController_:SetSelectedState("off")
	end
end

function var_0_0.SetPos(arg_8_0, arg_8_1)
	arg_8_0.transform_.position = arg_8_1
end

function var_0_0.SetLocalPos(arg_9_0, arg_9_1)
	arg_9_0.transform_.localPosition = arg_9_1
end

function var_0_0.GetLocalPos(arg_10_0)
	return arg_10_0.transform_.localPosition
end

function var_0_0.GetTipsPos(arg_11_0)
	return arg_11_0.tipsTrans_.localPosition
end

function var_0_0.GetTipsHeight(arg_12_0)
	return arg_12_0.tipsTrans_.rect.height
end

function var_0_0.GetTipsWidth(arg_13_0)
	return arg_13_0.tipsTrans_.rect.width
end

function var_0_0.SetPivot(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.tipsTrans_.pivot = Vector2(arg_14_1, arg_14_2)
end

function var_0_0.ResetPos(arg_15_0)
	arg_15_0:SetPos(arg_15_0.orignalPos)
end

function var_0_0.UpdateChessUI(arg_16_0)
	arg_16_0:UpdateChessInfo()
	arg_16_0:UpdateTagList()
end

function var_0_0.UpdateChessInfo(arg_17_0)
	local var_17_0 = AutoChessCfg[arg_17_0.chessItemData_.chessId]

	if var_17_0.type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		arg_17_0:UpdateAdminChessInfo()
	elseif var_17_0.type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS then
		arg_17_0:UpdateOpAdminChessInfo()
	else
		arg_17_0:UpdateNormalChessInfo()
	end
end

function var_0_0.UpdateAdminChessInfo(arg_18_0)
	arg_18_0.typeController_:SetSelectedState("special")

	local var_18_0 = AutoChessCfg[arg_18_0.chessItemData_.chessId]

	arg_18_0.playerNameText_.text = var_18_0.name

	local var_18_1 = var_18_0.level_buffs[3][1]

	if arg_18_0.chessItemData_.buffList and not table.indexof(arg_18_0.chessItemData_.buffList, var_18_1) then
		local var_18_2 = GetTips("AUTO_CHESS_BOSS_404")

		RichTextTools.SetMixedTextWithImage(arg_18_0.playerDescText_, var_18_2)

		arg_18_0.playerDescText_.text = var_18_2
	else
		AutoChessTools.GetChessBuffDesc(arg_18_0.chessItemData_, var_18_1, arg_18_0.playerDescText_)
	end

	arg_18_0.adminIcon_.sprite = AutoChessTools.GetChessBody(arg_18_0.chessItemData_.chessId)

	local var_18_3 = AutoChessTools.GetPlayerChessLevelBuff(var_18_0)

	arg_18_0:UpdatePlayerBuffTips(var_18_3)
	arg_18_0:UpdateBuffTips()
end

function var_0_0.UpdateOpAdminChessInfo(arg_19_0)
	arg_19_0.typeController_:SetSelectedState("special")

	local var_19_0 = AutoChessCfg[arg_19_0.chessItemData_.chessId]

	arg_19_0.playerNameText_.text = var_19_0.name

	local var_19_1 = var_19_0.level_buffs[1][1]

	arg_19_0.adminIcon_.sprite = AutoChessTools.GetChessBody(arg_19_0.chessItemData_.chessId)

	local var_19_2 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0.level_buffs) do
		if iter_19_0 ~= 1 then
			table.insert(var_19_2, iter_19_1)
		end
	end

	arg_19_0:UpdatePlayerBuffTips(var_19_2)
	arg_19_0:UpdateBuffTips()
	AutoChessTools.GetChessBuffDesc(arg_19_0.chessItemData_, var_19_1, arg_19_0.playerDescText_)
end

function var_0_0.UpdateNormalChessInfo(arg_20_0)
	arg_20_0.typeController_:SetSelectedState("normal")
	arg_20_0.tagListController_:SetSelectedState("on")

	local var_20_0 = AutoChessCfg[arg_20_0.chessItemData_.chessId]

	arg_20_0.nameText_.text = var_20_0.name
	arg_20_0.iconImg_.sprite = AutoChessTools.GetChessBody(arg_20_0.chessItemData_.chessId)

	if arg_20_0.chessItemData_.shopType ~= nil then
		local var_20_1 = AutoChessTools.GetAttrValue(nil, AutoChessConst.ATTR_KEY.SHOP_FREE_CHESS_COUNT) > 0

		arg_20_0.costText_.text = var_20_1 and 0 or var_20_0.shop_price
	else
		if var_20_0.sell_price ~= "" then
			arg_20_0.costText_.text = "+" .. var_20_0.sell_price[arg_20_0.chessItemData_.attributeData.level]
		end

		arg_20_0:UpdateBuffTips()
	end

	local var_20_2 = var_20_0.level_buffs ~= "" and var_20_0.level_buffs[arg_20_0.chessItemData_.attributeData.level][1] or nil

	AutoChessTools.GetChessBuffDesc(arg_20_0.chessItemData_, var_20_2, arg_20_0.descText_)
	arg_20_0.levelController_:SetSelectedIndex(var_20_0.star - 1)
end

function var_0_0.UpdatePlayerBuffTips(arg_21_0, arg_21_1)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1) do
			if table.indexof(arg_21_0.chessItemData_.buffList, iter_21_3) then
				var_21_0 = var_21_0 + 1

				if not arg_21_0.SepcBuffList_[iter_21_0] then
					local var_21_1 = Object.Instantiate(arg_21_0.tipsSepcSubGo_, arg_21_0.specSubRect_)
					local var_21_2 = AutoChessTipsSepcSubItem.New(var_21_1)

					arg_21_0.SepcBuffList_[iter_21_0] = var_21_2
				end

				arg_21_0.SepcBuffList_[iter_21_0]:SetData(iter_21_3, iter_21_0, arg_21_0.chessItemData_)
				arg_21_0.SepcBuffList_[iter_21_0]:SetActive(true)

				break
			end
		end
	end

	if var_21_0 > 0 then
		SetActive(arg_21_0.specSubRect_.gameObject, true)
	end
end

function var_0_0.CloseSubTips(arg_22_0)
	SetActive(arg_22_0.specSubRect_.gameObject, false)

	for iter_22_0, iter_22_1 in pairs(arg_22_0.SepcBuffList_) do
		iter_22_1:SetActive(false)
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.BuffList_) do
		iter_22_3:SetActive(false)
	end
end

function var_0_0.UpdateBuffTips(arg_23_0)
	local var_23_0 = 0

	arg_23_0.buffTipsWidth = 0

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.chessItemData_:GetBuffList()) do
		if arg_23_0.chessItemData_.uniqueId ~= iter_23_1:GetBuffSourceUid() then
			local var_23_1 = iter_23_1:GetBuffID()

			if AutoChessBuffCfg[var_23_1].is_show == 1 then
				var_23_0 = var_23_0 + 1
				arg_23_0.buffTipsWidth = 576

				if not arg_23_0.BuffList_[var_23_0] then
					local var_23_2 = Object.Instantiate(arg_23_0.tipSubGo_, arg_23_0.sideListRect_)
					local var_23_3 = AutoChessTipsSubItem.New(var_23_2)

					arg_23_0.BuffList_[var_23_0] = var_23_3
				end

				arg_23_0.BuffList_[var_23_0]:SetData(var_23_1, arg_23_0.chessItemData_)
				arg_23_0.BuffList_[var_23_0]:SetActive(true)
			end
		end
	end
end

function var_0_0.UpdateItemUI(arg_24_0, arg_24_1)
	arg_24_0.typeController_:SetSelectedState("normal")
	arg_24_0.tagListController_:SetSelectedState("off")

	local var_24_0 = AutoChessItemCfg[arg_24_0.chessItemData_.chessId]

	arg_24_0.nameText_.text = var_24_0.name
	arg_24_0.iconImg_.sprite = AutoChessTools.GetPropIcon(var_24_0.icon)

	local var_24_1 = AutoChessTools.GetAttrValue(nil, AutoChessConst.ATTR_KEY.SHOP_FREE_PROP_COUNT) > 0

	arg_24_0.costText_.text = var_24_1 and 0 or var_24_0.shop_price

	RichTextTools.SetMixedTextWithImage(arg_24_0.descText_, var_24_0.desc)

	arg_24_0.descText_.text = var_24_0.desc

	arg_24_0.levelController_:SetSelectedIndex(var_24_0.star - 1)
end

function var_0_0.SetActive(arg_25_0, arg_25_1)
	if arg_25_1 then
		arg_25_0.tipsStatusController_:SetSelectedState("chess")
	else
		arg_25_0.tipsStatusController_:SetSelectedState("hide")
	end
end

function var_0_0.UpdateTagList(arg_26_0)
	local var_26_0 = arg_26_0.tagListGo_.transform

	for iter_26_0 = 1, arg_26_0.tagListGo_.transform.childCount do
		if table.indexof(arg_26_0.chessCfg_.label, iter_26_0) then
			SetActive(var_26_0:GetChild(iter_26_0 - 1), true)
		else
			SetActive(var_26_0:GetChild(iter_26_0 - 1), false)
		end
	end
end

function var_0_0.RegistCloseCallback(arg_27_0, arg_27_1)
	arg_27_0.closeCallback_ = arg_27_1
end

function var_0_0.GetBuffWidth(arg_28_0)
	return arg_28_0.buffTipsWidth
end

function var_0_0.Dispose(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.SepcBuffList_) do
		iter_29_1:Dispose()
	end

	for iter_29_2, iter_29_3 in pairs(arg_29_0.BuffList_) do
		iter_29_3:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
