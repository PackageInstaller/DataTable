local DormSignPage = class("DormSignPage", import("view.base.BaseActivityPage"))

function DormSignPage:getUIName()
	return "DormSignPage"
end

function DormSignPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.items:Find("tpl"))
	self.goBtn = self.bg:Find("btn_go")
	self.lockTF = self.bg:Find("lock")

	return
end

function DormSignPage:OnDataSetting()
	self.actTaskProxy = getProxy(ActivityTaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.taskConfig = pg.task_data_template

	return
end

function DormSignPage:UpdateTaskData()
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

function DormSignPage:OnFirstFlush()
	self.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			local var_8_0 = self.taskGroup[arg_8_1 + 1]
			local var_8_1 = Drop.Create(self.taskConfig[self.taskGroup[arg_8_1 + 1]].award_display[1])

			if arg_8_1 + 1 > 1 then
				updateDrop(arg_8_2:Find("item"), var_8_1)
			end

			onButton(self, arg_8_2, function()
				if self.taskDic[var_8_0] and self.taskDic[var_8_0]:getTaskStatus() == 1 and not self.taskDic[var_8_0]:isOver() then
					self:emit(ActivityMediator.ON_ACTIVITY_TASK_SUBMIT, {
						activityId = self.activity.id,
						id = var_8_0
					})
				else
					self:emit(BaseUI.ON_DROP, var_8_1)
				end

				return
			end, SFX_PANEL)
		elseif arg_8_0 == UIItemList.EventUpdate then
			setActive(arg_8_2:Find("got"), self.taskDic[self.taskGroup[arg_8_1 + 1]] and self.taskDic[self.taskGroup[arg_8_1 + 1]]:isOver())
			setActive(arg_8_2:Find("tip"), self.taskDic[self.taskGroup[arg_8_1 + 1]] and self.taskDic[self.taskGroup[arg_8_1 + 1]]:getTaskStatus() == 1 and not self.taskDic[self.taskGroup[arg_8_1 + 1]]:isOver())
		end

		return
	end)
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.DORM3DSELECT)

		return
	end, SFX_PANEL)

	local var_7_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "SelectDorm3DMediator")

	setActive(self.goBtn, var_7_0)
	setActive(self.lockTF, not var_7_0)
	setActive(self.goBtn:Find("tip"), DormSignPage.IsShowGoRed())
	PlayerPrefs.SetString("DormSignPage", DormSignPage.GetDate())

	return
end

function DormSignPage:OnUpdateFlush()
	self:UpdateTaskData()
	self.uilist:align(#self.taskGroup)

	return
end

function DormSignPage.GetDate()
	return pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function DormSignPage.IsShowRed()
	return DormSignPage.IsShowGoRed() or DormSignPage.IsShowAwardRed()
end

function DormSignPage.IsShowGoRed()
	return PlayerPrefs.GetString("DormSignPage", "") ~= DormSignPage.GetDate()
end

function DormSignPage.IsShowAwardRed()
	return _.any(getProxy(ActivityTaskProxy):getTaskById(ActivityConst.DORM_SIGN_ID), function(arg_16_0)
		return arg_16_0:getTaskStatus() == 1
	end)
end

return DormSignPage
