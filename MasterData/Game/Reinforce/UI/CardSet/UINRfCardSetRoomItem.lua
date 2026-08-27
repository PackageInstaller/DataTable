local base = UIBaseNode
local UINRfCardSetRoomItem = class("UINRfCardSetRoomItem", base)

function UINRfCardSetRoomItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRfCardSetRoomItem:InitRfCardSetRoomItem(idx, roomId, resloader, isLock)
  self._roomIdx = idx
  self.ui.img_Empty:SetActive(roomId == 0)
  if roomId == 0 then
    self.ui.img_RoomPic.gameObject:SetActive(false)
    self.ui.img_BoosHeadPic.gameObject:SetActive(false)
    self.ui.obj_Lock:SetActive(false)
    return
  end
  local roomCfg = ConfigData.reinforce_card_room_group[roomId]
  if roomCfg == nil then
    error("reinforce_card_room_group roomId is null,id:" .. tostring(roomId))
    return
  end
  local roomTypeCfg = ConfigData.exploration_roomtype[roomCfg.room_type]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(self.roomType))
    return
  end
  local frameColor
  if roomCfg.cover_color == 0 then
    local colCfg = roomTypeCfg.color
    frameColor = Color.Temp(colCfg[1], colCfg[2], colCfg[3])
  else
    local colorCfg = ConfigData.reinforce_card_color_group[roomCfg.cover_color]
    if colorCfg == nil then
      error("Cant get reinforce_card_color_group,id:" .. tostring(roomCfg.cover_color))
      return
    end
    local colCfg = colorCfg.frame_color
    frameColor = Color.Temp(colCfg[1] / 255, colCfg[2] / 255, colCfg[3] / 255, 1)
  end
  local iconName = roomCfg.cover_icon
  if string.IsNullOrEmpty(iconName) then
    self.ui.img_RoomPic.gameObject:SetActive(true)
    self.ui.img_BoosHeadPic.gameObject:SetActive(false)
    local iconSprite = CRH:GetSprite(roomTypeCfg.icon, CommonAtlasType.ExplorationIcon)
    self.ui.img_RoomPic.sprite = iconSprite
    self.ui.img_RoomPic.color = frameColor
  else
    self.ui.img_RoomPic.gameObject:SetActive(false)
    self.ui.img_BoosHeadPic.gameObject:SetActive(true)
    self.ui.img_BoosHeadPic.enabled = false
    resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("ReinforceIcon"), function(atlas)
      if atlas == nil then
        return
      end
      self.ui.img_BoosHeadPic.sprite = AtlasUtil.GetResldSprite(atlas, iconName)
      self.ui.img_BoosHeadPic.enabled = true
    end)
    local iconSprite = CRH:GetSprite(roomTypeCfg.icon, CommonAtlasType.ExplorationIcon)
    self.ui.roomPicSmallFrame.sprite = iconSprite
    self.ui.roomPicSmallFrame.color = frameColor
  end
  self.ui.obj_Lock:SetActive(isLock)
end

function UINRfCardSetRoomItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCardSetRoomItem
