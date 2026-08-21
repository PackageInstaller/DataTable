_class("BodyAreaHelper", Object)
BodyAreaHelper = BodyAreaHelper

function BodyAreaHelper.IsPosInBodyArea(bodyArea, pos)
  for i, v in ipairs(bodyArea) do
    if v.x == pos.x and v.y == pos.y then
      return true
    end
  end
end

function BodyAreaHelper.GetBodyAreaLeft(area)
  local x = area[1].x
  for i = 2, #area do
    if x > area[i].x then
      x = area[i].x
    end
  end
  return x
end

function BodyAreaHelper.GetBodyAreaRight(area)
  local x = area[1].x
  for i = 2, #area do
    if x < area[i].x then
      x = area[i].x
    end
  end
  return x
end

function BodyAreaHelper.GetBodyAreaUp(area)
  local y = area[1].y
  for i = 2, #area do
    if y < area[i].y then
      y = area[i].y
    end
  end
  return y
end

function BodyAreaHelper.GetBodyAreaDown(area)
  local y = area[1].y
  for i = 2, #area do
    if y > area[i].y then
      y = area[i].y
    end
  end
  return y
end
