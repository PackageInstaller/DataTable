local UIEpStartRoom = class("UIEpStartRoom", UIBaseNode)
local SectorEnum = require("Game.Sector.SectorEnum")

function UIEpStartRoom:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.resloader = CS.ResLoader.Create()
end

function UIEpStartRoom:InitRoomUI(roomData, resloader)
  self.roomData = roomData
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  self.ui.tex_LayerCount.text = tostring(ExplorationManager:GetCurLevelIndex() + 1) .. "/" .. tostring(ExplorationManager:GetLevelCount())
  self.ui.tex_LevelName.text = LanguageUtil.GetLocaleText(sectorStageCfg.name)
  local levelInfo
  if sectorStageCfg.endlessCfg ~= nil then
    levelInfo = ConfigData:GetEndlessInfoMsg(sectorStageCfg, sectorStageCfg.endlessCfg.index * 10)
    self.ui.tex_LevelCount.text = levelInfo
  elseif sectorStageCfg.challengeCfg ~= nil then
    self.ui.tex_LevelCount.gameObject:SetActive(false)
    self.ui.img_SectorIcon.gameObject:SetActive(false)
    return
  else
    levelInfo = ConfigData:GetSectorInfoMsg(sectorStageCfg.sector, sectorStageCfg.num, sectorStageCfg.difficulty)
    self.ui.tex_LevelCount.text = levelInfo
  end
  self.ui.img_SectorIcon.gameObject:SetActive(false)
  local sectorCfg = ExplorationManager:GetSectorCfg()
  local hasCfg = sectorCfg ~= nil
  if not hasCfg then
    error("Cant get sectorCfg By ExplorationManager:GetSectorCfg()")
    return
  end
  local textureName = sectorCfg.scene_icon
  if not string.IsNullOrEmpty(textureName) then
    resloader:LoadABAssetAsync(PathConsts:GetSeceneIconPicPath(textureName), function(texture)
      if IsNull(self.transform) then
        return
      end
      self.ui.img_SectorIcon.gameObject:SetActive(true)
      self.ui.img_SectorIcon.texture = texture
    end)
  end
end

function UIEpStartRoom:GetRoomSize()
  return self.ui.roomNode.transform.sizeDelta
end

function UIEpStartRoom:ChangeUIState(eRoomState, withTween, isAutoPath)
end

return UIEpStartRoom
