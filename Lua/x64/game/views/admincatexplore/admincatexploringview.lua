local var_0_0 = class("AdminCatExploringView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/ExploreUI/ExploringPopUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetEventData), arg_4_0.listGo_, AdminCatExploreEventView)
end

function var_0_0.SetEventData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.regionData.eventData[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_0.regionData.adminCatID, arg_5_0.regionData.startTime)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBg_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = ExploreAreaCfg[arg_8_0.regionId]
	local var_8_1 = 0

	arg_8_0.regionData = AdminCatExploreData:GetDataByPara("regionData")[arg_8_0.regionId]

	if arg_8_0.regionData == nil then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.regionData.eventData) do
		if manager.time:GetServerTime() >= iter_8_1.time + arg_8_0.regionData.startTime then
			var_8_1 = math.min(var_8_1 + 1, #arg_8_0.regionData.eventData)
		end
	end

	local var_8_2 = 0

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.regionData.eventData) do
		if manager.time:GetServerTime() >= iter_8_3.time + arg_8_0.regionData.startTime then
			var_8_2 = var_8_2 + 1
		end
	end

	arg_8_0.regionTxt_.text = GetI18NText(var_8_0.area_name)

	local var_8_3 = arg_8_0.regionData.stopTime - manager.time:GetServerTime()

	arg_8_0.remainTxt_.text = manager.time:DescCDTime(var_8_3)
	arg_8_0.updateTimer_ = Timer.New(function()
		var_8_3 = arg_8_0.regionData.stopTime - manager.time:GetServerTime()
		arg_8_0.remainTxt_.text = manager.time:DescCDTime(var_8_3)

		if var_8_2 < #arg_8_0.regionData.eventData and manager.time:GetServerTime() >= arg_8_0.regionData.eventData[var_8_2 + 1].time + arg_8_0.regionData.startTime then
			var_8_2 = math.min(var_8_2 + 1, #arg_8_0.regionData.eventData)

			arg_8_0.list:StartScroll(var_8_2, var_8_2)
		end

		if var_8_3 <= 0 then
			arg_8_0.updateTimer_:Stop()

			arg_8_0.updateTimer_ = nil

			arg_8_0:Back()
			AdminCatExploreAction.AdminCatExploreFinish(arg_8_0.regionId)
		end
	end, 1, var_8_3, 1)

	arg_8_0.list:StartScroll(var_8_2)
	arg_8_0.updateTimer_:Start()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.regionId = arg_10_0.params_.regionId

	arg_10_0:UpdateView()
	manager.audio:PlayEffect("ui_system_explore", "explore_working", "")
	manager.audio:PlayEffect("ui_system_explore", "explore_working_loop", "")
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.updateTimer_ then
		arg_11_0.updateTimer_:Stop()

		arg_11_0.updateTimer_ = nil
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.list then
		arg_12_0.list:Dispose()

		arg_12_0.list = nil
	end

	var_0_0.super.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
end

return var_0_0
