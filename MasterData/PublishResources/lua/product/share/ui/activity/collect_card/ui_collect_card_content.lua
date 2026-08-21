require("ui_side_enter_center_content_base")
_class("UICollectCardContent", UISideEnterCenterContentBase)
UICollectCardContent = UICollectCardContent

function UICollectCardContent:DoInit()
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self._activePool = self:GetUIComponent("UISelectObjectPath", "ActivePool")
  self._activeImg = self:GetUIComponent("Image", "ActiveImg")
  self._timerPool = self:GetUIComponent("UISelectObjectPath", "TimerPool")
  self._bigAwardBtn = self:GetGameObject("BigAwardBtn")
  self._bigAwardGot = self:GetGameObject("BigAwardGot")
  self._descGo2 = self:GetGameObject("DescGo2")
  self._webBtn = self:GetGameObject("WebBtn")
  self._normalGo = self:GetGameObject("ComOpen")
  self._onlyWebGo = self:GetGameObject("ComClose")
  self._redGo = self:GetGameObject("GetCardRed")
  self._desc2 = self:GetUIComponent("UILocalizationText", "DescGo2")
  self._desc3 = self:GetUIComponent("UILocalizationText", "DescGo3")
  self._GetCardBtnTex = self:GetUIComponent("UILocalizationText", "GetCardBtnTex")
  self._WebBtnRed = self:GetGameObject("WebBtnRed")
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaign = self._data
end

function UICollectCardContent:CreateData()
  local localProcess = self._campaign:GetLocalProcess()
  self._cardCom = localProcess:GetComponent(ECampaignCollectCardComponentID.COLLECT_CARD)
  self._questCom = localProcess:GetComponent(ECampaignCollectCardComponentID.QUEST)
  self._cardCfgID = self._cardCom:GetComponentCfgId()
  self._cardComInfo = localProcess:GetComponentInfo(ECampaignCollectCardComponentID.COLLECT_CARD)
  self._questComInfo = localProcess:GetComponentInfo(ECampaignCollectCardComponentID.QUEST)
end

function UICollectCardContent:IsInland()
  if IsInland then
    return true
  end
  return false
end

function UICollectCardContent:BigAwardBtnOnClick(go)
  local cfg = self:BigCfg()
  self:GetAward(cfg.ID)
end

function UICollectCardContent:GetAward(awardid)
  if awardid and self:GetCardAwardStatus(awardid) == QuestStatus.QUEST_Completed then
    self:Lock("UICollectCardContent:GetAward")
    GameGlobal.TaskManager():StartTask(self.OnGetAward, self, awardid)
  end
end

function UICollectCardContent:CheckCardComplete(awardid)
  local cfg = Cfg.cfg_component_collect_card_reward[awardid]
  local cardList = cfg.CardList
  local notHave = false
  for key, value in pairs(cardList) do
    if self._cardComInfo.card[value] then
    else
      notHave = true
      break
    end
  end
  if notHave then
    return false
  end
  return true
end

function UICollectCardContent:OnGetAward(TT, awardid)
  Log.debug("###[UICollectCardContent] OnGetAward awardid:", awardid)
  local res = AsyncRequestRes:New()
  local rewards
  res, rewards = self._cardCom:HandleTakeRewardReq(TT, res, awardid)
  self:UnLock("UICollectCardContent:GetAward")
  if res and res:GetSucc() then
    if rewards and table.count(rewards) > 0 then
      self:ShowDialog("UIGetItemController", rewards)
    end
    self:CreateData()
    self:_Refresh()
  else
    local result = res:GetResult()
    Log.error("###[UICollectCardContent] HandleTakeRewardReq fail! result:", result)
  end
end

function UICollectCardContent:BigAwardInfoBtnOnClick(go)
  self:ShowDialog("UICollectCardAwardView", self:BigCfg())
end

