local var_0_0 = class("AdminCatExploreItem", ReduxView)

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
	arg_3_0.commendController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "commend")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, function()
		if arg_4_0.selectBtn then
			arg_4_0.selectBtn(arg_4_0.index)
		end
	end)
end

function var_0_0.GetStateController(arg_6_0)
	return arg_6_0.stateController
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.data = arg_7_1
	arg_7_0.isSelect = arg_7_2
	arg_7_0.selectBtn = arg_7_3

	arg_7_0:UpdateView()

	arg_7_0.index = arg_7_4
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.data == nil then
		arg_8_0.stateController:SetSelectedState("no")
		arg_8_0.commendController:SetSelectedState("off")

		return
	end

	local var_8_0 = ExploreMeowCfg[arg_8_0.data.id]
	local var_8_1 = ExploreMeowSkillCfg[var_8_0.skill]
	local var_8_2 = ExploreMeowInbornCfg[var_8_0.inborn]
	local var_8_3 = AdminCatExploreData:GetDataByPara("skillData")[var_8_0.skill]

	arg_8_0.nameTxt_.text = GetI18NText(var_8_0.meow_name)
	arg_8_0.skillLvTxt_.text = "Lv.<color=#EDF2F7><size=32>" .. var_8_3 .. "</size> </color>"

	arg_8_0.commendController:SetSelectedState(arg_8_0.data.recommend and "on" or "off")

	if arg_8_0.isSelect and arg_8_0.data.canUse then
		arg_8_0.stateController:SetSelectedState("sel")
	else
		arg_8_0.stateController:SetSelectedState(arg_8_0.data.canUse and "normal" or "lock")
	end

	arg_8_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. var_8_0.meow_icon)
	arg_8_0.skillImg1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_8_2.inborn_icon)
	arg_8_0.skillImg2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_8_1.skill_icon)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.selectBtn = nil

	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

return var_0_0
