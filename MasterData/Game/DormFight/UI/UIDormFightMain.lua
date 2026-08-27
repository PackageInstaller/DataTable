local cs_ResLoader = CS.ResLoader
local UIDormFightMain = class("UIDormFightMain", UIBaseWindow)
local UIDormFighterInfoNode = require("Game.DormFight.UI.UIDormFighterInfoNode")
local CS_pvpFightManager_ins = CS.PvpFightManager.Instance
local equipWeaponState = CS.EquipWeaponState

function UIDormFightMain:OnInit()
  self._resLoader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_attack, self, self.OnAttackBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_weapon, self, self.OnWeaponBtnClick)
  self.__OnRunBtnPressDown = BindCallback(self, self.OnRunBtnPressDown)
  self.ui.btn_run.onPressDown:AddListener(self.__OnRunBtnPressDown)
  self.__OnRunBtnPressUp = BindCallback(self, self.OnRunBtnPressUp)
  self.ui.btn_run.onPressUp:AddListener(self.__OnRunBtnPressUp)
  self.__OnBtnAtkDown = BindCallback(self, self.OnBtnAtkDown)
  self.ui.btn_attack.onPressDown:AddListener(self.__OnBtnAtkDown)
  self.__OnBtnAtkUp = BindCallback(self, self.OnBtnAtkUp)
  self.ui.btn_attack.onPressUp:AddListener(self.__OnBtnAtkUp)
  self.__OnBtnWepDown = BindCallback(self, self.OnBtnWepDown)
  self.ui.btn_weapon.onPressDown:AddListener(self.__OnBtnWepDown)
  self.__OnBtnWepUp = BindCallback(self, self.OnBtnWepUp)
  self.ui.btn_weapon.onPressUp:AddListener(self.__OnBtnWepUp)
  self.__OnJoyStickMove = BindCallback(self, self.OnJoyStickMove)
  self.ui.joystick:onTouchMove("+", self.__OnJoyStickMove)
  self.__OnJoyStickUp = BindCallback(self, self.OnJoyStickUp)
  self.ui.joystick:onTouchUp("+", self.__OnJoyStickUp)
  self.selfInfoItemNode = UIDormFighterInfoNode.New()
  self.selfInfoItemNode:Init(self.ui.userInfoItem)
  self.enemyInfoItemNode = UIDormFighterInfoNode.New()
  self.enemyInfoItemNode:Init(self.ui.friendInfoItem)
end

function UIDormFightMain:InitDormFightMain(dormFightCtrl, resLoader)
  self.dormFightCtrl = dormFightCtrl
  self.resLoader = resLoader
  self.ui.obj_gamePanel:SetActive(true)
  self.CS_pvpController = CS_pvpFightManager_ins.PvpFightController
  self.ui.btn_weapon.gameObject:SetActive(true)
  self:InitFighterInfo()
end

function UIDormFightMain:InitFighterInfo()
  local dormFightCtrl = self.dormFightCtrl
  if dormFightCtrl == nil then
    return
  end
  local selfFightersList = dormFightCtrl:GetSelfFighterList()
  local enemyFightersList = dormFightCtrl:GetOtherFighterList()
  local selfUserData = dormFightCtrl:GetSelfUserData()
  local otherUserData = dormFightCtrl:GetOtherUserData()
  local selfUserName = selfUserData:GetUserName()
  local otherUserName = otherUserData:GetUserName()
  local selfFightersHeadSpriteList = self:__GenHeadSpriteListByFighterList(selfFightersList)
  local enemyFightersHeadSpriteList = self:__GenHeadSpriteListByFighterList(enemyFightersList)
  self.selfInfoItemNode:InitUIDormFighterInfoNode(selfFightersHeadSpriteList, selfUserName)
  self.enemyInfoItemNode:InitUIDormFighterInfoNode(enemyFightersHeadSpriteList, otherUserName)
end

function UIDormFightMain:__GenHeadSpriteListByFighterList(fighterList)
  if fighterList == nil then
    return
  end
  local headSpriteList = {}
  for i = 1, #fighterList do
    local heroId = fighterList[i].heroId
    local skinId = fighterList[i].skinId
    local sprite = CRH:GetHeroSkinSprite(heroId, skinId)
    table.insert(headSpriteList, sprite)
  end
  return headSpriteList
end

function UIDormFightMain:OnFighterRetired(isSelf, killerIndex, retiredindex)
  if isSelf then
    self.selfInfoItemNode:FighterRetired(retiredindex)
  else
    self.enemyInfoItemNode:FighterRetired(retiredindex)
  end
end

function UIDormFightMain:CurrentFighterDie(isSelf)
  if isSelf then
    self.selfInfoItemNode:CurrentFighterRetired()
  else
    self.enemyInfoItemNode:CurrentFighterRetired()
  end
end

function UIDormFightMain:UpDateCountDown(count, limit)
  if self.ui == nil then
    return
  end
  local value = limit - count
  if value <= ConfigData.dorm_fight_config.countDownSFXStartTime then
    AudioManager:PlayAudioById(ConfigData.dorm_fight_config.countDownAudioId)
  end
  self.ui.tex_CountDown.text = TimeUtil:TimestampToTime(value)
end

function UIDormFightMain:SetMainFighterController(fighterController)
  if not IsNull(fighterController) then
    self.netCharacter = fighterController.NetCharacter
    self.fighterController = fighterController
    self.weaponController = self.netCharacter:GetComponent(typeof(CS.WeaponController))
  end
end

function UIDormFightMain:ExitButtonClicked()
end

