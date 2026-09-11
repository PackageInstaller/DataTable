local ValentineGameV2ResultView = class("ValentineGameV2ResultView", ReduxView)

function ValentineGameV2ResultView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineResultUI"
end

function ValentineGameV2ResultView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV2ResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ValentineGameV2ResultView:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "isright")
end

function ValentineGameV2ResultView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		manager.story:StartStoryById(ActivityValentineWordCfg[self.curQID_].stroy_id_list[self.selectIndex_], function(arg_7_0)
			JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
				activityID = self.activityID_
			})
		end, true)
	end)
end

function ValentineGameV2ResultView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.curQID_ = self.params_.qID
	self.selectIndex_ = self.params_.selectIndex

	self:RefreshUI()
end

function ValentineGameV2ResultView:RefreshUI()
	if self.selectIndex_ == ActivityValentineWordCfg[self.curQID_].correct_answer then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

function ValentineGameV2ResultView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
			activityID = self.activityID_
		})
	end)
end

function ValentineGameV2ResultView:OnExit()
	manager.windowBar:HideBar()
end

function ValentineGameV2ResultView:Dispose()
	self.super.Dispose(self)
end

return ValentineGameV2ResultView
