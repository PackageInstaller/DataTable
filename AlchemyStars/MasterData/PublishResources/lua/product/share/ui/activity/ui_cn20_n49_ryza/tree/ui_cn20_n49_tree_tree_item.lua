_class("UICN20N49TreeTreeItem", UICustomWidget)
UICN20N49TreeTreeItem = UICN20N49TreeTreeItem

function UICN20N49TreeTreeItem:OnShow()
  self._passivePool = self:GetUIComponent("UISelectObjectPath", "passivePool")
end

function UICN20N49TreeTreeItem:SetData(com, skillData, callback)
  self.talentTreeCom = com
  self._skillData = skillData
  self.callback = callback
  self:ShowPassiveList()
end

function UICN20N49TreeTreeItem:Get_1P_2N_Icon()
  local pools = self._passivePool:GetAllSpawnList()
  local t_1p = pools[1]
  return t_1p:Get_1P_2N_Icon()
end

function UICN20N49TreeTreeItem:ShowPassiveList()
  local passiveList = self._skillData:PassiveCfgList()
  local rootIDMap = self._skillData:RootIDMap()
  local comCfgID = self._skillData:ComCfgID()
  self._passivePool:SpawnObjects("UICN20N49TreeSkillParent", #passiveList)
  local pools = self._passivePool:GetAllSpawnList()
  for i = 1, #passiveList do
    local item = pools[i]
    local cfg = passiveList[i]
    local rootid = cfg.SkillTypeID
    item:SetData(i, rootid, cfg, rootIDMap, comCfgID, self.callback)
    if i == 1 then
      self._firstPassiveItem = item
    end
  end
end

function UICN20N49TreeTreeItem:RefreshCls(com, skillData)
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

function UICN20N49TreeTreeItem:GuideClickFirst()
  if self._firstPassiveItem then
    self._firstPassiveItem:IconOnClick()
  end
end
