_class("UIMailController", UIController)
UIMailController = UIMailController
local ClientMailType = {Normal = 1, Collection = 2}

function UIMailController:OnShow(uiParams)
  self._currentType = ClientMailType.Normal
  self.InitedMailList = false
  self._mailCountLabel = self:GetUIComponent("UILocalizationText", "MailCount")
  self._unReadMailCountLabel = self:GetUIComponent("UILocalizationText", "UnReadMailCount")
  self._unReadMailCountTitleGo = self:GetGameObject("UnReadMailCountTitle")
  self._mailEmptyIconGo = self:GetGameObject("MailEmptyIcon")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "MailList")
  self._deleteBtn = self:GetGameObject("ButtonDeleteReadedMail")
  self._atlas = self:GetAsset("UIMail.spriteatlas", LoadType.SpriteAtlas)
  self._selectNormal = self:GetUIComponent("Image", "normal")
  self._selectCollection = self:GetUIComponent("Image", "collection")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "BackBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end)
  self._mailModule = GameGlobal.GetModule(MailModule)
  self._currentTimeEvent = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, self.OnOneMinusUpdate, self)
  self:AttachEvent(GameEventType.ModuleMailNotifyNewMail, self._ReceiveNewMail)
  self:AttachEvent(GameEventType.ModuleMailNotifyExpiredMail, self._MailExpired)
  self:_RefreshMailData()
  self:_RefreshMailInfoPanel()
  self:_InitScrollView()
  self:_RefreshMailEmptyIconStatus()
  self:_RefreshSelectMail()
  self:_CachePetIdList()
end

function UIMailController:_RefreshSelectMail()
  if self._currentType == ClientMailType.Normal then
    self._selectNormal.sprite = self._atlas:GetSprite("mail_buchang_btn11")
    self._selectCollection.sprite = self._atlas:GetSprite("mail_buchang_btn10")
  elseif self._currentType == ClientMailType.Collection then
    self._selectNormal.sprite = self._atlas:GetSprite("mail_buchang_btn10")
    self._selectCollection.sprite = self._atlas:GetSprite("mail_buchang_btn11")
  end
end

function UIMailController:_RefreshMailEmptyIconStatus()
  if self._mailCount <= 0 then
    self._mailEmptyIconGo:SetActive(true)
  else
    self._mailEmptyIconGo:SetActive(false)
  end
end

function UIMailController:_CachePetIdList()
  local petModule = GameGlobal.GetModule(PetModule)
  petModule:GetAllPetsSnapshoot()
end

function UIMailController:_ReceiveNewMail()
  GameGlobal.TaskManager():StartTask(self._SendLoadAllMailDatasMsg, self)
end

function UIMailController:_SendLoadAllMailDatasMsg(TT)
  local ack, resMailData = self._mailModule:LoadAllMails(TT)
  if not ack:GetSucc() then
    ToastManager.ShowToast("receive mail data error")
  end
  self:_Refresh()
end

function UIMailController:_MailExpired()
  ToastManager.ShowToast(StringTable.Get("str_mail_has_expire"))
  self:_Refresh()
end

function UIMailController:LoadDataOnEnter(TT, res, uiParams)
  local mailModule = GameGlobal.GetModule(MailModule)
  local ack, resMailData = mailModule:LoadAllMails(TT)
  if ack:GetSucc() then
    res:SetSucc(true)
  else
    res:SetSucc(false)
    ToastManager.ShowToast("receive mail data error")
  end
end

function UIMailController:OnOneMinusUpdate()
  if not self._mailDatas then
    return
  end
  for k, v in pairs(self._mailDatas) do
    v.remainSeconds = v.remainSeconds - 1
    if v.remainSeconds <= 0 then
      v.remainSeconds = 0
    end
  end
  if not self._collectMailDatas then
    return
  end
  for k, v in pairs(self._collectMailDatas) do
    v.remainSeconds = v.remainSeconds - 1
    if v.remainSeconds <= 0 then
      v.remainSeconds = 0
    end
  end
