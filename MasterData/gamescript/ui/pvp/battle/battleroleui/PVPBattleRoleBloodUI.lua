local UIAnimationController = CS.Z1Client.UIAnimationController
local CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local TypeCanvas = typeof(CS.UnityEngine.Canvas)
local BLOOD_SIZE = 118
local PVPBattleRoleBloodUI, Super = System.NewComponent("PVPBattleRoleBloodUI")

function PVPBattleRoleBloodUI:ctor(uiNode, battleRole, intentNode)
  Super.ctor(self)
  self.ui = UI_Pvp_Blood_ShareResource(uiNode)
  self.intentNode = intentNode
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.isEnemy = battleRole.camp ~= bg.battleDataCenter:GetMyCamp()
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function PVPBattleRoleBloodUI:OnBind(binder)
  self.binder = binder
  self:OnBindHp(binder)
  self:OnBindRoleEnergy(binder)
  self:BindToDead(binder)
  self:OnBindBlock(binder)
  self:OnBindPosition(binder)
  self.stateUI = binder:BindComponent(PVPBattleRoleStateUI(self.ui.uiNode, self.battleRole, self.intentNode))
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  binder:BindEvent(EventMgr.Instance.PVPAwakerSelect, System.fn(self, self.OnPVPAwakerSelect))
end

function PVPBattleRoleBloodUI:OnUnbind()
  Super.OnUnbind(self)
  self:StopHpTween()
  if self.energyTw then
    self.energyTw:Kill()
    self.energyTw = nil
  end
  if bg.battleRender then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function PVPBattleRoleBloodUI:OnPVPAwakerSelect(uidMap)
  local fgCanvas = self.ui.uiNode:GetComponent(TypeCanvas)
  if not fgCanvas then
    return
  end
  local roleRoot = self.battleRole.statusUI and self.battleRole.statusUI.uiRoot
  if uidMap and uidMap[self.roleUid] then
    fgCanvas.overrideSorting = true
    fgCanvas.sortingLayerName = "Actor"
    fgCanvas.sortingOrder = 0
    if roleRoot then
      roleRoot.transform:SetAsLastSibling()
    end
    self.binder:SetCanvasGroupBlocksRaycasts(self.ui.uiNode, false)
  else
    fgCanvas.overrideSorting = false
    self.binder:SetCanvasGroupBlocksRaycasts(self.ui.uiNode, true)
  end
end

function PVPBattleRoleBloodUI:SetActive(isActive)
  self.ui.uiNode:SetActive(isActive)
end

function PVPBattleRoleBloodUI:BindToDead(binder)
  self.ui.Blood_Ash:SetActive(false)
  binder:BindToRaw(function(_, dead, _)
    self.ui.Blood_Ash:SetActive(dead)
  end, function()
    return self.battleRole.dead.value
  end)
end

function PVPBattleRoleBloodUI:OnBindHp(binder)
  self.ui.Image_D_Our:SetActive(not self.isEnemy)
  self.ui.Image_D_Enemy:SetActive(self.isEnemy)
  local bloodUI = self.isEnemy and self.ui.Image_D_Enemy or self.ui.Image_D_Our
  binder:BindToRaw(function(childBinder, hpPercent, preHpPercent)
    self:PlayHP(bloodUI, childBinder, hpPercent, preHpPercent)
  end, System.fn(self, self.GetHpAndBlockPercent))
  binder:BindToText(self.ui.Text_Blood, function()
    local hp = self.roleData:GetProperty(bc.RoleProperty.hp) or 0
    local block = self.roleData:GetProperty(bc.RoleProperty.block) or 0
    return hp + block
  end)
end

function PVPBattleRoleBloodUI:GetHpAndBlockPercent()
  local hp = self.roleData:GetProperty(bc.RoleProperty.hp)
  local maxHp = self.roleData:GetProperty(bc.RoleProperty.max_hp) or 0
  if 0 == maxHp then
    return 0, 0
  end
  local block = self.roleData:GetProperty(bc.RoleProperty.block)
  local denominator = math.max(maxHp, block + hp)
  local hpPer = hp / denominator
  local blockPer = (hp + block) / denominator
  return hpPer, blockPer
