_class("UIN28AVGStoryInfluenceItem", UICustomWidget)
UIN28AVGStoryInfluenceItem = UIN28AVGStoryInfluenceItem

function UIN28AVGStoryInfluenceItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
  self.animNames = {
    "uieff_UIN28AVGStoryInfluenceItem_noInfluence_in",
    "uieff_UIN28AVGStoryInfluenceItem_noInfluence_loop1",
    "uieff_UIN28AVGStoryInfluenceItem_noInfluence_loop2",
    "uieff_UIN28AVGStoryInfluenceItem_noInfluence_loop3",
    "uieff_UIN28AVGStoryInfluenceItem_noInfluence_out",
    "uieff_UIN28AVGStoryInfluenceItem_notTry_in",
    "uieff_UIN28AVGStoryInfluenceItem_notTry_loop1",
    "uieff_UIN28AVGStoryInfluenceItem_notTry_loop2",
    "uieff_UIN28AVGStoryInfluenceItem_notTry_loop3",
    "uieff_UIN28AVGStoryInfluenceItem_notTry_out",
    "uieff_UIN28AVGStoryInfluenceItem_isInfluence_in",
    "uieff_UIN28AVGStoryInfluenceItem_isInfluence_loop1",
    "uieff_UIN28AVGStoryInfluenceItem_isInfluence_loop2",
    "uieff_UIN28AVGStoryInfluenceItem_isInfluence_loop3",
    "uieff_UIN28AVGStoryInfluenceItem_isInfluence_out"
  }
  self.taskId = 0
end

function UIN28AVGStoryInfluenceItem:OnShow()
  self.anim = self:GetUIComponent("Animation", "root")
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Center(self.rt)
  self.noInfluence = self:GetGameObject("noInfluence")
  self.notTry = self:GetGameObject("notTry")
  self.isInfluence = self:GetGameObject("isInfluence")
  self.rtNoInfluence = self:GetUIComponent("RectTransform", "noInfluence")
  self.rtNotTry = self:GetUIComponent("RectTransform", "notTry")
  self.rtIsInfluence = self:GetUIComponent("RectTransform", "isInfluence")
  self.txtInfluence = self:GetUIComponent("UILocalizationText", "txtInfluence")
  self.poolLeader = self:GetUIComponent("UISelectObjectPath", "leader")
  self.poolPatners = self:GetUIComponent("UISelectObjectPath", "patners")
  self.goLeader = self:GetGameObject("leader")
  self.patners = self:GetGameObject("patners")
end

function UIN28AVGStoryInfluenceItem:OnHide()
  self.anim = nil
  self.taskId = 0
  self.option = nil
end

function UIN28AVGStoryInfluenceItem:Flush(option)
  self.option = option
  self:FlushInfluence()
  self:FlushPos()
end

function UIN28AVGStoryInfluenceItem:FlushPos()
  self.rt.anchoredPosition = self.data.optionPos[self.option.index] or Vector2.zero
end

function UIN28AVGStoryInfluenceItem:FlushInfluence()
  if self.option:IsSelected() then
    if self.option:IsInfluential() then
      if self.option:IsInfluentialLeader() then
        self.goLeader:SetActive(true)
        local leader = self.poolLeader:SpawnObject("UIN28AVGActorValueChange")
        leader:Flush(0, self.option.influenceLeader)
      else
        self.goLeader:SetActive(false)
      end
      if self.option:IsInfluentialPartners() then
        self.patners:SetActive(true)
        local lst = {}
        for index, actor in ipairs(self.data.actorPartners) do
          if self.option:IsInfluentialPartner(index) then
            table.insert(lst, index)
          end
        end
        local len = table.count(lst)
        self.poolPatners:SpawnObjects("UIN28AVGActorValueChange", len)
        local uis = self.poolPatners:GetAllSpawnList()
        for i, ui in ipairs(uis) do
          local index = lst[i]
          ui:Flush(index, self.option.influencePartners[index])
        end
      else
        self.patners:SetActive(false)
      end
      self.txtInfluence:SetText("")
    elseif string.isnullorempty(self.option.influence) then
    else
      self.txtInfluence:SetText(self.option.influence)
    end
  else
  end
end

function UIN28AVGStoryInfluenceItem:ResetRectTransform()
  self.rtNoInfluence.anchoredPosition = Vector2.zero
  self.rtNotTry.anchoredPosition = Vector2.zero
  self.rtIsInfluence.anchoredPosition = Vector2.zero
end

function UIN28AVGStoryInfluenceItem:GetState()
  if not self.option then
    return
  end
  local state = 0
  if self.option:IsSelected() then
    if self.option:IsInfluential() then
      state = 11
    elseif string.isnullorempty(self.option.influence) then
      state = 1
    else
      state = 11
    end
  else
    state = 6
  end
  self.noInfluence:SetActive(state == 1)
  self.notTry:SetActive(state == 6)
  self.isInfluence:SetActive(state == 11)
  return state
end

function UIN28AVGStoryInfluenceItem:PlayAnimIn()
  if not self.anim then
    return
  end
  self:ResetRectTransform()
  if self.taskId > 0 then
    GameGlobal.TaskManager():KillTask(self.taskId)
  end
  self.taskId = self:StartTask(function(TT)
    local state = self:GetState()
    local animName = self.animNames[state]
    self:ResetAnim()
    self.anim:Play(animName)
    YIELD(TT, 833)
    self.taskId = 0
    self:PlayAnimLoop()
  end, self)
end

function UIN28AVGStoryInfluenceItem:PlayAnimLoop()
  if not self.anim then
    return
  end
  local offset = math.random(1, 3)
  local state = self:GetState() + offset
  local animName = self.animNames[state]
  self:ResetAnim()
  self.anim:Play(animName)
end

function UIN28AVGStoryInfluenceItem:PlayAnimOut()
  if not self.anim then
    return
  end
  local state = self:GetState() + 4
  self:ResetAnim()
  self.anim:Play(self.animNames[state])
end

function UIN28AVGStoryInfluenceItem:ResetAnim()
  if not self.anim then
    return
  end
  for index, animName in ipairs(self.animNames) do
    self:ResetAnimByName(animName)
  end
end

function UIN28AVGStoryInfluenceItem:ResetAnimByName(animName)
  if not self.anim then
    return
  end
  local state = self.anim:get_Item(animName)
  if state then
    state.normalizedTime = 0
  end
  self.anim:Stop()
end

function UIN28AVGStoryInfluenceItem:PrintAnimNormalizedTime(animName)
  local state = self.anim:get_Item(animName)
  Log.fatal("### PrintAnimNormalizedTime", state.normalizedTime, animName)
end
