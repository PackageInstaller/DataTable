local LinerSignPage = class("LinerSignPage", import("view.base.BaseActivityPage"))

function LinerSignPage:OnInit()
	self.lockNamed = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED
	self.bg = self._tf:Find("AD")
	self.signTF = self.bg:Find("sign")
	self.items = self.signTF:Find("items")
	self.uilist = UIItemList.New(self.items, self.items:Find("tpl"))
	self.signBtn = self.signTF:Find("get")
	self.signGreyBtn = self.signTF:Find("get_grey")
	self.countText = self.signTF:Find("count_bg/count")
	self.namedTF = self.bg:Find("named")
	self.nameInput = self.namedTF:Find("input/nickname")
	self.sureBtn = self.namedTF:Find("sure")
	self.linerTF = self.bg:Find("liner")
	self.linerInput = self.linerTF:Find("name/input")
	self.linerBtn = self.linerTF:Find("go")

	setText(self.linerBtn:Find("lock/Text"), i18n("liner_sign_unlock_tip"))

	self.nameInput:GetComponent(typeof(InputField)).interactable = not self.lockNamed

	setActive(self.namedTF:Find("input/pan"), not self.lockNamed)

	self.linerInput:GetComponent(typeof(InputField)).interactable = not self.lockNamed

	setActive(self.linerTF:Find("name/edit"), not self.lockNamed)

	return
end

function LinerSignPage:OnDataSetting()
	self.nday = 0
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.taskConfig = pg.task_data_template
	self.preStory = self.activity:getConfig("config_client").preStory

	return updateActivityTaskStatus(self.activity)
end

function LinerSignPage:OnFirstFlush()
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local var_4_0 = Drop.Create(self.taskConfig[self.taskGroup[arg_4_1 + 1]].award_display[1])

			updateDrop(arg_4_2:Find("item_mask/item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("ui/activityuipage/linersignpage_atlas", "D" .. arg_4_1 + 1, arg_4_2:Find("day"), true)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_1 = arg_4_1 + 1
			local var_4_2 = self.taskProxy:getTaskById(self.taskGroup[arg_4_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[arg_4_1 + 1])

			setActive(arg_4_2:Find("cur"), arg_4_1 + 1 == self.nday)
			setActive(arg_4_2:Find("got"), var_4_1 < self.nday or var_4_2 and var_4_2:getTaskStatus() == 2)
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

	self.defaultName = getProxy(PlayerProxy):getRawData():GetName()

	setInputText(self.nameInput, self.defaultName)
	onButton(self, self.sureBtn, function()
		local var_9_0 = getInputText(self.nameInput)

		if var_9_0 == "" then
			return
		end

		if var_9_0 ~= self.defaultName and not nameValidityCheck(var_9_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			return
		end

		self:emit(ActivityMediator.STORE_DATE, {
			actId = ActivityConst.LINER_NAMED_ID,
			strValue = var_9_0,
			callback = function()
				self:OnUpdateFlush()

				return
			end
		})

		return
	end, SFX_PANEL)
	onInputEndEdit(self, self.linerInput, function(arg_11_0)
		if not self:IsNamed() then
			return
		end

		if arg_11_0 ~= self.defaultName and not nameValidityCheck(arg_11_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			setInputText(self.linerInput, self.lastName)

			return
		else
			self:emit(ActivityMediator.STORE_DATE, {
				actId = ActivityConst.LINER_NAMED_ID,
				strValue = arg_11_0,
				callback = function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("liner_name_modify"))
					self:OnUpdateFlush()

					return
				end
			})
		end

		return
	end)
	onButton(self, self.linerBtn, function()
		if self:IsLockLiner() then
			return
		end

		seriesAsync({
			function(arg_14_0)
				if self.preStory and self.preStory ~= "" then
					if not pg.NewStoryMgr.GetInstance():IsPlayed(self.preStory) then
						pg.NewStoryMgr.GetInstance():Play(self.preStory, arg_14_0)

						goto label_14_0
					end
				end

				arg_14_0()

				::label_14_0::

				return
			end
		}, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LINER)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function LinerSignPage:OnUpdateFlush()
	self.nday = self.activity.data3

	local var_16_0 = self:IsFinishSign()

	setActive(self.signTF, not var_16_0)
	setActive(self.namedTF, var_16_0 and not self:IsNamed())
	setActive(self.linerTF, var_16_0 and self:IsNamed())
	setActive(self.linerBtn:Find("lock"), self:IsLockLiner())

	if not var_16_0 then
		self.curTaskVO = self.taskProxy:getTaskById(self.taskGroup[self.nday]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday])
		self.remainCnt = math.min(self.activity:getDayIndex(), #self.taskGroup) - self.nday

		if self.curTaskVO:getTaskStatus() == 1 then
			self.remainCnt = self.remainCnt + 1
		end

		setActive(self.signBtn, self.remainCnt > 0)
		setActive(self.signGreyBtn, self.remainCnt <= 0)
		setText(self.countText, i18n("liner_sign_cnt_tip") .. self.remainCnt)
		self.uilist:align(#self.taskGroup)
	else
		self.lastName = getProxy(ActivityProxy):getActivityById(ActivityConst.LINER_NAMED_ID):getStrData1()

		setInputText(self.linerInput, self.lastName)
	end

	return
end

function LinerSignPage:IsFinishSign()
	local var_17_0 = self.taskProxy:getTaskById(self.taskGroup[#self.taskGroup]) or self.taskProxy:getFinishTaskById(self.taskGroup[#self.taskGroup])

	return var_17_0 and var_17_0:getTaskStatus() == 2
end

function LinerSignPage:IsNamed()
	local var_18_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LINER_NAMED_ID)

	return var_18_0 and not var_18_0:isEnd() and var_18_0:getStrData1() ~= ""
end

function LinerSignPage:IsLockLiner()
	local var_19_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LINER_ID)

	return not var_19_0 or var_19_0:isEnd()
end

return LinerSignPage
