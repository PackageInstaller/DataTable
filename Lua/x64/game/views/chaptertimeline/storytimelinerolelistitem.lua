local var_0_0 = class("StoryTimeLineRoleListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectedController_ = ControllerUtil.GetController(arg_2_0.transform_, "isSelected")

	arg_2_0:AddListener()
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.normalBtn_, nil, function()
		if arg_3_0.callback_ then
			arg_3_0.callback_(arg_3_0.index_)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.openBtn_, nil, function()
		if arg_3_0.openCallback_ then
			arg_3_0.openCallback_(arg_3_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.id_ = arg_6_2
	arg_6_0.cfg_ = ChapterClassSiftCfg[arg_6_0.id_]

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.nameText_.text = arg_7_0.cfg_.class_name
	arg_7_0.headIcon_.spriteAsync = HeroTools.GetHeadSprite(arg_7_0.cfg_.class_hero_icon)
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(tostring(arg_8_0.index_ == arg_8_1))
end

function var_0_0.SetClickCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.SetOpenCallback(arg_10_0, arg_10_1)
	arg_10_0.openCallback_ = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.callback_ = nil

	arg_11_0:RemoveAllListeners()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
