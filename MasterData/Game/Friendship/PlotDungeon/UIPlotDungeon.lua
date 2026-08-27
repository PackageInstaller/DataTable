local UIPlotDungeon = class("UIPlotDungeon", UIBaseWindow)
local base = UIBaseWindow
local HeroDungeonItemList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonItemList")
local UIHeroDungeonItem = require("Game.Friendship.PlotDungeon.UIHeroDungeonItem")
local UIHeroDungeonChapterList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UIHeroChapterItem = require("Game.Friendship.PlotDungeon.UIHeroChapterItem")
local RewardItem = require("Game.CommonUI.Item.UINBaseItem")
local FmtEnum = require("Game.Formation.FmtEnum")
local filterItem = require("Game.Friendship.PlotDungeon.UIFilterItem")
local HeroStoryItem = require("Game.Friendship.PlotDungeon.UIDungeonStoryItem")
local UINPlotDungeonArm = require("Game.Friendship.PlotDungeon.UINPlotDungeonArm")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINDungeonMultRateBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonMultRateBase")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local UINStarUpStarList = require("Game.Hero.NewUI.UpgradeStar.UINStarUpStarList")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")

function UIPlotDungeon:OnInit()
  self.ui.storyDetailNode:SetActive(false)
  self.originItemDataList = {}
  self.heroItemDataList = {}
  self.heroItemInsDict = {}
  self.onBattleStart = BindCallback(self, self.OnBattleStart)
  self.filterEvent = BindCallback(self, self.FilterItemAndUpdateList)
  self.filterParam = 0
  self._allTextContent = self.ui.tex_CampName.text
  self.filterParamDict = {}
  UIUtil.AddButtonListener(self.ui.btn_CampDrop, self, self.__dropCamList)
  self.campFilterItemPool = UIItemPool.New(filterItem, self.ui.btn_CampItem)
  self.onfilterItemClick = BindCallback(self, self.OnClickFilterItem)
  UIUtil.SetTopStatus(self, self.__onBack, {
    ConstGlobalItem.SKey
  })
  self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.__onDailyLimitUpdate)
  UIUtil.AddButtonListener(self.ui.btn_Friendship, self, self.OnClickFriendship)
  UIUtil.AddButtonListener(self.ui.btn_Favourite, self, self.OnClickFavouriteBtn)
  self.__reloadFriendShip = BindCallback(self, self.__loadFriendShip)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__reloadFriendShip)
  self.m_ChangeHeroItem = BindCallback(self, self.ChangeHeroItem)
  self.curHeroChipItem = UINBaseItemWithCount.New()
  self.curHeroChipItem:Init(self.ui.obj_currHeroChip)
  self.curStarList = UINStarUpStarList.New()
  self.curStarList:Init(self.ui.obj_curHeroStars)
  self.objArm = UINPlotDungeonArm.New()
  self.objArm:Init(self.ui.btn_Arma)
  UIUtil.AddButtonListener(self.ui.btn_StarUp, self, self.OnClickStarUp)
  self.__refreshHeroRank = BindCallback(self, self.__RefreshCurHeroStarAndFrag)
  MsgCenter:AddListener(eMsgEventId.OnHeroRankChange, self.__refreshHeroRank)
  self.__refreshCostNode = BindCallback(self, self.__RefreshCurHeroFrag)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshCostNode)
  self:__RegisterStarUpRedDotEvent()
  self.__DungeonTimerId = TimerManager:StartTimer(1, self.OnTimerUpdate, self, false, nil, nil)
end

function UIPlotDungeon:SortShoewHeroItem(dataList)
  table.sort(dataList, function(a, b)
    local aIsFavourite = a.heroData:IsFavouriteHero()
    local bIsFavourite = b.heroData:IsFavouriteHero()
    if aIsFavourite ~= bIsFavourite then
      return aIsFavourite
    end
    local needSortIsFragFull = ConfigData.game_config.plotDungeonSortByIsHaveEnoughFrage
    if needSortIsFragFull then
      local aIsNeedMoreFrage = a.heroData:GetMaxNeedFragNum(true) > 0
      local bIsNeedMoreFrage = b.heroData:GetMaxNeedFragNum(true) > 0
      if aIsNeedMoreFrage ~= bIsNeedMoreFrage then
        return aIsNeedMoreFrage
      end
    end
    local aUnlock = a:UnlockAndHasStageOpen()
    local bUnlock = b:UnlockAndHasStageOpen()
    if aUnlock ~= bUnlock then
      return aUnlock
    end
    if not aUnlock then
      local aStageCfg = a:GetNewLockStage()
      local bStageCfg = b:GetNewLockStage()
      if aStageCfg == nil or bStageCfg == nil then
        return aStageCfg ~= nil
      end
      if aStageCfg.pre_para1[1] ~= bStageCfg.pre_para1[1] then
        return aStageCfg.pre_para1[1] < bStageCfg.pre_para1[1]
      end
    else
      local aIsDouble = a.isDouble
      local bIsDouble = b.isDouble
      if aIsDouble ~= bIsDouble then
        return aIsDouble
      end
    end
    local powerA = a.heroData:GetFightingPower()
    local powerB = b.heroData:GetFightingPower()
    if powerA == powerB then
      return a.itemId < b.itemId
    else
      return powerA > powerB
    end
  end)
