local UINoticeMessagePush = class("UINoticeMessagePush", UIBaseWindow)
local base = UIBaseWindow
local UINNoticeSide = require("Game.Notice.UI.UINNoticeSide")
local UINDormFightInvitedSideItem = require("Game.Notice.UI.UINDormFightInvitedSideItem")
local cs_ResLoader = CS.ResLoader

function UINoticeMessagePush:OnInit()
  self.__permanent = true
  self.isShowingNoticeDic = {}
  self.noticeQueueDic = {}
  self.TimerDic = {}
  self.ui.obj_cup:SetActive(false)
  self.ui.obj_tips:SetActive(false)
  self.ui.obj_side:SetActive(false)
  self.ui.obj_Invited_side:SetActive(false)
  self.ui.obj_MilestoneTip:SetActive(false)
  self.sideItemPool = UIItemPool.New(UINNoticeSide, self.ui.obj_side)
  self.dormFightInvitedItemPool = UIItemPool.New(UINDormFightInvitedSideItem, self.ui.obj_Invited_side)
  self.originalCupImg = self.ui.img_cupIcon
  self.resloader = cs_ResLoader.Create()
end

function UINoticeMessagePush:AddNotice(noticeData, isPausing)
  if self.noticeQueueDic[noticeData.noticeShowType] == nil then
    self.noticeQueueDic[noticeData.noticeShowType] = {}
  end
  table.insert(self.noticeQueueDic[noticeData.noticeShowType], noticeData)
  if not isPausing then
    if noticeData.noticeShowType == NoticeManager.eNoticeShowType.left or noticeData.noticeShowType == NoticeManager.eNoticeShowType.dormFightLeft then
      self:__ShowNotice(noticeData)
    elseif not self.isShowingNoticeDic[noticeData.noticeShowType] then
      self:__ShowNotice(noticeData)
    end
  end
end

function UINoticeMessagePush:__TryPickFirstNoticeData(noticeShowType)
  if self.noticeQueueDic[noticeShowType] == nil or #self.noticeQueueDic[noticeShowType] == 0 then
    self:ForceCleanAllNotice(noticeShowType)
    return nil
  else
    return self.noticeQueueDic[noticeShowType][1]
  end
end

function UINoticeMessagePush:ForceCleanAllNotice(noticeShowType)
  if noticeShowType == NoticeManager.eNoticeShowType.left then
    self.sideItemPool:HideAll()
  elseif noticeShowType == NoticeManager.eNoticeShowType.down then
    self.ui.obj_cup:SetActive(false)
  elseif noticeShowType == NoticeManager.eNoticeShowType.mid then
    self.ui.obj_tips:SetActive(false)
  elseif noticeShowType == NoticeManager.eNoticeShowType.dormFightLeft then
    self.dormFightInvitedItemPool:HideAll()
  elseif noticeShowType == NoticeManager.eNoticeShowType.milestone then
    self.ui.obj_MilestoneTip:SetActive(false)
  end
end

