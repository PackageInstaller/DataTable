_class("UIN25VampireTalentTreeItem", UICustomWidget)
UIN25VampireTalentTreeItem = UIN25VampireTalentTreeItem

function UIN25VampireTalentTreeItem:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
  self.selectSkillId = 0
  self.animName = "uieffanim_UIN25VampireTalentTreeItem_in"
  self.unlockAnimName = "uieffanim_UIN25VampireTalentTreeItem_out"
  self.isLocked = nil
end

function UIN25VampireTalentTreeItem:OnShow(uiParams)
  self.anim = self:GetUIComponent("Animation", "UIN25VampireTalentTreeItem")
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  self.goCost = self:GetGameObject("cost")
  self.poolCost = self:GetUIComponent("UISelectObjectPath", "cost")
  self.imgCostBg = self:GetUIComponent("Image", "imgCostBg")
  self.skill = self:GetUIComponent("UISelectObjectPath", "skill")
  self.relic = self:GetUIComponent("UISelectObjectPath", "relic")
  self.lock = self:GetGameObject("lock")
  self.guideRoot = self:GetGameObject("Root")
  self.guideSkill = self:GetGameObject("skill")
  self.gudieRelic = self:GetGameObject("relic")
  self.eff = self:GetGameObject("eff")
  self:AttachEvent(GameEventType.N25VampireSelectTalentSkill, self.N25VampireSelectTalentSkill)
end

function UIN25VampireTalentTreeItem:OnHide()
  self:DetachEvent(GameEventType.N25VampireSelectTalentSkill, self.N25VampireSelectTalentSkill)
end

function UIN25VampireTalentTreeItem:Flush(id, callback)
  self.id = id
  self.callback = callback
  local tier = self.data:GetTierById(id)
  if tier.unlockTalent > 0 then
    self.goCost:SetActive(true)
    local uiTextCost = self.poolCost:SpawnObject("UIN25VampireTalentText")
    uiTextCost:Flush(tier.unlockTalent, "num_point")
    self.imgCostBg:CrossFadeAlpha(0.4, 0, false)
  else
    self.goCost:SetActive(false)
    self.imgCostBg:CrossFadeAlpha(1, 0, false)
  end
  local len = table.count(tier.skills)
  self.skill:SpawnObjects("UIN25VampireTalentSkillItem", len)
  local uis = self.skill:GetAllSpawnList()
  for i, skill in pairs(tier.skills) do
    local ui = uis[i]
    ui:Flush(skill, function()
      self:Move2Center(tier.id)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N25VampireSelectTalentSkill, self.id, skill.skillId)
      self:ShowDialog("UIN25VampireTalentSkillTips", skill.skillId)
    end)
  end
  if tier.relic then
    local uiRelic = self.relic:SpawnObject("UIN25VampireTalentRelicItem")
    uiRelic:Flush(tier.relic, function()
      self:Move2Center(tier.id)
      self:ShowDialog("UIN25VampireTalentItemTips", tier.relic)
    end)
  end
  if self.isLocked == nil then
    self.isLocked = tier:IsLock()
    self.lock:SetActive(self.isLocked)
    self.eff:SetActive(not self.isLocked)
  else
    local toState = tier:IsLock()
    if self.isLocked and not toState then
      self.isLocked = toState
      self.lock:SetActive(true)
      self.anim:Play(self.unlockAnimName)
      self.eff:SetActive(true)
    elseif not self.isLocked and toState then
      self.isLocked = toState
      self.lock:SetActive(true)
      self:ResetUnlockAnimation()
      self.eff:SetActive(false)
    end
  end
end

function UIN25VampireTalentTreeItem:Move2Center(tierId)
  local uiName = "UIN25VampireTalentTree"
  if GameGlobal.UIStateManager():IsShow(uiName) then
    GameGlobal.UIStateManager():CallUIMethod(uiName, "Move2Center", tierId)
  end
end

function UIN25VampireTalentTreeItem:N25VampireSelectTalentSkill(tierId, skillId)
  local uis = self.skill:GetAllSpawnList()
  for _, uiv in ipairs(uis) do
    if tierId == self.id then
      if skillId == uiv:SkillId() then
        uiv:Select(true)
      else
        uiv:Select(false)
      end
    else
      uiv:Select(false)
    end
  end
end

function UIN25VampireTalentTreeItem:Id()
  return self.id
end

function UIN25VampireTalentTreeItem:RectTransform()
  return self.rt
end

function UIN25VampireTalentTreeItem:RootOnClick(go)
  if self.callback then
    self.callback()
  end
end

function UIN25VampireTalentTreeItem:PlayAnimation()
  self.anim:Play(self.animName)
  local uis = self.skill:GetAllSpawnList()
  for _, uiv in ipairs(uis) do
    uiv:FlushTier()
  end
end

function UIN25VampireTalentTreeItem:ResetUnlockAnimation()
  self.anim:Play(self.unlockAnimName)
  self.anim:Rewind()
  self.anim:Sample()
  self.anim:Stop()
end
