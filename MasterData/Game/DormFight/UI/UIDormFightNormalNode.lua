local UIDormFightNormalNode = class("UINFmtNotEditNode", UIBaseNode)
local base = UIBaseNode

function UIDormFightNormalNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Editor, self, self.__OnClickEdit)
  UIUtil.AddButtonListener(self.ui.btn_Ready, self, self.__OnClickReady)
  self.hasReady = false
end

function UIDormFightNormalNode:InitDormFightNormalNode(fmtCtrl)
  self.fmtCtrl = fmtCtrl
  self.resloader = self.fmtCtrl:GetResloader()
  self.hasReady = false
  self:__ChangeToUnReadyState()
  local endTime = fmtCtrl:GetEndTime()
  if endTime ~= nil then
    self.CountDownSecend = endTime - PlayerDataCenter.timestamp
  end
  self:UpdateCountDown()
  if self._countDownTimerId ~= nil and self._countDownTimerId > 0 then
    TimerManager:StopTimer(self._countDownTimerId)
  end
  if self.CountDownSecend ~= nil then
    self._countDownTimerId = TimerManager:StartTimer(1, BindCallback(self, self.UpdateCountDown), nil, false, false, false)
  end
  local currentCount = self.fmtCtrl:GetSelectedFighterCount()
  local maxCount = self.fmtCtrl:GetMaxFighterCount()
  self:_RefreshSelectCount(currentCount, maxCount)
end

function UIDormFightNormalNode:OnShow()
  if self.fmtCtrl ~= nil then
    local currentCount = self.fmtCtrl:GetSelectedFighterCount()
    local maxCount = self.fmtCtrl:GetMaxFighterCount()
    self:_RefreshSelectCount(currentCount, maxCount)
  end
end

function UIDormFightNormalNode:UpdateCountDown()
  if self.CountDownSecend == nil then
    return
  end
  local time = self.fmtCtrl:GetEndTime() - PlayerDataCenter.timestamp
  self.CountDownSecend = self.CountDownSecend - 1
  if math.abs(self.CountDownSecend - time) > 2 then
    self.CountDownSecend = time
  end
  if self.CountDownSecend >= 0 and not IsNull(self.ui.tex_CountDown) then
    self.ui.tex_CountDown.text = TimeUtil:TimestampToTime(self.CountDownSecend)
  end
  if self.CountDownSecend <= ConfigData.dorm_fight_config.countDownSFXStartTime then
    AudioManager:PlayAudioById(ConfigData.dorm_fight_config.countDownAudioId)
  end
  if self.CountDownSecend < 0 then
    self:OnCountDownEnd()
    return
  end
end

function UIDormFightNormalNode:OnCountDownEnd()
end

function UIDormFightNormalNode:_RefreshSelectCount(currentCount, MaxCount)
  self.ui.Tex_Num.text = currentCount .. "/" .. MaxCount
end

function UIDormFightNormalNode:__OnClickEdit()
  self.fmtCtrl:EnterEditSate()
end

function UIDormFightNormalNode:__OnClickReady()
  if self.hasReady == true then
    return
  end
  local formationData = self.fmtCtrl:GetDfFormationData()
  local formationHeroDic = formationData:GetFormationHeroDic()
  local heroIds = {}
  local skinIds = {}
  for formatindex, heroId in pairs(formationHeroDic) do
    if heroId ~= nil then
      table.insert(heroIds, heroId)
      local heroData = PlayerDataCenter.heroDic[heroId]
      table.insert(skinIds, heroData.skinId)
    end
  end
  if #heroIds ~= 3 then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9350))
    return
  end
  self.ui.anim_already:Play()
  TimerManager:StopTimer(self._waitUIAnimOver)
  self._waitUIAnimOver = TimerManager:StartTimer(1, function()
    local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
    if dormFightCtrl ~= nil then
      dormFightCtrl:ConfirmDormFightFormation(heroIds, skinIds, function()
        self.hasReady = true
        self:__ChangeToReadyState()
      end)
    end
  end, nil, true)
end

function UIDormFightNormalNode:__ChangeToUnReadyState()
  self.ui.img_btnReadyBg:SetIndex(0)
  self.ui.tex_btnReady:SetIndex(0)
  self.ui.img_Prepare:SetActive(true)
end

function UIDormFightNormalNode:__ChangeToReadyState()
  self.ui.img_btnReadyBg:SetIndex(1)
  self.ui.tex_btnReady:SetIndex(1)
  self.ui.img_Ready:SetActive(true)
end

function UIDormFightNormalNode:OnDelete()
  if self._countDownTimerId ~= nil and self._countDownTimerId > 0 then
    TimerManager:StopTimer(self._countDownTimerId)
  end
end

return UIDormFightNormalNode
