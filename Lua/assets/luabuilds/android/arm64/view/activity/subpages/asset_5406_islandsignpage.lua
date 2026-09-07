local IslandSignPage = class("IslandSignPage", import("view.base.BaseActivityPage"))

function IslandSignPage:getUIName()
	return "IslandSignPage"
end

function IslandSignPage:OnInit()
	self.uilist = UIItemList.New(self.uiItemsTf, self.uiItemTf)
	self.uiGotList = UIItemList.New(self.uiItemsGetTf, self.uiGotItemTf)

	setText(self.uiText, i18n("island_sign_text"))

	return
end

function IslandSignPage:OnDataSetting()
	self.actTaskProxy = getProxy(ActivityTaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.taskConfig = pg.task_data_template

	return
end

function IslandSignPage:UpdateTaskData()
	self.taskVOs = self.actTaskProxy:getTaskById(self.activity.id)
	self.finishTaksVOs = self.actTaskProxy:getFinishTaskById(self.activity.id)
	self.taskDic = {}

	_.each(self.taskVOs, function(arg_5_0)
		self.taskDic[arg_5_0.id] = arg_5_0

		return
	end)
	_.each(self.finishTaksVOs, function(arg_6_0)
		self.taskDic[arg_6_0.id] = arg_6_0

		return
	end)

	return
end

function IslandSignPage:OnFirstFlush()
	self.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			local var_8_0 = Drop.Create(self.taskConfig[self.taskGroup[arg_8_1 + 1]].award_display[1])

			if arg_8_1 + 1 < 7 then
				updateDrop(arg_8_2:Find("item"), var_8_0)
			end

			onButton(self, arg_8_2, function()
				self:emit(BaseUI.ON_DROP, var_8_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiGotList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			setActive(arg_10_2:Find("get_bg"), self.taskDic[self.taskGroup[arg_10_1 + 1]] and self.taskDic[self.taskGroup[arg_10_1 + 1]]:isOver())
			setActive(arg_10_2:Find("tip"), self.taskDic[self.taskGroup[arg_10_1 + 1]] and self.taskDic[self.taskGroup[arg_10_1 + 1]]:getTaskStatus() == 0 and not self.taskDic[self.taskGroup[arg_10_1 + 1]]:isOver())
		end

		return
	end)
	setActive(self.uiGoBtn:Find("tip"), #self:GetCanReceiveTaskList() > 0)
	onButton(self, self.uiGoBtn, function()
		if self.liveAreaPage == nil then
			self.liveAreaPage = MainLiveAreaPage.New(self._parentTf, self.event)
		end

		self.liveAreaPage:ExecuteAction("Show", true, function()
			local var_12_0 = self:GetCanReceiveTaskList()

			if #var_12_0 > 0 then
				self:emit(ActivityMediator.ON_ACTIVITY_TASK_LIST_SUBMIT, {
					activityId = self.activity.id,
					ids = var_12_0
				})
			end

			return
		end)

		return
	end, SFX_PANEL)
	PlayerPrefs.SetString("IslandSignPage", IslandSignPage.GetDate())

	return
end

function IslandSignPage:OnUpdateFlush()
	self:UpdateTaskData()
	self.uilist:align(#self.taskGroup)
	self.uiGotList:align(#self.taskGroup)
	setActive(self.uiGoBtn:Find("tip"), #self:GetCanReceiveTaskList() > 0)

	return
end

function IslandSignPage.GetDate()
	return pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function IslandSignPage.IsShowRed()
	return IslandSignPage.IsShowAwardRed()
end

function IslandSignPage.IsShowGoRed()
	return PlayerPrefs.GetString("IslandSignPage", "") ~= IslandSignPage.GetDate()
end

function IslandSignPage.IsShowAwardRed()
	return _.any(getProxy(ActivityTaskProxy):getTaskById(ActivityConst.ISLAND_SIGN_ID), function(arg_18_0)
		return arg_18_0:getTaskStatus() == 0
	end)
end

function IslandSignPage:GetCanReceiveTaskList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs((getProxy(ActivityTaskProxy):getTaskById(ActivityConst.ISLAND_SIGN_ID))) do
		if iter_19_1:getTaskStatus() == 0 then
			table.insert(var_19_0, iter_19_1.id)
		end
	end

	return var_19_0
end

function IslandSignPage:Destroy()
	if self.liveAreaPage then
		self.liveAreaPage:Destroy()

		self.liveAreaPage = nil
	end

	IslandSignPage.super.Destroy(self)

	return
end

function IslandSignPage:onBackPressed()
	if self.liveAreaPage and self.liveAreaPage:GetLoaded() and self.liveAreaPage:isShowing() then
		self.liveAreaPage:Hide()

		return true
	end

	return false
end

return IslandSignPage
