local NewYearsEveDinnerPage = class("NewYearsEveDinnerPage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1 = 3
local var_0_2 = 2
local var_0_3 = Vector2(760, -144)
local var_0_4 = Vector2(370, -144)

function NewYearsEveDinnerPage:OnInit()
	NewYearsEveDinnerPage.super.OnInit(self)

	self.roleTF = self.bg:Find("mask/role_pos")
	self.effectNode = self.bg:Find("mofang_yanwu")
	self.foodTF = self.bg:Find("food")
	self.dialogTF = self.bg:Find("dialog")
	self.rightPanel = self.bg:Find("right_panel")
	self.helpBtn = self.rightPanel:Find("help_btn")
	self.titleFoodTF = self.rightPanel:Find("menu_title/icon")
	self.cookBtn = self.rightPanel:Find("cook_btn")
	self.cookProgress = self.cookBtn:Find("progress")
	self.cookAwardTF = self.cookBtn:Find("award")

	return
end

function NewYearsEveDinnerPage:OnDataSetting()
	self.cookActID = self.activity:getConfig("config_client").linkTaskPoolAct
	self.cookCfg = pg.activity_template[self.cookActID].config_client
	self.cookTaskIds = pg.activity_template[self.cookActID].config_data
	self.totalCookCnt = #self.cookTaskIds
	self.playerId = getProxy(PlayerProxy):getData().id
	self.randomSeed = self:GetRandomById()

	NewYearsEveDinnerPage.super.OnDataSetting(self)

	return
end

function NewYearsEveDinnerPage:GetRandomById()
	local var_3_0 = self.playerId
	local var_3_1 = {}

	while #var_3_1 < 7 do
		var_3_0 = math.floor(var_3_0 / 10)

		if var_3_0 == 0 then
			var_3_0 = self.playerId
		end

		table.insert(var_3_1, var_3_0 % 10)
	end

	return var_3_1
end

function NewYearsEveDinnerPage:OnFirstFlush()
	NewYearsEveDinnerPage.super.OnFirstFlush(self)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.sevenday_nianye.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.cookBtn, function()
		if self.isMoving then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_nianye"))

			return
		end

		if self.isEffectPlaying then
			return
		end

		local var_6_0 = self.taskProxy:getTaskVO(self.curTaskId)

		if var_6_0:getTaskStatus() == 1 then
			setActive(self.effectNode, true)

			self.isEffectPlaying = true

			self:managedTween(LeanTween.delayedCall, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_6_0)
				setActive(self.effectNode, false)

				self.isEffectPlaying = false

				return
			end, var_0_2, nil)
		end

		return
	end, SFX_PANEL)
	setActive(self.cookBtn:Find("shine"), false)

	return
end

function NewYearsEveDinnerPage:OnUpdateFlush()
	NewYearsEveDinnerPage.super.OnUpdateFlush(self)

	self.cookAct = getProxy(ActivityProxy):getActivityById(self.cookActID)

	assert(self.cookAct and not self.cookAct:isEnd(), "自选任务池活动(type86)已结束")
	self:RefreshCookData()
	self:UpdateCookData()
	self:UpdateCookUI()

	return
end

function NewYearsEveDinnerPage:RefreshCookData()
	self.usedCnt = self.cookAct:getData1()

	local var_9_0 = pg.TimeMgr.GetInstance()

	self.unlockCnt = (var_9_0:DiffDay(self.cookAct:getStartTime(), var_9_0:GetServerTime()) + 1) * self.cookAct:getConfig("config_id")
	self.unlockCnt = math.min(self.unlockCnt, self.totalCookCnt)
	self.remainCnt = self.usedCnt >= self.totalCookCnt and 0 or self.unlockCnt - self.usedCnt

	return
end

