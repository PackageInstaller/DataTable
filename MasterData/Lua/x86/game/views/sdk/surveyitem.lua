local SurveyItem = class("SurveyItem", ReduxView)

function SurveyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SurveyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SurveyItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "Item")
	self.commonList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, CommonItemView)
end

function SurveyItem:RefreshUI(arg_4_1)
	self.info_ = arg_4_1

	self.controller_:SetSelectedIndex(arg_4_1.status)

	self.nameText_.text = GetI18NText(arg_4_1.name)
	self.datetextText_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(arg_4_1.stop_time, "!%Y/%m/%d ") .. manager.time:STimeDescS(arg_4_1.stop_time, "!%H:%M:%S"))

	self:UpdateData()
	self.commonList_:StartScroll(#self.itemList_)
end

function SurveyItem:UpdateData()
	self.itemList_ = {}

	for iter_5_0, iter_5_1 in ipairs(self.info_.attachment_list) do
		table.insert(self.itemList_, {
			id = iter_5_1.id,
			number = iter_5_1.num
		})
	end
end

function SurveyItem:indexItem(arg_6_1, arg_6_2)
	local var_6_0 = clone(ItemTemplateData)

	var_6_0.id = self.itemList_[arg_6_1].id
	var_6_0.number = self.itemList_[arg_6_1].number

	function var_6_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_6_2:SetData(var_6_0)
end

function SurveyItem:AddUIListener()
	self:AddBtnListener(self.answerbtnBtn_, nil, function()
		if self.info_.status == 0 then
			local var_9_0 = PlayerData:GetPlayerInfo().userID
			local var_9_1 = PlayerData:GetPlayerInfo().signUserId
			local var_9_2 = OperationAction.GetOperationUrl("gameNotifyURL") or ""

			if SDKTools.GetIsThisServer({
				"kr"
			}) then
				LuaForUtil.OpenWebView(self.info_.url .. var_9_0 .. "_" .. var_9_1, true)
			elseif SDKTools.GetIsOverSea() then
				SendMessageToSDK(string.format("{\"messageType\" : \"ShowSurvey\", \"activityId\" : \"%s\",\"roleId\" : \"%s\" , \"serverId\" : \"%s\", \"gameNotifyURL\" : \"%s\" }", self.info_.question_num, var_9_0 .. "_" .. var_9_1, tostring(_G.TMP_SERVER_ID), var_9_2))
			else
				LuaForUtil.OpenWebView(self.info_.url .. var_9_0 .. "_" .. var_9_1, true)
			end
		end
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.info_.status == 1 then
			SurveyAction.GetReward(self.info_.id)
		end
	end)
end

function SurveyItem:Dispose()
	self.commonList_:Dispose()
	SurveyItem.super.Dispose(self)
end

return SurveyItem
