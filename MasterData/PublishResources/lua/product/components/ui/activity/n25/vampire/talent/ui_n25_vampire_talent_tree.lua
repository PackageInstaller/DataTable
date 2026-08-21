_class("UIN25VampireTalentTree", UIController)
UIN25VampireTalentTree = UIN25VampireTalentTree

function UIN25VampireTalentTree:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
  self.scaleSizeList = {en = 0.8}
end

function UIN25VampireTalentTree:OnShow(uiParams)
  local TopBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtns = TopBtn:SpawnObject("UINewCommonTopButton")
  backBtns:SetData(function()
    if self.data:GetActivityCampaign():CheckCampaignOpen() then
      self:SwitchState(UIStateType.UIN25VampireMain)
    else
      ToastManager.ShowToast(StringTable.Get("str_activity_error_" .. CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED))
      self:SwitchState(UIStateType.UIMain)
    end
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self.poolLevel = self:GetUIComponent("UISelectObjectPath", "level")
  self.txtExp = self:GetUIComponent("UILocalizationText", "txtExp")
  self.lock = self:GetGameObject("lock")
  self.normal = self:GetGameObject("normal")
  self.Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.rtUsed = self:GetUIComponent("RectTransform", "used")
  self.rtLeft = self:GetUIComponent("RectTransform", "left")
  self.txtUsed = self:GetUIComponent("UILocalizationText", "txtUsed")
  self.txtLeft = self:GetUIComponent("UILocalizationText", "txtLeft")
  self.rtSV = self:GetUIComponent("RectTransform", "sv")
  self.sv = self:GetUIComponent("ScrollRect", "sv")
  self.rtContent = self:GetUIComponent("RectTransform", "Content")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self:AttachEvent(GameEventType.N25UpdateTalentData, self.N25UpdateTalentData)
  self:AttachEvent(GameEventType.OnVampireTalentSkillTipsClose, self.OnVampireTalentSkillTipsClose)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.CheckActivityClose)
  self:Flush()
  self:PlayAnimTalentTreeItem()
  self:_CheckGuide()
end

function UIN25VampireTalentTree:OnHide()
  self.Icon:DestoryLastImage()
  self:DetachEvent(GameEventType.N25UpdateTalentData, self.N25UpdateTalentData)
  self:DetachEvent(GameEventType.OnVampireTalentSkillTipsClose, self.OnVampireTalentSkillTipsClose)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.CheckActivityClose)
end

function UIN25VampireTalentTree:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN25VampireTalentTree)
end

function UIN25VampireTalentTree:GuideSecondItemTalent()
  if self.secondTreeItem then
    return self.secondTreeItem.gudieRelic
  end
end

function UIN25VampireTalentTree:GuideFirstItemTalent()
  if self.firstTreeItem then
    return self.firstTreeItem.guideSkill
  end
end

function UIN25VampireTalentTree:Flush()
  local lv, curExp, lvUpExp = self.data:GetTalentLevelExp()
  local uiTextLevel = self.poolLevel:SpawnObject("UIN25VampireTalentText")
  uiTextLevel:Flush(lv, "num_level")
  self.txtExp:SetText(curExp .. "/" .. lvUpExp)
  self:FlushRoleSkill()
  local used = self.data:GetTalentUsed()
  local left = self.data:GetTalentLeft()
  self.txtUsed:SetText(used)
  self.txtLeft:SetText(left)
  local language = Localization.GetCurLanguage()
  if language == LanguageType.us then
    self.rtUsed.localScale = Vector3.one * self.scaleSizeList.en
    self.rtLeft.localScale = Vector3.one * self.scaleSizeList.en
  else
    self.rtUsed.localScale = Vector3.one
    self.rtLeft.localScale = Vector3.one
  end
  self:FlushTalentTreeItem()
end

function UIN25VampireTalentTree:FlushTalentTreeItem()
  local len = table.count(self.data.tiers)
  self.poolContent:SpawnObjects("UIN25VampireTalentTreeItem", len)
  local uis = self.poolContent:GetAllSpawnList()
  for i, tier in pairs(self.data.tiers) do
    local ui = uis[i]
    ui:Flush(tier.id, function()
      self:Move2Center(tier.id)
    end)
    if i == 1 then
      self.firstTreeItem = ui
    elseif i == 2 then
      self.secondTreeItem = ui
    end
  end
