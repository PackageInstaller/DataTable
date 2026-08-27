local UINSignInMininGameBeforeNode = class("UINSignInMininGameBeforeNode", UIBaseNode)
local base = UIBaseNode
local UINAwardItem = require("Game.ActivitySignInMiniGame.UI.UINSignInMiniGameAwardItem")
local UINDayItem = require("Game.ActivitySignInMiniGame.UI.UINSignInMiniGameDayItem")

function UINSignInMininGameBeforeNode:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINSignInMininGameBeforeNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_awardItem:SetActive(false)
  self.awardItemPool = UIItemPool.New(UINAwardItem, self.ui.obj_awardItem)
  self.ui.obj_vaildDayItem:SetActive(false)
  self.vaildDayItemPool = UIItemPool.New(UINDayItem, self.ui.obj_vaildDayItem)
  self.ui.obj_emptyDayItem:SetActive(false)
  self.emptyDayItemPool = UIItemPool.New(UINDayItem, self.ui.obj_emptyDayItem)
  self.vaildDayItemList = {}
  self._infoWindowAniTimer = nil
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.OnClickBtnJump)
  UIUtil.AddButtonListener(self.ui.btn_stop, self, self.OnClickBtnStop)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickBtnBg)
end

function UINSignInMininGameBeforeNode:InitNode(ctrl, resloader)
  self.siginInMiniCtrl = ctrl
  local actId = self.siginInMiniCtrl:GetActId()
  local cfg = ConfigData.sign_minigame_sign[actId]
  if cfg == nil then
    return
  end
  local curLeftDay = self.siginInMiniCtrl:GetLeftDayWithOpenTime(PlayerDataCenter.timestamp)
  if curLeftDay < 1 then
    self.ui.tex_Date.text = LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[13].content)
  else
    self.ui.tex_Date.text = curLeftDay .. LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[14].content)
  end
  local allSignDay = self.siginInMiniCtrl:GetAllSignInDay()
  local hasSignDayCount = self.siginInMiniCtrl:GetHasSignDayCount()
  local isSignToDay = not self.siginInMiniCtrl:IsCanSignToDay()
  local totalSignCount = self.siginInMiniCtrl:GetTotalSignDay(actId)
  self.resloader = resloader
  self.ui.obj_SignedBg:SetActive(isSignToDay)
  if not isSignToDay then
    if hasSignDayCount < 1 then
      self.ui.tex_Message.text = string.format(LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[11].content), hasSignDayCount + 1, totalSignCount)
    else
      self.ui.tex_Message.text = string.format(LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[12].content), hasSignDayCount + 1, totalSignCount)
    end
    self.ui.tex_Message.gameObject:SetActive(false)
    TimerManager:StartTimer(1, function(obj_tex)
      if IsNull(obj_tex) then
        return
      end
      obj_tex.gameObject:SetActive(true)
    end, self.ui.tex_Message, true, true)
  end
  self.ui.obj_infoWindow:SetActive(not isSignToDay)
  if not isSignToDay then
    local function callback()
      AudioManager:PlayAudioById(1250)
    end
    
    TimerManager:StopTimer(self._infoWindowAniTimer)
    self._infoWindowAniTimer = TimerManager:StartTimer(1, callback, self, true)
  end
  self.ui.tex_Text.text = string.format(LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[10].content), hasSignDayCount, totalSignCount)
  self.ui.tex_SigninTimes.text = tostring(hasSignDayCount) .. "/" .. totalSignCount
  self.awardItemPool:HideAll()
  local num = #cfg.award_num_max
  for i = num, 1, -1 do
    local item = self.awardItemPool:GetOne()
    item.transform:SetParent(self.ui.groupItem_Award.transform)
    item.transform:SetAsLastSibling()
    item:InitItem(i, cfg.award_num_min[i], cfg.award_num_max[i])
  end
  local actData = self.siginInMiniCtrl:GetActSignInMiniGameActData()
  local startTs = actData:GetActivityStartTime()
  local endTs = actData:GetActivityEndTime()
  local startTimetable = TimeUtil:TimestampToDate(startTs)
  local startWeek = startTimetable.wday
  startWeek = startWeek - 1
  if startWeek == 0 then
    startWeek = 7
  end
  self.emptyDayItemPool:HideAll()
  for i = 1, startWeek - 1 do
    local item = self.emptyDayItemPool:GetOne()
    item.transform:SetParent(self.ui.groupItem_Day.transform)
    item.transform:SetAsLastSibling()
  end
  self.vaildDayItemList = {}
  self.vaildDayItemPool:HideAll()
  startTimetable.hour = 0
  startTimetable.min = 0
  startTimetable.sec = 0
  local startDayTs = TimeUtil:DateToTimestamp(startTimetable)
  local dayNum = 0
  local endTimeTable = TimeUtil:TimestampToDate(math.floor(TimeUtil:TimpApplyLogicOffset(endTs)))
  endTimeTable.hour = 0
  endTimeTable.min = 0
  endTimeTable.sec = 0
  local endDayTs = TimeUtil:DateToTimestamp(endTimeTable)
  for ts = startDayTs, endDayTs, 86400 do
    dayNum = dayNum + 1
    local item = self.vaildDayItemPool:GetOne()
    item.transform:SetParent(self.ui.groupItem_Day.transform)
    item.transform:SetAsLastSibling()
    local dateTb = TimeUtil:TimestampToDate(ts)
    item:InitVaildItem(dateTb.day)
    local signFlag = 3
    if curLeftDay >= dayNum then
      signFlag = 2
    end
    if allSignDay[dayNum - 1] == true then
      signFlag = 1
    end
    item:ChangeSignFlag(signFlag)
    table.insert(self.vaildDayItemList, item)
  end
  self._totalDayNum = dayNum
