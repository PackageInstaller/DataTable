local USCastle2023Scene = class("USCastle2023Scene", import("..TemplateMV.BackHillTemplate"))

USCastle2023Scene.EffectName = {
	"yanhua_01",
	"yanhua_02",
	"yanhua_maomao",
	"yanhua_mofang",
	"yanhua_chuanmao",
	"yanhua_huangji",
	"yanhua_xinxin",
	"yanhua_Azurlane"
}
USCastle2023Scene.FireworkRange = Vector2(300, 300)
USCastle2023Scene.EffectPosLimit = {
	limitX = {
		-700,
		700
	},
	limitY = {
		250,
		500
	}
}
USCastle2023Scene.EffectInterval = 1.5
USCastle2023Scene.EffectRecycleTime = 3
USCastle2023Scene.SFX_LIST = {
	"event:/ui/firework1",
	"event:/ui/firework2",
	"event:/ui/firework3",
	"event:/ui/firework4"
}

function USCastle2023Scene:getUIName()
	return "USCastle2023UI"
end

USCastle2023Scene.edge2area = {
	default = "_SDPlace"
}

function USCastle2023Scene:init()
	USCastle2023Scene.super.init(self)

	self.top = self._tf:Find("top")
	self._bg = self._tf:Find("BG")
	self._map = self._tf:Find("map")

	for iter_2_0 = 0, self._map.childCount - 1 do
		local var_2_0 = self._map:GetChild(iter_2_0)

		self["map_" .. go(var_2_0).name] = var_2_0
	end

	self._upper = self._tf:Find("upper")
	self.upper_yanhuiyaoyue = nil
	self.upper_xintiaochengbao = nil

	for iter_2_1 = 0, self._upper.childCount - 1 do
		local var_2_1 = self._upper:GetChild(iter_2_1)

		self["upper_" .. go(var_2_1).name] = var_2_1
	end

	self._SDPlace = self._tf:Find("SDPlace")
	self.containers = {
		self._SDPlace
	}
	self._shipTpl = self._map:Find("ship")
	self.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.USCastle2023Graph"))
	self.fireworksTF = self._tf:Find("play_fireworks")
	self.fireworksList = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8
	}

	return
end

function USCastle2023Scene:didEnter()
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
			helps = pg.gametip.uscastle2023_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_XINTIAOCHENGBAO)

	self:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	self:InitFacilityCross(self._map, self._upper, "yanhuiyaoyue", function()
		local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

		if var_7_0 and not var_7_0:isEnd() then
			self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.FEAST)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))
		end

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "xintiaochengbao", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 56)

		return
	end)
	self:InitFacilityCross(self._map, self._upper, "shujvhuigu", function()
		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SUMMARY)

		return
	end)
	self:BindItemSkinShop()
	self:BindItemBuildShip()
	self:UpdateView()
	self:PlayFireworks()

	return
end

function USCastle2023Scene.FeastTip()
	return getProxy(FeastProxy):ShouldTip()
end

function USCastle2023Scene.XinTiaoChengBaoTip()
	return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_XINTIAOCHENGBAO)
end

function USCastle2023Scene:UpdateView()
	setActive(self.upper_yanhuiyaoyue:Find("Tip"), USCastle2023Scene.FeastTip())
	setActive(self.upper_xintiaochengbao:Find("Tip"), USCastle2023Scene.XinTiaoChengBaoTip())

	return
end

function USCastle2023Scene:willExit()
	self:clearStudents()
	self:StopPlayFireworks()
	USCastle2023Scene.super.willExit(self)

	return
end

function USCastle2023Scene:IsShowMainTip()
	if self and not self:isEnd() then
		return USCastle2023Scene.XinTiaoChengBaoTip() or USCastle2023Scene.FeastTip()
	end

	return
end

function USCastle2023Scene:PlayFireworks()
	self:StopPlayFireworks()
	self:PlayerOneFirework()

	self.fireworksTimer = Timer.New(function()
		self:PlayerOneFirework()

		return
	end, USCastle2023Scene.EffectInterval, -1)

	self.fireworksTimer:Start()

	return
end

function USCastle2023Scene:PlayerOneFirework()
	local var_17_0 = self.fireworksList[math.random(#self.fireworksList)]

	table.removebyvalue(self.fireworksList, var_17_0)

	local var_17_1 = USCastle2023Scene.EffectName[var_17_0]
	local var_17_2 = self.fireworksTF:Find(USCastle2023Scene.EffectName[var_17_0])
	local var_17_3 = math.random(#USCastle2023Scene.SFX_LIST)

	if var_17_2 then
		setLocalPosition(var_17_2, self:GetFireworkPos())
		setActive(var_17_2, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(USCastle2023Scene.SFX_LIST[var_17_3])
		Timer.New(function()
			if self.fireworksList then
				setActive(var_17_2, false)
				table.insert(self.fireworksList, var_17_0)
			end

			return
		end, USCastle2023Scene.EffectRecycleTime, 1):Start()
	else
		self.loader:GetPrefab("ui/" .. USCastle2023Scene.EffectName[var_17_0], "", function(arg_19_0)
			pg.ViewUtils.SetSortingOrder(arg_19_0, 1)

			arg_19_0.name = var_17_1

			setParent(arg_19_0, self.fireworksTF)
			setLocalPosition(arg_19_0, self:GetFireworkPos())
			setActive(arg_19_0, true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(USCastle2023Scene.SFX_LIST[var_17_3])
			Timer.New(function()
				if self.fireworksList then
					setActive(arg_19_0, false)
					table.insert(self.fireworksList, var_17_0)
				end

				return
			end, USCastle2023Scene.EffectRecycleTime, 1):Start()

			return
		end)
	end

	return
end

function USCastle2023Scene:GetFireworkPos()
	local var_21_0 = Vector2(0, 0)

	if self.lastPos then
		local var_21_1 = Vector2(self.lastPos.x, self.lastPos.y)
		local var_21_2 = math.abs(var_21_1.x - self.lastPos.x)
		local var_21_3 = math.abs(var_21_1.y - self.lastPos.y)

		while var_21_2 < USCastle2023Scene.FireworkRange.x / 2 and var_21_3 < USCastle2023Scene.FireworkRange.y or var_21_3 < USCastle2023Scene.FireworkRange.y / 2 and var_21_2 < USCastle2023Scene.FireworkRange.x do
			var_21_1.x = math.random(USCastle2023Scene.EffectPosLimit.limitX[1], USCastle2023Scene.EffectPosLimit.limitX[2])
			var_21_1.y = math.random(USCastle2023Scene.EffectPosLimit.limitY[1], USCastle2023Scene.EffectPosLimit.limitY[2])
			var_21_2 = math.abs(var_21_1.x - self.lastPos.x)
			var_21_3 = math.abs(var_21_1.y - self.lastPos.y)
		end

		var_21_0 = var_21_1
	else
		var_21_0.x = math.random(USCastle2023Scene.EffectPosLimit.limitX[1], USCastle2023Scene.EffectPosLimit.limitX[2])
		var_21_0.y = math.random(USCastle2023Scene.EffectPosLimit.limitY[1], USCastle2023Scene.EffectPosLimit.limitY[2])
	end

	self.lastPos = var_21_0

	return var_21_0
end

function USCastle2023Scene:StopPlayFireworks()
	if self.fireworksTimer then
		self.fireworksTimer:Stop()

		self.fireworksTimer = nil
	end

	return
end

return USCastle2023Scene
