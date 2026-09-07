local CombatUIPreviewer = class("CombatUIPreviewer")
local var_0_1 = {
	LOOP = 3,
	FILLED = 2,
	UNFILLED = 1
}

CombatUIPreviewer.WeaponButtonPreviewMode = var_0_1

local var_0_2 = Vector3(0, 1, 40)
local var_0_3 = Vector3(35, 1, 40)
local var_0_4 = Vector3(30, 0, 0)
local var_0_5 = Vector3(330, 0, 0)
local var_0_6 = Vector3(-532, 157, 0)
local var_0_7 = Vector3(-665, 70, -675)
local var_0_8 = Vector3(473, 157, 0)
local var_0_9 = Vector3(-791, 70, 0)
local var_0_10 = Vector3(464, 70, -675)

function CombatUIPreviewer:Ctor(arg_1_1)
	self.rawImage = arg_1_1

	setActive(self.rawImage, false)

	self.seaCameraGO = GameObject.Find("BarrageCamera")
	self.seaCamera = self.seaCameraGO:GetComponent(typeof(Camera))
	self.seaCamera.targetTexture = self.rawImage.texture
	self.seaCamera.enabled = true

	return
end

function CombatUIPreviewer:setDisplayWeapon(arg_2_1, arg_2_2, arg_2_3)
	self.weaponIds = arg_2_1
	self.equipSkinId = arg_2_2 or 0

	return
end

