ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local BattleBossCharacter = class("BattleBossCharacter", ys.Battle.BattleEnemyCharacter)

ys.Battle.BattleBossCharacter = BattleBossCharacter
BattleBossCharacter.__name = "BattleBossCharacter"

function BattleBossCharacter:Ctor()
	BattleBossCharacter.super.Ctor(self)

	return
end

function BattleBossCharacter:Dispose()
	if not self._chargeTimer.paused then
		self._chargeTimer:Stop()
	end

	if self._castClock then
		self._castClock:Dispose()

		self._castClock = nil
	end

	if self._aimBiarBar then
		self._factory:GetHPBarPool():DestroyObj((self._aimBiarBar:GetGO()))
		self._aimBiarBar:Dispose()

		self._aimBiarBar = nil
	end

	LeanTween.cancel(self._HPBar)
	BattleBossCharacter.super.Dispose(self)

	return
end

function BattleBossCharacter:Update()
	BattleBossCharacter.super.Update(self)
	self:UpdateCastClockPosition()

	if self._armor then
		self:UpdateCastClock()
	end

	self:UpdateBarrierClockPosition()

	if self._barrier then
		self:updateBarrierClock()
	end

	return
end

function BattleBossCharacter:UpdateVigilantBarPosition()
	self._vigilantBar:UpdateVigilantBarPosition(self._referenceVector + self._hpBarOffset)

	return
end

function BattleBossCharacter:RegisterWeaponListener(arg_5_1)
	BattleBossCharacter.super.RegisterWeaponListener(self, arg_5_1)
	arg_5_1:RegisterEventListener(self, var_0_1.WEAPON_INTERRUPT, self.onWeaponInterrupted)

	return
end

function BattleBossCharacter:UnregisterWeaponListener(arg_6_1)
	BattleBossCharacter.super.UnregisterWeaponListener(self, arg_6_1)
	arg_6_1:UnregisterEventListener(self, var_0_1.WEAPON_INTERRUPT)

	return
end

function BattleBossCharacter:AddHPBar(arg_7_1, arg_7_2)
	self._HPBar = arg_7_1
	self._HPBarTf = arg_7_1.transform

	arg_7_1:SetActive(true)
	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_HP, self.OnUpdateHP)

	self._HPBarCountText = self._HPBarTf:Find("HPBarCount"):GetComponent(typeof(Text))
	self._activeVernier = arg_7_2

	self:SetTemplateInfo()
	self:initBarComponent()
	self:SetHPBarCountText(self._HPBarTotalCount)

	self._cacheHP = self._unitData:GetMaxHP()

	self:UpdateHpBar()
	self:initBarrierBar()

	return
end

function BattleBossCharacter:SetTemplateInfo()
	local var_8_0 = self._unitData:GetTemplate()

	if var_8_0 then
		self._HPBarTf:Find("BossNameBG/BossName"):GetComponent(typeof(Text)).text = var_8_0.name
	end

	self._HPBarTf:Find("BossNameBG/BossLv"):GetComponent(typeof(Text)).text = "Lv." .. self._unitData:GetLevel()

	setImageSprite(self._HPBarTf:Find("BossIcon/typeIcon/icon"), GetSpriteFromAtlas("shiptype", shipType2Battleprint(pg.enemy_data_by_type[var_8_0.type].type)), true)
	setImageSprite(findTF(self._HPBarTf, "BossIcon/icon"), (var_0_0.Battle.BattleResourceManager.GetInstance():GetCharacterSquareIcon(self._bossIcon)))

	self._armorBar = self._HPBarTf:Find("ArmorBar")
	self._armorProgress = self._HPBarTf:Find("ArmorBar/armorProgress"):GetComponent(typeof(Image))

	SetActive(self._armorBar, false)

	self._barrierBar = self._HPBarTf:Find("ShieldBar")
	self._barrierProgress = self._barrierBar:Find("shieldProgress"):GetComponent(typeof(Image))

	SetActive(self._barrierBar, false)

	return
