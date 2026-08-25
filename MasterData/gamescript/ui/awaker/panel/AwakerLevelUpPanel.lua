local typeof = _ENV.typeof
local Text = CS.UnityEngine.UI.Text
local Animator = CS.UnityEngine.Animator
local Toggle = CS.UnityEngine.UI.Toggle
local AwakerLevelUpPanel, Super = System.NewClass("AwakerLevelUpPanel", UIBasePanel)
AwakerLevelUpPanel.uiResCls = UI_Awaker_Popup_Levelup_TipResource

function AwakerLevelUpPanel:ctor(data)
  Super.ctor(self)
  self.awakerTid = data.awakerTid
  self.level = data.level
  self.exp = data.exp
  self.model = data.model
end

function AwakerLevelUpPanel:OnBind(binder)
  self.binder = binder
  local toggleComp = self.ui.Toggle_Level_Max:GetComponent(typeof(Toggle))
  toggleComp.isOn = false
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.OnCancelClick))
  local model = binder:createModel(AwakerLevelUpModel, self.awakerTid, self.level, self.exp, self.model)
  self.ui.Image_Gradient:SetActive(false)
  local confirmBtnTipsData = {
    clickFunc = function()
      local function OnReqSuccess()
        local tid = model.awakerTid
        
        local currLv = model.level
        local nextLv = model.targetLevel
        local improveList = AwakerDataUtils.GetAwakerLevelChangeAttrImprove(tid, currLv, nextLv)
        UIManager.Instance:Reopen(Urls.AwakerCommonUpSuccessPanel, LT.Text("Awaker_LevelUp_Success"), currLv, nextLv, improveList)
      end
      
      model:ReqAwakerLevelUp(OnReqSuccess)
    end,
    stateFunc = function()
      return model.levelUpState
    end,
    textFunc = function()
      return model.levelUpText
    end
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      if not animator then
        self:OnCancelClick()
        return
      end
      AnimatorUtils.PlayState(animator, "Base Layer.ClosePanel")
    end,
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnCancelClick))
  binder:BindToText(self.ui.Text_Level_Old, function()
    return model.level
  end)
  binder:BindToText(self.ui.Text_Level_Next, function()
    if model.hasReqLevelUp then
      local textComp = self.ui.Text_Level_Next:GetComponent(typeof(Text))
      return textComp.text
    end
    local tid = self.model.selectAwakerId
    local currLevelLimit = self.model:GetAwakerCurrLevelLimit(tid)
    do return math.min, model.targetLevel end
    return math.min, model.targetLevel, currLevelLimit
  end)
  binder:BindToText(self.ui.Text_Level_Total, function()
    local showStr = string.format("/ %s", model.maxLevel)
    return showStr
  end)
  binder:BindToText(self.ui.Text_Coin_Need, function()
    if model.isMaxLevel then
      return "--"
    end
    local ownExp, needExp = model.ownExp, model.needExp
    local ownNumColorStr = "#FFFFFF"
    if not model.isMaxLevel and ownExp < needExp then
      ownNumColorStr = "#E25312"
    end
    local effectResultValue = model.needReduceExp
    if effectResultValue and needExp > effectResultValue then
      if not model.isMaxLevel and ownExp >= effectResultValue then
        ownNumColorStr = "#FFFFFF"
      end
      needExp = LT.Textf("{s1} <color=#9A9A9A><Del:{s2}></color>", effectResultValue, needExp)
    end
    local moneyStateStr = LT.Textf("<color={s1}>{s2}</color>/{s3}", ownNumColorStr, ownExp, needExp)
    return moneyStateStr
  end)
  binder:BindToVisible(self.ui.Image_Max, function()
    return model.level == model.targetLevel
  end)
  binder:BindToVisible(self.ui.Group_Cost, function()
    return model.level < model.targetLevel
  end)
  binder:BindToVisible(self.ui.Toggle_Level_Max, function()
    return model.level < model.targetLevel
  end)
  binder:BindToImage(self.ui.Image_Coin_Icon, function()
    do return model.GetExpIcon end
    return model.GetExpIcon, model
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Levelup_List, function()
    do return model.GetImproveAttrList end
    return model.GetImproveAttrList, model
  end, function(itemBinder, obj, index)
    local list = model:GetImproveAttrList()
    local data = list[index]
    itemBinder:BindComponent(AwakerLevelUpAttrItem(obj, data))
  end)
  binder:BindToToggleValueChange(self.ui.Toggle_Level_Max, function(isOn)
    model:SetSingle(not isOn)
  end)
  binder:BindComponent(AwakerSpecialSkillAdditionItem(self.ui.UI_Awaker_Button_Addition, CommonDefine.AwakerSpecialSkillType.ResNeedReduce, "AwakerLevelUp"))
end

function AwakerLevelUpPanel:OnCancelClick()
  self:Close()
end

function AwakerLevelUpPanel:ShowAwakerVoice(voiceId)
  if 0 == voiceId then
    return
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  if self.timer ~= nil then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  self.timer = self.binder:BindTimer(duration, 1, nil, function()
    self.ui.Image_Gradient:SetActive(false)
  end)
  AudioManager.Instance:PostSoundEvent(soundEventName)
end

return AwakerLevelUpPanel
