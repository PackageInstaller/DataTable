local ChapterAutoDetailPanel = class("ChapterAutoDetailPanel", import("view.base.BaseSubView"))

function ChapterAutoDetailPanel:getUIName()
	return "ChapterAutoDetailPanel"
end

function ChapterAutoDetailPanel:OnLoaded()
	setText(self.uiTitleText, i18n("auto_battle_headline"))
	setText(self.uiCommonHeaderText, i18n("auto_battle_ing_base_loot"))
	setText(self.uiExtraHeaderText, i18n("auto_battle_extra_loot"))
	setText(self.uiProficiencyHeaderText, i18n("auto_battle_class_exp_head"))
	setText(self.uiStopBtnText, i18n("auto_battle_ing_stop"))
	setText(self.uiGetBtnText, i18n("auto_battle_ing_finish"))

	self.awardUIList = UIItemList.New(self.uiAwardTF, self.uiAwardTF:Find("item"))

	return
end

function ChapterAutoDetailPanel:OnInit()
	self.awardUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateAwardTpl(arg_4_1, arg_4_2)
		end

		return
	end)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiStopBtn, function()
		self:OnClickBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.uiGetBtn, function()
		self:OnClickBtn()

		return
	end, SFX_PANEL)

	return
end

function ChapterAutoDetailPanel:OnClickBtn()
	pg.m02:sendNotification(GAME.END_CHAPTER_AUTO, {
		num = getProxy(ChapterAutoProxy):GetFinishedCnt()
	})
	self:Hide()

	return
end

function ChapterAutoDetailPanel:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	ChapterAutoDetailPanel.super.Show(self)

	return
end

function ChapterAutoDetailPanel:Enter(arg_11_1)
	self.chapter = arg_11_1

	local var_11_0 = self.chapter:getConfig("icon")

	if var_11_0 and var_11_0[1] then
		setActive(self.uiHeadTF, true)
		setImageSprite(self.uiHeadTF:Find("Image"), LoadSprite("qicon/" .. var_11_0[1]))
	else
		setActive(self.uiHeadTF, false)
	end

	setText(self.uiNameText, self.chapter:getConfig("name"))

	local var_11_1 = getProxy(ChapterAutoProxy)

	self.finishTime = var_11_1:GetFinishAllCommissionTime()

	local var_11_2 = var_11_1:GetCommissionList()

	self.proficiencyOnce = var_11_2[1]:GetClassExpAward()

	setText(self.uiProficiencyText, self.proficiencyOnce)

	self.awards = ChapterAutoDetailPanel.GetAwards(self.chapter)

	self.awardUIList:align(#self.awards)

	local var_11_3 = underscore.any(var_11_2, function(arg_12_0)
		return arg_12_0:UsedTicket()
	end)

	setActive(self.uiDropFrameTF:Find("scroll"), var_11_3)
	setActive(self.uiDropFrameTF:Find("empty"), not var_11_3)

	if pg.TimeMgr.GetInstance():GetServerTime() < self.finishTime then
		self:StartTimer()
	else
		self:UpdateContent()
	end

	self:Show()

	return
end

function ChapterAutoDetailPanel:StartTimer()
	self:StopTimer()

	self.timer = Timer.New(function()
		self:UpdateContent()

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function ChapterAutoDetailPanel:UpdateContent()
	local var_15_0 = pg.TimeMgr.GetInstance()
	local var_15_1 = self.finishTime - var_15_0:GetServerTime()

	setText(self.uiTimeText, i18n("auto_battle_ing_time", var_15_1 > 0 and var_15_0:DescCDTime(var_15_1) or "00:00:00"))

	local var_15_2, var_15_3 = getProxy(ChapterAutoProxy):GetCntInfo()

	setText(self.uiCountText, i18n("auto_battle_ing_cnt", var_15_2, var_15_3))
	setActive(self.uiStopBtn, var_15_2 < var_15_3)
	setActive(self.uiGetBtn, var_15_2 == var_15_3)

	return
end

function ChapterAutoDetailPanel:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ChapterAutoDetailPanel:UpdateAwardTpl(arg_17_1, arg_17_2)
	local var_17_0 = Drop.Create(self.awards[arg_17_1 + 1])

	updateDrop(arg_17_2, var_17_0)
	onButton(self, arg_17_2, function()
		if ({
			[99] = true
		})[var_17_0:getConfig("type")] then
			self:emit(LevelMediator2.GET_CHAPTER_DROP_SHIP_LIST, self.chapter.id, function(arg_19_0)
				local var_19_0 = {}

				for iter_19_0, iter_19_1 in ipairs((var_17_0:getConfig("display_icon"))) do
					local var_19_1 = iter_19_1[2]

					var_19_0[#var_19_0 + 1] = {
						type = iter_19_1[1],
						id = iter_19_1[2],
						anonymous = iter_19_1[1] == DROP_TYPE_SHIP and not table.contains(arg_19_0, var_19_1)
					}
				end

				self:emit(BaseUI.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_19_0,
					content = var_17_0:getConfig("display")
				})

				return
			end)
		else
			self:emit(BaseUI.ON_DROP, var_17_0)
		end

		return
	end, SFX_PANEL)

	return
end

function ChapterAutoDetailPanel:Hide()
	self:StopTimer()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	ChapterAutoDetailPanel.super.Hide(self)

	return
end

function ChapterAutoDetailPanel:OnDestroy()
	self:StopTimer()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChapterAutoDetailPanel:GetAwards()
	local var_22_0 = LevelInfoView.getChapterAwards(self)

	if type(pg.chapter_auto_statistics[self.id].drop_display_extra) == "table" then
		for iter_22_0, iter_22_1 in ipairs(pg.chapter_auto_statistics[self.id].drop_display_extra) do
			table.insert(var_22_0, {
				iter_22_1[1],
				iter_22_1[2]
			})
		end
	end

	return var_22_0
end

return ChapterAutoDetailPanel
