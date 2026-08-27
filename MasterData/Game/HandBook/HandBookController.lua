local HandBookController = class("HandBookController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local HandBookEnum = require("Game.HandBook.HandBookEnum")
local ShopUtil = require("Game.Shop.ShopUtil")
local __isSendingSingle = false
local __singleQueue = {}

local function SendSingle(callback)
  if __isSendingSingle then
    table.insert(__singleQueue, callback)
    return
  else
    __isSendingSingle = true
    if callback ~= nil then
      callback()
    end
  end
end

local function SendSingleOver()
  __isSendingSingle = false
  if 0 < #__singleQueue then
    local callback = __singleQueue[1]
    table.remove(__singleQueue, 1)
    callback()
  end
end

function HandBookController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.hero_relationship)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_collect_collect_theme)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_collect_collect_reward)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_collect_card_main)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_room_group)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_card_star)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_card_main)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_label)
  ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary24_talk_surprise)
  self.__collectNumDic = {}
  self.__viewLayerList = {}
  self._skinThemeNumDic = {}
  self.__PreconditionCallback = BindCallback(self, self.__Precondition)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__PreconditionCallback)
  self.__onHeroSkinChange = BindCallback(self, self.__OnHeroSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__onHeroSkinChange)
  self.__onHeroUpdate = BindCallback(self, self.__OnHeroUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onHeroUpdate)
  self.__SkinUpdateCallback = BindCallback(self, self.__SkinUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.__SkinUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__onHeroSkinChange)
  self._whiteHistoryMsgDic = {}
  self:ReqActivityAnniv24LastHistoryData()
end

function HandBookController:CalCampHeroCollectNum(forceRecal)
  if not forceRecal and not table.IsEmptyTable(self.__collectNumDic) then
    return
  end
  for campId, _ in pairs(ConfigData.camp) do
    local num = 0
    local hideNum = 0
    for _, heroId in pairs(ConfigData.camp.camp2HeroListDic[campId]) do
      local heroCfg = ConfigData.hero_data[heroId]
      if PlayerDataCenter.heroDic[heroId] ~= nil then
        num = num + 1
        if heroCfg.collection_exclude then
          hideNum = hideNum + 1
        end
      end
    end
    self.__collectNumDic[campId] = num
    self.__collectNumDic[0] = (self.__collectNumDic[0] or 0) + num - hideNum
  end
end

function HandBookController:CalSkinThemeCollectNum(forceRecal)
  if not forceRecal and not table.IsEmptyTable(self._skinThemeNumDic) then
    return
  end
  self._skinThemeNumDic.total = 0
  for themeId, skinList in pairs(ConfigData.skin.themeDic) do
    local themeCfg = ConfigData.skinTheme[themeId]
    if not themeCfg.lock_theme then
      local num = 0
      for _, skinId in ipairs(skinList) do
        if PlayerDataCenter.skinData:IsHaveSkin(skinId) then
          num = num + 1
        end
      end
      self._skinThemeNumDic[themeId] = num
      self._skinThemeNumDic.total = self._skinThemeNumDic.total + num
    end
  end
end

function HandBookController:__SkinUpdate()
  self:CalSkinThemeCollectNum(true)
  local hbSkinListWin = UIManager:GetWindow(UIWindowTypeID.HandBookSkinList)
  if hbSkinListWin ~= nil then
    hbSkinListWin:HBSkinUpdate()
  end
  local mianUI = UIManager:GetWindow(UIWindowTypeID.HandBookMain)
  if mianUI ~= nil then
    mianUI:RefreshHBCollectByType(HandBookEnum.eEnterType.Skin)
  end
end

function HandBookController:OpenHandBookMain(where, openCallback)
  self:CalCampHeroCollectNum()
  self:CalSkinThemeCollectNum()
  UIManager:ShowWindowAsync(UIWindowTypeID.HandBookBackground, function(bg_win)
    self:SetHBViewSetLayer(0)
    UIManager:ShowWindowAsync(UIWindowTypeID.HandBookMain, function(win)
      win:InitHandBookMain()
      win:SetFromWhichUI(where)
      bg_win:HBBGPalyerEnterTween()
      if openCallback ~= nil then
        openCallback()
      end
    end)
  end)
end

function HandBookController:HandleHandBookJumpArg(targetType, targetSubType)
  if targetType == nil then
    return
  elseif targetType == HandBookEnum.eEnterType.Activity then
    self:OpenHandBookActivity(Vector3.zero)
  elseif targetType == HandBookEnum.eEnterType.Hero then
    self:OpenHandBookHeroIndex()
  elseif targetType == HandBookEnum.eEnterType.Skin then
    self:OpenHandBookHeroSkinTheme()
    if targetSubType ~= nil then
      print("--TODO 适配具体的主题")
    end
  end
