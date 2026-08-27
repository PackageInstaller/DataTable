local UINUltimateNode = class("UINUltimateNode", UIBaseNode)
local base = UIBaseNode
local UINUltSkillHeroItem = require("Game.Battle.UI.SkillModule.UltimateSkill.UINUltSkillHeroItem")
local UINUltSkillMpParticleItem = require("Game.Battle.UI.SkillModule.UltimateSkill.UINUltSkillMpParticleItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_DOTween = CS.DG.Tweening.DOTween
local CS_BattleManager = CS.BattleManager.Instance
local util = require("XLua.Common.xlua_util")
local ProgressAnimSpeed = 1.5
local MaskRadiusMax = 1
local MaskRadius = 0.3
xlua.private_accessible(CS.BattlePlayerController)

function UINUltimateNode:ctor(resloader)
  self.resloader = resloader
end

function UINUltimateNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ultSkip, self, self.OnUltSkip)
  UIUtil.AddValueChangedListener(self.ui.tog_AutoUltimate, self, self.__OnAutoUltClick)
  self.ui.btn_ShowUltDes.onPress:AddListener(BindCallback(self, self.__OnLongPressShowUltDes))
  self.ui.btn_ShowUltDes.onPressUp:AddListener(BindCallback(self, self.__OnPressUpShowUltDes))
  self.__OnHeroItemClicked = BindCallback(self, self.OnHeroItemClicked)
  self.__ShowSkillInfo = BindCallback(self, self.ShowSkillInfo)
  self.__HideSkillInfo = BindCallback(self, self.HideSkillInfo)
  self.__OnRecycleMpParticle = BindCallback(self, self.__RecycleMpParticle)
  self.ui.heroHeadItem:SetActive(false)
  self.heroItemPool = UIItemPool.New(UINUltSkillHeroItem, self.ui.heroHeadItem)
  self.ui.mpParticleItem:SetActive(false)
  self.mpParticleItem = UIItemPool.New(UINUltSkillMpParticleItem, self.ui.mpParticleItem)
  self.ui.focusMask.enabled = false
  self.maskMaterial = CS.UnityEngine.Object.Instantiate(self.ui.mat_maskFoucus)
  self.ui.focusMask.material = self.maskMaterial
  self.ui.videoRenderer.enabled = false
  self.ui.btn_ultSkipRender.raycastTarget = false
  self.__skillFillAmount = 0
  self.__skillEfficent = ConfigData.game_config.ultMpEfficent / ConfigData.game_config.ultMpMaxEfficent
  self._img_Value_Height = self.ui.img_Value.transform.rect.height
  self.isUnlockAutoUlt = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_battle_auto_ult)
  self.isUnlockAutoUlt = self.isUnlockAutoUlt and not BattleUtil.IsInBrotatBattle() and not BattleUtil.IsInTDBattle()
  self.ui.tog_AutoUltimate.gameObject:SetActive(self.isUnlockAutoUlt)
  self.isSkipBtnActive = true
end

function UINUltimateNode:InitBattlePlayerUltSkill(battleSkillList, useSkillFunc, ultEffectSkipFunc)
  self.useSkillFunc = useSkillFunc
  self.ultEffectSkipFunc = ultEffectSkipFunc
  self:CreateUltSkillHero(battleSkillList)
  self:RefreshAutoBattleToggle()
end

function UINUltimateNode:CreateUltSkillHero(battleSkillList)
  self.hasUltSkill = false
  self.heroItemDic = {}
  self.heroUltItemCount = 0
  self.notSkillHeroItemDic = {}
  self.heroItemPool:HideAll()
  self.heroItemList = {}
  local battleOriginRoleList = CS_BattleManager.CurBattleController.PlayerTeamController.battleOriginRoleList
  local hasSkillHeroIdDic = {}
  if self._genHeadCo ~= nil then
    GR.StopCoroutine(self._genHeadCo)
    self._genHeadCo = nil
  end
  local isBattleRunning = CS_BattleManager.IsBattleRunning
  self._genHeadCo = GR.StartCoroutine(util.cs_generator(function()
    local index = 0
    for i = 0, battleSkillList.Count - 1 do
      if not isBattleRunning then
        coroutine.yield(nil)
      end
      local battleSkill = battleSkillList[i]
      if battleSkill ~= nil then
        index = index + 1
        if not self.hasUltSkill then
          self.hasUltSkill = true
        end
        local id = battleSkill.maker.roleDataId
        local heroData = self:_GetHeroData(id)
        hasSkillHeroIdDic[id] = true
        self:AddHeroUltSkill(battleSkill, index, heroData)
      end
    end
    for i = 0, battleOriginRoleList.Count - 1 do
      if not isBattleRunning then
        coroutine.yield(nil)
      end
      local roleEntity = battleOriginRoleList[i]
      local heroId = roleEntity.roleDataId
      if roleEntity.x ~= ConfigData.buildinConfig.BenchX and not hasSkillHeroIdDic[heroId] then
        local heroData = self:_GetHeroData(heroId)
        self:AddHeroItem(heroId, heroData)
      end
    end
    self._genHeadCo = nil
  end))