end

function BattleBossCharacter:SetBossData(arg_9_1)
	self._bossBarInfoList = {}
	self._HPBarTotalCount = arg_9_1.hpBarNum or 1
	self._hideBarNum = arg_9_1.hideBarNum
	self._bossIcon = self:GetUnitData():GetTemplate().icon
	self._bossIndex = arg_9_1.bossCount

	return
end

function BattleBossCharacter:GetBossIndex()
	return self._bossIndex
end

function BattleBossCharacter:initBarComponent()
	self._stepHP = self:GetUnitData():GetMaxHP() / self._HPBarTotalCount
	self._resTotalCount = 5
	self._bossBarInfoList = {}

	while 1 <= self._resTotalCount do
		local var_11_0 = {}
		local var_11_1 = self._HPBarTf:Find("bloodBarContainer/hp_" .. 1)
		local var_11_2 = self._HPBarTf:Find(("bloodBarContainer/hp_" .. 1) .. "_delta")

		var_11_0.progressImage = var_11_1:GetComponent(typeof(Image))
		var_11_0.deltaImage = var_11_2:GetComponent(typeof(Image))
		var_11_0.progressTF = var_11_1.transform
		var_11_0.deltaTF = var_11_2.transform
		var_11_0.progressImage.fillAmount = 1
		var_11_0.deltaImage.fillAmount = 1
		self._bossBarInfoList[1] = var_11_0
	end

	self._topBarIndex = self._HPBarTf.childCount - 1
	self._currentFmod = math.fmod(self._HPBarTotalCount, self._resTotalCount)

	if self._currentFmod == 0 then
		self._currentFmod = self._resTotalCount
	end

	if self._HPBarTotalCount < 5 then
		local var_11_4 = self._resTotalCount

		while var_11_4 > self._HPBarTotalCount do
			SetActive(self._HPBarTf:Find("bloodBarContainer/hp_" .. var_11_4), false)
			SetActive(self._HPBarTf:Find(("bloodBarContainer/hp_" .. var_11_4) .. "_delta"), false)

			var_11_4 = var_11_4 - 1
		end
	else
		local var_11_5 = self._resTotalCount

		while var_11_5 > self._currentFmod do
			self._HPBarTf:Find("bloodBarContainer/hp_" .. var_11_5).transform:SetSiblingIndex(0)
			self._HPBarTf:Find(("bloodBarContainer/hp_" .. var_11_5) .. "_delta").transform:SetSiblingIndex(0)

			var_11_5 = var_11_5 - 1
		end
	end

	if self._activeVernier then
		self._vernier = self._HPBarTf:Find("vernier/tag")

		SetActive(self._HPBarTf:Find("vernier"), self._activeVernier)
	end

	self._chargeTimer = Timer.New(function()
		self._currentTween = self:generateTween()

		return
	end, 1)

	return
end

function BattleBossCharacter:UpdateHpBar()
	local var_13_0 = self._unitData:GetCurrentHP()

	if self._cacheHP == var_13_0 then
		return
	end

	if not self._chargeTimer.paused then
		self._chargeTimer:Stop()
		self._chargeTimer:Stop()
		self._chargeTimer:Reset()
	end

	local var_13_1, var_13_2, var_13_3 = self:GetCurrentFmod()

	self:SortBar(var_13_1, var_13_3)

	self._currentFmod = var_13_1
	self._currentDivision = var_13_3

	if var_13_0 < self._cacheHP then
		if self._currentDivision ~= var_13_3 then
			LeanTween.cancel(self._HPBar)
		end

		self._chargeTimer:Start()
	end

	self._bossBarInfoList[var_13_1].progressImage.fillAmount = var_13_2

	if self._activeVernier then
		self._vernier.anchorMin = Vector2(var_13_2, 0.5)
		self._vernier.anchorMax = Vector2(var_13_2, 0.5)
	end

	self:SetHPBarCountText(var_13_3)

	self._cacheHP = var_13_0

	return
