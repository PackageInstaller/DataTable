local var_0_0 = class("PassportRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonItem1_ = CommonItemView.New(arg_3_0.commonItemGo1_)
	arg_3_0.commonItem2_ = CommonItemView.New(arg_3_0.commonItemGo2_)
	arg_3_0.CommonData1 = clone(ItemTemplateData)
	arg_3_0.CommonData2 = clone(ItemTemplateData)
end

function var_0_0.AddEventListeners(arg_4_0)
	arg_4_0:RegistEventListener(GET_BONUS_SUCCESS, handler(arg_4_0, arg_4_0.OnGetBonus))
	arg_4_0:RegistEventListener(PASSPORT_BUYED, handler(arg_4_0, arg_4_0.OnPassportBuyed))
end

function var_0_0.OnPassportBuyed(arg_5_0)
	arg_5_0:UpdateView()
end

function var_0_0.OnGetBonus(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.cfg_.id or arg_6_1 == 0 then
		arg_6_0:UpdateView()
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.cfg_ = BattlePassCfg[arg_7_2]
	arg_7_0.levelCfg_ = GameLevelSetting[arg_7_0.index_]

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.levelLabel_.text = string.format("%d", arg_8_0.index_)
	arg_8_0.bottomLabel_.text = string.format("%d", arg_8_0.index_)

	local var_8_0 = PassportData:GetRewardStatus(arg_8_0.index_, arg_8_0.cfg_.id)
	local var_8_1 = {
		id = arg_8_0.cfg_.reward_free[1][1],
		number = arg_8_0.cfg_.reward_free[1][2],
		clickFun = function(arg_9_0)
			arg_8_0:OnItemClick(arg_9_0.id, arg_9_0.number, 1)
		end
	}
	local var_8_2 = {
		id = arg_8_0.cfg_.reward_pay[1][1],
		number = arg_8_0.cfg_.reward_pay[1][2],
		clickFun = function(arg_10_0)
			arg_8_0:OnItemClick(arg_10_0.id, arg_10_0.number, 2)
		end
	}

	var_8_1.highLight = false
	var_8_1.completedFlag = false
	var_8_2.highLight = false
	var_8_2.completedFlag = false
	var_8_2.locked = false

	if PassportData:GetPayLevel() <= 0 then
		var_8_2.locked = true
	end

	if var_8_0 == "payHaveGet" then
		var_8_2.completedFlag = true
		var_8_1.completedFlag = true
	elseif var_8_0 == "payCanGet" then
		var_8_2.highLight = true
		var_8_1.highLight = true
	elseif var_8_0 == "freeHaveGet" then
		var_8_1.completedFlag = true
	elseif var_8_0 == "freeCanGet" then
		var_8_1.highLight = true

		SetActive(arg_8_0.redGo1_, true)
	elseif var_8_0 == "payHalfCanGet" then
		var_8_1.completedFlag = true
		var_8_2.highLight = true
	end

	CommonTools.SetCommonData(arg_8_0.commonItem1_, var_8_1, arg_8_0.CommonData1)
	CommonTools.SetCommonData(arg_8_0.commonItem2_, var_8_2, arg_8_0.CommonData2)
end

function var_0_0.AddUIListener(arg_11_0)
	return
end

function var_0_0.OnItemClick(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 == 1 and PassportData:GetRewardStatus(arg_12_0.index_, arg_12_0.cfg_.id) ~= "freeCanGet" and PassportData:GetRewardStatus(arg_12_0.index_, arg_12_0.cfg_.id) ~= "payCanGet" then
		if arg_12_1 ~= 0 and arg_12_2 ~= 0 then
			ShowPopItem(POP_ITEM, {
				arg_12_1,
				arg_12_2
			})
		end

		return
	end

	if arg_12_3 == 2 and PassportData:GetRewardStatus(arg_12_0.index_, arg_12_0.cfg_.id) ~= "payCanGet" and PassportData:GetRewardStatus(arg_12_0.index_, arg_12_0.cfg_.id) ~= "payHalfCanGet" then
		if arg_12_1 ~= 0 and arg_12_2 ~= 0 then
			ShowPopItem(POP_ITEM, {
				arg_12_1,
				arg_12_2
			})
		end

		return
	end

	if PassportData:GetPayLevel() > 0 then
		PassportAction.RequestGetBonus(arg_12_0.cfg_.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	else
		local var_12_0 = PassportData:GetLevel()
		local var_12_1 = GameSetting.battlepass_level_noti.value
		local var_12_2 = PassportData:GetReceiveInfo()
		local var_12_3 = false

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			local var_12_4 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type][iter_12_1]

			if PassportData:GetReceiveInfo(var_12_4) or var_12_0 < iter_12_1 then
				var_12_3 = false
			else
				var_12_3 = true

				break
			end
		end

		if var_12_3 then
			JumpTools.OpenPageByJump("passportBuyPopView")
		else
			PassportAction.RequestGetBonus(arg_12_0.cfg_.id, PassportData:GetPayLevel() > 0 and 1 or 0)
		end
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllEventListener()

	if arg_13_0.commonItem1_ then
		arg_13_0.commonItem1_:Dispose()

		arg_13_0.commonItem1_ = nil
	end

	if arg_13_0.commonItem2_ then
		arg_13_0.commonItem2_:Dispose()

		arg_13_0.commonItem2_ = nil
	end

	arg_13_0.CommonData1 = nil
	arg_13_0.CommonData2 = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