end

function UINUltimateNode:RefreshAutoBattleToggle()
  local isOpenUlt = false
  if self.isUnlockAutoUlt then
    isOpenUlt = CommonUtil.IsOpenUltSkillAuto()
  end
  self.ui.tog_AutoUltimate.isOn = isOpenUlt
end

function UINUltimateNode:_GetHeroData(heroId)
  local heroData
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer ~= nil then
    local dynHero = dynPlayer.heroDic[heroId]
    if dynHero ~= nil then
      return dynHero.heroData
    end
  end
  heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    local heroCfg = ConfigData.hero_data[heroId]
    heroData = HeroData.New({
      basic = {
        id = heroId,
        level = 1,
        exp = 0,
        star = heroCfg.rank,
        potentialLvl = 0,
        ts = -1,
        career = heroCfg.career,
        company = heroCfg.camp,
        skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
      }
    })
  end
  return heroData
end

function UINUltimateNode:AddUltSkillItemInBattle(roleDataId, battleSkill)
  if self.heroItemDic[roleDataId] ~= nil then
    return
  end
  local index = self.heroUltItemCount + 1
  local heroData = self:_GetHeroData(roleDataId)
  if heroData == nil then
    return
  end
  self:AddHeroUltSkill(battleSkill, index, heroData)
  self.heroUltItemCount = index
  self.hasUltSkill = true
end

function UINUltimateNode:RemoveUltSkillItemInBattle(roleDataId, battleSkill)
  local heroItem = self.heroItemDic[roleDataId]
  if heroItem == nil then
    return
  end
  for i = #self.heroItemList, 1, -1 do
    if self.heroItemList[i] == heroItem then
      table.remove(self.heroItemList, i)
    end
  end
  self.heroItemPool:HideOne(heroItem)
  self.heroItemDic[roleDataId] = nil
  self.heroUltItemCount = self.heroUltItemCount - 1
  for i, v in ipairs(self.heroItemList) do
    v:ReSetFpxConsOffest(i, self.ui.efx_offsetZ)
  end
end

function UINUltimateNode:OnHeroItemClicked(battleSkill)
  if self.useSkillFunc == nil then
    return
  end
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSelectSkillType(true)
  end
  self.useSkillFunc(battleSkill, false)
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillClick, battleSkill)
end

function UINUltimateNode:SetUltSkipBtnActive(bValue)
  self.isSkipBtnActive = bValue
end

function UINUltimateNode:OnUltSkip()
  if not self.isSkipBtnActive then
    return
  end
  if ExplorationManager:IsInExploration() and ExplorationManager:IsSectorNewbee() then
    return
  end
  local win = UIManager:GetWindow(UIWindowTypeID.UltimateSkillShow)
  if win ~= nil then
    win:Delete()
  end
  if self.ultEffectSkipFunc ~= nil then
    self.ultEffectSkipFunc()
  end
end

function UINUltimateNode:ShowSkillInfo(item, battleSkill, heroData)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.skill)
  local name, describe
  if battleSkill == nil then
    for k, skillData in ipairs(heroData.skillList) do
      if skillData:IsUniqueSkill() then
        name = skillData:GetName()
        describe = skillData:GetLevelDescribe(1, nil, isShowDetail)
        break
      end
    end
  else
    name = battleSkill.name
    describe = battleSkill.skillCfg:GetLevelDescribe(battleSkill.level, false, isShowDetail)
  end
  win:SetTitleAndContext(name, describe)
  win:FloatTo(item.transform, HAType.right, VAType.up)
end

