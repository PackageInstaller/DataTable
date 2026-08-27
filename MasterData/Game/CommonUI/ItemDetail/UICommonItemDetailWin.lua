local UICommonItemDetailWin = class("UICommonItemDetailWin", UIBaseWindow)
local base = UIBaseWindow
local util = require("XLua.Common.xlua_util")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local UINRaffleDetailItem = require("Game.CommonUI.ItemDetail.UINRaffleDetailItem")
local JumpInfoItem = require("Game.CommonUI.ItemDetail.UICIDJumpInfoItem")
local JumpManager = require("Game.Jump.JumpManager")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local cs_MessageCommon = CS.MessageCommon

function UICommonItemDetailWin:OnInit()
  self.isARG = false
  UIUtil.AddButtonListener(self.ui.btn_return, self, self.OnBtnReturnClick)
  UIUtil.AddButtonListener(self.ui.btn_Use, self, self.OnBtnUseClick)
  UIUtil.AddButtonListener(self.ui.btn_Left, self, self.OnClickSwitchLeft)
  UIUtil.AddButtonListener(self.ui.btn_Right, self, self.OnClickSwitchRight)
  UIUtil.AddButtonListener(self.ui.btn_UseGift, self, self.OnClickUse)
  UIUtil.AddButtonListener(self.ui.btn_detail, self, self.OnBtnRandomItemDetail)
  UIUtil.AddButtonListener(self.ui.Btn_SkillDetails, self, self.OnClickSkillDetails)
  self.resloader = CS.ResLoader.Create()
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
  self.baseItem:BindBaseItemResloader(self.resloader)
  self.athInfoNode = UINAthDetailItem.New()
  self.athInfoNode:Init(self.ui.aTHDetailItem)
  self.poolInfoItem = UIItemPool.New(JumpInfoItem, self.ui.obj_jumpInfoItem)
  self.ui.obj_jumpInfoItem:SetActive(false)
  self.raffleItemPool = UIItemPool.New(UINRaffleDetailItem, self.ui.obj_raffleItem, false)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
end

function UICommonItemDetailWin:InitCommonItemDetail(itemCfg, useAction)
  if itemCfg == nil then
    error("Can't find itemCfg")
    return
  end
  self.itemId = itemCfg.id
  self.useAction = useAction
  self.showList = {
    [1] = {itemCfg = itemCfg, athData = nil}
  }
  self.selectIndex = 1
  self:RefreshDetail()
  AudioManager:PlayAudioById(1072)
end

function UICommonItemDetailWin:OnShow()
  UIUtil.SetTopStatus(self, self.Hide, nil, nil, nil, true)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  self.transform:SetAsLastSibling()
end

function UICommonItemDetailWin:InitAthDetail(itemCfg, athData, useAction)
  if itemCfg == nil then
    error("Can't find itemCfg")
    return
  end
  self.useAction = useAction
  self.showList = {
    [1] = {itemCfg = itemCfg, athData = athData}
  }
  self.selectIndex = 1
  self:RefreshDetail()
end

function UICommonItemDetailWin:InitLimitTimeItemDetail(itemCfg, stackInfo, useAction)
  if itemCfg == nil then
    error("Can't find itemCfg")
    return
  end
  if stackInfo == nil then
    local limitCfg = ConfigData.item_time_limit[itemCfg.id]
    if limitCfg ~= nil and limitCfg.type == eLimitTimeItemType.Fixed then
      stackInfo = {}
      stackInfo.num = PlayerDataCenter:GetItemCount(itemCfg.id)
      stackInfo.time = limitCfg.time
    end
  end
  self.useAction = useAction
  self.showList = {
    [1] = {itemCfg = itemCfg, stackInfo = stackInfo}
  }
  self.isTimeOut = false
  self.selectIndex = 1
  self:RefreshDetail()
end

