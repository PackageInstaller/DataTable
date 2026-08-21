local var_0_0 = class("HellaParkourLoseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourLoseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.collectController = ControllerUtil.GetController(arg_4_0.transform_, "collect")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, HellaParkourLoseItem)
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.parkour_activity_id = arg_6_0.params_.parkour_activity_id or 0

	local var_6_0 = ActivityCfg[arg_6_0.parkour_activity_id]
	local var_6_1 = var_6_0 and var_6_0.sub_activity_list or {}

	arg_6_0.loseList = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = ActivityParkourCfg[iter_6_1]

		table.insert(arg_6_0.loseList, var_6_2.specail_item)
	end

	local var_6_3 = ParkourData:GetParkCollect(arg_6_0.parkour_activity_id)

	table.sort(arg_6_0.loseList, function(arg_7_0, arg_7_1)
		local var_7_0 = not not table.indexof(var_6_3, arg_7_0)

		if var_7_0 ~= not not table.indexof(var_6_3, arg_7_1) then
			return var_7_0
		else
			return arg_7_0 < arg_7_1
		end
	end)
	arg_6_0.list:StartScroll(#arg_6_0.loseList)
	arg_6_0:SetSelectIndex(1)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()

	arg_8_0.selectIndex = -1
end

function var_0_0.Refresh(arg_9_0)
	local var_9_0 = arg_9_0.loseList[arg_9_0.selectIndex]
	local var_9_1 = ParkourData:GetParkCollect(arg_9_0.parkour_activity_id)

	if table.indexof(var_9_1, var_9_0) then
		arg_9_0.collectController:SetSelectedIndex(1)
	else
		arg_9_0.collectController:SetSelectedIndex(0)
	end

	if ItemCfg[var_9_0] then
		arg_9_0.m_name.text = ItemTools.getItemName(var_9_0)
		arg_9_0.m_des.text = ItemTools.getItemDesc(var_9_0)
	end

	arg_9_0.m_icon.sprite = ItemTools.getItemSprite(var_9_0)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.loseList[arg_10_1]

	arg_10_2:SetData(arg_10_1, arg_10_0.parkour_activity_id, var_10_0)
	arg_10_2:SetSelectedIndex(arg_10_0.selectIndex)
	arg_10_2:RegistCallBack(handler(arg_10_0, arg_10_0.SetSelectIndex))
end

function var_0_0.SetSelectIndex(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == arg_11_0.selectIndex then
		return
	end

	local var_11_0 = arg_11_0.loseList[arg_11_1]

	ParkourData:SetParkourCollectRedPoint(arg_11_0.parkour_activity_id, var_11_0)

	arg_11_0.selectIndex = arg_11_1

	local var_11_1 = arg_11_0.list:GetItemList()

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		iter_11_1:SetSelectedIndex(arg_11_0.selectIndex)
		iter_11_1:UpdateState()
	end

	arg_11_0:Refresh()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.list:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
