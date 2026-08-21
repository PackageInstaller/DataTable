local var_0_0 = class("StoryItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.info_ = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.name_.text = GetI18NText(arg_2_0.info_.name)

	arg_2_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.Init(arg_3_0)
	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.lv_.text = arg_4_0.info_.id

	arg_4_0:Show(true)
end

function var_0_0.SetIndex(arg_5_0, arg_5_1)
	arg_5_0.transform_:SetSiblingIndex(arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveAllListeners()

	arg_6_0.data_ = nil
	arg_6_0.index_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.OnClick(arg_7_0)
	manager.story:StartStory(arg_7_0.info_.id)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	if arg_8_0.isShow_ == arg_8_1 then
		return
	end

	arg_8_0.isShow_ = arg_8_1

	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