end

function UIPlotDungeon:InitDungeonType(dungeonTypeData, heroId, onBackCallback)
  self.dungeonTypeData = dungeonTypeData
  for index, value in ipairs(dungeonTypeData:GetDungeonDataList()) do
    self.originItemDataList[index] = value
  end
  self:SortShoewHeroItem(self.originItemDataList)
  for index, value in ipairs(self.originItemDataList) do
    self.heroItemDataList[index] = value
  end
  self.resLoader = cs_ResLoader.Create()
  self.selectHeroId = heroId
  if onBackCallback ~= nil then
    self.onBackCallback = onBackCallback
  end
  self:__updateDailyChanceAndStrength()
  self:__prepareHeroItemData()
  self:__loadHeroDungeonList(self.selectItemIndex)
end

function UIPlotDungeon:__dailyLimitUpdate()
  for k, v in ipairs(self.heroItemDataList) do
    if v ~= nil then
      v:CleanCacheData()
    end
  end
  self.heroItemList:ExecuteFilter(self.filterParamDict[self.filterParam])
  self:__updateDailyChanceAndStrength()
  local isInited = {}
  self.campFilterItemPool:HideAll()
  for _, heroItemData in ipairs(self.originItemDataList) do
    if not isInited[heroItemData.sortParam] then
      isInited[heroItemData.sortParam] = true
      local isdouble = heroItemData:GetIsHaveMultReward()
      self:InitDropFilterItem(heroItemData.sortParam, isdouble)
    end
  end
  self:InitDropFilterItem(0)
end

function UIPlotDungeon:__updateDailyChanceAndStrength()
  local leftNum, totaleLimit, playedNums = self.dungeonTypeData:GetDungeonTypePlayLeftLimitNum()
  self.ui.tex_LimitCount:SetIndex(0, tostring(leftNum), tostring(totaleLimit))
end

function UIPlotDungeon:__updateMultReward(dungeonData)
  if dungeonData:GetIsHaveMultReward() then
    if self.multRateBase == nil then
      self.multRateBase = UINDungeonMultRateBase.New()
      self.multRateBase:Init(self.ui.isDoubleOrDropUp)
    end
    self.multRateBase:Show()
    self.multRateBase:InitMultRate(dungeonData)
  elseif self.multRateBase ~= nil then
    self.multRateBase:Hide()
  else
    self.ui.isDoubleOrDropUp:SetActive(false)
  end
end

function UIPlotDungeon:__loadHeroDungeonList(selectItemIndex)
  self.heroItemList = HeroDungeonItemList.New()
  self.heroItemList:Init(self.ui.heroList)
  self.heroItemList:InjectDataAndFilterEvent(self.heroItemDataList)
  self.heroItemList:InjectItemInitEvent(BindCallback(self, self.__InitItem))
  self.heroItemList:InjectItemUpdateEvent(BindCallback(self, self.__UpdateDungeonItem))
  self.heroItemList:LoadItemList(selectItemIndex)
end

function UIPlotDungeon:__InitItem(go)
  local item = UIHeroDungeonItem.New()
  item:Init(go)
  local onclick = BindCallback(self, self.__onClickItem, go)
  item:InjectResLoaderAndClickEvent(self.resLoader, onclick)
  self.heroItemInsDict[go] = item
end

function UIPlotDungeon:__onClickItem(go)
  self:OnSelectItemEvent(go)
end

