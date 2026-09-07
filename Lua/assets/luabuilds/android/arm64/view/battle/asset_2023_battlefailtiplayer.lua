local BattleFailTipLayer = class("BattleFailTipLayer", import("..base.BaseUI"))

BattleFailTipLayer.PowerUpBtn = {
	EquipLevelUp = 2,
	SkillLevelUp = 3,
	ShipBreakUp = 4,
	ShipLevelUp = 1
}

function BattleFailTipLayer:getUIName()
	return "BattleFailTipUI"
end

function BattleFailTipLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function BattleFailTipLayer:initData()
	self.battleSystem = self.contextData.battleSystem

	return
end

function BattleFailTipLayer:findUI()
	self.powerUpTipPanel = self._tf:Find("Main")
	self.shipLevelUpBtn = self.powerUpTipPanel:Find("ShipLevelUpBtn")
	self.equipLevelUpBtn = self.powerUpTipPanel:Find("EquipLevelUpBtn")
	self.skillLevelUpBtn = self.powerUpTipPanel:Find("SkillLevelUpBtn")
	self.shipBreakUpBtn = self.powerUpTipPanel:Find("ShipBreakUpBtn")
	self.closeBtn = self.powerUpTipPanel:Find("CloseBtn")

	return
end

function BattleFailTipLayer:addListener()
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.shipLevelUpBtn, function()
		if self.battleSystem == SYSTEM_SCENARIO then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("fightfail_up"),
				onYes = function()
					if self.contextData.battleSystem == SYSTEM_SCENARIO then
						self.lastClickBtn = BattleFailTipLayer.PowerUpBtn.ShipLevelUp

						self:emit(BattleFailTipMediator.CHAPTER_RETREAT)
					else
						self:emit(BattleFailTipMediator.GO_HIGEST_CHAPTER)
					end

					return
				end
			})
		else
			self:emit(BattleFailTipMediator.GO_HIGEST_CHAPTER)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.equipLevelUpBtn, function()
		if self.battleSystem == SYSTEM_SCENARIO then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("fightfail_equip"),
				onYes = function()
					if self.contextData.battleSystem == SYSTEM_SCENARIO then
						self.lastClickBtn = BattleFailTipLayer.PowerUpBtn.EquipLevelUp

						self:emit(BattleFailTipMediator.CHAPTER_RETREAT)
					else
						self:emit(BattleFailTipMediator.GO_DOCKYARD_EQUIP)
					end

					return
				end
			})
		else
			self:emit(BattleFailTipMediator.GO_DOCKYARD_EQUIP)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.skillLevelUpBtn, function()
		self:emit(BattleFailTipMediator.GO_NAVALTACTICS)

		return
	end, SFX_PANEL)
	onButton(self, self.shipBreakUpBtn, function()
		if self.battleSystem == SYSTEM_SCENARIO then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("fight_strengthen"),
				onYes = function()
					if self.contextData.battleSystem == SYSTEM_SCENARIO then
						self.lastClickBtn = BattleFailTipLayer.PowerUpBtn.ShipBreakUp

						self:emit(BattleFailTipMediator.CHAPTER_RETREAT)
					else
						self:emit(BattleFailTipMediator.GO_DOCKYARD_SHIP)
					end

					return
				end
			})
		else
			self:emit(BattleFailTipMediator.GO_DOCKYARD_SHIP)
		end

		return
	end, SFX_PANEL)

	return
end

function BattleFailTipLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:aniBeforeEnter()

	return
end

function BattleFailTipLayer:onBackPressed()
	self:closeView()

	return
end

function BattleFailTipLayer:willExit()
	LeanTween.cancel(go(self._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function BattleFailTipLayer:aniBeforeEnter()
	local var_17_0 = GetComponent(self._tf, "CanvasGroup")

	LeanTween.value(go(self._tf), 0, 1, 0.6):setOnUpdate(System.Action_float(function(arg_18_0)
		var_17_0.alpha = arg_18_0

		return
	end))

	return
end

return BattleFailTipLayer
