local var_0_0 = class("SurveyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "Item")
	arg_3_0.commonList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, CommonItemView)
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.info_ = arg_4_1

	arg_4_0.controller_:SetSelectedIndex(arg_4_1.status)

	arg_4_0.nameText_.text = GetI18NText(arg_4_1.name)

	local var_4_0 = manager.time:STimeDescS(arg_4_1.stop_time, "!%Y/%m/%d ") .. manager.time:STimeDescS(arg_4_1.stop_time, "!%H:%M:%S")

	arg_4_0.datetextText_.text = string.format(GetTips("TIME_DISPLAY_12"), var_4_0)

	arg_4_0:UpdateData()
	arg_4_0.commonList_:StartScroll(#arg_4_0.itemList_)
end

function var_0_0.UpdateData(arg_5_0)
	arg_5_0.itemList_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.info_.attachment_list) do
		table.insert(arg_5_0.itemList_, {
			id = iter_5_1.id,
			number = iter_5_1.num
		})
	end
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.itemList_[arg_6_1]
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.number

	function var_6_1.clickFun(arg_7_0)
		ShowPopItem(POP_ITEM, {
			arg_7_0.id,
			arg_7_0.number
		})
	end

	arg_6_2:SetData(var_6_1)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.answerbtnBtn_, nil, function()
		if arg_8_0.info_.status == 0 then
			local var_9_0 = PlayerData:GetPlayerInfo().userID
			local var_9_1 = PlayerData:GetPlayerInfo().signUserId
			local var_9_2 = arg_8_0.info_.url
			local var_9_3 = OperationAction.GetOperationUrl("gameNotifyURL") or ""

			if SDKTools.GetIsThisServer({
				"kr"
			}) then
				LuaForUtil.OpenWebView(var_9_2 .. var_9_0 .. "_" .. var_9_1, true)
			elseif SDKTools.GetIsOverSea() then
				SendMessageToSDK(string.format("{\"messageType\" : \"ShowSurvey\", \"activityId\" : \"%s\",\"roleId\" : \"%s\" , \"serverId\" : \"%s\", \"gameNotifyURL\" : \"%s\" }", arg_8_0.info_.question_num, var_9_0 .. "_" .. var_9_1, tostring(_G.TMP_SERVER_ID), var_9_3))
			else
				LuaForUtil.OpenWebView(var_9_2 .. var_9_0 .. "_" .. var_9_1, true)
			end
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		if arg_8_0.info_.status == 1 then
			SurveyAction.GetReward(arg_8_0.info_.id)
		end
	end)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonList_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
