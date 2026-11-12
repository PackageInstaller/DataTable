local Avg_9_CurtainCtrl = class("Avg_9_CurtainCtrl", BaseCtrl)
Avg_9_CurtainCtrl._mapNodeConfig = {
  imgCurtain = {sComponentName = "Image"}
}
Avg_9_CurtainCtrl._mapEventConfig = {
  [EventId.AvgSetCurtain] = "OnEvent_SetCurtain"
}

function Avg_9_CurtainCtrl:OnEnable()
  self.gameObject:SetActive(false)
end

function Avg_9_CurtainCtrl:SetEnd(bVisible)
  self.gameObject:SetActive(true)
  local nDuration = 1
  NovaAPI.ImageDoFade(self._mapNode.imgCurtain, bVisible == true and 0 or 1, nDuration, true)
  return nDuration
end

function Avg_9_CurtainCtrl:OnEvent_SetCurtain(bVisible)
  self:SetEnd(bVisible)
end

return Avg_9_CurtainCtrl
