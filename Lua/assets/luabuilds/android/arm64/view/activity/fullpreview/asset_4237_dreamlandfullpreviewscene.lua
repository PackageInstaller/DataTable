local DreamlandFullPreviewScene = class("DreamlandFullPreviewScene", import(".FullPreviewSceneTemplate"))

DreamlandFullPreviewScene.MINIGAME_ID = 66

function DreamlandFullPreviewScene:getUIName()
	return "DreamlandFullPreviewUI"
end

function DreamlandFullPreviewScene:init()
	local var_2_0 = self._tf:Find("btns")

	self.dreamlandBtn = var_2_0:Find("dreamland")
	self.skinBtn = var_2_0:Find("skin")
	self.buildBtn = var_2_0:Find("build")
	self.battleBtn = var_2_0:Find("battle")
	self.minigameBtn = var_2_0:Find("minigame")

	setText(self._tf:Find("top/info/Text"), i18n("dreamland_main_desc"))

	self.preActId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_DREAMLAND):getConfig("config_client").preActID

	local var_2_1 = underscore.flatten(pg.activity_template[self.preActId].config_data)

	self.taskId = var_2_1[#var_2_1]

	return
end

function DreamlandFullPreviewScene:didEnter()
	onButton(self, self._tf:Find("top/back"), function()
		self:emit(DreamlandFullPreviewScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/home"), function()
		self:emit(DreamlandFullPreviewScene.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.dreamland_main_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.dreamlandBtn, function()
		if self.isFinishPre then
			self:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.DREAMLAND)
		else
			self:emit(FullPreviewMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
				id = self.preActId
			})
		end

		return
	end, SFX_PANEL)
	self:BindSkinShop(self.skinBtn)
	self:BindBuildShip(self.buildBtn)
	self:BindBattle(self.battleBtn)
	self:BindMiniGame(self.minigameBtn, DreamlandFullPreviewScene.MINIGAME_ID)
	self:UpdateView()

	return
end

function DreamlandFullPreviewScene:IsFinishPreAct()
	local var_8_0 = getProxy(TaskProxy)
	local var_8_1 = var_8_0:getTaskById(self.taskId) or var_8_0:getFinishTaskById(self.taskId)

	return var_8_1 and var_8_1:getTaskStatus() == 2
end

function DreamlandFullPreviewScene:UpdateView()
	setActive(self.minigameBtn:Find("tip"), DreamlandFullPreviewScene.MiniGameTip())
	setActive(self.dreamlandBtn:Find("dreamland/tip"), DreamlandFullPreviewScene.DreamlandTip())

	self.isFinishPre = self:IsFinishPreAct()

	setActive(self.dreamlandBtn:Find("dreamland"), self.isFinishPre)
	setActive(self.dreamlandBtn:Find("pre_act"), not self.isFinishPre)
	setActive(self.dreamlandBtn:Find("pre_act/tip"), DreamlandFullPreviewScene.ActivityTip((getProxy(ActivityProxy):getActivityById(self.preActId))))

	return
end

function DreamlandFullPreviewScene.MiniGameTip()
	return DreamlandFullPreviewScene.IsMiniGameTip(DreamlandFullPreviewScene.MINIGAME_ID)
end

function DreamlandFullPreviewScene.DreamlandTip()
	local var_11_0 = getProxy(ActivityProxy)

	return DreamlandData.New(var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_DREAMLAND), (getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2))).ExistAnyMapOrExploreAward(var_11_0)
end

function DreamlandFullPreviewScene:ActivityTip()
	if not self or self:isEnd() then
		return false
	end

	local var_12_0 = getProxy(TaskProxy)
	local var_12_1 = underscore.flatten(self:getConfig("config_data"))
	local var_12_2 = var_12_0:getTaskById(var_12_1[self.data3]) or var_12_0:getFinishTaskById(var_12_1[self.data3])
	local var_12_3 = math.min(self:getDayIndex(), #var_12_1) - self.data3

	if var_12_2:getTaskStatus() == 1 then
		var_12_3 = var_12_3 + 1
	end

	return var_12_3 > 0
end

function DreamlandFullPreviewScene:IsShowMainTip()
	return DreamlandFullPreviewScene.MiniGameTip() or DreamlandFullPreviewScene.DreamlandTip()
end

return DreamlandFullPreviewScene
