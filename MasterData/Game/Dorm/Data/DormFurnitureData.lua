local DormFurnitureData = class("DormFurnitureData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormInterPointData = require("Game.Dorm.Data.DormInterPointData")

function DormFurnitureData:ctor()
end

function DormFurnitureData:InitFntData(id, roomData, fntData, isDoor)
  self.id = id
  self.roomData = roomData
  local fntId = id
  if isDoor and id == 0 then
    fntId = ConfigData.game_config.DmRoomDoorDefaultId
  end
  self:_InitFntCfg(fntId)
  self:UpdateFntData(fntData)
  self._enableInteract = true
end

function DormFurnitureData:_InitFntCfg(fntId)
  local fntCfg = ConfigData.dorm_furniture[fntId]
  if fntCfg == nil then
    error("Can't find dorm_furniture cfg, id = " .. tostring(fntId))
    return
  end
  self.fntCfg = fntCfg
  local itemCfg = ConfigData.item[fntId]
  if itemCfg == nil then
    error("Can't find item cfg, id = " .. tostring(fntId))
    return
  end
  self.itemCfg = itemCfg
  self.interpoint = {}
  for index, interId in ipairs(fntCfg.interact_point) do
    local interCfg = ConfigData.dorm_interpoint[interId]
    if interCfg == nil then
      error("dorm interpoint cfg is null,id:" .. tostring(interId))
    else
      local point = DormInterPointData.New()
      point:InitInterPoint(interCfg, fntCfg.interact_point_coord[index], fntCfg.interact_start_coord[index], self)
      table.insert(self.interpoint, point)
    end
  end
end

function DormFurnitureData:UpdateFntData(fntData, isReset)
  if fntData == nil then
    self.pos = 0
    self.r = proto_object_FT_R.R_0
    self.param = 0
    self.param2 = 0
  else
    self.pos = fntData.pos
    self.r = fntData.r
    self.param = fntData.param
    self.param2 = fntData.param2
  end
  self.x, self.y = DormUtil.FntCoord2XY(self.pos)
  if self:IsDmFntDoor() then
    local sizeX, sizeY = self:GetFntSize()
    local newY = self:GetFntDoorY(sizeY)
    if self.y ~= newY then
      self.y = newY
      self.pos = DormUtil.XYToRoomCoord(self.x, self.y)
    end
  end
  if not isReset then
    self:RecordOriginalFntData()
  end
end

function DormFurnitureData:GetFntDoorY(sizeY)
  local posY = self.roomData:GetRoomGridHeightCount() - sizeY
  return posY
end

function DormFurnitureData:RecordOriginalFntData()
  self.oldFntData = {
    id = self.id,
    pos = self.pos,
    r = self.r,
    param = self.param,
    param2 = self.param2
  }
end

function DormFurnitureData:ResetFntData()
  self:UpdateFntData(self.oldFntData, true)
end

function DormFurnitureData:IsFntDataParam2Change()
  return self.oldFntData.param2 ~= self.param2
end

function DormFurnitureData:GetFntRoom()
  return self.roomData
end

function DormFurnitureData:GetName()
  return LanguageUtil.GetLocaleText(self.itemCfg.name)
end

function DormFurnitureData:GetFntIntro()
  return LanguageUtil.GetLocaleText(self.itemCfg.describe)
end

function DormFurnitureData:GetFntType()
  return self.fntCfg.type
end

function DormFurnitureData:GetFntSize()
  return self.fntCfg.size[1], self.fntCfg.size[2], self.fntCfg.size[3]
end

function DormFurnitureData:GetFntCenterCfg()
  return self.fntCfg.fnt_center
end

function DormFurnitureData:GetFntPrefab()
  local roomType = self.roomData:GetDmRoomType()
  return DormUtil.GetDmFntPrefabPath(roomType, self.fntCfg)
end

function DormFurnitureData:GetFntIcon()
  return self.itemCfg.icon
end

function DormFurnitureData:GetFntComfort()
  return self.fntCfg.comfort
end

function DormFurnitureData:SetFntPos(x, y)
  self.x = x
  self.y = y
  self.pos = DormUtil.XYCoord2Fnt(x, y)
end

function DormFurnitureData:SetFntParam(param, record)
  if param == nil then
    param = 0
  end
  self.param = param
  if record then
    self.oldFntData.param = param
  end
end

function DormFurnitureData:GetFntParam()
  return self.param
end

function DormFurnitureData:CanBindRole()
  return self.fntCfg.can_binding
end

function DormFurnitureData:RotateFnt()
  self.r = (self.r + 90) % 360
  return self.r
end

function DormFurnitureData:CheckOutMap()
  local oldX = self.x
  local oldY = self.y
  local sizeX, sizeY = self:GetFntSize()
  local outX, outY, newX, newY = DormUtil.FntAreaOutMap(oldX, oldY, sizeX, sizeY, self.r, self:GetFntType(), self.roomData.roomCfg)
  if outX or outY then
    self:SetFntPos(newX, newY)
    return true
  end
  return false
end

function DormFurnitureData:GetDmFntServerData()
  local id = self.id
  local data = {
    id = id,
    pos = self.pos,
    r = self.r,
    param = self.param,
    param2 = self.param2
  }
  return data
end

function DormFurnitureData:IsDmFntDoor()
  return self:GetFntType() == DormEnum.eDormFntType.Door
end

function DormFurnitureData:TryFntDoorDataChangeDoor(fntId)
  local id = DormUtil.IsDmRoomDefaultDoorId(fntId) and 0 or fntId
  if self.id == id then
    return false
  end
  self.id = id
  self:_InitFntCfg(fntId)
  return true
end

function DormFurnitureData:GetFntOldId()
  return self.oldFntData.id
end

function DormFurnitureData:GetFntCategory()
  return self.fntCfg.category
end

function DormFurnitureData:SetFntDataLayer(layerIdx)
  self.param2 = layerIdx
end

function DormFurnitureData:GetFntDataLayer()
  return self.param2
end

function DormFurnitureData:IsFntWallpaperOverlap()
  return self.fntCfg.cover_wallpaper
end

function DormFurnitureData:IsInFntWallpaperMap()
  return self:GetFntType() == DormEnum.eDormFntType.Wallpaper or self:IsFntWallpaperOverlap()
end

function DormFurnitureData:HasFntAnimator()
  if self:IsFntEnableTouch() then
    return true
  end
  for _, point in pairs(self.interpoint) do
    if point:GetInterAnimType() > 0 then
      return true
    end
  end
  return false
end

function DormFurnitureData:IsFntEnableTouch()
  return self.fntCfg.touch_type > 0
end

function DormFurnitureData:GetFntTouchActList()
  return self.fntCfg.touch_act_list
end

function DormFurnitureData:GetFntInteractState()
  return self._enableInteract
end

function DormFurnitureData:SetFntInteractState(active)
  self._enableInteract = active
end

function DormFurnitureData:GetFntTouchInteractTips()
  return ConfigData:GetTipContent(self.fntCfg.touch_tips)
end

return DormFurnitureData