end

function PVPBattleRoleBloodUI:GetBarFillPosX(percent)
  return (percent - 0.5) * BLOOD_SIZE
end

function PVPBattleRoleBloodUI:PlayHP(bloodUI, _, hpPercent, _)
  self:StopHpTween()
  local posX = self:GetBarFillPosX(hpPercent)
  self.bloodTw = bloodUI.transform:DOLocalMoveX(posX, 0.3)
  local delayUI = self.ui.Image_D_BloodDelay
  delayUI:SetActive(true)
  self.delayTw = delayUI.transform:DOLocalMoveX(posX, 1.2):SetDelay(0.3):OnComplete(function()
    delayUI:SetActive(false)
  end)
end

function PVPBattleRoleBloodUI:StopHpTween()
  if self.bloodTw then
    self.bloodTw:Kill(false)
  end
  if self.delayTw then
    self.delayTw:Kill(false)
  end
  self.bloodTw = nil
  self.delayTw = nil
end

function PVPBattleRoleBloodUI:OnChangeBoutPhase(data)
  self:UpdateUltiSkillEffect()
end

function PVPBattleRoleBloodUI:UpdateUltiSkillEffect()
  if bg.isPVP then
    local isUltiSkillReady = self:IsUltiSkillReady()
    local isMyBout = bg.battleDataCenter.boutData.camp == bg.battleDataCenter:GetMyCamp()
    self.ui.UI_Pvp_Vx_UltiSkil01:SetActive(isUltiSkillReady and isMyBout and not self.isEnemy)
    self.ui.UI_Pvp_Vx_UltiSkill02:SetActive(isUltiSkillReady and isMyBout and not self.isEnemy)
  end
end

function PVPBattleRoleBloodUI:OnBindRoleEnergy(binder)
  binder:BindToRaw(function(_, percent)
    self.energyTw = self.ui.Image_D_Maniac.transform:DOLocalMoveX(self:GetBarFillPosX(percent), 0.3)
  end, function()
    do return self.GetRoleEnergyPercent end
    return self.GetRoleEnergyPercent, self
  end)
  binder:BindToText(self.ui.Text_Numerical, function()
    return self.roleData:GetProperty(bc.AwakerProperty.ulti_energy) or 0
  end)
  if self.isEnemy then
    self.ui.Text_Numerical:SetActive(true)
    self.ui.Text_C_Release:SetActive(false)
    self.ui.UI_Pvp_Vx_UltiSkil01:SetActive(false)
    self.ui.UI_Pvp_Vx_UltiSkill02:SetActive(false)
  else
    binder:BindToVisible(self.ui.Text_Numerical, function()
      return not self:IsUltiSkillReady()
    end)
    binder:BindToRaw(function(_, value, oldVal)
      if false == oldVal and true == value then
        BattleVoiceController.Instance:OnPvpVoiceSkillReady(self.roleData.tid, self.battleRole.camp)
      end
      self.ui.Text_C_Release:SetActive(value)
      self:UpdateUltiSkillEffect()
    end, function()
      do return self.IsUltiSkillReady end
      return self.IsUltiSkillReady, self
    end)
  end
  binder:BindButtonClick(self.ui.Btn_Click_Ulti, function()
    self:OnClickUlti()
  end)
  if bg.battleDataCenter:IsMyCamp(self.battleRole.camp) then
    local maxRoleCount = 4
    local uName = "KeyBurst" .. maxRoleCount - self.battleRole.battleFieldPos + 1
    binder:BindComponent(ShortCutComp(self.ui.Text_UltiShortCut, uName, function()
      self:OnClickUlti()
    end))
  end
end

function PVPBattleRoleBloodUI:IsUltiSkillReady()
  local BP = bc.BattleProperty
  local coma = self.roleData:GetProperty(BP.PVPComa)
  local immueComa = self.roleData:GetProperty(BP.PVPImmue_Coma)
  local isInComa = coma and coma > 0 and (not immueComa or 0 == immueComa)
  local isEnergyEnough = self:GetRoleEnergyPercent() >= 1
  local isNotDead = not self.roleData:IsDead()
  return isEnergyEnough and not isInComa and isNotDead