function UICommonItemDetailWin:InitListDetail(showList, index, notShowBuyFrag)
  if showList == nil or #showList == 0 then
    error("Can't find itemCfg")
    return
  end
  self.useAction = nil
  self.showList = showList
  self.selectIndex = index
  if notShowBuyFrag ~= nil then
    self.notShowBuyFrag = notShowBuyFrag
  end
  self:RefreshDetail()
end

function UICommonItemDetailWin:InitCommonItemDetailWithCount(itemCfg, useAction, count)
  if itemCfg == nil then
    error("Can't find itemCfg")
    return
  end
  self:InitCommonItemDetail(itemCfg, useAction)
  if count then
    self:_ShowCount(count)
  end
end

function UICommonItemDetailWin:RefreshDetail()
  self.selectIndex = self.selectIndex or 1
  local selectData = self.showList[self.selectIndex]
  self.itemId = selectData.itemCfg.id
  local itemCfg = selectData.itemCfg
  local athData = selectData.athData
  local stackInfo = selectData.stackInfo
  if itemCfg == nil then
    error("Can't find itemCfg")
    return
  end
  self:RefreshSwitchState()
  self:__InitCIDData(itemCfg)
  self:__InitCIDUI(itemCfg, athData, stackInfo)
  if self.ui.btn_UseGift.gameObject.activeSelf then
    self.ui.btn_UseGift.gameObject:SetActive(false)
  end
  if self.ui.obj_randomItem.gameObject.activeSelf then
    self.ui.obj_randomItem:SetActive(false)
  end
  if athData ~= nil then
    self.ui.obj_normalDetail:SetActive(false)
    self.athInfoNode:InitAthDetailItem(nil, athData, nil, false, false, false)
    self.athInfoNode:Show()
    self:RefreshARGInfo(false)
    self:RefreshLimitTime(nil, self.itemId)
  elseif stackInfo ~= nil then
    self.ui.obj_normalDetail:SetActive(true)
    self.athInfoNode:Hide()
    self:UpdateJumpList(itemCfg)
    self:RefreshLimitTime(stackInfo.time, self.itemId)
    self:RefreshARGInfo(false)
  else
    self.ui.obj_normalDetail:SetActive(true)
    self.athInfoNode:Hide()
    self.isARG = PlayerDataCenter.allEffectorData:IsAutoGenerateResource(itemCfg.id)
    self:RefreshARGInfo(self.isARG)
    self:UpdateJumpList(itemCfg)
    self:RefreshLimitTime(nil, self.itemId)
  end
  self:RefreshRaffleItemList()
  self:RefreshMonsterCard()
end

function UICommonItemDetailWin:__InitCIDData(itemCfg)
  self.isHeroItem = false
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    self.isHeroItem = true
  end
  self.isHaveThisHero = false
  if self.isHeroItem and PlayerDataCenter.heroDic[itemCfg.arg[1]] ~= nil then
    self.isHaveThisHero = true
  end
  self.showUseBtn = false
  if itemCfg.can_use ~= false and itemCfg.can_use ~= nil or self.useAction ~= nil then
    self.showUseBtn = true
  end
  self.canUse = itemCfg.can_use
end

function UICommonItemDetailWin:__InitCIDUI(itemCfg, athData, stackInfo)
  self.baseItem:InitBaseItem(itemCfg, nil)
  self.baseItem:SetLimtTimeTagActive(false)
  if athData ~= nil then
    self:_ShowCount(PlayerDataCenter.allAthData:GetAthNumById(athData.id))
  elseif stackInfo ~= nil then
    self:_ShowCount(stackInfo.num)
  else
    self:_ShowCountByItem(itemCfg)
  end
  self.ui.tex_Name.text = tostring(LanguageUtil.GetLocaleText(itemCfg.name))
  self.ui.tex_Descr.text = tostring(LanguageUtil.GetLocaleText(itemCfg.describe))
  if not self.isHeroItem then
    self.ui.img_ItemQuality.color = ItemQualityColor[self.baseItem:GetQuality()]
  end
  self.ui.obj_HeroQuailty:SetActive(self.isHeroItem)
  self.ui.img_ItemQuality.gameObject:SetActive(not self.isHeroItem)
  self.ui.btn_Use.gameObject:SetActive(self.showUseBtn)
  if itemCfg.type_tag > 0 then
    self.ui.obj_ItemType:SetActive(true)
    self.ui.tex_ItemType.text = LanguageUtil.GetLocaleText(ConfigData.item_type_tag[itemCfg.type_tag].name)
  else
    self.ui.obj_ItemType:SetActive(false)
  end
