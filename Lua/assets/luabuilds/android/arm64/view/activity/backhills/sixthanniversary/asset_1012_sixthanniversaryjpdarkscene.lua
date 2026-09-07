local SixthAnniversaryJPDarkScene = class("SixthAnniversaryJPDarkScene", import("view.base.BaseUI"))

SixthAnniversaryJPDarkScene.STATUS_LOCK = 1
SixthAnniversaryJPDarkScene.STATUS_FOG = 2
SixthAnniversaryJPDarkScene.STATUS_STORY = 3
SixthAnniversaryJPDarkScene.STATUS_NOROMAL = 4
SixthAnniversaryJPDarkScene.ARROW_ANIM_DELTA = 20
SixthAnniversaryJPDarkScene.ARROW_ANIM_TIME = 0.5

function SixthAnniversaryJPDarkScene:getUIName()
	return "SixthAnniversaryJPDarkUI"
end

function SixthAnniversaryJPDarkScene:init()
	SixthAnniversaryJPDarkScene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self.countText = self._tf:Find("top/Count/Text")

	setText(self._tf:Find("top/Count/explain"), i18n("jp6th_lihoushan_pt1"))

	self.levelcontainer = self._tf:Find("upper")
	self.player = getProxy(PlayerProxy):getRawData()
	self.activityID = ActivityConst.MINIGAME_ZUMA
	self.config = pg.activity_template[self.activityID]
	self.arrowPosYList = {}

	for iter_2_0 = 1, 7 do
		self.arrowPosYList[iter_2_0] = self._tf:Find(tostring(iter_2_0), self.levelcontainer):Find("arrow").localPosition.y
	end

	return
end