end

function UIN25VampireTalentTree:FlushRoleSkill()
  if self.data:IsRoleSkillActive() then
    self.lock:SetActive(false)
    local roleSkill = self.data:GetCurRoleSkill()
    if roleSkill then
      self.normal:SetActive(true)
      local icon, name, desc = roleSkill:IconNameDesc()
      self.Icon:LoadImage(icon)
    else
      self.normal:SetActive(false)
    end
  else
    self.lock:SetActive(true)
    self.normal:SetActive(false)
  end
end

function UIN25VampireTalentTree:N25UpdateTalentData()
  self.data:InitVampire()
  self:Flush()
end

function UIN25VampireTalentTree:Move2Center(tierId)
  local uis = self.poolContent:GetAllSpawnList()
  for i, ui in pairs(uis) do
    if tierId == ui:Id() then
      local percent = 0.25
      local height = self.rtSV.rect.height
      local rt = ui:RectTransform()
      local localPosRT = self.rtSV:InverseTransformPoint(rt.position)
      local distance = math.abs(localPosRT.y)
      if distance > (0.5 - percent) * height then
        self:StartTask(function(TT)
          local key = "UIN25VampireTalentTreeMove2Center"
          self:Lock(key)
          local duration = 0.5
          local endValue = self.rtContent.anchoredPosition.y - localPosRT.y
          endValue = UnityEngine.Mathf.Clamp(endValue, 0, self.rtContent.rect.height - height)
          self.rtContent:DOAnchorPosY(endValue, duration)
          YIELD(TT, duration * 1000)
          self:UnLock(key)
        end, self)
      end
      break
    end
  end
end

function UIN25VampireTalentTree:GetTalentTreeItems()
  local uis = self.poolContent:GetAllSpawnList()
  return uis
end

function UIN25VampireTalentTree:PlayAnimTalentTreeItem()
  self:StartTask(function(TT)
    local key = "UIN25VampireTalentTreePlayAnimTalentTreeItem"
    self:Lock(key)
    local uis = self:GetTalentTreeItems()
    for index, ui in ipairs(uis) do
      ui:GetGameObject():SetActive(false)
    end
    for index, ui in ipairs(uis) do
      if index == 1 then
        YIELD(TT, 200)
      else
        YIELD(TT, 20)
      end
      ui:GetGameObject():SetActive(true)
      ui:PlayAnimation()
    end
    self:UnLock(key)
  end, self)
end

function UIN25VampireTalentTree:CheckActivityClose(id)
  local cType, cId = self.data:GetCampaignTypeId()
  if cId == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN25VampireTalentTree:BtnIntroOnClick(go)
  self:ShowDialog("UIN25VampireTalentIntro", "str_n25_vampire_talent_intro_title", "str_n25_vampire_talent_intro_")
end

function UIN25VampireTalentTree:ImgLockOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_n25_vampire_talent_skill_not_active"))
end

function UIN25VampireTalentTree:ImgRoleSkillOnClick(go)
  self:ShowDialog("UIN25VampireRoleSkill")
end

function UIN25VampireTalentTree:BtnResetOnClick(go)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_n25_vampire_reset_all_cost_point"), function(param)
    self:StartTask(function(TT)
      local used = self.data:GetTalentUsed()
      if used <= 0 then
        return
      end
      local key = "HandleBloodsuckerResetTalentTree"
      self:Lock(key)
      local c = self.data:GetComponentVampire()
      local res = AsyncRequestRes:New()
      c:HandleBloodsuckerResetTalentTree(TT, res)
      if N25Data.CheckCode(res) then
      end
      self:UnLock(key)
    end, self)
  end)
end

function UIN25VampireTalentTree:OnVampireTalentSkillTipsClose(skillId)
  local skilldata = self.data:GetSkillBySkillId(skillId)
  if skilldata.level == 1 then
    local cfgv = Cfg.cfg_mini_maze_talent[skillId]
    ToastManager.ShowToast(StringTable.Get("str_n25_vampire_talent_point_unlock", StringTable.Get(cfgv.Name)))
  end
end
