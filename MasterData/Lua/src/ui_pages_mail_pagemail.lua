local page = class("pageMail", G_UIPageBase)
local mailTpl = L_GameTpl:getMailTpl()
local mailBonus = L_GameTpl:getMailBonusCTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local mailCountMax = L_GameTpl:getGameConstTpl():getData("MAIL_LIMITS", L_Const.GameTplType.int)
local collectCountMax = L_GameTpl:getGameConstTpl():getData("MAIL_COLLECTION_NUM", L_Const.GameTplType.int)
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _jumpTpl = L_GameTpl:getCommonJumpTpl()
local _gmCustomizedtextListTpl = L_GameTpl:getGmCustomizedtextListTpl()

function page.bind()
  return {
    mailList = {
      moduleName = "pages/Mail/cellMailItem"
    },
    rewardItem = L_Const.ModuleInfo.CellIconBag,
    allMailCount = "",
    allMailCountShadow = "",
    unreadMailCount = "",
    unreadMailCountShadow = "",
    collectMailCount = "",
    collectMailCountShadow = "",
    leftNoMailActive = false,
    rightNoMailActive = false,
    leftInfoActive = true,
    rightInfoActive = true,
    title = "",
    sender = "",
    time = "",
    infoText = "",
    receiveBtn = true,
    isCollectToggleOn = false,
    rewardActive = false,
    linkActive = false,
    linkText = "",
    quetionBtnActive = true,
    choiceActive = false,
    selectedBgAcitve = false,
    collectMaskActive = false
  }
end

