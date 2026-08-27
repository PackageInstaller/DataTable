local UINEventComebackSystem = class("UINEventComebackSystem", UIBaseNode)
local base = UIBaseNode
local UINEventComebackSystemItem = require("Game.ActivityComeback.UI.UINEventComebackSystemItem")
local UINEventComebackSystemMain = require("Game.ActivityComeback.UI.UINEventComebackSystemMain")
local cs_ResLoader = CS.ResLoader
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINEventComebackSystem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.resLoader = cs_ResLoader.Create()
  self._itemPool = UIItemPool.New(UINEventComebackSystemItem, self.ui.Item)
  self.ui.Item.gameObject:SetActive(false)
  self.__OnSystemItemClick = BindCallback(self, self.OnSystemItemClick)
end

function UINEventComebackSystem:InitComebackSystem(comebackId)
  local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  if comebackCtrl == nil then
    return
  end
  local newSysData = comebackCtrl:GetComebackNewSystemData(comebackId)
  if newSysData == nil then
    return
  end
  self._newSysData = newSysData
  local modules = newSysData:GetComebackNewSystemModules()
  local modulesCfg = newSysData:GetComebackNewSystemModulesCfg()
  if self._systemMainNode == nil then
    self._systemMainNode = UINEventComebackSystemMain.New()
    self._systemMainNode:Init(self.ui.Main)
  end
  self:InitSystemItemList(true)
  self.ui.ScrollRect.horizontalNormalizedPosition = 0
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.ScrollRect.transform)
end

function UINEventComebackSystem:RefreshSystemMainNode(moduleCfg, taskIds, resLoader)
  if self._systemMainNode ~= nil then
    self._systemMainNode:RefreshComebackSystemMain(self._newSysData, moduleCfg, taskIds, resLoader, BindCallback(self, self.RefreshSystemItemList))
  end
end

function UINEventComebackSystem:RefreshSystemItemList()
  self:InitSystemItemList(false, self._cacheSelectIndex)
end

function UINEventComebackSystem:InitSystemItemList(isFirstOpen, lastChooseIndex)
  local modules = self._newSysData:GetComebackNewSystemModules()
  local modulesCfg = self._newSysData:GetComebackNewSystemModulesCfg()
  self._itemPool:HideAll()
  local moduleIds = {}
  local moduleDataDic = {}
  for index, data in ipairs(modules) do
    table.insert(moduleIds, data.moduleId)
    moduleDataDic[data.moduleId] = data
    local questIds = data.questIds
    local isDone = true
    for _, taskId in ipairs(data.questIds) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
      isDone = taskData.isPicked
      if not isDone then
        break
      end
    end
    moduleDataDic[data.moduleId].isDone = isDone
  end
  table.sort(moduleIds, function(a, b)
    local dataA = moduleDataDic[a]
    local dataB = moduleDataDic[b]
    if dataA.isDone ~= dataB.isDone then
      return dataB.isDone
    end
    return a < b
  end)
  for index, moduleId in ipairs(moduleIds) do
    local curModuleData = moduleDataDic[moduleId]
    local curModuleCfg = modulesCfg[moduleId]
    local curIsDone = curModuleData.isDone
    local questIds = curModuleData.questIds
    if not curModuleCfg.is_hide then
      local item = self._itemPool:GetOne()
      item:InitComebackSystemItem(index, curModuleCfg, questIds, curIsDone, self.__OnSystemItemClick, self.resLoader)
      if index == 1 and isFirstOpen then
        item:OnClickComebackSystemItem()
      elseif lastChooseIndex ~= nil and index == lastChooseIndex then
        local preIndex = lastChooseIndex
        if curIsDone and (lastChooseIndex ~= 1 or not 1) then
          local preIndex = lastChooseIndex - 1
        end
        local preItem = self._itemPool.listItem[preIndex]
        preItem:OnClickComebackSystemItem()
      end
    end
  end
end

function UINEventComebackSystem:OnSystemItemClick(transform, moduleCfg, taskIds, index)
  self:RefreshSystemMainNode(moduleCfg, taskIds, self.resLoader)
  self.ui.Obj_Selected.transform:SetParent(transform)
  self.ui.Obj_Selected.transform.anchoredPosition = Vector2.zero
  if index then
    self._cacheSelectIndex = index
  end
end

function UINEventComebackSystem:OnDelete()
  self._itemPool:DeleteAll()
  if self._systemMainNode then
    self._systemMainNode:Delete()
  end
  if self.resLoader then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UINEventComebackSystem
