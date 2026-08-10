local var_0_0 = class("HeroDisplayPoseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.heroPoseItemList_ = {}
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.heroID_ = arg_2_1

	local var_2_0 = HeroDisplayData:GetHeroPoseList(arg_2_1)

	for iter_2_0 = 1, #var_2_0 do
		if not arg_2_0.heroPoseItemList_[iter_2_0] then
			arg_2_0.heroPoseItemList_[iter_2_0] = HeroDisplayPoseItem.New(arg_2_0.goItem_, arg_2_0.goParent_)
		end

		arg_2_0.heroPoseItemList_[iter_2_0]:SetData(arg_2_1, iter_2_0)
		arg_2_0.heroPoseItemList_[iter_2_0]:SetSelect(iter_2_0 == 1)
	end

	for iter_2_1 = #var_2_0 + 1, #arg_2_0.heroPoseItemList_ do
		arg_2_0.heroPoseItemList_[iter_2_1]:Show(false)
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.heroPoseItemList_) do
		iter_3_1:SetSelect(iter_3_0 == arg_3_1)
	end
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.heroPoseItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.heroPoseItemList_ = nil
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	if arg_6_1 then
		-- block empty
	end
end

return var_0_0
