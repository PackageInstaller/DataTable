local AntitheticalCoupletResultView = class("AntitheticalCoupletResultView", ReduxView)

function AntitheticalCoupletResultView:UIName()
	return AntitheticalCoupletTools.GetResultUIName(self.params_.activityID)
end

function AntitheticalCoupletResultView:UIParent()
	return manager.ui.uiMain.transform
end

function AntitheticalCoupletResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AntitheticalCoupletResultView:InitUI()
	self:BindCfgUI()
end

function AntitheticalCoupletResultView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/antitheticalCouplet", {
				activityID = self.params_.activityID
			})
		end
	end)
end

function AntitheticalCoupletResultView:OnEnter()
	self:RefreshUI()
end

function AntitheticalCoupletResultView:RefreshUI()
	local var_8_0 = ActivitySpringFestivalCoupletsCfg[self.params_.id]

	self.couplet1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/couplets/" .. ActivitySpringFestivalCoupletsCfg[self.params_.id].start_picture)

	local var_8_1

	if not self.params_.isComplet then
		var_8_1 = manager.story:GetStoryChoice()[1] or 1

		AntitheticalCoupletAction:ChooseStoryID(self.params_.id, var_8_1)
	else
		local var_8_2 = AntitheticalCoupletData:GetData(self.params_.id)

		if not var_8_2 or not var_8_2.chooseID then
			::label_8_0::

			var_8_1 = 1
		end
	end

	self.couplet2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/couplets/" .. var_8_0.result_picture[var_8_1])

	if SDKTools.GetIsEnglish() then
		self.couplet1_text.text = GetI18NText(var_8_0.start_text)
		self.couplet2_text.text = GetI18NText(var_8_0.result_text[var_8_1])
	end
end

function AntitheticalCoupletResultView:OnTop()
	manager.windowBar:HideBar()
end

function AntitheticalCoupletResultView:OnExit()
	return
end

function AntitheticalCoupletResultView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return AntitheticalCoupletResultView