end

function HandBookController:OpenHandBookHeroIndex()
  UIManager:ShowWindowAsync(UIWindowTypeID.HandBookHeroCampIndex, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.HandBookMain)
    win:InitHBHeroCampIndex(function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookMain)
      self:SetHBViewSetLayer(0)
    end)
    self:SetHBViewSetLayer(1, ConfigData:GetTipContent(8302))
  end)
end

function HandBookController:OpenHandBookHeroSkinTheme()
  self:__GetShopInfo(function(sellSkinShopList)
    UIManager:ShowWindowAsync(UIWindowTypeID.HandBookSkinList, function(win)
      if IsNull(win) then
        return
      end
      UIManager:HideWindow(UIWindowTypeID.HandBookMain)
      win:InitHBHeroSkinTheme(sellSkinShopList, function()
        UIManager:ShowWindowOnly(UIWindowTypeID.HandBookMain)
        self:SetHBViewSetLayer(0)
      end)
      self:SetHBViewSetLayer(1, LanguageUtil.GetLocaleText(ConfigData.handbook[HandBookEnum.eEnterType.Skin].title))
    end)
  end)
end

function HandBookController:OpenHandBookActivity(worldPos)
  UIManager:ShowWindowAsync(UIWindowTypeID.HandBookActBook, function(win)
    if IsNull(win) then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.HandBookMain)
    win:InitHandBookActBook(worldPos, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookMain)
      self:SetHBViewSetLayer(0)
    end)
    self:SetHBViewSetLayer(1, LanguageUtil.GetLocaleText(ConfigData.handbook[HandBookEnum.eEnterType.Activity].title))
  end)
end

function HandBookController:OpenHandBookCard()
  UIManager:ShowWindowAsync(UIWindowTypeID.HandBookCardMain, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.HandBookMain)
    win:InitHBCardMain(function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookMain)
      self:SetHBViewSetLayer(0)
    end)
    self:SetHBViewSetLayer(1, ConfigData:GetTipContent(8302))
  end)
end

function HandBookController:__GetShopInfo(callback)
  if callback == nil then
    return
  end
  local needReqShopIds = ShopUtil.GetSkinShopIdList()
  local sellSkinShopList = {}
  if 0 < #needReqShopIds then
    self:__ReqShop(1, needReqShopIds, sellSkinShopList, callback)
  else
    callback(sellSkinShopList)
  end
end

function HandBookController:__ReqShop(index, needReqShopIds, sellSkinShopList, callback)
  local shopCtr = ControllerManager:GetController(ControllerTypeId.Shop)
  local shopId = needReqShopIds[index]
  shopCtr:GetShopData(shopId, function(shopData)
    table.insert(sellSkinShopList, shopData)
    if index >= #needReqShopIds then
      callback(sellSkinShopList)
    else
      self:__ReqShop(index + 1, needReqShopIds, sellSkinShopList, callback)
    end
  end)
end

function HandBookController:GetHBHeroAllCollect()
  return self.__collectNumDic[0], ConfigData.hero_data.totalShowHeroCount
end

function HandBookController:GetHBSkinAllCollect()
  return self._skinThemeNumDic.total, ConfigData.skin.hbSkinCount
end

function HandBookController:GetCampHeroCollectRate(campId)
  return (self.__collectNumDic[campId] or 0) / (ConfigData.camp.camp2HeroNumDic[campId] or 1)
end

function HandBookController:GetCampHeroCollectNum(campId)
  return self.__collectNumDic[campId] or 0, ConfigData.camp.camp2HeroNumDic[campId] or 0
end

function HandBookController:GetSkinThemeCollectNum(themeId)
  return self._skinThemeNumDic[themeId] or 0
end

