local ArchivesWorldBossDetailPage = class("ArchivesWorldBossDetailPage", import(".BaseWorldBossDetailPage"))

function ArchivesWorldBossDetailPage:getUIName()
	return "ArchivesWorldBossDetailUI"
end

function ArchivesWorldBossDetailPage:OnAutoBattleResult(arg_2_1)
	self.autoBattleResultMsg:ExecuteAction("Show", {
		battleCnt = arg_2_1.cnt,
		damage = arg_2_1.damage,
		oil = arg_2_1.oil
	})
	self:Flush()
	self:UpdatePainting(self.groupId)

	return
end

function ArchivesWorldBossDetailPage:OnAutoBattleStart()
	self:Flush()
	self:UpdatePainting(self.groupId)

	return
end

function ArchivesWorldBossDetailPage:GetResSuffix()
	return "_archives"
end

function ArchivesWorldBossDetailPage:OnLoaded()
	ArchivesWorldBossDetailPage.super.OnLoaded(self)

	self.currProgressTr = self._tf:Find("progress")
	self.currProgressTxt = self._tf:Find("progress/value"):GetComponent(typeof(Text))
	self.listBtn = self._tf:Find("list_btn")
	self.archivesWorldbossBtn = ArchivesWorldbossBtn.New(self._tf:Find("archives_btn"), self.event)
	self.autoBattleBtn = self._tf:Find("btns/auto_btn")
	self.autoBattleTimeTxt = self.autoBattleBtn:Find("Text"):GetComponent(typeof(Text))
	self.battleMask = self._tf:Find("battle_mask")
	self.helpWindow = ArchivesWorldBossHelpPage.New(self._parentTf.parent, self.event)
	self.autoBattleTip = ArchivesWorldBossAutoBattleTipPage.New(self._parentTf.parent, self.event)
	self.autoBattleMsg = ArchivesWorldBossAutoBattleMsgbox.New(self._parentTf.parent, self.event)
	self.autoBattleResultMsg = ArchivesWorldBossAutoBattleResultMsg.New(self._parentTf.parent, self.event)

	return
end

function ArchivesWorldBossDetailPage:OnInit()
	ArchivesWorldBossDetailPage.super.OnInit(self)
	onButton(self, self.listBtn, function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_CHALLENGE)

		return
	end, SFX_PANEL)
	onButton(self, self.currProgressTr, function()
		local var_8_0 = WorldBossConst.GetAchieveBossItemInfo()

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
	onButton(self, self._tf:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.world_archives_boss_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleMask, function()
		triggerButton(self.autoBattleBtn)

		return
	end, SFX_PANEL)
	onButton(self, self.autoBattleBtn, function()
		if pg.TimeMgr.GetInstance():GetServerTime() + WorldBossConst.GetArchivesBossAutoBattleSecond() > self.boss:GetExpiredTime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_no_time_to_auto_battle"))

			return
		end

		local var_11_0 = WorldBossConst.GetAutoBattleState(self.boss)

		if var_11_0 == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
			self.autoBattleMsg:ExecuteAction("Show", {
				onContent = function()
					local var_12_0 = WorldBossConst.GetAutoBattleLeftTime()

					if var_12_0 <= 0 then
						return nil
					end

					return (pg.TimeMgr.GetInstance():DescCDTime(var_12_0))
				end,
				title = i18n("world_boss_archives_stop_auto_battle_title"),
				yesText = i18n("world_boss_archives_continue_auto_battle"),
				noText = i18n("world_boss_archives_stop_auto_battle"),
				onNo = function()
					self:emit(WorldBossMediator.ON_ARCHIVES_BOSS_STOP_AUTO_BATTLE, self.boss.id)

					return
				end
			})
		elseif var_11_0 == WorldBossConst.AUTO_BATTLE_STATE_HIDE then
			pg.TipsMgr.GetInstance():ShowTip(i18n("world_word_expired"))
		elseif var_11_0 == WorldBossConst.AUTO_BATTLE_STATE_LOCK then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_auto_battle_unopen"))
		else
			local var_11_1 = {}

			var_11_1.highestDamage = WorldBossConst.GetHighestDamage()
			var_11_1.autoBattleCnt = WorldBossConst.GetAutoBattleCnt()
			var_11_1.oil = WorldBossConst.GetAutoBattleOilConsume()
			var_11_1.time = WorldBossConst.GetArchivesBossAutoBattleMinute()

			function var_11_1.onYes()
				self:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE, self.boss.id)

				return
			end

			self.autoBattleTip:ExecuteAction("Show", var_11_1)
		end

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldBossDetailPage:OnStart()
	if nowWorld():GetBossProxy():InAutoBattle() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_archives_need_stop_auto_battle"))

		return
	end

	ArchivesWorldBossDetailPage.super.OnStart(self)

	return
end

function ArchivesWorldBossDetailPage:OnRescue()
	if self.helpWindow then
		self.helpWindow:ExecuteAction("Update", self.boss)
	end

	return
end

function ArchivesWorldBossDetailPage:OnUpdateRes()
	if not self.currProgressTxt then
		return
	end

	local var_17_0, var_17_1, var_17_2 = WorldBossConst.GetAchieveBossConsume()

	self.currProgressTxt.text = WorldBossConst.GetAchieveBossItemProgress() .. "/" .. var_17_2

	return
end

function ArchivesWorldBossDetailPage:UpdateMainInfo()
	ArchivesWorldBossDetailPage.super.UpdateMainInfo(self)

	self.levelTxt.text = self.boss:GetLevel()
	self.hpTxt.text = self.boss:GetHP() .. "/<color=#CF4E24>" .. self.boss:GetMaxHp() .. "</color>"

	return
end

function ArchivesWorldBossDetailPage:OnPaintingLoad()
	local var_19_0 = self.painting:Find("fitter")

	if var_19_0.childCount > 0 then
		local var_19_1 = WorldBossConst.GetAutoBattleState(self.boss) == WorldBossConst.AUTO_BATTLE_STATE_STARTING
		local var_19_2 = GetOrAddComponent(var_19_0:GetChild(0), typeof(Gradient))

		if var_19_2 then
			var_19_2.enabled = var_19_1
		end
	end

	return
end

function ArchivesWorldBossDetailPage:Show()
	ArchivesWorldBossDetailPage.super.Show(self)
	self:Flush()

	return
end

function ArchivesWorldBossDetailPage:OnBossExpired()
	if WorldBossConst.GetAutoBattleState(self.boss) == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
		if WorldBossConst.GetAutoBattleLeftTime() <= 0 then
			self:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, self.boss.id)
		end

		return
	end

	self:emit(WorldBossMediator.ON_SELF_BOSS_OVERTIME)

	return
