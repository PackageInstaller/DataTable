_class("N22MedalEditData", Object)
N22MedalEditData = N22MedalEditData

function N22MedalEditData:Constructor()
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.boardMedals = {}
  self.whBoard = Vector2(1672, 586)
end

function N22MedalEditData:Init()
  self:InitBoardMedals()
  self:FormatBoardMedalIndex()
end

function N22MedalEditData:InitBoardMedals()
  local medal_board = self.mMedal:GetPlacementInfo()
  local medal_on_board = medal_board.medal_on_board
  if not medal_on_board then
    return
  end
  self.boardMedals = {}
  for id, bm in pairs(medal_on_board) do
    local md = BoardMedal:New(id)
    md.index = bm.z
    md.pos = Vector2(bm.x, bm.y)
    md.quat = Quaternion(bm.quatx, bm.quaty, bm.quatz, bm.quatw)
    md.wh = Vector2(bm.w, bm.h)
    table.insert(self.boardMedals, md)
  end
end

function N22MedalEditData.CheckCode(res)
  if GameSingle then
    return true
  end
  local result = res:GetResult()
  if result == MedalErrorType.E_MEDAL_ERROR_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_medal_error_" .. result)
  ToastManager.ShowToast(msg)
  return false
end

function N22MedalEditData:GetBoardMedalById(id)
  for index, boardMedal in ipairs(self.boardMedals) do
    if boardMedal.id == id then
      return boardMedal
    end
  end
end

function N22MedalEditData:IsDirty()
  local medal_board = self.mMedal:GetPlacementInfo()
  local medal_on_board = medal_board.medal_on_board or {}
  if table.count(self.boardMedals) ~= table.count(medal_on_board) then
    return true
  end
  for _, boardMedal in ipairs(self.boardMedals) do
    local serData = medal_on_board[boardMedal.id]
    if not serData then
      return true
    end
    local posSer = Vector2(serData.x, serData.y)
    local quatSer = Quaternion(serData.quatx, serData.quaty, serData.quatz, serData.quatw)
    local index = serData.z
    if boardMedal:IsDirtyPos(posSer) or boardMedal:IsDirtyRot(quatSer) or boardMedal:IsDirtyIndex(index) then
      return true
    end
  end
  return false
end

function N22MedalEditData:GetBoardId()
  local medal_board = self.mMedal:GetPlacementInfo()
  return medal_board.board_back_id
end

function N22MedalEditData:SetBoardId(id)
  local medal_board = self.mMedal:GetPlacementInfo()
  medal_board.board_back_id = id
end

function N22MedalEditData:SortBoardMedals(boardMedals)
  table.sort(boardMedals, function(a, b)
    return a.index < b.index
  end)
end

function N22MedalEditData:FormatBoardMedalIndex()
  self:SortBoardMedals(self.boardMedals)
  for i, boardMedal in ipairs(self.boardMedals) do
    boardMedal.index = i
  end
end

function N22MedalEditData:SinkMedalById(id)
  local curBM = self:GetBoardMedalById(id)
  local curIndex = curBM.index
  for i, boardMedal in ipairs(self.boardMedals) do
    if boardMedal.index == curIndex then
      boardMedal.index = table.count(self.boardMedals)
    elseif curIndex < boardMedal.index then
      boardMedal.index = boardMedal.index - 1
    end
  end
end

function N22MedalEditData:GetBoardMedalLimit()
  local limit = Cfg.cfg_global.MedalLImit.IntValue
  return limit
end

function N22MedalEditData:GetMappingBoardMedalList(width, placementInfo)
  local ret = {}
  local medal_on_board = placementInfo.medal_on_board
  if medal_on_board then
    for id, srt in pairs(medal_on_board) do
      local bm = BoardMedal:New(id)
      bm.index = srt.z
      bm.pos = self:GetScaledPos(width, Vector2(srt.x, srt.y))
      bm.quat = Quaternion(srt.quatx, srt.quaty, srt.quatz, srt.quatw)
      bm.wh = Vector2(srt.w, srt.h) * self:GetScaleTimes(width)
      table.insert(ret, bm)
    end
    self:SortBoardMedals(ret)
  else
    Log.fatal("### medal_on_board nil.")
  end
  return ret
end

function N22MedalEditData:GetScaleTimes(width)
  local scaleTimes = width / self.whBoard.x
  return scaleTimes
end

function N22MedalEditData:GetScaledMatrix(width)
  local scaleTimes = self:GetScaleTimes(width)
  local mtx4Scale = UnityEngine.Matrix4x4.identity
  mtx4Scale.m00 = mtx4Scale.m00 * scaleTimes
  mtx4Scale.m11 = mtx4Scale.m11 * scaleTimes
  mtx4Scale.m22 = mtx4Scale.m22 * scaleTimes
  return mtx4Scale
end

