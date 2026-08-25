local UIBasePanel = require("Managers.UI.UIBasePanel")
local UI_Awaker_Popup_Tip_SucceedResource = require("UI.UIPackages.UI_Awaker_Popup_Tip_SucceedResource")
local AwakerBreakthroughAttrAdd = require("UI.Awaker.Item.AwakerBreakthroughAttrAdd")
local AwakerBreakthroughStars = require("UI.Awaker.Item.AwakerBreakthroughStars")
local System = require("System.System")
local DT = require("System.DataTable")
local typeof = _ENV.typeof
local CommonDefine = require("World.Enums.CommonDefine")
local AnimatorUtils = require("Animation.AnimatorUtils")
local AudioManager = require("Managers.AudioManager")
local AwakerAudioManager = require("Managers.AwakerAudioManager")
local Animator = CS.UnityEngine.Animator
local AwakerPage = CommonDefine.AwakerPage
local AwakerBreakthroughSuccessPanel, Super = System.NewClass("AwakerBreakthroughSuccessPanel", UIBasePanel)
AwakerBreakthroughSuccessPanel.uiResCls = UI_Awaker_Popup_Tip_SucceedResource

function AwakerBreakthroughSuccessPanel:ctor(model, attrModel)
  Super.ctor(self)
  self.model = model
  self.attrModel = attrModel
end

function AwakerBreakthroughSuccessPanel:InitUI(uiNode)
  Super.InitUI(self, uiNode)
  local tid = self.model.selectAwakerId
  local maxStar = self.model:GetAwakerBreakthroughMaxStar(tid)
  self.breakthroughStars = AwakerBreakthroughStars(self.ui.RootStars, maxStar)
end

function AwakerBreakthroughSuccessPanel:OnBind(binder)
  binder:BindToRaw(function(_, numStars)
    if not numStars then
      return
    end
    for idx = 1, self.breakthroughStars:NumStars() do
      if idx < numStars then
        self.breakthroughStars:TurnOn(idx)
      elseif idx == numStars then
        self.breakthroughStars:TurnOnAndShining(idx)
      else
        self.breakthroughStars:TurnOff(idx)
      end
    end
  end, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerCurrBreakthroughStar, self.model end
    return self.model.GetAwakerCurrBreakthroughStar, self.model, tid
  end)
  binder:BindToText(self.ui.Text_Lv, function()
    local tid = self.model.selectAwakerId
    local level = self.model:GetAwakerLevel(tid)
    local currLevelLimit = self.model:GetAwakerCurrLevelLimit(tid)
    do return string.format, "Lv.%s/%s", level end
    return string.format, "Lv.%s/%s", level, currLevelLimit
  end)
  binder:BindToVisible(self.ui.SkillRoot, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerCurrBreakthroughStarSkillName(awakerTid) ~= nil
  end)
  binder:BindToText(self.ui.Text_Skill, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerCurrBreakthroughStarSkillName(awakerTid) or ""
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerCurrBreakthroughStarSkillIcon(awakerTid) or ""
  end)
  binder:BindToRaw(function()
    self.model:CalcCurrBreakthroughStarAttrChange(self.model.selectAwakerId, self.attrModel)
  end, function()
    return self.attrModel.baseAttrs
  end)
  binder:BindToCircularListView(self.ui.ScrollView_AttrAdd, function()
    local awakerTid = self.model.selectAwakerId
    do return self.model.GetAwakerCurrBreakthroughStarAttrChange, self.model end
    return self.model.GetAwakerCurrBreakthroughStarAttrChange, self.model, awakerTid
  end, function(itemBinder, obj, index)
    local awakerTid = self.model.selectAwakerId
    local attrChangeList = self.model:GetAwakerCurrBreakthroughStarAttrChange(awakerTid)
    itemBinder:BindComponent(AwakerBreakthroughAttrAdd(obj, attrChangeList[index]))
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.Close))
  self.ui.Image_Gradient:SetActive(false)
  self:ShowAwakerVoice(AwakerAudioManager.Instance:GetAwakerVoiceId(CommonDefine.AwakerVoiceTrigger.AwakerPromote, self.model.selectAwakerId, self.model.awakerCurSkin))
  self.model:SetCurAwakerVoice("", "")
end

function AwakerBreakthroughSuccessPanel:Close()
  self.model:SetAwakerPage(AwakerPage.Detail)
  Super.Close(self)
end

function AwakerBreakthroughSuccessPanel:ShowAwakerVoice(voiceId)
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

return AwakerBreakthroughSuccessPanel
