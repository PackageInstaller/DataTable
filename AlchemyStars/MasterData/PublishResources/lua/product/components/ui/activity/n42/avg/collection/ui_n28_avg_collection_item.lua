_class("UIN28AVGCollectionItem", UICustomWidget)
UIN28AVGCollectionItem = UIN28AVGCollectionItem

function UIN28AVGCollectionItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGCollectionItem:OnShow()
  self.normal = self:GetGameObject("normal")
  self.lock = self:GetGameObject("lock")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.imgIconObj = self:GetGameObject("imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtName1 = self:GetUIComponent("UILocalizationText", "txtName1")
  self.select = self:GetGameObject("select")
  self.red = self:GetGameObject("red")
  self.new = self:GetGameObject("new")
end

function UIN28AVGCollectionItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN28AVGCollectionItem:Flush(endId, clickCallback)
  self.endId = endId
  local ending = self.data:GetEndingById(endId)
  local state = ending:AwardState()
  if state then
    self.normal:SetActive(true)
    self.lock:SetActive(false)
    self.imgIcon:LoadImage(ending.cgCollectTab)
    self.txtName:SetText(ending.title)
    self.txtName1:SetText(ending.title)
    self.imgIconObj:SetActive(true)
  else
    self.imgIconObj:SetActive(false)
    self.normal:SetActive(false)
    self.lock:SetActive(true)
  end
  self.clickCallback = clickCallback
  self:FlushNew()
  self:FlushRed()
end

function UIN28AVGCollectionItem:FlushNew()
  local ending = self.data:GetEndingById(self.endId)
  local hasNew = ending:HasNew()
  self.new:SetActive(hasNew)
end

function UIN28AVGCollectionItem:FlushRed()
  local ending = self.data:GetEndingById(self.endId)
  local hasRed = ending:HasRed()
  self.red:SetActive(hasRed)
end

function UIN28AVGCollectionItem:FlushSelect(isSelect)
  self.select:SetActive(isSelect)
end

function UIN28AVGCollectionItem:EndId()
  return self.endId
end

function UIN28AVGCollectionItem:BtnOnClick(go)
  if self.clickCallback then
    self:clickCallback()
  end
end