local NoticeFunc
NoticeFunc = {
  [NoticeManager.eNoticeShowType.defualt] = function(self, noticeData, isShow, hideCallback)
  end,
  [NoticeManager.eNoticeShowType.down] = function(self, noticeData, isShow, hideCallback)
    if isShow then
      self.ui.obj_cup:SetActive(true)
      self.ui.tAnima_cup:DORestart()
      self.ui.tex_Title_cup.text = noticeData:GetNoticeTitle()
      self.ui.tex_Title_cup:StartScrambleTypeWriter()
      self.ui.tex_Intro_cup.text = noticeData:GetNoticeStr()
      self.ui.tex_Intro_cup:StartScrambleTypeWriter()
      AudioManager:PlayAudioById(1124)
      if not string.IsNullOrEmpty(noticeData:GetIcon()) then
        self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
          if spriteAtlas == nil then
            return
          end
          self.ui.img_cupIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, noticeData:GetIcon())
        end)
      end
    else
      self.ui.tAnima_cup.onRewind:AddListener(function()
        self.ui.obj_cup:SetActive(false)
        if hideCallback ~= nil then
          hideCallback()
        end
        self.ui.img_cupIcon = self.originalCupImg
        self.ui.tAnima_cup.onRewind:RemoveAllListeners()
      end)
      self.ui.tAnima_cup:DOPlayBackwards()
    end
  end,
  [NoticeManager.eNoticeShowType.milestone] = function(self, noticeData, isShow, hideCallback)
    if isShow then
      self.ui.obj_MilestoneTip:SetActive(true)
      self.ui.tex_MilestoneDes.text = noticeData:GetNoticeStr()
      self.ui.dt_MilestoneTip:DORestart()
    else
      self.ui.dt_MilestoneTip.onRewind:AddListener(function()
        self.ui.obj_MilestoneTip:SetActive(false)
        if hideCallback ~= nil then
          hideCallback()
        end
        self.ui.dt_MilestoneTip.onRewind:RemoveAllListeners()
      end)
      self.ui.dt_MilestoneTip:DOPlayBackwards()
    end
  end,
  [NoticeManager.eNoticeShowType.mid] = function(self, noticeData, isShow, hideCallback)
    if isShow then
      self.ui.obj_tips:SetActive(true)
      self.ui.tAnima_tips:DORestart()
      self.ui.tAnima_tipsFade:DORestart()
      self.ui.tex_Title_tip.text = noticeData:GetNoticeTitle()
      self.ui.tex_Title_tip:StartScrambleTypeWriter()
      self.ui.tex_Intro_tip.text = noticeData:GetNoticeStr()
      self.ui.tex_Intro_tip:StartScrambleTypeWriter()
      AudioManager:PlayAudioById(1124)
    else
      self.ui.tAnima_tips.onRewind:AddListener(function()
        self.ui.obj_tips:SetActive(false)
        if hideCallback ~= nil then
          hideCallback()
        end
        self.ui.tAnima_tips.onRewind:RemoveAllListeners()
      end)
      self.ui.tAnima_tips:DOPlayBackwards()
      self.ui.tAnima_tipsFade:DOPlayBackwards()
    end
  end,
  [NoticeManager.eNoticeShowType.left] = function(self, noticeData, isShow, hideCallback)
    if isShow then
      local item = self.sideItemPool:GetOne()
      item:SideShowNotice(noticeData, self.resloader)
      if #self.sideItemPool.listItem == 1 then
        AudioManager:PlayAudioById(1124)
      end
    else
      local firstitem = self.sideItemPool.listItem[1]
      local hideItemNum = 0
      for index, item in ipairs(self.sideItemPool.listItem) do
        if math.abs(item.noticeData.timeStampOfShow - firstitem.noticeData.timeStampOfShow) < 0.1 then
          if item ~= nil and not item.isHiding then
            item.isHiding = true
            item:HideSideNotice(function()
              if IsNull(item.gameObject) then
                return
              end
              self.sideItemPool:HideOne(item)
              item.isHiding = false
              table.remove(self.noticeQueueDic[NoticeManager.eNoticeShowType.left], 1)
            end)
          end
          hideItemNum = hideItemNum + 1
        end
      end
    end
  end,
  [NoticeManager.eNoticeShowType.dormFightLeft] = function(self, noticeData, isShow, hideCallback)
    if isShow then
      local item = self.dormFightInvitedItemPool:GetOne()
      item:SideShowNotice(noticeData, self.resloader)
      if #self.dormFightInvitedItemPool.listItem == 1 then
        AudioManager:PlayAudioById(1124)
      end
    else
      local firstitem = self.dormFightInvitedItemPool.listItem[1]
      local hideItemNum = 0
      for index, item in ipairs(self.dormFightInvitedItemPool.listItem) do
        if math.abs(item.noticeData.timeStampOfShow - firstitem.noticeData.timeStampOfShow) < 0.1 then
          if item ~= nil and not item.isHiding then
            item.isHiding = true
            item:HideSideNotice(function()
              if IsNull(item.gameObject) then
                return
              end
              self.dormFightInvitedItemPool:HideOne(item)
              item.isHiding = false
              table.remove(self.noticeQueueDic[NoticeManager.eNoticeShowType.dormFightLeft], 1)
            end)
          end
          hideItemNum = hideItemNum + 1
        end
      end
    end
  end
}

