ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleConfig
local BattlePlayerCharacter = class("BattlePlayerCharacter", ys.Battle.BattleCharacter)

ys.Battle.BattlePlayerCharacter = BattlePlayerCharacter
BattlePlayerCharacter.__name = "BattlePlayerCharacter"

function BattlePlayerCharacter:Ctor()
	BattlePlayerCharacter.super.Ctor(self)

	return
end

function BattlePlayerCharacter:SetUnitData(arg_2_1)
	BattlePlayerCharacter.super.SetUnitData(self, arg_2_1)

	self._chargeWeaponList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1:GetChargeList()) do
		self:InitChargeWeapon(iter_2_1)
	end

	self._torpedoWeaponList = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1:GetTorpedoList()) do
		self:InitTorpedoWeapon(iter_2_3)
	end

	self._airAssistList = {}

	local var_2_0 = arg_2_1:GetAirAssistList()

	if var_2_0 ~= nil then
		for iter_2_4, iter_2_5 in ipairs(var_2_0) do
			self:InitAirAssit(iter_2_5)
		end
	end

	self._weaponSectorList = {}

	return
end

function BattlePlayerCharacter:AddUnitEvent()
	BattlePlayerCharacter.super.AddUnitEvent(self)
	self._unitData:RegisterEventListener(self, var_0_1.WILL_DIE, self.onWillDie)
	self._unitData:RegisterEventListener(self, var_0_1.INIT_COOL_DOWN, self.onInitWeaponCD)
	self._unitData:RegisterEventListener(self, var_0_1.WEAPON_SECTOR, self.onActiveWeaponSector)
	self._unitData:RegisterEventListener(self, var_0_1.CREATE_POINT_AIR_STRIKE, self.onCreatePointAirStrike)

	if self._unitData:GetFleetRangeAAWeapon() then
		self:RegisterWeaponListener(self._unitData:GetFleetRangeAAWeapon())
	end

	return
end

