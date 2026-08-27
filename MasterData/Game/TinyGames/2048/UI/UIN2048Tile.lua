local UIN2048Tile = class("UIN2048Tile", UIBaseNode)
local base = UIBaseNode

function UIN2048Tile:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onTileMoveEnd = BindCallback(self, self._OnTileMoveEnd)
end

function UIN2048Tile:Init2048Tile(value, x, y, tilePool, sprite)
  self.level = value
  self.x = x
  self.y = y
  self._needDelete = false
  self:PrepareTile()
  self._tilePool = tilePool
  self.ui.tex_Level.text = tostring(value)
  self.ui.img_Icon.sprite = sprite
end

function UIN2048Tile:PrepareTile()
  self.merged = false
  self.needMove = false
  self.lastx = self.x
  self.lasty = self.y
  self.transform.localScale = Vector3.one
  self.transform:DOComplete(true)
end

function UIN2048Tile:SetTileAsMerged(from1, from2)
  self.fromTile1 = from1
  self.fromTile2 = from2
  self.merged = true
  self.fromTile1._needDelete = true
  self.fromTile2._needDelete = true
end

function UIN2048Tile:UpdateTilePosData(x, y)
  self.x = x
  self.y = y
  self.needMove = true
end

function UIN2048Tile:PlayTileCreateAnimation()
  self.transform.localScale = Vector3.zero
  self.transform:DOScale(Vector3.one, 0.15)
end

function UIN2048Tile:Play2048TileAnimation(gameCtrl)
  if self.merged then
    self.fromTile1:Play2048TileAnimation(gameCtrl)
    self.fromTile2:Play2048TileAnimation(gameCtrl)
    self.transform:DOPunchScale(Vector3.New(0.25, 0.25, 0.25), 0.15, 3):SetDelay(0.1)
  elseif self.needMove then
    local destPos = gameCtrl:GetTilePosition(self.x, self.y)
    self.transform:DOLocalMove(destPos, 0.1):OnComplete(self.__onTileMoveEnd)
  else
    self:_OnTileMoveEnd()
  end
end

function UIN2048Tile:_OnTileMoveEnd()
  if self._needDelete then
    self._tilePool:HideOne(self)
  end
end

function UIN2048Tile:OnDelete()
  base.OnDelete(self)
end

return UIN2048Tile
