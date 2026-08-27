local UINWarChessWarnLoop = class("UINWarChessWarnLoop", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween

function UINWarChessWarnLoop:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__TeamChangeCallback = BindCallback(self, self.__TeamChange)
  MsgCenter:AddListener(eMsgEventId.WC_SelectTeam, self.__TeamChangeCallback)
  self.__TurnChangeCallback = BindCallback(self, self.__TurnChange)
  MsgCenter:AddListener(eMsgEventId.WC_TurnStart, self.__TurnChangeCallback)
  self.__HeroDynUpdateCallback = BindCallback(self, self.__HeroDynUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_HeroDynUpdate, self.__HeroDynUpdateCallback)
end

function UINWarChessWarnLoop:__TeamChange(teamData)
  if teamData == self._teamData then
    return
  end
  if teamData == nil then
    self:__ResetWarnState()
    self._teamData = nil
    return
  end
  self._teamData = teamData
  self:__ResetWarnState()
  if teamData:GetWCTeamHP() <= ConfigData.game_config.wcWarnHoPer / 100 then
    self:__PingPongFadeEffectPlay(false, -1, 0, 1, 0, 0.6)
  end
end

function UINWarChessWarnLoop:__HeroDynUpdate()
  if self._teamData == nil then
    return
  end
  self:__ResetWarnState()
  if self._teamData:GetWCTeamHP() <= ConfigData.game_config.wcWarnHoPer / 100 then
    self:__PingPongFadeEffectPlay(false, -1, 0, 1, 0, 0.6)
  end
end

function UINWarChessWarnLoop:__PingPongFadeEffectPlay(flip, totalCount, curCount, time, minScale, maxScale)
  if totalCount ~= -1 and curCount == totalCount then
    return
  end
  minScale = minScale or 0
  maxScale = maxScale or 1
  if not flip then
    self.ui.img_turnWarrning:DOFade(maxScale, time):OnComplete(function()
      self:__PingPongFadeEffectPlay(not flip, totalCount, curCount, time, minScale, maxScale)
    end):SetLink(self.gameObject)
  else
    self.ui.img_turnWarrning:DOFade(minScale, time):OnComplete(function()
      self:__PingPongFadeEffectPlay(not flip, totalCount, curCount + 1, time, minScale, maxScale)
    end):SetLink(self.gameObject)
  end
end

function UINWarChessWarnLoop:__TurnChange(num)
  local warningNumber = WarChessManager.wcLevelCfg.warning
  if 0 < (warningNumber or 0) and warningNumber - num <= 0 then
    self:__ResetWarnState()
    self:__PingPongFadeEffectPlay(false, 2, 0, 0.5)
    self.ui.img_turnWarrning.transform:DOPunchScale(Vector3.New(0.5, 0.5, 0), 0.5, 1, 0):SetLoops(2)
  end
end

function UINWarChessWarnLoop:__ResetWarnState()
  self.ui.img_turnWarrning:DOKill()
  self.ui.img_turnWarrning.transform:DOKill()
  local color = self.ui.img_turnWarrning.color
  color.a = 0
  self.ui.img_turnWarrning.color = color
end

function UINWarChessWarnLoop:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_SelectTeam, self.__TeamChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.WC_TurnStart, self.__TurnChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.WC_HeroDynUpdate, self.__HeroDynUpdateCallback)
  base.OnDelete(self)
end

return UINWarChessWarnLoop