function BattlePlayerCharacter:RemoveUnitEvent()
	if self._unitData:GetFleetRangeAAWeapon() then
		self:UnregisterWeaponListener(self._unitData:GetFleetRangeAAWeapon())
	end

	for iter_4_0, iter_4_1 in ipairs(self._chargeWeaponList) do
		iter_4_1:UnregisterEventListener(self, var_0_1.CHARGE_WEAPON_FINISH)
		self:UnregisterWeaponListener(iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(self._torpedoWeaponList) do
		iter_4_3:UnregisterEventListener(self, var_0_1.TORPEDO_WEAPON_FIRE)
		iter_4_3:UnregisterEventListener(self, var_0_1.TORPEDO_WEAPON_PREPAR)
		iter_4_3:UnregisterEventListener(self, var_0_1.TORPEDO_WEAPON_CANCEL)
		iter_4_3:UnregisterEventListener(self, var_0_1.TORPEDO_WEAPON_READY)
		self:UnregisterWeaponListener(iter_4_3)
	end

	for iter_4_4, iter_4_5 in ipairs(self._airAssistList) do
		iter_4_5:UnregisterEventListener(self, var_0_1.CHARGE_WEAPON_FINISH)
		iter_4_5:UnregisterEventListener(self, var_0_1.FIRE)
	end

	self._unitData:UnregisterEventListener(self, var_0_1.WILL_DIE)
	self._unitData:UnregisterEventListener(self, var_0_1.INIT_COOL_DOWN)
	self._unitData:UnregisterEventListener(self, var_0_1.CREATE_POINT_AIR_STRIKE)
	BattlePlayerCharacter.super.RemoveUnitEvent(self)

	return
end

function BattlePlayerCharacter:Update()
	BattlePlayerCharacter.super.Update(self)
	self:UpdatePosition()
	self:UpdateMatrix()

	if not self._inViewArea or not self._alwaysHideArrow then
		self:UpdateArrowBarPosition()
	end

	if self._unitData:GetOxyState() then
		self:UpdateOxygenBar()
	end

	if self._cloakBar then
		self._cloakBar:UpdateCloakProgress()
		self._hpCloakBar:UpdateCloakProgress()

		if not self._inViewArea or not self._alwaysHideArrow then
			self:UpdateCloakBarPosition()
		end
	end

	return
end

function BattlePlayerCharacter:UpdateArrowBarPosition()
	BattlePlayerCharacter.super.UpdateArrowBarPosition(self)

	local var_6_0 = self._unitData:GetFleetVO():GetLeftBoundDistance()

	if self._arrowCG and var_6_0 then
		self._arrowCG.alpha = var_6_0 < 6 and 0.1 or 1
	end

	if self._unitData:GetGroupID() and table.contains(var_0_2.MIRROR_QICON_SHIP_GROUP, self._unitData:GetGroupID()) then
		setImageSprite(findTF(self._arrowBar, "icon"), (var_0_0.Battle.BattleResourceManager.GetInstance():GetCharacterQIcon(self._arrowVector.x > 0 and self._unitData:GetTemplate().painting .. var_0_2.MIRROR_QICON_KEY or self._unitData:GetTemplate().painting)))
	end

	return
end

function BattlePlayerCharacter:UpdateHpBar()
	BattlePlayerCharacter.super.UpdateHpBar(self)

	if self._unitData.__name == var_0_0.Battle.BattleCardPuzzlePlayerUnit.__name then
		self:UpdateVectorBar()
	end

	return
end

function BattlePlayerCharacter:UpdateOxygenBar()
	self._oxygenSlider.value = self._unitData:GetOxygenProgress()

	return
end

function BattlePlayerCharacter:UpdateVectorBar()
	self._vectorProgress.fillAmount = self._unitData:GetHPRate()

	return
end

function BattlePlayerCharacter:UpdateUIComponentPosition()
	BattlePlayerCharacter.super.UpdateUIComponentPosition(self)

	local var_10_0 = self._unitData:GetBornPosition()

	if var_10_0 then
		if not self._referenceVectorBorn then
			self._referenceVectorBorn = Vector3.New(var_10_0.x, var_10_0.y, var_10_0.z)
		else
			self._referenceVectorBorn:Set(var_10_0.x, var_10_0.y, var_10_0.z)
		end

		var_0_0.Battle.BattleVariable.CameraPosToUICameraByRef(self._referenceVectorBorn)
	end

	return
end

function BattlePlayerCharacter:AddArrowBar(arg_11_1)
	BattlePlayerCharacter.super.AddArrowBar(self, arg_11_1)

	self._arrowCG = GetOrAddComponent(self._arrowBarTf, typeof(CanvasGroup))
	self._vectorProgress = self._arrowBarTf:Find("HPBar/HPProgress"):GetComponent(typeof(Image))

	setImageSprite(findTF(self._arrowBar, "icon"), (var_0_0.Battle.BattleResourceManager.GetInstance():GetCharacterQIcon(self._unitData:GetTemplate().painting)))

	if self._unitData:IsMainFleetUnit() then
		if self._unitData:GetFleetVO():GetMainList()[3] == self._unitData then
			arg_11_1.transform:SetSiblingIndex(arg_11_1.transform.parent.childCount - 3)
		end
	end

	self:UpdateVectorBar()

	return
end

function BattlePlayerCharacter:GetReferenceVector(arg_12_1)
	if self._inViewArea then
		return BattlePlayerCharacter.super.GetReferenceVector(self, arg_12_1)
	else
		return self._arrowVector
	end

	return
end

function BattlePlayerCharacter:DisableWeaponTrack()
	if self._torpedoTrack then
		self._torpedoTrack:SetActive(false)
	end

	return
end

function BattlePlayerCharacter:SonarAcitve(arg_14_1)
	if var_0_0.Battle.BattleAttr.HasSonar(self._unitData) then
		self._sonar:GetComponent(typeof(Animator)).enabled = arg_14_1
	end

	return
end

function BattlePlayerCharacter:UpdateDiveInvisible()
	BattlePlayerCharacter.super.UpdateDiveInvisible(self)
	SetActive(self._diveMark, (self._unitData:GetDiveInvisible()))
	SetActive(self._oxygenBar, (self._unitData:GetOxygenVisible()))

	return
end

function BattlePlayerCharacter:Dispose()
	self._torpedoIcons = nil
	self._renderer = nil
	self._sonar = nil
	self._diveMark = nil
	self._oxygenBar = nil
	self._oxygenSlider = nil

	Object.Destroy(self._arrowBar)

	for iter_16_0, iter_16_1 in ipairs(self._weaponSectorList) do
		iter_16_1:Dispose()
	end

	self._weaponSectorList = nil

	BattlePlayerCharacter.super.Dispose(self)

	return
end

function BattlePlayerCharacter:GetModleID()
	return self._unitData:GetTemplate().prefab
end

function BattlePlayerCharacter:OnUpdateHP(arg_18_1)
	BattlePlayerCharacter.super.OnUpdateHP(self, arg_18_1)
	self:UpdateVectorBar()

	return
end

function BattlePlayerCharacter:onInitWeaponCD(arg_19_1)
	self:onTorepedoReady()

	return
end

function BattlePlayerCharacter:onCastBlink(arg_20_1)
	self:AddFX("jineng", false, arg_20_1.Data.timeScale, arg_20_1.Data.callbackFunc)

	return
end

function BattlePlayerCharacter:onTorpedoWeaponFire(arg_21_1)
	self._torpedoTrack:SetActive(false)
	self:onTorepedoReady()

	return
end

function BattlePlayerCharacter:onTorpedoPrepar(arg_22_1)
	self._torpedoTrack:SetActive(true)

	local var_22_0 = var_0_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(arg_22_1.Dispatcher:GetTemplateData().bullet_ID[1])

	self._torpedoTrack:SetScale(Vector3(var_22_0.range / var_0_2.SPINE_SCALE, var_22_0.cld_box[3] / var_0_2.SPINE_SCALE, 1))

	return
end

function BattlePlayerCharacter:onTorpedoCancel(arg_23_1)
	self._torpedoTrack:SetActive(false)

	return
end

function BattlePlayerCharacter:onTorepedoReady(arg_24_1)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(self._torpedoWeaponList) do
		if iter_24_1:GetCurrentState() == iter_24_1.STATE_READY then
			var_24_0 = var_24_0 + 1
		end
	end

	for iter_24_2 = 1, var_0_0.Battle.BattleConst.MAX_EQUIPMENT_COUNT do
		LuaHelper.SetTFChildActive(self._torpedoIcons, "torpedo_" .. iter_24_2, iter_24_2 <= var_24_0)
	end

	return
end

function BattlePlayerCharacter:onAAMissileWeaponFire(arg_25_1)
	self:onAAMissileReady()

	return
end

function BattlePlayerCharacter:onWillDie(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self._smokeList) do
		if iter_26_1.active == true then
			iter_26_1.active = false

			for iter_26_2, iter_26_3 in pairs(iter_26_1.smokes) do
				if iter_26_2.unInitialize then
					-- block empty
				else
					SetActive(iter_26_3, false)
				end
			end
		end
	end

	return
end

function BattlePlayerCharacter:AddHPBar(arg_27_1)
	BattlePlayerCharacter.super.AddHPBar(self, arg_27_1)

	self._torpedoIcons = self._HPBarTf:Find("torpedoIcons")

	if #self._torpedoWeaponList <= 0 then
		self._torpedoIcons.gameObject:SetActive(false)
	end

	self._sonar = self._HPBarTf:Find("sonarMark")

	if var_0_0.Battle.BattleAttr.HasSonar(self._unitData) then
		self._sonar.gameObject:SetActive(true)
	else
		self._sonar.gameObject:SetActive(false)
	end

	self._diveMark = self._HPBarTf:Find("diveMark")
	self._oxygenBar = self._HPBarTf:Find("oxygenBar")
	self._oxygenSlider = self._oxygenBar:Find("oxygen"):GetComponent(typeof(Slider))
	self._oxygenSlider.value = 1

	self:onTorepedoReady()

	return
end

function BattlePlayerCharacter:AddModel(arg_28_1)
	BattlePlayerCharacter.super.AddModel(self, arg_28_1)

	self._renderer = self:GetTf():GetComponent(typeof(Renderer))

	return
end

function BattlePlayerCharacter:AddChargeArea(arg_29_1)
	self._chargeWeaponArea = var_0_0.Battle.BattleChargeArea.New(arg_29_1)

	return
end

function BattlePlayerCharacter:AddTorpedoTrack(arg_30_1)
	self._torpedoTrack = var_0_0.Battle.BossSkillAlert.New(arg_30_1)

	self._torpedoTrack:SetActive(false)

	return
end

function BattlePlayerCharacter:AddCloakBar(arg_31_1)
	BattlePlayerCharacter.super.AddCloakBar(self, arg_31_1)

	self._hpCloakBar = var_0_0.Battle.BattleCloakBar.New(self._HPBarTf:Find("cloakBar"), var_0_0.Battle.BattleCloakBar.FORM_BAR)

	self._hpCloakBar:ConfigCloak(self._unitData:GetCloak())
	self._hpCloakBar:UpdateCloakProgress()
	self._hpCloakBar:SetActive(true)

	return
end

function BattlePlayerCharacter:onUpdateCloakConfig(arg_32_1)
	BattlePlayerCharacter.super.onUpdateCloakConfig(self, arg_32_1)
	self._hpCloakBar:UpdateCloakConfig()

	return
end

function BattlePlayerCharacter:onUpdateCloakLock(arg_33_1)
	BattlePlayerCharacter.super.onUpdateCloakLock(self, arg_33_1)
	self._hpCloakBar:UpdateCloakLock()

	return
end

function BattlePlayerCharacter:InitChargeWeapon(arg_34_1)
	self._chargeWeaponList[#self._chargeWeaponList + 1] = arg_34_1

	self:RegisterWeaponListener(arg_34_1)
	arg_34_1:RegisterEventListener(self, var_0_1.CHARGE_WEAPON_FINISH, self.onCastBlink)

	return
end

function BattlePlayerCharacter:InitAirAssit(arg_35_1)
	self._airAssistList[#self._airAssistList + 1] = arg_35_1

	arg_35_1:RegisterEventListener(self, var_0_1.CHARGE_WEAPON_FINISH, self.onCastBlink)
	arg_35_1:RegisterEventListener(self, var_0_1.FIRE, self.onCannonFire)

	return
end

function BattlePlayerCharacter:InitTorpedoWeapon(arg_36_1)
	self._torpedoWeaponList[#self._torpedoWeaponList + 1] = arg_36_1

	self:RegisterWeaponListener(arg_36_1)
	arg_36_1:RegisterEventListener(self, var_0_1.TORPEDO_WEAPON_FIRE, self.onTorpedoWeaponFire)
	arg_36_1:RegisterEventListener(self, var_0_1.TORPEDO_WEAPON_PREPAR, self.onTorpedoPrepar)
	arg_36_1:RegisterEventListener(self, var_0_1.TORPEDO_WEAPON_CANCEL, self.onTorpedoCancel)
	arg_36_1:RegisterEventListener(self, var_0_1.TORPEDO_WEAPON_READY, self.onTorepedoReady)

	return
end

function BattlePlayerCharacter:onActiveWeaponSector(arg_37_1)
	if arg_37_1.Data.isActive then
		local var_37_0 = var_0_0.Battle.BattleWeaponRangeSector.New(self._factory:GetFXPool():GetCharacterFX("weaponrange", self).transform)

		var_37_0:ConfigHost(self._unitData, arg_37_1.Data.weapon)

		self._weaponSectorList[arg_37_1.Data.weapon] = var_37_0
	else
		self._weaponSectorList[arg_37_1.Data.weapon]:Dispose()

		self._weaponSectorList[arg_37_1.Data.weapon] = nil
	end

	return
end

function BattlePlayerCharacter:onCreatePointAirStrike(arg_38_1)
	self:InitChargeWeapon(arg_38_1.Data.weapon)

	return
end

function BattlePlayerCharacter:OnAnimatorTrigger()
	self._unitData:CharacterActionTriggerCallback()

	return
end

function BattlePlayerCharacter:OnAnimatorEnd()
	self._unitData:CharacterActionEndCallback()

	return
end

function BattlePlayerCharacter:OnAnimatorStart()
	self._unitData:CharacterActionStartCallback()

	return
end

return