function page.methods()
  return {
    onclick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    mailList = {
      mailInfo = function(self, mailGuid)
        if L_MailManager:checkMailEffectValidAndRefresh(mailGuid, function()
          self:setMailCategroy(self.currentCategoryType)
        end) then
          L_MailStore:setCheckedMail(mailGuid)
          self:requestReadMail()
        end
      end
    },
    onclick_allReceiveBtn = function(self)
      local bool = false
      for k, v in pairs(L_MailStore:getAllMailInfo()) do
        local time1, time2 = L_TimeUtil.getLeftDayAndHour(v.effecttm + v.createtm)
        if v.guid ~= 0 and (time1 ~= nil or v.effecttm == 0) and not v.fetch then
          bool = true
          break
        end
      end
      if bool then
        local data = {u64 = 0}
        L_MailStore:req_changeCSProtoFetchMail(data)
      else
        L_GameUtil.showCommonTip({
          txtContent = wordsTpl:getTplById("notice_mail_noMail")
        })
        return
      end
    end,
    onclick_deleteReadBtn = function(self)
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("ui_pageMail_01"),
        txtContent = wordsTpl:getTplById("notice_mail_delAll"),
        txtSubContent = wordsTpl:getTplById("notice_mail_unaccalimed"),
        confirmCallback = function()
          local data = {u64 = 0}
          L_MailStore:req_changeCSProtoDelMail(data)
        end
      })
    end,
    onclick_deleteBtn = function(self)
      local mail = L_MailStore:getMail(self.mailGuid)
      if mail.collect then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mail_collect_delete"))
        return
      end
      if not L_MailManager:checkMailEffectValidAndRefresh(self.mailGuid, function()
        self:setMailCategroy(self.currentCategoryType)
      end) then
        return
      end
      local fetchMail = L_MailStore:getBoolFetchMail(self.mailGuid)
      if not fetchMail then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mail_cannotDel"))
        return
      end
      L_GameUtil.showCommonTip({
        txtTitle = wordsTpl:getTplById("notice_title_hint"),
        txtContent = wordsTpl:getTplById("notice_mail_del"),
        confirmCallback = function()
          local data = {
            u64 = self.mailGuid
          }
          L_MailStore:req_changeCSProtoDelMail(data)
        end
      })
    end,
    onclick_receiveBtn = function(self)
      if not L_MailManager:checkMailEffectValidAndRefresh(self.mailGuid, function()
        self:setMailCategroy(self.currentCategoryType)
      end) then
        return
      end
      L_MailStore:setCheckedMail(self.mailGuid)
      local data = {
        u64 = self.mailGuid
      }
      if self:canFetchMail(self.mailGuid) then
        L_MailStore:req_changeCSProtoFetchMail(data)
      end
    end,
    onclick_allMailToggled = function(self, bToogled)
      if bToogled then
        self:setMailCategroy(L_Const.mailCategory.all)
      end
    end,
    onclick_unreadMailToggled = function(self, bToogled)
      if bToogled then
        self:setMailCategroy(L_Const.mailCategory.unread)
      end
    end,
    onclick_collectMailToggled = function(self, bToogled)
      if bToogled then
        self:setMailCategroy(L_Const.mailCategory.collect)
      end
    end,
    onclick_collecToggled = function(self, bToogled)
      self:dealCollectToggled(bToogled)
    end,
    onClick_link = function(self)
      if not L_MailManager:checkMailEffectValidAndRefresh(L_MailStore:getCheckedMail(), function()
        self:setMailCategroy(self.currentCategoryType)
      end) then
        return
      end
      local mailData = L_MailStore:getMail(L_MailStore:getCheckedMail())
      local mailCfg = mailTpl:getTplById(mailData.template_id)
      if mailCfg then
        local jumpType = mailTpl:getJumpType(mailCfg)
        if jumpType == L_Const.mailJumpType.commonJump then
          local jumpId = mailTpl:getJumpId(mailCfg)
          L_JumpMgr:jumpTo(jumpId, mailData)
          C_AudioManager.Play("Play_SFX_System_UI_General_Frame_Open")
        elseif jumpType == L_Const.mailJumpType.questionLink then
          C_AudioManager.Play("Play_SFX_System_UI_General_Frame_Open")
          L_MailStore:req_questionLinkUrl(mailData.guid, function(url)
            self:showWebView(url)
            local eventData = {
              mail_id = mailTpl:getId(mailCfg),
              mail_guid = mailData.guid,
              mail_title = mailTpl:getTitle(mailCfg),
              link = url,
              custom_data = nil
            }
            L_GameUtil.logEvent(L_Const.logEventName.mail_click, eventData)
          end)
        end
      else
        local args = L_MailStore:getMailExtArgs(mailData, L_Const.mailExtType.url)
        if not table.isEmpty(args) then
          C_AudioManager.Play("Play_SFX_System_UI_General_Frame_Open")
          L_MailStore:req_questionLinkUrl(mailData.guid, function(url)
            printf("show url", url, args.url)
            self:showWebView(url)
            local eventData = {
              mail_id = 0,
              mail_guid = mailData.guid,
              mail_title = args.showStr,
              link = url,
              custom_data = nil
            }
            L_GameUtil.logEvent(L_Const.logEventName.mail_click, eventData)
          end)
        end
      end
    end,
    onClick_coin = function(self)
      if not self.coinFirstPlayed then
        self.bindComponents.coinAnimation:Play("anim_mail_coin_1")
        self.coinFirstPlayed = true
      else
        self.bindComponents.coinAnimation:Play("anim_mail_coin_2")
      end
    end,
    onClick_collectMask = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_collect_limit_tip"))
    end,
    onClick_bgClick = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:dealCollectToggled(bToogled)
  local mailGuid = L_MailStore:getCheckedMail()
  local mail = L_MailStore:getMail(mailGuid)
  if mail.collect == bToogled then
    return
  end
  if not bToogled and mail.effecttm ~= 0 and 0 >= mail.effecttm + mail.createtm - L_TimeUtil.getServerTime() then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("ui_collect_delete_tip"),
      confirmCallback = function()
        L_MailStore:req_changeCSProtoCollectMail({mailGuid = mailGuid}, function()
          self:setMailCategroy(self.currentCategoryType)
        end)
      end
    })
    return
  end
  if bToogled and self.currentMails[L_Const.mailCategory.collect] then
    if not L_MailManager:checkMailEffectValidAndRefresh(L_MailStore:getCheckedMail(), function()
      self:setMailCategroy(self.currentCategoryType)
    end) then
      return
    end
    if self.collectMailNum >= collectCountMax then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_collect_limit_tip"))
      return
    end
  end
  if bToogled then
    self.bindComponents.collectAnimation:Play("anim_mail_star")
  end
  L_MailStore:req_changeCSProtoCollectMail({mailGuid = mailGuid})