function UICollectCardContent:BigAwardInfoBtn2OnClick(go)
  self:ShowDialog("UICollectCardAwardView", self:BigCfg())
end

function UICollectCardContent:BigCfg()
  local cfgs = Cfg.cfg_component_collect_card_reward({
    ComponentID = self._cardCfgID,
    RewardType = 2
  })
  local cfg = cfgs[1]
  return cfg
end

function UICollectCardContent:SendBtnOnClick(go)
  self:ShowDialog("UICollectCardSend", self._cardCom, self._campaign._id)
end

function UICollectCardContent:WebBtnOnClick(go)
  self:OpenUrl()
end

function UICollectCardContent:WebBtn2OnClick(go)
  self:OpenUrl()
end

function UICollectCardContent:SetOpenUrlRed()
  local red = false
  if not UICollectCardContent.CheckLocalDB_Enter_WebView() then
    local closeTime = self._questComInfo.m_close_time
    local svrTime = self._svrTimeModule:GetServerTime() * 0.001
    if closeTime <= svrTime and self:IsAllCollected() then
      red = true
    end
  end
  self._WebBtnRed:SetActive(red)
end

function UICollectCardContent:IsAllCollected()
  local cards = self._cardComInfo.card
  local cfgs = Cfg.cfg_component_collect_card_reward({
    ComponentID = self._cardCfgID,
    RewardType = 2
  })
  local cfg = cfgs[1]
  local cardList = cfg.CardList
  local isAllCollected = true
  for key, value in pairs(cardList) do
    if cards[value] then
    else
      isAllCollected = false
      break
    end
  end
  return isAllCollected
end

function UICollectCardContent:OpenUrl()
  local closeTime = self._questComInfo.m_close_time
  local svrTime = self._svrTimeModule:GetServerTime() * 0.001
  if closeTime > svrTime then
    local tips = StringTable.Get("str_collect_card_packet_locked")
    ToastManager.ShowToast(tips)
    return
  end
  local cards = self._cardComInfo.card
  local cfgs = Cfg.cfg_component_collect_card_reward({
    ComponentID = self._cardCfgID,
    RewardType = 2
  })
  local cfg = cfgs[1]
  local cardList = cfg.CardList
  local isAllCollected = true
  for key, value in pairs(cardList) do
    if cards[value] then
    else
      isAllCollected = false
      break
    end
  end
  if not isAllCollected then
    local tips = StringTable.Get("str_collect_card_packet_empty")
    ToastManager.ShowToast(tips)
    return
  end
  local info = GameGlobal.GameLogic().ClientInfo
  local source = info.m_login_source
  local www
  if source == MobileClientLoginChannel.MCLC_WX then
    www = "https://game.weixin.qq.com/cgi-bin/comm/openlink?noticeid=90303934&auth_appid=wx4fa1b8651cf789f1&url=https%3A%2F%2Fgame.weixin.qq.com%2Fcgi-bin%2Factnew%2Fnewportalact%2F187964%2FHnIJLwWBCCjBe4Ka2piAWw%2Fmain_page%3Fact_id%3D187964%26k%3DHnIJLwWBCCjBe4Ka2piAWw%26pid%3Dmain_page%23wechat_redirect"
  else
    www = "https://youxi.gamecenter.qq.com/m/act/3e308e3780a87062_10178708.html?_wv=1&_wwv=4"
  end
  SDKProxy:GetInstance():OpenUrl(www, "Portrait")
  UICollectCardContent.SaveLocalDB_Enter_WebView()
end

function UICollectCardContent.SaveLocalDB_Enter_WebView()
  if not UICollectCardContent.CheckLocalDB_Enter_WebView() then
    local pstid = GameGlobal.GetModule(RoleModule):GetPstId()
    local key = "CollectCardWebView" .. pstid
    LocalDB.SetInt(key, 1)
  end
end

