local RecallSystemRecalledView = class("RecallSystemRecalledView", (import("game.views.recall.pages.RecallPageBase")))

function RecallSystemRecalledView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemRecalledView:InitUI()
	self:BindCfgUI()

	self.getController_ = ControllerUtil.GetController(self.rewardGo_.transform, "get")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RecallSystemSignItem)
	self.recallRewardList_ = LuaList.New(handler(self, self.RecallRewardIndexItem), self.recallRewardListGo_, CommonItemView)
end

function RecallSystemRecalledView:OnReceivedCodeReward()
	self:UpdateView()
	self.getController_:SetSelectedState("true")
end

function RecallSystemRecalledView:OnRecallSignUpdate()
	self:UpdateView()
end

function RecallSystemRecalledView:AddUIListener()
	self:AddBtnListener(self.inputRecalledCodeBtn_, nil, function()
		JumpTools.GoToSystem("RecallCodeInput")
	end)
	self:AddBtnListener(self.copyBtn_, nil, function()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = ActivityRecallData:GetDataByPara("recallUserInfo").user_id
	end)
end

function RecallSystemRecalledView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(ActivityRecallData:GetDataByPara("signData")[arg_8_1], arg_8_1)
end

function RecallSystemRecalledView:RecallRewardIndexItem(arg_9_1, arg_9_2)
	local var_9_0 = ActivityRecallData:GetDataByPara("recalledReward")

	CommonTools.SetCommonData(arg_9_2, {
		id = var_9_0[arg_9_1][1],
		number = var_9_0[arg_9_1][2],
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id,
				self.number
			})
		end
	})
end

function RecallSystemRecalledView:OnTop()
	return
end

function RecallSystemRecalledView:UpdateView()
	ActivityRecallData:UpdateSignState()
	self.list_:StartScroll(#ActivityRecallData:GetDataByPara("signData"))
	self.recallRewardList_:StartScroll(#ActivityRecallData:GetDataByPara("recalledReward"))

	local var_12_0 = ActivityRecallData:GetDataByPara("isSubmit")
	local var_12_1 = ActivityRecallData:GetDataByPara("recallUserInfo")

	self.getController_:SetSelectedState(var_12_0 and "true" or "false")

	if var_12_0 == true then
		self.recallNameTxt_.text = var_12_1.base_info.nick
		self.recallUIDTxt_.text = var_12_1.user_id
		self.recallHeadshotImg_.sprite = ItemTools.getItemSprite(var_12_1.base_info.icon)

		self.recallHeadshotImg_:SetNativeSize()

		self.serverName.text = string.format(GetTips("RECALLED_SERVER_NAME"), var_12_1.server_name)
	end

	self.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recalledTime")
end

function RecallSystemRecalledView:OnEnter()
	self:UpdateView()
end

function RecallSystemRecalledView:OnExit()
	return
end

function RecallSystemRecalledView:Hide()
	RecallSystemRecalledView.super.Hide(self)
end

function RecallSystemRecalledView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	if self.recallRewardList_ then
		self.recallRewardList_:Dispose()

		self.recallRewardList_ = nil
	end

	RecallSystemRecalledView.super.Dispose(self)
end

return RecallSystemRecalledView
