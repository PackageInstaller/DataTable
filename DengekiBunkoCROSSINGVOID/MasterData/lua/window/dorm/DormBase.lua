local WU, DB, REF = require("Common/WindowUtil")(this)
GridStyle = {
  Normal = 0,
  Wall = 1,
  FlippedWall = 2
}
local IsometricTools = CS.IsometricGame.IsometricTools
local BoxTerm = CS.IsometricGame.BoxTerm
local m_gridSprite, m_wallGridSprite, m_flippedWallGridSprite, m_cachedSortedBoxes, m_cntExtraGrid, m_gridTable, m_dormCamera, m_gridPrefab, m_dormHome, m_movableBoard
m_arrSuccFlag = nil
m_root = nil
m_board = nil
m_size = nil
m_aiOptions = {enableActorInteractive = true}

function PreloadResource()
  m_gridPrefab = WU.AcquireAsset("Window/Dorm/Furniture/grid")
  m_gridSprite = WU.AcquireAssetSprite("Texture/DormSprite/grid")
  m_wallGridSprite = WU.AcquireAssetSprite("Texture/DormSprite/wall_grid")
  m_flippedWallGridSprite = WU.AcquireAssetSprite("Texture/DormSprite/wall_grid_flip")
end

function SetupBase(dormHome)
  PreloadResource()
  m_dormHome = dormHome
  m_root = REF.DormRoot.IsometricRoot
  m_board = REF.DormRoot.IsometricBoard
end

function InitBase(size)
  m_cntExtraGrid = math.ceil(CS.IsometricGame.IsometricTools.GRID_HEIGHT_OVERLAP * size.z)
  if size ~= m_size then
    if m_gridTable ~= nil then
      for _, grid in pairs(m_gridTable) do
        CS.UnityEngine.GameObject.Destroy(grid)
      end
    end
    m_gridTable = {}
  end
  m_movableBoard = CS.MovableBoard()
  m_movableBoard:Init(size)
  m_root:Init(size)
  m_board:Init(size)
  m_size = size
end

function DeactiveAllGrid()
  for _, grid in pairs(m_gridTable) do
    WU.SetActive(grid, false)
  end
end

function ActiveGrid(x, y, active, color, style, sortingOrder)
  if x >= -m_cntExtraGrid and x < m_size.x and 0 <= y and y < m_size.y + m_cntExtraGrid then
    local coord = x + m_cntExtraGrid + y * (m_size.x + m_cntExtraGrid)
    local grid = m_gridTable[coord]
    if grid == nil then
      m_gridTable[coord] = CS.UnityEngine.GameObject.Instantiate(m_gridPrefab, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Quaternion.identity, m_dormHome.transform)
      grid = m_gridTable[coord]
      local p = IsometricTools.IsoToCart(m_root.unitSize, CS.UnityEngine.Vector3(x, y, 0))
      p = m_root.transform:TransformPoint(p)
      grid.transform.position = p
    end
    WU.SetActive(grid, active)
    local sprr = grid:GetComponent(typeof(CS.UnityEngine.SpriteRenderer))
    sprr.color = color
    local sprite = m_gridSprite
    local bgTrans = grid.transform:GetChild(0)
    bgTrans.gameObject:SetActive(false)
    grid.transform:GetChild(1).gameObject:SetActive(false)
    grid.transform:GetChild(2).gameObject:SetActive(false)
    if style == GridStyle.Wall then
      sprite = m_wallGridSprite
      bgTrans = grid.transform:GetChild(1)
    elseif style == GridStyle.FlippedWall then
      sprite = m_flippedWallGridSprite
      bgTrans = grid.transform:GetChild(2)
    end
    sprr.sprite = sprite
    sprr.sortingOrder = sortingOrder
    bgTrans.gameObject:SetActive(true)
    bgTrans:GetComponent(typeof(CS.UnityEngine.SpriteRenderer)).sortingOrder = sortingOrder - 1
  end
end

function CheckOutOfBound(box)
  local bd = box.bound
  local pos = box.isoPosition
  return not (pos.x + bd.x > m_size.x) and not (pos.y + bd.y > m_size.y)
end