end

function UIMailController:OnHide()
  if self._currentTimeEvent then
    GameGlobal.RealTimer():CancelEvent(self._currentTimeEvent)
    self._currentTimeEvent = nil
  end
  self:DetachEvent(GameEventType.ModuleMailNotifyNewMail, self._ReceiveNewMail)
  self:DetachEvent(GameEventType.ModuleMailNotifyExpiredMail, self._MailExpired)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshMailStatus)
end

function UIMailController:_RecvRefreshMailData(mail_id, isGain, isRead, isExpired)
  if self._currentType == ClientMailType.Normal then
    self._maxMailCount = Cfg.cfg_global.MailLimitNum.IntValue
    local delete_index
    local isNotFind = true
    for i, v in ipairs(self._mailDatas) do
      if v.id == mail_id then
        isNotFind = false
        if isExpired then
          delete_index = i
          break
        end
        if isGain then
          v.isGain = true
          isRead = true
        end
        if isRead then
          v.isRead = true
        end
        break
      end
    end
    if isExpired and delete_index ~= nil then
      table.remove(self._mailDatas, delete_index)
    end
    Log.debug("_________________isNotFind:", isNotFind)
    if isNotFind then
      self:_RefreshMailData()
    end
    self:_CalMailData()
  elseif self._currentType == ClientMailType.Collection then
    self._maxMailCount = Cfg.cfg_global.MailLimitNum.IntValue
    local delete_index
    local isNotFind = true
    for i, v in ipairs(self._collectMailDatas) do
      if v.id == mail_id then
        isNotFind = false
        if isExpired then
          delete_index = i
          break
        end
        if isGain then
          v.isGain = true
          isRead = true
        end
        if isRead then
          v.isRead = true
        end
        break
      end
    end
    if isExpired and delete_index ~= nil then
      table.remove(self._collectMailDatas, delete_index)
    end
    Log.debug("_________________isNotFind:", isNotFind)
    if isNotFind then
      self:_RefreshMailData()
    end
    self:_CalMailData()
  end
end

function UIMailController:_RecvRefreshCollectMailData(mail_id, isGain, isRead, isExpired)
  self._maxMailCount = Cfg.cfg_global.MailLimitNum.IntValue
  local delete_index
  local isNotFind = true
  for i, v in ipairs(self._collectMailDatas) do
    if v.id == mail_id then
      isNotFind = false
      if isExpired then
        delete_index = i
        break
      end
      if isGain then
        v.isGain = true
        isRead = true
      end
      if isRead then
        v.isRead = true
      end
      break
    end
  end
  if isExpired and delete_index ~= nil then
    table.remove(self._collectMailDatas, delete_index)
  end
  Log.debug("_________________isNotFind:", isNotFind)
  if isNotFind then
    self:_RefreshMailData()
  end
  self:_CalMailData()
end

function UIMailController:_RefreshMailData()
  self._maxMailCount = Cfg.cfg_global.MailLimitNum.IntValue
  self._mailDatas = {}
  self._collectMailDatas = {}
  local allMailData, collectMailData = self._mailModule:GetAllMailData()
  local mailCount = table.count(allMailData)
  local collectMailCount = table.count(collectMailData)
  for i = 1, mailCount do
    local mailInfo = allMailData[i]
    table.insert(self._mailDatas, self:_GetMailData(mailInfo))
  end
  for i = 1, collectMailCount do
    local mailInfo = collectMailData[i]
    table.insert(self._collectMailDatas, self:_GetMailData(mailInfo))
  end
  self:_CalMailData()
end

