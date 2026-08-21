local var_0_0 = class("FishIcon", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.iconController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "icon")
	arg_3_0.showNumController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "showNum")
	arg_3_0.showHaveController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "showHave")
	arg_3_0.selectedController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "selected")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.iconBtn_, nil, function()
		if arg_4_0.clickListener_ ~= nil then
			arg_4_0.clickListener_(arg_4_0.id_)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.RegisterClickListener(arg_7_0, arg_7_1)
	arg_7_0.icon_.raycastTarget = true
	arg_7_0.clickListener_ = arg_7_1
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectedController_:SetSelectedState(arg_8_1 and "true" or "false")
end

function var_0_0.SetId(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.id_ = arg_9_1
	arg_9_2 = arg_9_2 or -1
	arg_9_3 = arg_9_3 or -1
	arg_9_0.haveNum_ = arg_9_3
	arg_9_0.num_ = arg_9_2

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	if arg_10_0.needUpdateHave_ then
		arg_10_0:UpdateHaveBg()
	end

	arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Fishing/RareFishIcon/%d", arg_10_0.id_))

	if arg_10_0.num_ == -1 then
		arg_10_0.showNumController_:SetSelectedState("false")
	else
		arg_10_0.showNumController_:SetSelectedState("true")

		arg_10_0.numLabel_.text = tostring(arg_10_0.num_)
	end

	if arg_10_0.haveNum_ == -1 then
		arg_10_0.showHaveController_:SetSelectedState("false")
	else
		arg_10_0.showHaveController_:SetSelectedState("true")

		arg_10_0.haveNumLabel_.text = tostring(arg_10_0.haveNum_)
	end
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_12_0)
	return
end

function var_0_0.SetNeedUpdateHave(arg_13_0, arg_13_1)
	arg_13_0.needUpdateHave_ = arg_13_1
end

function var_0_0.UpdateHaveBg(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = FishingData:GetFish(arg_14_0.id_)

	if var_14_1 ~= nil then
		var_14_0 = var_14_1.num
	end

	if var_14_0 > 0 then
		arg_14_0.iconController_:SetSelectedState("have")
	else
		arg_14_0.iconController_:SetSelectedState("not")
	end
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
