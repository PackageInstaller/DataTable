local var_0_0 = class("RechargeVoucherItem", ReduxView)

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

	arg_3_0.statusController_ = arg_3_0.transCon_:GetController("status")
	arg_3_0.lastController_ = arg_3_0.transCon_:GetController("last")
	arg_3_0.itemList_ = {}
	arg_3_0.itemParentList_ = {}
	arg_3_0.rewardControllerList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = arg_3_0["itemGo_" .. iter_3_0]
		local var_3_1 = arg_3_0["itemParent_" .. iter_3_0]
		local var_3_2 = arg_3_0.transCon_:GetController("reward" .. iter_3_0)

		if var_3_0 then
			arg_3_0.itemList_[iter_3_0] = CommonItemView.New(arg_3_0["itemGo_" .. iter_3_0])
		end

		if var_3_1 then
			arg_3_0.itemParentList_[iter_3_0] = var_3_1
		end

		if var_3_2 then
			arg_3_0.rewardControllerList_[iter_3_0] = var_3_2
		end
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		if arg_4_0.isVersion_ then
			PayAction.GetVersionRechargeBonus({
				arg_4_0.cfg_.id
			})
		else
			PayAction.GetTotalRechargeBonus({
				arg_4_0.cfg_.id
			})
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index_ = arg_8_1.index
	arg_8_0.isReceive_ = arg_8_1.isReceive
	arg_8_0.isVersion_ = arg_8_2
	arg_8_0.cfg_ = arg_8_2 and VersionRechargeCfg[arg_8_1.id] or TotalRechargeCfg[arg_8_1.id]
	arg_8_0.nextNum_ = arg_8_3 and TotalRechargeCfg[arg_8_3.id].num or 0

	if arg_8_0.lastController_ then
		arg_8_0.lastController_:SetSelectedState(tostring(arg_8_3 == nil))
	end

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.nameLabel_.text = string.format("%02d", arg_9_0.index_)
	arg_9_0.numText_.text = arg_9_0.cfg_.num

	local var_9_0 = arg_9_0.isVersion_ and 2 or 4
	local var_9_1 = arg_9_0.isVersion_ and arg_9_0.cfg_.reward or arg_9_0.cfg_.reward_show

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = var_9_1[iter_9_0]

		if var_9_2 then
			SetActive(arg_9_0.itemParentList_[iter_9_0], true)

			local var_9_3 = clone(ItemTemplateData)

			var_9_3.id = var_9_2[1]
			var_9_3.number = var_9_2[2]

			function var_9_3.clickFun(arg_10_0)
				ShowPopItem(POP_ITEM, {
					arg_10_0.id,
					arg_10_0.number
				})
			end

			arg_9_0.itemList_[iter_9_0]:SetData(var_9_3)
		else
			SetActive(arg_9_0.itemParentList_[iter_9_0], false)
		end

		if not arg_9_0.isVersion_ then
			arg_9_0.rewardControllerList_[iter_9_0]:SetSelectedState(var_9_2 and table.indexof(arg_9_0.cfg_.Important_rewards, iter_9_0) and "show" or "hide")
		end
	end

	local var_9_4 = arg_9_0.isVersion_ and RechargeData:GetVersionRechargeNum() or RechargeData:GetTotalRechargeNum()

	if not arg_9_0.isVersion_ and var_9_4 >= arg_9_0.cfg_.num then
		arg_9_0.slider_.value = arg_9_0.nextNum_ ~= 0 and (var_9_4 - arg_9_0.cfg_.num) / (arg_9_0.nextNum_ - arg_9_0.cfg_.num) or 1
	end

	if arg_9_0.isReceive_ then
		arg_9_0.statusController_:SetSelectedState("already_received")
	elseif var_9_4 >= arg_9_0.cfg_.num then
		arg_9_0.statusController_:SetSelectedState("receive")
	else
		arg_9_0.statusController_:SetSelectedState("not_reach")
	end
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList_) do
		iter_11_1:Dispose()

		iter_11_1 = nil
	end

	arg_11_0.itemList_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
