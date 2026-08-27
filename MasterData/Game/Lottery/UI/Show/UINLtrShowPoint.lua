local UINLtrShowPoint = class("UINLtrShowPoint", UIBaseNode)
local base = UIBaseNode

function UINLtrShowPoint:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrShowPoint:InitLtrShowPoint(pos, fromPos, rare, from)
  local color = self.ui.imgRing1.color
  color.a = 0
  self.ui.imgRing1.color = color
  self.ui.imgRing2.color = color
  self:__ClearLineTween()
  self:__ClearPointTween()
  self.ui.flare:SetActive(false)
  self.bingoItem = nil
  self.rare = rare
  self.transform.anchoredPosition = pos
  if from ~= nil and from.entered == true then
    from.entered = false
    from.ui.anim:Rewind()
    from.ui.anim:Play("UI_LSPoint_Exit")
  end
  if rare == nil then
    self.pointFadeTween = self.ui.img_Point:DOFade(0, 0.5)
    self.ui.line.gameObject:SetActive(false)
  else
    self.ui.anim:Play("UI_LSPoint_Enter")
    self.entered = true
    self.ui.line.gameObject:SetActive(true)
    local localFromPos = fromPos - pos
    self.ui.line.transform.anchoredPosition = localFromPos
    local cross = Vector3.Cross(Vector3.New(localFromPos.x, localFromPos.y, 0), Vector3.right)
    local angle = Vector2.Angle(localFromPos, Vector2.right)
    if 0 < cross.z then
      angle = angle * -1
    end
    angle = angle + 180
    self.ui.line.transform.localEulerAngles = Vector3.New(0, 0, angle)
    local sizeDelta = self.ui.line.transform.sizeDelta
    sizeDelta.x = 0
    self.ui.line.transform.sizeDelta = sizeDelta
    sizeDelta.x = Vector2.Distance(localFromPos, Vector2.zero)
    self._lineTween = self.ui.line.transform:DOSizeDelta(sizeDelta, 0.3):SetDelay(0.5):OnPlay(function()
      AudioManager:PlayAudioById(1113)
    end)
  end
end

function UINLtrShowPoint:SetLtrPointBingo(bingoItem)
  self.bingoItem = bingoItem
end

function UINLtrShowPoint:GetLtrPointBingo()
  return self.bingoItem
end

function UINLtrShowPoint:ShowLtrSPointFlare()
  if self.entered == false then
    return
  end
  self.ui.flare:SetActive(true)
  local color = self.ui.rareColor[self.rare]
  local main1 = self.ui.flareParticle1.main
  local startColor = main1.startColor
  startColor.color = color
  main1.startColor = startColor
  local main2 = self.ui.flareParticle2.main
  main2.startColor = startColor
  if self.rare == eHeroCardRareType.R then
    AudioManager:PlayAudioById(1048)
  elseif self.rare == eHeroCardRareType.SR then
    AudioManager:PlayAudioById(1049)
  elseif self.rare == eHeroCardRareType.SSR then
    AudioManager:PlayAudioById(1050)
  end
end

function UINLtrShowPoint:__ClearLineTween()
  if self._lineTween ~= nil then
    self._lineTween:Kill()
    self._lineTween = nil
  end
end

function UINLtrShowPoint:__ClearPointTween()
  if self.pointFadeTween ~= nil then
    self.pointFadeTween:Kill()
    self.pointFadeTween = nil
  end
end

function UINLtrShowPoint:OnDelete()
  self:__ClearLineTween()
  self:__ClearPointTween()
  base.OnDelete(self)
end

return UINLtrShowPoint
