local AllSkinData = class("AllSkinData")
local SkinEnum = require("Game.Skin.SkinEnum")
local CS_ResManagerIns = CS.ResManager.Instance
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function AllSkinData:ctor()
  self.skinDic = {}
  self.flatSkinDic = {}
  self.L2dHideDic = {}
  self._skinUpgradeDic = {}
  self.l2dOpenSfxDic = {}
  self.limitTimeSkinDic = {}
  self.outlineColor = Color.New(0, 0, 0, 0.6)
end

function AllSkinData:UpdateData(data)
  for heroId, v in pairs(data) do
    self.skinDic[heroId] = v.unlockSkin
    for skinId, _ in pairs(v.unlockSkin) do
      self.flatSkinDic[skinId] = true
    end
    for key, skinId in pairs(v.L2DHide) do
      self:UpdateHideL2dBg(heroId, skinId, true)
    end
    if v.infos ~= nil then
      for skinId, skinInfo in pairs(v.infos) do
        self:UpdateOpenLive2dSfx(skinId, skinInfo.L2DAudioOff)
        self._skinUpgradeDic[skinId] = skinInfo.levelUp
        if skinInfo.expireTime > 0 or self.limitTimeSkinDic[skinId] and 0 < self.limitTimeSkinDic[skinId] then
          self.limitTimeSkinDic[skinId] = skinInfo.expireTime
        end
      end
    end
  end
  for skinId, v in pairs(self.limitTimeSkinDic) do
    if self.flatSkinDic[skinId] then
      do
        self.limitTimeSkinDic[skinId] = nil
        local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
        skinCtrl:SkinLimitEnd(skinId)
      end
    elseif v < PlayerDataCenter.timestamp then
      local heroId = self:GetHeroIdBySkinId(skinId)
      local changeSkin = ConfigData.hero_data[heroId].default_skin
      if PlayerDataCenter:ContainsHeroData(heroId) then
        local heroData = PlayerDataCenter:GetHeroData(heroId)
        changeSkin = heroData.skinId
      end
      MsgCenter:Broadcast(eMsgEventId.HeroSkinLimitTimeOut, heroId, changeSkin)
      local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
      skinCtrl:SkinLimitTimeOut(skinId)
      self.limitTimeSkinDic[skinId] = nil
    end
  end
end

