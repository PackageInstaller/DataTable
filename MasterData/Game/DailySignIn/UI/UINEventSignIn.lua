local UINEventSignIn = class("UINEventSignIn", UIBaseNode)
local base = UIBaseNode
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local UINEventSigninRewardItem = require("Game.DailySignIn.UI.UINEventSigninRewardItem")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_ResLoader = CS.ResLoader

function UINEventSignIn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.selectedItemDateNum = nil
  self.__TimerId = nil
  self.lastPickedNum = 0
  self.resloader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_jump, self, self.OnClickBuyMonthCard)
  self.rewardItemPool = UIItemPool.New(UINEventSigninRewardItem, self.ui.obj_dailyItem)
  self.ui.obj_dailyItem:SetActive(false)
  self.obj_noneBGList = {}
  self.obj_noneBGList[1] = self.ui.obj_noneBG
  self.ui.obj_noneBG:SetActive(false)
  self.ItemWithCountList = {}
  local rewardItem = UINBaseItemWithReceived.New()
  rewardItem:Init(self.ui.obj_rewardItem)
  self.ItemWithCountList[1] = rewardItem
  self.ui.obj_rewardItem:SetActive(false)
  self.__SelectRewardItemCallback = BindCallback(self, self.__SelectRewardItem)
  self.__ShowMonthCardLeftNum = BindCallback(self, self.ShowMonthCardLeftNum)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.__ShowMonthCardLeftNum)
end

function UINEventSignIn:InitEventSignin(activityId, notPickedSinginMailUIDList)
  local notPickedMailUIDsList = {}
  local allWait2PickDayDic = {}
  local allWait2PickUidDic = {}
  if notPickedSinginMailUIDList ~= nil then
    local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
    for _, mailUid in pairs(notPickedSinginMailUIDList) do
      if mailController ~= nil and mailController.mailDataDic[mailUid] ~= nil then
        local mailData = mailController.mailDataDic[mailUid]
        local pickDay = mailData:GetExtraParams()[1]
        if pickDay == nil then
          error("mail UID:" .. tostring(mailUid) .. " not have a pickDayInfo as sigin reward")
        elseif allWait2PickDayDic[pickDay] == nil then
          allWait2PickDayDic[pickDay] = 1
          allWait2PickUidDic[pickDay] = {}
          table.insert(allWait2PickUidDic[pickDay], mailUid)
        else
          allWait2PickDayDic[pickDay] = allWait2PickDayDic[pickDay] + 1
          table.insert(allWait2PickUidDic[pickDay], mailUid)
        end
      end
    end
  end
  for pickDay, list in pairs(allWait2PickUidDic) do
    list.pickDay = pickDay
    table.insert(notPickedMailUIDsList, list)
  end
  table.sort(notPickedMailUIDsList, function(a, b)
    return a.pickDay < b.pickDay
  end)
  for index, value in ipairs(notPickedMailUIDsList) do
    value.pickDay = nil
  end
  self:__InitRewardList(allWait2PickDayDic)
  self:__SetBeforeRefreshTime()
  self:ShowMonthCardLeftNum()
  self:SetSinginMailUIDList(notPickedMailUIDsList)
end

function UINEventSignIn:__InitRewardList(allWait2PickDayDic)
  PlayerDataCenter.dailySignInData:UpdDailySignInBonusId()
  local monthDayNum
  local logicDataTable = TimeUtil:TimestampToDate(math.floor(TimeUtil:TimpApplyLogicOffset(PlayerDataCenter.timestamp)))
  monthDayNum = os.date("!%d", os.time({
    year = logicDataTable.year,
    month = logicDataTable.month + 1,
    day = 0
  }))
  monthDayNum = tonumber(monthDayNum)
  if logicDataTable.month <= 9 then
    self.ui.tex_month:SetIndex(0, "0" .. tostring(logicDataTable.month))
  else
    self.ui.tex_month:SetIndex(0, tostring(logicDataTable.month))
  end
  self.ui.tex_year.text = tostring(logicDataTable.year)
  local pickedDayNum = PlayerDataCenter.dailySignInData:SingInNum()
  self.lastPickedNum = pickedDayNum
  self.rewardItemPool:HideAll()
  for i = 1, monthDayNum do
    local item = self.rewardItemPool:GetOne()
    item:InitSigninRewardItem(i, self.__SelectRewardItemCallback)
    if allWait2PickDayDic == nil then
      item:SetIsReceived(i <= pickedDayNum)
    else
      item:SetIsReceived(i <= pickedDayNum and allWait2PickDayDic[i] == nil)
    end
    if pickedDayNum == i then
      item:SetCurDayMArker()
      self:__SelectRewardItem(item)
    end
  end
  for _, go in pairs(self.obj_noneBGList) do
    go:SetActive(false)
  end
  for i = monthDayNum + 1, 35 do
    local go
    if self.obj_noneBGList[i - monthDayNum] ~= nil then
      go = self.obj_noneBGList[i - monthDayNum]
    else
      go = self.ui.obj_noneBG:Instantiate()
      self.obj_noneBGList[i - monthDayNum] = go
    end
    go:SetActive(true)
    go.transform:SetAsLastSibling()
  end
