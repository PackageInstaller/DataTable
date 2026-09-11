local DormInfomationView = class("DormInfomationView", ReduxView)

function DormInfomationView:UIName()
	return "Widget/BackHouseUI/Dorm/DormPanelOverviewUI"
end

function DormInfomationView:UIParent()
	return manager.ui.uiMain.transform
end

function DormInfomationView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormInfomationView:BuildContext()
	self.page = DormInfoOverviewPage.New(self.overviewObj_)
end

function DormInfomationView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
end

function DormInfomationView:AddUIListener()
	self:AddBtnListener(self.oneKeyBtn_, nil, function()
		DormAction:GiftFoodToHero(nil, nil, 1, function(arg_8_0, arg_8_1, arg_8_2)
			manager.notify:Invoke(BACKHOME_CATEEN_FEED_SUCCESS)
		end, function()
			ShowTips(GetTips("DORM_FEED_MAX"))
		end)
	end)
	self:AddBtnListener(self.autoPlaceBtn_, nil, function()
		BackHomeTools:OnceDeploy()
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormAdviceView")
	end)
end

function DormInfomationView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.ui:ShowBackground(false)
		self:Back()
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = {
				"Widget/BackHouseUI/Dorm/DormInfoPanelDescription_01"
			}
		}
	})
end

function DormInfomationView:OnEnter()
	manager.ui:ShowBackground(true)
	self.page:Show()
end

function DormInfomationView:Back()
	manager.ui:ShowBackground(false)
	DormInfomationView.super.Back(self)
end

function DormInfomationView:OnExit()
	self:RemoveAllEventListener()
	self.page:Hide()
end

function DormInfomationView:OnTop()
	self:RefreshBar()
	self.page:Render()
end

function DormInfomationView:OnBehind()
	manager.windowBar:HideBar()
end

function DormInfomationView:Dispose()
	self.page:Dispose()

	self.page = nil

	DormInfomationView.super.Dispose(self)
end

return DormInfomationView
