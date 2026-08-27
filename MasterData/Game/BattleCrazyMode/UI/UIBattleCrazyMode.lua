local UIBattleCrazyMode = class("UIBattleCrazyMode", UIBaseWindow)
local base = UIBaseWindow
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_WaitForSecondsRealtime = CS.UnityEngine.WaitForSecondsRealtime
local util = require("XLua.Common.xlua_util")

function UIBattleCrazyMode:OnInit()
  self.ui.countdown:SetActive(false)
  self.ui.crazyBuffList:SetActive(false)
  self.ui.tipsList:SetActive(false)
  self.ui.cTipsFade.gameObject:SetActive(false)
  self.ui.cTipsFadeMoveY = 20
  self.cTipsFadePos = self.ui.cTipsFade.transform.localPosition
  self.ui.crazyAtnTips.gameObject:SetActive(false)
  self.ui.crazyAtnTipsMoveY = 20
  self.cAtnTipsPos = self.ui.crazyAtnTips.transform.localPosition
  self.ui.crazyHpTips.gameObject:SetActive(false)
  self.ui.crazyHpTipsMoveY = 20
  self.cHpTipsPos = self.ui.crazyHpTips.transform.localPosition
  self.ui.crazyBuff1.onPress:AddListener(BindCallback(self, self.__OnCrazyBuff1Press))
  self.ui.crazyBuff1.onPressUp:AddListener(BindCallback(self, self.__OnCrazyBuffPressUp))
  self.ui.crazyBuff2.onPress:AddListener(BindCallback(self, self.__OnCrazyBuff2Press))
  self.ui.crazyBuff2.onPressUp:AddListener(BindCallback(self, self.__OnCrazyBuffPressUp))
  self.ui.btn_countdown.onPress:AddListener(BindCallback(self, self.__OnCountdownPress))
  self.ui.btn_countdown.onPressUp:AddListener(BindCallback(self, self.__OnCrazyBuffPressUp))
  self.isCrazy = false
  self.CrazyTipsData = {}
  self:InitCrazyTipsData()
end

function UIBattleCrazyMode:InjectCrazyTime(time)
  self.crazyStartTime = time
end

function UIBattleCrazyMode:InitCrazyTipsData()
  self.ui.tex_Percentage1:SetIndex(0, "0")
  self.ui.tex_Percentage2:SetIndex(0, "0")
  self.ui.tex_Countdown.text = tostring(self.crazyStartTime or 0)
  for k, v in pairs(ConfigData.overload) do
    if v.pop_up then
      self.CrazyTipsData[k] = 1
    end
  end
end

function UIBattleCrazyMode:Update(battleCtrl)
  local time = battleCtrl.timeInt
  if self.isCrazy then
    self:CrazyBuffInfoUpdate(math.floor(time - self.crazyStartTime + 2))
  else
    self:CrazyTimeInfoUpdate(self.crazyStartTime - time - 1)
  end
end

function UIBattleCrazyMode:CrazyTimeInfoUpdate(time)
  if self.isCrazy or self.ui == nil then
    return
  end
  local Countdown = math.max(0, time)
  local showCountdown = Countdown <= 10 and not BattleUtil.IsBattleEnableFormation()
  self.ui.countdown:SetActive(showCountdown)
  self.ui.tex_Countdown.text = Countdown
  if Countdown <= 0 then
    self:OnBattleCrazyStart()
  end
end

function UIBattleCrazyMode:CrazyBuffInfoUpdate(time)
  if not self.isCrazy or time <= 0 then
    return
  end
  if self.ui.countdown.activeSelf then
    self.ui.countdown:SetActive(false)
    self.ui.crazyBuffList:SetActive(true)
  end
  local overloadCfg = ConfigData.overload[time]
  if overloadCfg then
    self.ui.tex_Percentage1:SetIndex(0, tostring(overloadCfg.dps_up))
    self.ui.tex_Percentage2:SetIndex(0, tostring(overloadCfg.heal_down))
    if overloadCfg.pop_up then
      local AtnTips = tostring(overloadCfg.dps_up) .. "%"
      local HpTips = tostring(overloadCfg.heal_down) .. "%"
      self.ui.tex_CrazyAtnTips.text = string.format(ConfigData:GetTipContent(TipContent.Overload_Atn_Buff_Tip), AtnTips)
      self.ui.tex_CrazyHpTips.text = string.format(ConfigData:GetTipContent(TipContent.Overload_Hp_Buff_Tip), HpTips)
      self:ShowCrazyTips()
    end
  end
