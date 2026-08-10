local var_0_0 = class("SkillComboItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.skillSubList_ = {}

	arg_3_0:BindCfgUI()
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1.desc and arg_5_1.desc ~= "" then
		arg_5_0.descText_.text = GetI18NText(arg_5_1.desc)
	else
		arg_5_0.descText_.gameObject:SetActive(false)
	end

	arg_5_0.nameText_.text = GetI18NText(arg_5_1.name)

	if arg_5_1.list_icon[1] then
		arg_5_0.panelTrs_.gameObject:SetActive(true)

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.skillSubList_) do
			iter_5_1:Show(false)
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_1.list_icon) do
			if arg_5_0.skillSubList_[iter_5_2] == nil then
				local var_5_0 = Object.Instantiate(arg_5_0.skillGo_, arg_5_0.panelTrs_)

				arg_5_0.skillSubList_[iter_5_2] = SkillComboSubItem.New(var_5_0)
			end

			arg_5_0.skillSubList_[iter_5_2]:Show(true)
			arg_5_0.skillSubList_[iter_5_2]:RefreshData(arg_5_1, arg_5_2, iter_5_2)
		end
	else
		arg_5_0.panelTrs_.gameObject:SetActive(false)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.skillSubList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.skillSubList_ = nil
end

return var_0_0
