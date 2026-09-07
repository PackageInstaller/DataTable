local CurrentWorldBossDetailPage = class("CurrentWorldBossDetailPage", import(".BaseWorldBossDetailPage"))

function CurrentWorldBossDetailPage:getUIName()
	return "CurrentWorldBossDetailUI"
end

function CurrentWorldBossDetailPage:OnLoaded()
	CurrentWorldBossDetailPage.super.OnLoaded(self)

	self.listBtn = self._tf:Find("list_btn")
	self.metaWorldbossBtn = MetaWorldbossBtn.New(self._tf:Find("archives_btn"), self.event)
	self.helpWindow = WorldBossHelpPage.New(self._tf, self.event)
	self.currProgressTr = self._tf:Find("progress")
	self.currProgressTxt = self._tf:Find("progress/value"):GetComponent(typeof(Text))
	self.ptBtn = WorldbossPtBtn.New(self._tf:Find("point"))

	return
end

function CurrentWorldBossDetailPage:OnInit()
	CurrentWorldBossDetailPage.super.OnInit(self)
	onButton(self, self.listBtn, function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(self, self.currProgressTr, function()
		local var_5_0 = WorldBossConst.GetCurrBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_5_0.name,
			content = var_5_0.display,
			iconPath = var_5_0.icon,
			frame = var_5_0.rarity
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("point/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_boss_help_meta.tip
		})

		return
	end, SFX_PANEL)

	return
end

function CurrentWorldBossDetailPage:OnUpdateRes()
	local var_7_0, var_7_1, var_7_2 = WorldBossConst.GetCurrBossConsume()

	self.currProgressTxt.text = WorldBossConst.GetCurrBossItemProgress() .. "/" .. var_7_2

	return
end

function CurrentWorldBossDetailPage:OnUpdatePt()
	if self.ptBtn then
		self.ptBtn:Update()
	end

	return
end

function CurrentWorldBossDetailPage:OnRescue()
	if self.helpWindow then
		self.helpWindow:ExecuteAction("Update", self.boss)
	end

	return
end

function CurrentWorldBossDetailPage:Show()
	CurrentWorldBossDetailPage.super.Show(self)
	self:TryPlayGuide()

	return
end

function CurrentWorldBossDetailPage:TryPlayGuide()
	if pg.NewStoryMgr.GetInstance():IsPlayed("WorldG191") then
		WorldGuider.GetInstance():PlayGuide("WorldG191_1")
	end

	if pg.NewStoryMgr.GetInstance():IsPlayed("WorldG191_1") and not CurrentWorldBossDetailPage.formDock then
		WorldGuider.GetInstance():PlayGuide("WorldG192")
	end

	CurrentWorldBossDetailPage.formDock = false

	return
end

function CurrentWorldBossDetailPage:OnDestroy()
	CurrentWorldBossDetailPage.super.OnDestroy(self)

	if self.helpWindow then
		self.helpWindow:Destroy()

		self.helpWindow = nil
	end

	if self.metaWorldbossBtn then
		self.metaWorldbossBtn:Dispose()

		self.metaWorldbossBtn = nil
	end

	if self.ptBtn then
		self.ptBtn:Dispose()

		self.ptBtn = nil
	end

	return
end

return CurrentWorldBossDetailPage
