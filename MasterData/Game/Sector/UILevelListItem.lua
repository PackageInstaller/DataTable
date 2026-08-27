local UIlevelListItem = class("Game.Sector.UILevelListItem", UIBaseNode)
local base = UIBaseNode

function UIlevelListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_LevelItem, self, self.Select)
  self.ui.stopStateNode:SetActive(false)
end

function UIlevelListItem:InitLevelItem(levelData, callBack)
  self.levelNum = levelData.num
  self.levelData = levelData
  self.ui.tex_Name.text = string.format("%d-%d", levelData.sector, levelData.num)
  self.clickAction = callBack
  self.stageState = PlayerDataCenter.sectorStage:GetStageState(levelData.id)
  self.isUnlock = PlayerDataCenter.sectorStage:IsStageUnlock(levelData.id)
  self.ui.img_Lock.gameObject:SetActive(not self.isUnlock)
  self.ui.img_Pic.gameObject:SetActive(self.isUnlock)
  self.ui.obj_ClearLevel:SetActive(self.stageState > 0)
end

function UIlevelListItem:Select()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UIlevelListItem:DisableSelect()
  if not self.isUnlock then
    return
  end
  self.ui.stopStateNode:SetActive(true)
end

function UIlevelListItem:SetSelectUI(active)
  self.ui.select:SetActive(active)
end

function UIlevelListItem:ShowRedDot(show)
  self.ui.redDot:SetActive(show)
end

function UIlevelListItem:OnDelete()
  base.OnDelete(self)
end

return UIlevelListItem
