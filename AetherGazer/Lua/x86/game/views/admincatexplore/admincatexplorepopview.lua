local var_0_0 = class("AdminCatExplorePopView", ReduxView)
local var_0_1 = {
	4,
	8,
	10,
	12,
	20
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExplpreInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.hourList = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_1) do
		arg_4_0.hourList[iter_4_1] = arg_4_0["hour" .. iter_4_1 .. "_"]
	end

	arg_4_0.rewardList = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.rewardList_, CommonItemView)
	arg_4_0.adminCatList = LuaList.New(handler(arg_4_0, arg_4_0.SetAdminCatItem), arg_4_0.adminCatList_, AdminCatExploreItem)
end

function var_0_0.SetRewardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ExploreAreaCfg[arg_5_0.regionId].reward

	CommonTools.SetCommonData(arg_5_2, {
		id = var_5_0[arg_5_1][1],
		clickFun = function(arg_6_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_6_0.id
			})
		end
	})
end

function var_0_0.SetAdminCatItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.catList[arg_7_1]

	arg_7_2:SetData(var_7_0, arg_7_1 == arg_7_0.selectAdminCat, handler(arg_7_0, arg_7_0.AdminCatItemRegisterFunction), arg_7_1)

	arg_7_0.adminCatItemList[arg_7_1] = arg_7_2
end

function var_0_0.AdminCatItemRegisterFunction(arg_8_0, arg_8_1)
	if arg_8_0.catList[arg_8_1] == nil or arg_8_0.catList[arg_8_1].canUse == false then
		return
	end

	for iter_8_0 = 1, #arg_8_0.catList do
		local var_8_0 = arg_8_0.adminCatItemList[iter_8_0]:GetStateController()

		if var_8_0:GetSelectedState() ~= "lock" then
			var_8_0:SetSelectedState(iter_8_0 == arg_8_1 and "sel" or "normal")

			arg_8_0.selectAdminCat = arg_8_1
		end
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.exploreBtn_, nil, function()
		local var_10_0 = AdminCatExploreData:GetDataByPara("exploringCount")
		local var_10_1 = AdminCatExploreData:GetDataByPara("level")

		if not GuideData:IsFinish(513) then
			arg_9_0:Back()

			return
		end

		if var_10_0 >= ExploreLevelCfg[var_10_1].amount then
			ShowTips("EXPLORE_BEGIN_CONDITION_3")

			return
		end

		if arg_9_0.catList[arg_9_0.selectAdminCat].canUse == false then
			ShowTips("EXPLORE_MIMIR_NO_EXIST")

			return
		end

		AdminCatExploreAction.AdminCatExplore(arg_9_0.catList[arg_9_0.selectAdminCat].id, arg_9_0.selectHour, arg_9_0.regionId)
	end)
	arg_9_0:AddBtnListener(arg_9_0.cancelBtn_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.bgBtn_, nil, function()
		arg_9_0:Back()
	end)

	for iter_9_0, iter_9_1 in pairs(arg_9_0.hourList) do
		arg_9_0:AddBtnListener(iter_9_1, nil, function()
			arg_9_0:SetHourState(iter_9_0)
		end)
	end
end

function var_0_0.SetData(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.data = arg_14_1
	arg_14_0.index = arg_14_2
end

function var_0_0.SetHourState(arg_15_0, arg_15_1)
	if arg_15_1 > arg_15_0.maxExploreHour then
		return
	end

	for iter_15_0 = 4, arg_15_0.maxExploreHour do
		if arg_15_0.hourList[iter_15_0] then
			ControllerUtil.GetController(arg_15_0.hourList[iter_15_0].transform, "name"):SetSelectedState(iter_15_0 == arg_15_1 and "sel" or "normal")

			arg_15_0.selectHour = arg_15_1
		end
	end
end

function var_0_0.UpdateView(arg_16_0)
	local var_16_0 = ExploreAreaCfg[arg_16_0.regionId]

	arg_16_0.adminCatItemList = {}
	arg_16_0.regionMapImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/" .. var_16_0.icon)
	arg_16_0.regionNameTxt_.text = GetI18NText(var_16_0.area_name)
	arg_16_0.regionDescTxt_.text = GetI18NText(var_16_0.description)
	arg_16_0.catList = AdminCatExploreData:SortAdminCatList(arg_16_0.regionId)

	arg_16_0.adminCatList:StartScroll(#arg_16_0.catList > 6 and #arg_16_0.catList or 6)
	arg_16_0.rewardList:StartScroll(#ExploreAreaCfg[arg_16_0.regionId].reward)
	AdminCatExploreData:CalculateMaxExploreHour()
end

function var_0_0.OnExploreUpdate(arg_17_0)
	ShowTips("EXPLORE_BEGIN")
	arg_17_0:Back()
end

function var_0_0.SetLockHour(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(var_0_1) do
		local var_18_0 = ControllerUtil.GetController(arg_18_0.hourList[iter_18_1].transform, "name")

		if iter_18_1 > arg_18_0.maxExploreHour then
			var_18_0:SetSelectedState("lock")
		else
			var_18_0:SetSelectedState(iter_18_1 == arg_18_0.maxExploreHour and "sel" or "normal")
		end
	end
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.selectAdminCat = 1
	arg_19_0.regionId = arg_19_0.params_.regionId

	arg_19_0:UpdateView()

	arg_19_0.maxExploreHour = AdminCatExploreData:GetDataByPara("maxExploreHour")
	arg_19_0.selectHour = arg_19_0.maxExploreHour

	arg_19_0:SetLockHour()
end

function var_0_0.OnExit(arg_20_0)
	manager.windowBar:HideBar()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.adminCatItemList) do
		iter_20_1:OnExit()
	end

	arg_20_0.adminCatItemList = {}
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.rewardList then
		arg_21_0.rewardList:Dispose()

		arg_21_0.rewardList = nil
	end

	if arg_21_0.adminCatList then
		arg_21_0.adminCatList:Dispose()

		arg_21_0.adminCatList = nil
	end

	var_0_0.super.Dispose(arg_21_0)
	Object.Destroy(arg_21_0.gameObject_)

	arg_21_0.hourList = {}
end

return var_0_0
