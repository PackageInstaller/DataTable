local HarborBackHillScene = class("HarborBackHillScene", import("..TemplateMV.BackHillTemplate"))

function HarborBackHillScene:getUIName()
	return "HarborBackHillUI"
end

HarborBackHillScene.edge2area = {
	default = "_SDPlace"
}

function HarborBackHillScene:init()
	HarborBackHillScene.super.init(self)

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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.HarborBackHillGraph"))

	return
end

function HarborBackHillScene:didEnter()
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
			helps = pg.gametip.harbor_backhill_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_PIRATE_ID)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "xuanshangban", function()
		if HarborBackHillScene.XuanShangBanFirstTip() then
			PlayerPrefs.SetInt("FIRST_INTO_ACT_" .. ActivityConst.PIRATE_MEDAL_ACT_ID .. "_" .. getProxy(PlayerProxy):getData().id, 1)
		end

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.TEMPESTA_MEDAL_COLLECTION)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "mimichuanchang", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SECRET_SHIPYARD)

		return
	end)
	self:BindItemActivityShop()
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:UpdateView()

	return
end

function HarborBackHillScene.XuanShangBanFirstTip()
	return PlayerPrefs.GetInt("FIRST_INTO_ACT_" .. ActivityConst.PIRATE_MEDAL_ACT_ID .. "_" .. getProxy(PlayerProxy):getData().id) == 0
end

function HarborBackHillScene.XuanShangBanTip()
	return HarborBackHillScene.XuanShangBanFirstTip() or Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.PIRATE_MEDAL_ACT_ID)))
end

function HarborBackHillScene.IsFinishAllActTask()
	local var_11_0 = getProxy(TaskProxy)

	return underscore.all(pg.activity_template[ActivityConst.BOAT_QIAN_SHAO_ZHAN].config_data[#pg.activity_template[ActivityConst.BOAT_QIAN_SHAO_ZHAN].config_data], function(arg_12_0)
		return var_11_0:getFinishTaskById(arg_12_0)
	end)
end

function HarborBackHillScene.MiMiChuanChangTip()
	if not HarborBackHillScene.IsFinishAllActTask() then
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.BOAT_QIAN_SHAO_ZHAN)))
	else
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_PIRATE_ID)
	end

	return
end

function HarborBackHillScene:UpdateView()
	setActive(self.upper_mimichuanchang:Find("Tip"), HarborBackHillScene.MiMiChuanChangTip())
	setActive(self.upper_xuanshangban:Find("Tip"), HarborBackHillScene.XuanShangBanTip())

	return
end

function HarborBackHillScene:willExit()
	self:clearStudents()
	HarborBackHillScene.super.willExit(self)

	return
end

function HarborBackHillScene:IsShowMainTip()
	if self and not self:isEnd() then
		return HarborBackHillScene.XuanShangBanTip() or HarborBackHillScene.MiMiChuanChangTip()
	end

	return
end

return HarborBackHillScene
