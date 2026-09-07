local DreamSignPage = class("DreamSignPage", import("view.base.BaseActivityPage"))

function DreamSignPage:OnInit()
	self.lockNamed = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED
	self.bg = self._tf:Find("AD")
	self.signTF = self.bg:Find("sign")
	self.items = self.signTF:Find("items")
	self.uilist = UIItemList.New(self.items, self.items:Find("tpl"))
	self.signBtn = self.signTF:Find("get")
	self.goBtn = self.signTF:Find("go")
	self.lock = self.signTF:Find("lock")
	self.countText = self.signBtn:Find("count")
	self.signRed = self.signBtn:Find("tip")
	self.dreamRed = self.goBtn:Find("tip")

	return
end

function DreamSignPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.taskConfig = pg.task_data_template

	return updateActivityTaskStatus(self.activity)
end

function DreamSignPage:OnFirstFlush()
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local var_4_0 = Drop.Create(self.taskConfig[self.taskGroup[arg_4_1 + 1]].award_display[1])

			updateDrop(arg_4_2:Find("item_mask/item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_1 = self.taskProxy:getTaskById(self.taskGroup[arg_4_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[arg_4_1 + 1])

			setActive(arg_4_2:Find("got"), arg_4_1 + 1 < self.nday or var_4_1 and var_4_1:getTaskStatus() == 2)
		end

		return
	end)
	onButton(self, self.signBtn, function()
		if not self.remainCnt or self.remainCnt <= 0 then
			return
		end

		seriesAsync({
			function(arg_7_0)
				local var_7_0 = self.activity:getConfig("config_client").story

				if checkExist(var_7_0, {
					self.nday
				}, {
					1
				}) then
					pg.NewStoryMgr.GetInstance():Play(var_7_0[self.nday][1], arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				if self.curTaskVO:getTaskStatus() == 1 then
					self:emit(ActivityMediator.ON_TASK_SUBMIT, self.curTaskVO, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		if self:IsLock() then
			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.DREAMLAND)

		return
	end, SFX_PANEL)

	return
end

function DreamSignPage:OnUpdateFlush()
	self.nday = self.activity.data3
	self.curTaskVO = self.taskProxy:getTaskById(self.taskGroup[self.nday]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday])
	self.remainCnt = math.min(self.activity:getDayIndex(), #self.taskGroup) - self.nday

	if self.curTaskVO:getTaskStatus() == 1 then
		self.remainCnt = self.remainCnt + 1
	end

	local var_10_0 = self:IsFinishSign()

	setActive(self.signBtn, not var_10_0)
	setActive(self.goBtn, var_10_0)
	setActive(self.lock, var_10_0 and self:IsLock())
	setActive(self.signRed, self.remainCnt > 0)
	setActive(self.dreamRed, DreamlandFullPreviewScene.DreamlandTip())
	setText(self.countText, i18n("liner_sign_cnt_tip") .. self.remainCnt)
	self.uilist:align(#self.taskGroup)

	return
end

function DreamSignPage:IsFinishSign()
	local var_11_0 = self.taskProxy:getTaskById(self.taskGroup[#self.taskGroup]) or self.taskProxy:getFinishTaskById(self.taskGroup[#self.taskGroup])

	return var_11_0 and var_11_0:getTaskStatus() == 2
end

function DreamSignPage:IsLock()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.DREAMLAND_JP_ID)

	return not var_12_0 or var_12_0:isEnd()
end

return DreamSignPage
