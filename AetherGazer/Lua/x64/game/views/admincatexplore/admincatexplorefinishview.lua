local var_0_0 = class("AdminCatExploreFinishView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExploreGetUI"
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

	arg_4_0.controller = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CommonItemView)
	arg_4_0.list2Items = {}
end

function var_0_0.SetEventData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.regionData.eventData[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_0.adminCatID, arg_5_0.regionData.startTime)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	CommonTools.SetCommonData(arg_6_2, {
		id = arg_6_0.reward[arg_6_1].id,
		number = arg_6_0.reward[arg_6_1].num,
		clickFun = function(arg_7_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_7_0.id
			})
		end
	})
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		if arg_8_0.eventId ~= 0 and arg_8_0.isClick == nil then
			arg_8_0.controller:SetSelectedState("get")
			arg_8_0.animator_:Play("Fx_getPanel_cx", -1, 0)

			arg_8_0.isClick = true

			manager.audio:PlayEffect("ui_system_explore", "explore_finish", "")

			return
		end

		if arg_8_0.callBack then
			arg_8_0.callBack()
		end

		arg_8_0:Back()
	end)
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.UpdateView(arg_11_0)
	if arg_11_0.eventId ~= 0 then
		arg_11_0.controller:SetSelectedState("event")

		local var_11_0 = ExploreEventCfg[arg_11_0.eventId]

		arg_11_0.eventNameTxt_.text = GetI18NText(var_11_0.event_name)
		arg_11_0.eventDescTxt_.text = GetI18NText(var_11_0.description)
		arg_11_0.eventTxt_.text = string.format(GetTips("EXPLORE_EVENT_GAIN"), GetI18NText(var_11_0.effect_description))

		manager.audio:PlayEffect("ui_system_explore", "explore_working", "")
	else
		arg_11_0.controller:SetSelectedState("get")
		manager.audio:PlayEffect("ui_system_explore", "explore_finish", "")
	end

	arg_11_0.skillData = AdminCatExploreData:GetDataByPara("skillData")
	arg_11_0.regionData = AdminCatExploreData:GetDataByPara("regionData")[arg_11_0.regionId]

	local var_11_1 = ExploreMeowCfg[arg_11_0.adminCatID]
	local var_11_2 = var_11_1.skill
	local var_11_3 = ExploreMeowSkillCfg[var_11_2]
	local var_11_4 = arg_11_0.skillData[var_11_2]
	local var_11_5 = var_11_3.skill_effect[var_11_4]
	local var_11_6 = ExploreMeowInbornCfg[var_11_1.inborn]
	local var_11_7 = AdminCatExploreData:GetDataByPara("skillEffect")
	local var_11_8 = AdminCatExploreData:GetDataByPara("inbornEffect")
	local var_11_9 = ExploreAreaCfg[arg_11_0.regionId]

	SetActive(arg_11_0.eventTxt_.gameObject, arg_11_0.eventId ~= 0)
	SetActive(arg_11_0.skillTxt_.gameObject, var_11_7)
	SetActive(arg_11_0.inbornTxt_.gameObject, var_11_8)

	arg_11_0.skillTxt_.text = string.format(GetTips("EXPLORE_SKILL_GAIN"), string.format(GetI18NText(var_11_3.skill_description), var_11_5))
	arg_11_0.inbornTxt_.text = string.format(GetTips("EXPLORE_INBORN_GAIN"), GetI18NText(var_11_6.inborn_description))

	arg_11_0.list:StartScroll(#arg_11_0.reward)

	arg_11_0.nameTxt_.text = GetI18NText(var_11_9.area_name)
	arg_11_0.regionImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/" .. var_11_9.icon)
	arg_11_0.adminCatImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. var_11_1.meow_icon)

	for iter_11_0 = 1, #arg_11_0.regionData.eventData do
		if not arg_11_0.list2Items[iter_11_0] then
			local var_11_10 = Object.Instantiate(arg_11_0.itemGo_, arg_11_0.contentTrs_)

			arg_11_0.list2Items[iter_11_0] = AdminCatExploreEventView.New(var_11_10)
		end

		local var_11_11 = arg_11_0.regionData.eventData[iter_11_0]

		arg_11_0.list2Items[iter_11_0]:SetActive(true)
		arg_11_0.list2Items[iter_11_0]:SetData(var_11_11, arg_11_0.adminCatID, arg_11_0.regionData.startTime)
	end

	for iter_11_1 = #arg_11_0.regionData.eventData + 1, #arg_11_0.list2Items do
		arg_11_0.list2Items[iter_11_1]:SetActive(false)
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.regionId = arg_12_0.params_.regionId
	arg_12_0.reward = arg_12_0.params_.reward
	arg_12_0.eventId = arg_12_0.params_.eventId
	arg_12_0.adminCatID = arg_12_0.params_.adminCatID
	arg_12_0.callBack = arg_12_0.params_.callBack

	arg_12_0:UpdateView()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0.isClick = nil
	arg_13_0.callBack = nil

	if arg_13_0.updateTimer_ then
		arg_13_0.updateTimer_:Stop()

		arg_13_0.updateTimer_ = nil
	end
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.list then
		arg_14_0.list:Dispose()

		arg_14_0.list = nil
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.list2Items) do
		iter_14_1:Dispose()
	end

	var_0_0.super.Dispose(arg_14_0)
	Object.Destroy(arg_14_0.gameObject_)
end

return var_0_0