end

function UICommonItemDetailWin:RefreshARGInfo(bool)
  self.ui.obj_aRGInfo_Speed:SetActive(bool)
  self.ui.obj_aRGInfo_Time2Limit:SetActive(bool)
  if bool then
    local function Refresh()
      local num, nextTime = PlayerDataCenter.allEffectorData:GetCurrentARGNum(self.itemId)
      
      local speed = PlayerDataCenter.allEffectorData:GetCurrentARGSpeed(self.itemId)
      local ceiling = PlayerDataCenter.allEffectorData:GetCurrentARGCeiling(self.itemId)
      self:_ShowCount(num)
      if 0 < nextTime then
        self.ui.tex_speed:SetIndex(1, GetPreciseDecimalStr(speed * 3600, 1), TimeUtil:TimestampToTime(nextTime))
      else
        self.ui.tex_speed:SetIndex(0, GetPreciseDecimalStr(speed * 3600, 1))
      end
      self.ui.text_time2Limittitle:SetIndex(0, tostring(num), tostring(ceiling))
      if num < ceiling then
        local timeStr = TimeUtil:TimestampToTime((ceiling - num - 1) / speed + nextTime)
        self.ui.tex_time2Limit:SetIndex(0, timeStr)
      else
        self.ui.tex_time2Limit:SetIndex(1)
      end
    end
    
    Refresh()
    TimerManager:StopTimer(self.ARGTimerId)
    self.ARGTimerId = TimerManager:StartTimer(1, Refresh)
  elseif self.ARGTimerId ~= nil then
    TimerManager:StopTimer(self.ARGTimerId)
    self.ARGTimerId = nil
  end
end

function UICommonItemDetailWin:RefreshRaffleItemList()
  local cfg = ConfigData.item[self.itemId]
  self.raffleItemPool:HideAll()
  if cfg.type == eItemType.RaffleBox then
    self.ui.obj_rateList:SetActive(true)
    local raffleItemList = ConfigData.item.raffleBoxDic[self.itemId]
    for _, raffleCfg in pairs(raffleItemList) do
      local item = self.raffleItemPool:GetOne(true)
      item:InitRaffleDetailItem(ConfigData.item[raffleCfg.rewardId], raffleCfg.rewardCount, raffleCfg.weight)
    end
  else
    self.ui.obj_rateList:SetActive(false)
  end
end

function UICommonItemDetailWin:RefreshMonsterCard()
  local cfg = ConfigData.item[self.itemId]
  local isMonsterCard = cfg.type == eItemType.ItemTypeMonsterCard
  self.ui.Btn_SkillDetails.gameObject:SetActive(isMonsterCard)
  if not isMonsterCard then
    return
  end
  self.ui.Tex_SkillDetailsTitle:SetIndex(0)
  ConfigData:LoadDynCfg(eDynConfigData.activity_monster_card_card_level)
  local ActMonsterCardData = require("Game.ActivityFrame.ActivityMonsterCard.ActMonsterCardData")
  local monCardId = self.itemId
  local levelList = ConfigData.activity_monster_card_card_level[monCardId]
  local des = ActMonsterCardData.AacMCD_Static_GetDes(monCardId, #levelList, eLogicDesType.MonsterCard)
  local desHead = ConfigData:GetTipContent(13504)
  self.ui.Tex_SkillDes.text = desHead .. des
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_monster_card_card_level)
end

