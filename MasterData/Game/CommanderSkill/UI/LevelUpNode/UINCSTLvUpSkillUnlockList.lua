local UINCSTLvUpSkillUnlockList = class("UINCSTLvUpSkillUnlockList", UIBaseNode)
local base = UIBaseNode
local UINCSTLvUpSkillItem = require("Game.CommanderSkill.UI.LevelUpNode.UINCSTLvUpSkillItem")

function UINCSTLvUpSkillUnlockList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.skillItemDic = {}
end

function UINCSTLvUpSkillUnlockList:InitCSTLvUpSkillUnlockList(resLoader, unlockSkillDataList, newTreeLevel, treeData, refill)
  self.resLoader = resLoader
  self.newTreeLevel = newTreeLevel
  self.treeData = treeData
  self.unlockSkillDataList = unlockSkillDataList
  self:_RefillScrollRect(refill)
end

function UINCSTLvUpSkillUnlockList:_RefillScrollRect(refill)
  self.ui.scrollRect.totalCount = #self.unlockSkillDataList
  if refill then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINCSTLvUpSkillUnlockList:__OnNewItem(go)
  local item = UINCSTLvUpSkillItem.New()
  item:Init(go)
  self.skillItemDic[go] = item
end

function UINCSTLvUpSkillUnlockList:__OnChangeItem(go, index)
  local item = self.skillItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local unlockSkillData = self.unlockSkillDataList[index + 1]
  if unlockSkillData == nil then
    error("Can't find unlockSkillData by index, index = " .. tonumber(index))
  end
  local cmdSkillData = self.treeData.commanderSkillDataDic[unlockSkillData.skillId]
  item:InitCSTLvUpSkillItem(self.resLoader, cmdSkillData, self.newTreeLevel, unlockSkillData.skillLevel)
end

function UINCSTLvUpSkillUnlockList:OnDelete()
  for k, v in pairs(self.skillItemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UINCSTLvUpSkillUnlockList
