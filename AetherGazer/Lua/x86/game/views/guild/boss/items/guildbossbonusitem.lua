local var_0_0 = class("GuildBossBonusItem", ReduxView)

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

	arg_3_0.itemList = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.itemList[iter_3_0] = CommonItemView.New(arg_3_0["commonitem_sGo_" .. iter_3_0])
	end

	arg_3_0.statusController_ = arg_3_0.controller:GetController("status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn, nil, function()
		if arg_4_0.remainHp_ <= arg_4_0.needLessHp_ then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 2, arg_4_0.data_[1])
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.data_ = arg_7_1
	arg_7_0.remainHp_ = arg_7_2
	arg_7_0.needLessHp_ = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp * (100 - arg_7_0.data_[1]) / 100
	arg_7_0.bonusDataList_ = arg_7_0.data_[2]

	local var_7_0

	if arg_7_3 < 10 then
		var_7_0 = "0" .. arg_7_3
	else
		var_7_0 = arg_7_3
	end

	arg_7_0.numText_.text = var_7_0

	arg_7_0:UpdateView()
	arg_7_0:RefreshAwardItemList()
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.data_[1] == 100 then
		arg_8_0.descLabel_.text = GetTips("CLUB_BOSS_BLOOD_CONDITION_TIP2")
	else
		arg_8_0.descLabel_.text = string.format(GetTips("CLUB_BOSS_BLOOD_CONDITION_TIP1"), tostring(100 - arg_8_0.data_[1] .. "%"))
	end

	if GuildData:HaveGetGuildBossCommonReward(arg_8_0.data_[1]) then
		arg_8_0.statusController_:SetSelectedState("haveGet")
	elseif arg_8_0.remainHp_ <= arg_8_0.needLessHp_ then
		arg_8_0.statusController_:SetSelectedState("canGet")
	else
		arg_8_0.statusController_:SetSelectedState("cannotGet")
	end
end

function var_0_0.RefreshAwardItemList(arg_9_0)
	for iter_9_0 = 1, 3 do
		if arg_9_0.bonusDataList_[iter_9_0] then
			arg_9_0.itemList[iter_9_0]:SetData({
				id = arg_9_0.bonusDataList_[iter_9_0][1],
				number = arg_9_0.bonusDataList_[iter_9_0][2],
				clickFun = function(arg_10_0)
					ShowPopItem(POP_ITEM, {
						arg_10_0.id
					})
				end
			})
		else
			arg_9_0.itemList[iter_9_0]:SetData()
		end
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil

	if arg_14_0.itemList then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.itemList) do
			iter_14_1:Dispose()
		end

		arg_14_0.itemList = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
