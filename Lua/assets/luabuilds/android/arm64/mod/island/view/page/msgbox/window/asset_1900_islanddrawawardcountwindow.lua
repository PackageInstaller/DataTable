local IslandDrawAwardCountWindow = class("IslandDrawAwardCountWindow", import("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function IslandDrawAwardCountWindow:getUIName()
	return "IslandDrawAwardCountMsgBox"
end

function IslandDrawAwardCountWindow:OnLoaded()
	return
end

function IslandDrawAwardCountWindow:OnInit()
	setText(self.rtTitle, i18n("island_draw_choice_title"))
	onButton(self, self.btnClose, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.toggleList = UIItemList.New(self.rtToggles, self.rtToggleTpl)

	self.toggleList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0, var_5_1 = unpack(self.countAwardList[arg_5_1])
			local var_5_2 = Drop.New({
				type = pg.island_draw_reward[var_5_0].drop_type,
				id = pg.island_draw_reward[var_5_0].drop_id
			})

			IslandShopDrawAwardPage.ShowDropInfo(var_5_2, arg_5_2:Find("mask/Image"))
			setText(arg_5_2:Find("name/Text"), var_5_2:getName())
			setText(arg_5_2:Find("got/got/Text"), i18n("island_draw_get"))
			onToggle(self, arg_5_2, function(arg_6_0)
				if arg_6_0 then
					self.selectedTarget = var_5_0
				elseif self.selectedTarget == var_5_0 then
					self.selectedTarget = nil
				end

				return
			end, SFX_UI_CLICK)
			triggerToggle(arg_5_2, false)
			setToggleEnabled(arg_5_2, var_5_1)
			setActive(arg_5_2:Find("got"), not var_5_1)
		end

		return
	end)
	setText(self.btnConfirm:Find("Text"), i18n("word_take"))
	onButton(self, self.btnConfirm, function()
		if not self.selectedTarget or not self.activity:CanCountAward(self.selectedTarget) then
			return
		end

		self:emit(IslandMediator.DRAW_AWARD_OPERATION, {
			op = "count_award",
			activity_id = self.activity.id,
			target_id = self.selectedTarget
		})
		self:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function IslandDrawAwardCountWindow:OnShow()
	IslandDrawAwardCountWindow.super.OnShow(self)
	self:UpdateActivity(self.settings.activity)

	return
end

function IslandDrawAwardCountWindow:UpdateActivity(arg_9_1)
	self.activity = arg_9_1
	self.countAwardList = arg_9_1:GetCountAwards()

	self.toggleList:align(#self.countAwardList)
	setText(self.rtCountWord, i18n("island_draw_choice") .. string.format("%d/%d", self.activity:GetDrawCount(), self.activity:GetNextCountAwardTimes() or 0))
	setGray(self.btnConfirm, not self.activity:CanCountAward(self.selectedTarget))

	return
end

return IslandDrawAwardCountWindow
