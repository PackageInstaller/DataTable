local New_MailController = class("New_MailController", ControllerBase)
local HomeEnum = require("Game.Home.HomeEnum")
local cs_MessageCommon = CS.MessageCommon
local MailData = require("Game.Mail.MailData")
local MailEnum = require("Game.Mail.MailEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function New_MailController:OnInit()
  self.hasNotify = false
  self.haveNotGetRewardMail = false
  self.haveCouldDeleteMail = false
  self.isUIOpen = false
  self._m_InitDataCallback = BindCallback(self, self.m_InitDataCallback)
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Mail)
  self.mailDataDic = {}
end

function New_MailController:OnMailUIShow(callback)
  if self.hasNotify then
    self:ReqMailFetch(true, function()
      self:DeletAllOutDataMail()
      if callback ~= nil then
        callback()
      end
    end)
  else
    self:DeletAllOutDataMail()
    if callback ~= nil then
      callback()
    end
  end
  self.isUIOpen = true
  NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.Mail)
end

function New_MailController:OnMailUIHide()
  self.isUIOpen = false
end

function New_MailController:GetInitData()
  self.network:CS_MAIL_Detail_Batch(self._m_InitDataCallback)
end

function New_MailController:m_InitDataCallback(args)
  if args ~= nil and args.Count > 0 then
    local mailDetails = args[0]
    self:InitOrUpdateData(mailDetails, true)
  else
    error("InitData args error")
  end
end

function New_MailController:RecvUpdateDiff(data, delete)
  if delete ~= nil and table.count(delete) > 0 then
    self:DeleteData(delete)
  end
  if data ~= nil and table.count(data) > 0 then
    self:InitOrUpdateData(data)
  end
end

function New_MailController:ReqMailRead(uid, callback)
  local mailDetail = self.mailDataDic[uid]
  if mailDetail.status == MailEnum.eMailDetailType.None and not mailDetail.isReading then
    mailDetail.isReading = true
    self.network:CS_MAIL_Read(uid, callback)
  end
end

function New_MailController:ReqTreasuredMail(uid)
  local mailDetail = self.mailDataDic[uid]
  
  local function treasureFunc()
    mailDetail.isTreasure = true
    self.network:CS_MAIL_Favorite(uid, true, function()
      self:m_RefreshDeleteAndNewState()
      MsgCenter:Broadcast(eMsgEventId.OnMailDiff, {mailDetail})
    end)
  end
  
  local treasureCount = self:GetMailTreasureCount()
  if treasureCount >= ConfigData.game_config.MailTreasureCount then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(336))
    return
  end
  treasureFunc()
end

function New_MailController:ReqCancelTreasuredMail(uid)
  local mailDetail = self.mailDataDic[uid]
  
  local function cancelFunc()
    mailDetail.isTreasure = false
    self.network:CS_MAIL_Favorite(uid, false, function()
      self:m_RefreshDeleteAndNewState()
      MsgCenter:Broadcast(eMsgEventId.OnMailDiff, {mailDetail})
    end)
  end
  
  if mailDetail.expiredTm < PlayerDataCenter.timestamp then
    local msgWin = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    msgWin:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(337), function()
      cancelFunc()
    end)
    return
  end
  cancelFunc()
end

