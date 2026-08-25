local Vector3 = CS.UnityEngine.Vector3
local POS_HAVE_ICON = Vector3(52, 0, 0)
local POS_NONE_ICON = Vector3(0, 0, 0)
local CommonEffectDesc, Super = System.NewComponent("CommonEffectDesc")

function CommonEffectDesc:ctor(uiNode, desc)
  Super.ctor(self)
  self.ui = CardKeyWordItem_New_InfoResource(uiNode)
  self.desc = desc
end

function CommonEffectDesc:OnBind(binder)
  binder:BindToRaw(function(_, icon)
    if icon and "" ~= icon then
      if self.desc.useBigIcon then
        binder:SetActive(self.ui.Image_Effect_Icon, false)
        binder:SetActive(self.ui.Image_Effect_Icon2, true)
        binder:SetImage(self.ui.Image_Effect_Icon2, icon)
      else
        binder:SetActive(self.ui.Image_Effect_Icon, true)
        binder:SetActive(self.ui.Image_Effect_Icon2, false)
        binder:SetImage(self.ui.Image_Effect_Icon, icon)
      end
      self.ui.Text_Effect_Name.transform.localPosition = POS_HAVE_ICON
    else
      binder:SetActive(self.ui.Image_Effect_Icon, false)
      binder:SetActive(self.ui.Image_Effect_Icon2, false)
      self.ui.Text_Effect_Name.transform.localPosition = POS_NONE_ICON
    end
  end, function()
    return self.desc.icon
  end)
  binder:BindToRaw(function(_, name)
    binder:SetText(self.ui.Text_Effect_Name, name, nil, nil, {banKeywordBtn = true})
    binder:RemoveUnderline(self.ui.Text_Effect_Name)
  end, function()
    return self.desc.name
  end)
  binder:BindToRaw(function(_, desc)
    binder:SetText(self.ui.Text_Effect_Desc, desc, nil, nil, {banKeywordBtn = true})
    binder:RemoveUnderline(self.ui.Text_Effect_Desc)
    StrUtils.SetPreferredHeight(self.ui.Text_Effect_Desc)
  end, function()
    return self.desc.desc
  end)
  binder:BindToRaw(function(_, desc)
    binder:SetText(self.ui.Text_Effect_Sub_Desc, desc, false, nil, {banKeywordBtn = true})
    if bg.isPVP and self.desc.subDescColor then
      binder:SetTextColorByHtml(self.ui.Text_Effect_Sub_Desc, self.desc.subDescColor)
    end
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Effect_Sub_Desc, 2)
  end, function()
    return self.desc.subDesc
  end)
  if self.desc.layerCountList and #self.desc.layerCountList > 0 then
    binder:BindNewComponent(self.ui.uiNode, CommonEffectStateLayerComp, CardKeyWordItem_LayerCountResource, self.desc.layerCountList)
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.uiNode)
end

return CommonEffectDesc