function UIPlotDungeon:__UpdateDungeonItem(go, index)
  local item = self.heroItemInsDict[go]
  local data = self.heroItemDataList[index + 1]
  if item ~= nil and data ~= nil then
    item:OnUpdateWithData(data)
    item.index = index + 1
    go.name = data.itemId
    if self.selectHeroId == data.itemId then
      self.selectHeroId = item.data.itemId
      self.selectItem = item
      self.selectItemIndex = item.index
      self.selectDungeonData = item.data
      self:__updateSelectHeroDisplay(item, go)
    elseif self.selectInsGo ~= nil and self.selectInsGo == go then
      self.ui.img_Select:SetActive(false)
    end
  end
end

function UIPlotDungeon:GetItemByIndex(index)
  local go = self.heroItemList.ui.loopList:GetCellByIndex(index)
  if go ~= nil then
    return self.heroItemInsDict[go]
  end
  return nil
end

function UIPlotDungeon:GetItemByHeroId(heroId)
  for index, dungeonData in ipairs(self.heroItemDataList) do
    if dungeonData.itemId == heroId then
      local index = index - 1
      return self:GetItemByIndex(index)
    end
  end
end

function UIPlotDungeon:OnSelectItemEvent(go)
  if self.heroItemInsDict == nil then
    return
  end
  local item = self.heroItemInsDict[go]
  if item == nil then
    return
  end
  self.selectHeroId = item.data.itemId
  self.selectItem = item
  self.selectItemIndex = item.index
  self.selectDungeonData = item.data
  self:__updateSelectHeroDisplay(item, go)
  AudioManager:PlayAudioById(1060)
end

function UIPlotDungeon:__updateSelectHeroDisplay(item, itemGo)
  if self.chaptersUI ~= nil and self.chaptersUI.isShowDetailRect then
    self.chaptersUI:OnShowDetailRectAndSetSelectChapter(false)
  end
  local dungeonData = item.data
  if self.selectHeroId == nil or dungeonData == nil then
    return
  end
  self.ui.tex_StoryName.text = LanguageUtil.GetLocaleText(ConfigData.friendship_hero[dungeonData.itemId].des_name)
  self.ui.tex_StoryDescr.text = LanguageUtil.GetLocaleText(ConfigData.friendship_hero[dungeonData.itemId].des_info)
  self.ui.img_Select.transform:SetParent(item.transform, false)
  self.ui.img_Select:SetActive(true)
  self.selectInsGo = itemGo
  self.objArm:InitPlotDungeonArm(dungeonData:GetDungeonHeroData(), self._OnClickSpecWeapon)
  if self.ui.heroHolder == nil then
    return
  end
  self:__loadBgImg(item)
  if self.__curBigImgRes == nil or self.__curBigImgRes ~= dungeonData:GetDungeonHeroData().resCfg.res_Name then
    if self.heroPrefabResloader ~= nil then
      self.heroPrefabResloader:Put2Pool()
    end
    self.heroPrefabResloader = cs_ResLoader.Create()
    DestroyUnityObject(self.bigImgGameObject)
    self.__curBigImgRes = dungeonData:GetDungeonHeroData().resCfg.res_Name
    self.heroPrefabResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(dungeonData:GetDungeonHeroData().resCfg.res_Name), function(prefab)
      if self.__curBigImgRes ~= dungeonData:GetDungeonHeroData().resCfg.res_Name then
        return
      end
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroDungeon")
    end)
  end
  self:__loadChapterUI(dungeonData)
  self:__updateMultReward(dungeonData)
  self:__loadFriendShip()
  self:__RefreshCurHeroFrage()
  self:__RefreshCurHeroStarAndFrag()
  self:__RefreshFavouriteIcon(self.selectHeroId)
  self.ui.storyDetailNode:SetActive(true)
end

function UIPlotDungeon:__loadAvgUI(dungeonData)
  local dungeonStoryList = ConfigData.friendship_hero[dungeonData.itemId].story_id
  if dungeonStoryList ~= nil and 0 < #dungeonStoryList then
    if self.storyItemPool == nil then
      self.storyItemPool = UIItemPool.New(HeroStoryItem, self.ui.storyItem)
    end
    self.storyItemPool:HideAll()
    for i = 1, #dungeonStoryList do
      local storyItem = self.storyItemPool:GetOne()
      local storyCfg = ConfigData.story_avg[dungeonStoryList[i]]
      if storyCfg ~= nil then
        storyItem:InitWithData(storyCfg)
      end
      if not storyItem.isUnlock then
        return
      end
    end
  end
