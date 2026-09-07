local MusicFestivalScene3 = class("MusicFestivalScene3", import("..TemplateMV.BackHillTemplate"))

function MusicFestivalScene3:getUIName()
	return "MusicFestivalUI3"
end

MusicFestivalScene3.edge2area = {
	default = "_SDPlace"
}

function MusicFestivalScene3:init()
	MusicFestivalScene3.super.init(self)

	self.top = self._tf:Find("top")
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

	self._SDPlace = self._upper:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.MusicFestivalGraph3"))

	return
end

function MusicFestivalScene3:didEnter()
	onButton(self, self._tf:Find("top/Back"), function()
		self:emit(MusicFestivalScene3.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/Home"), function()
		self:emit(MusicFestivalScene3.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idol3rd_houshan.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID_3)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	self:InitFacilityCross(self._map, self._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 16)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_PT_ID_3)

	self:InitFacilityCross(self._map, self._upper, "huodongye", function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_3_1.id
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "dalaozhang", function()
		self:emit(MusicFestivalMediator.GO_SCENE, SCENE.IDOL_MEDAL_COLLECTION_SCENE3)

		return
	end)
	self:BindItemActivityShop()
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:BindItemBattle()
	self:UpdateView()

	return
end

function MusicFestivalScene3.MiniGameTip()
	return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MUSIC_FESTIVAL_ID_3)
end

function MusicFestivalScene3.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function MusicFestivalScene3.ActivityTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_PT_ID_3)))
end

function MusicFestivalScene3:UpdateView()
	setActive(self.upper_xiaoyouxi:Find("Tip"), MusicFestivalScene3.MiniGameTip())
	setActive(self.upper_dalaozhang:Find("Tip"), MusicFestivalScene3.MedalTip())
	setActive(self.upper_huodongye:Find("Tip"), MusicFestivalScene3.ActivityTip())

	return
end

function MusicFestivalScene3:IsShowMainTip()
	if self and not self:isEnd() then
		return MusicFestivalScene3.MiniGameTip() or MusicFestivalScene3.MedalTip() or MusicFestivalScene3.ActivityTip()
	end

	return
end

function MusicFestivalScene3:willExit()
	self:clearStudents()
	MusicFestivalScene3.super.willExit(self)

	return
end

return MusicFestivalScene3
