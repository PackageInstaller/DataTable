_class("UIN28AVGGraphNodeBase", UICustomWidget)
UIN28AVGGraphNodeBase = UIN28AVGGraphNodeBase

function UIN28AVGGraphNodeBase:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGGraphNodeBase:OnShow()
  self.atlas = self:GetAsset("UIN28AVG.spriteatlas", LoadType.SpriteAtlas)
  self.curPos = self:GetGameObject("curPos")
  self:InitComponent()
end

function UIN28AVGGraphNodeBase:OnHide()
end

function UIN28AVGGraphNodeBase:InitComponent()
  self.imgBG = self:GetUIComponent("Image", "imgBG")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtName1 = self:GetUIComponent("UILocalizationText", "txtName1")
  self.txtName1Outline = self:GetUIComponent("H3D.UGUI.CircleOutline", "txtName1")
end

function UIN28AVGGraphNodeBase:Flush(id)
  self.node = self.data:GetNodeById(id)
  self:FlushName()
  self:FlushState()
  self:FlushNew()
end

function UIN28AVGGraphNodeBase:FlushName()
end

function UIN28AVGGraphNodeBase:FlushCurPos(endId, nodeId)
  if 0 < endId then
    if self.node:IsEnd() then
      if nodeId == self.node.id and self.node.endId == endId then
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

function UIN28AVGGraphNodeBase:FlushState()
end

function UIN28AVGGraphNodeBase:FlushNew()
end