end

function UINEventSignIn:__SelectRewardItem(SigninRewardItem)
  self.selectedItemDateNum = SigninRewardItem.dateNum
  self.ui.obj_Select.transform:SetParent(SigninRewardItem.transform, false)
  self.ui.obj_Select:SetActive(true)
  self.ui.obj_sign:SetActive(SigninRewardItem.isPicked)
  local itemIds, itemNums = PlayerDataCenter.dailySignInData:GetSingInRewardByDayNum(SigninRewardItem.dateNum)
  local MC_itemIds, MC_itemNums = PlayerDataCenter.dailySignInData:GetMonthCardRewardBm(EPeriodicCardType.MonthCard)
  for _, item in pairs(self.ItemWithCountList) do
    item.gameObject:SetActive(false)
  end
  local count = 0
  if itemIds ~= nil then
    for index, id in ipairs(itemIds) do
      if self.ItemWithCountList[index] == nil then
        local rewardItem = UINBaseItemWithReceived.New()
        local go = self.ui.obj_rewardItem:Instantiate()
        rewardItem:Init(go)
        self.ItemWithCountList[index] = rewardItem
      end
      local itemCfg = ConfigData.item[id]
      local num = itemNums[index]
      self.ItemWithCountList[index].transform:SetParent(self.ui.obj_normalAwardGroup.transform, false)
      self.ItemWithCountList[index]:InitItemWithCount(itemCfg, num)
      self.ItemWithCountList[index].gameObject:SetActive(true)
    end
    count = #itemIds
  end
  if MC_itemIds ~= nil then
    for index, id in ipairs(MC_itemIds) do
      if self.ItemWithCountList[index + count] == nil then
        local rewardItem = UINBaseItemWithReceived.New()
        local go = self.ui.obj_rewardItem:Instantiate()
        rewardItem:Init(go)
        self.ItemWithCountList[index + count] = rewardItem
      end
      local itemCfg = ConfigData.item[id]
      local num = MC_itemNums[index]
      self.ItemWithCountList[index + count].transform:SetParent(self.ui.obj_monthAwardGroup.transform, false)
      self.ItemWithCountList[index + count]:InitItemWithCount(itemCfg, num)
      self.ItemWithCountList[index + count].gameObject:SetActive(true)
    end
  end
end

function UINEventSignIn:__SetBeforeRefreshTime()
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  if counterElem ~= nil then
    self.passTimeStamp = counterElem.nextExpiredTm
    self:__RefreshBeforeRefreshTime()
    TimerManager:StopTimer(self.__TimerId)
    self.__TimerId = TimerManager:StartTimer(1, self.__RefreshBeforeRefreshTime, self, false, false, true)
  end
end

function UINEventSignIn:__RefreshBeforeRefreshTime()
  self.ui.tex_time:SetIndex(0, TimeUtil:TimestampToTime(math.max(0, self.passTimeStamp - PlayerDataCenter.timestamp)))
end

function UINEventSignIn:SetSinginMailUIDList(notPickedMailUIDsList)
  if #notPickedMailUIDsList <= 0 then
    return
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  self:ShowCollectSignInReward(mailController, notPickedMailUIDsList, 1)
end