end

function UIBattleCrazyMode:OnBattleStartCrazyMode(battleCtrl)
  if self.__TimerId ~= nil then
    TimerManager:StopTimer(self.__TimerId)
    self.__TimerId = nil
  end
  self.__TimerId = TimerManager:StartTimer(1, BindCallback(self, self.Update, battleCtrl), nil, false, false, false)
  self:Show()
end

function UIBattleCrazyMode:OnBattlePause()
  self:Hide()
end

function UIBattleCrazyMode:OnBattleContinue()
  self:Show()
end

function UIBattleCrazyMode:OnBattleCrazyStart()
  self.ui.tex_CrazyTips.text = ConfigData:GetTipContent(TipContent.Overload_Tip)
  self.isCrazy = true
  self:CrazyBuffInfoUpdate(1)
end

function UIBattleCrazyMode:__OnCrazyBuff1Press()
  self:ShowBuffInfo(1)
end

function UIBattleCrazyMode:__OnCrazyBuff2Press()
  self:ShowBuffInfo(2)
end

function UIBattleCrazyMode:__OnCountdownPress()
  self:ShowBuffInfo(3)
end

function UIBattleCrazyMode:__OnCrazyBuffPressUp()
  self:HideBuffInfo()
end

function UIBattleCrazyMode:ShowBuffInfo(index)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  if index == 1 or index == 2 then
    win:SetTitleAndContext("", ConfigData:GetTipContent(TipContent.Overload_Buff_Tip))
  else
    win:SetTitleAndContext("", ConfigData:GetTipContent(TipContent.Overload_Time_Tip))
  end
  if index == 1 then
    win:FloatTo(self.ui.crazyBuff1.transform, HAType.left, VAType.down)
  end
  if index == 2 then
    win:FloatTo(self.ui.crazyBuff2.transform, HAType.left, VAType.down)
  end
  if index == 3 then
    win:FloatTo(self.ui.countdown.transform, HAType.left, VAType.down)
  end
end

function UIBattleCrazyMode:HideBuffInfo()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UIBattleCrazyMode:ShowCrazyTips()
  if self.__crazyTipsCoroutine == nil then
    self.__crazyTipsCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__StartCoroutineCrazyTips)))
  end
end

