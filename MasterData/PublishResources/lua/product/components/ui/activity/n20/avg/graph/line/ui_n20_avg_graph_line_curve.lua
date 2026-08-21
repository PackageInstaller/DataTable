_class("UIN20AVGGraphLineCurve", UICustomWidget)
UIN20AVGGraphLineCurve = UIN20AVGGraphLineCurve

function UIN20AVGGraphLineCurve:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
  self.quats = {
    [1] = Quaternion.Euler(0, 0, 0),
    [2] = Quaternion.Euler(0, 0, 90),
    [3] = Quaternion.Euler(0, 0, 180),
    [4] = Quaternion.Euler(0, 0, -90)
  }
end

function UIN20AVGGraphLineCurve:OnShow()
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Left(self.rt)
  self.dot = self:GetGameObject("dot")
  self.solid = self:GetGameObject("solid")
end

function UIN20AVGGraphLineCurve:OnHide()
end

function UIN20AVGGraphLineCurve:Flush(posPrev, pos, posNext, isDot)
  self.rt.anchoredPosition = pos
  local quat
  if posNext.x > posPrev.x and posNext.y > posPrev.y then
    if pos.y > posPrev.y and pos.x < posNext.x then
      quat = self.quats[1]
    else
      quat = self.quats[3]
    end
  elseif pos.y > posNext.y and pos.x > posPrev.x then
    quat = self.quats[4]
  else
    quat = self.quats[2]
  end
  self.rt.localRotation = quat
  if isDot then
    self.dot:SetActive(true)
    self.solid:SetActive(false)
  else
    self.dot:SetActive(false)
    self.solid:SetActive(true)
  end
end
