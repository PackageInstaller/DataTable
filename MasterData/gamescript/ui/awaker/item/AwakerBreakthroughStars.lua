local stateMask = {
  turnOff = 0,
  preTurnOn = 1,
  turnOn = 2,
  locate = 4,
  shining = 8
}
local AwakerBreakthroughStars = System.NewClass("AwakerBreakthroughStars")

function AwakerBreakthroughStars:ctor(uiRoot, numStars)
  self.uiRoot = uiRoot
  self:AdjustStarCount(numStars)
end

function AwakerBreakthroughStars:AdjustStarCount(numStars)
  self.stars = {}
  for idx = 0, self.uiRoot.transform.childCount - 1 do
    local starGO = self.uiRoot.transform:GetChild(idx).gameObject
    if idx < numStars then
      starGO:SetActive(true)
      local star = UI_Awaker_Item_PlanetResource(starGO)
      star.Image_Bg:SetActive(true)
      self:_SetState(star, stateMask.turnOff)
      table.insert(self.stars, star)
    else
      starGO:SetActive(false)
    end
  end
end

function AwakerBreakthroughStars:BindStarRed(binder, awakerTid)
  if not binder then
    return
  end
  for star, item in ipairs(self.stars) do
    if item then
      binder:BindComponent(RedDotComponent(item.Com_RedDot, CommonDefine.RedDotType.Dot, function()
        if not awakerTid then
          return false
        end
        local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
        if not awaker then
          return false
        end
        do return AwakerRedUtils.GetBreakthroughPreviewRed, awaker end
        return AwakerRedUtils.GetBreakthroughPreviewRed, awaker, star
      end))
    end
  end
end

function AwakerBreakthroughStars:NumStars()
  return #self.stars
end

function AwakerBreakthroughStars:TurnOff(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.turnOff)
  end
end

function AwakerBreakthroughStars:PreTurnOn(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.preTurnOn)
  end
end

function AwakerBreakthroughStars:TurnOn(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.turnOn)
  end
end

function AwakerBreakthroughStars:Locate(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.locate)
  end
end

function AwakerBreakthroughStars:Shining(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.shining)
  end
end

function AwakerBreakthroughStars:TurnOnAndShining(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.turnOn | stateMask.shining)
  end
end

function AwakerBreakthroughStars:TurnOnAndLocate(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.turnOn | stateMask.locate)
  end
end

function AwakerBreakthroughStars:TurnOffAndLocate(idx)
  local star = self.stars[idx]
  if star then
    self:_SetState(star, stateMask.turnOff | stateMask.locate)
  end
end

function AwakerBreakthroughStars:_SetState(star, mask)
  star.Image_Breathe:SetActive(stateMask.preTurnOn & mask > 0)
  star.Image_Bright:SetActive(stateMask.turnOn & mask > 0)
  star.Image_location:SetActive(stateMask.locate & mask > 0)
  star.Effect_Star_1:SetActive(stateMask.shining & mask > 0)
end

return AwakerBreakthroughStars
