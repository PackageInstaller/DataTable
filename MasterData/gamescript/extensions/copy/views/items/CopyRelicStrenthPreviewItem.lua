local RelicTypeNameMap = CommonDefine.GetRelicTypeNameMap()
local CopyRelicStrenthPreviewItem, Super = NewViewComponent("CopyRelicStrenthPreviewItem")

function CopyRelicStrenthPreviewItem:ctor(uiNode, view, relicTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dbgcopy_Item_RelicStrengthResource(uiNode)
  self.relicTid = relicTid
  self.relicCfg = RelicCfgUtils.GetCfg(self.relicTid)
end

function CopyRelicStrenthPreviewItem:RegisterEvents()
end

function CopyRelicStrenthPreviewItem:OnEnterComponent()
  self:SetText(self.ui.Text_Desc, LT.Text(self:GetRelicDesc()))
  self:BindTimer(0.05, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Desc)
  end)
  self:SetText(self.ui.Text_Name, LT.Text(self.relicCfg.Name))
  self:SetText(self.ui.Text_Type, LT.Text(RelicTypeNameMap[self.relicCfg.Quality]))
  self:SetImage(self.ui.Image_Relic, self.relicCfg.Icon)
end

function CopyRelicStrenthPreviewItem:GetRelicDesc()
  do return RelicDataUtils.GetRelicDesc, self.relicTid, nil, WorldStageManager.Instance:GetCurStageId() end
  return RelicDataUtils.GetRelicDesc, self.relicTid, nil, WorldStageManager.Instance:GetCurStageId()
end

return CopyRelicStrenthPreviewItem
