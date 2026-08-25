local CommonEffectStateLayerItem, Super = NewViewComponent("CommonEffectStateLayerItem")

function CommonEffectStateLayerItem:ctor(uiNode, view, layerCountList, uiRes)
  Super.ctor(self, uiNode, view)
  self.ui = CardKeyWordItem_LayerCountResource(uiNode)
  self._layerCountList = layerCountList
  self._uiRes = uiRes
end

function CommonEffectStateLayerItem:OnEnterComponent()
  local layerCountList = self._layerCountList
  self:_RefreshLayerCount(layerCountList[1], self.ui.Root_Layer_Count_1, self.ui.Image_Duration_Icon_1, self.ui.Text_Duration_Desc_1, self.ui.Text_Layer_Count_1)
  self:_RefreshLayerCount(layerCountList[2], self.ui.Root_Layer_Count_2, self.ui.Image_Duration_Icon_2, self.ui.Text_Duration_Desc_2, self.ui.Text_Layer_Count_2)
  self:_RefreshLayerCount(layerCountList[3], self.ui.Root_Layer_Count_3, self.ui.Image_Duration_Icon_3, self.ui.Text_Duration_Desc_3, self.ui.Text_Layer_Count_3)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.gameObject)
end

function CommonEffectStateLayerItem:_RefreshLayerCount(layerCount, uiRoot, uiIcon, uiDesc, uiCount)
  if layerCount then
    self:SetActive(uiRoot, true)
    self:SetImage(uiIcon, layerCount.icon)
    self:SetText(uiDesc, layerCount.desc)
    self:SetText(uiCount, layerCount.count)
  else
    self:SetActive(uiRoot, false)
  end
end

function CommonEffectStateLayerItem:OnExitComponent()
  if self._uiRes then
    PoolManager.Instance:FreeItemUI(self._uiRes)
    self._uiRes = nil
  end
  Super.OnExitComponent(self)
end

return CommonEffectStateLayerItem
