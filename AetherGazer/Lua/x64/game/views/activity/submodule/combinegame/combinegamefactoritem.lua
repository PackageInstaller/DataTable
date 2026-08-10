local var_0_0 = class("CombineGameFactorItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.selectBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
			arg_4_0.register(arg_4_0.index, arg_4_0.factorId, arg_4_0.selectController)
		end)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.index = arg_6_1
	arg_6_0.factorId = arg_6_2
	arg_6_0.register = arg_6_3
	arg_6_0.cfg = ActivityCombineFactorCfg[arg_6_2]
	arg_6_0.isSelect = arg_6_4

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. arg_7_0.cfg.icon)
	arg_7_0.descTxt_.text = GetI18NText(arg_7_0.cfg.description)
	arg_7_0.scoreTxt_.text = arg_7_0.cfg.score > 0 and "+" .. arg_7_0.cfg.score or arg_7_0.cfg.score

	if arg_7_0.selectController then
		arg_7_0.selectController:SetSelectedState(arg_7_0.isSelect and "true" or "false")
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:UpdateView()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
