_class("UISeasonTalentTreeTreeItem", UICustomWidget)
UISeasonTalentTreeTreeItem = UISeasonTalentTreeTreeItem

function UISeasonTalentTreeTreeItem:OnShow()
  self._passivePool = self:GetUIComponent("UISelectObjectPath", "passivePool")
end

function UISeasonTalentTreeTreeItem:SetData(com, skillData, callback)
  self.talentTreeCom = com
  self._skillData = skillData
  self.callback = callback
  self:ShowPassiveList()
end

function UISeasonTalentTreeTreeItem:Get_1P_2N_Icon()
  local pools = self._passivePool:GetAllSpawnList()
  local t_1p = pools[1]
  return t_1p:Get_1P_2N_Icon()
end

function UISeasonTalentTreeTreeItem:ShowPassiveList()
  local passiveList = self._skillData:PassiveCfgList()
  local rootIDMap = self._skillData:RootIDMap()
  local comCfgID = self._skillData:ComCfgID()
  self._passivePool:SpawnObjects("UISeasonTalentTreeSkillParent", #passiveList)
  local pools = self._passivePool:GetAllSpawnList()
  for i = 1, #passiveList do
    local item = pools[i]
    local cfg = passiveList[i]
    local rootid = cfg.SkillTypeID
    item:SetData(i, rootid, cfg, rootIDMap, comCfgID, self.callback)
  end
end

function UISeasonTalentTreeTreeItem:RefreshCls(com, skillData)
  self.talentTreeCom = com
  self._skillData = skillData
  local passiveList = self._skillData:PassiveCfgList()
  local rootIDMap = self._skillData:RootIDMap()
  local pools = self._passivePool:GetAllSpawnList()
  for i = 1, #passiveList do
    local item = pools[i]
    local cfg = passiveList[i]
    local rootid = cfg.SkillTypeID
    local cls = rootIDMap[rootid]
    item:RefreshCls(cls, rootIDMap)
  end
end
