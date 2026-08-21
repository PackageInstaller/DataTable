_class("UIBattlePassCN1QuestTabBtn", UICustomWidget)
UIBattlePassCN1QuestTabBtn = UIBattlePassCN1QuestTabBtn
local UIBattlePassCN1QuestTabBtnState = {
  Lock = 1,
  Off = 2,
  On = 3
}
_enum("UIBattlePassCN1QuestTabBtnState", UIBattlePassCN1QuestTabBtnState)

function UIBattlePassCN1QuestTabBtn:OnShow(uiParams)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIBattlePassCN1QuestTabBtn:OnHide()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIBattlePassCN1QuestTabBtn:SetData(index, campaign, callback)
  self._index = index
  self._campaign = campaign
  self._callback = callback
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_Quest(self._campaign, index)
  self:_SetUiStyle(index)
  self:Refresh()
end

function UIBattlePassCN1QuestTabBtn:Refresh(selected)
  self._state = self:_CheckState(selected)
  self:_SetState(self._state)
  self:_CheckPoint()
end

function UIBattlePassCN1QuestTabBtn:PlayAnimationInSequence(index)
  local animName, duration = "UIeff_UIBattlePassCN1QuestTabBtn_in", 333
  local delay = index * 60
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, false)
end

function UIBattlePassCN1QuestTabBtn:_CheckState(selected)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local unlockTime = self._componentInfo.m_unlock_time
  local closeTime = self._componentInfo.m_close_time
  self._notStart = curTime < unlockTime
  self._isClosed = curTime > closeTime
  local isLock = self._notStart or self._isClosed
  local state = UIBattlePassCN1QuestTabBtnState.Off
  state = selected and UIBattlePassCN1QuestTabBtnState.On or state
  state = isLock and UIBattlePassCN1QuestTabBtnState.Lock or state
  return state
end

function UIBattlePassCN1QuestTabBtn:_SetState(state)
  local widgetGroup = {
    [UIBattlePassCN1QuestTabBtnState.Lock] = {"LockBtn"},
    [UIBattlePassCN1QuestTabBtnState.Off] = {"OffBtn"},
    [UIBattlePassCN1QuestTabBtnState.On] = {"OnBtn"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetGroup, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIBattlePassCN1QuestTabBtn:_GetImageStyleInfo(index, state)
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_Extra")
  local ImgIdx = {
    [1] = "_Img_Sprite_1",
    [2] = "_Img_Sprite_2",
    [3] = "_Img_Sprite_3"
  }
  local strIdx = {
    [1] = "_Txt_StrId_1",
    [2] = "_Txt_StrId_2",
    [3] = "_Txt_StrId_3"
  }
  local bgSt = {
    [UIBattlePassCN1QuestTabBtnState.Lock] = "_Bg_Lock",
    [UIBattlePassCN1QuestTabBtnState.Off] = "_Bg_Off",
    [UIBattlePassCN1QuestTabBtnState.On] = "_Bg_On"
  }
  local imgSt = {
    [UIBattlePassCN1QuestTabBtnState.Lock] = "_Img_Color_Lock",
    [UIBattlePassCN1QuestTabBtnState.Off] = "_Img_Color_Off",
    [UIBattlePassCN1QuestTabBtnState.On] = "_Img_Color_On"
  }
  local txtSt = {
    [UIBattlePassCN1QuestTabBtnState.Lock] = "_Txt_Color_Lock",
    [UIBattlePassCN1QuestTabBtnState.Off] = "_Txt_Color_Off",
    [UIBattlePassCN1QuestTabBtnState.On] = "_Txt_Color_On"
  }
  local tb_out = {
    bgInfos = {
      tb[bgSt[state]]
    },
    imgInfos = {
      tb[ImgIdx[index]],
      tb[imgSt[state]]
    },
    txtInfos = {
      tb[strIdx[index]],
      tb[txtSt[state]]
    }
  }
  return tb_out
end

function UIBattlePassCN1QuestTabBtn:_SetUiStyle(index)
  local tb = {
    [UIBattlePassCN1QuestTabBtnState.Lock] = {
      bg = "bg_lock",
      img = "img_lock",
      txt = "txt_lock"
    },
    [UIBattlePassCN1QuestTabBtnState.Off] = {
      bg = "bg_off",
      img = "img_off",
      txt = "txt_off"
    },
    [UIBattlePassCN1QuestTabBtnState.On] = {
      bg = "bg_on",
      img = "img_on",
      txt = "txt_on"
    }
  }
  for st, widget in ipairs(tb) do
    local styleInfo = self:_GetImageStyleInfo(index, st)
    for _, info in ipairs(styleInfo.bgInfos) do
      UIStyleHelper.FitStyle_Widget(info, self, widget.bg)
    end
    for _, info in ipairs(styleInfo.imgInfos) do
      UIStyleHelper.FitStyle_Widget(info, self, widget.img)
    end
    for _, info in ipairs(styleInfo.txtInfos) do
      UIStyleHelper.FitStyle_Widget(info, self, widget.txt)
    end
  end
end

function UIBattlePassCN1QuestTabBtn:LockBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._notStart then
    Log.info("UIBattlePassCN1QuestTabBtn:LockBtnOnClick() NotStart")
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local endTime = self._componentInfo.m_unlock_time
    local stamp = endTime - curTime
    if stamp <= 0 then
      self:Refresh()
      return
    end
    local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
    local str = StringTable.Get("str_activity_battlepass_tab_quest_group_notstart", timeStr)
    ToastManager.ShowToast(str)
  else
    Log.info("UIBattlePassCN1QuestTabBtn:LockBtnOnClick() IsClosed")
    ToastManager.ShowToast(StringTable.Get("str_activity_battlepass_tab_quest_group_over"))
  end
end

function UIBattlePassCN1QuestTabBtn:OffBtnOnClick()
  Log.info("UIBattlePassCN1QuestTabBtn:OffBtnOnClick()")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._callback then
    self._callback(self._index)
  end
end

function UIBattlePassCN1QuestTabBtn:OnBtnOnClick()
  Log.info("UIBattlePassCN1QuestTabBtn:OnBtnOnClick()")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
end

function UIBattlePassCN1QuestTabBtn:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UIBattlePassCN1QuestTabBtn:_CheckPoint()
  local isShow = UIActivityBattlePassHelper.CalcRed_Quest(self._campaign, self._index)
  self:GetGameObject("red"):SetActive(isShow)
end
