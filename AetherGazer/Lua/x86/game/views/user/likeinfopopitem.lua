local var_0_0 = class("LikeInfoPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0.id_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id_ = arg_7_1.id
	arg_7_0.nick_ = arg_7_1.nick
	arg_7_0.icon_ = arg_7_1.icon
	arg_7_0.frame_ = arg_7_1.frame
	arg_7_0.level_ = arg_7_1.level
	arg_7_0.time_ = arg_7_2

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.commonPortrait_:RenderHead(arg_8_0.icon_)
	arg_8_0.commonPortrait_:RenderFrame(arg_8_0.frame_)

	arg_8_0.nickTxt_.text = arg_8_0.nick_
	arg_8_0.levelTxt_.text = arg_8_0.level_
	arg_8_0.timeTxt_.text = manager.time:STimeDescS(arg_8_0.time_, "!%Y/%m/%d %H:%M")
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.commonPortrait_ ~= nil then
		arg_10_0.commonPortrait_:Dispose()

		arg_10_0.commonPortrait_ = nil
	end

	arg_10_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