end

function page:showWebView(url, callback)
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    local onClose
    if callback then
      function onClose()
        callback()
      end
    end
    CS.Lens.Gameplay.UI.WebView.WebViewManager.OpenCommonWebOH(url, onClose)
    return
  end
  local data = {
    url = url,
    title = L_WordsTpl:getValue("ui_pageMail_02"),
    callback = callback,
    showLoading = true
  }
  L_UI:open("pageCommonWeb", data)
end

function page:requestReadMail(notRefresh)
  local mailGuid = L_MailStore:getCheckedMail()
  local mailData = L_MailStore:getMail(mailGuid)
  local data = {
    mailGuid = mailGuid,
    read = mailData.read
  }
  L_MailStore:req_changeCSProtoReadMail(data, function()
    if not self.isBind then
      return
    end
    if not notRefresh then
      if self.bindComponents.choice.followTarget ~= nil or self.bTweening then
        self.bindComponents.choice.hideGraphicWhenTargetIsNull = false
        self.bindComponents.choice.followTarget = nil
        local trans
        for i = 1, #self.bind.mailList do
          if self.bind.mailList:getValue(i, "guid") == mailGuid then
            trans = self.bind.mailList:getItemCls(i):getTrans()
          end
        end
        if trans ~= nil then
          self:killTween()
          self.bTweening = true
          self.tween = self.bindComponents.choice.transform:DOMove(trans.position, 0.33)
          self.tween:SetEase(Tweening.Ease.OutQuart):OnComplete(function()
            self.bindComponents.choice.hideGraphicWhenTargetIsNull = true
            for i = 1, #self.bind.mailList do
              self.bind.mailList:getItemCls(i):refresh()
            end
            self.bTweening = false
            self:killTween()
          end, self)
        end
      else
        for i = 1, #self.bind.mailList do
          self.bind.mailList:getItemCls(i):refresh()
        end
      end
    end
    local unreadMailNum = #L_MailManager:getMailByCategory(L_Const.mailCategory.unread)
    self.bind.unreadMailCount = tostring(unreadMailNum)
    self.bind.unreadMailCountShadow = tostring(unreadMailNum)
    self.bind.mailList:getItemCls(1):refresh()
    self:mailDetailInfo(mailGuid)
  end)
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.bind.quetionBtnActive = C_IntegrateMgr.SystemUnlockModule:IsSystemShowHelpButton(L_SystemConst.enum.mail)
  if self.currentCategoryType == nil then
    self.currentCategoryType = L_Const.mailCategory.all
  end
  self:setMailCategroy(self.currentCategoryType)
  L_MailStore:listenCallFunc(L_MailStore.event.removedMail, self.removedMail, self)
  L_MailStore:listenCallFunc(L_MailStore.event.receiveMail, self.receiveMail, self)
  L_MailStore:listenCallFunc(L_MailStore.event.collectMail, self.collectMail, self)
end

function page:close()
  L_MailStore:unListenCallFunc(L_MailStore.event.removedMail, self.removedMail, self)
  L_MailStore:unListenCallFunc(L_MailStore.event.receiveMail, self.receiveMail, self)
  L_MailStore:unListenCallFunc(L_MailStore.event.collectMail, self.collectMail, self)
  if self.currentMails and self.currentMails[L_Const.mailCategory.all] then
    for _, mail in pairs(self.currentMails[L_Const.mailCategory.all]) do
      mail.choiceComp = nil
    end
  end
  self:killTween()
end

function page:killTween()
  if self.tween ~= nil then
    self.tween:Kill()
    self.tween = nil
  end
end

