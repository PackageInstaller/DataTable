local BirthdayPopView = class("BirthdayPopView", ReduxView)

function BirthdayPopView:UIName()
	return "Widget/System/UserInfor/BirthdayPopUI"
end

function BirthdayPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BirthdayPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BirthdayPopView:InitUI()
	self:BindCfgUI()
end

function BirthdayPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = string.format(GetTips("BIRTHDAY_POP_BACK_TIPS"), ItemCfg[BirthdayCfg[#BirthdayCfg].commemorative_props_id].name),
			OkCallback = function()
				self:Back()
			end,
			CancelCallback = function()
				self:Back()
			end
		})
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
		manager.ui:SetMainCamera("null")
		manager.story:StartStoryById(BirthdayCfg[#BirthdayCfg].story_id, function()
			self:Back()

			local var_10_0 = gameContext:GetLastOpenPage()

			if var_10_0 == "home" then
				gameContext:GetOpenPageHandler(var_10_0):SetCamera()
			end
		end)
		IllustratedData:ModifyPlot(BirthdayCfg[#BirthdayCfg].story_id)
	end)
end

function BirthdayPopView:OnEnter()
	BirthData:SetPopShowState(true)
	self:RefreshUI()
end

function BirthdayPopView:RefreshUI()
	self.titleText_.text = GetTips("BIRTHDAY_POP_TITLE")
	self.descText_.text = GetTips("BIRTHDAY_POP_DESC")
end

function BirthdayPopView:Dispose()
	Object.Destroy(self.gameObject_)
	BirthdayPopView.super.Dispose(self)
end

function BirthdayPopView:Cacheable()
	return false
end

return BirthdayPopView