end

function UIPlotDungeon:__loadChapterUI(dungeonData)
  if self.chaptersUI == nil then
    self.chaptersUI = UIHeroDungeonChapterList.New()
    self.chaptersUI:Init(self.ui.levelRewardNode)
  end
  if self.chaptersItemPool == nil or self.fstRewardItemPool == nil or self.mbRewardItemPool == nil then
    self.chaptersItemPool, self.fstRewardItemPool, self.mbRewardItemPool = self.chaptersUI:CreatePool(UIHeroChapterItem, RewardItem, RewardItem)
  end
  self.chaptersItemPool:HideAll()
  self.fstRewardItemPool:HideAll()
  self.mbRewardItemPool:HideAll()
  for index, dungeonStageData in ipairs(dungeonData:GetDungeonStageList()) do
    local item = self.chaptersItemPool:GetOne()
    item:InitWithStageData(dungeonStageData, index, self.fstRewardItemPool, self.mbRewardItemPool)
  end
  local stageNum = dungeonData:GetDungeonStageCount()
  if stageNum < 6 then
    for i = #dungeonData:GetDungeonStageList() + 1, 6 do
      local item = self.chaptersItemPool:GetOne()
      item:InitEmptyStageItem()
    end
  end
  self.chaptersUI:UpdateWithChapterList(self.chaptersItemPool.listItem, dungeonData, self.onBattleStart)
end

function UIPlotDungeon:__loadFriendShip()
  local isUnlcok = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  self.ui.btn_Friendship.gameObject:SetActive(isUnlcok)
  if not isUnlcok then
    return
  end
  local level = PlayerDataCenter.allFriendshipData:GetLevel(self.selectHeroId)
  if level < 10 then
    self.ui.tex_FriendshipLevel:SetIndex(0, "0", tostring(level))
  else
    self.ui.tex_FriendshipLevel:SetIndex(1, tostring(level))
  end
  self.dungeonTypeData:UpdateDungeonAndStageUnlock()
  self:__loadChapterUI(self.selectDungeonData)
  self:RefreshArmShow()
end

function UIPlotDungeon:__RefreshCurHeroFrage()
  local itemId = self.chaptersUI.selectChapterItem.cfg.first_reward_ids[1]
  if itemId == nil then
    return
  end
  local itemcfg = ConfigData.item[itemId]
  if itemcfg == nil then
    warn("itemcfg is Can't find,id:" .. tostring(itemId))
    return
  end
  local count = PlayerDataCenter:GetItemCount(itemId)
  self.curHeroChipItem:InitItemWithCount(itemcfg, count, nil)
end

function UIPlotDungeon:OnClickFriendship()
  if self.selectHeroId == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(win)
    if win ~= nil then
      local heroData = PlayerDataCenter.heroDic[self.selectHeroId]
      win:InitFriendshipSkillUpgrade(heroData, self.heroPrefabResloader, nil, self.m_ChangeHeroItem)
    end
  end)
end

function UIPlotDungeon:__RefreshCurHeroStarAndFrag(heroId)
  self:__RefreshCurHeroStar()
  self:__RefreshCurHeroFrag()
  self:__RefreshStarUpRedDot()
end

function UIPlotDungeon:__RefreshCurHeroStar()
  if self.selectHeroId == nil then
    return
  end
  local heroData = PlayerDataCenter.heroDic[self.selectHeroId]
  local rankCfg = ConfigData.hero_rank[heroData.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroData.rank))
  end
  self.curStarList:InitStarList(nil, rankCfg.star)
end

function UIPlotDungeon:__RefreshCurHeroFrag()
  if self.selectHeroId == nil then
    return
  end
  local heroData = PlayerDataCenter.heroDic[self.selectHeroId]
  local isFullRank = heroData:IsFullRank()
  self.ui.obj_Chip:SetActive(not isFullRank)
  self.ui.tex_ChipCount.gameObject:SetActive(not isFullRank)
  self.ui.obj_RankMax:SetActive(isFullRank)
  if not isFullRank then
    local fragCount = heroData:GetHeroFragCount()
    local needFrag = heroData:StarNeedFrag()
    self.ui.tex_ChipCount:SetIndex(0, tostring(fragCount or 0), tostring(needFrag or 0))
  end
  self:RefreshArmShow()
end