function page:setMailCategroy(categoryType)
  self.bind.choiceActive = false
  self.bind.selectedBgAcitve = false
  self:updateMailData()
  if categoryType ~= nil then
    self.currentCategoryType = categoryType
  end
  self.currentMails[self.currentCategoryType] = L_MailManager:getMailByCategory(self.currentCategoryType)
  if self.currentMails[self.currentCategoryType][1] then
    L_MailStore:setCheckedMail(self.currentMails[self.currentCategoryType][1].guid)
  else
    L_MailStore:setCheckedMail(0)
  end
  self:refreshMail()
end

function page:updateMailData()
  self.currentMails = {}
  self.currentMails[L_Const.mailCategory.all] = L_MailManager:getMailByCategory(L_Const.mailCategory.all)
  self.currentMails[L_Const.mailCategory.unread] = L_MailManager:getMailByCategory(L_Const.mailCategory.unread)
  self.currentMails[L_Const.mailCategory.collect] = L_MailManager:getMailByCategory(L_Const.mailCategory.collect)
end

function page:setLeftButtons()
  local mailCount = #self.currentMails[self.currentCategoryType]
  self.bind.leftNoMailActive = mailCount == 0
  self.bind.rightNoMailActive = mailCount == 0
  self.bind.leftInfoActive = mailCount ~= 0
  self.bind.rightInfoActive = mailCount ~= 0
  self:refreshButtonLabels()
end

function page:refreshButtonLabels()
  local currentMails = {}
  currentMails[L_Const.mailCategory.all] = L_MailManager:getMailByCategory(L_Const.mailCategory.all)
  currentMails[L_Const.mailCategory.unread] = L_MailManager:getMailByCategory(L_Const.mailCategory.unread)
  currentMails[L_Const.mailCategory.collect] = L_MailManager:getMailByCategory(L_Const.mailCategory.collect)
  local allMailNum = #currentMails[L_Const.mailCategory.all]
  local unreadMailNum = #currentMails[L_Const.mailCategory.unread]
  local collectNum = #currentMails[L_Const.mailCategory.collect]
  self.bind.allMailCount = allMailNum .. "/" .. mailCountMax
  self.bind.allMailCountShadow = allMailNum .. "/" .. mailCountMax
  self.bind.unreadMailCount = tostring(unreadMailNum)
  self.bind.unreadMailCountShadow = tostring(unreadMailNum)
  self.bind.collectMailCount = collectNum .. "/" .. collectCountMax
  self.bind.collectMailCountShadow = collectNum .. "/" .. collectCountMax
end

function page:refreshMail()
  self:setLeftButtons()
  self.bindComponents.leftPanelAnimation:Play("anim_mail_refresh_left_hide")
  self.bind.mailList:clear()
  local data = self.currentMails[self.currentCategoryType]
  if data then
    for _, mail in pairs(data) do
      mail.choiceComp = self.bindComponents.choice
    end
    self.bind.mailList:insert_array(data)
    if 0 < #data then
      self:requestReadMail(true)
      Timer.once(0.033, function()
        self.bind.choiceActive = true
        self.bind.selectedBgAcitve = true
      end, self, self.gameObject)
    end
    self.bindComponents.leftPanelAnimation:Play("anim_mail_refresh_left")
  end
end