function New_MailController:ReqReceiveAttachment(uid)
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  local _, rewardDic, _, receivedDic = self.mailDataDic[uid]:IsHaveAtt()
  local itemTransDic = {}
  for id, rewardNum in pairs(rewardDic) do
    if not receivedDic[id] then
      local itemCfg = ConfigData.item[id]
      if itemCfg.overflow_type == eItemTransType.actMoneyX then
        local num = PlayerDataCenter:GetItemOverflowNum(id, rewardNum)
        if num ~= 0 then
          itemTransDic[id] = num
        end
      end
    end
  end
  self.network:CS_MAIL_ReceiveAttachment(uid, function(args)
    local realRewardDic = {}
    if args ~= nil and args.Count > 0 then
      local update = args[0]
      if update == nil then
        return
      end
      local data = update[uid]
      if data ~= nil then
        for key, value in pairs(data.att.data) do
          if table.contain(data.att.received, key) then
            realRewardDic[key] = true
          end
        end
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local rewardIds = {}
      local rewardNums = {}
      for id, num in pairs(rewardDic) do
        if not receivedDic[id] and realRewardDic[id] then
          table.insert(rewardIds, id)
          table.insert(rewardNums, num)
        end
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
      CRData:SetCRItemTransDic(itemTransDic)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function New_MailController:ReqDeleteOneMail(uid)
  if self.isDeleting then
    if self.mailDataDic[uid] ~= nil then
      if self.waitDeletDic == nil then
        self.waitDeletDic = {}
      end
      self.waitDeletDic[uid] = true
    end
    return
  end
  self.isDeleting = true
  self.network:CS_MAIL_Delete(uid, function()
    self.isDeleting = false
    if self.waitDeletDic ~= nil and table.count(self.waitDeletDic) > 0 then
      for uid, _ in pairs(self.waitDeletDic) do
        self.waitDeletDic[uid] = nil
        self:ReqDeleteOneMail(uid)
        break
      end
    else
      self.waitDeletDic = nil
    end
  end)
end

function New_MailController:_GenAllMailRewardOverflowDic()
  local itemTransDic = {}
  local onePickReceivedDic = {}
  for i, v in pairs(self.mailDataDic) do
    local tempItemTransDic = {}
    local haveReward, rewardDic, isPicked, receivedDic = v:IsHaveAtt()
    local isOverflow = false
    if haveReward and rewardDic and not isPicked then
      for id, rewardNum in pairs(rewardDic) do
        if receivedDic[id] then
          onePickReceivedDic[id] = true
        else
          local itemCfg = ConfigData.item[id]
          if itemCfg then
            if itemCfg.type == eItemType.Arithmetic and #PlayerDataCenter.allAthData:GetAllAthList() + rewardNum > ConfigData.game_config.athMaxNum then
              isOverflow = true
              break
            end
            if itemCfg.overflow_type == eItemTransType.actMoneyX then
              local num = PlayerDataCenter:GetItemOverflowNum(id, rewardNum)
              if num ~= 0 then
                tempItemTransDic[id] = num
              end
            else
              local nowNum = PlayerDataCenter:GetItemCount(itemCfg.id)
              if nowNum + rewardNum > itemCfg.holdlimit then
                isOverflow = true
                break
              end
            end
          end
        end
      end
      if not isOverflow then
        for id, overflowNum in pairs(tempItemTransDic) do
          if itemTransDic[id] then
            itemTransDic[id] = itemTransDic[id] + overflowNum
          else
            itemTransDic[id] = overflowNum
          end
        end
      end
    end
  end
  self.itemTransDic = itemTransDic
  self.onePickReceivedDic = onePickReceivedDic
end

function New_MailController:ReqOneClickPickUp()
  if self.haveNotGetRewardMail then
    self:_GenAllMailRewardOverflowDic()
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self.network:CS_MAIL_OneClickPickUp(function(args)
      if args ~= nil and args.Count > 0 then
        local update = args[0]
        if update == nil then
          return
        end
        local rewardDic = {}
        for uid, data in pairs(update) do
          if data.att ~= nil then
            for key, value in pairs(data.att.data) do
              if table.contain(data.att.received, key) and not self.onePickReceivedDic[key] then
                if rewardDic[key] == nil then
                  rewardDic[key] = value
                else
                  rewardDic[key] = value + rewardDic[key]
                end
              end
            end
          end
        end
        local rewardIds = {}
        local rewardNums = {}
        for id, num in pairs(rewardDic) do
          table.insert(rewardIds, id)
          table.insert(rewardNums, num)
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
          CRData:SetCRItemTransDic(self.itemTransDic)
          window:AddAndTryShowReward(CRData)
        end)
      else
        CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      end
    end)
  end
end

function New_MailController:ReqOneClickDelete()
  if self.haveCouldDeleteMail then
    self.network:CS_MAIL_OneKeyDelete()
  end
end

function New_MailController:HasMailNotify()
  self.hasNotify = true
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.mail_Notice))
  local mailNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  mailNode:SetRedDotCount(1)
  local mailWin = UIManager:GetWindow(UIWindowTypeID.Mail)
  if mailWin ~= nil then
    self:ReqMailFetch(false)
  end
end

function New_MailController:ReqMailFetch(waitRev, callback)
  self.network:CS_MAIL_Fetch(waitRev, callback)
end