function UIDormFightMain:OnAttackBtnClick()
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  if self.fighterController.IsDead then
    self.fighterController:NetRevive()
    return
  end
  if not IsNull(self.weaponController) then
    local weaponState = self.weaponController.weaponState
    if weaponState == equipWeaponState.EquipWeapon then
      self.weaponController:NetThrowWeapon()
      return
    end
  end
  local animator = self.fighterController.FighterAnimator
  local isAttacking = animator:GetCurrentAnimatorStateInfo(0):IsTag("attack")
  local time = animator:GetCurrentAnimatorStateInfo(0).normalizedTime
  if animator:GetCurrentAnimatorStateInfo(0):IsTag("Default") or isAttacking and 0.5 < time then
    self.fighterController:FindTarget()
    if self.fighterController.IsRun then
      return
    end
    local roleEntity = self.netCharacter.roleEntity
    if roleEntity.ep < roleEntity.epReduceByAttack then
      return
    end
    self.fighterController:NetAttack()
  end
end

function UIDormFightMain:OnUpdateBtnWeapon(netCharacter)
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  if not self.netCharacter.IsOwnedBySelf or self.netCharacter ~= netCharacter then
    return
  end
  if self.ui == nil then
    return
  end
  local TouchingWeapons = self.weaponController.TouchingWeapons
  local weaponState = self.weaponController.weaponState
  if TouchingWeapons.Count > 0 or weaponState == equipWeaponState.EquipWeapon then
    self.ui.obj_uncatch:SetActive(false)
  else
    self.ui.obj_uncatch:SetActive(true)
  end
  if weaponState ~= equipWeaponState.EquipWeapon then
    self.ui.img_weaponImage:SetIndex(0)
  else
    self.ui.img_weaponImage:SetIndex(1)
  end
end

function UIDormFightMain:OnWeaponBtnClick()
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  if self.fighterController.IsDead then
    return
  end
  if self.ui == nil then
    return
  end
  local touchingWeapons = self.weaponController.TouchingWeapons
  local weaponState = self.weaponController.weaponState
  if self.weaponController.animator:GetCurrentAnimatorStateInfo(0):IsTag("Default") then
    if weaponState == equipWeaponState.NoWeapon and 0 < touchingWeapons.Count then
      self.weaponController:NetPickUpWeapon(touchingWeapons[0])
      self.ui.img_weaponImage:SetIndex(1)
    elseif weaponState == equipWeaponState.EquipWeapon then
      self.weaponController:NetThrowWeapon()
      self.ui.img_weaponImage:SetIndex(0)
    end
  end
end

function UIDormFightMain:OnUpdateBtnRun(netCharacter)
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  if not self.netCharacter.IsOwnedBySelf or self.netCharacter ~= netCharacter then
    return
  end
  if self.ui == nil then
    return
  end
  local roleEntity = self.netCharacter.roleEntity
  local isInteractable = roleEntity.ep >= roleEntity.epReduceByRunPerSecond
  self.ui.btn_run.interactable = isInteractable
end

function UIDormFightMain:OnRunBtnPressDown()
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  if self.fighterController.IsDead then
    return
  end
  local roleEntity = self.netCharacter.roleEntity
  if roleEntity.ep <= 0 then
    return false
  end
  self.fighterController:NetRun()
end

function UIDormFightMain:OnRunBtnPressUp()
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  self:OnUpdateBtnRun(self.netCharacter)
  if self.fighterController.IsDead then
    return
  end
  self.fighterController:NetStopRun()
end

function UIDormFightMain:OnBtnAtkDown()
  if self.ui == nil then
    return
  end
  self.ui.btn_attack.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
end

function UIDormFightMain:OnBtnAtkUp()
  if self.ui == nil then
    return
  end
  self.ui.btn_attack.transform.localScale = Vector3.New(1, 1, 1)
end

function UIDormFightMain:OnBtnWepDown()
  if self.ui == nil then
    return
  end
  self.ui.btn_weapon.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
end

function UIDormFightMain:OnBtnWepUp()
  if self.ui == nil then
    return
  end
  self.ui.btn_weapon.transform.localScale = Vector3.New(1, 1, 1)
end

function UIDormFightMain:OnJoyStickMove(joyStickData)
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  local radians = joyStickData.radians
  local radius = joyStickData.power
  local dir = Vector3.zero
  if 0.1 <= radius then
    local axisH = math.cos(radians) * radius
    local axisV = math.sin(radians) * radius
    dir = Vector3.New(axisH, 0, axisV)
  end
  self.fighterController:SetMoveVector(dir, radius)
end

function UIDormFightMain:OnJoyStickUp()
  if IsNull(self.netCharacter) or IsNull(self.fighterController) then
    return
  end
  self.fighterController:SetMoveVector(Vector3.zero, 0)
end

function UIDormFightMain:OnFightEnd()
  self:OnJoyStickUp()
  if not IsNull(self.fighterController) then
    self.fighterController:NetStopRun()
    self.fighterController.FighterAnimator:SetFloat("velocity", 0)
  end
  if self.ui ~= nil then
    self.ui.joystick:Reset()
  end
  AudioManager:PlayAudioById(ConfigData.dorm_fight_config.fightEndAudioId)
end

function UIDormFightMain:OnDelete()
  if self.ui ~= nil then
    self.ui.btn_run.onPressDown:RemoveListener(self.__OnRunBtnPressDown)
    self.ui.btn_run.onPressUp:RemoveListener(self.__OnRunBtnPressUp)
    self.ui.joystick:onTouchMove("-", self.__OnJoyStickMove)
    self.ui.joystick:onTouchUp("-", self.__OnJoyStickUp)
  end
  self.selfInfoItemNode:Delete()
  self.selfInfoItemNode = nil
  self.enemyInfoItemNode:Delete()
  self.enemyInfoItemNode = nil
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  UIBaseWindow.OnDelete(self)
end

return UIDormFightMain