function UICommonItemDetailWin:OnClickSkillDetails(forceclose)
  if forceclose then
    self.__isSkillDetailOpen = false
  else
    self.__isSkillDetailOpen = not self.__isSkillDetailOpen
  end
  self.ui.Img_ArrowUp:SetActive(self.__isSkillDetailOpen)
  self.ui.Img_ArrowDown:SetActive(not self.__isSkillDetailOpen)
  self.ui.Obj_SkillDetail:SetActive(self.__isSkillDetailOpen)
  if self.__isSkillDetailOpen then
    self.ui.Tex_SkillDetailsTitle:SetIndex(1)
  else
    self.ui.Tex_SkillDetailsTitle:SetIndex(0)
  end
end

function UICommonItemDetailWin:RefreshLimitTime(outTime, itemId, isBackPackItem)
  local cfg = ConfigData.item_time_limit[itemId]
  local limitType = eLimitTimeItemType.None
  if cfg ~= nil then
    limitType = cfg.type
  end
  if limitType ~= eLimitTimeItemType.None then
    if self.ui.obj_limitTime.activeSelf == false then
      self.ui.obj_limitTime:SetActive(true)
    end
    if outTime ~= nil then
      local function Refresh()
        local diffTime = outTime - PlayerDataCenter.timestamp
        
        if 0 < diffTime then
          local d, h, m, s = TimeUtil:TimestampToTimeInter(diffTime, false, true)
          if 0 < d then
            self.ui.text_LimitTime:SetIndex(0, tostring(d), tostring(h))
          elseif 0 < h then
            self.ui.text_LimitTime:SetIndex(1, tostring(h), tostring(m))
          elseif 0 < m then
            self.ui.text_LimitTime:SetIndex(2, tostring(m))
          else
            self.ui.text_LimitTime:SetIndex(2, tostring(1))
          end
        else
          self.ui.text_LimitTime:SetIndex(3)
          self.isTimeOut = true
          TimerManager:StopTimer(self.LimitTimeItemTimerId)
        end
      end
      
      Refresh()
      TimerManager:StopTimer(self.LimitTimeItemTimerId)
      self.LimitTimeItemTimerId = TimerManager:StartTimer(1, Refresh, self)
    else
      self.ui.text_LimitTime:SetIndex(4)
    end
  elseif self.ui.obj_limitTime.activeSelf == true then
    self.ui.obj_limitTime:SetActive(false)
  end
end

function UICommonItemDetailWin:SetNotNeedAnyJump(bool)
  self.notNeedAnyJump = bool
end

function UICommonItemDetailWin:UpdateJumpList(itemCfg)
  if self.__UpdateJumpListCo ~= nil then
    GR.StopCoroutine(self.__UpdateJumpListCo)
    self.__UpdateJumpListCo = nil
  end
  self.__UpdateJumpListCo = GR.StartCoroutine(util.cs_generator(self.__UpdateJumpList, self, itemCfg))
end

