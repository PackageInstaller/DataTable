local CurrentWorldBossEmptyPage = class("CurrentWorldBossEmptyPage", import(".BaseWorldBossEmptyPage"))

function CurrentWorldBossEmptyPage:getUIName()
	return "CurrentWorldBossEmptyUI"
end

function CurrentWorldBossEmptyPage:OnLoaded()
	CurrentWorldBossEmptyPage.super.OnLoaded(self)

	self.timeTxt = self._tf:Find("time/Text"):GetComponent(typeof(Text))

	self:UpdateUseItemStyle(WorldBossConst.GetCurrBossGroup() or "")

	self.simulateBtn = self._tf:Find("simulate_btn")

	return
end

function CurrentWorldBossEmptyPage:OnInit()
	CurrentWorldBossEmptyPage.super.OnInit(self)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_boss_help_meta.tip
		})

		return
	end, SFX_PANEL)
	setActive(self.simulateBtn, true)
	onButton(self, self.simulateBtn, function()
		self:emit(WorldBossMediator.ON_UPDATE_BOSS_INFO, function()
			local var_6_0 = {}

			var_6_0.content = i18n("meta_simulated_btn", nowWorld():GetBossProxy().currentBossLV)

			function var_6_0.onYes()
				self:emit(WorldBossMediator.ON_BATTLE, WorldBossConst.GetCurrBossID(), nil, 1, true)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_6_0)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.progressTr, function()
		local var_8_0 = WorldBossConst.GetCurrBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_8_0.name,
			content = var_8_0.display,
			iconPath = var_8_0.icon,
			frame = var_8_0.rarity
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("list_btn"), function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(self, self.activeBtn, function()
		if WorldBossConst.CanUnlockCurrBoss() then
			self:emit(WorldBossMediator.ON_ACTIVE_BOSS, (WorldBossConst.GetCurrBossID()))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_item_count_noenough"))
		end

		return
	end, SFX_PANEL)

	return
end

function CurrentWorldBossEmptyPage:OnUpdate()
	local var_11_0 = WorldBossConst.GetCurrBossStartTimeAndEndTime()
	local var_11_1 = pg.TimeMgr.GetInstance():inTime(var_11_0)
	local var_11_2 = var_11_1 and WorldBossConst.CanUnlockCurrBoss()

	setActive(self.useItem, var_11_2)
	setActive(self.noItem, not var_11_2)

	self.timeTxt.text = var_11_1 and pg.TimeMgr.GetInstance():DescDateFromConfig(var_11_0[1]) .. "~" .. pg.TimeMgr.GetInstance():DescDateFromConfig(var_11_0[2]) or ""
	self.metaWorldbossBtn = self.metaWorldbossBtn or MetaWorldbossBtn.New(self._tf:Find("archives_btn"), self.event)
	self.ptBtn = self.ptBtn or WorldbossPtBtn.New(self._tf:Find("point"))

	return
end

function CurrentWorldBossEmptyPage:OnUpdateRes()
	if not self.progressTxt then
		return
	end

	local var_12_0, var_12_1, var_12_2 = WorldBossConst.GetCurrBossConsume()

	self.progressTxt.text = WorldBossConst.GetCurrBossItemProgress() .. "/" .. var_12_2

	return
end

function CurrentWorldBossEmptyPage:OnUpdatePt(arg_13_1)
	if self.ptBtn then
		self.ptBtn:Update()
	end

	return
end

function CurrentWorldBossEmptyPage:OnDestroy()
	CurrentWorldBossEmptyPage.super.OnDestroy(self)

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

return CurrentWorldBossEmptyPage
