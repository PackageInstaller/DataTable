local CollectHistryDetailCom, Super = NewViewComponent("CollectHistryDetailCom")

function CollectHistryDetailCom:ctor(uiNode, view, collectTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_History_DetailsResource(uiNode)
  self._descComList = {}
end

function CollectHistryDetailCom:OnBuildComponent()
end

function CollectHistryDetailCom:OnEnterComponent()
end

function CollectHistryDetailCom:RegisterEvents()
end

function CollectHistryDetailCom:UpdateViewData(collectTid)
  self._collectTid = collectTid
  self._collectCfg = CollectionHallCfgUtils.GetCfg(collectTid)
end

function CollectHistryDetailCom:RefreshView()
  self:_RefreshTitle()
  self:_RefreshImage()
  self:_RefreshContent()
end

function CollectHistryDetailCom:_RefreshContent()
  local contentList = CollectionHallCfgUtils.GetContentList(self._collectTid)
  local scrollRect = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  scrollRect.verticalNormalizedPosition = 1
  local contentLen = #contentList
  for i = 1, contentLen do
    local targetData = contentList[i]
    local com = self._descComList[i]
    if com then
      com:Show()
      com:UpdateViewData(targetData)
      com:RefreshView()
    else
      local obj = self:_CreateDescObj()
      com = self:AddViewComponentOnce(obj, OrganizationDescItem, targetData)
      self._descComList[i] = com
    end
  end
  if contentLen < #self._descComList then
    for i = contentLen + 1, #self._descComList do
      self._descComList[i]:Hide()
    end
  end
end

function CollectHistryDetailCom:_CreateDescObj()
  local obj = GameObject.Instantiate(self.ui.UI_Collection_Image_Container, self.ui.Content.transform)
  obj:SetActive(true)
  return obj
end

function CollectHistryDetailCom:_RefreshImage()
  local picture = self._collectCfg.Picture
  if not picture then
    self:SetActive(self.ui.Group_CG, false)
    self:SetActive(self.ui.Image_Normal, true)
    return
  end
  self:SetActive(self.ui.Image_Normal, false)
  self:SetActive(self.ui.Group_CG, true)
  self:SetImage(self.ui.Image_CG, picture)
end

function CollectHistryDetailCom:_RefreshTitle()
  local prefix, suffix = CollectionHallCfgUtils.GetCollectionHistoryTitle(self._collectTid)
  self:SetText(self.ui.Text_Century, prefix)
  self:SetText(self.ui.Text_Title, suffix)
end

function CollectHistryDetailCom:Hide()
  self:SetActive(self.ui.uiNode, false)
end

function CollectHistryDetailCom:Show()
  self:SetActive(self.ui.uiNode, true)
end

return CollectHistryDetailCom
