local UIDungeonWaveTip = class("UIDungeonWaveTip", UIBaseWindow)
local base = UIBaseWindow
local cs_DoTween = CS.DG.Tweening.DOTween

function UIDungeonWaveTip:OnInit()
  self.__onFadeCompletedEvent = BindCallback(self, self.__onFadeCompleted)
end

function UIDungeonWaveTip:InjectWave(wave, dungeonId)
  local dungeonStageCfg = ConfigData.battle_dungeon[dungeonId]
  local play_para, wave_battlesCfg
  if dungeonStageCfg ~= nil then
    play_para = dungeonStageCfg.play_para
  end
  if play_para ~= nil then
    wave_battlesCfg = ConfigData.wave_battles[play_para]
  end
  local openMove = Vector3.New(0, -80, 0)
  self.openInfoSequence = cs_DoTween.Sequence():AppendCallback(function()
    self.ui.canvasGroup.alpha = 0
  end):Append(self.ui.canvasGroup:DOFade(1, 0.25)):Join(self.ui.canvasGroup.transform:DOLocalMove(openMove, 0.35):SetRelative(true))
  if wave ~= nil then
    self.ui.wave_Count:SetIndex(0, tostring(wave.cur), tostring(wave.total))
    if wave_battlesCfg ~= nil then
      local curWaveCfg = wave_battlesCfg[wave.cur]
      if curWaveCfg ~= nil then
        local title = LanguageUtil.GetLocaleText(curWaveCfg.show_text)
        if not string.IsNullOrEmpty(title) then
          self.ui.tex_WaveTip:SetIndex(1, title)
          local playtime
          if 0 >= curWaveCfg.show_time then
            playtime = 0.75
          else
            playtime = curWaveCfg.show_time
          end
          self.openInfoSequence:Append(self.ui.canvasGroup:DOFade(0, 0.25):SetDelay(playtime))
          return
        end
      end
    end
    self.openInfoSequence:Append(self.ui.canvasGroup:DOFade(0, 0.25):SetDelay(0.5))
    local strCurWave = ""
    if wave.cur <= 9 then
      strCurWave = "0" .. tostring(wave.cur)
    else
      strCurWave = tostring(wave.cur)
    end
    self.ui.tex_WaveTip:SetIndex(0, strCurWave)
  end
  self.openInfoSequence:AppendCallback(self.__onFadeCompletedEvent):Pause():SetAutoKill(false)
  self.openInfoSequence:Restart()
end

function UIDungeonWaveTip:__onFadeCompleted()
  base.Hide(self)
end

function UIDungeonWaveTip:OnDelete()
  if not IsNull(self.ui.tween) then
    self.ui.tween:DOKill()
  end
  if self.openInfoSequence ~= nil then
    self.openInfoSequence:Kill()
    self.openInfoSequence = nil
  end
  base.OnDelete(self)
end

return UIDungeonWaveTip
