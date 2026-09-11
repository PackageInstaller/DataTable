local CommissionInfoChapterAutoItem = class("CommissionInfoChapterAutoItem", import(".CommissionInfoItem"))

function CommissionInfoChapterAutoItem:Ctor(arg_1_1, arg_1_2)
	CommissionInfoChapterAutoItem.super.Ctor(self, arg_1_1, arg_1_2)

	self.timeContainer = self._tf:Find("frame/counter/time")
	self.timeText = self.timeContainer:Find("Text"):GetComponent(typeof(Text))
	self.expireContainer = self._tf:Find("frame/expire")
	self.expireText = self.expireContainer:Find("Text"):GetComponent(typeof(Text))
	self.lockTF = self._tf:Find("lock")

	setActive(self.lockTF, false)
	setText(self.lockTF:Find("Text"), i18n("commission_label_unlock_auto_tip"))

	return
end

function CommissionInfoChapterAutoItem:CanOpen()
	return ChapterAutoProxy.IsSystemOpen()
end

function CommissionInfoChapterAutoItem:Init()
	setActive(self.foldFlag, false)
	CommissionInfoChapterAutoItem.super.Init(self)
	setActive(self.lockTF, not self:CanOpen())

	self.detailPanel = ChapterAutoDetailPanel.New(self._tf, self.view.event)

	return
end

function CommissionInfoChapterAutoItem:OnFlush()
	self.list = {}

	local var_4_0 = getProxy(ChapterAutoProxy)
	local var_4_1 = getProxy(ChapterAutoProxy):GetWillExpireTicketCnt()

	self.expireText.text = i18n("auto_battle_book_expire_warning", var_4_1)

	setActive(self.expireContainer, var_4_1 > 0)

	self.finishedTime = var_4_0:GetFinishAllCommissionTime()

	self:OnUpdateTime()

	if self.isShowTime then
		self:AddTimer()
	else
		self:RemoveTimer()
	end

	return
end

function CommissionInfoChapterAutoItem:OnUpdateTime()
	local var_5_0, var_5_1 = getProxy(ChapterAutoProxy):GetCntInfo()

	self.isLeisure = var_5_1 == 0
	self.isFinishedAll = not self.isLeisure and var_5_0 == var_5_1
	self.isShowTime = not self.isLeisure and not self.isFinishedAll
	self.finishedCounter.text = var_5_0 .. "/" .. var_5_1
	self.ongoingCounter.text = ""
	self.leisureCounter.text = ""

	setActive(self.ongoingCounterContainer, false)
	setActive(self.finishedCounterContainer, not self.isLeisure)
	setActive(self.leisureCounterContainer, self.isLeisure)
	setActive(self.goBtn, self.isLeisure or var_5_0 < var_5_1)
	setActive(self.finishedBtn, self.isFinishedAll)

	if self.isShowTime then
		local var_5_2 = pg.TimeMgr.GetInstance()
		local var_5_3 = self.finishedTime - var_5_2:GetServerTime()

		self.timeText.text = var_5_3 > 0 and var_5_2:DescCDTime(var_5_3) or "00:00:00"
	end

	if self.isFinishedAll then
		self:RemoveTimer()
	end

	return
end

function CommissionInfoChapterAutoItem:UpdateListItem(arg_6_1, arg_6_2, arg_6_3)
	return
end

function CommissionInfoChapterAutoItem:AddTimer()
	self:RemoveTimer()
	setActive(self.timeContainer, true)

	self.timer = Timer.New(function()
		self:OnUpdateTime()

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function CommissionInfoChapterAutoItem:RemoveTimer()
	setActive(self.timeContainer, false)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CommissionInfoChapterAutoItem:GetList()
	return getProxy(ChapterAutoProxy):GetCommissionList()
end

function CommissionInfoChapterAutoItem:OnSkip()
	local var_11_0 = getProxy(ChapterProxy)

	if self.isLeisure then
		self:emit(CommissionInfoMediator.GO_BATTLE)
	else
		self.detailPanel:ExecuteAction("Enter", (var_11_0:getChapterById(var_11_0:GetAutoChapterId())))
	end

	return
end

function CommissionInfoChapterAutoItem:OnFinishAll()
	self:emit(CommissionInfoMediator.ON_END_CHAPTER_AUTO)

	return
end

function CommissionInfoChapterAutoItem:Dispose()
	CommissionInfoChapterAutoItem.super.Dispose(self)
	self:RemoveTimer()

	if self.detailPanel then
		self.detailPanel:Destroy()

		self.detailPanel = nil
	end

	return
end

return CommissionInfoChapterAutoItem