function UIMailController:_GetMailData(mailInfo)
  local mailData = {}
  mailData.id = mailInfo.mail_id
  mailData.isGain = mailInfo.is_gain
  mailData.isRead = mailInfo.is_read
  mailData.mailIcon = mailInfo.sender_icon_id
  if mailInfo.mail_type == MailType.MAIL_TYPE_GM_SYSTEM_NOTICE then
    mailData.title = mailInfo.title_id
    mailData.content = mailInfo.content_id
    mailData.senderName = mailInfo.sender_nick
  elseif mailInfo.mail_type == MailType.MAIL_TYPE_ITEM_CONVER then
    mailData.title = StringTable.Get(mailInfo.title_id)
    mailData.senderName = StringTable.Get(mailInfo.sender_nick)
    local content_id_ext = mailInfo.content_id_ext
    if content_id_ext and content_id_ext.assetid > 0 then
      local tb = Cfg.cfg_item[content_id_ext.assetid]
      if tb then
        local converId = tb.ConverId
        if converId and 0 < converId then
          local converIdCfg = Cfg.cfg_item[converId]
          if converIdCfg then
            mailData.content = StringTable.Get(mailInfo.content_id, StringTable.Get(tb.Name), content_id_ext.count, StringTable.Get(converIdCfg.Name))
          else
            mailData.content = StringTable.Get(mailInfo.content_id, StringTable.Get(tb.Name), content_id_ext.count)
          end
        else
          mailData.content = StringTable.Get(mailInfo.content_id, StringTable.Get(tb.Name), content_id_ext.count)
        end
      else
        mailData.content = StringTable.Get(mailInfo.content_id)
      end
    else
      mailData.content = StringTable.Get(mailInfo.content_id)
    end
  elseif mailInfo.mail_type == MailType.MAIL_TYPE_FIX_ITEM then
    mailData.title = StringTable.Get(mailInfo.title_id)
    local contentParams = mailInfo.content_param
    local paramTab = {}
    for i = 1, #contentParams do
      if i % 3 == 1 then
        local itemid = tonumber(contentParams[i])
        local cfg_item = Cfg.cfg_item[itemid]
        if not cfg_item then
          Log.error("###[mail] cfg_item is nil ! id --> ", itemid)
        end
        local itemName = StringTable.Get(cfg_item.Name) or ""
        table.insert(paramTab, itemName)
      else
        table.insert(paramTab, contentParams[i])
      end
    end
    mailData.content = StringTable.Get(mailInfo.content_id, table.unpack(paramTab))
    mailData.senderName = StringTable.Get(mailInfo.sender_nick)
  elseif mailInfo.mail_type == MailType.MAIL_TYPE_TOWER_COMPENTSATE then
    mailData.title = StringTable.Get(mailInfo.title_id)
    mailData.content = StringTable.Get(mailInfo.content_id, table.unpack(mailInfo.content_param))
    mailData.senderName = StringTable.Get(mailInfo.sender_nick)
  elseif mailInfo.mail_type == MailType.MAIL_TYPE_TEXT_CONVER then
    mailData.title = StringTable.Get(mailInfo.title_id)
    mailData.senderName = StringTable.Get(mailInfo.sender_nick)
    local contentParams = mailInfo.content_param
    if contentParams and #contentParams % 4 == 0 then
      local groupCount = #contentParams / 4
      local from, to = {}, {}
      for i = 1, groupCount do
        local group = i - 1
        local fromID = tonumber(contentParams[group * 4 + 1])
        local fromCount = tonumber(contentParams[group * 4 + 2])
        local toID = tonumber(contentParams[group * 4 + 3])
        local toCount = tonumber(contentParams[group * 4 + 4])
        table.insert(from, {fromID, fromCount})
        table.insert(to, {toID, toCount})
      end
      local params = {}
      local strKey
      if #from == 1 and #to == 1 then
        for _, t in ipairs(from) do
          local id = t[1]
          local count = t[2]
          local name = StringTable.Get(Cfg.cfg_item[id].Name)
          table.insert(params, name)
          table.insert(params, count)
          break
        end
        for _, t in ipairs(to) do
          local id = t[1]
          local count = t[2]
          local name = StringTable.Get(Cfg.cfg_item[id].Name)
          table.insert(params, name)
          table.insert(params, count)
          break
        end
        strKey = mailInfo.content_id .. "_1"
      elseif #from == 2 and #to == 2 then
        for _, t in ipairs(from) do
          local id = t[1]
          local count = t[2]
          local name = StringTable.Get(Cfg.cfg_item[id].Name)
          table.insert(params, name)
          table.insert(params, count)
        end
        for _, t in ipairs(to) do
          local id = t[1]
          local count = t[2]
          local name = StringTable.Get(Cfg.cfg_item[id].Name)
          table.insert(params, name)
          table.insert(params, count)
        end
        strKey = mailInfo.content_id .. "_2"
      else
        Log.exception("赛季邮件参数错误2", echo(contentParams))
      end
      mailData.content = StringTable.Get(strKey, table.unpack(params))
    else
      Log.exception("赛季邮件参数错误1", echo(contentParams))
    end
  elseif mailInfo.mail_type == MailType.MAIL_TYPE_CAM_QUEST then
    mailData.title = StringTable.Get(mailInfo.title_id)
    mailData.senderName = StringTable.Get(mailInfo.sender_nick)
    local cname = ""
    local content_id_ext = mailInfo.content_id_ext
    if content_id_ext and content_id_ext.assetid > 0 then
      local cfg_campaign = Cfg.cfg_campaign[content_id_ext.assetid]
      if cfg_campaign then
        cname = StringTable.Get(cfg_campaign.CampaignName)
      end
    end
    mailData.content = StringTable.Get(mailInfo.content_id, cname)
  else
    mailData.title = StringTable.Get(mailInfo.title_id)
    mailData.content = StringTable.Get(mailInfo.content_id)
    mailData.senderName = StringTable.Get(mailInfo.sender_nick)
  end
  mailData.createTimeSeconds = mailInfo.create_time
  mailData.createTime = TimeToDate(mailInfo.create_time, "day")
  mailData.remainSeconds = mailInfo.remain_time
  mailData.rewards = mailInfo.appendix
  if mailData.rewards ~= nil and 0 < table.count(mailData.rewards) then
    mailData.hasReward = true
  end
  return mailData
