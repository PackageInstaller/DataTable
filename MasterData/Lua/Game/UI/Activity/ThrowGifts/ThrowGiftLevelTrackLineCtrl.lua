local ThrowGiftLevelTrackLineCtrl = class("ThrowGiftLevelTrackLineCtrl", BaseCtrl)
ThrowGiftLevelTrackLineCtrl._mapNodeConfig = {
  TemplateDot = {},
  rtPool = {sComponentName = "Transform"}
}
ThrowGiftLevelTrackLineCtrl._mapEventConfig = {}
ThrowGiftLevelTrackLineCtrl._mapRedDotConfig = {}

function ThrowGiftLevelTrackLineCtrl:Awake()
  self.tbCurDot = {}
  self.tbPool = {}
  self.nPrevTimer = 0
end

function ThrowGiftLevelTrackLineCtrl:FadeIn()
end

function ThrowGiftLevelTrackLineCtrl:FadeOut()
end

function ThrowGiftLevelTrackLineCtrl:OnEnable()
end

function ThrowGiftLevelTrackLineCtrl:OnDisable()
  self:DestroyAll()
end

function ThrowGiftLevelTrackLineCtrl:OnDestroy()
end

function ThrowGiftLevelTrackLineCtrl:OnRelease()
end

function ThrowGiftLevelTrackLineCtrl:DestroyAll()
  for _, rtDot in ipairs(self.tbCurDot) do
    destroy(rtDot.gameObject)
  end
  for _, rtDot in ipairs(self.tbPool) do
    destroy(rtDot.gameObject)
  end
  self.tbCurDot = {}
  self.tbPool = {}
end

function ThrowGiftLevelTrackLineCtrl:Reset()
  for _, rtDot in ipairs(self.tbCurDot) do
    table.insert(self.tbPool, rtDot)
    rtDot:SetParent(self._mapNode.rtPool)
  end
  self.tbCurDot = {}
  self.nPrevTimer = 0
end

function ThrowGiftLevelTrackLineCtrl:GetDot()
  if #self.tbPool > 0 then
    local rtDot = table.remove(self.tbPool)
    rtDot:SetParent(self.gameObject.transform)
    table.insert(self.tbCurDot, rtDot)
    return rtDot
  end
  local goDot = instantiate(self._mapNode.TemplateDot, self.gameObject.transform)
  goDot:SetActive(true)
  local rtDot = goDot:GetComponent("RectTransform")
  table.insert(self.tbCurDot, rtDot)
  return rtDot
end

function ThrowGiftLevelTrackLineCtrl:AddDot(v2Pos)
  local rtDot = self:GetDot()
  rtDot.anchoredPosition = v2Pos
end

return ThrowGiftLevelTrackLineCtrl
