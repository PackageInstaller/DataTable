_class("UIN20AVGCollectionItem", UICustomWidget)
UIN20AVGCollectionItem = UIN20AVGCollectionItem

function UIN20AVGCollectionItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGCollectionItem:OnShow()
  self.normal = self:GetGameObject("normal")
  self.lock = self:GetGameObject("lock")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.select = self:GetGameObject("select")
  self.red = self:GetGameObject("red")
  self.new = self:GetGameObject("new")
end

function UIN20AVGCollectionItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN20AVGCollectionItem:Flush(endId, clickCallback)
  self.endId = endId
  local ending = self.data:GetEndingById(endId)
  local state = ending:AwardState()
  if state then
    self.normal:SetActive(true)
    self.lock:SetActive(false)
    local node = self.data:GetNodeByEndId(ending.id)
    self.imgIcon:LoadImage(node.cg)
    self.txtName:SetText(ending.title)
  else
    self.normal:SetActive(false)
    self.lock:SetActive(true)
  end
  self.clickCallback = clickCallback
  self:FlushNew()
  self:FlushRed()
end

function UIN20AVGCollectionItem:FlushNew()
  local ending = self.data:GetEndingById(self.endId)
  local hasNew = ending:HasNew()
  self.new:SetActive(hasNew)
end

function UIN20AVGCollectionItem:FlushRed()
  local ending = self.data:GetEndingById(self.endId)
  local hasRed = ending:HasRed()
  self.red:SetActive(hasRed)
end

function UIN20AVGCollectionItem:FlushSelect(isSelect)
  self.select:SetActive(isSelect)
end

function UIN20AVGCollectionItem:EndId()
  return self.endId
end

function UIN20AVGCollectionItem:btnOnClick(go)
  if self.clickCallback then
    self:clickCallback()
  end
end
