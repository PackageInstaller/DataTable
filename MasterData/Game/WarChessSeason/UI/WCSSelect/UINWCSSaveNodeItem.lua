local UINWCSSaveNodeItem = class("UINWCSSaveNodeItem", UIBaseNode)
local base = UIBaseNode

function UINWCSSaveNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickArchive)
end

function UINWCSSaveNodeItem:InitSelectSavingItem(seasonId, index, archives, selectCallback)
  self._seasonId = seasonId
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
    local stageInfoCfgs = WarChessSeasonManager:GetWCSTowerList(self._seasonId)
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

function UINWCSSaveNodeItem:SetFileNameByEnvName()
  if self._archives == nil then
    return
  end
  local diffId
  local seasonId = self._archives.warChessSeasonId
  local stageInfoCfgs = WarChessSeasonManager:GetWCSTowerList(seasonId)
  for _diffId, stageInfoCfg in pairs(stageInfoCfgs) do
    if self._archives.warChessTowerId == stageInfoCfg.season_id then
      diffId = _diffId
      break
    end
  end
  local envCfg = WarChessSeasonManager:GetEnvCfgBySeasonAndDiff(seasonId, diffId)
  if envCfg == nil then
    return
  end
  self.ui.tex_FileNum:SetIndex(2, LanguageUtil.GetLocaleText(envCfg.general_env_name))
end

function UINWCSSaveNodeItem:RefreshSelectArchiveState(flag)
  if flag then
    self.ui.img_Frame.color = self.ui.color_selected
  else
    self.ui.img_Frame.color = self.ui.color_unselect
  end
end

function UINWCSSaveNodeItem:GetArchiveData()
  return self._archives
end

function UINWCSSaveNodeItem:GetArchiveIndex()
  return self._index
end

function UINWCSSaveNodeItem:OnClickArchive()
  if self._selectCallback ~= nil then
    self._selectCallback(self)
  end
end

return UINWCSSaveNodeItem
