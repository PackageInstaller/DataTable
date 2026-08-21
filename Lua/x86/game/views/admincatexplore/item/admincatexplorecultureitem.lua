local var_0_0 = class("AdminCatExploreCultureItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.registerFunction then
			arg_4_0.registerFunction(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.data = arg_6_1
	arg_6_0.index = arg_6_2
	arg_6_0.registerFunction = arg_6_3
	arg_6_0.selectIndex = arg_6_4

	arg_6_0:UpdateView()
end

function var_0_0.GetController(arg_7_0)
	return arg_7_0.selectController
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = ExploreMeowCfg[arg_8_0.data.id]

	arg_8_0.stateController:SetSelectedState(arg_8_0.data.canUse and "unlock" or "lock")

	arg_8_0.adminCatImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_8_0.meow_icon)
	arg_8_0.nameTxt_.text = GetI18NText(var_8_0.meow_name)

	arg_8_0.selectController:SetSelectedState(arg_8_0.index == arg_8_0.selectIndex and "sel" or "normal")
	manager.redPoint:bindUIandKey(arg_8_0.adminCatImg_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. arg_8_0.data.id, {
		x = 150,
		y = 70
	})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.adminCatImg_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. arg_10_0.data.id)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

return var_0_0
