_class("UICN20N49LineTalentTreeSlot", UICustomWidget)
UICN20N49LineTalentTreeSlot = UICN20N49LineTalentTreeSlot

function UICN20N49LineTalentTreeSlot:OnShow()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._red = self:GetGameObject("red")
  self:AttachEvent(GameEventType.OnTalentTreeRedChange, self.OnTalentTreeRedChange)
  self._countdownTimer = {}
end

function UICN20N49LineTalentTreeSlot:SetData(campaign, com)
  self._campaign = campaign
  self.talentTreeCom = com
  self._comCfgId = self.talentTreeCom:GetComponentCfgId()
  self.talentTreeComInfo = self.talentTreeCom:GetComponentInfo()
  local info = self.talentTreeComInfo.m_talent_info
  self.slotInfo = info.m_skill_solt
  self:SlotCfgList()
  self:ShowPools()
  self:ShowRed()
  self:PlayPoolsAnime()
end

function UICN20N49LineTalentTreeSlot:OnHide()
  for i, countdownTimer in pairs(self._countdownTimer) do
    self._countdownTimer[i] = UIActivityHelper.CancelTimerEvent(self._countdownTimer[i])
  end
end

function UICN20N49LineTalentTreeSlot:OnTalentTreeRedChange()
  self:ShowRed()
end

function UICN20N49LineTalentTreeSlot:ShowRed()
  local red = self.talentTreeCom:HaveRedPoint()
  self._red:SetActive(red)
end

function UICN20N49LineTalentTreeSlot:SlotCfgList()
  self.slotCfgList = {}
  local cfgs = Cfg.cfg_component_talent_tree_slot({
    ComponentID = self._comCfgId
  })
  for key, value in pairs(cfgs) do
    table.insert(self.slotCfgList, value)
  end
  table.sort(self.slotCfgList, function(a, b)
    return a.SlotID < b.SlotID
  end)
end

function UICN20N49LineTalentTreeSlot:ShowPools()
  self._pool:SpawnObjects("UICN20N49LineTalentTreeSlotCell", table.count(self.slotCfgList))
  local pools = self._pool:GetAllSpawnList()
end

function UICN20N49LineTalentTreeSlot:PlayPoolsAnime()
  local pools = self._pool:GetAllSpawnList()
  if #pools == 0 then
    return
  end
  if self._countdownTimer then
    for i, countdownTimer in pairs(self._countdownTimer) do
      self._countdownTimer[i] = UIActivityHelper.CancelTimerEvent(self._countdownTimer[i])
    end
  end
  for i = 1, #self.slotCfgList do
    local item = pools[i]
    local cfg = self.slotCfgList[i]
    local rootid = self.slotInfo[cfg.SlotID]
    item:SetData(i, cfg, rootid)
    self._countdownTimer[i] = GameGlobal.Timer():AddEvent(50 * (i - 1), function()
      local animation = pools[i]:GetUIComponent("Animation", "_anim")
      animation:Play("uieff_UICN20N49LineTalentTreeSlotItem_in")
    end)
  end
end

function UICN20N49LineTalentTreeSlot:BtnOnClick(go)
  if not self.talentTreeCom:ComponentIsClose() and self.talentTreeCom:ComponentIsOpen() then
    self:ShowDialog("UICN20N49TreeController")
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
    local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN20N49MainController, nil)
    local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
  end
end