end

function BattleBossCharacter:generateTween()
	local var_14_0 = self._bossBarInfoList[self._currentFmod].deltaImage

	duration = duration or 0.7

	return (LeanTween.value(go(self._HPBar), self._bossBarInfoList[self._currentFmod].deltaImage.fillAmount, self._bossBarInfoList[self._currentFmod].progressImage.fillAmount, 0.7):setOnUpdate(System.Action_float(function(arg_15_0)
		var_14_0.fillAmount = arg_15_0

		return
	end)))
end

function BattleBossCharacter:GetCurrentFmod()
	local var_16_0, var_16_1 = math.modf(self._unitData:GetCurrentHP() / self._stepHP)
	local var_16_2 = math.fmod(var_16_0 + 1, self._resTotalCount)

	if var_16_2 == 0 then
		var_16_2 = 5
	end

	return var_16_2, var_16_1, var_16_0 + 1
end

function BattleBossCharacter:SortBar(arg_17_1, arg_17_2)
	if arg_17_1 == self._currentFmod then
		return
	elseif arg_17_1 > self._currentFmod then
		local var_17_0 = self._currentFmod

		self._bossBarInfoList[self._currentFmod].progressImage.fillAmount = 1
		self._bossBarInfoList[var_17_0].deltaImage.fillAmount = 1

		while var_17_0 < arg_17_1 do
			var_17_0 = var_17_0 + 1

			self._bossBarInfoList[var_17_0].deltaTF:SetSiblingIndex(self._topBarIndex)
			self._bossBarInfoList[var_17_0].progressTF:SetSiblingIndex(self._topBarIndex)
			SetActive(self._bossBarInfoList[var_17_0].progressImage, true)
			SetActive(self._bossBarInfoList[var_17_0].deltaImage, true)
		end
	elseif arg_17_1 < self._currentFmod then
		local var_17_1 = self._currentFmod

		while arg_17_1 < var_17_1 do
			self._bossBarInfoList[var_17_1].progressImage.fillAmount = 1
			self._bossBarInfoList[var_17_1].deltaImage.fillAmount = 1

			self._bossBarInfoList[var_17_1].progressTF:SetSiblingIndex(0)
			self._bossBarInfoList[var_17_1].deltaTF:SetSiblingIndex(0)

			if arg_17_2 < self._resTotalCount then
				SetActive(self._bossBarInfoList[var_17_1].progressImage, false)
				SetActive(self._bossBarInfoList[var_17_1].deltaImage, false)
			end

			var_17_1 = var_17_1 - 1
		end
	end

	return
end

function BattleBossCharacter:SetHPBarCountText(arg_18_1)
	self._HPBarCountText.text = self._hideBarNum and "X??" or "X " .. arg_18_1

	return
end

function BattleBossCharacter:UpdateHPBarPosition()
	if self._normalHPTF and not self._hideHP then
		self._hpBarPos:Copy(self._referenceVector):Add(self._hpBarOffset)

		self._normalHPTF.position = self._hpBarPos
	end

	return
end

function BattleBossCharacter:onWeaponPreCast(arg_20_1)
	BattleBossCharacter.super.onWeaponPreCast(self, arg_20_1)
	self:initArmorBar(arg_20_1.Data.armor)

	if arg_20_1.Data.armor and arg_20_1.Data.armor ~= 0 then
		self:initCastClock(arg_20_1.Data.time, arg_20_1.Dispatcher)
	end

	return
end

function BattleBossCharacter:onWeaponPrecastFinish(arg_21_1)
	BattleBossCharacter.super.onWeaponPrecastFinish(self, arg_21_1)

	if self._castClock:GetCastingWeapon() == arg_21_1.Dispatcher and arg_21_1.Data.armor and arg_21_1.Data.armor ~= 0 then
		if self._armor <= 0 then
			self._castClock:Interrupt(true)
		else
			self._castClock:Interrupt(false)
		end

		self._armor = nil

		SetActive(self._armorBar, false)
	end

	return
