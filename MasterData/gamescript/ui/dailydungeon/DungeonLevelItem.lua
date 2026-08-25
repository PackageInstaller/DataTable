local DungeonLevelItem, Super = System.NewComponent("DungeonLevelItem")

function DungeonLevelItem:ctor(uiNode, levelId, unlocked, selected, selectCallback)
  Super.ctor(self)
  self.levelId = levelId
  self.unlocked = unlocked
  self.selected = selected
  self.selectCallback = selectCallback
  self.ui = Item_EverydayDungeons_LevelResource(uiNode)
end

function DungeonLevelItem:OnBind(binder)
  self.binder = binder
  self.ui.Group_Lock:SetActive(not self.unlocked)
  self.ui.Text_Name:SetActive(self.unlocked)
  local config = DT.DailyLevelConfig[self.levelId]
  if self.unlocked then
    binder:SetText(self.ui.Text_Name, config.Name)
  else
    binder:SetText(self.ui.Text_UnlockDesc, config.UnlockDesc)
  end
  binder:BindButtonClick(self.ui.uiNode, function()
    if not self.unlocked then
      Alert.Show(10191)
      return
    end
    if self.selectCallback then
      self.selectCallback(self, not self.selected)
    end
  end)
end

function DungeonLevelItem:SetSelected(selected)
  self.selected = selected
  self.ui.Image_Bg_High:SetActive(self.selected)
end

return DungeonLevelItem
