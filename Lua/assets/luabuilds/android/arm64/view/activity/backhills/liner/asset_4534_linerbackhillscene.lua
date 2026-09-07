local LinerBackHillScene = class("LinerBackHillScene", import("..TemplateMV.BackHillTemplate"))

LinerBackHillScene.optionsPath = {
	"top/btn_home"
}
LinerBackHillScene.ACT_ID = ActivityConst.LINER_ID
LinerBackHillScene.MINIGAME_ID = 65
LinerBackHillScene.TASK_ACT_ID = ActivityConst.LINER_SIGN_ID
LinerBackHillScene.NAME_ID = ActivityConst.LINER_NAMED_ID

function LinerBackHillScene:getUIName()
	return "LinerBackHillUI"
end

function LinerBackHillScene:getBGM()
	return self.activity:getConfig("config_client").backHillBgm[LinerBackHillScene.IsDay() and "day" or "night"]
end

function LinerBackHillScene.IsDay()
	local var_3_0 = pg.TimeMgr.GetInstance():GetServerHour()
	local var_3_1 = getProxy(ActivityProxy):getActivityById(LinerBackHillScene.ACT_ID)

	assert(var_3_1 and not var_3_1:isEnd(), "not exist liner act, type: " .. LinerBackHillScene.ACT_ID)

	local var_3_2 = var_3_1:getConfig("config_client").time

	return var_3_0 >= var_3_2[1] and var_3_0 < var_3_2[2]
end

function LinerBackHillScene:init()
	self._dayTF = self._tf:Find("day")
	self._nightTF = self._tf:Find("night")

	for iter_4_0 = 0, self._dayTF.childCount - 1 do
		local var_4_0 = self._dayTF:GetChild(iter_4_0)

		self["day_" .. go(var_4_0).name] = var_4_0
	end

	for iter_4_1 = 0, self._nightTF.childCount - 1 do
		local var_4_1 = self._nightTF:GetChild(iter_4_1)

		self["night_" .. go(var_4_1).name] = var_4_1
	end

	self._map = self._dayTF
	self._upper = self._nightTF
	self._log_tip = self._tf:Find("top/btn_log/tip")
	self._unlock = self._tf:Find("top/unlock_info")
	self.activity = getProxy(ActivityProxy):getActivityById(LinerBackHillScene.ACT_ID)
	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function LinerBackHillScene:didEnter()
	onButton(self, self._tf:Find("top/btn_back"), function()
		self:emit(LinerBackHillScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["7th_main_tip"].tip
		})

		return
	end, SFX_PANEL)
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:InitFacilityCross(self._dayTF, self._nightTF, "btn_game", function()
		self:emit(LinerBackHillMediator.GO_MINIGAME, LinerBackHillScene.MINIGAME_ID)

		return
	end)
	self:InitFacilityCross(self._dayTF, self._nightTF, "btn_cruise", function()
		self:emit(LinerBackHillMediator.GO_SCENE, SCENE.LINER)
		PlayerPrefs.SetString("LinerBackHillScene", LinerBackHillScene.GetDate())

		return
	end)
	self:InitFacilityCross(self._dayTF, self._nightTF, "btn_task", function()
		self:emit(LinerBackHillMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = LinerBackHillScene.TASK_ACT_ID
		})

		return
	end)

	local var_5_0 = not pg.NewStoryMgr.GetInstance():IsPlayed(getProxy(ActivityProxy):getActivityById(LinerBackHillScene.TASK_ACT_ID):getConfig("config_client").preStory)

	onButton(self, self._tf:Find("top/btn_log"), function()
		if var_5_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("liner_activity_lock"))
		else
			self:emit(LinerBackHillMediator.GO_SUBLAYER, Context.New({
				mediator = LinerLogBookMediator,
				viewComponent = LinerLogBookLayer
			}))
		end

		return
	end, SFX_PANEL)
	setActive(self.day_btn_task, var_5_0)
	setActive(self.night_btn_task, var_5_0)
	setActive(self._unlock, var_5_0)
	setActive(self.day_btn_cruise, not var_5_0)
	setActive(self.night_btn_cruise, not var_5_0)
	setActive(self._dayTF, LinerBackHillScene.IsDay())
	setActive(self._nightTF, not LinerBackHillScene.IsDay())
	self:UpdateView()

	return
end

function LinerBackHillScene:UpdateView()
	setActive(self._log_tip, LinerBackHillScene.LogTip())
	setActive(self.day_btn_game:Find("tip"), LinerBackHillScene.MiniGameTip())
	setActive(self.night_btn_game:Find("tip"), LinerBackHillScene.MiniGameTip())
	setActive(self.day_btn_cruise:Find("tip"), LinerBackHillScene.CruiseTip())
	setActive(self.night_btn_cruise:Find("tip"), LinerBackHillScene.CruiseTip())

	return
end

function LinerBackHillScene.GetDate()
	return pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function LinerBackHillScene.LogTip()
	return LinerLogBookLayer.IsTip()
end

function LinerBackHillScene.MiniGameTip()
	return getProxy(MiniGameProxy):GetHubByGameId(LinerBackHillScene.MINIGAME_ID).count > 0
end

function LinerBackHillScene.CruiseTip()
	return not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER):IsFinishAllTime() and PlayerPrefs.GetString("LinerBackHillScene") ~= LinerBackHillScene.GetDate()
end

function LinerBackHillScene:IsShowMainTip()
	if self and not self:isEnd() then
		return LinerBackHillScene.LogTip() or LinerBackHillScene.MiniGameTip() or LinerBackHillScene.CruiseTip()
	end

	return
end

function LinerBackHillScene:willExit()
	return
end

return LinerBackHillScene