end

function ArchivesWorldBossDetailPage:Flush()
	self.archivesWorldbossBtn:Flush()

	local var_22_0 = WorldBossConst.GetAutoBattleState(self.boss)
	local var_22_1 = self.autoBattleBtn:GetComponent(typeof(Image))

	self:RemoveBattleTimer()
	setActive(self.battleMask, false)

	self.autoBattleTimeTxt.text = ""

	local var_22_2

	if var_22_0 == WorldBossConst.AUTO_BATTLE_STATE_LOCK then
		var_22_2 = "auto_03"
	elseif var_22_0 == WorldBossConst.AUTO_BATTLE_STATE_STARTING then
		var_22_2 = "auto_02"

		self:AddBattleTimer()
		setActive(self.battleMask, true)
	else
		var_22_2 = "auto_01"
	end

	GetSpriteFromAtlasAsync("ui/WorldBossUI_atlas", var_22_2, function(arg_23_0)
		var_22_1.sprite = arg_23_0

		return
	end)
	setActive(self.autoBattleBtn, var_22_0 ~= WorldBossConst.AUTO_BATTLE_STATE_HIDE)
	setGray(self.startBtn, WorldBossConst.AUTO_BATTLE_STATE_STARTING == var_22_0, true)

	return
end

function ArchivesWorldBossDetailPage:AddBattleTimer()
	if self.boss:IsExpired() then
		return
	end

	if WorldBossConst.GetAutoBattleLeftTime() <= 0 then
		self:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, self.boss.id)

		return
	end

	self.timer = Timer.New(function()
		local var_25_0 = WorldBossConst.GetAutoBattleLeftTime()

		if var_25_0 < 0 then
			self:RemoveBattleTimer()

			self.autoBattleTimeTxt.text = ""
		end

		if var_25_0 < 0 and self.boss then
			self:emit(WorldBossMediator.ON_ARCHIVES_BOSS_AUTO_BATTLE_TIMEOVER, self.boss.id)
		else
			self.autoBattleTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_25_0)
		end

		return
	end, 1, -1)

	self.timer.func()
	self.timer:Start()

	return
end

function ArchivesWorldBossDetailPage:RemoveBattleTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ArchivesWorldBossDetailPage:Hide()
	ArchivesWorldBossDetailPage.super.Hide(self)
	self:RemoveBattleTimer()

	return
end

function ArchivesWorldBossDetailPage:OnDestroy()
	local var_28_0 = self.painting:Find("fitter"):GetChild(0)

	if var_28_0 and var_28_0:GetComponent(typeof(Gradient)) then
		var_28_0:GetComponent(typeof(Gradient)).enabled = false
	end

	ArchivesWorldBossDetailPage.super.OnDestroy(self)

	if self.helpWindow then
		self.helpWindow:Destroy()

		self.helpWindow = nil
	end

	if self.autoBattleTip then
		self.autoBattleTip:Destroy()

		self.autoBattleTip = nil
	end

	if self.autoBattleMsg then
		self.autoBattleMsg:Destroy()

		self.autoBattleMsg = nil
	end

	if self.archivesWorldbossBtn then
		self.archivesWorldbossBtn:Dispose()

		self.archivesWorldbossBtn = nil
	end

	if self.autoBattleResultMsg then
		self.autoBattleResultMsg:Destroy()

		self.autoBattleResultMsg = nil
	end

	return
end

return ArchivesWorldBossDetailPage
