local SenrankaguraBackHillScene = class("SenrankaguraBackHillScene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function SenrankaguraBackHillScene:getUIName()
	return "SenrankaguraBackHillUI"
end

SenrankaguraBackHillScene.edge2area = {
	default = "_SDPlace"
}

function SenrankaguraBackHillScene:init()
	SenrankaguraBackHillScene.super.init(self)

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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SenrankaguraBackHillGraph"))

	return
end

function SenrankaguraBackHillScene:didEnter()
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
			helps = pg.gametip.senrankagura_backhill_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_BUFF)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "renshuzhidaochang", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SENRANKAGURA_TRAIN)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "michuanrenfashu", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SENRANKAGURA_MEDAL)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "renzherenwuban", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.SENRANKAGURA_TURNTABLE
		})

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "baochouleijisuo", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.SENRANKAGURA_PT
		})

		return
	end)
	self:BindItemActivityShop()
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:BindItemBattle()
	self:UpdateView()

	return
end

function SenrankaguraBackHillScene:UpdateView()
	setActive(self.upper_renshuzhidaochang:Find("Tip"), SenrankaguraBackHillScene.TrainTip())
	setActive(self.upper_michuanrenfashu:Find("Tip"), SenrankaguraBackHillScene.MedalTip())
	setActive(self.upper_renzherenwuban:Find("Tip"), SenrankaguraBackHillScene.TaskTip())
	setActive(self.upper_baochouleijisuo:Find("Tip"), SenrankaguraBackHillScene.PTTip())

	return
end

function SenrankaguraBackHillScene:willExit()
	self:clearStudents()
	SenrankaguraBackHillScene.super.willExit(self)

	return
end

function SenrankaguraBackHillScene.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID))) or SenrankaguraMedalScene.GetTaskCountAble()
end

function SenrankaguraBackHillScene.TaskTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_TURNTABLE)))
end

function SenrankaguraBackHillScene.PTTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_PT)))
end

function SenrankaguraBackHillScene.TrainTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_TRAIN_ACT_ID)))
end

function SenrankaguraBackHillScene:IsShowMainTip()
	if self and not self:isEnd() then
		return SenrankaguraBackHillScene.PTTip() or SenrankaguraBackHillScene.MedalTip() or SenrankaguraBackHillScene.TaskTip() or SenrankaguraBackHillScene.TrainTip()
	end

	return
end

return SenrankaguraBackHillScene
