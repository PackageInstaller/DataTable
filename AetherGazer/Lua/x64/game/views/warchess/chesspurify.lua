local var_0_0 = class("ChessPurify", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessPurifyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.itemList_ = {}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, ChessPurifyItem)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_tickBtn_, nil, function()
		if arg_5_0.selectItem_ == 0 then
			ShowTips("NO_DEBUFF")
		else
			local var_6_0 = manager.ChessManager:GetExecutingChess()

			WarChessAction.PurifyDeBuff({
				x = var_6_0.x,
				z = var_6_0.z
			}, arg_5_0.itemList_[arg_5_0.selectItem_])
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
		manager.ChessManager:EventsEnd()
	end)
end

function var_0_0.OnPurifyDeBuff(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2.param ~= 0 then
		if isSuccess(arg_8_1.result) then
			local var_8_0 = arg_8_2.param

			WarChessData:ModifyArtifactData(var_8_0, -1)
			arg_8_0:Back()
			manager.ChessManager:DoNextEvent()
			ShowTips("PURIFY_SUCCESS")
		else
			arg_8_0:Back()
			manager.ChessManager:EventsEnd()
			ShowTips(arg_8_1.result)
		end
	end
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.selectItem_ = 0

	arg_9_0:UpdateData()
	arg_9_0.scrollHelper_:StartScroll(#arg_9_0.itemList_)
end

function var_0_0.UpdateData(arg_10_0)
	arg_10_0.itemList_ = {}

	local var_10_0 = WarChessData:GetArtifactData()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if WarchessItemCfg[iter_10_0].identify_buff == 1 then
			table.insert(arg_10_0.itemList_, iter_10_0)
		end
	end
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(arg_11_1, {
		id = arg_11_0.itemList_[arg_11_1]
	})
	arg_11_2:SetSelectedState(arg_11_1 == arg_11_0.selectItem_)
	arg_11_2:RegisterListener(function(arg_12_0)
		if arg_12_0 ~= arg_11_0.selectItem_ then
			arg_11_0.selectItem_ = arg_12_0

			arg_11_0.scrollHelper_:Refresh()

			arg_11_0.btn_tickBtn_.interactable = true

			SetActive(arg_11_0.itemiconGo_, true)

			arg_11_0.itemiconImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[arg_11_0.itemList_[arg_12_0]].icon)
			arg_11_0.nameText_.text = GetI18NText(WarchessItemCfg[arg_11_0.itemList_[arg_12_0]].name)
		end
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:RefreshUI()
	SetActive(arg_13_0.itemiconGo_, false)

	arg_13_0.btn_tickBtn_.interactable = false
	arg_13_0.nameText_.text = ""
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
