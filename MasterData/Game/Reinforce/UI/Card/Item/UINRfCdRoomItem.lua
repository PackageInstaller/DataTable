local base = UIBaseNode
local UINRfCdRoomItem = class("UINRfCdRoomItem", base)

function UINRfCdRoomItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINRfCdRoomItem:InitRfCdRoomItem(idx, roomId, resloader, isLock, clickFunc)
  self._roomIdx = idx
  self._clickFunc = clickFunc
  local roomCfg = ConfigData.reinforce_card_room_group[roomId]
  if roomCfg == nil then
    error("cant get reinforce_card_room_group,roomId:" .. tostring(roomId))
    return
  end
  local roomTypeCfg = ConfigData.exploration_roomtype[roomCfg.room_type]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(self.roomType))
    return
  end
  local iconName = roomCfg.cover_icon
  local coverIconSprite = false
  if string.IsNullOrEmpty(iconName) then
    local iconSprite = CRH:GetSprite(roomTypeCfg.icon, CommonAtlasType.ExplorationIcon)
    self.ui.img_Icon.sprite = iconSprite
  else
    coverIconSprite = true
    self.ui.img_Icon.enabled = false
    resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("ReinforceIcon"), function(atlas)
      if atlas == nil then
        return
      end
      self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(atlas, iconName)
      self.ui.img_Icon.enabled = true
    end)
  end
  local coverName = LanguageUtil.GetLocaleText(roomCfg.cover_name)
  if string.IsNullOrEmpty(coverName) then
    self.ui.tex_RoomName.text = LanguageUtil.GetLocaleText(roomTypeCfg.title)
  else
    self.ui.tex_RoomName.text = coverName
  end
  self.ui.obj_Lock:SetActive(isLock)
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
  self.ui.img_Frame.color = frameColor
  self.ui.img_Icon.color = coverIconSprite and Color.white or frameColor
  self:SetRfCdRoomItemEmpty(false)
end

function UINRfCdRoomItem:SetRfCdRoomItemEmpty(isEmpty)
  self.ui.img_Empty:SetActive(isEmpty)
  self.ui.roomInfo:SetActive(not isEmpty)
  self.ui.img_Frame.gameObject:SetActive(not isEmpty)
end

function UINRfCdRoomItem:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self._roomIdx)
  end
end

function UINRfCdRoomItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCdRoomItem
