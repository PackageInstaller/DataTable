local OtherworldBackHillScene = class("OtherworldBackHillScene", import("..TemplateMV.BackHillTemplate"))

function OtherworldBackHillScene:getUIName()
	return "OtherworldBackHillUI"
end

OtherworldBackHillScene.edge2area = {
	default = "_SDPlace"
}

function OtherworldBackHillScene:init()
	OtherworldBackHillScene.super.init(self)

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
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.OtherworldBackHillSceneGraph"))
	self.ptIconTF = self._tf:Find("top/Res/icon")
	self.ptValueTF = self._tf:Find("top/Res/Text")

	return
end

function OtherworldBackHillScene:didEnter()
	self:SetNativeSizes()
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
			helps = pg.gametip.otherworld_backhill_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/Terminal"), function()
		self:emit(OtherworldBackHilllMediator.GO_SUBLAYER, Context.New({
			mediator = OtherworldTerminalMediator,
			viewComponent = OtherworldTerminalLayer
		}))

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/OtherWorld"), function()
		pg.SceneAnimMgr.GetInstance():OtherWorldCoverGoScene(SCENE.OTHERWORLD_MAP, {
			mode = OtherworldMapScene.MODE_BATTLE
		})

		return
	end, SFX_CANCEL)
	self:InitFacilityCross(self._map, self._upper, "maoxianzgonghui", function()
		local var_9_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TASK_ID)

		if not var_9_0 or var_9_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		self:emit(OtherworldBackHilllMediator.GO_SUBLAYER, Context.New({
			mediator = OtherWorldTaskMediator,
			viewComponent = OtherWorldTaskLayer
		}))

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "jiujiushendian", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.OTHER_WORLD_TEMPLE_SCENE)

		return
	end)
	self:BindItemSkinShop()
	self:UpdateView()

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID)

	if not var_3_0 then
		return
	end

	self.resId = pg.activity_random_award_template[var_3_0:getConfig("config_data")[1]].resource_type

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = self.resId
	}):getIcon(), "", self.ptIconTF)
	self:UpdateRes()

	return
end

function OtherworldBackHillScene:SetNativeSizes()
	eachChild(self._upper, function(arg_12_0)
		local var_12_0 = arg_12_0:Find("Image")
		local var_12_1 = var_12_0 and var_12_0:GetComponent(typeof(Image))

		if var_12_1 then
			var_12_1:SetNativeSize()
		end

		return
	end)

	return
end

function OtherworldBackHillScene.GongHuiTip()
	return getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.OTHER_WORLD_TASK_ID)
end

function OtherworldBackHillScene.ShenDianTip()
	return ActivityItemPool.GetTempleRedTip(ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID)
end

function OtherworldBackHillScene.TerminalTip()
	return TerminalAdventurePage.IsTip()
end

function OtherworldBackHillScene:UpdateRes()
	setText(self.ptValueTF, getProxy(PlayerProxy):getData():getResource(self.resId))

	return
end

function OtherworldBackHillScene:UpdateView()
	setActive(self.upper_maoxianzgonghui:Find("Tip"), OtherworldBackHillScene.GongHuiTip())
	setActive(self.upper_jiujiushendian:Find("Tip"), OtherworldBackHillScene.ShenDianTip())
	setActive(self._tf:Find("top/Terminal/Tip"), OtherworldBackHillScene.TerminalTip())

	return
end

function OtherworldBackHillScene:UpdateActivity()
	self:UpdateView()

	return
end

function OtherworldBackHillScene:willExit()
	self:clearStudents()
	OtherworldBackHillScene.super.willExit(self)

	return
end

function OtherworldBackHillScene:IsShowMainTip()
	if self and not self:isEnd() then
		return OtherworldBackHillScene.GongHuiTip() or OtherworldBackHillScene.ShenDianTip()
	end

	return
end

function OtherworldBackHillScene.IsShowTip()
	return OtherworldBackHillScene.GongHuiTip() or OtherworldBackHillScene.ShenDianTip()
end

return OtherworldBackHillScene