function RearrangeAllBox()
  m_arrSuccFlag = true
  for i = 0, m_root.boxList.size - 1 do
    local box = m_root.boxList[i]
    m_arrSuccFlag = CheckOutOfBound(box)
    if not m_arrSuccFlag then
      warning("GamePlay", string.format("[Dorm] %s is out of dorm range", box.gameObject.name))
      break
    end
  end
  for i = 0, m_root.borderList.size - 1 do
    local box = m_root.borderList[i]
    if box.term == BoxTerm.Carpet then
      m_arrSuccFlag = CheckOutOfBound(box)
      if not m_arrSuccFlag then
        warning("GamePlay", string.format("[Dorm] %s is out of dorm range", box.gameObject.name))
        break
      end
    end
  end
  if m_arrSuccFlag then
    m_arrSuccFlag = false
    local boxList = m_root.boxList:Clone()
    local i = boxList.size - 1
    while 0 <= i do
      local box = boxList[i]
      if box.term == BoxTerm.Dynamic and not box.gameObject.activeSelf then
        boxList:RemoveAt(i)
      end
      i = i - 1
    end
    local sortedBoxes = m_root:SortBox(m_root.borderList, boxList)
    if sortedBoxes ~= nil then
      m_arrSuccFlag = true
      m_cachedSortedBoxes = sortedBoxes
      m_board:Purge()
      for i = 0, m_cachedSortedBoxes.Length - 1 do
        m_board:AddBox(m_cachedSortedBoxes[i])
      end
    end
  end
  if m_cachedSortedBoxes ~= nil then
    for i = 0, m_cachedSortedBoxes.Length - 1 do
      if m_cachedSortedBoxes[i] then
        PlaceTransform(m_cachedSortedBoxes[i], i)
      end
    end
  else
    warning("GamePlay", "[Dorm] Error occured when rearrange boxes")
  end
  return m_arrSuccFlag
end

function PlaceTransform(box, sortingOrder)
  local p = CS.IsometricGame.IsometricTools.IsoToCart(box.unitSize, box.isoPositionRaw)
  p = box.root.transform:TransformPoint(p)
  box.transform.position = p
  local view = _ENV["$"](box).View
  if box.term == BoxTerm.Floor then
    view["$SetSortingOrder"](0)
  elseif box.term == BoxTerm.Wallpaper then
    view["$SetSortingOrder"](1)
  elseif box.bound.z == 0 then
    view["$SetSortingOrder"](100 + sortingOrder)
  elseif box.term == BoxTerm.Dynamic and box.boxParent ~= nil then
    local boxSortingOrder = 1000 + 100 * sortingOrder
    view["$SetSortingOrder"](boxSortingOrder)
    local values = {}
    local childIdx = 1
    for i = 0, box.boxParent.boxChildren.size - 1 do
      local child = box.boxParent.boxChildren[i]
      if child.type == BoxTerm.Dynamic then
        childIdx = childIdx + 1
      end
      if child == box then
        break
      end
    end
    values[childIdx] = boxSortingOrder + 1
    _ENV["$"](box.boxParent.transform:GetChild(0).gameObject)["$$SetSortingOrder"](values)
  else
    local values = {}
    for i = 0, 10 do
      values[i] = 1000 + 100 * sortingOrder + i
    end
    view["$SetSortingOrder"](values)
  end
  if box.allowFlip then
    view["$SetFlip"](box.flip)
  end
end

function UpdateMovableBoard()
  m_movableBoard:Recalculate(m_root.boxList)
end

function IsMovableAtPoint(i, j)
  return m_movableBoard:IsMovableAt(i, j)
end

function IsMovableAtRange(i, j, e, d)
  if not IsMovableAtPoint(e, d) then
    return false
  end
  for s = i, e do
    for k = j, d do
      if not IsMovableAtPoint(s, k) then
        return false
      end
    end
  end
  return true
end

function GetBoxListByGridOnMovable(x, y)
  return m_movableBoard:GetBoxListByGrid(x, y)
end

function AddBox(prefab, targetBox, targetPos, flip)
  if flip == nil then
    flip = false
  end
  local prefabBox = prefab:GetComponent(typeof(CS.IsometricGame.IsometricBox))
  local valid = false
  local toPlace = false
  local term = targetBox.term
  if (term == BoxTerm.Floor or term == BoxTerm.Carpet) and (prefabBox.term == BoxTerm.Normal or prefabBox.term == BoxTerm.Desk or prefabBox.term == BoxTerm.OnDesk or prefabBox.term == BoxTerm.Carpet) then
    valid = true
  end
  if term == BoxTerm.Wallpaper and prefabBox.term == BoxTerm.Walldecor then
    valid = true
  end
  if term == BoxTerm.Desk and prefabBox.term == BoxTerm.OnDesk then
    local top = {}
    local bd = targetBox.bound
    for i = 1, bd.x do
      for j = 1, bd.y do
        table.insert(top, {
          x = targetPos.x + i,
          y = targetPos.y + j,
          z = targetPos.z
        })
      end
    end
    if targetBox:CanPlacedOn(top) then
      valid = true
      toPlace = true
    end
  else
    valid = true
  end
  if valid then
    local boxCom = prefabBox:GetComponent(typeof(CS.IsometricGame.IsometricBox))
    boxCom.isoPosition = targetPos
    boxCom.flip = flip
    prefabBox:AddToRoot(m_root)
    if toPlace then
      prefabBox:SetParent(targetBox)
    end
    RearrangeAllBox()
    return prefabBox
  else
    warning("GamePlay", string.Format("[Dorm] can't place new box {0} on {1} at {2}", prefab.name, targetBox.gameObject.name, targetPos))
    return nil
  end
