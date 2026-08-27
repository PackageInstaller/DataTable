local UINChristmas22TechSpecialList = class("UINChristmas22TechSpecialList", UIBaseNode)
local base = UIBaseNode
local UINChristmas22TechSpecialItem = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechSpecialItem")

function UINChristmas22TechSpecialList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.closeBg, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  self._itemPool = UIItemPool.New(UINChristmas22TechSpecialItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
end

function UINChristmas22TechSpecialList:SetChristmas22LogicDesType(desType)
  self._desType = desType
end

function UINChristmas22TechSpecialList:InitChristmas22TechSpecialList(actTechTree, specialBranchId, resloader, callback)
  local techDic = actTechTree:GetTechDataDic()[specialBranchId]
  if techDic == nil then
    error("tech list error")
    return
  end
  local techList = {}
  for k, techData in pairs(techDic) do
    table.insert(techList, techData)
  end
  table.sort(techList, function(a, b)
    return a:GetTechId() < b:GetTechId()
  end)
  self._itemPool:HideAll()
  for i, techData in ipairs(techList) do
    local item = self._itemPool:GetOne()
    item:SetChristmas22LogicDesType(self._desType)
    item:InitChristmas22TechSpecialItem(techData, resloader, callback)
  end
end

function UINChristmas22TechSpecialList:RefreshChristmas22TechSpecialList()
  for i, v in ipairs(self._itemPool.listItem) do
    v:RefreshChristmas22TechSpecialItem()
  end
end

return UINChristmas22TechSpecialList