end

function UIMailController:_CalMailData()
  self._mailDatas = self:_SortMailData(self._mailDatas)
  self._mailCount = table.count(self._mailDatas)
  self._unReadMailCount = 0
  for i = 1, self._mailCount do
    local mailData = self._mailDatas[i]
    if mailData.isRead == false then
      self._unReadMailCount = self._unReadMailCount + 1
    end
  end
  self._collectMailDatas = self:_SortMailData(self._collectMailDatas)
  self._collectMailCount = table.count(self._collectMailDatas)
  self._unReadCollectMailCount = 0
  for i = 1, self._collectMailCount do
    local mailData = self._collectMailDatas[i]
    if mailData.isRead == false then
      self._unReadCollectMailCount = self._unReadCollectMailCount + 1
    end
  end
end

function UIMailController:_SortMailData(mailDatas)
  table.sort(mailDatas, function(a, b)
    if a.isRead ~= b.isRead then
      return b.isRead
    end
    local isGainA = not a.hasReward or a.isGain
    local isGainB = not b.hasReward or b.isGain
    if isGainA ~= isGainB then
      return isGainB
    end
    if a.createTimeSeconds ~= b.createTimeSeconds then
      return a.createTimeSeconds > b.createTimeSeconds
    end
    return a.id < b.id
  end)
  return mailDatas
end

function UIMailController:_RefreshMailInfoPanel()
  if self._currentType == ClientMailType.Normal then
    self._mailCountLabel.text = "<color=#ffd300>" .. self._mailCount .. "</color>" .. " / " .. self._maxMailCount
    self._unReadMailCountLabel.text = self._unReadMailCount
  elseif self._currentType == ClientMailType.Collection then
    self._mailCountLabel.text = "<color=#ffd300>" .. self._collectMailCount .. "</color>" .. " / " .. self._maxMailCount
    self._unReadMailCountLabel.text = self._unReadCollectMailCount
  end