function SixthAnniversaryJPDarkScene:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.jp6th_lihoushan_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Shop"), function()
		self:emit(SixthAnniversaryJPDarkMediator.GO_SCENE, SCENE.ZUMA_PT_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Task"), function()
		self:emit(SixthAnniversaryJPDarkMediator.GO_SCENE, SCENE.LAUNCH_BALL_TASK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("BG/door"), function()
		pg.SceneAnimMgr.GetInstance():SixthAnniversaryJPCoverGoScene(SCENE.SIXTH_ANNIVERSARY_JP)

		return
	end, SFX_PANEL)
	self:UpdateView()
	pg.NewStoryMgr.GetInstance():Play(self.config.config_client.lihoushanstory)

	return
end

function SixthAnniversaryJPDarkScene:UpdateView()
	self:UpdateLevels()
	self:UpdateCount()
	self:UpdateTaskTip()

	return
end

function SixthAnniversaryJPDarkScene:UpdateLevels()
	self.unlockCnt = LaunchBallActivityMgr.GetActivityDay(self.activityID)
	self.finishCnt = LaunchBallActivityMgr.GetRoundCount(self.activityID)
	self.maxCnt = LaunchBallActivityMgr.GetRoundCountMax(self.activityID)

	if self.finishCnt < self.maxCnt then
		self.curIndex = self.finishCnt + 1 or -1
	end

	for iter_11_0 = 1, 7 do
		self:UpdateLevelByStatus(self._tf:Find(tostring(iter_11_0), self.levelcontainer), (self:GetLevelStatus(iter_11_0)))
	end

	for iter_11_1 = 1, 3 do
		local var_11_0 = self.levelcontainer:Find("role" .. iter_11_1)

		setActive(var_11_0, LaunchBallActivityMgr.CheckZhuanShuAble(self.activityID, iter_11_1) and not LaunchBallActivityMgr.IsFinishZhuanShu(self.activityID, iter_11_1))
		onButton(self, var_11_0, function()
			pg.NewStoryMgr.GetInstance():Play(self.config.config_client.roleStory[iter_11_1], function()
				LaunchBallActivityMgr.OpenGame(LaunchBallGameConst.round_type_zhuanshu, iter_11_1)

				return
			end)

			return
		end, SFX_PANEL)
	end

	local var_11_1 = self.levelcontainer:Find("endless")

	setActive(var_11_1, self.finishCnt >= self.maxCnt)
	onButton(self, var_11_1, function()
		LaunchBallActivityMgr.OpenGame(LaunchBallGameConst.round_type_wuxian, 1)

		return
	end, SFX_PANEL)

	return
end

function SixthAnniversaryJPDarkScene:GetLevelStatus(arg_15_1)
	return arg_15_1 <= self.finishCnt and SixthAnniversaryJPDarkScene.STATUS_NOROMAL or arg_15_1 == self.curIndex and (arg_15_1 <= self.unlockCnt and (pg.NewStoryMgr.GetInstance():IsPlayed(self.config.config_client.zumaStory[arg_15_1]) and SixthAnniversaryJPDarkScene.STATUS_NOROMAL or SixthAnniversaryJPDarkScene.STATUS_STORY) or SixthAnniversaryJPDarkScene.STATUS_LOCK) or SixthAnniversaryJPDarkScene.STATUS_FOG
end

function SixthAnniversaryJPDarkScene:UpdateLevelByStatus(arg_16_1, arg_16_2)
	if arg_16_2 == SixthAnniversaryJPDarkScene.STATUS_LOCK then
		setActive(arg_16_1:Find("lock"), true)
		setActive(arg_16_1:Find("title/lock"), true)
		setActive(arg_16_1:Find("fog"), false)
		setActive(arg_16_1:Find("tag"), false)
		onButton(self, arg_16_1, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("jp6th_lihoushan_time"))

			return
		end, SFX_PANEL)
	elseif arg_16_2 == SixthAnniversaryJPDarkScene.STATUS_FOG then
		setActive(arg_16_1:Find("lock"), false)
		setActive(arg_16_1:Find("title/lock"), false)
		setActive(arg_16_1:Find("fog"), true)
		setActive(arg_16_1:Find("tag"), false)
		onButton(self, arg_16_1, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("jp6th_lihoushan_order"))

			return
		end, SFX_PANEL)
	elseif arg_16_2 == SixthAnniversaryJPDarkScene.STATUS_STORY then
		setActive(arg_16_1:Find("lock"), false)
		setActive(arg_16_1:Find("title/lock"), false)
		setActive(arg_16_1:Find("fog"), false)
		setActive(arg_16_1:Find("tag"), false)
		onButton(self, arg_16_1, function()
			pg.NewStoryMgr.GetInstance():Play(self.config.config_client.zumaStory[tonumber(arg_16_1.name)], function()
				self:UpdateLevels()

				return
			end)

			return
		end, SFX_PANEL)
	elseif arg_16_2 == SixthAnniversaryJPDarkScene.STATUS_NOROMAL then
		setActive(arg_16_1:Find("lock"), false)
		setActive(arg_16_1:Find("title/lock"), false)
		setActive(arg_16_1:Find("fog"), false)
		setActive(arg_16_1:Find("tag"), true)
		onButton(self, arg_16_1, function()
			LaunchBallActivityMgr.OpenGame(LaunchBallGameConst.round_type_juqing, tonumber(arg_16_1.name))

			return
		end, SFX_PANEL)
	end

	local var_16_0 = arg_16_1:Find("arrow")

	LeanTween.cancel(var_16_0.gameObject)

	local var_16_1 = tonumber(arg_16_1.name)

	if var_16_1 == self.curIndex then
		setLocalPosition(var_16_0, {
			y = self.arrowPosYList[var_16_1]
		})
		setActive(var_16_0, true)
		LeanTween.moveY(var_16_0, self.arrowPosYList[var_16_1] + SixthAnniversaryJPDarkScene.ARROW_ANIM_DELTA, SixthAnniversaryJPDarkScene.ARROW_ANIM_TIME):setLoopPingPong()
	else
		setActive(var_16_0, false)
	end

	return
end

function SixthAnniversaryJPDarkScene:UpdateCount()
	setText(self.countText, LaunchBallActivityMgr.GetRemainCount(self.activityID))

	return
end

function SixthAnniversaryJPDarkScene:UpdateTaskTip()
	setActive(self.top:Find("Task/Tip"), LaunchBallTaskMgr.GetRedTip())

	return
end

function SixthAnniversaryJPDarkScene:onBackPressed()
	self:emit(SixthAnniversaryJPDarkMediator.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP)

	return
end

return SixthAnniversaryJPDarkScene
