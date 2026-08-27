local base = UIBaseNode
local UIOasisBuildingCanvas = class("UIOasisBuildingCanvas", base)
local NameItem = require("Game.Oasis.UI.UIOasisBuildingCanvasNameItem")
local ProcessItem = require("Game.Oasis.UI.UIOasisBuildingCanvasProgressItem")

function UIOasisBuildingCanvas:OnInit()
  local nameRoot = self:FindComponent("NameRoot", eUnityComponentID.Transform)
  self.ui.nameRoot = {}
  UIUtil.LuaUIBindingTable(nameRoot, self.ui.nameRoot)
  self.ui.nameRoot.gameObject = nameRoot.gameObject
  self.ui.nameRoot.namePrefab:SetActive(false)
  self.nameItems = {}
  self.nameItemPool = {}
  local progressRoot = self:FindComponent("ProgressRoot", eUnityComponentID.Transform)
  self.ui.progressRoot = {}
  UIUtil.LuaUIBindingTable(progressRoot, self.ui.progressRoot)
  self.ui.progressRoot.progressPrefab:SetActive(false)
  self.progressItem = {}
  self.progressItemPool = {}
end

function UIOasisBuildingCanvas:CreateNameItem(id, UIbulidData)
  local item = self.nameItems[id]
  if item == nil then
    if #self.nameItemPool > 0 then
      item = table.remove(self.nameItemPool, 1)
    else
      local go = self.ui.nameRoot.namePrefab:Instantiate()
      go:SetActive(true)
      item = NameItem.New()
      item:Init(go)
      item:Split(self.ui.nameRoot.flowRoot, self.ui.nameRoot.bg1Root, self.ui.nameRoot.bg2Root, self.ui.nameRoot.arrowBgRoot, self.ui.nameRoot.text1Root, self.ui.nameRoot.text2Root)
    end
  end
  item:InitCanvasNameItem(id, UIbulidData, self.isTop)
  self.nameItems[id] = item
end

function UIOasisBuildingCanvas:SetBuildCanvasTopMode(isTop)
  self.isTop = isTop
  for id, nameItem in pairs(self.nameItems) do
    nameItem:ShowBuildName3dTop(self.isTop)
  end
end

function UIOasisBuildingCanvas:UpdateNameItemLevel(id, level)
  local item = self.nameItems[id]
  if item ~= nil then
    item:UpdateBuildingLevel(level)
  end
end

function UIOasisBuildingCanvas:UpdateNamePos(id, position)
  local item = self.nameItems[id]
  if item ~= nil then
    item:UpdateNamePos(position)
  end
end

function UIOasisBuildingCanvas:RecycleNameItem(id)
  local item = self.nameItems[id]
  if item ~= nil then
    item:OnRecycle()
    self.nameItems[id] = nil
    table.insert(self.nameItemPool, item)
  end
end

function UIOasisBuildingCanvas:SetNameRootActive(active)
  if self.ui.nameRoot ~= nil then
    self.ui.nameRoot.gameObject:SetActive(active)
  end
end

function UIOasisBuildingCanvas:ShowBuildingName3dItem(id, show)
  local item = self.nameItems[id]
  if item ~= nil then
    if show then
      item:Show()
    else
      item:Hide()
    end
  end
end

function UIOasisBuildingCanvas:SetBuildName3dItemCanLevelUp(id, canLvUp)
  local item = self.nameItems[id]
  if item ~= nil then
    item:BuildName3dCanLevelUp(canLvUp)
  end
end

function UIOasisBuildingCanvas:__GetProcessItem()
  local item
  if #self.progressItemPool > 0 then
    item = table.remove(self.progressItemPool, 1)
  else
    local go = self.ui.progressRoot.progressPrefab:Instantiate()
    go:SetActive(true)
    item = ProcessItem.New()
    item:Init(go)
    item:Split(self.ui.progressRoot.bgRoot, self.ui.progressRoot.fillRoot, self.ui.progressRoot.textRoot)
  end
  return item
end

function UIOasisBuildingCanvas:UpdateProcess(id, position, progress, text)
  local item = self.progressItem[id]
  if item == nil then
    item = self:__GetProcessItem()
    item:InitCanvasProcessItem(id, position, progress, text)
    self.progressItem[id] = item
  else
    item:UpdateProcess(progress, text)
    item:UpdateProcessPos(position)
  end
end

function UIOasisBuildingCanvas:UpdateProcessPos(id, position)
  local item = self.progressItem[id]
  if item ~= nil then
    item:UpdateProcessPos(position)
  end
end

function UIOasisBuildingCanvas:RecycleProcessItem(id)
  local item = self.progressItem[id]
  if item ~= nil then
    item:OnRecycle()
    self.progressItem[id] = nil
    table.insert(self.progressItemPool, item)
  end
end

function UIOasisBuildingCanvas:RecycleUI(id)
  self:RecycleNameItem(id)
  self:RecycleProcessItem(id)
end

function UIOasisBuildingCanvas:OnDelete()
  for k, v in pairs(self.nameItems) do
    v:OnDelete()
  end
  self.nameItems = {}
  for k, v in pairs(self.progressItem) do
    v:OnDelete()
  end
  self.progressItem = {}
  for k, v in ipairs(self.progressItemPool) do
    v:OnDelete()
  end
  self.progressItemPool = {}
  base.OnDelete(self)
end

return UIOasisBuildingCanvas
