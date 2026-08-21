local var_0_0 = class("ActivityNoobFirstRechargeView_1", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:GetUIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.type_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "type")
end

function var_0_0.GetUIName(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieRechargeUI_new"
	else
		return "Widget/System/Activitynewbie/NewbieRechargeUI_old"
	end
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.commonItem_:Dispose()

	arg_3_0.commonItem_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.sourceBtn_, nil, function()
		local var_5_0 = GameSetting.newbie_first_charge_reward_6.value[2]

		JumpTools.JumpToPage2(var_5_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(1, 0, function()
			arg_4_0:SetData()
		end)
	end)

	if arg_4_0.heroBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.heroBtn_, nil, function()
			local var_8_0 = ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]]

			if var_8_0.type == ItemConst.ITEM_TYPE.HERO_PIECE then
				local var_8_1 = var_8_0.id

				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = var_8_1
				})
			elseif var_8_0.type == ItemConst.ITEM_TYPE.GIFT then
				local var_8_2 = var_8_0.param[1][1]

				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = var_8_2
				})
			end
		end)
	end

	if arg_4_0.heroBtn2_ then
		arg_4_0:AddBtnListener(arg_4_0.heroBtn2_, nil, function()
			local var_9_0 = ItemCfg[GameSetting.newbie_first_charge_reward_6.value[3][1]]

			if var_9_0.type == ItemConst.ITEM_TYPE.HERO_PIECE then
				local var_9_1 = var_9_0.id

				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = var_9_1
				})
			elseif var_9_0.type == ItemConst.ITEM_TYPE.GIFT and #var_9_0.param > 1 then
				local var_9_2 = var_9_0.param[2][1]

				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = var_9_2
				})
			end
		end)
	end
end

function var_0_0.SetData(arg_10_0)
	arg_10_0.rewardCfg_ = GameSetting.newbie_first_charge_reward_6.value[3]

	if not arg_10_0.commonItem_ then
		local var_10_0 = clone(ItemTemplateData)

		var_10_0.id = arg_10_0.rewardCfg_[1]
		var_10_0.number = arg_10_0.rewardCfg_[2]

		function var_10_0.clickFun(arg_11_0)
			if arg_10_0.status_ == 1 then
				ActivityNewbieTools.ReceiveRechargeReward(1, 0, function()
					arg_10_0:SetData()
				end)
			else
				ShowPopItem(POP_ITEM, {
					arg_11_0.id,
					arg_11_0.number
				})
			end
		end

		arg_10_0.commonItem_ = CommonItemView.New(arg_10_0.commonGo_)

		arg_10_0.commonItem_:SetData(var_10_0)
	end

	local var_10_1 = ActivityNewbieTools.GetFirstRechargeStatus()
	local var_10_2 = var_10_1.firstGearStatus

	arg_10_0.status_ = var_10_1.firstGearStatus

	arg_10_0.statusController_:SetSelectedIndex(var_10_2)

	if arg_10_0.typeController_ then
		arg_10_0.typeController_:SetSelectedIndex(arg_10_0.type_)
	end

	ActivityNewbieTools.SetSelectFirstRecharge(1)
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

return var_0_0
