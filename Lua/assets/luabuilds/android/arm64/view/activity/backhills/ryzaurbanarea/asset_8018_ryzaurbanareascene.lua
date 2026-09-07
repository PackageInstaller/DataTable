local RyzaUrbanAreaScene = class("RyzaUrbanAreaScene", import("..TemplateMV.BackHillTemplate"))

function RyzaUrbanAreaScene:getUIName()
	return "RyzaUrbanAreaUI"
end

RyzaUrbanAreaScene.edge2area = {
	default = "map_middle",
	["2_3"] = "map_front",
	["1_2"] = "map_front",
	["3_4"] = "map_front"
}

function RyzaUrbanAreaScene:init()
	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._shipTpl = self._map:Find("ship")
	self._upper = self._tf:Find("upper")

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self.containers = {
		self.map_front,
		self.map_middle
	}
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.RyzaUrbanAreaGraph"))
	self.minigameCount = self.top:Find("minigame/count")
	self.puniAnim = self._map:Find("huodongye/puni"):GetComponent("SpineAnimUI")

	return
end

function RyzaUrbanAreaScene:didEnter()
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(RyzaUrbanAreaScene.ON_BACK)

		return
	end)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(RyzaUrbanAreaScene.ON_HOME)

		return
	end)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ryza_tip_main.tip
		})

		return
	end)
	self:BindItemActivityShop()
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:BindItemBattle()

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	self:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	self:InitFacilityCross(self._map, self._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 43)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_PT)

	self:InitFacilityCross(self._map, self._upper, "huodongye", function()
		local var_8_0 = {}

		var_8_0.id = var_3_1 and var_3_1.id

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, var_8_0)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "lianjingongfang", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ATELIER_COMPOSITE)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "weituoban", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.RYZA_TASK)

		return
	end)
	self:UpdateView()
	self:AutoFitScreen()

	return
end

function RyzaUrbanAreaScene:UpdateView()
	local var_11_0 = getProxy(ActivityProxy)
	local var_11_2 = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	setActive(self.upper_xiaoyouxi:Find("tip"), (RyzaUrbanAreaScene.IsMiniActNeedTip(var_11_2 and var_11_2.id)))

	local var_11_3 = var_11_2 and getProxy(MiniGameProxy):GetHubByHubId(var_11_2:getConfig("config_id"))

	setText(self.minigameCount, var_11_3.usedtime .. "/" .. var_11_3:getConfig("reward_need"))

	local var_11_4 = var_11_0:getActivityById(ActivityConst.RYZA_PT)

	setActive(self.upper_huodongye:Find("tip"), var_11_4 and var_11_4:readyToAchieve())
	self:UpdatePuniAnim(var_11_4)
	setActive(self.upper_weituoban:Find("tip"), (getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.RYZA_TASK)))

	return
end

function RyzaUrbanAreaScene:UpdatePuniAnim(arg_12_1)
	if not arg_12_1 then
		self.puniAnim:SetAction("normal_" .. math.random(9), 0)
	else
		local var_12_0 = arg_12_1:getConfig("config_client").puni_phase
		local var_12_1 = ActivityPtData.New(arg_12_1):GetLevelProgress()
		local var_12_2 = 1

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			if iter_12_1 < var_12_1 then
				var_12_2 = var_12_2 + 1
			end
		end

		if var_12_2 == #var_12_0 then
			var_12_2 = math.random(#var_12_0)
		end

		self.puniAnim:SetAction("normal_" .. var_12_2, 0)
	end

	return
end

function RyzaUrbanAreaScene:IsShowMainTip()
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_RYZA)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_PT)))
	end)() or (function()
		return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.RYZA_TASK)
	end)()
end

function RyzaUrbanAreaScene:willExit()
	self:clearStudents()

	return
end

return RyzaUrbanAreaScene