function New_MailController:RecvMailFetch()
  self.hasNotify = false
  self:RefrshMailRedDot()
end

function New_MailController:InitOrUpdateData(mailDetails, isInit)
  local hasDiff = false
  local hasNew = false
  local needNoticeNew = false
  local diffDatas = {}
  for _, mailDetail in pairs(mailDetails) do
    if self.mailDataDic[mailDetail.uid] ~= nil then
      self.mailDataDic[mailDetail.uid]:Update(mailDetail)
      hasDiff = true
      table.insert(diffDatas, self.mailDataDic[mailDetail.uid])
    else
      local mailData = MailData.CreateMailData(mailDetail)
      self.mailDataDic[mailDetail.uid] = mailData
      hasNew = true
      if not mailData:IsSignInRewardMail() then
        needNoticeNew = true
      end
    end
  end
  self:m_RefreshDeleteAndNewState()
  if hasDiff or hasNew then
    MsgCenter:Broadcast(eMsgEventId.OnMailDiff, diffDatas, hasNew)
  end
  self:StartAutoDeleteTimer()
  self:RefrshMailRedDot()
  if isInit then
    local latestTime
    for _, mailData in pairs(self.mailDataDic) do
      if mailData:GetState() == MailEnum.eMailDetailType.None and not mailData:IsSignInRewardMail() then
        local time = mailData:GetTime(true)
        if latestTime == nil or latestTime < time then
          latestTime = time
        end
      end
    end
    if latestTime ~= nil then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.Mail, {
        jumpType = JumpManager.eJumpTarget.Mail,
        argList = nil
      }, nil, nil))
    end
  end
  if not isInit and needNoticeNew then
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(latestTime, NoticeManager.eNoticeType.Mail, {
      jumpType = JumpManager.eJumpTarget.Mail,
      argList = nil
    }, nil, nil))
  end
  self.notPickedSinginMailUIDList = nil
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil and not homeController.isRunningAutoShow and homeController.homeState == HomeEnum.eHomeState.Normal and homeController:ValidCouldOpenSinginReward() then
    homeController:AddAutoShowGuide(HomeEnum.eAutoShwoCommand.Singin)
  end
end

function New_MailController:DeleteData(delete)
  for uid, _ in pairs(delete) do
    if self.mailDataDic[uid] ~= nil then
      self.mailDataDic[uid]:Delete()
      self.mailDataDic[uid] = nil
    end
  end
  self:m_RefreshDeleteAndNewState()
  self:RefrshMailRedDot()
  MsgCenter:Broadcast(eMsgEventId.OnMailDelete, delete)
end

function New_MailController:m_RefreshDeleteAndNewState()
  self.haveCouldDeleteMail = false
  self.haveNotGetRewardMail = false
  local haveNeedNoticeMail = false
  for _, mailData in pairs(self.mailDataDic) do
    local isHaveAtt, attDic, isPicked = mailData:IsHaveAtt()
    if isHaveAtt and not isPicked then
      self.haveNotGetRewardMail = true
    elseif isHaveAtt and isPicked and not mailData:GetIsTreasure() then
      self.haveCouldDeleteMail = true
    elseif not isHaveAtt and mailData:GetState() ~= MailEnum.eMailDetailType.None and not mailData:GetIsTreasure() then
      self.haveCouldDeleteMail = true
    end
    if mailData:GetState() == MailEnum.eMailDetailType.None then
      haveNeedNoticeMail = true
    end
    if self.haveCouldDeleteMail and self.haveNotGetRewardMail and haveNeedNoticeMail then
      break
    end
  end
  if not haveNeedNoticeMail then
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.Mail)
  end
end

function New_MailController:SetOnlyShowTreasureMail(bool)
  self.isOnlyShowTreasureMail = bool
end

function New_MailController:GetOnlyShowTreasureMail()
  return self.isOnlyShowTreasureMail
end

function New_MailController:GetMailDataList()
  local list = {}
  for _, data in pairs(self.mailDataDic) do
    if not (not data:GetCouldShow() or self.isOnlyShowTreasureMail) or data:GetCouldShow() and self.isOnlyShowTreasureMail and data:GetIsTreasure() then
      table.insert(list, data)
    end
  end
  table.sort(list, function(a, b)
    if a.status == b.status then
      local aTreasure = a:GetIsTreasure()
      local bTreasure = b:GetIsTreasure()
      if aTreasure ~= bTreasure then
        return aTreasure
      end
      if a:GetTime(true) == b:GetTime(true) then
        return a.uid > b.uid
      else
        return a:GetTime(true) > b:GetTime(true)
      end
    else
      return a.status < b.status
    end
  end)
  return list