function UICollectCardContent.CheckLocalDB_Enter_WebView()
  local pstid = GameGlobal.GetModule(RoleModule):GetPstId()
  local key = "CollectCardWebView" .. pstid
  local val = LocalDB.GetInt(key, 0)
  return val ~= 0
end

function UICollectCardContent:DoShow()
  if self._campaign:CheckCampaignNew() then
    self:StartTask(function(TT)
      self._campaign:ClearCampaignNew(TT)
    end)
  end
  self:CreateData()
  self:_Refresh()
  local reveiceInfo = self._cardCom:GetReceiveCardsInfo()
  if reveiceInfo and 0 < #reveiceInfo then
    self:ShowDialog("UICollectCardReceive", reveiceInfo, function()
      self._cardCom:ClearReceiveCardsInfo()
    end, self._cardCom)
  end
  self._inited = true
end

function UICollectCardContent:DoHide()
  self._inited = false
end

function UICollectCardContent:DoDestroy()
end

function UICollectCardContent:_Refresh()
  local comIsOpen = self:CheckComOpen()
  self:SetOnlyWeb(comIsOpen)
  self:SetDescGo2()
  if comIsOpen then
    self:SetTimer()
    self:SetActivePoint()
    self:SetBigAward()
    self:SetWebBtn()
    self:SetCardList()
  else
    self:SetOpenUrlRed()
  end
end

function UICollectCardContent:SetOnlyWeb(open)
  self._normalGo:SetActive(open)
  self._onlyWebGo:SetActive(not open)
end

function UICollectCardContent:SetBigAward()
  local cfg = self:BigCfg()
  local status = self:GetCardAwardStatus(cfg.ID)
  self._bigAwardBtn:SetActive(status == QuestStatus.QUEST_Completed)
  self._bigAwardGot:SetActive(status == QuestStatus.QUEST_Taken)
end

function UICollectCardContent:SetWebBtn()
  self._webBtn:SetActive(self:IsInland())
end

function UICollectCardContent:SetDescGo2()
  self._descGo2:SetActive(self:IsInland())
  Log.debug("###[UICollectCardContent] IsInland() 1")
  if self:IsInland() then
    Log.debug("###[UICollectCardContent] IsInland() 2")
    local info = GameGlobal.GameLogic().ClientInfo
    local source = info.m_login_source
    local desc2, desc3
    if source == MobileClientLoginChannel.MCLC_WX then
      desc3 = "str_collect_card_close_money_wechat"
      desc2 = "str_collect_card_money_wechat"
      Log.debug("###[UICollectCardContent] IsInland() 3")
    else
      desc3 = "str_collect_card_close_money_qq"
      desc2 = "str_collect_card_money_qq"
      Log.debug("###[UICollectCardContent] IsInland() 4")
    end
    self._desc2:SetText(StringTable.Get(desc2))
    self._desc3:SetText(StringTable.Get(desc3))
  end
end