function UINUltimateNode:HideSkillInfo()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UINUltimateNode:AddHeroUltSkill(battleSkill, index, heroData)
  local heroId = battleSkill.maker.roleDataId
  if self.heroItemDic[heroId] ~= nil then
    warning(string.format("为英雄%d配置了多个必杀技，请检查配置表。", heroId))
    return
  end
  local heroItem = self.heroItemPool:GetOne()
  heroItem:InitUltSkillHeroItem(battleSkill, self.resloader, self.__OnHeroItemClicked, index, self.ui.efx_offsetZ, heroData, self.ui.fxpCanvas, self.ui.hpCanvas)
  heroItem:SetShowUltSkillInfoFunc(self.__ShowSkillInfo, self.__HideSkillInfo)
  self.heroItemDic[heroId] = heroItem
  self.heroUltItemCount = self.heroUltItemCount + 1
  table.insert(self.heroItemList, heroItem)
  heroItem:UltSkillUsable(self.__useEnable, self.__highlightIntensity)
end

function UINUltimateNode:AddHeroItem(heroId, heroData)
  if self.notSkillHeroItemDic[heroId] ~= nil then
    return
  end
  local heroItem = self.heroItemPool:GetOne()
  heroItem:InitHeroUltHeadItem(heroData, self.resloader, self)
  heroItem:SetShowUltSkillInfoFunc(self.__ShowSkillInfo, self.__HideSkillInfo)
  heroItem:UltSkillUsable(false)
  self.notSkillHeroItemDic[heroId] = heroItem
end

function UINUltimateNode:RemoveHeroItem(heorId)
  local item = self.notSkillHeroItemDic[heorId]
  if item == nil then
    return
  end
  self.heroItemPool:HideOne(item)
  self.notSkillHeroItemDic[heorId] = nil
end

function UINUltimateNode:OnUpdateLogic_UltimateNode()
  for k, skillItem in ipairs(self.heroItemPool.listItem) do
    skillItem:OnUpdateLogic_UltSkillItem(self.__highlightIntensity)
    skillItem:OnUpdateLogic_ReturnCD()
  end
end

function UINUltimateNode:OnUpdateRender_UltimateNode(deltaTime, interpolation)
  for k, skillItem in ipairs(self.heroItemPool.listItem) do
    skillItem:OnUpdateRender_UltSkillItem(deltaTime, interpolation)
    skillItem:OnUpdateRender_ReturnCD()
  end
end

function UINUltimateNode:ShowSideHeadHpBar(heroHpRateDic)
  for _, skillItem in pairs(self.heroItemPool.listItem) do
    local rate = heroHpRateDic[skillItem.heroId]
    if rate ~= nil then
      skillItem:SetSideHpBarActive(true, rate)
    else
      skillItem:SetSideHpBarActive(false)
    end
  end
end

function UINUltimateNode:ShowHeroReturnCD(heroId, retrunCD)
  if self.heroItemPool == nil then
    return
  end
  for _, skillItem in pairs(self.heroItemPool.listItem) do
    if skillItem.heroId == heroId then
      skillItem:ShowHeroReturnCD(retrunCD)
      break
    end
  end
end

function UINUltimateNode:DisableHeroUltSkill(heroId, disable)
  if self.heroItemDic == nil then
    return
  end
  self.__useEnable = not disable
  local heroItem = self.heroItemDic[heroId]
  local battleCtrl, playerCtrl
  if BattleUtil.IsInTDBattle() then
    battleCtrl = CS_BattleManager.CurBattleController
    if battleCtrl ~= nil then
      playerCtrl = battleCtrl.PlayerController
    end
  end
  if heroItem ~= nil then
    local maker
    if heroItem.battleSkill ~= nil then
      maker = heroItem.battleSkill.maker
    end
    local isRoleDie = maker ~= nil and maker.hp <= 0
    if not disable and isRoleDie then
      return
    end
    if playerCtrl ~= nil and isRoleDie then
      playerCtrl:RemoveHeroUltSkill(heroItem.battleSkill)
      self:RemoveUltSkillItemInBattle(heroId, heroItem.battleSkill)
    else
      heroItem:DisableUltSkillHeroItem(disable)
    end
  end
  local isAllDisable = self:CheckAllHeroItemDisable()
  if isAllDisable and self.__tweenLeft then
    self.ui.tweenLeft:DOPlayBackwards()
    self.__tweenLeft = false
  end
end

function UINUltimateNode:CheckAllHeroItemDisable()
  local isAllDisable = true
  for k, v in pairs(self.heroItemDic) do
    if v ~= nil and not v:IsHeroItemDisabled() then
      isAllDisable = false
      break
    end
  end
  return isAllDisable
end

function UINUltimateNode:UpdateUltSkill(useEnable, curRatio, nextRatio, factor, interpolation)
  local fillAount = Mathf.Lerp(self.__skillFillAmount, nextRatio, interpolation * ProgressAnimSpeed)
  self:RefreshUltMpFillAmount(fillAount)
  self:RefreshUltSkillHero(useEnable, self.ui.img_AdvValue.fillAmount)
  self:RefreshUltMpSpeed(factor, true)
