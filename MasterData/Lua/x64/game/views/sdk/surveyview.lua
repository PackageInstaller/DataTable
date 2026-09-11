local SurveyView = class("SurveyView", ReduxView)

function SurveyView:UIName()
	return "Widget/System/Medium/InvestigateUI"
end

function SurveyView:UIParent()
	return manager.ui.uiPop.transform
end

function SurveyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SurveyView:InitUI()
	self:BindCfgUI()

	self.surveyList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, SurveyItem)
	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function SurveyView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function SurveyView:UpdateData()
	self.itemList_ = {}

	for iter_7_0, iter_7_1 in pairs((SurveyData:GetSurveyList())) do
		if self.params_.type == iter_7_1.type then
			table.insert(self.itemList_, iter_7_1)
		end
	end

	table.sort(self.itemList_, function(arg_8_0, arg_8_1)
		local function var_8_0(arg_9_0)
			if arg_9_0 == 1 then
				return 1
			end

			if arg_9_0 == 2 then
				return 3
			end

			if arg_9_0 == 0 then
				return 2
			end
		end

		local var_8_1 = var_8_0(arg_8_0.status)
		local var_8_2 = var_8_0(arg_8_1.status)

		if var_8_1 ~= var_8_2 then
			return var_8_1 < var_8_2
		end

		return arg_8_0.id > arg_8_1.id
	end)
end

function SurveyView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(self.itemList_[arg_10_1])
end

function SurveyView:OnEnter()
	self:UpdateData()

	if #self.itemList_ <= 0 then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")
		self.surveyList_:StartScroll(#self.itemList_)
	end
end

function SurveyView:OnExit()
	return
end

function SurveyView:OnGetSurveyGift(arg_13_1, arg_13_2)
	self:UpdateData()
	self.surveyList_:StartScroll(#self.itemList_)
	getReward2(mergeReward2(arg_13_1.item_list))
end

function SurveyView:OnFinishSurvey()
	self:UpdateData()
	self.surveyList_:StartScroll(#self.itemList_)
end

function SurveyView:OnExitInput()
	JumpTools.Back()

	return true
end

function SurveyView:Dispose()
	self.surveyList_:Dispose()
	SurveyView.super.Dispose(self)
end

return SurveyView
