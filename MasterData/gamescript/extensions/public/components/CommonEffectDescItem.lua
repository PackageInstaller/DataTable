local Vector3 = CS.UnityEngine.Vector3
local POS_HAVE_ICON = Vector3(52, 0, 0)
local POS_NONE_ICON = Vector3(0, 0, 0)
local ClearAllTextInPrefab = CS.Framework.UIUtilTool.ClearAllTextInPrefab
local CommonEffectDescItem, Super = NewViewComponent("CommonEffectDescItem")

function CommonEffectDescItem:ctor(uiNode, view, desc)
  Super.ctor(self, uiNode, view)
  self.ui = CardKeyWordItem_New_InfoResource(uiNode)
  self._desc = desc
end

function CommonEffectDescItem:OnEnterComponent()
  self:_RefreshIcon()
  self:_RefreshName()
  self:_RefreshDesc()
  self:_RefreshSubDesc()
  self:_RefreshLayerCount()
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.gameObject)
end

function CommonEffectDescItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CommonEffectDescItem:_RefreshIcon()
  local icon = self._desc.icon
  if icon and "" ~= icon then
    if self._desc.useBigIcon then
      self:SetActive(self.ui.Image_Effect_Icon, false)
      self:SetActive(self.ui.Image_Effect_Icon2, true)
      self:SetImage(self.ui.Image_Effect_Icon2, icon)
    else
      self:SetActive(self.ui.Image_Effect_Icon, true)
      self:SetActive(self.ui.Image_Effect_Icon2, false)
      self:SetImage(self.ui.Image_Effect_Icon, icon)
    end
    self.ui.Text_Effect_Name.transform.localPosition = POS_HAVE_ICON
  else
    self:SetActive(self.ui.Image_Effect_Icon, false)
    self:SetActive(self.ui.Image_Effect_Icon2, false)
    self.ui.Text_Effect_Name.transform.localPosition = POS_NONE_ICON
  end
end

function CommonEffectDescItem:_RefreshName()
  self:SetText(self.ui.Text_Effect_Name, self._desc.name, nil, nil, {banKeywordBtn = true})
  self:_RemoveUnderline(self.ui.Text_Effect_Name)
end

function CommonEffectDescItem:_RefreshDesc()
  self:SetText(self.ui.Text_Effect_Desc, self._desc.desc, nil, nil, {banKeywordBtn = true})
  self:_RemoveUnderline(self.ui.Text_Effect_Desc)
  StrUtils.SetPreferredHeight(self.ui.Text_Effect_Desc)
end

function CommonEffectDescItem:_RefreshSubDesc()
  self:SetText(self.ui.Text_Effect_Sub_Desc, self._desc.subDesc, false, nil, {banKeywordBtn = true})
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Effect_Sub_Desc, 2)
end

function CommonEffectDescItem:_RefreshLayerCount()
  if not self._desc.layerCountList or 0 == #self._desc.layerCountList then
    return
  end
  local uiRes = PoolManager.Instance:GetItemUIResouce(CardKeyWordItem_LayerCountResource)
  local uiNode = uiRes.uiNode
  UIManager.InitUIPos(self.gameObject, uiNode)
  ClearAllTextInPrefab(uiNode)
  self:AddViewComponent(uiNode, CommonEffectStateLayerItem, self._desc.layerCountList, uiRes)
end

function CommonEffectDescItem:_RemoveUnderline(owner)
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  local text = textComp.text
  if string.find(text, "<u>", 1, true) then
    text = string.gsub(text, "<u>", "")
    text = string.gsub(text, "</u>", "")
    textComp.text = text
  end
end

return CommonEffectDescItem
