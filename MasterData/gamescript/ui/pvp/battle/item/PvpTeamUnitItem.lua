local TMP_Text = CS.TMPro.TMP_Text
local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local PvpTeamUnitItem, Super = System.NewComponent("PvpTeamUnitItem")

function PvpTeamUnitItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_DispositionResource(uiNode)
  self.iconFunc = data.iconFunc
  self.nameFunc = data.nameFunc
  self.collectionType = data.collectionType
  self.nameFrameFunc = data.nameFrameFunc
end

function PvpTeamUnitItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Name, self.nameFunc)
  binder:BindToImage(self.ui.Image_Icon, self.iconFunc)
  binder:BindToImage(self.ui.Image_Skill, self.iconFunc)
  binder:BindToImage(self.ui.Image_Name, function()
    return self.nameFrameFunc and self.nameFrameFunc()
  end)
  binder:BindToVisible(self.ui.Image_Icon, function()
    return not self:_ShowWithMask(self.collectionType)
  end)
  binder:BindToVisible(self.ui.Image_Mask, function()
    do return self._ShowWithMask, self end
    return self._ShowWithMask, self, self.collectionType
  end)
  local tmp = self.ui.Text_Name.gameObject:GetComponent(typeof(TMP_Text))
  local viewWidth = self.ui.ScrollView.gameObject.transform.sizeDelta.x
  local textWidth = tmp.preferredWidth
  if viewWidth < textWidth then
    tmp.alignment = TextAlignmentOptions.Left
  else
    tmp.alignment = TextAlignmentOptions.Center
  end
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
end

function PvpTeamUnitItem:_ShowWithMask(type)
  do return table.contains, {
    CommonDefine.PVPCollectionType.Weapon
  } end
  return table.contains, {
    CommonDefine.PVPCollectionType.Weapon
  }, type
end

return PvpTeamUnitItem
