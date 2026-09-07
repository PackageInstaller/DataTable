local WorldBossHPAwardPanel = class("WorldBossHPAwardPanel", import("view.base.BaseSubView"))

function WorldBossHPAwardPanel:Ctor(...)
	WorldBossHPAwardPanel.super.Ctor(self, ...)

	self.buffer = FuncBuffer.New()

	return
end

function WorldBossHPAwardPanel:getUIName()
	return "WorldBossHPAwardWindow"
end

function WorldBossHPAwardPanel:OnInit()
	setText(self._tf:Find("window/top/bg/infomation"), i18n("world_expedition_reward_display"))

	self.itemList = self._tf:Find("window/panel/viewport/list")

	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg_dark"), function()
		self:Hide()

		return
	end)
	self.buffer:SetNotifier(self)
	self.buffer:ExcuteAll()

	return
end

function WorldBossHPAwardPanel:Show()
	WorldBossHPAwardPanel.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function WorldBossHPAwardPanel:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	WorldBossHPAwardPanel.super.Hide(self)

	return
end

function WorldBossHPAwardPanel:UpdateView(arg_8_1)
	self:Show()

	local var_8_0 = arg_8_1:GetHP()

	if arg_8_1:IsPeriodEnemy() then
		var_8_0 = math.min(var_8_0, nowWorld():GetHistoryLowestHP(arg_8_1.id))
	end

	local var_8_1 = pg.world_expedition_data[arg_8_1:GetBattleStageId()]
	local var_8_2 = var_8_1 and var_8_1.phase_drop_display

	UIItemList.StaticAlign(self.itemList, self.itemList:GetChild(0), (var_8_1 and var_8_1.phase_drop_display or nil) and (#var_8_2 or 0), function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_9_0 = var_8_2[arg_9_1 + 1]
		local var_9_1 = var_8_0 <= var_8_2[arg_9_1 + 1][1]

		setText(arg_9_2:Find("target"), i18n("world_expedition_reward_display2", math.ceil(var_8_2[arg_9_1 + 1][1] / 100)))
		setActive(arg_9_2:Find("mask"), var_9_1)
		UIItemList.StaticAlign(arg_9_2:Find("awards"), arg_9_2:Find("awards"):GetChild(0), #var_9_0[2], function(arg_10_0, arg_10_1, arg_10_2)
			local var_10_0

			if arg_10_0 ~= UIItemList.EventUpdate then
				do return end

				var_10_0 = {
					type = var_9_0[2][arg_10_1 + 1][1],
					id = var_9_0[2][arg_10_1 + 1][2]
				}
			end

			var_10_0.count = var_9_0[2][arg_10_1 + 1][3]

			updateDrop(arg_10_2:Find("IconTpl"), var_10_0)
			onButton(self, arg_10_2:Find("IconTpl"), function()
				self:emit(BaseUI.ON_DROP, var_10_0)

				return
			end)

			return
		end)

		return
	end)

	return
end

return WorldBossHPAwardPanel