function HandBookController:GetHBCardAllCollect()
  local collectCfgList = ConfigData.reinforce_collect_card_main
  local collectCfg = collectCfgList[1]
  local star_score1 = collectCfg.star_score1
  local star_score2 = collectCfg.star_score2
  local star_score3 = collectCfg.star_score3
  local cardTable = self.cardHistoryData or {}
  local cardIdListDic = ConfigData.reinforce_card_card_main.packGroup[59001]
  local totalCount = 0
  local count = 0
  for collect_theme, cardIdList in pairs(cardIdListDic) do
    if 0 < collect_theme then
      for _, cardId in ipairs(cardIdList) do
        totalCount = totalCount + star_score3
        local msgCardData = cardTable[cardId]
        if msgCardData ~= nil then
          local star = msgCardData.star
          if star == 1 then
            count = count + star_score1
          elseif star == 2 then
            count = count + star_score2
          elseif star == 3 then
            count = count + star_score3
          end
        end
      end
    end
  end
  local process = 0
  if totalCount ~= 0 then
    process = count / (totalCount or 1)
  end
  process = math.clamp(process, 0, 1)
  return process
end

function HandBookController:SetHBViewSetLayer(layer, name)
  if name ~= nil then
    self.__viewLayerList[layer] = name
  end
  local bgWin = UIManager:GetWindow(UIWindowTypeID.HandBookBackground)
  if bgWin ~= nil then
    if layer <= 0 then
      bgWin:ShowHBBGSetTop(false)
      bgWin:ShowHBBGTime(true)
      return
    end
    bgWin:ShowHBBGSetTop(true)
    bgWin:ShowHBBGTime(false)
    local index = layer - 1
    bgWin:HBBGSetTop(index, self.__viewLayerList)
  end
end

function HandBookController:__OnHeroSkinChange(heroId, skinId)
  local listWin = UIManager:GetWindow(UIWindowTypeID.HandBookHeroCampHeroList)
  local relationWin = UIManager:GetWindow(UIWindowTypeID.HandbookHeroRelation)
  if listWin ~= nil then
    listWin:HBHLOnHeroSkinChange(heroId)
  end
  if relationWin ~= nil then
    relationWin:HBHROnHeroSkinChange(heroId)
  end
end

function HandBookController:__OnHeroUpdate(heroUpdateDic, hasNew)
  if not hasNew then
    return
  end
  self:CalCampHeroCollectNum(true)
  local indexWin = UIManager:GetWindow(UIWindowTypeID.HandBookHeroCampIndex)
  local listWin = UIManager:GetWindow(UIWindowTypeID.HandBookHeroCampHeroList)
  if indexWin ~= nil then
    indexWin:HBCIRefreshCollectRate()
  end
  if listWin ~= nil then
    listWin:RefreshHeroCollect()
  end
  local mianUI = UIManager:GetWindow(UIWindowTypeID.HandBookMain)
  if mianUI ~= nil then
    mianUI:RefreshHBCollectByType(HandBookEnum.eEnterType.Hero)
  end
end

function HandBookController:__Precondition()
  local mianUI = UIManager:GetWindow(UIWindowTypeID.HandBookMain)
  if mianUI ~= nil then
    mianUI:CheckAndRefreshCollect()
  end
end

function HandBookController:ReqWhiteHistoryData(actId, callback)
  if self._whiteHistoryMsgDic[actId] ~= nil then
    if callback ~= nil then
      callback(self._whiteHistoryMsgDic[actId])
    end
    return
  end
  SendSingle(function()
    local whiteDayNetWork = NetworkManager:GetNetwork(NetworkTypeID.WhiteDay)
    whiteDayNetWork:CS_Activity_Polariod_History(actId, function(args)
      if args.Count == 0 then
        error("args.Count == 0")
        return
      end
      local activityPolariodData = args[0]
      self._whiteHistoryMsgDic[actId] = activityPolariodData
      if callback ~= nil then
        callback(activityPolariodData)
      end
      SendSingleOver()
    end)
  end)
end

function HandBookController:ReqActivityAnniv24LastHistoryData()
  if self.cardHistoryData ~= nil then
    return
  end
  SendSingle(function()
    local reinforceNetWork = NetworkManager:GetNetwork(NetworkTypeID.Reinforce)
    reinforceNetWork:CS_ActivityAnniv24_LastHistoryData(function(args)
      if args.Count == 0 then
        error("args.Count == 0")
        return
      end
      self.cardHistoryData = args[0].cards
      local mianUI = UIManager:GetWindow(UIWindowTypeID.HandBookMain)
      if mianUI ~= nil then
        mianUI:__RefreshHBMainCard()
      end
      SendSingleOver()
    end)
  end)
end

function HandBookController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.hero_relationship)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_collect_collect_theme)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_collect_collect_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_room_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_card_star)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_card_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_label)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary24_talk_surprise)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_collect_card_main)
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__PreconditionCallback)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__onHeroSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__onHeroUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.__SkinUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__onHeroSkinChange)
end

return HandBookController
