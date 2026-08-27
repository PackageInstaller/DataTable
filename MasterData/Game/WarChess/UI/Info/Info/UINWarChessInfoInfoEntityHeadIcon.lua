local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoEntityHeadIcon = class("UINWarChessInfoInfoEntityHeadIcon", base)

function UINWarChessInfoInfoEntityHeadIcon:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__curHeadIconId = nil
end

function UINWarChessInfoInfoEntityHeadIcon:RefreshEntityHeadIcon(iconAtlas, headIconId)
  if headIconId == nil then
    error("headIconId is nil")
    return
  end
  if self.__curHeadIconId == headIconId then
    return
  end
  self.__curHeadIconId = headIconId
  local headIconCfg = ConfigData.warchess_icon_res[headIconId]
  if headIconCfg == nil then
    error("headIconCfg is nil:" .. tostring(headIconId))
    return
  end
  local iconName = headIconCfg.res_name
  self.ui.img_entityHeadIcon.sprite = AtlasUtil.GetResldSprite(iconAtlas, iconName)
end

function UINWarChessInfoInfoEntityHeadIcon:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoEntityHeadIcon
