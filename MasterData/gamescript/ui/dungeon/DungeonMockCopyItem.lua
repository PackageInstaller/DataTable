local DungeonMockCopyItem, Super = System.NewComponent("DungeonMockCopyItem")

function DungeonMockCopyItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_Common_ElementResource(uiNode)
  self.stageGroupId = data.stageGroupId
  self.clickFunc = data.clickFunc
  self.isSelectFunc = data.isSelectFunc
  self.cfg = DT.StageGroup[self.stageGroupId]
end

function DungeonMockCopyItem:OnBind(binder)
  self.binder = binder
  self.ui.Image_D_Icon:SetActive(false)
  self.ui.Image_Mask_Icon:SetActive(false)
  binder:SetText(self.ui.Text_Title, self.cfg.Name)
  self.ui.Text_Desc:SetActive(false)
  self.ui.Group_Nor:SetActive(true)
  self.ui.Group_Mask:SetActive(false)
  self.ui.Text_Tip:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Click, self.clickFunc)
  binder:BindToVisible(self.ui.Group_Select, self.isSelectFunc)
end

return DungeonMockCopyItem