function UIBattleCrazyMode:__ShowCrazyTipsTween()
  if self.__showCTipsSeq ~= nil then
    self.__showCTipsSeq:Restart()
  else
    self.ui.cTipsFade.gameObject:SetActive(true)
    self.ui.cTipsFade.alpha = 0
    local cTipsPos = Vector3.New(self.cTipsFadePos.x, self.cTipsFadePos.y - self.ui.cTipsFadeMoveY, self.cTipsFadePos.z)
    self.ui.cTipsFade.transform.localPosition = cTipsPos
    local sequence = cs_DoTween.Sequence()
    sequence:Append(self.ui.cTipsFade:DOFade(1, 0.15):SetLoops(4, CS.DG.Tweening.LoopType.Restart))
    sequence:Join(self.ui.cTipsFade.transform:DOLocalMoveY(self.ui.cTipsFadeMoveY, 0.3):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    self.__showCTipsSeq = sequence
  end
  if self.__showCAtnTipsSeq ~= nil then
    self.__showCAtnTipsSeq:Restart()
  else
    self.ui.crazyAtnTips.gameObject:SetActive(true)
    self.ui.crazyAtnTips.alpha = 0
    local cTipsPos = Vector3.New(self.cAtnTipsPos.x, self.cAtnTipsPos.y - self.ui.crazyAtnTipsMoveY, self.cAtnTipsPos.z)
    self.ui.crazyAtnTips.transform.localPosition = cTipsPos
    local sequence = cs_DoTween.Sequence()
    sequence:Append(self.ui.crazyAtnTips:DOFade(1, 0.15):SetLoops(4, CS.DG.Tweening.LoopType.Restart))
    sequence:Join(self.ui.crazyAtnTips.transform:DOLocalMoveY(self.ui.crazyAtnTipsMoveY, 0.3):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    self.__showCAtnTipsSeq = sequence
  end
  if self.__showCHpTipsSeq ~= nil then
    self.__showCHpTipsSeq:Restart()
  else
    self.ui.crazyHpTips.gameObject:SetActive(true)
    self.ui.crazyHpTips.alpha = 0
    local cTipsPos = Vector3.New(self.cHpTipsPos.x, self.cHpTipsPos.y - self.ui.crazyAtnTipsMoveY, self.cHpTipsPos.z)
    self.ui.crazyHpTips.transform.localPosition = cTipsPos
    local sequence = cs_DoTween.Sequence()
    sequence:Append(self.ui.crazyHpTips:DOFade(1, 0.15):SetLoops(4, CS.DG.Tweening.LoopType.Restart))
    sequence:Join(self.ui.crazyHpTips.transform:DOLocalMoveY(self.ui.crazyAtnTipsMoveY, 0.3):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    self.__showCHpTipsSeq = sequence
  end
end

function UIBattleCrazyMode:__HideCrazyTipsTween()
  if self.__hideCTipsSeq ~= nil then
    self.__hideCTipsSeq:Restart()
  else
    local sequence = cs_DoTween.Sequence()
    sequence:Append(self.ui.cTipsFade:DOFade(0, 0.3))
    sequence:Join(self.ui.cTipsFade.transform:DOLocalMoveY(self.ui.cTipsFadeMoveY, 0.3):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    sequence:AppendCallback(function()
      self.ui.cTipsFade.gameObject:SetActive(false)
    end)
    self.__hideCTipsSeq = sequence
  end
  if self.__hideCAtnTipsSeq ~= nil then
    self.__hideCAtnTipsSeq:Restart()
  else
    local sequence = cs_DoTween.Sequence()
    sequence:Append(self.ui.crazyAtnTips:DOFade(0, 0.3))
    sequence:Join(self.ui.crazyAtnTips.transform:DOLocalMoveY(self.ui.crazyAtnTipsMoveY, 0.3):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    sequence:AppendCallback(function()
      self.ui.crazyAtnTips.gameObject:SetActive(false)
      GR.StopCoroutine(self.__crazyTipsCoroutine)
      self.__crazyTipsCoroutine = nil
    end)
    self.__hideCAtnTipsSeq = sequence
  end
  if self.__hideCHpTipsSeq ~= nil then
    self.__hideCHpTipsSeq:Restart()
  else
    local sequence = cs_DoTween.Sequence()
    sequence:Append(self.ui.crazyHpTips:DOFade(0, 0.3))
    sequence:Join(self.ui.crazyHpTips.transform:DOLocalMoveY(self.ui.crazyAtnTipsMoveY, 0.3):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    sequence:AppendCallback(function()
      self.ui.crazyHpTips.gameObject:SetActive(false)
    end)
    self.__hideCHpTipsSeq = sequence
  end
end

function UIBattleCrazyMode:__StartCoroutineCrazyTips()
  self:__ClearTipsTween()
  self:__ShowCrazyTipsTween()
  coroutine.yield(cs_WaitForSecondsRealtime(self.ui.cTipsShowTime))
  self:__HideCrazyTipsTween()
end

function UIBattleCrazyMode:__ClearTipsTween()
  if self.__showCAtnTipsSeq ~= nil then
    self.__showCAtnTipsSeq:Kill()
    self.__showCAtnTipsSeq = nil
  end
  if self.__showCHpTipsSeq ~= nil then
    self.__showCHpTipsSeq:Kill()
    self.__showCHpTipsSeq = nil
  end
  if self.__showCTipsSeq ~= nil then
    self.__showCTipsSeq:Kill()
    self.__showCTipsSeq = nil
  end
  if self.__hideCTipsSeq ~= nil then
    self.__hideCTipsSeq:Kill(true)
    self.__hideCTipsSeq = nil
  end
  if self.__hideCAtnTipsSeq ~= nil then
    self.__hideCAtnTipsSeq:Kill(true)
    self.__hideCAtnTipsSeq = nil
  end
  if self.__hideCHpTipsSeq ~= nil then
    self.__hideCHpTipsSeq:Kill(true)
    self.__hideCHpTipsSeq = nil
  end
end

function UIBattleCrazyMode:Show(withTween)
  if self.active then
    return
  end
  base.Show(self)
end

function UIBattleCrazyMode:Hide(withTween)
  if not self.active then
    return
  end
  base.Hide(self)
end

function UIBattleCrazyMode:OnDelete()
  self:__ClearTipsTween()
  self.isCrazy = false
  TimerManager:StopTimer(self.__TimerId)
  self.CrazyTipsData = {}
  if self.__crazyTipsCoroutine ~= nil then
    GR.StopCoroutine(self.__crazyTipsCoroutine)
    self.__crazyTipsCoroutine = nil
  end
  base.OnDelete(self)
end

return UIBattleCrazyMode