function UIPlotDungeon:__RefreshStarUpRedDot()
  local ok, heroStarUpNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.selectHeroId, RedDotStaticTypeId.HeroStarUp)
  self.ui.obj_StarUpRedDot:SetActive(ok and heroStarUpNode:GetRedDotCount() > 0)
end

function UIPlotDungeon:__RegisterStarUpRedDotEvent()
  function self.__onheroCardStarRedDotEvent(node)
    if self.selectHeroId ~= nil and self.selectHeroId == node:GetParentNodeId() then
      self.ui.obj_StarUpRedDot:SetActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
end

function UIPlotDungeon:OnClickStarUp()
  if self.selectHeroId == nil then
    return
  end
  local heroData = PlayerDataCenter.heroDic[self.selectHeroId]
  if heroData:IsFullRank() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUp, function(windows)
    if windows == nil then
      error("Can't open " .. self.heroId .. "'s starUP window")
      return
    end
    windows:InitHeroStarUp(self.resLoader, nil, self.m_ChangeHeroItem)
    windows:SwitchHero(heroData, self.heroPrefabResloader)
  end)
end

function UIPlotDungeon:OnClickFavouriteBtn()
  local curHeroId = self.selectHeroId
  local heroData = PlayerDataCenter.heroDic[curHeroId]
  local isFvourite = heroData:IsFavouriteHero()
  heroData:SetIsFavouriteHero(not isFvourite)
  self:__RefreshFavouriteIcon(curHeroId)
  local dungeonItem = self:GetItemByHeroId(curHeroId)
  if dungeonItem ~= nil then
    dungeonItem:RefreshIsFavourite()
  end
  NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_SUB_DUNGEON(curHeroId)
  self:SortShoewHeroItem(self.originItemDataList)
  self.heroItemDataList = {}
  if self.filterEvent ~= nil then
    for index, dungeonData in ipairs(self.originItemDataList) do
      if self.filterEvent(dungeonData.sortParam) then
        table.insert(self.heroItemDataList, dungeonData)
      end
      if dungeonData.itemId == curHeroId then
        self.selectItemIndex = #self.heroItemDataList
      end
    end
  else
    for index, dungeonData in ipairs(self.originItemDataList) do
      self.heroItemDataList[index] = dungeonData
      if dungeonData.itemId == curHeroId then
        self.selectItemIndex = index
      end
    end
  end
  self.heroItemList:ExecuteFilter(self.filterParamDict[self.filterParam], self.selectItemIndex)
end

function UIPlotDungeon:__RefreshFavouriteIcon(heroId)
  if self.selectHeroId ~= heroId then
    return
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData:IsFavouriteHero() then
    self.ui.tex_Favourite:SetIndex(0)
  else
    self.ui.tex_Favourite:SetIndex(1)
  end
end

function UIPlotDungeon:ChangeHeroItem(flag, callback)
  local nowIndex = self.selectItemIndex
  if 0 < flag then
    repeat
      nowIndex = nowIndex + 1
      if nowIndex > #self.heroItemDataList then
        nowIndex = 1
      end
    until self.heroItemDataList[nowIndex]:UnlockAndHasStageOpen()
  else
    repeat
      nowIndex = nowIndex - 1
      if nowIndex <= 0 then
        nowIndex = #self.heroItemDataList
      end
    until self.heroItemDataList[nowIndex]:UnlockAndHasStageOpen()
  end
  self.heroItemList:Roll2Index(nowIndex - 1, function()
    for go, item in pairs(self.heroItemInsDict) do
      if item.active and item.data == self.heroItemDataList[nowIndex] then
        self:__onClickItem(go)
        break
      end
    end
    if callback ~= nil then
      local heroData = PlayerDataCenter.heroDic[self.selectHeroId]
      callback(heroData, self.heroPrefabResloader)
    end
  end)
end