end

function UINUltimateNode:UpdateUltSkillForce(useEnable, curRatio, factor)
  self:RefreshUltMpFillAmount(curRatio)
  self:RefreshUltSkillHero(useEnable, self.ui.img_AdvValue.fillAmount)
  self:RefreshUltMpSpeed(factor, false)
end

function UINUltimateNode:RefreshUltSkillHero(useEnable, fillAount)
  local allHeroItemDisable = self:CheckAllHeroItemDisable()
  self.__useEnable = useEnable and not allHeroItemDisable
  if self.__useEnable and self.hasUltSkill then
    local efcMentioned = false
    if not self.__tweenLeft then
      self.ui.tweenLeft:DOPlayForward()
      self.__tweenLeft = true
      efcMentioned = true
    end
    local intensity = (fillAount - 0.1) / 0.9
    if self.__highlightIntensity ~= intensity or efcMentioned or self.__highlightIntensity >= 1 then
      self.__highlightIntensity = intensity
      for k, heroItem in pairs(self.heroItemDic) do
        if self.__skillFillAmount >= 0.5 or heroItem:IsSkillCanSpecialPlay() then
          heroItem:UltSkillUsable(true, intensity)
          if efcMentioned and not heroItem:IsHeroItemDisabled() then
            heroItem:ShowEfcMetioned()
          end
        else
          heroItem:UltSkillUsable(false)
        end
      end
    end
  else
    if self.__tweenLeft then
      self.ui.tweenLeft:DOPlayBackwards()
      self.__tweenLeft = false
    end
    for k, heroItem in pairs(self.heroItemDic) do
      heroItem:UltSkillUsable(false)
    end
  end
end

function UINUltimateNode:RefreshUltMpFillAmount(fillAount)
  self.__skillFillAmount = fillAount
  local efficent = self.__skillEfficent
  local invalidFillAmount = math.min(fillAount / efficent, 1)
  local validFillAmount = math.min(math.max(fillAount - efficent, 0) / (1 - efficent), 1)
  if 1 > self.ui.img_Value.fillAmount and invalidFillAmount == 1 then
    AudioManager:PlayAudioById(1005)
  end
  self.ui.img_Value.fillAmount = invalidFillAmount
  if 1 > self.ui.img_AdvValue.fillAmount and validFillAmount == 1 then
    AudioManager:PlayAudioById(1006)
  end
  self.ui.img_AdvValue.fillAmount = validFillAmount
  local posY = 0
  if 1 <= invalidFillAmount then
    posY = self._img_Value_Height * (validFillAmount - 0.5)
  else
    posY = self._img_Value_Height * (invalidFillAmount - 0.5)
  end
  self.ui.progressPoint:SetAnchoredPosition(0, posY)
end

function UINUltimateNode:IsUltSkillSlotFull()
  return self.ui.img_Value.fillAmount >= 1
end

function UINUltimateNode:RefreshUltMpSpeed(speed, withTween)
  local newSpeed = self:GetSpeedInDeployState()
  speed = newSpeed or speed
  if self.__ultMpSpeed == speed then
    return
  end
  self.__ultMpSpeed = speed
  local speedStr
  if 10 <= speed then
    speedStr = tostring(math.floor(speed))
  else
    speedStr = string.format("%.1f", speed)
  end
  self.ui.tex_Speed.text = speedStr
  local clampSpeed = math.min(speed, 10)
  local posY = self.ui.speedItem.parent.sizeDelta.y * (clampSpeed - 1) / 9
  self.ui.speedItem:SetAnchoredPosition(0, posY)
  if withTween then
    local value = clampSpeed / 10
    local endValue = Vector3.New(value, value, value)
    self.ui.tweenSpeed.endValueV3 = endValue
    self.ui.tweenSpeed:DORestart()
  end
end

function UINUltimateNode:GetSpeedInDeployState()
  local battleCtrl = CS_BattleManager.CurBattleController
  if not CS_BattleManager.IsBattleRunning then
    local playerTeam = battleCtrl.PlayerTeamController
    local aliveRoleCount = 0
    aliveRoleCount = aliveRoleCount + self:CheckAndCollectAliveCount(playerTeam.battleOriginRoleList)
    aliveRoleCount = aliveRoleCount + self:CheckAndCollectAliveCount(playerTeam.dungeonRoleList)
    local ultSkillModel = battleCtrl.PlayerController.UltSkillHandle.ultSkillModel
    ultSkillModel:InitUltMpFactor(aliveRoleCount, ultSkillModel.dynPlayer)
    return ultSkillModel.UltMpIncreaseFactorOnPercent
  end
  return nil