end

function UIMailController:_SetListItemCount()
  if self._currentType == ClientMailType.Normal then
    self._scrollView:SetListItemCount(self._mailCount, false)
  elseif self._currentType == ClientMailType.Collection then
    self._scrollView:SetListItemCount(self._collectMailCount, false)
  end
end

function UIMailController:_InitScrollView()
  self._scrollView:InitListView(self._mailCount, function(scrollview, index)
    return self:_OnGetMailItem(scrollview, index)
  end, self:GetScrollViewParam())
  self.InitedMailList = true
end

function UIMailController:GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 240
  return param
end

function UIMailController:_OnGetMailItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIMailItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if self._currentType == ClientMailType.Normal then
      if itemIndex > self._mailCount then
        itemWidget:GetGameObject():SetActive(false)
      else
        self:_RefreshMailItemInfo(itemWidget, itemIndex)
      end
    elseif self._currentType == ClientMailType.Collection then
      if itemIndex > self._collectMailCount then
        itemWidget:GetGameObject():SetActive(false)
      else
        self:_RefreshMailItemInfo(itemWidget, itemIndex)
      end
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIMailController:_RefreshMailItemInfo(itemWidget, index)
  if self._currentType == ClientMailType.Normal then
    itemWidget:Refresh(self, self._mailDatas[index])
  elseif self._currentType == ClientMailType.Collection then
    itemWidget:Refresh(self, self._collectMailDatas[index], true)
  end
end

function UIMailController:_Refresh()
  self:_RefreshSelectMail()
  self:_RefreshMailData()
  self:_SetListItemCount()
  self._scrollView:RefreshAllShownItem()
  self:_RefreshMailInfoPanel()
  self:_RefreshMailEmptyIconStatus()
end

function UIMailController:_RecvRefresh(mail_id, isGain, isRead, isExpired)
  self:_RefreshSelectMail()
  self:_RecvRefreshMailData(mail_id, isGain, isRead, isExpired)
  self:_SetListItemCount()
  self._scrollView:RefreshAllShownItem()
  self:_RefreshMailInfoPanel()
  self:_RefreshMailEmptyIconStatus()
end

function UIMailController:NormalOnClick()
  self._deleteBtn:SetActive(true)
  self._currentType = ClientMailType.Normal
  self:_Refresh()
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UIMailController:CollectionOnClick()
  self._deleteBtn:SetActive(false)
  self._currentType = ClientMailType.Collection
  self:_Refresh()
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UIMailController:BtnDeleteAllReadedMailOnClick(go)
  self:Lock("DeleteAllReadedMailLock")
  GameGlobal.TaskManager():StartTask(self._SendDeleteAllReadedMailMsg, self)
end

function UIMailController:_SendDeleteAllReadedMailMsg(TT)
  local res = self._mailModule:RequestBatchDeleteMail(TT)
  self:UnLock("DeleteAllReadedMailLock")
  if res.m_result == MailErrorCode.MAIL_SUCC then
    self:_Refresh()
    return
  end
end

function UIMailController:BtnCollectedRewardOnClick(go)
  self:Lock("CollectedAllRewardsLock")
  GameGlobal.TaskManager():StartTask(self._SendCollectedAllRewardsMsg, self)
end

function UIMailController:_SendCollectedAllRewardsMsg(TT)
  GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(true)
  local res, rewards
  if self._currentType == ClientMailType.Normal then
    res, rewards = self._mailModule:RequestBatchReceiveAppendix(TT)
  elseif self._currentType == ClientMailType.Collection then
    res, rewards = self._mailModule:RequestBatchReceiveAppendix(TT, true)
  end
  GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(false)
  self._autoConversionList = GameGlobal.GetModule(ItemModule):GetConverList()
  self:UnLock("CollectedAllRewardsLock")
  if res.m_result == MailErrorCode.MAIL_SUCC and rewards then
    self:_ShowRewards(rewards)
  end
  self:_Refresh()
