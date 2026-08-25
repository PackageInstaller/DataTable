local typeof = _ENV.typeof
local Vector2 = CS.UnityEngine.Vector2
local UIAnimationController = CS.Z1Client.UIAnimationController
local BattleDimensionUI, Super = System.NewComponent("BattleDimensionUI")

function BattleDimensionUI:ctor(ui, battleRole)
  Super.ctor(self)
  self.ui = ui
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
end

function BattleDimensionUI:OnBind(binder)
  self.binder = binder
  self:OnBindDimensionCard(binder)
  self:OnBindBlackHoleBtn(binder)
end

function BattleDimensionUI:OnUnbind()
  Super.OnUnbind(self)
  if bg.battleRender then
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
  end
end

function BattleDimensionUI:OnBindDimensionCard(binder)
  self.dimensionSlots = {}
  self.dimensionProgress = Vue.ref(0)
  binder:BindToRaw(function(_, dimensionSlotNum, _)
    local max = math.max(dimensionSlotNum, #self.dimensionSlots)
    bg.battleRender.cardMgr:CheckDimensionCardMax()
    for i = 1, max do
      if i <= dimensionSlotNum then
        if self.dimensionSlots[i] == nil then
          local item = binder:BindNewComponent(self.ui.Content_Chaowei, DimensionCardStatusUIItem, Item_Battle_Chaowei_FeatureResource, self.roleData:IsPVEPlayerCamp(), self.roleData:IsMonster())
          self.dimensionSlots[i] = item
        end
      elseif self.dimensionSlots[i] ~= nil then
        self.dimensionSlots[i].binder:teardown()
        self.dimensionSlots[i] = nil
      end
    end
    local dimensionCards = bg.battleRender.cardMgr:GetCardListByDeck(bc.CardDeck.DimensionDeck)
    self:RefreshDimensionCards(dimensionCards)
    self:SetDimensionSlotPos()
  end, function()
    if self.roleData:IsPVEPlayerCamp() then
      do return self.roleData.GetProperty, self.roleData end
      return self.roleData.GetProperty, self.roleData, bc.RoleProperty.dimension_slot
    else
      do return self.roleData.GetProperty, self.roleData end
      return self.roleData.GetProperty, self.roleData, bc.RoleProperty.monster_dimension_slot
    end
  end)
  binder:BindToRaw(function(_, _, _)
    local deck = bc.CardDeck.DimensionDeck
    if not self.roleData:IsPVEPlayerCamp() then
      deck = bc.CardDeck.MonsterDimensionDeck
    end
    local dimensionCards = bg.battleRender.cardMgr:GetCardListByDeck(deck)
    self:RefreshDimensionCards(dimensionCards)
  end, function()
    do return bg.battleDataCenter.GetCardDimensionStep end
    return bg.battleDataCenter.GetCardDimensionStep, bg.battleDataCenter
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if 0 ~= nVal and nVal == #self.dimensionSlots then
      self:PlayDimentionGrowOpen()
    end
    if not oVal then
      return
    end
    if oVal < nVal then
      self.dimensionSlots[nVal]:PlayAnimSlotRecharge()
    end
  end, function()
    return self.dimensionProgress.value
  end)
  binder:BindEvent(EventMgr.Instance.DimensionBoutEnd, System.fn(self, self.PlayDimentionGrowClose))
end

function BattleDimensionUI:OnBindBlackHoleBtn(binder)
  if not self.roleData:IsPVEPlayerCamp() then
    return
  end
  binder:BindButtonClick(self.ui.Btn_ChaoWei_BlackHole, System.fn(self, self.OnBtnBlackHole))
  binder:BindToVisible(self.ui.Image_BlackHoleHigh, System.fn(self, self.IsShowBlackHoleHigh))
  binder:BindToVisible(self.ui.Btn_ChaoWei_BlackHole, function()
    return self.roleData:GetProperty(bc.RoleProperty.dimension_slot) > 0
  end)
  local isMix = bg.battleDataCenter:IsMixSchoolExChoas()
  local uName = isMix and "KeySchoolUse2" or "KeySchoolUse"
  binder:BindComponent(ShortCutComp(self.ui.Text_ChaoweiShortCut, uName, function()
    self:OnBtnBlackHole()
  end))
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
end

function BattleDimensionUI:OnBtnBlackHole()
  if BattleSkillUtils.IsDimensionSchoolSkillInCd() then
    Alert.ShowStr(LT.Textf("DimensionAbilityCoolDown", self.roleData:GetDimensionAbilityCd()))
    return
  end
  local isOk, tipsId = self:IsCanUseBlackHole()
  if not isOk and tipsId then
    Alert.Show(tipsId)
    return
  end
  UIManager.Instance:Reopen(Urls.BattleDimensionSkillUsePanel, function()
    self:UseDimensionSkill()
  end)
end

function BattleDimensionUI:UseDimensionSkill()
  bg.battleRender:SendCommand(BattleCommand.lg_UseDimensionSkill, {})
end

function BattleDimensionUI:OnCommandResult(msgData)
  if msgData.msgId == BattleCommand.lg_UseDimensionSkill and msgData.ret == true then
    self:PlayDimentionCardDestroy()
  end
end

function BattleDimensionUI:IsCanUseBlackHole()
  if not bg.battleDataCenter:IsMyActionCamp() then
    return
  end
  local playRole = bg.battleDataCenter:GetPlayerRoleDataModel()
  local usedTime = playRole:GetProperty(bc.BattleProperty.bout_dskill_use_times) or 0
  local dimensionCards = bg.battleRender.cardMgr:GetCardListByDeck(bc.CardDeck.DimensionDeck)
  local _ = bg.battleDataCenter:GetCardDimensionStep()
  local tipsId
  if 0 == #dimensionCards then
    tipsId = 10912
    return false, tipsId
  end
  if usedTime >= 1 then
    tipsId = 10913
    return false, tipsId
  end
  local cmdParser = BattleCmdParserClient({})
  local cond = DT.BattleApi.DimensionAbilityCond.Data
  local ret = cmdParser:GetValueByCmd(cond)
  if true ~= ret then
    return false
  end
  return true
end

function BattleDimensionUI:IsShowBlackHoleHigh()
  local playRole = bg.battleDataCenter:GetPlayerRoleDataModel()
  local usedTime = playRole:GetProperty(bc.BattleProperty.bout_dskill_use_times) or 0
  local dimensionCards = bg.battleRender.cardMgr:GetCardListByDeck(bc.CardDeck.DimensionDeck)
  local _ = bg.battleDataCenter:GetCardDimensionStep()
  if 0 == #dimensionCards then
    return false
  end
  if usedTime >= 1 then
    return false
  end
  if BattleSkillUtils.IsDimensionSchoolSkillInCd() then
    return false
  end
  return true
end

function BattleDimensionUI:SetDimensionSlotPos()
  local dimensionSlotNum = #(self.dimensionSlots or {})
  if not self.roleData:IsPVEPlayerCamp() then
    return
  end
  local tf = self.ui.Content_Chaowei.transform
  local isMix = bg.battleDataCenter:IsMixSchoolExChoas()
  local posY = 0
  if isMix then
    tf.localScale = CS.UnityEngine.Vector3(0.8, 0.8, 1)
    posY = -60
  end
  if dimensionSlotNum <= 5 then
    tf.anchoredPosition = Vector2(-195, posY)
  elseif 6 == dimensionSlotNum then
    tf.anchoredPosition = Vector2(-248, posY)
  else
    tf.anchoredPosition = Vector2(-269, posY)
  end
end

function BattleDimensionUI:RefreshDimensionCards(dimensionCards)
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

function BattleDimensionUI:PlayDimentionGrowOpen()
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

function BattleDimensionUI:PlayDimentionGrowClose()
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

function BattleDimensionUI:PlayDimentionCardDestroy()
  self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase:SetActive(true)
  local gropBottleAnimControl = self.ui.UI_Vx_Battle_Chaowei_HeadGlowBase:GetComponent(typeof(UIAnimationController))
  gropBottleAnimControl:PlayState("UI_Vx_Battle_Chaowei_HeadGlowBase_Carddestroy")
end

return BattleDimensionUI
