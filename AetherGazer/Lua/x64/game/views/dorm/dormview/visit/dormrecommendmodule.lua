local var_0_0 = class("DormRecommendModule", ReduxView)

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
	arg_4_0.mode = "all"

	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexTemplate), arg_4_0.uilistGo_, DormVisitPictureItem)
	arg_4_0.danceShareList = LuaList.New(handler(arg_4_0, arg_4_0.RenderDanceDIYDataItem), arg_4_0.danceList_.gameObject, DanceDIYDataItem)
	arg_4_0.listController = arg_4_0.controllers_:GetController("category")
	arg_4_0.btnControllers = {}
	arg_4_0.allBtnController = arg_4_0:InitBtnController(arg_4_0.allBtn_, "all")
	arg_4_0.publicBtnController = arg_4_0:InitBtnController(arg_4_0.exBtn_, "public")
	arg_4_0.privateBtnController = arg_4_0:InitBtnController(arg_4_0.innerBtn_, "private")
	arg_4_0.danceBtnController = arg_4_0:InitBtnController(arg_4_0.danceBtn_, "dance")

	arg_4_0:SwitchBtnController("all")
	arg_4_0:AddListener()
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0:SwitchMode(arg_5_1, true)
	else
		arg_5_0:RefreshList(true)
	end
end

function var_0_0.SwitchMode(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.mode = arg_6_1

	DormVisitTools:SetListIndex(2, arg_6_1)
	arg_6_0:SwitchBtnController(arg_6_1)
	arg_6_0:RefreshList(arg_6_2)
end

function var_0_0.AddListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.allBtn_, nil, function()
		arg_7_0:OnAllBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.exBtn_, nil, function()
		arg_7_0:OnPublicBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.innerBtn_, nil, function()
		arg_7_0:OnPrivateBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.danceBtn_, nil, function()
		arg_7_0:OnDanceBtnClick()
	end)
	arg_7_0:AddBtnListener(arg_7_0.refreshBtn_, nil, function()
		arg_7_0:OnRefreshBtnClick()
	end)
end

function var_0_0.RefreshList(arg_13_0, arg_13_1)
	if arg_13_0.mode == "dance" then
		arg_13_0.listController:SetSelectedState("dance")
		IdolTraineeTools.FetchSharedDIY(arg_13_1, IdolTraineeConst.shareCategory.Random, function(arg_14_0)
			arg_13_0:RefreshDanceList(arg_14_0)
		end)
	else
		arg_13_0.listController:SetSelectedState("house")

		arg_13_0.fullVisitList = arg_13_0.fullVisitList or {}
		arg_13_0.visitList = {}

		if arg_13_1 then
			arg_13_0.fullVisitList = {}

			local var_13_0 = DormVisitTools:GetTemplateExhibitList(2)

			if var_13_0 then
				for iter_13_0, iter_13_1 in pairs(var_13_0) do
					table.insert(arg_13_0.fullVisitList, {
						id = iter_13_0,
						data = iter_13_1
					})
				end
			end
		end

		for iter_13_2, iter_13_3 in ipairs(arg_13_0.fullVisitList) do
			if arg_13_0.mode == "all" then
				table.insert(arg_13_0.visitList, iter_13_3.id)
			elseif arg_13_0.mode == "public" then
				local var_13_1 = iter_13_3.data.architecture_id

				if BackHomeCfg[var_13_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
					table.insert(arg_13_0.visitList, iter_13_3.id)
				end
			elseif arg_13_0.mode == "private" then
				local var_13_2 = iter_13_3.data.architecture_id

				if BackHomeCfg[var_13_2].type ~= DormConst.BACKHOME_TYPE.PublicDorm then
					table.insert(arg_13_0.visitList, iter_13_3.id)
				end
			end
		end

		arg_13_0.scrollHelper_:StartScroll(#arg_13_0.visitList)
	end
end

function var_0_0.RefreshDanceList(arg_15_0, arg_15_1)
	arg_15_1 = arg_15_1 or {}

	print(arg_15_0.cachedBriefList, arg_15_1)

	arg_15_0.cachedBriefList = arg_15_1

	arg_15_0.danceShareList:StartScroll(#arg_15_0.cachedBriefList)
end

function var_0_0.indexTemplate(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:RefreshUI(arg_16_0.visitList[arg_16_1], 2)
end

function var_0_0.RenderDanceDIYDataItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.cachedBriefList[arg_17_1]

	arg_17_2:SetData(var_17_0, true)
	arg_17_2:SetDisplayName(var_17_0.name)
	arg_17_2:SetSelected(false)
	arg_17_2:SetOnClick(IdolTraineeTools.ViewSharedDIY)
end

function var_0_0.OnAllBtnClick(arg_18_0)
	arg_18_0:SwitchMode("all")
end

function var_0_0.OnPublicBtnClick(arg_19_0)
	arg_19_0:SwitchMode("public")
end

function var_0_0.OnPrivateBtnClick(arg_20_0)
	arg_20_0:SwitchMode("private")
end

function var_0_0.OnDanceBtnClick(arg_21_0)
	arg_21_0:SwitchMode("dance")
end

function var_0_0.OnRefreshBtnClick(arg_22_0)
	DormAction:AskFurTemplateExhibitList(2)
end

function var_0_0.Show(arg_23_0)
	DormVisitTools:SetListIndex(2)

	if arg_23_0.isShowing == false then
		arg_23_0.isShowing = true

		SetActive(arg_23_0.gameObject_, true)
	end
end

function var_0_0.Hide(arg_24_0)
	if arg_24_0.isShowing == true then
		arg_24_0.isShowing = false

		SetActive(arg_24_0.gameObject_, false)
	end
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0.scrollHelper_:Dispose()
	arg_25_0.danceShareList:Dispose()
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
