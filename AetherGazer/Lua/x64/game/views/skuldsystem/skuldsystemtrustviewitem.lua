local var_0_0 = class("SkuldSystemTrustViewItem", ReduxView)

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

	arg_3_0.btnController_ = arg_3_0.allBtnController_:GetController("all")

	for iter_3_0 = 1, 3 do
		arg_3_0["item" .. iter_3_0 .. "_"] = CommonItemView.New(arg_3_0["awardItem" .. iter_3_0 .. "Obj_"])
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.rewardID_ = arg_4_1
	arg_4_0.cfg_ = ActivityPointRewardCfg[arg_4_0.rewardID_]

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)
	local var_5_1 = arg_5_0.cfg_.need

	arg_5_0.titleText_.text = string.format(GetTips("SKULD_ICON_NEED"), var_5_1)

	if var_5_1 <= var_5_0 then
		arg_5_0.progressText_.text = var_5_1 .. "/" .. var_5_1
		arg_5_0.progressBar_.value = 1

		if SkuldSystemData:GetPointRewardIsGet(arg_5_0.rewardID_) then
			arg_5_0.btnController_:SetSelectedState("complete")
		else
			arg_5_0.btnController_:SetSelectedState("receive")
		end
	else
		arg_5_0.progressText_.text = var_5_0 .. "/" .. var_5_1
		arg_5_0.progressBar_.value = var_5_0 / var_5_1

		arg_5_0.btnController_:SetSelectedState("lock")
	end

	for iter_5_0 = 1, 3 do
		local var_5_2 = arg_5_0.cfg_.reward_item_list[iter_5_0]

		if var_5_2 then
			local var_5_3 = clone(ItemTemplateData)

			var_5_3.id = var_5_2[1]
			var_5_3.number = var_5_2[2]

			if SkuldSystemData:GetPointRewardIsGet(arg_5_0.rewardID_) then
				var_5_3.grayFlag = true
			else
				var_5_3.grayFlag = false
			end

			function var_5_3.clickFun(arg_6_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_6_0.id,
					arg_6_0.number
				})
			end

			arg_5_0["item" .. iter_5_0 .. "_"]:SetData(var_5_3)
		else
			arg_5_0["item" .. iter_5_0 .. "_"]:SetData(nil)
		end
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		if not (ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= arg_7_0.cfg_.need) or SkuldSystemData:GetPointRewardIsGet(arg_7_0.rewardID_) then
			-- block empty
		else
			ActivityAction.ReceivePointReward({
				arg_7_0.rewardID_
			})
		end
	end)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
