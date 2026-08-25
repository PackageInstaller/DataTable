local CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local Animator = CS.UnityEngine.Animator
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local IntentionDisappearStateHash = Animator.StringToHash("Base Layer.UA_Battle_Intention_xiaoshi")
local BattleRoleIntentionUI, Super = System.NewComponent("BattleRoleIntentionUI")

function BattleRoleIntentionUI:ctor(uiNode, battleRole)
  Super.ctor(self)
  self.ui = UI_Battle_Item_IntentionResource(uiNode)
  self.intentionAnimator = uiNode:GetComponentInChildren(typeof(Animator))
  uiNode.transform:SetAsFirstSibling()
  self.battleRole = battleRole
  self.roleUid = battleRole.uid
  self.roleData = bg.battleDataCenter:GetRoleDataModel(self.roleUid)
  self.intentTip = nil
  self.intentionInfo = nil
end

function BattleRoleIntentionUI:OnBind(binder)
  self.binder = binder
  self.ui.uiNode:SetActive(false)
  self:OnBindIntention(binder, self.battleRole)
  self:OnBindTentacle(binder)
  binder:BindButtonClick(self.ui.Btn_Intention, function()
    local effectDescGroup = bg.battleDataCenter.stateData:GetRoleShowStateEffectDescGroup(self.roleUid, true)
    UIManager.Instance:Show(Urls.MonsterBuffListPanel, self.battleRole, effectDescGroup)
  end)
end

function BattleRoleIntentionUI:OnBindIntention(binder)
  binder:BindToRaw(function()
    local intentionInfo = self.roleData.intentionInfo or {}
    local blind = bg.battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.blind)
    if blind and blind > 0 then
      self:SetIntention(false)
      return
    end
    if intentionInfo.intention ~= nil then
      self:SetIntention(true, intentionInfo)
    elseif intentionInfo.intention == nil then
      self:SetIntention(false)
    end
  end, function()
    local info = self.roleData.intentionInfo or {}
    local uniqKey = string.format("%s%s%s%s", info.intention, info.totalDamage, info.damageStr, info.testNil)
    return uniqKey
  end)
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
  binder:BindToRaw(function(_, isUIVisible)
    if self._isNeedPlayIntentionAnim then
      self:PlayIntentionAnim()
    end
  end, function()
    return bg.battlePanel and bg.battlePanel:GetUIVisible()
  end)
end

function BattleRoleIntentionUI:OnBindTentacle(binder)
  if self.roleData.camp == bc.BattleCamp.Camp2 then
    binder:BindNewComponent(self.ui.uiNode, BattleBossTentacleUI, Func_Battle_Boss_ChuwanResource, self.battleRole, self.roleData)
    self:OnBindTentaclePos(binder)
  end
end

function BattleRoleIntentionUI:OnBindTentaclePos(binder)
  if self:IsSaintBabyBoss() then
    return
  end
  binder:BindToRaw(function(_, tentacleMaxCount)
    local uiTf = self.ui.uiNode.transform
    if 0 == tentacleMaxCount then
      uiTf.anchoredPosition = Vector2(-6, 0)
      uiTf.localScale = Vector3(1, 1, 1)
    else
      uiTf.anchoredPosition = Vector2(-82, 0)
      uiTf.localScale = Vector3(0.8, 0.8, 1)
    end
  end, function()
    do return self.roleData.GetTentacleMaxCount end
    return self.roleData.GetTentacleMaxCount, self.roleData
  end)
end

function BattleRoleIntentionUI:IsSaintBabyBoss()
  local tid = self.roleData.tid
  local monsterCfg = bg.DT.MonsterConfig[tid]
  return monsterCfg and monsterCfg.AnimationID == 35134
end

function BattleRoleIntentionUI:SetIntention(visible, intentionInfo)
  self.intentionVisible = visible
  self.intentionInfo = intentionInfo
  if visible then
    if intentionInfo.intentionIcon then
      self.binder:SetImage(self.ui.Image_Intention_Icon, intentionInfo.intentionIcon)
    end
    if bg.battlePanel and bg.battlePanel:GetUIVisible() then
      self:PlayIntentionAnim()
    else
      self._isNeedPlayIntentionAnim = true
    end
    local skill = DT.Skill[intentionInfo.intention]
    if skill then
      local tid = self.battleRole.tid
      local monster = DT.MonsterConfig[tid]
      local awaker = self.roleData:GetAwaker(skill.AwakerID)
      local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(awaker)
      local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(awaker)
      local skillName = BattleSkillUtils.GetSkillName(skill, breakSkillLevel, potencyLevel)
      self.binder:SetText(self.ui.Text_Intention_Number, intentionInfo.damageStr)
      if monster and monster.IsHide then
        self.binder:SetText(self.ui.Text_Intention_Type, "")
      else
        self.binder:SetText(self.ui.Text_Intention_Type, skillName)
      end
      if bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
        self.ui.uiNode:SetActive(true)
      else
        AnimatorUtils.PlayState(self.intentionAnimator, "Base Layer.UA_Battle_Intention_chuxian")
      end
    else
      Logger.Warn("BattleRoleIntentionUI:SetIntention skill is nil, skillId = " .. intentionInfo.intention)
    end
  elseif bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim() then
    self.ui.uiNode:SetActive(false)
  else
    AnimatorUtils.PlayState(self.intentionAnimator, "Base Layer.UA_Battle_Intention_xiaoshi")
  end
end

function BattleRoleIntentionUI:PlayIntentionAnim()
  self._isNeedPlayIntentionAnim = false
  self.ui.uiNode:SetActive(true)
  local behavior = self.intentionAnimator:GetAnimatorStateBehavior()
  if behavior then
    behavior:onStateComplete("+", function(hash)
      if hash == IntentionDisappearStateHash then
        self.ui.uiNode:SetActive(self.intentionVisible)
      end
    end)
  end
end

function BattleRoleIntentionUI:SetActiveWithIntention(isActive)
  if self.uiTween then
    self.uiTween:Kill()
  end
  local time = 0.4
  local resultValue = isActive and 1 or 0
  self.uiTween = self.binder:DotweenProcessAlpha(self.ui.uiNode, resultValue, time)
  self.uiTween:OnComplete(function()
    self.uiTween = nil
  end)
end

return BattleRoleIntentionUI
