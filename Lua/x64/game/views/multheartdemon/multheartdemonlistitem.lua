local var_0_0 = class("MultHeartDemonListItem", ReduxView)

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

	if arg_3_0.headItem_ then
		arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
	end

	if arg_3_0.conExCollection_ then
		arg_3_0.rankController_ = arg_3_0.conExCollection_:GetController("rank")
	else
		arg_3_0.rankController_ = ControllerUtil.GetController(arg_3_0.transform_, "rank")
	end

	if arg_3_0.viewBtn_ then
		arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
			JumpTools.OpenPageByJump("MultHeartDemonRankSquads", {
				data = arg_3_0.data
			})
		end)
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index = arg_5_2
	arg_5_0.data = arg_5_1
	arg_5_0.type = arg_5_3

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	if arg_6_0.data == nil then
		arg_6_0.rankController_:SetSelectedState("5")

		arg_6_0.rankText_.text = ""

		return
	end

	arg_6_0.nickText_.text = arg_6_0.data.nick
	arg_6_0.rankText_.text = arg_6_0.data.rank

	arg_6_0.rankController_:SetSelectedState(tostring(arg_6_0.data.rank > 3 and 0 or arg_6_0.data.rank))
	arg_6_0[arg_6_0.type == 2 and "UpdateRankView" or "UpdateMainView"](arg_6_0)
end

function var_0_0.UpdateRankView(arg_7_0)
	arg_7_0.finishTimeText_.text = manager.time:DescCdTime2(arg_7_0.data.staticInfo.clearTime)

	arg_7_0.commonPortrait_:RenderHead(arg_7_0.data.portrait)
	arg_7_0.commonPortrait_:RenderFrame(arg_7_0.data.frame)

	arg_7_0.gradeText_.text = arg_7_0.data.score
	arg_7_0.hitDamageText_.text = arg_7_0.data.staticInfo.hitNumber
end

function var_0_0.UpdateMainView(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.commonPortrait_ then
		arg_10_0.commonPortrait_:Dispose()
	end

	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

return var_0_0
