local KindergartenScene = class("KindergartenScene", import("view.base.BaseUI"))

function KindergartenScene:getUIName()
	return "KindergartenUI"
end

function KindergartenScene:init()
	self.mainAnim = self._tf:GetComponent(typeof(Animation))
	self.topUI = self._tf:Find("ui/top")

	local var_2_0 = self.topUI:Find("title/title_kinder")

	var_2_0:GetComponent(typeof(Image)):SetNativeSize()

	var_2_0:Find("FX/textmask").localScale = {
		x = var_2_0.rect.width,
		y = var_2_0.rect.height
	}
	self.bottomUI = self._tf:Find("ui/bottom")
	self.paradiseBtn = self.bottomUI:Find("paradise")
	self.paradiseValue = self.paradiseBtn:Find("value/Text")
	self.adventureBtn = self.bottomUI:Find("adventure")
	self.rightUI = self._tf:Find("ui/right")
	self.ptBtn = self.rightUI:Find("pt")
	self.ptValue = self.ptBtn:Find("value/Text")
	self.ptTip = self.ptBtn:Find("tip")
	self.rankBtn = self.rightUI:Find("rank")
	self.taskBtn = self.rightUI:Find("task")
	self.taskTip = self.taskBtn:Find("tip")

	return
end

function KindergartenScene:didEnter()
	onButton(self, self.topUI:Find("back"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("home"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["202406_main_help"].tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.paradiseBtn, function()
		self:emit(KindergartenMediator.GO_SUBLAYER, Context.New({
			mediator = TongXinSpringMediator,
			viewComponent = TongXinSpringLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.adventureBtn, function()
		self:emit(KindergartenMediator.GO_SCENE, SCENE.BOSSRUSH_MAIN)

		return
	end, SFX_PANEL)
	onButton(self, self.ptBtn, function()
		self:emit(KindergartenMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolPtMediator,
			viewComponent = ChildishnessSchoolPtPage
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.rankBtn, function()
		self:emit(KindergartenMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtn, function()
		self:emit(KindergartenMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolTaskMediator,
			viewComponent = ChildishnessSchoolTaskPage
		}))

		return
	end, SFX_PANEL)
	self.mainAnim:Play(self.contextData.isBack and "anim_kinder_main_show" or "anim_kinder_main_in")
	self:UpdateView()

	return
end

function KindergartenScene:UpdateView()
	self:UpdatePt()
	self:UpdateTask()

	return
end

function KindergartenScene:UpdatePt()
	local var_13_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_PT_ACT_ID)

	if var_13_0 and not var_13_0:isEnd() then
		setActive(self.ptBtn, true)
		setActive(self.ptTip, KindergartenScene.ShowPtTip(var_13_0))
		setText(self.ptValue, var_13_0.data1)
	else
		setActive(self.ptBtn, false)
	end

	return
end

function KindergartenScene:UpdateTask()
	local var_14_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID)

	if var_14_0 and not var_14_0:isEnd() then
		setActive(self.taskBtn, true)
		setActive(self.taskTip, KindergartenScene.ShowTaskTip(var_14_0))
	else
		setActive(self.taskBtn, false)
	end

	return
end

function KindergartenScene:UpdateParadise()
	local var_15_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	if var_15_0 and not var_15_0:isEnd() then
		setActive(self.paradiseBtn, true)
		setText(self.paradiseValue, string.format("(%d/%d)", #var_15_0:GetAvaliableShipIds(), (var_15_0:GetTotalSlotCount())))
	else
		setActive(self.paradiseBtn, false)
	end

	return
end

function KindergartenScene:onBackPressed()
	self:quickExitFunc()

	return
end

function KindergartenScene:ShowPtTip()
	return Activity.IsActivityReady(self or getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_PT_ACT_ID))
end

function KindergartenScene:ShowTaskTip()
	return Activity.IsActivityReady(self or getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID))
end

function KindergartenScene.IsShowMainTip()
	return KindergartenScene.ShowPtTip() or KindergartenScene.ShowTaskTip()
end

return KindergartenScene