function UIPlotDungeon:OnBattleStart(autoBattleCount)
  self.selectChapterItem = self.chaptersUI.selectChapterItem
  local dungeonData = self.selectDungeonData
  local dungeonStageData = self.selectChapterItem.dungeonStageData
  if dungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  if dungeonData:GetDungeonPlayLeftLimitNum() == 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return
  end
  if dungeonStageData:GetIsReach2Limit() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return
  end
  for id, count in pairs(dungeonStageData:GetNormalCostItemDic()) do
    if id ~= ConstGlobalItem.SKey and count ~= nil and 0 < count then
      local itemNum = PlayerDataCenter:GetItemCount(id)
      if count > itemNum then
        cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Item_NotReach))
        return
      end
    end
  end
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFormationFunc()
    UIManager:HideWindow(UIWindowTypeID.FriendShipPlotDungeon)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  end
  
  local function exitFormationFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.FriendShipPlotDungeon)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
    end
  end
  
  local startBattleFunc
  
  function startBattleFunc(curSelectFormationData, callBack)
    local selectDungeonStageData
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      selectDungeonStageData = dungeonData:GetDungeonAutoBattleMaxStage()
    end
    if selectDungeonStageData == nil then
      selectDungeonStageData = dungeonStageData
    end
    if selectDungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      return
    end
    if PlayerDataCenter.stamina:GetCurrentStamina() < selectDungeonStageData:GetStaminaCost() then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFormationId(dungeonData:GetDungeonId4SaveFragFormation(), curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin, selectDungeonStageData, self.selectDungeonData)
    BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
    self.__startDungeonBattleTS = PlayerDataCenter.timestamp
    BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local lastPlayData = LastPlayData.New():SetLPDDngeonType(self.dungeonTypeData.dungeonType):SetLPDExtraData({
        lastSelectHeroId4LPDExtra = self.selectHeroId
      }):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
        local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
        if aftertTeatmentCtrl ~= nil then
          aftertTeatmentCtrl:TeatmentBengin()
        end
      end)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end, self.selectItemId))
    local interfaceData = DungeonInterfaceData.CreateDefaultBattleInterface()
    interfaceData:BindDungeonStageData(selectDungeonStageData, startBattleFunc)
    local firstPower, benchPower = fmtCtrl:CalculatePower(formationData)
    BattleDungeonManager:RequestEnterDungeon(selectDungeonStageData:GetDungeonStageId(), formationData, interfaceData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end, firstPower, benchPower)
  end
  
  local function realEnterFormationFunc()
    local forbidSupport = 0 < (autoBattleCount or 0)
    local selectDungeonStageData
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      selectDungeonStageData = dungeonData:GetDungeonAutoBattleMaxStage()
    end
    if selectDungeonStageData == nil then
      selectDungeonStageData = dungeonStageData
    end
    local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFormationId(dungeonData:GetDungeonId4SaveFragFormation())
    if 0 < (autoBattleCount or 0) then
      BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount)
    end
    fmtCtrl:ResetFmtCtrlState()
    fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.FriendshipDungeon, selectDungeonStageData:GetDungeonStageId(), lastFmtId):SetFmtCtrlCallback(enterFormationFunc, exitFormationFunc, startBattleFunc):SetEnterBattleCostTicketNum(self.selectChapterItem.costStrengthNum):SetFmtForbidSupport(forbidSupport)
    fmtCtrl:EnterFormation()
  end
  
  if dungeonStageData:GetDungeonStageIsCompleted() then
    local isNeedMoreFrage = dungeonStageData.dungeonData.heroData:GetMaxNeedFragNum(true) > 0
    if not isNeedMoreFrage then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.PlotDungeon_ReplayFullFrage), function()
        realEnterFormationFunc()
      end, nil)
      return
    end
    if dungeonStageData.dungeonData.itemId == 1001 then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.PlotDungeon_ReplayPersicaria), function()
        realEnterFormationFunc()
      end, nil)
      return
    end
  end
  realEnterFormationFunc()
end

function UIPlotDungeon:AfterBattleWin(dungenStageData, dungeonData, hasSupport)
  PlayerDataCenter:LocallyAddDungeonLimit(dungeonData:GetDungeonId(), dungenStageData:GetDungeonStageId(), hasSupport, self.__startDungeonBattleTS)
  dungeonData:CleanCacheData()
  dungeonData:CalUnLockedAndProgress()
end

function UIPlotDungeon:__loadBgImg(item)
  self.ui.img_StoryBg.texture = item.img_StoryBg
end

function UIPlotDungeon:__prepareHeroItemData()
  if self.selectHeroId == nil and #self.heroItemDataList > 0 then
    for index, dungeonData in ipairs(self.heroItemDataList) do
      if dungeonData:GetIsUnlock() then
        self.selectHeroId = dungeonData.itemId
        break
      end
    end
    if self.selectHeroId == nil then
      error("not handle no hero unlock condition")
    end
  end
  for index, v in ipairs(self.heroItemDataList) do
    if self.selectHeroId == v.itemId then
      self.selectItemIndex = index
    end
  end
  for index, dungeonData in ipairs(self.heroItemDataList) do
    if self.filterParamDict[dungeonData.sortParam] == nil then
      self.filterParamDict[dungeonData.sortParam] = 1
      local isdouble = dungeonData:GetIsHaveMultReward()
      self:InitDropFilterItem(dungeonData.sortParam, isdouble)
    else
      self.filterParamDict[dungeonData.sortParam] = self.filterParamDict[dungeonData.sortParam] + 1
    end
  end
  self.filterParamDict[0] = #self.heroItemDataList
  self:InitDropFilterItem(0)
