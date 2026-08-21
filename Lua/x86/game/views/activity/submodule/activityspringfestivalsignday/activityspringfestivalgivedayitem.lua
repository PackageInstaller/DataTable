local var_0_0 = class("ActivitySpringFestivalGiveDayItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = arg_3_0.controllerEx_:GetController("state")
	arg_3_0.selectedCon_ = arg_3_0.controllerEx_:GetController("selected")
	arg_3_0.rewardItemList_ = {}
	arg_3_0.itemDataList_ = {}

	for iter_3_0 = 1, 2 do
		arg_3_0.rewardItemList_[iter_3_0] = CommonItemView.New(arg_3_0["rewardGo_" .. iter_3_0], true)
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.receiveFunc_ then
			arg_4_0.receiveFunc_(arg_4_0.cfg.state, arg_4_0.index)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_complete, nil, function()
		arg_4_0.selectedCon_:SetSelectedIndex(0)

		if arg_4_0.receiveFunc_ then
			arg_4_0.receiveFunc_(arg_4_0.cfg.state, arg_4_0.index)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_lock, nil, function()
		local var_7_0 = ActivitySpringFestivalGive2100Cfg.all[arg_4_0.index]
		local var_7_1 = ActivitySpringFestivalGive2100Cfg[var_7_0].sub_id
		local var_7_2 = ActivityData:GetActivityData(var_7_1).startTime

		ShowTips(string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(var_7_2)))
	end)
end

function var_0_0.RefreshSelect(arg_8_0, arg_8_1)
	arg_8_0.selectedCon_:SetSelectedIndex(arg_8_0.index == arg_8_1 and 0 or 1)
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	arg_9_0.index = arg_9_1
	arg_9_0.cfg = ActivitySpringFestivalGive2100Data:GetDayListInfoByIndex(arg_9_1)

	local var_9_0 = ActivitySpringFestivalGive2100Cfg.all[arg_9_1]
	local var_9_1 = ActivitySpringFestivalGive2100Cfg[var_9_0]
	local var_9_2 = var_9_1.sub_id
	local var_9_3 = ActivityData:GetActivityData(var_9_2).startTime

	if ActivityData:GetActivityIsOpen(var_9_1.sub_id) and var_9_3 < manager.time:GetServerTime() then
		if arg_9_0.cfg.state == "reward" then
			arg_9_0.stateCon_:SetSelectedIndex(1)
		else
			arg_9_0.stateCon_:SetSelectedIndex(2)
		end
	else
		arg_9_0.stateCon_:SetSelectedIndex(0)
	end

	arg_9_0:RefreshReward(var_9_1.reward)

	arg_9_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_9_1.hero_id)
	arg_9_0.day_.text = GetI18NText(var_9_1.title)
end

function var_0_0.RefreshReward(arg_10_0, arg_10_1)
	local var_10_0 = ActivitySpringFestivalGive2100Data:GetDayListInfoByIndex(arg_10_0.index)
	local var_10_1 = getRewardFromDropCfg(arg_10_1, true)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if not arg_10_0.itemDataList_[iter_10_0] then
			arg_10_0.itemDataList_[iter_10_0] = clone(ItemTemplateData)
			arg_10_0.itemDataList_[iter_10_0].clickFun = function(arg_11_0)
				ShowPopItem(POP_ITEM, {
					arg_11_0.id,
					arg_11_0.number
				})
			end
		end

		arg_10_0.itemDataList_[iter_10_0].id = iter_10_1.id
		arg_10_0.itemDataList_[iter_10_0].number = iter_10_1.num
		arg_10_0.itemDataList_[iter_10_0].completedFlag = var_10_0.state == "complete"
		arg_10_0.itemDataList_[iter_10_0].grayFlag = var_10_0.state == "complete"

		arg_10_0.rewardItemList_[iter_10_0]:SetData(arg_10_0.itemDataList_[iter_10_0])
	end
end

function var_0_0.RegisterClickFunc(arg_12_0, arg_12_1)
	arg_12_0.receiveFunc_ = arg_12_1
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItemList_) do
		iter_13_1:Dispose()
	end

	arg_13_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
