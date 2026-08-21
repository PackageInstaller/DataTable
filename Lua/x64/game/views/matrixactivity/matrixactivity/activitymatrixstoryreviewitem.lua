local var_0_0 = class("ActivityMatrixStoryReviewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, ActivityMatrixStoryReviewTalkItem)
end

function var_0_0.GetHeight(arg_4_0)
	return arg_4_0.hight or 0
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = _G["Story" .. arg_5_1]
	local var_5_1 = 0

	if var_5_0 and var_5_0.narrativeData then
		arg_5_0.talks = var_5_0.narrativeData
		var_5_1 = #arg_5_0.talks
	end

	arg_5_0.list:StartScroll(var_5_1)

	if var_5_1 == 0 then
		arg_5_0.hight = 369.18
	else
		arg_5_0.hight = 169.18 + 100 * var_5_1
	end

	arg_5_0.transform_.sizeDelta = Vector2.New(arg_5_0.transform_.rect.width, arg_5_0.hight)
	arg_5_0.m_title.text = StoryCfg[arg_5_1] and GetI18NText(StoryCfg[arg_5_1].name) or ""
	arg_5_0.m_des.text = var_5_0 and var_5_0.narrativeTime and GetI18NText(StoryWordCfg[var_5_0.narrativeTime].content) or ""
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	if not arg_6_1 then
		arg_6_0.hight = 0
	end
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.talks[arg_7_1]

	arg_7_2:SetData(var_7_0)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.list:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
