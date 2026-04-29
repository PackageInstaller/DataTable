_class("UIN20AVGGraphNodeBase", UICustomWidget)
UIN20AVGGraphNodeBase = UIN20AVGGraphNodeBase

function UIN20AVGGraphNodeBase:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGGraphNodeBase:OnShow()
  self.atlas = self:GetAsset("UIAVG.spriteatlas", LoadType.SpriteAtlas)
  self.curPos = self:GetGameObject("curPos")
  self:InitComponent()
end

function UIN20AVGGraphNodeBase:OnHide()
end

function UIN20AVGGraphNodeBase:InitComponent()
  self.imgBG = self:GetUIComponent("Image", "imgBG")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
end

function UIN20AVGGraphNodeBase:Flush(id)
  self.node = self.data:GetNodeById(id)
  self:FlushName()
  self:FlushState()
  self:FlushNew()
end

function UIN20AVGGraphNodeBase:FlushName()
end

function UIN20AVGGraphNodeBase:FlushCurPos(endId)
  if 0 < endId then
    if self.node:IsEnd() then
      if self.node.endId == endId then
        self.curPos:SetActive(true)
      else
        self.curPos:SetActive(false)
      end
    else
      self.curPos:SetActive(false)
    end
  else
    local curNodeId = self.data:CurNodeId()
    if curNodeId == self.node.id then
      self.curPos:SetActive(true)
    else
      self.curPos:SetActive(false)
    end
  end
end

function UIN20AVGGraphNodeBase:FlushState()
end

function UIN20AVGGraphNodeBase:FlushNew()
end