end

function UINUltimateNode:CheckAndCollectAliveCount(csRoleList)
  if csRoleList == nil or csRoleList.Count <= 0 then
    return 0
  end
  local aliveCount = 0
  for i = 0, csRoleList.Count - 1 do
    local role = csRoleList[i]
    if not role.roleOnBench and not role.isDead then
      aliveCount = aliveCount + 1
    end
  end
  return aliveCount
end

function UINUltimateNode:CreateMpParticle(startPos, ratio)
  if ratio == 0 then
    return
  end
  local mpPartItem = self.mpParticleItem:GetOne()
  local posX, posY = UIManager:World2UIPositionOut(self.ui.progressPoint, nil, nil, UIManager.UICamera)
  mpPartItem:InitUltSkillMpParticle(startPos, posX, posY, ratio, self.__OnRecycleMpParticle)
end

function UINUltimateNode:__RecycleMpParticle(mpPartItem)
  self.mpParticleItem:HideOne(mpPartItem)
end

function UINUltimateNode:ShowUltSkillFocusMask(show)
  if show then
    self.ui.focusMask.enabled = true
    self.maskMaterial:SetFloat("_Radius", MaskRadiusMax)
    local startRadius = self.maskMaterial:GetFloat("_Radius")
    CS_DOTween.To(function()
      return startRadius
    end, function(x)
      if not IsNull(self.maskMaterial) then
        self.maskMaterial:SetFloat("_Radius", x)
      end
    end, MaskRadius, 0.7):SetLink(self.gameObject)
  else
    self.ui.focusMask.enabled = false
  end
end

function UINUltimateNode:UpdateUltSkillFocusMask(screenPos)
  self.maskMaterial:SetVector("_Item", Vector4.New(screenPos.x, screenPos.y, 0, 0))
end

function UINUltimateNode:GetUltSkillMovieRenderer()
  return self.ui.videoRenderer
end

function UINUltimateNode:GetUltSkipBtnRenderer()
  return self.ui.btn_ultSkipRender
end

function UINUltimateNode:ChangeUltSkillUIOrder(change)
  if change then
    self.ui.canvas_heroList.overrideSorting = true
    self.ui.canvas_progress.overrideSorting = true
    self.ui.raycast_heroList.enabled = false
    self.ui.tween_progress:DORestart()
  else
    self.ui.canvas_heroList.overrideSorting = false
    self.ui.canvas_progress.overrideSorting = false
    self.ui.raycast_heroList.enabled = true
    self.ui.tween_progress:DORewind()
  end
end

function UINUltimateNode:IsHaveUltHead(heroId)
  if self.heroItemDic[heroId] ~= nil then
    return true, true
  end
  if self.notSkillHeroItemDic[heroId] ~= nil then
    return true, false
  end
  return false, false
end

function UINUltimateNode:__OnAutoUltClick(value)
  local index = value and 1 or 0
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  setCtrl:SetGSMultSettingIndex(eGameSetDescType.ultSkill_auto, index)
  self.ui.img_Auto:SetIndex(index)
  local win = UIManager:ShowWindow(UIWindowTypeID.Battle)
  if win ~= nil then
    win:SetUltAuto(value)
  end
end

function UINUltimateNode:__OnLongPressShowUltDes()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local title = ConfigData:GetTipContent(1019)
  local describe = ConfigData:GetTipContent(1018)
  win:SetTitleAndContext(title, describe)
  win:FloatTo(nil, HAType.autoCenter, VAType.up, -20, 20)
end

function UINUltimateNode:__OnPressUpShowUltDes()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UINUltimateNode:OnDelete()
  self.heroItemCount = 0
  if self.maskMaterial ~= nil then
    DestroyUnityObject(self.maskMaterial)
    self.maskMaterial = nil
  end
  if self._genHeadCo ~= nil then
    GR.StopCoroutine(self._genHeadCo)
    self._genHeadCo = nil
  end
  self.useSkillFunc = nil
  self.ultEffectSkipFunc = nil
  self.heroItemPool:DeleteAll()
  self.heroItemPool = nil
  self.mpParticleItem:DeleteAll()
  self.mpParticleItem = nil
  self:ShowUltSkillFocusMask(false)
  base.OnDelete(self)
end

return UINUltimateNode
