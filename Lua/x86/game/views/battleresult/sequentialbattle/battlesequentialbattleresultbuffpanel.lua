local var_0_0 = class("BattleSequentialBattleResultBuffPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.buffItemList_ = {}
	arg_1_0.emptyController_ = arg_1_0.controllerEx_:GetController("empty")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		arg_2_0.buffItemList_[iter_2_0] = arg_2_0.buffItemList_[iter_2_0] or SequentialBattleFactoryTeamBuff.New(arg_2_0.buffItem_, arg_2_0.buffParent_)

		arg_2_0.buffItemList_[iter_2_0]:SetData(arg_2_1[iter_2_0])
	end

	if #arg_2_1 <= 0 then
		arg_2_0.emptyController_:SetSelectedState("true")
	else
		arg_2_0.emptyController_:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.buffItemList_) do
		iter_3_1:Dispose()
	end

	arg_3_0.buffItemList_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

return var_0_0
