local var_0_0 = class("DormFriendVisitModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitBtnController(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ControllerUtil.GetController(arg_2_1.transform, "name")

	arg_2_0.btnControllers[arg_2_2] = var_2_0

	return var_2_0
end

function var_0_0.SwitchBtnController(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.btnControllers) do
		iter_3_1:SetSelectedState(arg_3_1 == iter_3_0 and "false" or "true")
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.isShowing = true

	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexTemplate), arg_4_0.uilistGo_, DormVisitItem)
	arg_4_0.danceShareList = LuaList.New(handler(arg_4_0, arg_4_0.RenderDanceDIYDataItem), arg_4_0.danceList_.gameObject, DanceDIYDataItem)
	arg_4_0.listController = arg_4_0.controllers_:GetController("tab")
	arg_4_0.btnControllers = {}
	arg_4_0.danceBtnController = arg_4_0:InitBtnController(arg_4_0.danceBtn_, "dance")
	arg_4_0.houseBtnController = arg_4_0:InitBtnController(arg_4_0.houseBtn_, "house")

	arg_4_0:SwitchBtnController("house")
	arg_4_0:AddDragListener(arg_4_0.uilistGo_, function()
		return
	end, function()
		return
	end, function()
		local var_7_0 = arg_4_0.contentGo_.transform.anchoredPosition.y

		if arg_4_0.loadingGo_.transform.sizeDelta.y < -1 * var_7_0 then
			if not arg_4_0.refreshFlag then
				ShowTips(GetTips("DORM_RECOMMEND_CD"))

				return
			else
				arg_4_0.refreshFlag = false

				arg_4_0.refreshTimer:Start()
				DormAction:AskFurTemplateExhibitList(arg_4_0.groupID)
			end
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.danceBtn_, nil, function()
		arg_4_0:SwitchMode("dance")
	end)
	arg_4_0:AddBtnListener(arg_4_0.houseBtn_, nil, function()
		arg_4_0:SwitchMode("house")
	end)
end

function var_0_0.Refresh(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0:SwitchMode(arg_10_1, true)
	else
		arg_10_0:RefreshList(true)
	end
end

function var_0_0.SwitchMode(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.mode = arg_11_1

	DormVisitTools:SetListIndex(1, arg_11_1)
	arg_11_0:SwitchBtnController(arg_11_1)
	arg_11_0:RefreshList(arg_11_2)
end

function var_0_0.Show(arg_12_0)
	DormVisitTools:SetListIndex(1)

	if arg_12_0.isShowing == false then
		arg_12_0.isShowing = true

		SetActive(arg_12_0.gameObject_, true)
	end
end

function var_0_0.Hide(arg_13_0)
	if arg_13_0.isShowing == true then
		arg_13_0.isShowing = false

		SetActive(arg_13_0.gameObject_, false)
	end
end

function var_0_0.RefreshList(arg_14_0, arg_14_1)
	if arg_14_0.mode == "dance" then
		arg_14_0.listController:SetSelectedState("dance")
		IdolTraineeTools.FetchSharedDIY(arg_14_1, IdolTraineeConst.shareCategory.Friends, function(arg_15_0)
			arg_14_0:RefreshDanceList(arg_15_0)
		end)
	else
		arg_14_0.listController:SetSelectedState("dorm")

		arg_14_0.visitList = {}

		local var_14_0 = DormVisitTools:GetTemplateExhibitList(1)

		if var_14_0 then
			for iter_14_0, iter_14_1 in pairs(var_14_0) do
				table.insert(arg_14_0.visitList, iter_14_0)
			end

			arg_14_0.scrollHelper_:StartScroll(#arg_14_0.visitList)
		end
	end
end

function var_0_0.RefreshDanceList(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or {}
	arg_16_0.cachedBriefList = arg_16_1

	arg_16_0.danceShareList:StartScroll(#arg_16_0.cachedBriefList)
end

function var_0_0.indexTemplate(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_0.visitList[arg_17_1], 1)
	arg_17_2:RegisterEnterCallBack(function(arg_18_0)
		SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
			backhome_source = 2
		})
		DormVisitTools:SetListIndex(1)
		DormAction:AskSingleFurTemplateExhibit(arg_18_0)
	end)
end

function var_0_0.RenderDanceDIYDataItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.cachedBriefList[arg_19_1]

	arg_19_2:SetData(var_19_0, true)
	arg_19_2:SetDisplayName(var_19_0.name)
	arg_19_2:SetSelected(false)
	arg_19_2:SetOnClick(IdolTraineeTools.ViewSharedDIY)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.scrollHelper_:Dispose()
	arg_20_0.danceShareList:Dispose()
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