function AllSkinData:UpdateHeroDefaultSkin(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  if self.skinDic[heroId] == nil then
    self.skinDic[heroId] = {}
  end
  local defaultSkinId = heroCfg.default_skin
  self.skinDic[heroId][defaultSkinId] = true
  self.flatSkinDic[defaultSkinId] = true
end

function AllSkinData:GetHeroIdBySkinId(skinId)
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local heroId = skinCtrl:GetHeroId(skinId)
  return heroId
end

function AllSkinData:IsSkinUnlocked(skinId)
  if (skinId or 0) == 0 then
    warn("skin \"0\" is out of data, pls update it to real skin id!")
    return true
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    return true
  end
  if skinCfg.skin_locked then
    return false
  end
  return true
end

function AllSkinData:IsHaveSkin(skinId)
  return self:IsHaveSkinLimit(skinId) or self:IsHaveSkinPermanent(skinId)
end

function AllSkinData:IsHaveSkinLimit(skinId)
  if (skinId or 0) == 0 then
    warn("skin \"0\" is out of data, pls update it to real skin id!")
    return false
  end
  if not self:IsSkinUnlocked(skinId) then
    return false
  end
  if self.limitTimeSkinDic[skinId] then
    return 0 < self.limitTimeSkinDic[skinId]
  end
  return false
end

function AllSkinData:IsHaveSkinPermanent(skinId)
  if (skinId or 0) == 0 then
    warn("skin \"0\" is out of data, pls update it to real skin id!")
    return true
  end
  if not self:IsSkinUnlocked(skinId) then
    return false
  end
  return self.flatSkinDic[skinId]
end

function AllSkinData:GetSkinLimitTime(skinId)
  if not self:IsHaveSkinLimit(skinId) then
    return nil
  end
  return self.limitTimeSkinDic[skinId]
end

function AllSkinData:RecordLive2dSwitchState(heroId, skinId, isOpen)
  if self.live2dSwitchDic == nil then
    if isOpen then
      return
    end
    self.live2dSwitchDic = {}
  end
  if self.live2dSwitchDic[heroId] == nil then
    if isOpen then
      return
    end
    self.live2dSwitchDic[heroId] = {}
  end
  if isOpen then
    self.live2dSwitchDic[heroId][skinId] = nil
  else
    self.live2dSwitchDic[heroId][skinId] = true
  end
  MsgCenter:Broadcast(eMsgEventId.OnHeroLive2dChange, heroId, skinId, isOpen)
end

function AllSkinData:GetLive2dSwitchState(heroId, skinId)
  if not skinId or skinId == 0 then
    skinId = ConfigData.hero_data[heroId].default_skin
  end
  if self.live2dSwitchDic == nil then
    return true
  end
  if self.live2dSwitchDic[heroId] == nil then
    return true
  end
  return self.live2dSwitchDic[heroId][skinId] == nil
end

function AllSkinData:UpdateHideL2dBg(heroId, skinId, isHide)
  self.L2dHideDic[skinId] = isHide
end

function AllSkinData:GetHideL2dDic()
  return self.L2dHideDic
end

function AllSkinData:IsHideL2dBg(skinId)
  if not self:IsHaveSkin(skinId) then
    return false
  end
  if self.L2dHideDic[skinId] == nil then
    return false
  end
  return self.L2dHideDic[skinId]
end

function AllSkinData:IsHideHolight(skinId)
  if self:IsHaveSkin(skinId) then
    return true
  end
  return false
end

function AllSkinData:UpdateOpenLive2dSfx(skinId, isClose)
  if self.l2dOpenSfxDic == nil then
    self.l2dOpenSfxDic = {}
  end
  self.l2dOpenSfxDic[skinId] = isClose
end

function AllSkinData:GetL2dOpenSfxDic()
  return self.l2dOpenSfxDic
end

function AllSkinData:IsCloseLive2dSfx(skinId)
  if not self:IsHaveSkin(skinId) then
    return false
  end
  if self.l2dOpenSfxDic[skinId] == nil then
    return false
  end
  return self.l2dOpenSfxDic[skinId]
end

function AllSkinData:IsHaveL2d(skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg ~= nil then
    return self:GetSkinLive2dLevel(skinId) > 0
  end
  return false
end

function AllSkinData:GetSkinLive2dLevel(skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("Cant get skin cfg, skinId:" .. tostring(skinId))
    return 0
  end
  if skinCfg.upgrade_use then
    if self:IsHaveSkinLimit(skinId) then
      return 2
    end
    return self:IsSkinUpgrageEnd(skinId) and 2 or 0
  end
  return skinCfg.live2d_level
end

function AllSkinData:IsSkinUpgrageOpen(skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("Cant get skin cfg, skinId:" .. tostring(skinId))
    return false
  end
  return not table.IsEmptyTable(skinCfg.upgrade_cost)
end

function AllSkinData:IsSkinUpgrageEnd(skinId)
  return self._skinUpgradeDic[skinId] and self._skinUpgradeDic[skinId] > 0
end

function AllSkinData:IsSkinUpgrageOpenAndNotUpgradeEnd(skinId)
  return self:IsSkinUpgrageOpen(skinId) and not self:IsSkinUpgrageEnd(skinId)
end

function AllSkinData:IsSkinCanUpgrade(skinId)
  if not self:IsSkinUpgrageOpen(skinId) then
    return false
  end
  local skinCfg = ConfigData.skin[skinId]
  if self:IsSkinUpgrageEnd(skinId) then
    return false
  end
  local haveSkin = self:IsHaveSkinPermanent(skinId)
  return haveSkin or self:UnlockSkinBattlePass(skinCfg)
end

function AllSkinData:UnlockSkinBattlePass(skinCfg)
  local conditionShopParam = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active]
  if conditionShopParam == nil then
    return false
  end
  local activityCfg = ConfigData.activity[conditionShopParam[1]]
  if activityCfg == nil then
    return
  end
  local eActivityType = require("Game.ActivityFrame.ActivityFrameEnum").eActivityType
  if eActivityType.BattlePass ~= activityCfg.type then
    return false
  end
  local bpData = PlayerDataCenter.battlepassData:GetBattlePassByActId(activityCfg.activity_id)
  return bpData and bpData.unlockSenior
end

function AllSkinData:GetSkinUpgradeCost(skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("Cant get skin cfg, skinId:" .. tostring(skinId))
    return
  end
  for itemId, itemNum in pairs(skinCfg.upgrade_cost) do
    return itemId, itemNum
  end
end

function AllSkinData:UpdSkinUpgrade(skinId)
  self._skinUpgradeDic[skinId] = 1
end

function AllSkinData:IsInSkinUpgradeTimeRange(skinId)
  local skinCfg = ConfigData.skin[skinId]
  return CheckCondition.CheckLua(skinCfg.pre_condition, skinCfg.pre_para1, skinCfg.pre_para2)
end

function AllSkinData:GetSkinUpgradeLimitTime(skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("Cant get skin cfg, skinId:" .. tostring(skinId))
    return
  end
  if CheckCondition.CheckLua(skinCfg.pre_condition, skinCfg.pre_para1, skinCfg.pre_para2) then
    for index, condition in ipairs(skinCfg.pre_condition) do
      if condition == CheckerTypeId.TimeRange then
        local endTime = skinCfg.pre_para2[index]
        local diffTime = math.floor(endTime - PlayerDataCenter.timestamp)
        if 0 < diffTime then
          local day, hour, minute = TimeUtil:TimestampToTimeInter(diffTime, false, true)
          return day, hour, minute
        end
      end
    end
  end
  return -1, -1, -1
end

function AllSkinData:IsShowSkinOutline(skinId, fromWhere, callback)
  if not ConfigData.game_config.IsUsingSkinRecitify then
    callback(false)
    return
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    callback(false)
    return
  end
  if fromWhere == nil then
    fromWhere = SkinEnum.fromWhere.normalUI
  end
  if fromWhere == SkinEnum.fromWhere.heroInfoAndHandbook or fromWhere == SkinEnum.fromWhere.bp or fromWhere == SkinEnum.fromWhere.shopOrGift or fromWhere == SkinEnum.fromWhere.adjutant then
    if self:IsHaveSkin(skinId) then
      callback(false)
      return
    else
      self:JudgeIsSkinFitConditon(skinId, function(bool)
        callback(not bool)
      end)
      return
    end
  else
    callback(not self:IsHaveSkin(skinId))
    return
  end
  callback(false)
  return
end

function AllSkinData:GetSkinOutlineRes(dataId, type)
  local heroId, skinId
  if type == SkinEnum.getOutLineResType.resName then
    skinId = ConfigData.skin.skinRes2SkinId[dataId]
    if skinId == nil then
      return nil
    end
  end
  if type == SkinEnum.getOutLineResType.skinId then
    skinId = dataId
  end
  if skinId ~= nil then
    local skinCfg = ConfigData.skin[skinId]
    if skinCfg == nil then
      return nil
    end
    heroId = skinCfg.heroId
  elseif type == SkinEnum.getOutLineResType.resName then
    heroId = dataId
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    return nil
  end
  local targetSkinId = heroCfg.default_skin
  local targetSkinCfg = ConfigData.skin[targetSkinId]
  local skinRes = targetSkinCfg.src_id_pic
  return skinRes
end

function AllSkinData:RecitifySkinRes(skinRes, fromWhere, getRealPathFunc)
  if not ConfigData.game_config.IsUsingSkinRecitify then
    return skinRes
  end
  local skinId = ConfigData.skin.skinRes2SkinId[skinRes]
  if skinId == nil then
    return skinRes
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    return skinRes
  end
  if fromWhere == nil then
    fromWhere = SkinEnum.fromWhere.normalUI
  end
  
  local function CheckHasRes(name)
    if getRealPathFunc ~= nil then
      local path = getRealPathFunc(name)
      return CS_ResManagerIns:ContainsAsset(path)
    end
  end
  
  if fromWhere == SkinEnum.fromWhere.normalUI then
    if not string.IsNullOrEmpty(skinCfg.src_id_pic_rectify) and CheckHasRes(skinCfg.src_id_pic_rectify) then
      return skinCfg.src_id_pic_rectify
    end
  elseif self:IsHaveSkin(skinId) or fromWhere == SkinEnum.fromWhere.heroVow then
    return skinRes
  elseif not string.IsNullOrEmpty(skinCfg.src_id_pic_rectify) and CheckHasRes(skinCfg.src_id_pic_rectify) then
    return skinCfg.src_id_pic_rectify
  end
  return skinRes
end

function AllSkinData:DealNotSelfHaveHeroSkinOverraid(skinId, heroId)
  if not ConfigData.game_config.IsUsingSkinRecitify or self.flatSkinDic[skinId] ~= nil then
    return skinId
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if skinId == 0 then
    skinId = heroCfg.default_skin
  end
  
  local function GetNextLevelSkin(theSkinId, isInit)
    if theSkinId == nil then
      return nil
    end
    local skinCfg = ConfigData.skin[theSkinId]
    if skinCfg == nil then
      return nil
    end
    if not skinCfg.rectify_skin or self.flatSkinDic[skinId] ~= nil then
      return theSkinId
    end
    if skinCfg.theme < 1 or skinCfg.theme > 3 then
      if isInit then
        theSkinId = heroCfg.default_skin
      else
        return nil
      end
    else
      local targetTheme = skinCfg.theme + 1
      theSkinId = nil
      for _, id in ipairs(heroCfg.skin) do
        local tempSkinCfg = ConfigData.skin[id]
        if tempSkinCfg.theme == targetTheme then
          theSkinId = id
          break
        end
      end
    end
    return GetNextLevelSkin(theSkinId, false)
  end
  
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg.rectify_skin then
    skinId = heroCfg.default_skin
    skinId = GetNextLevelSkin(skinId, true)
  end
  return skinId
end

function AllSkinData:JudgeIsSkinFitConditon(skinId, resultCallback)
  if resultCallback == nil then
    return
  end
  if ConfigData.game_config.isShadowAllSkin then
    resultCallback(false)
    return
  end
  local skinCfg = ConfigData.skin[skinId]
  if table.count(skinCfg.conditionParamDic) == 0 then
    resultCallback(false)
    return
  end
  local order = {
    proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active,
    proto_csmsg_SystemFunctionID.SystemFunctionID_Gift,
    proto_csmsg_SystemFunctionID.SystemFunctionID_Store
  }
  local isHaveShop = false
  for _, type in ipairs(order) do
    local param = skinCfg.conditionParamDic[type]
    if type == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active then
      local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
      local curBPActDataDic = actFrameCtr:GetShowByActType(ActivityFrameEnum.eActivityType.BattlePass)
      for actframeId, _ in pairs(curBPActDataDic) do
        local actData = actFrameCtr:GetActivityFrameData(actframeId)
        local actId = actData:GetActId()
        local passInfo = PlayerDataCenter.battlepassData.passInfos[actId]
        if passInfo ~= nil and passInfo:IsResidentBP() and ConfigData.battlepass_skin[ConfigData.buildinConfig.RadioChoiceBpShowId][skinCfg.id] ~= nil then
          if param == nil then
            param = {actframeId}
          else
            table.insert(param, actframeId)
          end
        end
      end
    end
    if param ~= nil then
      if type == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active then
        local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        if actFrameCtr == nil then
          resultCallback(false)
          return
        end
        for i, v in ipairs(param) do
          local actData = actFrameCtr:GetActivityFrameData(v)
          if actData ~= nil and actData:IsActivityOpen() then
            resultCallback(true)
            return
          end
        end
      elseif type == proto_csmsg_SystemFunctionID.SystemFunctionID_Gift then
        if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Gift) then
          resultCallback(false)
          return
        end
        local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
        if payGiftCtrl == nil then
          resultCallback(false)
          return
        end
        for _, giftId in ipairs(param) do
          local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
          if giftInfo ~= nil and giftInfo:IsUnlock() then
            resultCallback(true)
            return
          end
        end
      elseif type == proto_csmsg_SystemFunctionID.SystemFunctionID_Store then
        if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) then
          resultCallback(false)
          return
        end
        local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        local waitNum = #param
        local isHaveOne = false
        isHaveShop = true
        for i, shopId in ipairs(param) do
          shopCtrl:GetShopData(shopId, function(shopData)
            local goodsData = shopData ~= nil and shopData:GetShopGoodDataByItemId(skinCfg.id, true) or nil
            if goodsData ~= nil then
              local isLimitTime, isInTime = goodsData:GetStillTime()
              if (not isLimitTime or isInTime) and not isHaveOne then
                isHaveOne = true
                resultCallback(true)
              end
            end
            waitNum = waitNum - 1
            if waitNum <= 0 and not isHaveOne then
              resultCallback(false)
            end
          end)
        end
      end
    end
  end
  if not isHaveShop then
    resultCallback(false)
  end
end

function AllSkinData:IsSkinL2dCouldShow(skinId)
  local live2dConfig = ConfigData.skin_live2d[skinId]
  if live2dConfig == nil or live2dConfig.rectify_l2d and ConfigData.game_config.IsUsingSkinRecitify then
    return false
  end
  return true
end

return AllSkinData
