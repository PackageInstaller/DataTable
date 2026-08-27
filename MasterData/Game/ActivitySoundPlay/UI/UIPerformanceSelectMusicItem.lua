local base = UIBaseNode
local UIPerformanceSelectMusicItem = class("UIPerformanceSelectMusicItem", base)

function UIPerformanceSelectMusicItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnClickSelect)
  self._tagColorArray = {}
  UIUtil.LuaUIBindingTable(self.ui.img_DiffTag, self._tagColorArray)
end

function UIPerformanceSelectMusicItem:InitSkinLimitTaskItem(rhythmData, score)
  self._rhythmData = rhythmData
  self._score = score
  self:Refresh()
end

function UIPerformanceSelectMusicItem:Refresh()
  self:RefreshMusicName()
  self:RefreshScore()
  self:RefreshDiffTag()
end

function UIPerformanceSelectMusicItem:RefreshMusicName()
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self._rhythmData.rhythm_des)
end

function UIPerformanceSelectMusicItem:RefreshScore()
  self.ui.tex_Score.text = self._score
end

function UIPerformanceSelectMusicItem:RefreshDiffTag()
  local difficulty = self._rhythmData.difficulty
  local diffColor = self._tagColorArray.arr_DiffColor[difficulty + 1]
  self.ui.img_DiffTag.color = diffColor
  self.ui.tex_Diff:SetIndex(difficulty)
  self.ui.img_Frame.color = diffColor
  self.ui.tex_Name.color = diffColor
end

function UIPerformanceSelectMusicItem:OnClickSelect()
  UIManager:ShowWindowAsync(UIWindowTypeID.PerformancePlay, function(window)
    if window == nil then
      return
    end
    local musicCfg = ConfigData.tiny_game_instrument[1]
    window:InitMiniGameMusic(musicCfg, self._rhythmData)
  end)
end

function UIPerformanceSelectMusicItem:OnDelete()
end

return UIPerformanceSelectMusicItem
