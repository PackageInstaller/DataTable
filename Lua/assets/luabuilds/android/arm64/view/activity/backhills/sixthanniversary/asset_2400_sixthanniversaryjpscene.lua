local SixthAnniversaryJPScene = class("SixthAnniversaryJPScene", import("..TemplateMV.BackHillTemplate"))

function SixthAnniversaryJPScene:getUIName()
	return "SixthAnniversaryJPUI"
end

SixthAnniversaryJPScene.edge2area = {
	default = "_SDPlace"
}

function SixthAnniversaryJPScene:init()
	SixthAnniversaryJPScene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SixthAnniversaryJPGraph"))

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT then
		setActive(self.map_shujuhuigu, true)
		setActive(self.upper_shujuhuigu, true)
	else
		setActive(self.map_shujuhuigu, false)
		setActive(self.upper_shujuhuigu, false)
	end

	return
end

function SixthAnniversaryJPScene:didEnter()
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
			helps = pg.gametip.jp6th_biaohoushan_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "jiujiuwenquan", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_HOTSPRING)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "shujuhuigu", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "shijiandiaocha", function()
		pg.SceneAnimMgr.GetInstance():SixthAnniversaryJPCoverGoScene(SCENE.SIXTH_ANNIVERSARY_JP_DARK)

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:UpdateView()
	pg.NewStoryMgr.GetInstance():Play(pg.activity_template[ActivityConst.MINIGAME_ZUMA].config_client.biaohoushanstory)

	return
end

function SixthAnniversaryJPScene.HotSpringTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)))
end

function SixthAnniversaryJPScene.ZumaTip()
	return LaunchBallActivityMgr.IsTip(ActivityConst.MINIGAME_ZUMA) or LaunchBallTaskMgr.GetRedTip()
end

function SixthAnniversaryJPScene:UpdateView()
	setActive(self.upper_jiujiuwenquan:Find("Tip"), SixthAnniversaryJPScene.HotSpringTip())
	setActive(self.upper_shijiandiaocha:Find("Tip"), SixthAnniversaryJPScene.ZumaTip())

	return
end

function SixthAnniversaryJPScene:willExit()
	self:clearStudents()
	SixthAnniversaryJPScene.super.willExit(self)

	return
end

function SixthAnniversaryJPScene:IsShowMainTip()
	if self and not self:isEnd() then
		return SixthAnniversaryJPScene.HotSpringTip() or SixthAnniversaryJPScene.ZumaTip()
	end

	return
end

function SixthAnniversaryJPScene:onBackPressed()
	self:emit(SixthAnniversaryJPScene.ON_HOME)

	return
end

return SixthAnniversaryJPScene