function NewYearsEveDinnerPage:UpdateCookData()
	local var_10_0 = 0

	self.receivedTasks = {}

	local var_10_1 = underscore.rest(self.cookTaskIds, 1)

	for iter_10_0, iter_10_1 in ipairs(self.cookTaskIds) do
		local var_10_2 = self.taskProxy:getTaskVO(iter_10_1)

		if var_10_2:isReceive() then
			table.insert(self.receivedTasks, var_10_2)

			var_10_0 = var_10_0 + 1

			table.removebyvalue(var_10_1, iter_10_1)
		end
	end

	table.sort(self.receivedTasks, function(arg_11_0, arg_11_1)
		return arg_11_0.submitTime < arg_11_1.submitTime
	end)

	self.receivedTasks = underscore.map(self.receivedTasks, function(arg_12_0)
		return arg_12_0.id
	end)

	if self.usedCnt ~= var_10_0 then
		self.usedCnt = var_10_0
		self.cookAct.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.cookAct)

		return
	end

	local var_10_3

	if self.remainCnt == 0 then
		var_10_3 = self.usedCnt or self.usedCnt + 1

		if self.remainCnt == 0 then
			self.curTaskId = self.receivedTasks[#self.receivedTasks]

			goto label_10_0
		end
	end

	self.curTaskId = var_10_1[self.randomSeed[var_10_3] % #var_10_1 + 1]

	::label_10_0::

	return
end

function NewYearsEveDinnerPage:UpdateCookUI()
	setText(self.cookProgress, ((self.remainCnt == 0 or nil) and (self.usedCnt or self.usedCnt + 1)) .. "/" .. self.totalCookCnt)

	local var_13_0 = self.taskProxy:getTaskVO(self.curTaskId)
	local var_13_1 = var_13_0:getConfig("award_display")[1]

	updateDrop(self.cookAwardTF, {
		type = var_13_1[1],
		id = var_13_1[2],
		count = var_13_1[3]
	})

	local var_13_2 = var_13_0:getTaskStatus() == 2

	setActive(self.cookAwardTF:Find("got"), var_13_2)
	setActive(self.cookAwardTF:Find("icon_bg/count"), var_13_2)
	setText(self.dialogTF:Find("Text"), i18n(self.cookCfg[self.curTaskId][3]))

	local var_13_3

	if var_13_2 then
		var_13_3 = self.cookCfg[self.curTaskId][2] .. "_2" or "unknown"
	end

	GetImageSpriteFromAtlasAsync("ui/activityuipage/NewYearsEveDinnerPage_atlas", self.cookCfg[self.curTaskId][2], self.foodTF, true)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/NewYearsEveDinnerPage_atlas", var_13_3, self.titleFoodTF, true)

	self.prefabName = self.cookCfg[self.curTaskId][1]

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(self.prefabName, true, function(arg_14_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.modelTf = tf(arg_14_0)
		self.modelTf.localPosition = Vector3(0, 0, 0)
		self.modelTf.localScale = Vector3(1, 1, 1)

		self:ClearRole()
		setParent(self.modelTf, self.roleTF)
		self:PlayRoleAnim()

		return
	end)

	return
end

function NewYearsEveDinnerPage:ClearRole()
	self.isMoving = false

	if LeanTween.isTweening(self.roleTF) then
		LeanTween.cancel(self.roleTF)
	end

	removeAllChildren(self.roleTF)

	return
end

function NewYearsEveDinnerPage:PlayRoleAnim()
	local var_16_0 = self.taskProxy:getTaskVO(self.curTaskId):getTaskStatus() == 2
	local var_16_1 = self.modelTf:GetComponent("SpineAnimUI")

	setActive(self.foodTF, false)
	setActive(self.dialogTF, false)
	setActive(self.cookBtn:Find("shine"), false)

	if var_16_0 then
		setAnchoredPosition(self.roleTF, var_0_4)
		var_16_1:SetAction("normal", 0)
		setActive(self.foodTF, true)
		setActive(self.dialogTF, true)
		setActive(self.cookBtn:Find("shine"), not var_16_0 and self.remainCnt > 0)
	else
		var_16_1:SetAction("move", 0)

		self.isMoving = true

		setAnchoredPosition(self.roleTF, var_0_3)
		self:managedTween(LeanTween.moveX, function()
			var_16_1:SetAction("normal", 0)

			self.isMoving = false

			setActive(self.foodTF, var_16_0)
			setActive(self.dialogTF, var_16_0)
			setActive(self.cookBtn:Find("shine"), not var_16_0 and self.remainCnt > 0)

			return
		end, self.roleTF, var_0_4.x, var_0_1):setEase(LeanTweenType.linear)
	end

	return
end

function NewYearsEveDinnerPage:OnDestroy()
	if self.prefabName and self.modelTf then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefabName, self.modelTf.gameObject)

		self.prefabName = nil
		self.modelTf = nil
	end

	self:cleanManagedTween()

	return
end

return NewYearsEveDinnerPage