function UINEventSignIn:ShowCollectSignInReward(mailController, notPickedMailUIDsList, index)
  if mailController == nil then
    error("can't get mailController")
    return
  end
  local mailUids = notPickedMailUIDsList[index]
  for _, mailUid in ipairs(mailUids) do
    if mailController.mailDataDic[mailUid] == nil then
      error("can't get mail data with UID:" .. tostring(mailUid))
      return
    end
  end
  UIUtil.AddOneCover("UINEventSignIn")
  local dayNum = mailController.mailDataDic[mailUids[1]]:GetExtraParams()[1]
  local thisRewardItem = self.rewardItemPool.listItem[dayNum]
  if thisRewardItem == nil then
    self:_CollectSignInreward(mailUids, mailController, notPickedMailUIDsList, index)
  else
    self.waitingShowReward = true
    thisRewardItem:LoadAndPlayFx(self.resloader, nil, nil, function()
      if IsNull(self.transform) then
        return
      end
      self:_CollectSignInreward(mailUids, mailController, notPickedMailUIDsList, index)
      thisRewardItem:SetIsReceived(true)
      self.waitingShowReward = false
      self.ui.obj_sign:SetActive(true)
    end)
  end
end

function UINEventSignIn:_CollectSignInreward(mailUids, mailController, notPickedSinginMailUIDList, index)
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  UIUtil.CloseOneCover("UINEventSignIn")
  self:__GetAllMailRewars(mailUids, 1, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      local rewardIds = {}
      local rewardNums = {}
      
      local function TryShowNext()
        local index = index
        if index < #notPickedSinginMailUIDList then
          index = index + 1
          self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
        end
      end
      
      for _, mailUid in ipairs(mailUids) do
        local mailData = mailController.mailDataDic[mailUid]
        if mailData == nil then
          TryShowNext()
          return
        end
        local _, rewardDic, _ = mailData:IsHaveAtt()
        for id, num in pairs(rewardDic) do
          table.insert(rewardIds, id)
          table.insert(rewardNums, num)
        end
      end
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRTitle(ConfigData:GetTipContent(14024)):SetCRShowOverFunc(TryShowNext)
      for iMonthCardType = 1, EPeriodicCardType.PeriodicCardCount do
        local leftday = PlayerDataCenter.dailySignInData:GetMonthCardLeftCount(iMonthCardType)
        if 0 < leftday and leftday <= PlayerDataCenter.dailySignInData:GetMonthCardData(iMonthCardType):GetMonthCardTipsDay() then
          CRData:SetCRMonthCardTimeTips(iMonthCardType, true)
        end
      end
      if PlayerDataCenter.dailySignInData:IsHaveCard(EPeriodicCardType.StaminaCard) then
        CRData:SetCutCRStaminaReward(true)
      end
      window:AddAndTryShowReward(CRData)
      for _, mailUid in ipairs(mailUids) do
        mailController:ReqDeleteOneMail(mailUid)
      end
    end)
  end)
end

function UINEventSignIn:__GetAllMailRewars(mailUids, index, callback)
  local mailUid = mailUids[index]
  index = index + 1
  NetworkManager:GetNetwork(NetworkTypeID.Mail):CS_MAIL_ReceiveAttachment(mailUid, function()
    if #mailUids >= index then
      self:__GetAllMailRewars(mailUids, index, callback)
    elseif callback ~= nil then
      callback()
    end
  end)
end

function UINEventSignIn:ShowMonthCardLeftNum()
  local leftday = PlayerDataCenter.dailySignInData:GetMonthCardLeftCount(EPeriodicCardType.MonthCard)
  local needTips = false
  if 0 < leftday then
    self.ui.tex_jump:SetIndex(1)
    self.ui.tex_LastTime:SetIndex(0, tostring(leftday))
    if leftday <= PlayerDataCenter.dailySignInData:GetMonthCardData(EPeriodicCardType.MonthCard):GetMonthCardTipsDay() then
      needTips = true
    end
  else
    self.ui.tex_jump:SetIndex(0)
    self.ui.tex_LastTime.text.text = ""
  end
  self.ui.TimeNode:SetActive(needTips)
end

function UINEventSignIn:OnClickBuyMonthCard()
  JumpManager:Jump(JumpManager.eJumpTarget.DynShop, function(callback)
    local signHolderWin = UIManager:GetWindow(UIWindowTypeID.EventSignin)
    if signHolderWin ~= nil then
      signHolderWin:OnClickCloseSign()
    end
    if callback ~= nil then
      callback()
    end
  end, nil, {
    ShopEnum.ShopId.MonthCardId
  })
end

function UINEventSignIn:OnDelete()
  TimerManager:StopTimer(self.__TimerId)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.__ShowMonthCardLeftNum)
  base.OnDelete(self)
end

return UINEventSignIn
