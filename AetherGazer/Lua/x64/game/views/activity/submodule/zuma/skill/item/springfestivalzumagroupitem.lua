local var_0_0 = class("SpringFestivalZumaGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.skillID = arg_1_2
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.talentList = {}

	local var_2_0 = arg_2_0.gameObject_.transform
	local var_2_1 = ZumaData:GetSkillGroupList(arg_2_0.skillID)

	for iter_2_0, iter_2_1 in pairs(var_2_1) do
		local var_2_2 = var_2_0:GetChild(iter_2_0 - 1)
		local var_2_3 = SpringFestivalBuffItem.New(var_2_2.gameObject, iter_2_1)

		table.insert(arg_2_0.talentList, var_2_3)
	end
end

function var_0_0.SetClickCallBack(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.talentList) do
		iter_3_1:SetClickCallBack(arg_3_1)
	end
end

function var_0_0.RefreshUI(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.talentList) do
		iter_4_1:RefreshUI()
	end
end

function var_0_0.GetTargetTalentItem(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.talentList) do
		if iter_5_1:GetTalentID() == arg_5_1 then
			return iter_5_1
		end
	end

	return nil
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.talentList) do
		iter_6_1:Dispose()
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