function CombatUIPreviewer:setCombatUI(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.uiGO = arg_3_1
	self.hpBarGO = arg_3_2
	self.enemyBarGO = arg_3_3
	self.skinKey = arg_3_4

	local var_3_0 = arg_3_1.transform

	self.uiTF = arg_3_1.transform
	self.chatPop = var_3_0:Find("popup")
	self.chatPopGo = self.chatPop.gameObject

	setActive(self.chatPop, false)

	self.flagShipMark = var_3_0:Find("flagShipMark")
	self.timer = var_3_0:Find("Timer")

	setActive(self.timer, true)
	setText(self.timer:Find("Text"), "03:00")

	self.buttonContainer = var_3_0:Find("Weapon_button_container")

	local var_3_1 = {
		var_0_1.UNFILLED,
		var_0_1.FILLED,
		var_0_1.LOOP
	}

	for iter_3_0 = 1, 3 do
		local var_3_2 = ys.Battle["BattleWeaponButton" .. self.skinKey] and ys.Battle["BattleWeaponButton" .. self.skinKey].New() or ys.Battle.BattleWeaponButton.New()
		local var_3_3 = cloneTplTo(var_3_0:Find("Weapon_button_progress"), self.buttonContainer)

		skinName = "Skill_" .. iter_3_0

		ys.Battle.BattleSkillView.SetSkillButtonPreferences(var_3_3, iter_3_0)
		var_3_2:ConfigSkin(var_3_3)
		var_3_2:SwitchIcon(iter_3_0, arg_3_4)
		var_3_2:SwitchIconEffect(iter_3_0, arg_3_4)
		var_3_2:SetTextActive(true)
		var_3_2:SetToCombatUIPreview(var_3_1[iter_3_0])

		if iter_3_0 == 3 then
			local var_3_5 = GetOrAddComponent(go(var_3_3), typeof(UnityEngine.Playables.PlayableDirector))

			if var_3_5 then
				var_3_5.enabled = true
			end
		end
	end

	self.heroBar = arg_3_2.transform

	setActive(self.heroBar:Find("heroBlood"), true)

	self.enemyBar = self.enemyBarGO.transform

	setActive(self.enemyBar:Find("enemyBlood"), true)
	self:updateBarPos()

	self.mainArrow = var_3_0:Find("EnemyArrowContainer/MainArrow")

	setActive(self.mainArrow, true)

	self.autoBtn = var_3_0:Find("AutoBtn")

	setActive(self.autoBtn, true)
	triggerToggle(self.autoBtn, true)

	self.enemyHPBar = var_3_0:Find("EnemyHPBar")

	setActive(self.enemyHPBar, false)

	self.bossHPBar = var_3_0:Find("BossBarContainer/heroBlood")

	setActive(self.bossHPBar, true)

	local var_3_6 = self.bossHPBar:Find("bloodBarContainer")

	for iter_3_1 = 0, var_3_6.childCount - 1 do
		var_3_6:GetChild(iter_3_1):GetComponent(typeof(Image)).fillAmount = 1
		iter_3_1 = iter_3_1 + 1
	end

	self.skillContainer = var_3_0:Find("Skill_Activation/Root")
	self.skill = var_3_0:Find("Skill_Activation/mask")

	local var_3_7 = var_3_0:Find("Stick/Area/BG/spine")

	if var_3_7 then
		var_3_7:GetComponent(typeof(SpineAnimUI)):SetAction("normal", 0)
	end

	self.stick = var_3_0:Find("Stick/Area/Stick")
	self.stickTail = self.stick:Find("tailGizmos")

	return
end

function CombatUIPreviewer:load(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	assert(not self.loading and not self.loaded, "load function can be called only once.")

	self.loading = true
	self.shipVO = arg_4_2
	self.enemyVO = arg_4_3

	ys.Battle.BattleVariable.Init(true)
	ys.Battle.BattleVariable.UpdateCameraPositionArgs()
	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_4_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_4_0:Init()
	var_4_0:AddPreloadResource(var_4_0.GetUIPath("CombatHPPop" .. self.skinKey))
	var_4_0:AddPreloadResource(var_4_0.GetMapResource(arg_4_1))
	var_4_0:AddPreloadResource(var_4_0.GetDisplayCommonResource())

	if self.equipSkinId > 0 then
		var_4_0:AddPreloadResource(var_4_0.GetEquipSkinPreviewRes(self.equipSkinId))
	end

	var_4_0:AddPreloadResource(var_4_0.GetShipResource(arg_4_2.configId, arg_4_2.skinId), false)
	var_4_0:AddPreloadResource(var_4_0.GetShipResource(arg_4_3.configId, arg_4_3.skinId), false)
	var_4_0:StartPreload(function()
		self.seaView = ys.Battle.BattleMap.New(arg_4_1)

		local function var_5_0(arg_6_0)
			self.loading = false
			self.loaded = true

			pg.UIMgr.GetInstance():LoadingOff()

			local var_6_0 = ys.Battle.BattleFXPool.GetInstance()

			self.seaFXPool = var_6_0

			local var_6_1 = {}

			for iter_6_0, iter_6_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				var_6_1[iter_6_0] = Vector3(pg.ship_skin_template[arg_4_2.skinId].fx_container[iter_6_0][1], pg.ship_skin_template[arg_4_2.skinId].fx_container[iter_6_0][2], pg.ship_skin_template[arg_4_2.skinId].fx_container[iter_6_0][3])
			end

			local var_6_2 = arg_4_2:getConfig("scale") / 50

			self.seaCharacter = arg_6_0

			;(function(arg_7_0, arg_7_1)
				arg_7_0.transform.localScale = arg_7_1 and Vector3(var_6_2 * -1, var_6_2, var_6_2) or Vector3(var_6_2, var_6_2, var_6_2)
				arg_7_0.transform.localEulerAngles = var_0_4

				arg_7_0.transform:GetComponent("SpineAnim"):SetAction(ys.Battle.BattleConst.ActionName.MOVE, 0, true)

				local var_7_0 = GameObject()

				var_7_0.transform:SetParent(arg_7_0.transform, false)

				var_7_0.transform.localPosition = Vector3.zero
				var_7_0.transform.localEulerAngles = var_0_5

				pg.EffectMgr.GetInstance():PlayBattleEffect(var_6_0:GetCharacterFX("movewave", {
					GetGO = function()
						return self.seaCharacter
					end,
					GetSpecificFXScale = function()
						return {}
					end,
					GetAttachPoint = function()
						return var_7_0
					end,
					GetFXOffsets = function(arg_11_0, arg_11_1)
						arg_11_1 = arg_11_1 or 1

						return var_6_1[arg_11_1]
					end
				}), Vector3.zero, true)

				return
			end)(self.seaCharacter)

			self.seaCharacter.transform.localPosition = var_0_2

			self:SeaUpdate()
			setImageSprite(findTF(self.mainArrow, "icon"), (ys.Battle.BattleResourceManager.GetInstance():GetCharacterQIcon(self.shipVO:getPrefab())))
			setImageSprite(findTF(self.bossHPBar, "BossIcon/icon"), (ys.Battle.BattleResourceManager.GetInstance():GetCharacterSquareIcon(self.enemyVO:getPrefab())))
			setText(findTF(self.bossHPBar, "BossNameBG/BossName"), ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(self.enemyVO.configId).name)
			setActive(self.rawImage, true)
			pg.TimeMgr.GetInstance():ResumeBattleTimer()
			arg_4_5()

			return
		end

		local function var_5_1(arg_12_0)
			local var_12_0 = ys.Battle.BattleFXPool.GetInstance()

			self.seaFXPool = var_12_0

			local var_12_1 = {}

			for iter_12_0, iter_12_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				var_12_1[iter_12_0] = Vector3(pg.ship_skin_template[arg_4_3.skinId].fx_container[iter_12_0][1], pg.ship_skin_template[arg_4_3.skinId].fx_container[iter_12_0][2], pg.ship_skin_template[arg_4_3.skinId].fx_container[iter_12_0][3])
			end

			local var_12_2 = arg_4_3:getConfig("scale") / 50

			self.seaEnemy = arg_12_0

			;(function(arg_13_0, arg_13_1)
				arg_13_0.transform.localScale = arg_13_1 and Vector3(var_12_2 * -1, var_12_2, var_12_2) or Vector3(var_12_2, var_12_2, var_12_2)
				arg_13_0.transform.localEulerAngles = var_0_4

				arg_13_0.transform:GetComponent("SpineAnim"):SetAction(ys.Battle.BattleConst.ActionName.MOVE, 0, true)

				local var_13_0 = GameObject()

				var_13_0.transform:SetParent(arg_13_0.transform, false)

				var_13_0.transform.localPosition = Vector3.zero
				var_13_0.transform.localEulerAngles = var_0_5

				pg.EffectMgr.GetInstance():PlayBattleEffect(var_12_0:GetCharacterFX("movewave", {
					GetGO = function()
						return self.seaCharacter
					end,
					GetSpecificFXScale = function()
						return {}
					end,
					GetAttachPoint = function()
						return var_13_0
					end,
					GetFXOffsets = function(arg_17_0, arg_17_1)
						arg_17_1 = arg_17_1 or 1

						return var_12_1[arg_17_1]
					end
				}), Vector3.zero, true)

				return
			end)(self.seaEnemy, true)

			self.seaEnemy.transform.localPosition = var_0_3

			return
		end

		var_4_0:InstCharacter(arg_4_3:getPrefab(), function(arg_18_0)
			var_5_1(arg_18_0)

			return
		end)
		var_4_0:InstCharacter(arg_4_2:getPrefab(), function(arg_19_0)
			var_5_0(arg_19_0)

			return
		end)

		return
	end, nil)
	pg.UIMgr.GetInstance():LoadingOn()

	return
end

function CombatUIPreviewer:updateBarPos()
	if self.seaCharacter then
		self.heroBar.localPosition = var_0_6
		self.flagShipMark.localPosition = var_0_7
	end

	if self.seaEnemy then
		self.enemyBar.localPosition = var_0_8
	end

	return
end

function CombatUIPreviewer:updatePopUp()
	setActive(self.chatPop, true)

	self.chatPop.localPosition = var_0_9

	LeanTween.cancel(self.chatPop)

	if self.chatPop.transform:GetComponent(typeof(Animation)) then
		ys.Battle.BattleCharacter.ChatPopAnimation(self.chatPop, 4)
		ys.Battle.BattleCharacter.setChatText(self.chatPop, pg.ship_skin_words[100000].skill)
	else
		LeanTween.scale(rtf(self.chatPop.gameObject), Vector3.New(0, 0, 1), 0.1):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(function()
			ys.Battle.BattleCharacter.ChatPop(self.chatPop, 5)
			ys.Battle.BattleCharacter.setChatText(self.chatPop, pg.ship_skin_words[100000].skill)

			return
		end))
	end

	return
end

function CombatUIPreviewer:updateSkillFloat()
	setActive(self.skill, true)

	local var_23_0 = ys.Battle.BattleResourceManager.GetInstance()
	local var_23_1 = self.skinKey == "Standard" and var_23_0:GetCharacterIcon(self.shipVO:getPrefab()) or var_23_0:GetCharacterSquareIcon(self.shipVO:getPrefab())
	local var_23_2 = self.skill.transform

	self.skill.localScale = Vector3(1.5, 1.5, 0)

	local var_23_3 = var_23_2:GetComponent(typeof(Animation))

	if var_23_3 then
		local var_23_4 = 1

		while var_23_3:GetClip("anim_skinui_skill_" .. var_23_4) do
			var_23_4 = var_23_4 + 1
		end

		if var_23_4 > 1 then
			var_23_3:Play("anim_skinui_skill_" .. math.random(var_23_4 - 1))
		end
	end

	setText(findTF(var_23_2, "skill/skill_name/Text"), HXSet.hxLan(pg.skill_data_template[9033].name))

	findTF(var_23_2, "skill/icon_mask/icon"):GetComponent(typeof(Image)).sprite = var_23_1

	local var_23_5 = Color.New(1, 1, 1, 1)

	findTF(var_23_2, "skill/skill_name"):GetComponent(typeof(Image)).color = var_23_5
	findTF(var_23_2, "skill"):GetComponent(typeof(Image)).color = var_23_5

	var_23_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_24_0)
		setActive(self.skill, false)

		return
	end)

	var_23_2.position = Clone(self.heroBar.position)

	return