end

function PVPBattleRoleBloodUI:OnClickUlti()
  if not self:IsUltiSkillReady() then
    return
  end
  if bg.battleRender:IsInSelectCard() then
    return
  end
  if bg.isReplay then
    self.stateUI:ShowStateList()
    return
  end
  if self.isEnemy then
    self.stateUI:ShowStateList()
    return
  end
  if self:GetRoleEnergyPercent() < 1 or self.roleData:IsDead() or not bg.battleDataCenter:IsMyActionCamp() then
    self.stateUI:ShowStateList()
    return
  end
  bg.ultiSkillAwakerTid = self.roleData.tid
  BattleVoiceModel.Instance:ResetPvpPlayerThinking()
  local cmdTargetMode = bg.battleRender.cmdTargetMgr and bg.battleRender.cmdTargetMgr:GetModel() or bc.PVPTargetModel.Server
  local sendData = {
    roleUid = self.roleData.uid,
    awakerUid = self.roleData.uid,
    playerId = bg.battleDataCenter:GetPlayerIdByCamp(self.roleData.camp)
  }
  if cmdTargetMode == bc.PVPTargetModel.Server then
    bg.battleRender:SendCommand(BattleCommand.lg_UseUltiSkill, sendData)
  elseif cmdTargetMode == bc.PVPTargetModel.Client then
    bg.battleRender.cmdTargetMgr:OnParseCommond(BattleCommand.lg_UseUltiSkill, sendData)
  end
end

function PVPBattleRoleBloodUI:GetRoleEnergyPercent()
  local ulti_energy = self.roleData:GetProperty(bc.AwakerProperty.ulti_energy)
  local ulti_energy_max = self.roleData:GetProperty(bc.AwakerProperty.ulti_energy_max)
  if ulti_energy and ulti_energy_max and 0 ~= ulti_energy_max then
    return ulti_energy / ulti_energy_max
  end
  return 0
end

function PVPBattleRoleBloodUI:HideBlockEffect()
  self.ui.UI_Vx_Battle_Defense_Appear01_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Hit01_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die01_Right:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Appear01:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Hit01:SetActive(false)
  self.ui.UI_Vx_Battle_Defense_Die01:SetActive(false)
end

function PVPBattleRoleBloodUI:OnBindDecorate(binder)
  binder:BindToRaw(function(childBinder, camp)
    local isCamp1 = camp == bc.BattleCamp.Camp1
    local isCamp2 = camp == bc.BattleCamp.Camp2
    local isBoss = self:IsBossOrElite()
    self.ui.Boss_Blood_Decorate:SetActive(isBoss)
    self.ui.Boss_Shield_Decorate:SetActive(isBoss)
    childBinder:BindToRaw(function(_, isHaveBlock)
      self.ui.Boss_Shield:SetActive(isHaveBlock and isBoss)
      self.ui.Group_Shield_Right:SetActive(isHaveBlock and isCamp1)
      self.ui.Group_Shield_Anim_Right:SetActive(isHaveBlock and isCamp1)
      self.ui.Group_Shield:SetActive(isHaveBlock and isCamp2 and not isBoss)
      self.ui.Group_Shield_Anim:SetActive(isHaveBlock and isCamp2 and not isBoss)
    end, function()
      local block = self.roleData:GetProperty(bc.RoleProperty.block) or 0
      return block > 0
    end)
  end, function()
    return self.roleData.camp
  end)
end

function PVPBattleRoleBloodUI:IsBossOrElite()
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    local config = self.battleRole.awakerList[1].configData
    return config.MonsterClass == bc.MonsterClass.Boss or config.MonsterClass == bc.MonsterClass.Elite
  end
  return false
end

function PVPBattleRoleBloodUI:OnBindBlock(binder)
  binder:BindToRaw(function(_, blockPer, _)
    self.ui.Image_D_Shilds:SetActive(blockPer and blockPer > 0)
    self.ui.Image_D_Shilds.transform:DOLocalMoveX(self:GetBarFillPosX(blockPer), 0)
  end, function()
    local _, blockPer = self:GetHpAndBlockPercent()
    return blockPer
  end)
end