function page:mailDetailInfo(mailGuid, skipAnimation)
  if not skipAnimation then
    self.bindComponents.rightPanelAnimation:Play("anim_mail_refresh_right_hide")
  end
  self.mailGuid = mailGuid
  self.bind.rightPanelActive = true
  local mailData = L_MailStore:getMail(self.mailGuid)
  if not mailData.read then
    local data = {mailGuid = mailGuid}
    L_MailStore:req_changeCSProtoReadMail(data)
  end
  local tempMailTpl = mailTpl:getTplById(mailData.template_id)
  local title, sender, content = self:getMailInfo(tempMailTpl, mailData)
  self.bind.title = title
  self.bind.sender = sender
  self.bind.infoText = content
  self.bind.time = L_TimeUtil.getDisplayTime(mailData.createtm)
  local data, tempBoolFetch = self:getRewardData(mailData)
  self.bind.rewardActive = not table.isEmpty(data)
  local tmp = {}
  for i = 1, #data do
    table.insert(tmp, {
      guid = data[i].reward.guid,
      itemId = data[i].reward.itemid,
      itemNum = data[i].reward.itemnum,
      itemType = data[i].reward.itemtype,
      isReceived = data[i].receive
    })
  end
  self.bind.rewardItem:clear()
  self.bind.rewardItem:insert_array(tmp)
  self.bind.receiveBtn = not tempBoolFetch
  if mailData.collect == nil then
    mailData.collect = false
  end
  self.bind.isCollectToggleOn = mailData.collect
  self:setJumpInfo(tempMailTpl)
  Timer.once(0.033, function()
    if string.isEmpty(content) then
      self.bindComponents.dotListRect.sizeDelta = C_Vector2(self.bindComponents.dotListRect.sizeDelta.x, 0)
    else
      local height = self.bindComponents.infoTextRect.sizeDelta.y
      self.bindComponents.dotListRect.sizeDelta = C_Vector2(self.bindComponents.dotListRect.sizeDelta.x, height + 11)
    end
  end, self, self.gameObject)
  if not skipAnimation then
    self.bindComponents.rightPanelAnimation:Play("anim_mail_refresh_right")
  end
  self.collectMailNum = #L_MailManager:getMailByCategory(L_Const.mailCategory.collect)
  local isShowCollectMask = not mailData.collect and self.collectMailNum >= collectCountMax
  self.bind.collectMaskActive = isShowCollectMask
end

function page:setJumpInfo(mailCfg)
  self.bind.linkActive = false
  if not mailCfg then
    local mailData = L_MailStore:getMail(self.mailGuid)
    printf("show url", mailData.argsDict)
    local args = L_MailStore:getMailExtArgs(mailData, L_Const.mailExtType.url)
    if not table.isEmpty(args) then
      self.bind.linkActive = true
      self.bind.linkText = args.showStr
    end
    return
  end
  local jumpType = mailTpl:getJumpType(mailCfg)
  if jumpType == L_Const.mailJumpType.questionLink then
    self.bind.linkActive = not string.isEmpty(mailTpl:getLink(mailCfg))
    if not string.isEmpty(mailTpl:getLink(mailCfg)) then
      self.bind.linkText = mailTpl:getJumpShow(mailCfg)
    end
  elseif jumpType == L_Const.mailJumpType.commonJump then
    local jumpId = mailTpl:getJumpId(mailCfg)
    if math.isEmpty(jumpId) then
      return
    end
    self.bind.linkActive = true
    self.bind.linkText = mailTpl:getJumpShow(mailCfg)
  end
end

function page:getMailInfo(tempMailTpl, mailData)
  local title, sender, content
  if tempMailTpl and tempMailTpl.type == L_Const.mailType.type1 then
    title = mailBonus:getWordsById(mailTpl:getTitle(tempMailTpl))
    sender = mailBonus:getWordsById(mailTpl:getName(tempMailTpl))
    content = mailBonus:getWordsById(mailTpl:getContent(tempMailTpl))
    if tempMailTpl.id == 20101 or tempMailTpl.id == 20102 or tempMailTpl.id == 20103 then
      if not mailData.args or table.count(mailData.args) < 5 then
        errorf("特殊奇波出现邮件参数异常")
        content = mailBonus:getWordsById(mailTpl:getContent(tempMailTpl))
        return
      end
      local mapId = mailData.args[1].attr_id
      local petCfgId = mailData.args[4].attr_id
      local endTime = mailData.args[3].attr_id
      local areaId = L_GameTpl:getWorldAreaTpl():getCurSceneAreaList(mapId)[1].id
      local areaCfg = _worldAreaTpl:getTplById(areaId)
      local sceneName = _worldAreaTpl:getName(areaCfg)
      local petCfg = _petTpl:getTplById(petCfgId)
      local petName = _petTpl:getName(petCfg)
      local endTime = L_TimeUtil.getDisplayTime(endTime)
      content = mailBonus:getWordsById(mailTpl:getContent(tempMailTpl))
      content = L_Lang:get(content, {
        [0] = sceneName,
        [1] = petName,
        [2] = endTime
      })
      title = string.format(mailData.title, petName)
    elseif tempMailTpl.id == 1 then
      local name = mailData.args[1].str_val
      local time = mailData.args[2].str_val
      content = L_Lang:get(content, {
        [0] = name,
        [1] = time
      })
    elseif tempMailTpl.id == 2 or tempMailTpl.id == 3 then
      local reason = mailData.args[1].str_val
      local funcNameId = mailData.args[2].attr_id
      local gmCustomizedtextListCfg = _gmCustomizedtextListTpl:getTplById(funcNameId)
      local funcName = _gmCustomizedtextListTpl:getFunctionName(gmCustomizedtextListCfg)
      content = L_Lang:get(content, {
        [0] = reason,
        [1] = funcName
      })
    else
      content = mailBonus:getWordsById(mailTpl:getContent(tempMailTpl))
    end
  else
    title = mailData.title
    sender = tostring(mailData.sender_id)
    content = tostring(mailData.content)
    content = string.gsub(content, "\\n", "\n")
  end
  return title, sender, content