end

function Remove(box, rearrange)
  if rearrange == nil then
    rearrange = true
  end
  while box.boxChildren.size > 0 do
    Remove(box.boxChildren[0], rearrange)
  end
  if box.boxParent then
    box.boxParent:RemoveChild(box)
  end
  m_root:RemoveBox(box)
  CS.UnityEngine.GameObject.Destroy(box.gameObject)
  if rearrange then
    RearrangeAllBox()
  end
end

function RemoveAll()
  local stack = {}
  for i = 0, m_root.boxList.size - 1 do
    local box = m_root.boxList[i]
    if box.term ~= BoxTerm.Dynamic then
      table.insert(stack, box)
    end
  end
  for i = 0, m_root.borderList.size - 1 do
    local box = m_root.borderList[i]
    if box.term == BoxTerm.Walldecor or box.term == BoxTerm.Carpet then
      table.insert(stack, box)
    end
  end
  while 0 < #stack do
    Remove(stack[#stack], false)
    table.remove(stack, #stack)
  end
  RearrangeAllBox()
end

function Flip(targetBox, reset)
  if reset == nil then
    reset = true
  end
  if targetBox.term == BoxTerm.Walldecor or not targetBox.allowFlip then
    return false
  end
  local children = {}
  for i = 0, targetBox.boxChildren.size - 1 do
    if targetBox.boxChildren[i].term == BoxTerm.OnDesk then
      table.insert(children, targetBox.boxChildren[i])
    end
  end
  FlipImpl(targetBox, children)
  if reset then
    local succeed = RearrangeAllBox()
    if not succeed then
      FlipImpl(targetBox, children)
      RearrangeAllBox()
    end
    return succeed
  else
    return true
  end
end

function FlipImpl(targetBox, children)
  targetBox.flip = not targetBox.flip
  local bd = targetBox.bound
  bd = CS.UnityEngine.Vector2(bd.x, bd.y)
  local targetPos = targetBox.isoPosition
  local one = CS.UnityEngine.Vector3(1, 1, 0)
  for _, box in ipairs(children) do
    local localPos = box.isoPosition - targetPos
    local boxBd = box.bound
    boxBd = CS.UnityEngine.Vector3(boxBd.x, boxBd.y, 0)
    box.isoPosition = targetPos + IsometricTools.FlipBoxPoint(bd, localPos) - boxBd + one
    box.flip = not box.flip
  end
end

function _MoveChildren(box, relativeMovement)
  for i = 0, box.boxChildren.size - 1 do
    local boxOnDesk = box.boxChildren[i]
    boxOnDesk.isoPosition = boxOnDesk.isoPosition + relativeMovement
    _MoveChildren(boxOnDesk, relativeMovement)
  end
end

function Move(box, pos)
  if box.term == BoxTerm.Floor or box.term == BoxTerm.Wallpaper then
    warning("GamePlay", "[Dorm] can't move floor or wallpaper")
    return false
  end
  local relativeMovement = pos - box.isoPosition
  _MoveChildren(box, relativeMovement)
  box.isoPosition = pos
  return RearrangeAllBox()
end

function CanInteractive(box)
  if not box.allowInteractive then
    return false
  end
  local can = false
  local dynamicCount = 0
  for i = 0, box.boxChildren.size - 1 do
    local child = box.boxChildren[i]
    if child.term == BoxTerm.Dynamic then
      dynamicCount = dynamicCount + 1
    end
  end
  can = dynamicCount < box.interactiveSeats.Length
  if can and box.term == BoxTerm.Desk then
    local interactiveSeat = box:GetInteractiveSeat()
    local bdDynamic = CS.UnityEngine.Vector3(2, 2, 0)
    for i = 0, box.boxChildren.size - 1 do
      local child = box.boxChildren[i]
      if child.term == BoxTerm.OnDesk and not IsometricTools.BoxOuter(child.isoPosition, interactiveSeat, child.bound, bdDynamic) then
        can = false
        break
      end
    end
  end
  return can
end