end

function UINSignInMininGameBeforeNode:RefreshNode()
  local actId = self.siginInMiniCtrl:GetActId()
  local curLeftDay = self.siginInMiniCtrl:GetLeftDayWithOpenTime(PlayerDataCenter.timestamp)
  if curLeftDay < 1 then
    self.ui.tex_Date.text = LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[13].content)
  else
    self.ui.tex_Date.text = curLeftDay .. LanguageUtil.GetLocaleText(ConfigData.sign_minigame_text[14].content)
  end
  local allSignDay = self.siginInMiniCtrl:GetAllSignInDay()
  local hasSignDayCount = self.siginInMiniCtrl:GetHasSignDayCount()
  local totalSignCount = self.siginInMiniCtrl:GetTotalSignDay(actId)
  local isSignToDay = not self.siginInMiniCtrl:IsCanSignToDay()
  self.ui.tex_SigninTimes.text = tostring(hasSignDayCount) .. "/" .. tostring(totalSignCount)
  self.ui.obj_SignedBg:SetActive(isSignToDay)
  for i = 1, self._totalDayNum do
    local item = self.vaildDayItemList[i]
    local signFlag = 3
    if curLeftDay >= i then
      signFlag = 2
    end
    if allSignDay[i - 1] == true then
      signFlag = 1
    end
    item:ChangeSignFlag(signFlag)
  end
end

function UINSignInMininGameBeforeNode:OnClickBtnJump()
  self.ui.obj_emojiWindow:SetActive(true)
  self.emojiId = 0
  local actId = self.siginInMiniCtrl:GetActId()
  self.totalEmojiCount = #ConfigData.sign_minigame_emoji[actId]
  self.ui.btn_stop.gameObject:SetActive(true)
  self.ui.btn_bg.enabled = false
  self.jumpTimer = TimerManager:StartTimer(1, BindCallback(self, self.ChangeEmoji), nil, false, true)
  self._changeEmojiSound = AudioManager:PlayAudioById(1252, function(back)
    self._changeEmojiSound = nil
  end)
end

function UINSignInMininGameBeforeNode:ChangeEmoji()
  self.emojiId = self.emojiId + 1
  if self.emojiId > self.totalEmojiCount then
    self.emojiId = self.emojiId - self.totalEmojiCount
  end
  local actId = self.siginInMiniCtrl:GetActId()
  local emojiSprite = ConfigData.sign_minigame_emoji[actId][self.emojiId].name
  local atlasName = self.siginInMiniCtrl:GetActSignInMiniGameAtlasName()
  self.ui.img_emoji.sprite = AtlasUtil.GetSpriteFromAtlas(atlasName, emojiSprite, self.resloader)
end

function UINSignInMininGameBeforeNode:OnClickBtnStop()
  if self.jumpTimer ~= nil then
    TimerManager:StopTimer(self.jumpTimer)
    self.jumpTimer = nil
  end
  if self._changeEmojiSound ~= nil then
    AudioManager:StopAudioByBack(self._changeEmojiSound)
  end
  AudioManager:PlayAudioById(1253)
  self.ui.btn_stop.gameObject:SetActive(false)
  self.siginInMiniCtrl:CS_ACTIVITY_SignMiniGame_Sign(self.emojiId, function()
    self.ui.btn_bg.enabled = true
  end)
end

function UINSignInMininGameBeforeNode:OnClickBtnBg()
  self.ui.obj_emojiWindow:SetActive(false)
  self.ui.obj_infoWindow:SetActive(false)
  self.storeRoomRoot:OnEmojiWindowClose()
end

function UINSignInMininGameBeforeNode:OnShow()
  base.OnShow(self)
end

function UINSignInMininGameBeforeNode:OnHide()
  base.OnHide()
end

function UINSignInMininGameBeforeNode:OnDelete()
  base.OnDelete(self)
  self.vaildDayItemPool:DeleteAll()
  self.emptyDayItemPool:DeleteAll()
  self.awardItemPool:DeleteAll()
  if self.jumpTimer ~= nil then
    TimerManager:StopTimer(self.jumpTimer)
    self.jumpTimer = nil
  end
  if self._changeEmojiSound ~= nil then
    AudioManager:StopAudioByBack(self._changeEmojiSound)
  end
  TimerManager:StopTimer(self._infoWindowAniTimer)
end

return UINSignInMininGameBeforeNode
