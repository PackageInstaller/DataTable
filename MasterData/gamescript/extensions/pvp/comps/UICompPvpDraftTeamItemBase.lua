local UICompPvpDraftTeamItemBase, Super = NewViewComponent("UICompPvpDraftTeamItemBase")

function UICompPvpDraftTeamItemBase:ctor(uiNode, view, collectionTid, playerData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_PVP_Item_RotationTeamResource(uiNode)
  self._collectionTid = collectionTid
  self._playerData = playerData
end

function UICompPvpDraftTeamItemBase:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpDraftTeamItemBase:_RefreshView()
  if not self._collectionTid then
    self:SetActive(self.ui.Group_Empty, true)
    self:SetActive(self.ui.Group_Info, false)
    return
  end
  self:SetActive(self.ui.Group_Empty, false)
  self:SetActive(self.ui.Group_Info, true)
  self:SetImage(self.ui.Image_Card, self:_GetCollectImage(), false)
  self:_RefreshQualityBg()
end

function UICompPvpDraftTeamItemBase:_GetCollectImage()
  Logger.Error("Please override UICompPvpDraftTeamItemBase:_GetCollectImage")
end

function UICompPvpDraftTeamItemBase:_RefreshQualityBg()
  Logger.Error("Please override UICompPvpDraftTeamItemBase:_GetCollectImage")
end

return UICompPvpDraftTeamItemBase
