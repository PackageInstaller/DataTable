_class("UICN20N49TreeSlotItem", UICustomWidget)
UICN20N49TreeSlotItem = UICN20N49TreeSlotItem

function UICN20N49TreeSlotItem:OnShow()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._slotInfoPanel = self:GetGameObject("SlotInfoPanel")
  self._slotInfoPanel:SetActive(false)
  self._skillName = self:GetUIComponent("UILocalizationText", "SkillName")
  self._skillTYpe = self:GetUIComponent("UILocalizationText", "SkillType")
  self._activeSkillNumber = self:GetUIComponent("UILocalizationText", "ActiveSkillNumber")
  self._anim = self:GetUIComponent("Animation", "UICN20N49Tree_Slot")
  self._panelPos = self:GetUIComponent("RectTransform", "SlotInfoPanel")
  self._currentSelectSlotID = nil
  self.idx2slotPos = {
    [1] = Vector2(227, 221),
    [2] = Vector2(227, 73),
    [3] = Vector2(227, -73),
    [4] = Vector2(227, -221)
  }
  self:AttachEvent(GameEventType.OnSelectSlot, self.OnSelectSlot)
end

function UICN20N49TreeSlotItem:OnSelectSlot(id)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  local info = self.talentComInfo.m_talent_info
  local slotInfo = info.m_skill_solt
  if slotInfo[id] and 0 < slotInfo[id] then
    self._slotInfoPanel:SetActive(true)
    local rootid = slotInfo[id]
    local map = self.skillData:RootIDMap()
    local skillCls = map[rootid]
    local cfg = skillCls:GetCfg()
    local nameStr = cfg.Name
    local type = skillCls.type
    local typeName
    if type == SeasonTalentSkillType.Passive then
      typeName = "str_cn20_n49_tree_skil_type_1"
    elseif type == SeasonTalentSkillType.Normal then
      typeName = "str_cn20_n49_tree_skil_type_3"
    elseif type == SeasonTalentSkillType.Power then
      typeName = "str_cn20_n49_tree_skil_type_2"
    end
    local pos = self.idx2slotPos[id]
    self._panelPos.anchoredPosition = pos
    self._skillTYpe:SetText(StringTable.Get(typeName))
    self._skillName:SetText(StringTable.Get(nameStr))
    self._currentSelectSlotID = id
    self._anim:Stop()
    self._anim:Play("uianim_UISeasonTalentTree_SlotInfoPanel_in")
    return
  end
  if self._currentSelectSlotID then
    self._anim:Stop()
    self._anim:Play("uianim_UISeasonTalentTree_SlotInfoPanel_out")
    self._timer = GameGlobal.Timer():AddEvent(500, function()
      self._slotInfoPanel:SetActive(false)
    end)
  end
  self._currentSelectSlotID = nil
end

function UICN20N49TreeSlotItem:BtnOnClick(go)
  self.unloadCb(self._currentSelectSlotID)
end

function UICN20N49TreeSlotItem:OneBtnOnClick(go)
  local info = self.talentComInfo.m_talent_info
  local slotInfo = info.m_skill_solt
  for key, value in pairs(slotInfo) do
    if value and 0 < value then
      self.unloadAllCb(self._currentSelectSlotID)
      return
    end
  end
  Log.debug("###[UICN20N49TreeSlotItem] OneBtnOnClick,but no slot use !")
end

function UICN20N49TreeSlotItem:SetData(com, skillData, callback, unloadCb, unloadAllCb)
  self.talentCom = com
  self.skillData = skillData
  self._comCfgId = self.talentCom:GetComponentCfgId()
  self.talentComInfo = self.talentCom:GetComponentInfo()
  local info = self.talentComInfo.m_talent_info
  self.slotInfo = info.m_skill_solt
  self.callback = callback
  self.unloadCb = unloadCb
  self.unloadAllCb = unloadAllCb
  self:SlotCfgList()
  self:ShowActiveSkill()
  local slotRect = self:ShowPools()
  local poolRect = self:GetUIComponent("RectTransform", "poolRect")
  return poolRect, slotRect, self.slotCfgList
end

function UICN20N49TreeSlotItem:ShowActiveSkill()
  local info = self.talentComInfo.m_talent_info
  local len = table.count(info.m_skill_list)
  self._activeSkillNumber:SetText(len)
end

function UICN20N49TreeSlotItem:SlotCfgList()
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

function UICN20N49TreeSlotItem:ShowPools()
  local slotRectList = {}
  self._pool:SpawnObjects("UICN20N49TreeSlotCell", #self.slotCfgList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self.slotCfgList do
    local item = pools[i]
    local cfg = self.slotCfgList[i]
    local rootid = self.slotInfo[cfg.SlotID]
    item:SetData(i, cfg, rootid, self.callback)
    local slotRect = self:GetUIComponent("RectTransform", "slotRect" .. i)
    table.insert(slotRectList, slotRect)
  end
  return slotRectList
end

function UICN20N49TreeSlotItem:RefreshData(com, skillData)
  self.talentCom = com
  self.skillData = skillData
  self._comCfgId = self.talentCom:GetComponentCfgId()
  self.talentComInfo = self.talentCom:GetComponentInfo()
  local info = self.talentComInfo.m_talent_info
  self.slotInfo = info.m_skill_solt
  self:RefreshPools()
  self:ShowActiveSkill()
  self._slotInfoPanel:SetActive(false)
end

function UICN20N49TreeSlotItem:RefreshPools()
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self.slotCfgList do
    local item = pools[i]
    local cfg = self.slotCfgList[i]
    local rootid = self.slotInfo[cfg.SlotID]
    item:RefreshData(rootid)
  end
end
