local UIEventAngelaGiftMain = class("UIEventAngelaGiftMain", UIBaseWindow)
local base = UIBaseWindow
local UINEventAngelaGiftSmallNode = require("Game.EventAngelaGift.UI.UINEventAngelaGiftSmallNode")
local UINEventAngelaGiftBigNode = require("Game.EventAngelaGift.UI.UINEventAngelaGiftBigNode")
local JumpManager = require("Game.Jump.JumpManager")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation

function UIEventAngelaGiftMain:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.angelaGiftController = ControllerManager:GetController(ControllerTypeId.EventAngelaGift, true)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickClose)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
  self._RefreshAllGift = BindCallback(self, self.RefreshAllGift)
  self.TweenDic = self.transform:GetComponentsInChildren(typeof(CS_DOTweenAnimation))
end

function UIEventAngelaGiftMain:InitEventAngelaGiftMain(actId, isPop)
  self.isPop = isPop
  self.angelaGiftData = self.angelaGiftController:GetAngelaGiftDataByActId(actId)
  if self.angelaGiftData == nil then
    return
  end
  local giftSteps = giftSteps or {}
  for index, giftInfo in ipairs(self.angelaGiftData.groupGiftInfos) do
    local giftItem = giftSteps[index]
    if giftItem == nil then
      giftItem = index < 3 and UINEventAngelaGiftSmallNode.New() or UINEventAngelaGiftBigNode.New()
      giftItem:Init(self.ui.array_gifts[index])
      giftSteps[index] = giftItem
    end
    giftItem:InitAngelaGiftNode(giftInfo, self._RefreshAllGift)
  end
  self.giftSteps = giftSteps
  if isPop then
    self.ui.tog_popup.gameObject:SetActive(true)
    self.ui.btn_close.gameObject:SetActive(true)
    self.ui.btn_background.gameObject:SetActive(true)
    local scale = self.ui.obj_main.transform.localScale
    scale.x = 0.9
    scale.y = 0.9
    self.ui.obj_main.transform.localScale = scale
  else
    self.ui.tog_popup.gameObject:SetActive(false)
    self.ui.btn_close.gameObject:SetActive(false)
    self.ui.btn_background.gameObject:SetActive(false)
    local scale = self.ui.obj_main.transform.localScale
    scale.x = 1
    scale.y = 1
    self.ui.obj_main.transform.localScale = scale
    self.angelaGiftData:SetAngelaGiftDataLooked()
    for i = 0, self.TweenDic.Length - 1 do
      local tween = self.TweenDic[i]
      tween:DOComplete()
    end
  end
  self:RefreshAllGift()
end

function UIEventAngelaGiftMain:SetCloseCallback(closeCallback)
  self._closeCallback = closeCallback
end

function UIEventAngelaGiftMain:OnStepChange(step)
  self.ui.tex_des.gameObject:SetActive(true)
  self.ui.tex_subDes.gameObject:SetActive(true)
  if step == 1 then
    self.ui.tex_des.text = ConfigData:GetTipContent(7900)
    self.ui.tex_subDes.text = ConfigData:GetTipContent(7903)
  elseif step == 2 then
    self.ui.tex_des.text = ConfigData:GetTipContent(7901)
    self.ui.tex_subDes.text = ConfigData:GetTipContent(7904)
  elseif step == 3 then
    self.ui.tex_des.text = ConfigData:GetTipContent(7902)
    self.ui.tex_subDes.gameObject:SetActive(false)
  else
    self.ui.tex_des.text = ConfigData:GetTipContent(7902)
    self.ui.tex_subDes.gameObject:SetActive(false)
    if self.isPop then
      self:OnClickClose()
    end
  end
end

function UIEventAngelaGiftMain:RefreshAllGift()
  local currentStep = self.angelaGiftData:GetGroupGiftCurrentStep()
  for step, giftItem in ipairs(self.giftSteps) do
    if step < currentStep then
      giftItem:SetAngelaGiftState(UINEventAngelaGiftSmallNode.eGiftState.Picked)
    elseif step > currentStep then
      giftItem:SetAngelaGiftState(UINEventAngelaGiftSmallNode.eGiftState.Locked)
    else
      giftItem:SetAngelaGiftState(UINEventAngelaGiftSmallNode.eGiftState.CanBuy)
    end
  end
  self:OnStepChange(currentStep)
end

function UIEventAngelaGiftMain:BackAction()
  self:Delete()
end

function UIEventAngelaGiftMain:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventAngelaGiftMain:OnDelete()
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  if self.ui.tog_popup.isOn then
    self.angelaGiftData:SetAngelaGiftDataCantPopToday()
  end
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  base.OnDelete(self)
end

return UIEventAngelaGiftMain