function UICommonItemDetailWin:__UpdateJumpList(itemCfg)
  self.poolInfoItem:HideAll()
  local isHaveAchieveDes = itemCfg.achieve_des ~= ""
  local isHaveNormalJumpList = itemCfg.jumpList ~= nil and #itemCfg.jumpList ~= 0 and JumpManager.couldUseItemJump
  local isCouldBuyFrag = self.isHeroItem and self.isHaveThisHero and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) and not self.notShowBuyFrag
  self.isCoulduseGift = false
  self.useGiftList = nil
  self.jumpuseGiftItem = nil
  local isShowRandomItemBtn = false
  if itemCfg.giftIdList ~= nil and 0 < table.count(itemCfg.giftIdList) then
    isShowRandomItemBtn = true
  end
  if itemCfg.type == eItemType.BackgroudPlate then
    isShowRandomItemBtn = true
  end
  self.ui.obj_randomItem:SetActive(isShowRandomItemBtn)
  local inDungeonOrEp = BattleDungeonManager:InBattleDungeon() or ExplorationManager:IsInExploration()
  if self.notNeedAnyJump or inDungeonOrEp then
    if isHaveAchieveDes then
      self.ui.obj_jumpList:SetActive(false)
      self.ui.tex_achieveText.gameObject:SetActive(true)
      self.ui.tex_achieveText.text = tostring(LanguageUtil.GetLocaleText(itemCfg.achieve_des))
      return
    else
      self.ui.obj_jumpList:SetActive(false)
      self.ui.tex_achieveText.gameObject:SetActive(false)
      return
    end
  end
  local waitFactory = true
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.factoryController:IsCouldOpenQuickProduceUI(self.itemId, function(isHaveQuickFactory, targetOrderData)
    waitFactory = false
    if isHaveQuickFactory then
      local factoryItem = self.poolInfoItem:GetOne()
      factoryItem:InitQuickProduce(targetOrderData, self.factoryController)
    end
  end)
  while waitFactory do
    coroutine.yield(nil)
  end
  if isCouldBuyFrag then
    local frageId = itemCfg.id
    local shopCfg = ConfigData.shop_hero.fragId2ShopInfo[frageId]
    if shopCfg then
      local item = self.poolInfoItem:GetOne()
      item:InitQuickBuy(shopCfg.shopId, shopCfg.shelfId, shopCfg.resourceIds)
    end
  end
  if isHaveNormalJumpList then
    local jumpDic = {}
    for index, cfg in ipairs(itemCfg.jumpList) do
      if cfg.jump_id ~= JumpManager.eJumpTarget.fragDungeon or self.isHaveThisHero then
        if jumpDic[cfg.jump_id] == nil then
          jumpDic[cfg.jump_id] = {}
        end
        table.insert(jumpDic[cfg.jump_id], cfg.jumpArgs)
      end
    end
    for jumpId, args in pairs(jumpDic) do
      local item = self.poolInfoItem:GetOne()
      item:InitCIDJumpInfoItem(jumpId, args)
    end
  end
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[itemCfg.arg[1]]
    if heroData ~= nil and heroData:IsCouldFragConvert() then
      local item = self.poolInfoItem:GetOne()
      item:InitFragConvert({
        itemCfg.id
      })
    end
  end
  local isHaveJumpList = 0 < #self.poolInfoItem.listItem
  if isHaveJumpList then
    self.ui.obj_jumpList:SetActive(true)
    self.ui.tex_achieveText.gameObject:SetActive(false)
  elseif isHaveAchieveDes then
    self.ui.obj_jumpList:SetActive(false)
    self.ui.tex_achieveText.gameObject:SetActive(true)
    self.ui.tex_achieveText.text = tostring(LanguageUtil.GetLocaleText(itemCfg.achieve_des))
  else
    self.ui.obj_jumpList:SetActive(false)
    self.ui.tex_achieveText.gameObject:SetActive(false)
  end
end

function UICommonItemDetailWin:OnBtnReturnClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonItemDetailWin:TryShowGiftJump(flag)
  self.isCoulduseGift = flag
  if not flag then
    if self.jumpuseGiftItem ~= nil then
      self.poolInfoItem:HideOne(self.jumpuseGiftItem)
      self.jumpuseGiftItem = nil
    end
    return
  end
  if self.useGiftList == nil then
    local list = {}
    table.insertto(list, ConfigData.item.fixedPacketMappingDic[self.itemId] or table.emptytable)
    table.insertto(list, ConfigData.item.selectPacketMappingDic[self.itemId] or table.emptytable)
    self.useGiftList = list
  end
  local canShow = false
  for _, expPacketid in ipairs(self.useGiftList) do
    if PlayerDataCenter:GetItemCount(expPacketid) > 0 then
      canShow = true
      break
    end
  end
  if canShow then
    if self.jumpuseGiftItem == nil then
      self.jumpuseGiftItem = self.poolInfoItem:GetOne()
    end
    self.jumpuseGiftItem:InitUseGift(self.itemId, self.useGiftList)
  else
    if self.jumpuseGiftItem ~= nil then
      self.poolInfoItem:HideOne(self.jumpuseGiftItem)
    end
    self.jumpuseGiftItem = nil
  end