end

function UIMailController:_ShowRewards(rewards, callback)
  UiMailHelper.ShowUIGetRewards(rewards, callback, false, self._autoConversionList)
  return
end

function UIMailController:ReadMail(mailData)
  if not mailData then
    return
  end
  self:Lock("ReadMailLock")
  GameGlobal.TaskManager():StartTask(self._SendReadMailMsg, self, mailData)
end

function UIMailController:_SendReadMailMsg(TT, mailData)
  local res = self._mailModule:RequestReadMail(TT, mailData.id)
  self:UnLock("ReadMailLock")
  Log.debug("_______________________res.m_result:", res.m_result)
  if res.m_result == MailErrorCode.MAIL_SUCC or res.m_result == MailErrorCode.MAIL_ALREADY_READ then
    self:ShowDialog("UIMailContentController", mailData, self, self._currentType == ClientMailType.Collection)
    self:_RecvRefresh(mailData.id, false, true, false)
    return
  elseif res.m_result == MailErrorCode.MAIL_ERR_MAIL_EXPIRED then
    ToastManager.ShowToast(StringTable.Get("str_mail_has_expire"))
    self:_RecvRefresh(mailData.id, false, true, true)
    return
  end
  self:_Refresh()
end

function UIMailController:CollectedReward(mailData, callback)
  if not mailData then
    return
  end
  self:Lock("CollectedMailLock")
  GameGlobal.TaskManager():StartTask(self._SendCollectedRewardMsg, self, mailData, callback)
end

function UIMailController:_SendCollectedRewardMsg(TT, mailData, callback)
  GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(true)
  local res, rewards = self._mailModule:RequestReceiveAppendix(TT, mailData.id)
  GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(false)
  self._autoConversionList = GameGlobal.GetModule(ItemModule):GetConverList()
  self:UnLock("CollectedMailLock")
  if res.m_result == MailErrorCode.MAIL_SUCC then
    self:_RecvRefresh(mailData.id, true, true, false)
    mailData.isGain = true
    mailData.isRead = true
    if rewards then
      self:_ShowRewards(rewards, function()
        if callback then
          callback(true)
        end
      end)
    end
    return
  end
  if res.m_result == MailErrorCode.MAIL_ERR_MAIL_EXPIRED then
    if callback then
      callback(false)
    end
    ToastManager.ShowToast(StringTable.Get("str_mail_has_expire"))
    self:_RecvRefresh(mailData.id, true, true, true)
    return
  elseif res.m_result == MailErrorCode.MAIL_ERR_PHY_IS_LIMIT then
    ToastManager.ShowToast(StringTable.Get("str_physicalpower_error_phy_add_full"))
    return
  elseif res.m_result == MailErrorCode.MAIL_ERR_ASSET_DOUBLE_RES_LIMIT then
    ToastManager.ShowToast(StringTable.Get("str_mail_maxcarrier_tip"))
    return
  end
  self:_Refresh()
end

function UIMailController:DeleteMail(mailData, callback)
  if not mailData then
    return
  end
  self:Lock("DeleteMailLock")
  GameGlobal.TaskManager():StartTask(self._SendDeleteMailMsg, self, mailData, callback)
end

function UIMailController:_SendDeleteMailMsg(TT, mailData, callback)
  local res = self._mailModule:RequestDeleteMail(TT, mailData.id)
  self:UnLock("DeleteMailLock")
  if res.m_result == MailErrorCode.MAIL_SUCC then
    self:_Refresh()
    if callback then
      callback(true)
    end
    return
  end
  if res.m_result == MailErrorCode.MAIL_ERR_MAIL_HAVE_APPENDIX then
    ToastManager.ShowToast(StringTable.Get("str_mail_has_reward_ungain"))
  end
  if callback then
    callback(false)
  end
end
