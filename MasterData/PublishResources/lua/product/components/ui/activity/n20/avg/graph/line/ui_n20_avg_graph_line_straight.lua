_class("UIN20AVGGraphLineStraight", UICustomWidget)
UIN20AVGGraphLineStraight = UIN20AVGGraphLineStraight

function UIN20AVGGraphLineStraight:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGGraphLineStraight:OnShow()
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Left(self.rt)
  self.root = self:GetUIComponent("RectTransform", "root")
  self.dot = self:GetGameObject("dot")
  self.solid = self:GetGameObject("solid")
end

function UIN20AVGGraphLineStraight:OnHide()
end

function UIN20AVGGraphLineStraight:Flush(s, e, isDot)
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
