local var_0_0 = class("ActivityMatrixStoryReviewTalkItem", ReduxView)

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
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1[1] or ""
	local var_4_1 = arg_4_1[2] or 0

	arg_4_0.m_head.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Story/Character/" .. var_4_0)
	arg_4_0.m_content.text = StoryWordCfg[var_4_1] and GetI18NText(StoryWordCfg[var_4_1].content) or ""
end

return var_0_0
