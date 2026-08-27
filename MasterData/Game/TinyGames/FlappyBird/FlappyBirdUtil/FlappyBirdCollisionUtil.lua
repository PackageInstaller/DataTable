local FlappyBirdCollisionUtil = {}

function FlappyBirdCollisionUtil.IsRectRectOnCollission(entityAPos, entityAColliBox, entityBPos, entityBColliBox)
  local r1Left = entityAPos.x + entityAColliBox.left
  local r1Bottom = entityAPos.y + entityAColliBox.bottom
  local r1Right = entityAPos.x + entityAColliBox.right
  local r1Top = entityAPos.y + entityAColliBox.top
  local r2Left = entityBPos.x + entityBColliBox.left
  local r2Bottom = entityBPos.y + entityBColliBox.bottom
  local r2Right = entityBPos.x + entityBColliBox.right
  local r2Top = entityBPos.y + entityBColliBox.top
  return not (r1Right < r2Left) and not (r1Left > r2Right) and not (r1Top < r2Bottom) and not (r1Bottom > r2Top)
end

return FlappyBirdCollisionUtil
