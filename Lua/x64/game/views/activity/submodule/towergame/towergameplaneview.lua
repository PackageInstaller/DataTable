local var_0_0 = class("TowerGamePlaneView", ReduxView)
local var_0_1 = {
	b = 1,
	a = 0
}

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/snakeactive/MardukSnakedroneUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statu_ = var_0_1.a
	arg_4_0.APlaneBtnList_ = {}
	arg_4_0.BPlaneBtnList_ = {}

	for iter_4_0 = 1, arg_4_0.atrans_.childCount do
		local var_4_0 = arg_4_0.atrans_:GetChild(iter_4_0 - 1)

		arg_4_0.APlaneBtnList_[iter_4_0] = var_4_0:GetComponent(typeof(Button))
	end

	for iter_4_1 = 1, arg_4_0.btrans_.childCount do
		local var_4_1 = arg_4_0.btrans_:GetChild(iter_4_1 - 1)

		arg_4_0.BPlaneBtnList_[iter_4_1] = var_4_1:GetComponent(typeof(Button))
	end

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.ItemRenderler), arg_4_0.listgo_, TowerGamePlaneItem)
	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.controllertrans_, "statu")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.abtn_, nil, function()
		arg_6_0.statu_ = var_0_1.a

		arg_6_0.controller_:SetSelectedState("a")
		arg_6_0:RefreshUI()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bbtn_, nil, function()
		arg_6_0.statu_ = var_0_1.b

		arg_6_0.controller_:SetSelectedState("b")
		arg_6_0:RefreshUI()
	end)

	if arg_6_0.APlaneBtnList_ then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.APlaneBtnList_) do
			arg_6_0:AddBtnListener(iter_6_1, nil, function()
				arg_6_0.list_:ScrollToIndex(iter_6_0, false, true)
			end)
		end
	end

	if arg_6_0.BPlaneBtnList_ then
		for iter_6_2, iter_6_3 in pairs(arg_6_0.BPlaneBtnList_) do
			arg_6_0:AddBtnListener(iter_6_3, nil, function()
				arg_6_0.list_:ScrollToIndex(iter_6_2, false, true)
			end)
		end
	end
end

function var_0_0.RefreshUI(arg_12_0)
	if arg_12_0.statu_ == var_0_1.a then
		arg_12_0.list_:StartScroll(TowerGameData:GetATypePlaneNum())
	else
		arg_12_0.list_:StartScroll(TowerGameData:GetBTypePlaneNum())
	end
end

function var_0_0.ItemRenderler(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, arg_13_0.statu_)
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.list_ then
		arg_14_0.list_:Dispose()

		arg_14_0.list_ = nil
	end
end

return var_0_0
