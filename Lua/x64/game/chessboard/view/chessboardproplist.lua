local var_0_0 = class("ChessBoardPropList", ReduxView)

;({}).showState = {
	selected = "selected",
	name = "state",
	grey = "grey",
	blank = "blank",
	normal = "normal"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.closeSelectState = arg_1_2 or false

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectItemClickHandle_ = handler(arg_3_0, arg_3_0.OnSelectItemClick)
	arg_3_0.propList = {}

	for iter_3_0 = 1, ChessBoardConst.CHESSBOARD_MAX_PROP_NUMS do
		arg_3_0.propList[iter_3_0] = ChessBoardPropItem.New(arg_3_0[string.format("propItem%sGo_", iter_3_0)], iter_3_0)

		arg_3_0.propList[iter_3_0]:SetSelectHandle(arg_3_0.selectItemClickHandle_)
	end
end

function var_0_0.OnSelectItemClick(arg_4_0, arg_4_1)
	if arg_4_0.closeSelectState then
		return
	end

	if arg_4_0.propList[arg_4_0.SelectIndex] then
		arg_4_0.propList[arg_4_0.SelectIndex]:SetSelectState(arg_4_1)
	end

	arg_4_0.SelectIndex = arg_4_1

	if arg_4_0.propList[arg_4_0.SelectIndex] then
		arg_4_0.propList[arg_4_0.SelectIndex]:SetSelectState(arg_4_1)
	end
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.SelectIndex = nil

	arg_5_0:RefreshList()
end

function var_0_0.CheckGetEffect(arg_6_0)
	local var_6_0 = #manager.ChessBoardManager:GetHeroProp()

	if arg_6_0.propList[var_6_0] then
		arg_6_0.propList[var_6_0]:ShowGetEffect()
	end
end

function var_0_0.RefreshList(arg_7_0)
	local var_7_0 = manager.ChessBoardManager:GetHeroProp()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.propList) do
		iter_7_1:Refresh(var_7_0[iter_7_0] or nil)
	end
end

function var_0_0.SetClickHandle(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.propList or {}) do
		iter_8_1:SetClickHandle(arg_8_1)
	end
end

function var_0_0.ClickTargetProp(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.propList) do
		if iter_9_0 == arg_9_1 then
			iter_9_1:OnClick()

			break
		end
	end
end

function var_0_0.GetSelectIndex(arg_10_0)
	return arg_10_0.SelectIndex
end

function var_0_0.SetUnInteractable(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.propList) do
		iter_11_1:SetUnInteractable()
	end
end

function var_0_0.StartArenaChance(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.propList) do
		iter_12_1:StartArenaChance()
	end
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.propList) do
		iter_13_1:Dispose()
	end

	arg_13_0.propList = nil

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
