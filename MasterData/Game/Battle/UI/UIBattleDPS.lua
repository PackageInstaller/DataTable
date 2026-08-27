local UIBattleDPS = class("UIBattleDPS", UIBaseWindow)
local base = UIBaseWindow
local UINBattleDPSItem = require("Game.Battle.UI.UINBattleDPSItem")

function UIBattleDPS:OnInit()
  UIUtil.AddValueChangedListener(self.ui.tog_DPS, self, self.OnPageChanged)
  self.achivTypeTogglePool = UIItemPool.New(UINBattleDPSItem, self.ui.obj_template)
  self.ui.obj_template:SetActive(false)
  self.dpsItemDic = {}
  self.dpsItemList = {}
  self.maxDamage = 0
  self.oldDamage = 0
  self.ui.tog_DPS.isOn = true
  self.ui.obj_panel:SetActive(true)
  self.cacheDamageTable = {}
  if self.timer == nil then
    self.timer = TimerManager:StartTimer(5, BindCallback(self, self.UpadteDpsUI), nil, false, true, false)
  end
end

function UIBattleDPS:OnHeroTakeDamage(role, damage)
  local id = 0
  if role ~= nil then
    id = role.roleDataId
  end
  if self.cacheDamageTable[id] == nil then
    self.cacheDamageTable[id] = damage
  end
  self.maxDamage = math.max(damage, self.maxDamage)
  if self.dpsItemDic[id] == nil then
    local item = self.achivTypeTogglePool:GetOne(true)
    local name
    if role ~= nil then
      name = role.name
    end
    item:InitDPSItem(id, name)
    item.heroID = id
    item:AddDamage(damage, 0, false)
    self.dpsItemDic[id] = item
    table.insert(self.dpsItemList, item)
  end
end

function UIBattleDPS:UpadteDpsUI()
  if table.count(self.cacheDamageTable) <= 0 then
    return
  end
  local isNeedUpdateMaxDamage = false
  if self.maxDamage ~= self.oldDamage then
    self.oldDamage = self.maxDamage
    isNeedUpdateMaxDamage = true
  end
  local totalDamage = 0
  for k, v in pairs(self.cacheDamageTable) do
    local item = self.dpsItemDic[k]
    if item ~= nil then
      item:AddDamage(v, self.maxDamage, isNeedUpdateMaxDamage)
    end
    totalDamage = totalDamage + v
  end
  MsgCenter:Broadcast(eMsgEventId.OnDamageValueChange, totalDamage)
  self.cacheDamageTable = {}
end

function UIBattleDPS:OnPageChanged(bool)
  if bool then
    self.ui.obj_panel:SetActive(true)
  else
    self.ui.obj_panel:SetActive(false)
  end
end

function UIBattleDPS:SortItem()
  table.sort(self.dpsItemList, function(a, b)
    if a.damage == b.damage then
      return a.heroID > b.heroID
    else
      return a.damage > b.damage
    end
  end)
  for index, item in ipairs(self.dpsItemList) do
    item.transform:SetSiblingIndex(index - 1)
  end
end

function UIBattleDPS:OnHide()
  base.OnHide(self)
end

function UIBattleDPS:OnDelete()
  base.OnDelete(self)
  for id, item in pairs(self.dpsItemDic) do
    item:Clean()
  end
  TimerManager:StopTimer(self.timer)
  self.timer = nil
  self.achivTypeTogglePool:HideAll()
  self.dpsItemDic = {}
end

return UIBattleDPS