end

function CombatUIPreviewer:updateHPPop()
	local var_25_0

	if not self._popNumMgr then
		self._popNumMgr = ys.Battle.BattlePopNumManager.GetInstance()

		self._popNumMgr:InitialBundlePool(self.uiGO.transform:Find("HPTextCharacterContainer/container"))

		self._popNumBundle = self._popNumMgr:GetBundle()
		var_25_0 = {
			nil,
			1
		}
	end

	var_25_0[1] = math.random(1, 4)

	local var_25_1 = self._popNumBundle:GetPop(false, math.random(1, 2) > 1, false, 114, var_25_0)

	var_25_1._tf.localPosition = var_0_10

	var_25_1:Play()

	return
end

local var_0_11 = 250
local var_0_12 = 50
local var_0_13 = 1000
local var_0_14 = 2
local var_0_15 = 3

function CombatUIPreviewer:updateStick()
	if self._stickMoveCount and self._stickMoveCount <= var_0_11 then
		self._stickMoveCount = self._stickMoveCount + 1

		if (self.stickVX + self.stick.localPosition.x) * (self.stickVX + self.stick.localPosition.x) + (self.stickVY + self.stick.localPosition.y) * (self.stickVY + self.stick.localPosition.y) > var_0_13 * 2 then
			local var_26_0 = math.atan2(self.stickVY + self.stick.localPosition.y, self.stickVX + self.stick.localPosition.x)
			local var_26_3 = math.random() * 2 * math.pi
			local var_26_4 = math.random(var_0_14, var_0_15)

			self.stickVX = math.cos(var_26_3) * var_26_4
			self.stickVY = math.sin(var_26_3) * var_26_4

			if self.stickVX * (var_0_13 * math.cos(var_26_0) / var_0_13) + self.stickVY * (var_0_13 * math.sin(var_26_0) / var_0_13) > 0 then
				self.stickVX = -self.stickVX
				self.stickVY = -self.stickVY
			end
		else
			self.stickPos.x = self.stickVX + self.stick.localPosition.x
			self.stickPos.y = self.stickVY + self.stick.localPosition.y
			self.stick.localPosition = self.stickPos
		end

		if self._stickMoveCount >= var_0_11 then
			if self.stickTail then
				setActive(self.stickTail, false)
			end

			self.stick.localPosition = Vector3.zero
			self._stickMoveCount = nil
			self._stickStopCount = 0
		end
	elseif self._stickStopCount and self._stickStopCount <= var_0_12 then
		self._stickStopCount = self._stickStopCount + 1

		if self._stickStopCount >= var_0_12 then
			if self.stickTail then
				setActive(self.stickTail, true)
			end

			local var_26_5 = math.random() * 2 * math.pi
			local var_26_6 = math.random(var_0_14, var_0_15)

			self.stickVX = math.cos(var_26_5) * var_26_6
			self.stickVY = math.cos(var_26_5) * var_26_6
			self._stickStopCount = nil
			self._stickMoveCount = 0
		end
	end

	return