end

function UICommonItemDetailWin:OnBtnUseClick()
  if self.useAction ~= nil then
    self.useAction()
    return
  end
  if self.canUse then
  end
end

function UICommonItemDetailWin:OnClickSwitchLeft()
  if self.selectIndex > 1 then
    self.selectIndex = self.selectIndex - 1
    self:RefreshDetail()
  end
end

function UICommonItemDetailWin:OnClickSwitchRight()
  if self.selectIndex < #self.showList then
    self.selectIndex = self.selectIndex + 1
    self:RefreshDetail()
  end
end

function UICommonItemDetailWin:RefreshSwitchState()
  self.ui.btn_Left.gameObject:SetActive(self.selectIndex ~= nil and self.selectIndex > 1)
  self.ui.btn_Right.gameObject:SetActive(self.selectIndex ~= nil and self.selectIndex < #self.showList)
end

function UICommonItemDetailWin:ParentWindowType(type)
  self.parentWindowType = type
end

function UICommonItemDetailWin:OnItemRefresh(itemUpdate)
  if itemUpdate[self.itemId] ~= nil then
    self:_ShowCountByItem(ConfigData.item[self.itemId])
  end
  if self.useGiftList ~= nil then
    for _, itemId in ipairs(self.useGiftList) do
      if itemUpdate[itemId] ~= nil then
        self:_ShowUseGiftJump()
        break
      end
    end
  end
end

function UICommonItemDetailWin:_ShowUseGiftJump()
  if not self.isCoulduseGift then
    return
  end
  local canShow = false
  for _, itemId in ipairs(self.useGiftList) do
    if PlayerDataCenter:GetItemCount(itemId) > 0 then
      canShow = true
      break
    end
  end
  if canShow then
    if self.jumpuseGiftItem == nil then
      self.jumpuseGiftItem = self.poolInfoItem:GetOne()
      self.jumpuseGiftItem:InitUseGift(self.itemId, self.useGiftList)
    end
  else
    if self.jumpuseGiftItem ~= nil then
      self.poolInfoItem:HideOne(self.jumpuseGiftItem)
    end
    self.jumpuseGiftItem = nil
  end
end

function UICommonItemDetailWin:_ShowCountByItem(itemCfg)
  if itemCfg == nil or itemCfg.type == eItemType.HeroCard then
    self.ui.obj_stock:SetActive(false)
    return
  end
  local count = 0
  if itemCfg.id == ConstGlobalItem.SKey then
    count = PlayerDataCenter.stamina:GetCurrentStamina()
  else
    count = PlayerDataCenter:GetItemCount(itemCfg.id)
  end
  self:_ShowCount(count)
end

function UICommonItemDetailWin:_ShowCount(count)
  if count <= 0 then
    self.ui.obj_stock:SetActive(false)
  else
    self.ui.tex_Count.text = tostring(count)
    self.ui.obj_stock:SetActive(true)
  end
end

function UICommonItemDetailWin:OnClickUse()
  UIUtil.OnClickBackByUiTab(self)
  local itemCfg = ConfigData.item[self.itemId]
  if self.isTimeOut then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6041))
    return
  end
  if ConfigData:IsManualOpenGiftItem(itemCfg) then
    self:UseGift(itemCfg)
  elseif itemCfg.id == ConfigData.game_config.changeNameItemId or itemCfg.id == ConfigData.game_config.limitTimeChangeNameItemId then
    self:UseChangeNameCard(itemCfg)
  elseif HeroGoLevelItemDic[itemCfg.id] then
    self:UseHeroQuickLv(itemCfg)
  end
