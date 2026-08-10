local var_0_0 = class("ActivitySkinDrawGiftItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.rewardItemList = {}

	for iter_2_0 = 1, 2 do
		arg_2_0.rewardItemList[iter_2_0] = ActivitySkinDrawItem.New(arg_2_0["rewardGo_" .. iter_2_0])
	end

	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
	arg_2_0.getController_ = arg_2_0.controller_:GetController("get")
	arg_2_0.posController_ = arg_2_0.controller_:GetController("pos")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = ItemCfg[arg_4_1].param

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if ItemCfg[iter_4_1[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			arg_4_0.rewardItemList[iter_4_0]:RefreshData({
				itemId = iter_4_1[1],
				count = iter_4_1[2] * arg_4_2
			}, arg_4_4)
		else
			arg_4_0.rewardItemList[iter_4_0]:RefreshData({
				itemId = iter_4_1[1],
				count = iter_4_1[2] * arg_4_2
			})
		end
	end

	if arg_4_3 then
		arg_4_0.stateController_:SetSelectedState("showText")

		arg_4_0.bottomText_.text = arg_4_3
	else
		arg_4_0.stateController_:SetSelectedState("normal")
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.SetInPopView(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.posController_:SetSelectedState("pop")
	else
		arg_6_0.posController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.rewardItemList) do
		iter_7_1:Dispose()

		iter_7_1 = nil
	end

	arg_7_0.rewardItemList = nil

	arg_7_0.super.Dispose(arg_7_0)
end

return var_0_0
