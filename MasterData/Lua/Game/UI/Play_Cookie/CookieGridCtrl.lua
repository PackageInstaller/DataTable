local CookieGridCtrl = class("CookieGridCtrl", BaseCtrl)
CookieGridCtrl._mapNodeConfig = {
  imgCookieIcon = {sComponentName = "Image"},
  imgTips = {},
  imgHalo_01 = {},
  imgHalo_02 = {},
  imgHeart = {}
}
local CookieShapeEnum = {
  Gear = 1,
  Wrench = 2,
  Ruler = 3,
  Lens = 4
}
local IconPathDefault = {
  [CookieShapeEnum.Gear] = "UI_Activity/_400016/SpriteAtlas/Sprite/zs_cookie_01",
  [CookieShapeEnum.Lens] = "UI_Activity/_400016/SpriteAtlas/Sprite/zs_cookie_04",
  [CookieShapeEnum.Ruler] = "UI_Activity/_400016/SpriteAtlas/Sprite/zs_cookie_03",
  [CookieShapeEnum.Wrench] = "UI_Activity/_400016/SpriteAtlas/Sprite/zs_cookie_02"
}
local nPerfectTiming = 0.33
local colorPerfect = Color(1.0, 0.302, 0.796, 1.0)

function CookieGridCtrl:Init(nShape, nGreatTime, nPerfectTime)
  self.animator = self.gameObject:GetComponent("Animator")
  self.nShape = nShape
  self:SetPngSprite(self._mapNode.imgCookieIcon, IconPathDefault[nShape])
  NovaAPI.SetImageColor(self._mapNode.imgCookieIcon, Color(1, 1, 1, 0.15))
  self:SetSelect(false)
  self:PlayEnterAnim()
  self.nGreatTime = nGreatTime
  self.nPerfectTime = nPerfectTime
end

function CookieGridCtrl:SetFilled()
  NovaAPI.SetImageColor(self._mapNode.imgCookieIcon, Color(1, 1, 1, 1))
  self:PlayEnterAnim()
end

function CookieGridCtrl:GetGirdShape()
  if nil ~= self.nShape then
    return self.nShape
  end
  return 0
end

function CookieGridCtrl:SetSelect(bActive)
  self._mapNode.imgTips:SetActive(bActive)
end

function CookieGridCtrl:PlayLightAnim()
  self._mapNode.imgHalo_01:SetActive(false)
  self._mapNode.imgHalo_02:SetActive(false)
  self.animator:Play("CookieGrid_Light")
end

function CookieGridCtrl:PlayWrongAnim(nBlockTime, bShowHeart)
  self._mapNode.imgHalo_01:SetActive(false)
  self._mapNode.imgHalo_02:SetActive(false)
  if nBlockTime == nil or nBlockTime <= 0 then
    nBlockTime = 1
  end
  self._mapNode.imgHeart:SetActive(bShowHeart == true)
  local nAnimLength = NovaAPI.GetAnimClipLength(self.animator, {
    "CookieGrid_wrong"
  })
  local nSpeed = nAnimLength / nBlockTime
  self.animator:SetFloat("WrongSpeed", nSpeed or 1)
  self.animator:Play("CookieGrid_wrong", 0, 0)
end

function CookieGridCtrl:PlayHaloAnim(nSpeed)
  self._mapNode.imgHalo_01:SetActive(true)
  self._mapNode.imgHalo_02:SetActive(true)
  self.animator:SetFloat("PlaySpeed", nSpeed or 1)
  self.animator:Play("CookieGrid_play", 0, 0)
  self:StartFadingColor()
end

function CookieGridCtrl:StartFadingColor()
  if self.timerColorFade ~= nil then
    self.timerColorFade:Cancel()
    self.timerColorFade = nil
  end
  GameUIUtils.SetUIMaterialAnimationColorValue1(self._mapNode.imgHalo_01.gameObject, 1, 1, 1, 1)
  local nTimeNeed = self.nGreatTime - self.nPerfectTime
  self.colorCur = Color(1, 1, 1, 1)
  self.nColorTime = 0
  self.timerColorFade = self:AddTimer(0, 0.034, function()
    self.nColorTime = self.nColorTime + 0.034
    local tempColor = self:_LerpColor(self.colorCur, colorPerfect, self.nColorTime, nTimeNeed)
    GameUIUtils.SetUIMaterialAnimationColorValue1(self._mapNode.imgHalo_01.gameObject, tempColor.r, tempColor.g, tempColor.b, tempColor.a)
  end, true, true, true)
  self:AddTimer(1, nTimeNeed + 0.1, function()
    if self.timerColorFade ~= nil then
      self.timerColorFade:Cancel()
      self.timerColorFade = nil
    end
    self._mapNode.imgHalo_01:SetActive(false)
    self._mapNode.imgHalo_02:SetActive(false)
  end, true, true, true)
end

function CookieGridCtrl:_LerpColor(currentColor, targetColor, elapsedTime, totalTime)
  if totalTime <= 0 then
    return {
      r = targetColor.r,
      g = targetColor.g,
      b = targetColor.b,
      a = targetColor.a or 1
    }
  end
  local t = elapsedTime / totalTime
  if 1 < t then
    t = 1
  end
  if t < 0 then
    t = 0
  end
  local res = Color(currentColor.r + (targetColor.r - currentColor.r) * t, currentColor.g + (targetColor.g - currentColor.g) * t, currentColor.b + (targetColor.b - currentColor.b) * t, (currentColor.a or 1) + ((targetColor.a or 1) - (currentColor.a or 1)) * t)
  return res
end

function CookieGridCtrl:StopAllAnim()
  self.animator:Play("Empty", 0, 0)
  self._mapNode.imgHalo_01:SetActive(false)
  self._mapNode.imgHalo_02:SetActive(false)
end

function CookieGridCtrl:PlayEnterAnim()
  self._mapNode.imgHalo_01:SetActive(false)
  self._mapNode.imgHalo_02:SetActive(false)
  self.animator:Play("CookieGrid_in", 0, 0)
end

return CookieGridCtrl