function UICollectCardContent:SetActivePoint()
  local activeVal = self._questModule:GetDailyQuestVigorous()
  local questList = self:GetQuestList()
  self._activePool:SpawnObjects("UICollectCardActivePoint", #questList)
  local pools = self._activePool:GetAllSpawnList()
  local maxPoint = 100
  local sliderWidth = 870
  for i = 1, #questList do
    local item = pools[i]
    local questid = questList[i]
    local quest = self._questModule:GetQuest(questid)
    local questInfo = quest:QuestInfo()
    item:SetData(i, questInfo, function(idx)
      self:OnQuestItemClick(idx)
    end, maxPoint, sliderWidth)
  end
  self._activeImg.fillAmount = math.min(1, activeVal / maxPoint)
  local getCardTexStr
  local itemNew1, itemNew2 = self:GetNewCostItemCount()
  if itemNew1 or itemNew2 then
    getCardTexStr = "str_collect_card_box_btn"
    self._GetCardBtnTex:SetText(StringTable.Get(getCardTexStr))
    self._redGo:SetActive(true)
  else
    local item1, item2 = self:GetCostItemCount()
    if item1 or item2 then
      getCardTexStr = "str_collect_card_reget_button"
      self._GetCardBtnTex:SetText(StringTable.Get(getCardTexStr))
      self._redGo:SetActive(true)
    else
      self._redGo:SetActive(false)
    end
  end
end

function UICollectCardContent:OnQuestItemClick(idx)
  Log.debug("###[UICollectCardContent] start get quest awards")
  self:Lock("UICollectCardContent:OnQuestItemClick")
  GameGlobal.TaskManager():StartTask(self.OnHandleOneKeyTakeQuest, self)
end

function UICollectCardContent:OnHandleOneKeyTakeQuest(TT)
  local res = AsyncRequestRes:New()
  self._questCom:HandleOneKeyTakeQuest(TT, res)
  self:UnLock("UICollectCardContent:OnQuestItemClick")
  if res and res:GetSucc() then
    Log.debug("###[UICollectCardContent] start get quest awards over")
    local item1, item2 = self:GetUseCostItem()
    if item1 or item2 then
      self:HandleDropCardReq(item1, item2)
    else
      Log.error("###[UICollectCardContent] get quest awards,item is nil !")
    end
  else
    local result = res:GetResult()
    Log.error("###[UICollectCardContent] OnHandleOneKeyTakeQuest fail ! result:", result)
  end
end

function UICollectCardContent:GetCardBtnOnClick(go)
  local item1, item2 = self:GetUseCostItem()
  if item1 or item2 then
    self:HandleDropCardReq(item1, item2)
  else
    Log.debug("###[UICollectCardContent] GetCardBtnOnClick,item is nil !")
  end
end

function UICollectCardContent:HandleDropCardReq(item1, item2)
  self:Lock("UICollectCardContent:HandleDropCardReq")
  GameGlobal.TaskManager():StartTask(self.OnHandleDropCardReq, self, item1, item2)
end

function UICollectCardContent:OnHandleDropCardReq(TT, item1, item2)
  Log.debug("###[UICollectCardContent] start OnHandleDropCardReq")
  local res = AsyncRequestRes:New()
  local cards
  res, cards = self._cardCom:HandleDropCardReq(TT, res, item1, item2)
  self:UnLock("UICollectCardContent:HandleDropCardReq")
  if res and res:GetSucc() then
    if cards and table.count(cards) > 0 then
      self:ShowDialog("UICollectCardOpen", cards)
    end
    self:CreateData()
    self:_Refresh()
  else
    local result = res:GetResult()
    Log.error("###[UICollectCardContent] HandleDropCardReq fail! result:", result)
  end
end

function UICollectCardContent:GetNewCostItemCount()
  local cfgs1 = Cfg.cfg_component_collect_item({
    ComponentID = self._cardCfgID,
    Type = 1,
    Mail = 1
  })
  local cfgs2 = Cfg.cfg_component_collect_item({
    ComponentID = self._cardCfgID,
    Type = 2,
    Mail = 1
  })
  local cfg1 = cfgs1[1]
  local cfg2 = cfgs2[1]
  local RoleAsset1, RoleAsset2
  if cfg1 then
    local id = cfg1.ID
    local count = self._itemModule:GetItemCount(id)
    if 0 < count then
      RoleAsset1 = RoleAsset:New()
      RoleAsset1.assetid = id
      RoleAsset1.count = count
    end
  end
  if cfg2 then
    local id = cfg2.ID
    local count = self._itemModule:GetItemCount(id)
    if 0 < count then
      RoleAsset2 = RoleAsset:New()
      RoleAsset2.assetid = id
      RoleAsset2.count = count
    end
  end
  return RoleAsset1, RoleAsset2
end

function UICollectCardContent:GetUseCostItem()
  local item1, item2 = self:GetNewCostItemCount()
  if item1 or item2 then
  else
    item1, item2 = self:GetCostItemCount()
  end
  return item1, item2
end

function UICollectCardContent:GetCostItemCount()
  local cfgs1 = Cfg.cfg_component_collect_item({
    ComponentID = self._cardCfgID,
    Type = 1,
    Mail = 0
  })
  local cfgs2 = Cfg.cfg_component_collect_item({
    ComponentID = self._cardCfgID,
    Type = 2,
    Mail = 0
  })
  local cfg1 = cfgs1[1]
  local cfg2 = cfgs2[1]
  local RoleAsset1, RoleAsset2
  if cfg1 then
    local id = cfg1.ID
    local count = self._itemModule:GetItemCount(id)
    if 0 < count then
      RoleAsset1 = RoleAsset:New()
      RoleAsset1.assetid = id
      RoleAsset1.count = count
    end
  end
  if cfg2 then
    local id = cfg2.ID
    local count = self._itemModule:GetItemCount(id)
    if 0 < count then
      RoleAsset2 = RoleAsset:New()
      RoleAsset2.assetid = id
      RoleAsset2.count = count
    end
  end
  return RoleAsset1, RoleAsset2
end

function UICollectCardContent:GetQuestList()
  local questList = self._questComInfo.m_accept_cam_quest_list
  return questList
end

function UICollectCardContent:SetCardList()
  local cfgs = Cfg.cfg_component_collect_card_reward({
    ComponentID = self._cardCfgID,
    RewardType = 1
  })
  self._cardList = {}
  for i = 1, #cfgs do
    table.insert(self._cardList, cfgs[i])
  end
  table.sort(self._cardList, function(a, b)
    return a.ID < b.ID
  end)
  self._pool:SpawnObjects("UICollectCardItem", #self._cardList)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._cardList do
    local cfg = self._cardList[i]
    local item = pools[i]
    local status = self:GetCardAwardStatus(cfg.ID)
    local haveCount, allCount = self:GetCardHaveCount(cfg.ID)
    item:SetData(i, cfg, haveCount, allCount, status, function(idx)
      self:OnCardClick(idx)
    end, function(idx)
      self:OnCardClickAward(idx)
    end, self._inited)
  end
end

function UICollectCardContent:GetCardHaveCount(awardid)
  local cfg = Cfg.cfg_component_collect_card_reward[awardid]
  local cardList = cfg.CardList
  local count = 0
  for key, value in pairs(cardList) do
    if self._cardComInfo.card[value] then
      count = count + 1
    end
  end
  return count, #cardList
end

function UICollectCardContent:GetCardAwardStatus(id)
  local gotList = self._cardComInfo.received_rewards
  if table.icontains(gotList, id) then
    return QuestStatus.QUEST_Taken
  elseif self:CheckCardComplete(id) then
    return QuestStatus.QUEST_Completed
  else
    return QuestStatus.QUEST_Accepted
  end
end

function UICollectCardContent:OnCardClick(idx)
  local cfg = self._cardList[idx]
  local haveCount = self:GetCardHaveCount(cfg.ID)
  self:ShowDialog("UICollectCardInfo", cfg, haveCount, self._cardComInfo)
end

function UICollectCardContent:OnCardClickAward(idx)
  local cfg = self._cardList[idx]
  self:GetAward(cfg.ID)
end

function UICollectCardContent:CheckComOpen()
  local svrTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._cardComInfo.m_close_time
  if svrTime < endTime then
    return true
  end
  return false
end

function UICollectCardContent:SetTimer()
  local endTime = self._cardComInfo.m_close_time
  self._timerObj = self._timerPool:SpawnObject("UISeasonTalentTimeBase")
  self._timerObj:Set_Time_Tex("str_collect_card_time")
  self._timerObj:SetData(endTime, function()
    local tips = StringTable.Get("str_activity_error_107")
    ToastManager.ShowToast(tips)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
  end)
end
