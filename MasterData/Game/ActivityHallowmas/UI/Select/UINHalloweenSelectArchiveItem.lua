local UINHalloweenSelectArchiveItem = class("UINHalloweenSelectArchiveItem", UIBaseNode)
local base = UIBaseNode

function UINHalloweenSelectArchiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickArchive)
end

function UINHalloweenSelectArchiveItem:InitSelectArchiveItem(hallowmasData, index, archives, selectCallback)
  self._hallowmasData = hallowmasData
  self._archives = archives
  self._selectCallback = selectCallback
  self._index = index
  self.ui.tex_Num.text = string.format("%02d", index)
  self.ui.tex_FileNum:SetIndex(1)
  self.ui.tex_FileNum.text.color = self.ui.color_emptyTex
  self.ui.img_Icon:SetIndex(self._archives ~= nil and 0 or 1)
  self.ui.tex_EnviroDes.gameObject:SetActive(self._archives ~= nil)
  self.ui.tex_ModeDes.gameObject:SetActive(self._archives ~= nil)
  self.ui.info:SetActive(self._archives ~= nil)
  self.ui.img_EnviroBg.gameObject:SetActive(self._archives ~= nil)
  if self._archives ~= nil then
    self.ui.tex_FileNum:SetIndex(0, tostring(index))
    self.ui.tex_FileNum.text.color = Color.white
    if hallowmasData ~= nil then
      local stageInfoCfgs = hallowmasData:GetHallowmasStageInfoCfg()
      local stageInfo, index
      for i, v in ipairs(stageInfoCfgs) do
        if v.season_id == self._archives.warChessTowerId then
          stageInfo = v
          index = v.difficulty_color + 1
        end
      end
      if stageInfo ~= nil then
        self.ui.tex_EnviroDes.text = LanguageUtil.GetLocaleText(stageInfo.difficulty_name)
        self.ui.tex_ModeDes.text = LanguageUtil.GetLocaleText(stageInfo.difficulty_name_en)
        local color = self.ui.color_diffculty[index]
        if color == nil then
          color = self.ui.color_diffculty[#self.ui.color_diffculty]
        end
        self.ui.img_EnviroBg.color = color
      end
    end
    local buffCount = 0
    for i, v in ipairs(self._archives.warChessBuffs) do
      local buffCfg = ConfigData.warchess_buff[v.configId]
      if buffCfg ~= nil and buffCfg.is_show then
        buffCount = buffCount + 1
      end
    end
    self.ui.tex_Port:SetIndex(0, tostring(buffCount))
    self.ui.tex_Layer:SetIndex(0, tostring(self._archives.warChessSeasonFloor))
    local algCount = 0
    for k, v in pairs(self._archives.alg) do
      algCount = algCount + v
    end
    self.ui.tex_Func:SetIndex(0, tostring(algCount))
  end
end

function UINHalloweenSelectArchiveItem:SetFileNameByEnvName()
  if self._archives == nil then
    return
  end
  local diffId = self._hallowmasData:GetHallowmasDiffIdByTowerId(self._archives.warChessTowerId)
  local envId = self._hallowmasData:GetHallowmasEnvIdByDifficultyId(diffId)
  if envId == -1 then
    if isGameDev then
      warn(" env is nil, only in halloween21 act is legal.")
    end
    return
  end
  local cfg = ConfigData.activity_hallowmas_general_env[envId]
  self.ui.tex_FileNum:SetIndex(2, LanguageUtil.GetLocaleText(cfg.general_env_name))
end

function UINHalloweenSelectArchiveItem:RefreshSelectArchiveState(flag)
  if flag then
    self.ui.img_Frame.color = self.ui.color_selected
  else
    self.ui.img_Frame.color = self.ui.color_unselect
  end
end

function UINHalloweenSelectArchiveItem:GetArchiveData()
  return self._archives
end

function UINHalloweenSelectArchiveItem:GetArchiveIndex()
  return self._index
end

function UINHalloweenSelectArchiveItem:OnClickArchive()
  if self._selectCallback ~= nil then
    self._selectCallback(self)
  end
end

return UINHalloweenSelectArchiveItem