end

function CombatUIPreviewer:SeaUpdate()
	pg.TimeMgr.GetInstance():AddBattleTimer("barrageUpdateTimer", -1, 0.033, function()
		self:updateBarPos()

		return
	end)

	self._stickStopCount = 0
	self.stickPos = Vector2.New(0, 0)

	pg.TimeMgr.GetInstance():AddBattleTimer("stickUpdateTimer", -1, 0.033, function()
		self:updateStick()

		return
	end)
	pg.TimeMgr.GetInstance():AddBattleTimer("popupUpdateTimer", -1, 10, function()
		self:updatePopUp()

		return
	end)
	pg.TimeMgr.GetInstance():AddBattleTimer("skillFloatUpdateTimer", -1, 10, function()
		self:updateSkillFloat()

		return
	end)
	pg.TimeMgr.GetInstance():AddBattleTimer("HPPopUpdateTimer", -1, 3, function()
		self:updateHPPop()

		return
	end)

	return
end

function CombatUIPreviewer:clear()
	pg.TimeMgr.GetInstance():RemoveAllBattleTimer()
	Destroy(self.seaCharacter)
	Destroy(self.seaEnemy)
	Destroy(self.uiGO)
	Destroy(self.hpBarGO)
	Destroy(self.enemyBarGO)

	if self.seaView then
		self.seaView:Dispose()

		self.seaView = nil
	end

	if self._popNumMgr then
		self._popNumMgr:Clear()
	end

	if self.weaponList then
		for iter_33_0, iter_33_1 in ipairs(self.weaponList) do
			for iter_33_2, iter_33_3 in ipairs(iter_33_1.emitterList) do
				iter_33_3:Destroy()
			end
		end

		self.weaponList = nil
	end

	if self.seaFXPool then
		self.seaFXPool:Clear()

		self.seaFXPool = nil
	end

	if self.seaFXContainersPool then
		self.seaFXContainersPool:Clear()

		self.seaFXContainersPool = nil
	end

	ys.Battle.BattleResourceManager.GetInstance():Clear()

	self.seaCamera.enabled = true
	self.seaCameraGO = nil
	self.seaCamera = nil
	self.loading = false
	self.loaded = false

	return
end

return CombatUIPreviewer