end

function UICommonItemDetailWin:OnBtnRandomItemDetail()
  UIUtil.OnClickBackByUiTab(self)
  local itemCfg = ConfigData.item[self.itemId]
  if itemCfg ~= nil and itemCfg.type == eItemType.BackgroudPlate then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
      if win == nil then
        return
      end
      win:InitUserInfoView(PlayerDataCenter.inforData)
      win:SetBackgroundPlateId(self.itemId)
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.RewardPreview, function(window)
      if window == nil then
        return
      end
      window:InitRewardPreview(self.itemId, itemCfg.giftIdList, itemCfg.giftCountList)
    end)
  end
end

function UICommonItemDetailWin:UseHeroQuickLv(itemCfg)
  local golevelCfg = ConfigData.hero_golevel[itemCfg.id]
  if golevelCfg == nil then
    return
  end
  if not CheckCondition.CheckLua(golevelCfg.pre_condition, golevelCfg.pre_para1, golevelCfg.pre_para2) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7906))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroQuickLvUpWindow, function(window)
    if window == nil then
      return
    end
    window:InitHeroQuickLvWindow(itemCfg, self.resloader)
  end)
end

function UICommonItemDetailWin:UseChangeNameCard(itemCfg)
  if CloseCustomBename or ConfigData.game_config.closePlayerRename then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    if window ~= nil then
      window:OpenChangeNameDialogFromStore()
    end
  end)
end

function UICommonItemDetailWin:UseGift(itemCfg)
  local count = PlayerDataCenter:GetItemCount(itemCfg.id)
  if (itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeFixedItem or itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRandomReward) and count == 1 then
    local athMaxCoulHaveNum = ConfigData.item.athGiftDic[itemCfg.id]
    if athMaxCoulHaveNum ~= nil and 0 < athMaxCoulHaveNum and #PlayerDataCenter.allAthData:GetAllAthList() + athMaxCoulHaveNum > ConfigData.game_config.athMaxNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.WearhouseOpenAthPackageFull))
      return
    end
    local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    local warehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
    warehouseNetwork:CS_BACKPACK_UseItem(itemCfg.id, count, function(dataList)
      if dataList.Count <= 0 then
        return
      end
      local rewardDic = dataList[0]
      local rewardIds = {}
      local rewardCounts = {}
      for id, num in pairs(rewardDic) do
        table.insert(rewardIds, id)
        table.insert(rewardCounts, num)
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts):SetCRHeroSnapshoot(heroIdSnapShoot)
        window:AddAndTryShowReward(CRData)
      end)
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUseGift, function(win)
      if win == nil then
        return
      end
      win:InitCommonUseGift(itemCfg)
    end)
  end
end

function UICommonItemDetailWin:ShowUseGiftBtn(itemCfg)
  if itemCfg == nil then
    return
  end
  if ConfigData:IsManualOpenItem(itemCfg) then
    local itemData = PlayerDataCenter.itemDic[itemCfg.id]
    self.ui.btn_UseGift.gameObject:SetActive(itemData ~= nil and itemData:GetCount() > 0)
  end
end

function UICommonItemDetailWin:HideUseGiftBtn()
  self.ui.btn_UseGift.gameObject:SetActive(false)
end

function UICommonItemDetailWin:OnHide()
  self.poolInfoItem:DeleteAll()
  self:OnClickSkillDetails(true)
  self.notNeedAnyJump = false
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  TimerManager:StopTimer(self.ARGTimerId)
  TimerManager:StopTimer(self.LimitTimeItemTimerId)
end

function UICommonItemDetailWin:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__UpdateJumpListCo ~= nil then
    GR.StopCoroutine(self.__UpdateJumpListCo)
    self.__UpdateJumpListCo = nil
  end
  base.OnDelete(self)
end

return UICommonItemDetailWin
