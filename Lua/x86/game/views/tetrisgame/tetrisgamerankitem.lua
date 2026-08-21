local var_0_0 = class("TetrisGameRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)
	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.skillListGo_, TetrisGameSkillIconItem)

	arg_2_0:AddUIListener()
end

function var_0_0.IndexItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:RefreshUI(arg_3_0.skillList_[arg_3_1])
	arg_3_2:RegisterClickFunc(handler(arg_3_0, arg_3_0.OnClickSkillItem))
end

function var_0_0.OnClickSkillItem(arg_4_0, arg_4_1)
	JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
		skillList = arg_4_0.skillList_,
		skillID = arg_4_1
	})
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.data_ = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.userID_ = arg_7_0.data_.id
	arg_7_0.nickText_.text = GetI18NText(arg_7_0.data_.nick)
	arg_7_0.rankText_.text = tostring(arg_7_0.index_)
	arg_7_0.scoreText_.text = arg_7_0.data_.score

	arg_7_0.commonPortrait_:RenderHead(arg_7_0.data_.portrait)
	arg_7_0.commonPortrait_:RenderFrame(arg_7_0.data_.frame)

	arg_7_0.skillList_ = arg_7_0.data_.extraInfo

	arg_7_0.uiList_:StartScroll(#arg_7_0.skillList_)
end

function var_0_0.AddUIListener(arg_8_0)
	return
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.commonPortrait_:Dispose()

	if arg_10_0.uiList_ then
		arg_10_0.uiList_:Dispose()

		arg_10_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
