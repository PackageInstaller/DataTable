local UIEventLadderGift = class("UIEventLadderGift", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local JumpManager = require("Game.Jump.JumpManager")
local UINEventLadderGiftItem = require("Game.EventLadderGift.UI.UINEventLadderGiftItem")
local cs_ResLoader = CS.ResLoader
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation

function UIEventLadderGift:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.resloader = cs_ResLoader.Create()
  self._giftItemPool = UIItemPool.New(UINEventLadderGiftItem, self.ui.giftItem, false)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_ViewSkin, self, self._OnClickViewSkin)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
  self.__RefreshLadderGiftChangeCallback = BindCallback(self, self.__RefreshLadderGiftChange)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__RefreshLadderGiftChangeCallback)
  self.TweenList = self.transform:GetComponentsInChildren(typeof(CS_DOTweenAnimation))
end

function UIEventLadderGift:InitEventLadderGift(actId, isPop)
  self.isPop = isPop
  self.ladderGiftCtrl = ControllerManager:GetController(ControllerTypeId.EventLadderGift)
  self._actData = self.ladderGiftCtrl:GetLadderGiftDataByActId(actId)
  self._actLadderGiftCfg = self._actData:GetLadderGiftMainCfg()
  self:RefreshPopUI()
  self:RefreshNormalUI()
  local skinId = self._actData:GetLadderGiftSkinId()
  self.ui.btn_ViewSkin.gameObject:SetActive(skinId ~= 0)
  self:StopActTimer()
  self._timerId = TimerManager:StartTimer(1, self.__OnTimeDown, self, false, false)
  self:__OnTimeDown()
end

function UIEventLadderGift:RefreshPopUI()
  if self.isPop then
    self.ui.tog_Popup.gameObject:SetActive(true)
    self.ui.btn_Close.gameObject:SetActive(true)
    self.ui.btn_Background.gameObject:SetActive(true)
    local scale = self.ui.obj_main.transform.localScale
    scale.x = 0.9
    scale.y = 0.9
    self.ui.obj_main.transform.localScale = scale
  else
    self.ui.tog_Popup.gameObject:SetActive(false)
    self.ui.btn_Close.gameObject:SetActive(false)
    self.ui.btn_Background.gameObject:SetActive(false)
    local scale = self.ui.obj_main.transform.localScale
    scale.x = 1
    scale.y = 1
    self.ui.obj_main.transform.localScale = scale
    for i = 0, self.TweenList.Length - 1 do
      local tween = self.TweenList[i]
      tween:DOComplete()
    end
  end
end

function UIEventLadderGift:RefreshNormalUI()
  self.ui.tex_Title.text = tostring(self._actData:GetActivityName())
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._actLadderGiftCfg.tip_des)
  self.ui.tex_name.text = LanguageUtil.GetLocaleText(self._actLadderGiftCfg.activity_name)
  local timeTitle, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._actData)
  self.ui.tex_TimeTitle.text = timeTitle
  self.ui.tex_EndTime.text = timeStr
  self._expireTime = expireTime
  self.ui.tex_BigGiftName.text = LanguageUtil.GetLocaleText(self._actLadderGiftCfg.reward_des)
  self.ui.tex_BigGiftDes.text = LanguageUtil.GetLocaleText(self._actLadderGiftCfg.reward_tips)
  local path = PathConsts:GetActivityLadderGiftPath(self._actLadderGiftCfg.reward_pic)
  self.ui.img_Title.enabled = false
  self.resloader:LoadABAssetAsync(path, function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Title.texture = texture
    self.ui.img_Title.enabled = true
  end)
  self:RefreshLadderGiftList()
end

function UIEventLadderGift:SetCloseCallback(closeCallback)
  self._closeCallback = closeCallback
end

function UIEventLadderGift:RefreshLadderGiftList()
  local giftList = self._actLadderGiftCfg.group_id
  if 3 < #giftList then
    self.ui.rect_item.pivot = Vector2.Temp(0, 0.5)
  else
    self.ui.rect_item.pivot = Vector2.Temp(0.5, 0.5)
  end
  self._giftItemPool:HideAll()
  local lastGiftInfo
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  for id, giftId in pairs(giftList) do
    local payGiftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    local giftItem = self._giftItemPool:GetOne()
    giftItem:InitEventLadderGiftItem(payGiftInfo, self.resloader, id, lastGiftInfo)
    lastGiftInfo = payGiftInfo
  end
  local nowNum = self._actData:GetGroupGiftCurrentStep()
  nowNum = math.clamp(nowNum, 1, #giftList)
  local offsetNum = 1 < #giftList and (nowNum - 1) / (#giftList - 1) or 0
  self.ui.scroll_rect.horizontalNormalizedPosition = offsetNum
end

function UIEventLadderGift:BackAction()
  self:Delete()
end

function UIEventLadderGift:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventLadderGift:_OnClickViewSkin()
  local skinId = self._actData:GetLadderGiftSkinId()
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    skinId,
    require("Game.Skin.SkinEnum").fromWhere.bp
  }, true)
end

function UIEventLadderGift:__RefreshLadderGiftChange()
  self:RefreshLadderGiftList()
end

function UIEventLadderGift:__OnTimeDown()
  local diffStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime)
  self.ui.tex_LastTime.text = diffStr
  if diff <= 0 then
    self:StopActTimer()
  end
end

function UIEventLadderGift:StopActTimer()
  if self._timerId then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIEventLadderGift:OnDelete()
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self:StopActTimer()
  self._giftItemPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__RefreshLadderGiftChangeCallback)
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  if self.ui.tog_Popup.isOn then
    self._actData:SetLadderGiftDataCantPopToday()
  end
end

return UIEventLadderGift
