local var_0_0 = class("NewWarChessPopItemView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessActionUIPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.allProps = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]
	arg_3_0.selectNum_ = 0
	arg_3_0.canUseMaxNum_ = 0
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.btnController_ = ControllerUtil.GetController(arg_5_0.okBtn_.transform, "enabled")
	arg_5_0.scrollHelper = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.itemListGo_, CommonItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.propsBonds[arg_6_1]
	local var_6_1 = ItemTools.getItemNum(var_6_0)
	local var_6_2 = {
		id = var_6_0,
		number = var_6_1,
		type = ItemCfg[var_6_0].type
	}

	arg_6_2:RefreshData(var_6_2)
	arg_6_2:SetSelectType("equip")
	arg_6_2:ShowSelect(arg_6_1 == arg_6_0.selectInex and 1 or 0)
	arg_6_2:RegistCallBack(function(arg_7_0)
		if var_6_1 > 0 then
			arg_6_0.selectInex = arg_6_1
			arg_6_0.selectNum_ = 1

			arg_6_0:RefreshCanUseMaxNum()
			arg_6_0.scrollHelper:Refresh()
			arg_6_0:UpdateSliderPositionBySelectNum()
			arg_6_0:UpdatePreview()
		end
	end)
end

function var_0_0.RefreshCanUseMaxNum(arg_8_0)
	local var_8_0 = ItemCfg[arg_8_0.propsBonds[arg_8_0.selectInex]]
	local var_8_1 = ItemTools.getItemNum(arg_8_0.propsBonds[arg_8_0.selectInex])
	local var_8_2 = NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")
	local var_8_3 = NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max
	local var_8_4 = math.floor((var_8_3 - var_8_2) / var_8_0.param[1])
	local var_8_5 = math.min(var_8_4, var_8_1)
	local var_8_6 = math.min(var_8_5, NewChessTools.GetNewWarChessGameSetting("new_warchess_movepoint_usenum_max", NewWarChessData:GetCurrentMainActivity())[1])

	arg_8_0.canUseMaxNum_ = math.max(var_8_6, 0)

	if arg_8_0.canUseMaxNum_ <= 0 then
		arg_8_0.selectNum_ = 0
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btn_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.okBtn_, nil, function()
		local var_11_0 = arg_9_0.propsBonds[arg_9_0.selectInex]
		local var_11_1 = arg_9_0.selectNum_

		if var_11_1 > 0 then
			CommonAction.TryToUseItem({
				{
					item_info = {
						id = var_11_0,
						num = var_11_1
					},
					use_list = {
						NewWarChessData:GetCurrentWarChessMapID()
					}
				}
			})
		end
	end)
	arg_9_0.useNumSlider_.onValueChanged:AddListener(function()
		arg_9_0.selectNum_ = math.floor(arg_9_0.canUseMaxNum_ * arg_9_0.useNumSlider_.value + 1e-05)

		if arg_9_0.canUseMaxNum_ > 0 then
			if arg_9_0.selectNum_ < 1 then
				arg_9_0.selectNum_ = 1
			end
		elseif arg_9_0.canUseMaxNum_ <= 0 then
			arg_9_0.selectNum_ = 0
		end

		arg_9_0:UpdateSliderPositionBySelectNum()
		arg_9_0:UpdatePreview()
	end)
	arg_9_0:AddPressingByTimeListener(arg_9_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_9_0.selectNum_ > 1 then
			arg_9_0.selectNum_ = arg_9_0.selectNum_ - 1

			arg_9_0:UpdateSliderPositionBySelectNum()
			arg_9_0:UpdatePreview()

			return true
		end

		return false
	end)
	arg_9_0:AddPressingByTimeListener(arg_9_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_9_0.selectNum_ < arg_9_0.canUseMaxNum_ then
			arg_9_0.selectNum_ = arg_9_0.selectNum_ + 1

			arg_9_0:UpdateSliderPositionBySelectNum()
			arg_9_0:UpdatePreview()

			return true
		end

		return false
	end)
end

function var_0_0.OnTryToUseItem(arg_15_0, arg_15_1, arg_15_2)
	if isSuccess(arg_15_1.result) then
		local var_15_0 = arg_15_2.use_item_list[1].num * ItemCfg[arg_15_2.use_item_list[1].item_id].param[1]

		NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_15_0)
		JumpTools.Back()

		local var_15_1 = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_MOVEPOINT"), var_15_0)
		local var_15_2 = {
			tipsType = NewChessConst.TIPS_TYPE.NORMAL,
			tipsText = var_15_1
		}

		manager.NewChessManager:CreateTips(var_15_2)
	else
		ShowTips(arg_15_1.result)
	end
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.mainActivityID_ = arg_16_0.params_.mainActivityID
	arg_16_0.propsBonds = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.allProps) do
		if ItemCfg[iter_16_1].time[2][1] == arg_16_0.mainActivityID_ then
			table.insert(arg_16_0.propsBonds, iter_16_1)
		end
	end

	arg_16_0.selectInex = 0
	arg_16_0.selectNum_ = 0
	arg_16_0.canUseMaxNum_ = 0

	arg_16_0:RefreshTexts()

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.propsBonds) do
		if ItemTools.getItemNum(iter_16_3) > 0 then
			arg_16_0.selectInex = iter_16_2
			arg_16_0.selectNum_ = 1

			arg_16_0:RefreshCanUseMaxNum()
			arg_16_0:UpdateSliderPositionBySelectNum()
			arg_16_0:UpdatePreview()

			break
		end
	end

	arg_16_0.scrollHelper:StartScroll(#arg_16_0.propsBonds)

	if arg_16_0.selectInex == 0 then
		arg_16_0.selectNum_ = 0
		arg_16_0.canUseMaxNum_ = 0

		arg_16_0:UpdateSliderPositionBySelectNum()
		arg_16_0:UpdatePreview()
	end
end

function var_0_0.RefreshTexts(arg_17_0)
	arg_17_0.currencyText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))
end

function var_0_0.UpdateSliderPositionBySelectNum(arg_18_0)
	if arg_18_0.canUseMaxNum_ == 0 then
		arg_18_0.useNumSlider_.value = 0
	else
		arg_18_0.useNumSlider_.value = arg_18_0.selectNum_ / arg_18_0.canUseMaxNum_
	end
end

function var_0_0.UpdatePreview(arg_19_0)
	arg_19_0.useNumText_.text = arg_19_0.selectNum_

	if arg_19_0.selectNum_ == 0 then
		arg_19_0.getnumText_.text = 0

		arg_19_0.btnController_:SetSelectedState("false")

		arg_19_0.okBtn_.interactable = false
	else
		local var_19_0 = arg_19_0.propsBonds[arg_19_0.selectInex]
		local var_19_1 = ItemCfg[var_19_0].param[1] * arg_19_0.selectNum_

		arg_19_0.getnumText_.text = var_19_1

		arg_19_0.btnController_:SetSelectedState("true")

		arg_19_0.okBtn_.interactable = true
	end

	arg_19_0.delBtn_.interactable = arg_19_0.selectNum_ > 1
	arg_19_0.addBtn_.interactable = arg_19_0.selectNum_ < arg_19_0.canUseMaxNum_
	arg_19_0.okBtn_.interactable = arg_19_0.selectInex > 0
end

function var_0_0.OnExitInput(arg_20_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
