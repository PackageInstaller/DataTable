local CommonEffectStateLayerComp, Super = System.NewComponent("CommonEffectStateLayerComp")

function CommonEffectStateLayerComp:ctor(uiNode, layerCountList)
  Super.ctor(self)
  self.ui = CardKeyWordItem_LayerCountResource(uiNode)
  self.layerCountList = layerCountList
end

function CommonEffectStateLayerComp:OnBind(binder)
  local layerCountList = self.layerCountList
  self:BindLayerCount(layerCountList[1], binder, self.ui.Root_Layer_Count_1, self.ui.Image_Duration_Icon_1, self.ui.Text_Duration_Desc_1, self.ui.Text_Layer_Count_1)
  self:BindLayerCount(layerCountList[2], binder, self.ui.Root_Layer_Count_2, self.ui.Image_Duration_Icon_2, self.ui.Text_Duration_Desc_2, self.ui.Text_Layer_Count_2)
  self:BindLayerCount(layerCountList[3], binder, self.ui.Root_Layer_Count_3, self.ui.Image_Duration_Icon_3, self.ui.Text_Duration_Desc_3, self.ui.Text_Layer_Count_3)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.uiNode)
end

function CommonEffectStateLayerComp:BindLayerCount(layerCount, binder, uiRoot, uiIcon, uiDesc, uiCount)
  if layerCount then
    uiRoot:SetActive(true)
    binder:BindToImage(uiIcon, function()
      return layerCount.icon
    end)
    binder:BindToText(uiDesc, function()
      return layerCount.desc
    end)
    binder:BindToText(uiCount, function()
      return layerCount.count
    end)
  else
    uiRoot:SetActive(false)
  end
end

return CommonEffectStateLayerComp
