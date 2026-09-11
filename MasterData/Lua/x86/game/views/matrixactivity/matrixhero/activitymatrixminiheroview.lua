local ActivityMatrixMiniHeroView = class("ActivityMatrixMiniHeroView", MatrixMiniHeroView)

function ActivityMatrixMiniHeroView:OnCtor()
	ActivityMatrixMiniHeroView.super.OnCtor(self)

	self.ClassList_ = {
		ActivityMatrixHeroAttributePage,
		ActivityMatrixHeroSkillPage,
		ActivityMartixHeroWeaponPage,
		ActivityMatrixHeroEquipPage,
		ActivityMatrixHeroAstrolabePage
	}
end

function ActivityMatrixMiniHeroView:AddUIListener()
	for iter_2_0, iter_2_1 in pairs(self.toggles_) do
		iter_2_1.onValueChanged:AddListener(function(arg_3_0)
			if arg_3_0 then
				self:SwitchPage(iter_2_0)

				if self.pages_[iter_2_0] then
					self.pages_[iter_2_0]:SetMatirxHeroInfo(self.matrix_activity_id, self.curHeroId_)
				end
			end
		end)
	end
end

function ActivityMatrixMiniHeroView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
end

function ActivityMatrixMiniHeroView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixMiniHeroView.super.OnEnter(self)
end

function ActivityMatrixMiniHeroView:UpdateHeroView()
	self:UpdateAvatarView()

	for iter_6_0, iter_6_1 in pairs(self.pages_) do
		iter_6_1:SetMatirxHeroInfo(self.matrix_activity_id, self.curHeroId_)
	end
end

function ActivityMatrixMiniHeroView:GetHeroData(arg_7_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_7_1)
end

function ActivityMatrixMiniHeroView:GetHeroSkin(arg_8_1)
	return ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, arg_8_1)
end

return ActivityMatrixMiniHeroView
