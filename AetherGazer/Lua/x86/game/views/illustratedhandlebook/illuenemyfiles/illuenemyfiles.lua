local var_0_0 = class("IlluEnemyFiles", ReduxView)
local var_0_1 = {
	7,
	8,
	6,
	10
}
local var_0_2 = true

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluEnemyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluEnemyFilesItem)
	arg_4_0.btnControllerList_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.btnControllerList_[iter_4_0] = ControllerUtil.GetController(arg_4_0[string.format("btn%strs_", iter_4_0)], "name")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_1, nil, function()
		arg_5_0:RefreshUI(1)

		arg_5_0.params_.index = 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_2, nil, function()
		arg_5_0:RefreshUI(2)

		arg_5_0.params_.index = 2
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_3, nil, function()
		arg_5_0:RefreshUI(3)

		arg_5_0.params_.index = 3
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_4, nil, function()
		arg_5_0:RefreshUI(4)

		arg_5_0.params_.index = 4
	end)
end

function var_0_0.UpdateDate(arg_10_0, arg_10_1)
	arg_10_0.itemList_ = {}

	if MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]] then
		for iter_10_0, iter_10_1 in pairs(MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]]) do
			if CollectMonsterCfg[iter_10_1].hide == 0 then
				table.insert(arg_10_0.itemList_, {
					id = iter_10_1,
					name = GetMonsterName({
						iter_10_1
					})
				})
			elseif CollectMonsterCfg[iter_10_1].hide == 2 then
				-- block empty
			elseif IllustratedData:GetEnemyInfo()[iter_10_1] then
				table.insert(arg_10_0.itemList_, {
					id = iter_10_1,
					name = GetMonsterName({
						iter_10_1
					})
				})
			end
		end
	end
end

function var_0_0.RefreshNum(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1 = not MonsterCfg.get_id_list_by_race[var_0_1[arg_11_1]] and 0 or #MonsterCfg.get_id_list_by_race[var_0_1[arg_11_1]]
	local var_11_2 = IllustratedData:GetEnemyInfo()
	local var_11_3 = 0
	local var_11_4 = 0

	if MonsterCfg.get_id_list_by_race[var_0_1[arg_11_1]] then
		for iter_11_0, iter_11_1 in pairs(MonsterCfg.get_id_list_by_race[var_0_1[arg_11_1]]) do
			if var_11_2[iter_11_1] then
				var_11_3 = var_11_3 + 1
			end

			if not var_11_2[iter_11_1] and CollectMonsterCfg[iter_11_1].hide == 1 then
				var_11_4 = var_11_4 + 1
			end
		end
	end

	arg_11_0.collectnumText_.text = var_11_3 .. "/" .. var_11_1 - var_11_4
end

function var_0_0.indexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.selectType_

	arg_12_2:RefreshUI(arg_12_0.itemList_[arg_12_1])
end

function var_0_0.RefreshUI(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:UpdateDate(arg_13_1)

	if arg_13_2 then
		if arg_13_0.params_.scrollPos_ then
			arg_13_0.scroll_:StartScrollByPosition(#arg_13_0.itemList_, arg_13_0.params_.scrollPos_)
		else
			arg_13_0.scroll_:StartScroll(#arg_13_0.itemList_)
		end
	else
		arg_13_0.scroll_:StartScroll(#arg_13_0.itemList_)
	end

	arg_13_0:RefreshNum(arg_13_1)

	for iter_13_0 = 1, 4 do
		arg_13_0.btnControllerList_[iter_13_0]:SetSelectedState(tostring(arg_13_1 == iter_13_0))
	end
end

function var_0_0.OnEnter(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_14_0.params_.index = arg_14_0.params_.index or 1

	arg_14_0:RefreshUI(arg_14_0.params_.index, true)
	manager.redPoint:bindUIandKey(arg_14_0.btn1trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[1]])
	manager.redPoint:bindUIandKey(arg_14_0.btn2trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[2]])
	manager.redPoint:bindUIandKey(arg_14_0.btn3trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[3]])
	manager.redPoint:bindUIandKey(arg_14_0.btn4trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[4]])
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_15_0.btn1trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[1]])
	manager.redPoint:unbindUIandKey(arg_15_0.btn2trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[2]])
	manager.redPoint:unbindUIandKey(arg_15_0.btn3trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[3]])
	manager.redPoint:unbindUIandKey(arg_15_0.btn4trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[4]])

	arg_15_0.params_.scrollPos_ = arg_15_0.scroll_:GetScrolledPosition()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.scroll_:Dispose()

	arg_16_0.scroll_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
