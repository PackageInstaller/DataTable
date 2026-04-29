_class("UIN28AVGGraphLineStraight", UICustomWidget)
UIN28AVGGraphLineStraight = UIN28AVGGraphLineStraight

function UIN28AVGGraphLineStraight:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGGraphLineStraight:OnShow()
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Left(self.rt)
  self.root = self:GetUIComponent("RectTransform", "root")
  self.dot = self:GetGameObject("dot")
  self.solid = self:GetGameObject("solid")
end

function UIN28AVGGraphLineStraight:OnHide()
end

function UIN28AVGGraphLineStraight:Flush(s, e, isDot)
  local vec = e - s
  local vec3From, vec3To = Vector3.right, Vector3(vec.x, vec.y, 0)
  local quat = Quaternion.FromToRotation(vec3From, vec3To)
  self.rt.anchoredPosition = s
  self.rt.localRotation = quat
  self.root.sizeDelta = Vector2(Vector2.Magnitude(vec), self.root.sizeDelta.y)
  if isDot then
    self.dot:SetActive(true)
    self.solid:SetActive(false)
  else
    self.dot:SetActive(false)
    self.solid:SetActive(true)
  end
end