function N22MedalEditData:GetScaledPos(width, pos)
  local mtx4Scale = self:GetScaledMatrix(width)
  local v4 = mtx4Scale * Vector4(pos.x, pos.y, 0, 0)
  return Vector2(v4.x, v4.y)
end

function N22MedalEditData:GetScaledWidthHeight(width, wh)
  local scaleTimes = self:GetScaleTimes(width)
  local wh = wh * scaleTimes
  return wh
end

function N22MedalEditData:GetScaledMatrixInverse(width)
  local mtx4Scale = self:GetScaledMatrix(width)
  return mtx4Scale.inverse
end

function N22MedalEditData:GetScaledPosInverse(width, pos)
  local mtx4Scale = self:GetScaledMatrixInverse(width)
  local v4 = mtx4Scale * Vector4(pos.x, pos.y, 0, 0)
  return Vector2(v4.x, v4.y)
end

function N22MedalEditData:GetScaledWidthHeightInverse(width, wh)
  local scaleTimes = self:GetScaleTimes(width)
  local wh = wh / scaleTimes
  return wh
end

_class("BoardMedal", Object)
BoardMedal = BoardMedal

function BoardMedal:Constructor(id)
  self.id = id
  self.itemId = id
  self.index = 0
  self.pos = Vector2.zero
  self.quat = Quaternion.identity
  self.wh = Vector2.zero
  local cfgv = BoardMedal.CfgItemMedal(self.itemId)
  self.model = cfgv.Model .. ".prefab"
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.data = self.mMedal:GetN22MedalEditData()
end

function BoardMedal.CfgItemMedal(itemId)
  local cfgv = Cfg.cfg_item_medal[itemId]
  if not cfgv then
    Log.exception("### cfg_item_medal 中缺少配置. itemId=", itemId)
  end
  return cfgv
end

function BoardMedal:IconMedal()
  return BoardMedal.IconMedalById(self.itemId)
end

function BoardMedal.IconMedalById(id)
  local cfgv = BoardMedal.CfgItemMedal(id)
  return cfgv.IconMedal
end

function BoardMedal:PosView(width)
  local pos = self.data:GetScaledPos(width, self.pos)
  return pos
end

function BoardMedal:IsDirtyPos(pos)
  local isDirty = not BoardMedal.IsEqualVector2(self.pos, pos)
  return isDirty
end

function BoardMedal:IsDirtyRot(quat)
  local isDirty = not BoardMedal.IsEqualQuaternion(self.quat, quat)
  return isDirty
end

function BoardMedal:IsDirtyIndex(index)
  local isDirty = not BoardMedal.IsEqualFloat(self.index, index)
  return isDirty
end

function BoardMedal.IsEqualFloat(fl, fr)
  local epsilon = 0.01
  local delta = fl - fr
  if delta >= -epsilon and epsilon >= delta then
    return true
  end
  return false
end

function BoardMedal.IsEqualVector2(v2l, v2r)
  if BoardMedal.IsEqualFloat(v2l.x, v2r.x) and BoardMedal.IsEqualFloat(v2l.y, v2r.y) then
    return true
  end
  return false
end

function BoardMedal.IsEqualQuaternion(quatl, quatr)
  if BoardMedal.IsEqualFloat(quatl.x, quatr.x) and BoardMedal.IsEqualFloat(quatl.y, quatr.y) and BoardMedal.IsEqualFloat(quatl.z, quatr.z) and BoardMedal.IsEqualFloat(quatl.w, quatr.w) then
    return true
  end
  return false
end

_class("MedalAABB", Object)
MedalAABB = MedalAABB

function MedalAABB:Constructor()
  self.min = Vector2.zero
  self.max = Vector2.zero
  self.center = Vector2.zero
end

function MedalAABB:InitByPoints(points)
  local minX = 99999
  local minY = 99999
  local maxX = -99999
  local maxY = -99999
  for index, point in ipairs(points) do
    minX = math.min(minX, point.x)
    minY = math.min(minY, point.y)
    maxX = math.max(maxX, point.x)
    maxY = math.max(maxY, point.y)
  end
  self.min.x = minX
  self.min.y = minY
  self.max.x = maxX
  self.max.y = maxY
  self.center = (self.min + self.max) * 0.5
end

function MedalAABB:IntersectsAABB(aabb)
  local xIntersects = self.max.x > aabb.min.x and self.min.x < aabb.max.x
  local yIntersects = self.max.y > aabb.min.y and self.min.y < aabb.max.y
  return xIntersects and yIntersects
end

function MedalAABB:ContainsPoint(point)
  local xIntersects = self.min.x < point.x and point.x < self.max.x
  local yIntersects = self.min.y < point.y and point.y < self.max.y
  return xIntersects and yIntersects
end

function MedalAABB:InvolveAABB(aabb)
  local minInvolve = aabb.min.x > self.min.x and aabb.min.y > self.min.y
  local maxInvolve = aabb.max.x < self.max.x and aabb.max.y < self.max.y
  return minInvolve and maxInvolve
end
