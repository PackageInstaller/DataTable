require("ui_side_enter_item_base")
_class("UISeasonMazeEnterBtn", UISideEnterItem_Base)
UISeasonMazeEnterBtn = UISeasonMazeEnterBtn

function UISeasonMazeEnterBtn.GetLocalDBKey()
  local str = "UISeasonMazeEnterBtn"
  local key = UIActivityHelper.GetLocalDBKeyWithPstId(str .. "_")
  return key
end

function UISeasonMazeEnterBtn:LoadData(TT)
end

function UISeasonMazeEnterBtn:CheckOpen(TT)
  return self:_CheckOpen()
end

function UISeasonMazeEnterBtn:_CheckOpen(TT)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if self._sample == nil then
    return false
  end
  if not self._sample.is_open then
    return false
  end
  return true
end

function UISeasonMazeEnterBtn:GetSideEnterRawImage()
  return self._btnCfg.SideEnterIcon
end

function UISeasonMazeEnterBtn:DoShow()
  UIWidgetHelper.SetLocalizationText(self, "txtTitle", StringTable.Get("str_season_maze_s2_title"))
  UIWidgetHelper.SetRawImage(self, "bg", self:GetSideEnterRawImage())
  self.te = UIActivityHelper.StartTimerEvent(self.te, function()
    self:_CheckPoint()
  end)
end

function UISeasonMazeEnterBtn:CheckRed()
  return 0
end

function UISeasonMazeEnterBtn:CheckNew()
  return self:_CalcNew() and 1 or 0
end

function UISeasonMazeEnterBtn:_CalcNew()
  local key = UISeasonMazeEnterBtn.GetLocalDBKey()
  return not LocalDB.HasKey(key)
end

function UISeasonMazeEnterBtn:_CalcRed()
  return false
end

function UISeasonMazeEnterBtn:OnHide()
  UIActivityHelper.CancelTimerEvent(self.te)
end