end

function page:getRewardData(mailData)
  local data = {}
  local tempBoolFetch = true
  if mailData.reward and mailData.reward.rewards then
    local reward = mailData.reward.rewards
    tempBoolFetch = mailData.fetch
    for i = 1, #reward do
      table.insert(data, {
        receive = tempBoolFetch,
        reward = reward[i]
      })
    end
  end
  return data, tempBoolFetch
end

function page:collectMail(mailGuid)
  self.collectMailNum = #L_MailManager:getMailByCategory(L_Const.mailCategory.collect)
  self.bind.collectMailCount = self.collectMailNum .. "/" .. collectCountMax
  self.bind.collectMailCountShadow = self.collectMailNum .. "/" .. collectCountMax
  for i = 1, #self.bind.mailList do
    self.bind.mailList:getItemCls(i):refresh()
  end
  local mail = L_MailStore:getMail(mailGuid)
  self.bind.isCollectToggleOn = mail.collect
end

function page:removedMail(data)
  self:setMailCategroy(self.currentCategoryType or L_Const.mailCategory.all)
end

function page:receiveMail(data)
  self:refreshButtonLabels()
  for i = 1, #self.bind.mailList do
    self.bind.mailList:getItemCls(i):refresh()
  end
  self:mailDetailInfo(L_MailStore:getCheckedMail(), true)
end

function page:readMail(guid)
  for i = 1, #self.bind.mailList do
    if self.bind.mailList:getValue(i, "guid") == guid then
      local v = L_MailStore:getMail(guid)
      local tempNoRewardUnread = not v.read
      local tempNoRewardRead = v.read
      if self.bind.mailList:getValue(i, "iconAct") then
        self.bind.mailList:change(i, {noRead = false, read = true})
      else
        self.bind.mailList:change(i, {
          noRead = false,
          read = true,
          noRewardUnread = tempNoRewardUnread,
          noRewardRead = tempNoRewardRead
        })
      end
      self:mailDetailInfo(guid)
      return
    end
  end
end

function page:getPropNum(guid)
  local mailData = L_MailStore:getMail(guid)
  if mailData.reward.rewards then
    local reward = mailData.reward.rewards
    for i = 1, #reward do
      local weaponItem = L_ItemManager:parsesoulessenceItem(reward[1].itemid)
      local tempNum = C_BagMgr:getItemNumByItemId(reward[i].itemid) + reward[i].itemnum
      if 100 < tempNum then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_mail_resource_limit"))
        return weaponItem.name
      end
    end
  end
  return true
end

function page:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.mail)
  callback(result)
end

function page:canFetchMail(guid)
  local templateType = L_MailStore:getMailTemplateId(guid)
  if templateType == L_GameConstTpl:getData("KIBO_ALL_BOX_FULL_MAIL", L_Const.GameTplType.int) and not L_PetStore:checkPetBoxCanAdd() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_box_full_can_not_receive"))
    return false
  end
  return true
end

return page
