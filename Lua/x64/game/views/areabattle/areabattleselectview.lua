local var_0_0 = class("AreaBattleSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.params_.mainActivityID) .. "NormalfightingSelectUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, AreaBattleSelectItem)
	arg_4_0.raceController = arg_4_0.raceController_:GetController("name")
	arg_4_0.buffController = arg_4_0.buffController_:GetController("name")
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1

	if arg_5_0.raceController:GetSelectedState() == "false" then
		var_5_0 = var_5_0 + 8
	end

	arg_5_2:SetData(arg_5_0.typeList[arg_5_1], arg_5_1, handler(arg_5_0, arg_5_0.ClickCallBack), arg_5_0, var_5_0, arg_5_0.listGo_.transform.rect)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.clearBtn_, nil, function()
		arg_6_0.selectList = {}
		arg_6_0.canUsePoint = arg_6_0.maxPoint

		arg_6_0:UpdateBottom()

		for iter_7_0, iter_7_1 in pairs(arg_6_0.list:GetItemList()) do
			iter_7_1:Clear()
		end

		saveData("AreaBattle", tostring(arg_6_0.stageID), "")
	end)
	arg_6_0:AddBtnListener(arg_6_0.raceBtn_, nil, function()
		if arg_6_0.raceController:GetSelectedState() == "false" then
			arg_6_0.raceController:SetSelectedState("true")
			arg_6_0.buffController:SetSelectedState("false")
			arg_6_0:UpdateBuff(arg_6_0.raceController:GetSelectedState() == "true", arg_6_0.buffController:GetSelectedState() == "true")
			arg_6_0:UpdateView()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.buffBtn_, nil, function()
		if arg_6_0.buffController:GetSelectedState() == "false" then
			arg_6_0.buffController:SetSelectedState("true")
			arg_6_0.raceController:SetSelectedState("false")
			arg_6_0:UpdateBuff(arg_6_0.raceController:GetSelectedState() == "true", arg_6_0.buffController:GetSelectedState() == "true")
			arg_6_0:UpdateView()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs(arg_6_0.selectList) do
			table.insert(var_10_0, iter_10_0)
		end

		AreaBattleAction.SaveAffix(arg_6_0.activityID, var_10_0, arg_6_0.stageID)
		gameContext:Go("/sectionSelectHero", {
			section = arg_6_0.stageID,
			sectionType = BattleConst.STAGE_TYPE_NEW.AREA_BATTLE,
			activityID = arg_6_0.activityID
		})
	end)
end