end

function UIPlotDungeon:__dropCamList(isShow)
  if isShow ~= nil and isShow == false then
    self.ui.campList:SetActive(isShow)
    self.ui.img_Arrow.transform.localScale = Vector3.one
    return
  end
  local curActive = self.ui.campList.activeSelf
  self.ui.campList:SetActive(not curActive)
  if curActive then
    self.ui.img_Arrow.transform.localScale = Vector3.one
  else
    AudioManager:PlayAudioById(1069)
    self.ui.img_Arrow.transform.localScale = Vector3.New(1, -1, 1)
  end
end

function UIPlotDungeon:InitDropFilterItem(careerId, isDouble)
  local filterItem = self.campFilterItemPool:GetOne()
  filterItem:InitFWithData(careerId, isDouble, self._allTextContent)
  filterItem.clickEvent = self.onfilterItemClick
end

function UIPlotDungeon:OnClickFilterItem(campId, campText)
  self.ui.tex_CampName.text = campText
  self:__dropCamList(false)
  self.filterParam = campId
  if campId == 0 then
    AudioManager:PlayAudioById(4100)
  else
    local careerCfg = ConfigData.career[campId]
    AudioManager:PlayAudioById(careerCfg.click_audio)
  end
  if self.filterEvent ~= nil then
    self.heroItemDataList = {}
    for k, v in ipairs(self.originItemDataList) do
      if self.filterEvent(v.sortParam) then
        table.insert(self.heroItemDataList, v)
      end
    end
  end
  self.selectHeroId = nil
  for index, dungeonData in ipairs(self.heroItemDataList) do
    if dungeonData:GetIsUnlock() then
      self.selectHeroId = dungeonData.itemId
      break
    end
  end
  if self.selectHeroId == nil then
    error("not handle no hero unlock condition")
  end
  self.heroItemList:ExecuteFilter(self.filterParamDict[self.filterParam])
end

function UIPlotDungeon:RefreshArmShow()
  self.objArm:RefreshSpecWeaponState()
end

function UIPlotDungeon._OnClickSpecWeapon(heroData)
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(heroData.dataId)
  local weaponData = heroData:GetHeroDataSpecWeapon(weaponId)
  if weaponData == nil then
    return
  end
  if weaponData:IsSpecWeaponCouldUprage() then
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetSpeacWeaponLooked(weaponId)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SpecWeapon, function(win)
    if win == nil then
      return
    end
    win:InitUISpecWeapon(weaponData, heroData, function()
      local win = UIManager:GetWindow(UIWindowTypeID.FriendShipPlotDungeon)
      if win ~= nil and not win.active then
        win:RefreshArmShow()
        win:Show()
      end
    end)
    UIManager:HideWindow(UIWindowTypeID.FriendShipPlotDungeon)
  end)
end

function UIPlotDungeon:FilterItemAndUpdateList(itemSortParam)
  if self.filterParam == 0 then
    return true
  else
    return itemSortParam == self.filterParam
  end
end

function UIPlotDungeon:OnTimerUpdate()
  if self.multRateBase ~= nil and self.multRateBase.active then
    self.multRateBase:UpdateLeftTime()
  end
end

function UIPlotDungeon:__onBack(toHome)
  if self.onBackCallback ~= nil then
    self.onBackCallback(toHome)
  end
  base.Delete(self)
end

function UIPlotDungeon:OnDelete()
  if self.__DungeonTimerId ~= nil then
    TimerManager:StopTimer(self.__DungeonTimerId)
    self.__DungeonTimerId = nil
  end
  if self.heroPrefabResloader ~= nil then
    self.heroPrefabResloader:Put2Pool()
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
  end
  if self.chaptersUI ~= nil then
    self.chaptersUI:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__reloadFriendShip)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroRankChange, self.__refreshHeroRank)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshCostNode)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  base.OnDelete(self)
end

return UIPlotDungeon
