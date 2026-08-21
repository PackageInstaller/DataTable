_class("UISeasonTalentLineMissionSlot", UICustomWidget)
UISeasonTalentLineMissionSlot = UISeasonTalentLineMissionSlot

function UISeasonTalentLineMissionSlot:OnShow()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._red = self:GetGameObject("red")
  self:AttachEvent(GameEventType.OnTalentTreeRedChange, self.OnTalentTreeRedChange)
end

function UISeasonTalentLineMissionSlot:SetData(com)
  self.talentCom = com
  self._comCfgId = self.talentCom:GetComponentCfgId()
  self.talentComInfo = self.talentCom:GetComponentInfo()
  local info = self.talentComInfo.m_talent_info
  self.slotInfo = info.m_skill_solt
  self:SlotCfgList()
  self:ShowPools()
  self:ShowRed()
end

function UISeasonTalentLineMissionSlot:OnTalentTreeRedChange()
  self:ShowRed()
end

function UISeasonTalentLineMissionSlot:ShowRed()
  local red = UISeasonHelper.TalentTreeSkillRed(nil, self.talentCom)
  self._red:SetActive(red)
end

function UISeasonTalentLineMissionSlot:SlotCfgList()
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

function UISeasonTalentLineMissionSlot:ShowPools()
  self._pool:SpawnObjects("UISeasonTalentLineMissionSlotCell", #self.slotCfgList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self.slotCfgList do
    local item = pools[i]
    local cfg = self.slotCfgList[i]
    local rootid = self.slotInfo[cfg.SlotID]
    item:SetData(i, cfg, rootid)
  end
end

function UISeasonTalentLineMissionSlot:BtnOnClick(go)
  if self.talentComInfo.m_b_unlock then
    self:ShowDialog("UISeasonTalentTreeController")
  else
    local missionid = self.talentComInfo.m_need_mission_id
    local cfg_camp_mission = Cfg.cfg_campaign_mission[missionid]
    local missionName = StringTable.Get(cfg_camp_mission.Name)
    local tips = StringTable.Get("str_season_talent_tree_line_node_lock_tex", missionName)
    ToastManager.ShowToast(tips)
  end
end