end

function New_MailController:GetMailTreasureCount()
  local count = 0
  for _, data in pairs(self.mailDataDic) do
    if data:GetCouldShow() and data:GetIsTreasure() then
      count = count + 1
    end
  end
  return count
end

function New_MailController:GetSignInRewardMailUIDs(isNotFirstGetSignInReward, notRead, onlyMonthCard)
  if self.notPickedSinginMailUIDList ~= nil then
    return self.notPickedSinginMailUIDList
  end
  local notPickedSinginMailUIDList = {}
  for _, mailData in pairs(self.mailDataDic) do
    if mailData:IsSignInRewardMail() and (not onlyMonthCard or mailData:IsSignInMonthCardReward()) then
      if isNotFirstGetSignInReward then
        if mailData:GetState() == MailEnum.eMailDetailType.None then
          local isHaveReward, _, isPicked = mailData:IsHaveAtt()
          if isHaveReward and not isPicked then
            table.insert(notPickedSinginMailUIDList, mailData.uid)
          end
        end
      else
        if not notRead then
          self:ReqMailRead(mailData.uid)
        end
        local isHaveReward, _, isPicked = mailData:IsHaveAtt()
        if isHaveReward and not isPicked then
          table.insert(notPickedSinginMailUIDList, mailData.uid)
        end
      end
    end
  end
  return notPickedSinginMailUIDList
end

function New_MailController:StartAutoDeleteTimer()
  if self.m_outDataTimerId ~= nil then
    TimerManager:StopTimer(self.m_outDataTimerId)
    self.m_outDataTimerId = nil
  end
  if table.count(self.mailDataDic) > 0 then
    local time = self:GetLatestRefreshTm()
    self.m_outDataTimerId = TimerManager:StartTimer(time, BindCallback(self, self.DeletAllOutDataMail, true), nil, true, false, true)
  end
end

function New_MailController:GetLatestRefreshTm()
  local seconds = math.maxinteger
  for _, data in pairs(self.mailDataDic) do
    if data:GetTimeBeforeExpired() ~= 0 or not data.isTreasure then
      seconds = math.min(data:GetTimeBeforeExpired(), seconds)
    end
  end
  return seconds
end

function New_MailController:DeletAllOutDataMail(isFromTimer)
  if isFromTimer == true then
    self.m_outDataTimerId = nil
    self:StartAutoDeleteTimer()
  end
  local delete = {}
  local haveTreasure = false
  for uid, data in pairs(self.mailDataDic) do
    if data:GetTimeBeforeExpired() <= 0 and not data.isTreasure then
      self.mailDataDic[uid]:Delete()
      self.mailDataDic[uid] = nil
      delete[uid] = true
    elseif data:GetTimeBeforeExpired() <= 0 and data.isTreasure then
      haveTreasure = true
    end
  end
  if 0 < table.count(delete) then
    self:RefrshMailRedDot()
    MsgCenter:Broadcast(eMsgEventId.OnMailDelete, delete)
    return
  end
  if haveTreasure then
    self:RefrshMailRedDot()
  end
end

function New_MailController:RefrshMailRedDot()
  local mailNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail) then
    mailNode:SetRedDotCount(0)
    return
  end
  for uid, mailData in pairs(self.mailDataDic) do
    if mailData:GetCouldShow() then
      if mailData:GetState() == MailEnum.eMailDetailType.None then
        mailNode:SetRedDotCount(1)
        return
      elseif mailData:GetState() == MailEnum.eMailDetailType.Read and mailData:IsHaveAtt() and 0 < mailData:GetTimeBeforeExpired() then
        mailNode:SetRedDotCount(1)
        return
      end
    end
  end
  if self.hasNotify then
    mailNode:SetRedDotCount(1)
    return
  end
  mailNode:SetRedDotCount(0)
end

function New_MailController:OnDelete()
  if self.m_outDataTimerId ~= nil then
    TimerManager:StopTimer(self.m_outDataTimerId)
    self.m_outDataTimerId = nil
  end
end

return New_MailController