function UINoticeMessagePush:__ShowNotice(noticeData, durationTime)
  self.isShowingNoticeDic[noticeData.noticeShowType] = true
  NoticeFunc[noticeData.noticeShowType](self, noticeData, true)
  noticeData.timeStampOfShow = PlayerDataCenter.timestamp
  if noticeData.noticeShowType == NoticeManager.eNoticeShowType.left or noticeData.noticeShowType == NoticeManager.eNoticeShowType.dormFightLeft then
    local uiPool = noticeData.noticeShowType == NoticeManager.eNoticeShowType.left and self.sideItemPool or self.dormFightInvitedItemPool
    if self.TimerDic[noticeData.noticeShowType] == nil then
      do
        local duration = noticeData.noticeShowType == NoticeManager.eNoticeShowType.dormFightLeft and self.ui.dormFightNotice_duration or self.ui.side_duration
        self.TimerDic[noticeData.noticeShowType] = TimerManager:StartTimer(duration, function()
          self:__HideNotice(nil, noticeData.noticeShowType)
          if #uiPool.listItem <= 0 then
            TimerManager:StopTimer(self.TimerDic[noticeData.noticeShowType])
            self.TimerDic[noticeData.noticeShowType] = nil
            self.isShowingNoticeDic[noticeData.noticeShowType] = false
            uiPool:DeleteAll()
          end
        end, self, false, false, true)
      end
    end
  else
    self.TimerDic[noticeData.noticeShowType] = TimerManager:StartTimer(self.ui.other_duration, function()
      self.TimerDic[noticeData.noticeShowType] = nil
      self:__HideNotice(noticeData)
    end, self, true, false, true)
  end
end

function UINoticeMessagePush:__HideNotice(noticeData, eNoticeShowType)
  if eNoticeShowType == NoticeManager.eNoticeShowType.left or eNoticeShowType == NoticeManager.eNoticeShowType.dormFightLeft then
    NoticeFunc[eNoticeShowType](self, nil, false)
  else
    table.remove(self.noticeQueueDic[noticeData.noticeShowType], 1)
    NoticeFunc[noticeData.noticeShowType](self, nil, false, function()
      local nextNoticeData = self:__TryPickFirstNoticeData(noticeData.noticeShowType)
      if nextNoticeData ~= nil then
        self:__ShowNotice(nextNoticeData)
      else
        self.isShowingNoticeDic[noticeData.noticeShowType] = false
      end
    end)
  end
end

function UINoticeMessagePush:PuaseShowNotice()
  for noticeShowType, value in pairs(self.TimerDic) do
    TimerManager:StopTimer(value)
    self.TimerDic[noticeShowType] = nil
    if noticeShowType ~= NoticeManager.eNoticeShowType.left and noticeShowType ~= NoticeManager.eNoticeShowType.dormFightLeft then
      local noticeData = self.noticeQueueDic[noticeShowType][1]
      if noticeData.timeStampOfShow ~= nil and PlayerDataCenter.timestamp - noticeData.timeStampOfShow > self.ui.other_duration / 4 then
        table.remove(self.noticeQueueDic[noticeData.noticeShowType], 1)
      end
    end
  end
  self.sideItemPool:DeleteAll()
  self.dormFightInvitedItemPool:DeleteAll()
  self.ui.obj_cup:SetActive(false)
  self.ui.obj_tips:SetActive(false)
  self.ui.obj_MilestoneTip:SetActive(false)
  self.ui.tAnima_cup.onRewind:RemoveAllListeners()
  self.ui.tAnima_tips.onRewind:RemoveAllListeners()
  self.ui.dt_MilestoneTip.onRewind:RemoveAllListeners()
end

function UINoticeMessagePush:ContinueShowNotice()
  for noticeShowType, noticeQueue in pairs(self.noticeQueueDic) do
    if noticeShowType == NoticeManager.eNoticeShowType.left or noticeShowType == NoticeManager.eNoticeShowType.dormFightLeft then
      for index, noticeData in ipairs(noticeQueue) do
        self:__ShowNotice(noticeData)
      end
    elseif noticeQueue ~= nil and 0 < #noticeQueue then
      self:__ShowNotice(noticeQueue[1])
    end
  end
end

function UINoticeMessagePush:OnDelete()
  self.sideItemPool:DeleteAll()
  self.dormFightInvitedItemPool:DeleteAll()
  self.ui.obj_cup:SetActive(false)
  self.ui.obj_tips:SetActive(false)
  self.ui.obj_side:SetActive(false)
  for key, value in pairs(self.TimerDic) do
    TimerManager:StopTimer(value)
    self.TimerDic[key] = nil
  end
  self.TimerDic = {}
  base.OnDelete(self)
end

return UINoticeMessagePush
