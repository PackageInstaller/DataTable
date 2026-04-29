_class("CheckUIPetLayerCount_Test", AutoTestCheckPointBase)
CheckUIPetLayerCount_Test = CheckUIPetLayerCount_Test

function CheckUIPetLayerCount_Test:BeforeCheck()
end

function CheckUIPetLayerCount_Test:Check(notify)
  local expect = self._args.expect
  local pstid = self._entity:PetPstID():GetPstID()
  local svc = self._world:GetService("AutoTest")
  local num = svc:ReadBlackBoard_Test("UIPetAccNum_" .. pstid) or 0
  self._message = " UIPetLayerCount:" .. num .. " expect:" .. expect
  return num == expect
end

_class("CheckUIPetPassiveSkillBuffLayerCount_Test", AutoTestCheckPointBase)
CheckUIPetPassiveSkillBuffLayerCount_Test = CheckUIPetPassiveSkillBuffLayerCount_Test

function CheckUIPetPassiveSkillBuffLayerCount_Test:BeforeCheck()
end

function CheckUIPetPassiveSkillBuffLayerCount_Test:Check(notify)
  local expect = self._args.expect
  local pstid = self._entity:PetPstID():GetPstID()
  local svc = self._world:GetService("AutoTest")
  local num = svc:ReadBlackBoard_Test("UIPetBuffLayerNum_" .. pstid) or 0
  self._message = " UIPetBuffLayerCount:" .. num .. " expect:" .. expect
  return num == expect
end

_class("CheckUIBuffIcon_Test", AutoTestCheckPointBase)
CheckUIBuffIcon_Test = CheckUIBuffIcon_Test

function CheckUIBuffIcon_Test:BeforeCheck()
end

function CheckUIBuffIcon_Test:Check(notify)
  local buffID = self._args.buffID
  local expect = self._args.expect
  local entityID = self._entity:GetID()
  local layer = 0
  local svc = self._world:GetService("AutoTest")
  local t = svc:ReadBlackBoard_Test("UIHPBuff_" .. entityID)
  if t then
    layer = t[buffID] or 0
  end
  self._message = " UI Buff Icon LayerCount:" .. layer .. " expect:" .. expect
  return layer == expect
end

_class("CheckUIHPShieldExist_Test", AutoTestCheckPointBase)
CheckUIHPShieldExist_Test = CheckUIHPShieldExist_Test

function CheckUIHPShieldExist_Test:BeforeCheck()
end

function CheckUIHPShieldExist_Test:Check(notify)
  local val = self._entity:HP():GetShieldValue()
  if self._args.exist then
    return 0 < val
  else
    return val == 0
  end
end

_class("CheckUILayerShieldCount_Test", AutoTestCheckPointBase)
CheckUILayerShieldCount_Test = CheckUILayerShieldCount_Test

function CheckUILayerShieldCount_Test:BeforeCheck()
end

function CheckUILayerShieldCount_Test:Check(notify)
  local expect = self._args.expect
  local entityID = self._entity:GetID()
  local svc = self._world:GetService("AutoTest")
  local cnt = svc:ReadBlackBoard_Test("UIHPLayerShieldCount_" .. entityID, 0)
  self._message = " UI LayerShieldCount:" .. cnt .. " expect:" .. expect
  return expect == cnt
end

_class("CheckRenderPieceType_Test", AutoTestCheckPointBase)
CheckRenderPieceType_Test = CheckRenderPieceType_Test

function CheckRenderPieceType_Test:BeforeCheck()
end

function CheckRenderPieceType_Test:Check(notify)
  local pos = Vector2.Index2Pos(self._args.pos)
  local svc = self._world:GetService("Piece")
  local entity = svc:FindPieceEntity(pos)
  local pieceType = entity:Piece():GetPieceType()
  self._message = "pos=" .. self._args.pos .. " pieceType=" .. pieceType .. " expect=" .. self._args.pieceType
  if pieceType == self._args.pieceType then
    return true
  end
  return false
end