function var_0_0.UpdateView(arg_11_0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.listGo_.transform)
	TimeTools.StartAfterSeconds(0.1, function()
		arg_11_0.list:StartScroll(#arg_11_0.typeList)
		arg_11_0:UpdateBottom()

		if arg_11_0.index ~= 999 then
			arg_11_0.list:ScrollToIndex(arg_11_0.index, false, false)
		end
	end, {})
end

function var_0_0.UpdateBottom(arg_13_0)
	arg_13_0.canUseTxt_.text = arg_13_0.canUsePoint .. "/" .. arg_13_0.maxPoint
	arg_13_0.totalTxt_.text = arg_13_0.canUsePoint
end

function var_0_0.ClickCallBack(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.selectList) do
		var_14_0 = var_14_0 + 1
	end

	arg_14_0.canUsePoint = arg_14_0.maxPoint - var_14_0

	arg_14_0:UpdateBottom()

	local var_14_1 = ""

	for iter_14_2, iter_14_3 in pairs(arg_14_0.selectList) do
		var_14_1 = var_14_1 .. iter_14_2 .. "," .. tostring(iter_14_3) .. "."
	end

	saveData("AreaBattle", tostring(arg_14_0.stageID), var_14_1)
end

function var_0_0.UpdateBuff(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	arg_15_0.typeList = {}

	if arg_15_0.canUsePoint < 0 then
		arg_15_0.canUsePoint = arg_15_0.maxPoint

		saveData("AreaBattle", tostring(arg_15_0.stageID), "")

		arg_15_0.selectList = {}
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.buffList) do
		local var_15_1 = TalentTreeCfg[iter_15_1]

		if var_15_0[var_15_1.stage] == nil then
			var_15_0[var_15_1.stage] = {}
		end

		table.insert(var_15_0[var_15_1.stage], iter_15_1)
	end

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		table.sort(iter_15_3, function(arg_16_0, arg_16_1)
			return arg_16_0 < arg_16_1
		end)
	end

	for iter_15_4, iter_15_5 in ipairs(var_15_0) do
		for iter_15_6, iter_15_7 in pairs(iter_15_5) do
			if arg_15_0.selectList[iter_15_7] then
				arg_15_0.index = math.min(arg_15_0.index, iter_15_4)
			end
		end
	end

	if not arg_15_1 and not arg_15_2 then
		if arg_15_0.index > 8 and arg_15_0.index ~= 999 then
			arg_15_0.raceController:SetSelectedState("false")
			arg_15_0.buffController:SetSelectedState("true")

			arg_15_0.index = arg_15_0.index - 8

			for iter_15_8, iter_15_9 in ipairs(var_15_0) do
				if iter_15_8 > 8 then
					table.insert(arg_15_0.typeList, {
						data = iter_15_9,
						type = iter_15_8
					})
				end
			end
		else
			for iter_15_10, iter_15_11 in ipairs(var_15_0) do
				if iter_15_10 <= 8 then
					table.insert(arg_15_0.typeList, {
						data = iter_15_11,
						type = iter_15_10
					})
				end
			end
		end
	else
		for iter_15_12, iter_15_13 in ipairs(var_15_0) do
			if arg_15_1 and iter_15_12 <= 8 then
				table.insert(arg_15_0.typeList, {
					data = iter_15_13,
					type = iter_15_12
				})
			end

			if arg_15_2 and iter_15_12 > 8 then
				table.insert(arg_15_0.typeList, {
					data = iter_15_13,
					type = iter_15_12
				})
			end
		end
	end
end

function var_0_0.UpdateData(arg_17_0)
	arg_17_0.stageID = arg_17_0.params_.stageID
	arg_17_0.activityID = arg_17_0.params_.activityID
	arg_17_0.mainActivityID = arg_17_0.params_.mainActivityID
	arg_17_0.cfg = ActivityAreaBattleCfg[arg_17_0.activityID]
	arg_17_0.data = ActivityAreaBattleData:GetDataByActivityID(arg_17_0.mainActivityID)[arg_17_0.activityID]

	for iter_17_0, iter_17_1 in pairs(arg_17_0.cfg.buff_list) do
		if iter_17_1[1] == arg_17_0.stageID then
			arg_17_0.buffList = iter_17_1[2]
			difficult = iter_17_0
		end
	end

	arg_17_0.maxPoint = 0

	for iter_17_2, iter_17_3 in pairs(arg_17_0.data.difficultList[arg_17_0.params_.difficult] or {}) do
		if iter_17_2 ~= arg_17_0.stageID then
			arg_17_0.maxPoint = arg_17_0.maxPoint + iter_17_3.point
		end
	end

	arg_17_0.canUsePoint = arg_17_0.maxPoint
	arg_17_0.selectList = {}
	arg_17_0.index = 999

	local var_17_0 = 0
	local var_17_1 = getData("AreaBattle", tostring(arg_17_0.stageID)) or ""

	if var_17_1 ~= "" then
		local var_17_2 = string.split(var_17_1, ".")

		for iter_17_4, iter_17_5 in ipairs(var_17_2) do
			if iter_17_5 ~= "" then
				local var_17_3 = string.split(iter_17_5, ",")

				arg_17_0.selectList[tonumber(var_17_3[1])] = true
				var_17_0 = var_17_0 + 1
			end
		end
	end

	arg_17_0.canUsePoint = arg_17_0.canUsePoint - var_17_0

	arg_17_0:UpdateBuff()
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.raceController:SetSelectedState("true")
	arg_18_0.buffController:SetSelectedState("false")
	arg_18_0:UpdateData()
	arg_18_0:UpdateView()
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.list then
		arg_21_0.list:Dispose()

		arg_21_0.list = nil
	end

	var_0_0.super.Dispose(arg_21_0)
	Object.Destroy(arg_21_0.gameObject_)
end

return var_0_0