end

function BattleBossCharacter:onWeaponInterrupted(arg_22_1)
	self._unitData:StateChange(var_0_0.Battle.UnitState.STATE_INTERRUPT)

	return
end

function BattleBossCharacter:initArmorBar(arg_23_1)
	if arg_23_1 and arg_23_1 ~= 0 then
		self._armor = arg_23_1
		self._totalArmor = arg_23_1

		self:updateWeaponArmor()
		SetActive(self._armorBar, true)
	end

	return
end

function BattleBossCharacter:OnUpdateHP(arg_24_1)
	if self._barrier and arg_24_1.Data.preShieldHP < 0 then
		self._barrier = self._barrier + arg_24_1.Data.preShieldHP

		self:updateBarrierBar()
	end

	BattleBossCharacter.super.OnUpdateHP(self, arg_24_1)

	if self._armor and arg_24_1.Data.dHP < 0 then
		self._armor = self._armor + arg_24_1.Data.dHP

		self:updateWeaponArmor()
	end

	return
end

function BattleBossCharacter:updateWeaponArmor()
	self._armorProgress.fillAmount = self._armor / self._totalArmor

	return
end

function BattleBossCharacter:initCastClock(arg_26_1, arg_26_2)
	self._castClock:Casting(arg_26_1, arg_26_2)

	self._castFinishTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_26_1
	self._castDuration = arg_26_1

	return
end

function BattleBossCharacter:UpdateCastClock()
	self._castClock:UpdateCastClock()

	return
end

function BattleBossCharacter:updateComponentDiveInvisible()
	BattleBossCharacter.super.updateComponentDiveInvisible(self)
	SetActive(self._HPBarTf, true)

	return
end

function BattleBossCharacter:updateComponentVisible()
	BattleBossCharacter.super.updateComponentVisible(self)
	SetActive(self._HPBarTf, true)

	return
end

function BattleBossCharacter:initBarrierBar()
	self._unitData:RegisterEventListener(self, var_0_1.BARRIER_STATE_CHANGE, self.onBarrierStateChange)

	return
end

function BattleBossCharacter:onBarrierStateChange(arg_31_1)
	local var_31_0 = arg_31_1.Data.barrierDurability
	local var_31_1 = arg_31_1.Data.barrierDuration

	SetActive(self._barrierBar, arg_31_1.Data.barrierDurability > 0)

	if var_31_0 > 0 then
		self._totalBarrier = var_31_0
		self._barrier = var_31_0

		self:initBarrierClock(var_31_1)
		self:updateBarrierBar()
		self:updateBarrierClock()
	else
		self._barrier = nil
		self._totalBarrier = nil

		self._barrierClock:Interrupt()
	end

	return
end

function BattleBossCharacter:updateBarrierBar()
	self._barrierProgress.fillAmount = self._barrier / self._totalBarrier

	return
end

function BattleBossCharacter:updateBarrierClock()
	self._barrierClock:UpdateBarrierClockProgress()

	return
end

function BattleBossCharacter:initBarrierClock(arg_34_1)
	self._barrierClock:Shielding(arg_34_1)

	return
end

function BattleBossCharacter:AddAimBiasBar(arg_35_1)
	self._normalHPTF = arg_35_1
	self._aimBiarBarTF = arg_35_1:Find("biasBar")
	self._aimBiarBar = var_0_0.Battle.BattleAimbiasBar.New(self._aimBiarBarTF)

	self._aimBiarBar:ConfigAimBias(self._unitData:GetAimBias())
	self._aimBiarBar:UpdateAimBiasProgress()

	return
end

function BattleBossCharacter:AddModel(arg_36_1)
	BattleBossCharacter.super.AddModel(self, arg_36_1)
	self:UpdatePosition()

	return
end

return