function PVPBattleRoleBloodUI:OnBindRoleName(binder)
  self.ui.Text_Monster_Name:SetActive(self.battleRole.camp == bc.BattleCamp.Camp2)
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    binder:SetText(self.ui.Text_Monster_Name, LT.Text(bg.battleDataCenter:GetRoleName(self.battleRole.uid, false)))
  end
end

function PVPBattleRoleBloodUI:OnBindUnSelect(binder)
  binder:BindToRaw(function(_, visible)
    local canvasGroup = self.ui.uiNode:GetComponent(CanvasGroup)
    if canvasGroup then
      if visible then
        canvasGroup.alpha = 1
      else
        canvasGroup.alpha = 0
      end
    end
  end, function()
    local notSelected = 0 == self.roleData:GetProperty(bc.RoleProperty.not_select)
    return notSelected
  end)
end

function PVPBattleRoleBloodUI:OnBindScarletBlood(binder)
  local isShowBloodDrop = self.roleData:IsShowBloodDrop()
  self.ui.Content_Blood_Drop:SetActive(isShowBloodDrop)
  if not isShowBloodDrop then
    return
  end
  binder:BindNewComponent(self.ui.Content_Blood_Drop, UIBloodDrop, UI_Battle_Blood_DropResource, self.battleRole, self.roleData)
end

function PVPBattleRoleBloodUI:OnBindPosition(binder)
  binder:SetImage(self.ui.Image_Icon_1, self:_GetRolePositionIcon())
end

function PVPBattleRoleBloodUI:_GetRolePositionIcon()
  if not bg.isPVP or self.roleData:IsMonster() then
    return
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(self.roleData.tid)
  local posTid = awakerConfig and awakerConfig.PVPPosition
  local posConfig = posTid and bg.DT.PVPPosition[posTid]
  return posConfig and posConfig.BloodBarPositionIcon
end

function PVPBattleRoleBloodUI:RefreshDimensionCards(dimensionCards)
  local rechargeNum = 0
  dimensionCards = dimensionCards or {}
  for i = 1, #self.dimensionSlots do
    local card = dimensionCards[i]
    if card and card.configData.AwakerID then
      rechargeNum = rechargeNum + 1
    end
    local item = self.dimensionSlots[i]
    item:SetCard(card)
  end
  self.dimensionProgress.value = rechargeNum
end

function PVPBattleRoleBloodUI:PlayDimentionGrowOpen()
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    return
  end
  self.ui.UI_Vx_Battle_Chaowei_HeadGlowTop:SetActive(true)
  self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase:SetActive(true)
  self.ui.UI_Vx_Battle_Chaowei_HeadGlowTop.transform:SetAsLastSibling()
  local growTopAnimControl = self.ui.UI_Vx_Battle_Chaowei_HeadGlowTop:GetComponent(typeof(UIAnimationController))
  local gropBottleAnimControl = self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase:GetComponent(typeof(UIAnimationController))
  growTopAnimControl:PlayState("UI_Vx_Battle_Chaowei_HeadGlowTop_Open")
  gropBottleAnimControl:PlayState("UI_Vx_Battle_Chaowei_HeadGlowBase_Open")
end

function PVPBattleRoleBloodUI:PlayDimentionGrowClose()
  if self.battleRole.camp == bc.BattleCamp.Camp2 then
    return
  end
  if self.ui.UI_Vx_Battle_Chaowei_HeadGlowTop.activeInHierarchy then
    local growTopAnimControl = self.ui.UI_Vx_Battle_Chaowei_HeadGlowTop:GetComponent(typeof(UIAnimationController))
    growTopAnimControl:PlayState("UI_Vx_Battle_Chaowei_HeadGlowTop_Close", function()
      self.ui.UI_Vx_Battle_Chaowei_HeadGlowTop:SetActive(false)
    end)
  end
  if self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase.activeInHierarchy then
    local gropBottleAnimControl = self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase:GetComponent(typeof(UIAnimationController))
    gropBottleAnimControl:PlayState("UI_Vx_Battle_Chaowei_HeadGlowBase_Close", function()
      self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase:SetActive(false)
    end)
  end
end

return PVPBattleRoleBloodUI
