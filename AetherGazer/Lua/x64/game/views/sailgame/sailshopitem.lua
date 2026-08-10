local var_0_0 = class("SailShopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_5_0 = SailGameData:GetCurGameData(arg_4_0.activityID_).curStageIndex

		SailGameAction.EventOperate(arg_4_0.activityID_, var_5_0, arg_4_0.index_)
	end)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.commonItem_:Dispose()

	arg_6_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.goodData_ = arg_7_2
	arg_7_0.index_ = arg_7_3

	arg_7_0:RefreshUI()
	arg_7_0:UpdateStatus()
end

function var_0_0.UpdateStatus(arg_8_0)
	if arg_8_0.goodData_.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT then
		arg_8_0.statusController_:SetSelectedState("soldOut")
	elseif ItemTools.getItemNum(arg_8_0.goodData_.costID) < arg_8_0.goodData_.costNum then
		arg_8_0.statusController_:SetSelectedState("off")
	else
		arg_8_0.statusController_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshUI(arg_9_0)
	if not arg_9_0.commonItem_ then
		arg_9_0.commonItem_ = CommonItem.New(arg_9_0.commonItemGo_)

		arg_9_0.commonItem_:RegistCallBack(function()
			if arg_9_0.clickCallback_ then
				if arg_9_0.clickCallback_() then
					ShowPopItem(POP_ITEM, arg_9_0.costCfg_)
				end
			else
				ShowPopItem(POP_ITEM, arg_9_0.costCfg_)
			end
		end)
	end

	arg_9_0.costCfg_ = {
		arg_9_0.goodData_.costID,
		arg_9_0.goodData_.costNum
	}

	arg_9_0.commonItem_:RefreshData(formatReward(arg_9_0.costCfg_))

	local var_9_0 = ItemTools.getItemNum(arg_9_0.costCfg_[1])

	arg_9_0.commonItem_:SetBottomText(string.format("%s/%s", var_9_0, arg_9_0.costCfg_[2]))

	arg_9_0.goodIcon_.sprite = ItemTools.getItemSprite(arg_9_0.goodData_.goodID)
	arg_9_0.goodNumText_.text = arg_9_0.goodData_.goodNum
end

return var_0_0
