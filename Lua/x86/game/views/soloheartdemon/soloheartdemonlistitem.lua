local var_0_0 = class("SoloHeartDemonListItem", ReduxView)

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

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	if arg_3_0.conExCollection_ then
		arg_3_0.rankController_ = arg_3_0.conExCollection_:GetController("rank")
	else
		arg_3_0.rankController_ = ControllerUtil.GetController(arg_3_0.transform_, "rank")
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.index = arg_4_2
	arg_4_0.data = arg_4_1
	arg_4_0.type = arg_4_3

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	if arg_5_0.data == nil then
		arg_5_0.rankController_:SetSelectedState("5")

		arg_5_0.rankText_.text = ""

		return
	end

	arg_5_0.nickText_.text = arg_5_0.data.nick
	arg_5_0.rankText_.text = arg_5_0.data.rank

	arg_5_0.rankController_:SetSelectedState(tostring(arg_5_0.data.rank > 3 and 0 or arg_5_0.data.rank))
	arg_5_0.commonPortrait_:RenderHead(arg_5_0.data.portrait)
	arg_5_0.commonPortrait_:RenderFrame(arg_5_0.data.frame)
	arg_5_0[arg_5_0.type == 2 and "UpdateRankView" or "UpdateMainView"](arg_5_0)
end

function var_0_0.UpdateRankView(arg_6_0)
	arg_6_0.finishTimeText_.text = manager.time:DescCdTime2(arg_6_0.data.staticInfo.clearTime)
	arg_6_0.gradeText_.text = arg_6_0.data.score
	arg_6_0.hitDamageText_.text = arg_6_0.data.staticInfo.hitNumber
end

function var_0_0.UpdateMainView(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:UpdateView()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
