local var_0_0 = class("SpringPreheatPrayRewardItem", ReduxView)
local var_0_1 = {
	GO_SELECT = 1,
	SELECTING = 2
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.id_ = 0

	arg_2_0:SwitchToSelecting()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.goSelectController_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.selectingController_ = ControllerUtil.GetController(arg_3_0.transform_, "select")

	if arg_3_0.commonItemGo_ then
		arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
		arg_3_0.hasCommonItem_ = true
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.onClickHandler_ then
			arg_4_0.onClickHandler_(arg_4_0)
		end
	end)

	if arg_4_0.commonItem_ then
		arg_4_0.commonItem_:RegistCallBack(function(arg_6_0)
			if arg_4_0.onClickHandler_ then
				arg_4_0.onClickHandler_(arg_4_0)
			end
		end)
	end
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.onClickHandler_ = arg_7_1
	end
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.commonItem_ then
		arg_10_0.commonItem_:Dispose()

		arg_10_0.commonItem_ = nil
	end

	arg_10_0.super.Dispose(arg_10_0)
end

function var_0_0.SwitchToGoSelect(arg_11_0)
	arg_11_0.mode_ = var_0_1.GO_SELECT
end

function var_0_0.SwitchToSelecting(arg_12_0)
	arg_12_0.mode_ = var_0_1.SELECTING
end

function var_0_0.SetSelected(arg_13_0, arg_13_1)
	arg_13_0.selected_ = arg_13_1

	return arg_13_0.selected_
end

function var_0_0.SetSelectable(arg_14_0, arg_14_1)
	arg_14_0.selectable_ = arg_14_1

	return arg_14_0.selectable_
end

function var_0_0.SetData(arg_15_0, arg_15_1)
	arg_15_0.id_ = arg_15_1
	arg_15_0.poolId_ = SpringPreheatData:GetPoolId()

	arg_15_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_16_0)
	if arg_16_0.mode_ == var_0_1.GO_SELECT then
		arg_16_0.goSelectController_:SetSelectedState(arg_16_0:CanGoSelect() and "true" or "false")
	elseif arg_16_0.selectable_ then
		arg_16_0.selectingController_:SetSelectedState(arg_16_0.selected_ and "clicked" or "selectable")
	else
		arg_16_0.selectingController_:SetSelectedState("selected")
	end

	arg_16_0:RefreshItemUI()
end

function var_0_0.RefreshItemUI(arg_17_0)
	if arg_17_0.id_ == 0 then
		arg_17_0.itemID_ = 0

		if arg_17_0.hasCommonItem_ then
			SetActive(arg_17_0.commonItemGo_, false)
		end

		SetActive(arg_17_0.iconGo_, false)

		return
	end

	local var_17_0, var_17_1 = KagutsuchiGachaData:GetDrawItemReward(arg_17_0.poolId_, arg_17_0.id_)

	arg_17_0.itemID_ = var_17_0

	if arg_17_0.hasCommonItem_ then
		arg_17_0.commonItem_:RefreshData({
			id = var_17_0,
			number = var_17_1
		})
		SetActive(arg_17_0.commonItemGo_, true)
	else
		arg_17_0.icon_.sprite = ItemTools.getItemSprite(var_17_0)

		SetActive(arg_17_0.iconGo_, true)
	end
end

function var_0_0.GetItemId(arg_18_0)
	return arg_18_0.itemID_
end

function var_0_0.CanGoSelect(arg_19_0)
	return arg_19_0.id_ ~= 0 and arg_19_0.mode_ == var_0_1.GO_SELECT
end

return var_0_0
