local var_0_0 = class("CoreVerificationTeamInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	arg_1_0.heroHeadItem_ = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiListGo_, CoreVerificationTeamInfoHeadIconItem)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_0.list[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.mainBtn_, nil, function()
		return
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.data = arg_7_1
	arg_7_0.nameText_.text = GetTips("CORE_VERIFICATION_BOSS_DES_" .. arg_7_2)

	if arg_7_0.data and arg_7_0.data.score ~= 0 then
		arg_7_0.list = arg_7_0.data.hero_list or {}

		arg_7_0.list_:StartScroll(#arg_7_0.list)

		arg_7_0.scoreText_.text = arg_7_0.data.score
	else
		arg_7_0.list_:StartScroll(0)

		arg_7_0.scoreText_.text = 0
	end
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.list_ then
		arg_8_0.list_:Dispose()

		arg_8_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
