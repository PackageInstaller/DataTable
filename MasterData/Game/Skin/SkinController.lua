local SkinController = class("SkinController", ControllerBase)
local base = ControllerBase
local SkinConditionFunc = require("Game.Skin.SkinConditionFunc")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local cs_MessageCommon = CS.MessageCommon

function SkinController:GetHeroId(skinId)
  local cfg = ConfigData.skin[skinId]
  if cfg == nil then
    return nil
  end
  return cfg.heroId
end

function SkinController:GetResModel(heroId, skinId)
  local heroCfg = ConfigData.hero_data[heroId]
  local cfg
  if heroCfg ~= nil then
    cfg = ConfigData.resource_model[heroCfg.src_id]
  else
    error("hero_data is NULL  id:" .. tostring(heroId))
    return
  end
  if cfg == nil then
    error("resource_model is NULL  id:" .. tostring(heroCfg.src_id))
    return
  end
  return self:UpdateResModel(cfg, skinId)
end

function SkinController:UpdateResModel(resmodelCfg, skinId)
  local cfg = setmetatable({}, {__index = resmodelCfg})
  local skinCfg
  if (skinId or 0) ~= 0 then
    skinCfg = ConfigData.skin[skinId]
  end
  if skinCfg == nil or skinCfg.skin_locked then
    cfg.src_id_pic = resmodelCfg.res_Name
    cfg.src_id_model = resmodelCfg.res_Name
  else
    cfg.src_id_pic = string.IsNullOrEmpty(skinCfg.src_id_pic) and resmodelCfg.res_Name or skinCfg.src_id_pic
    cfg.src_id_model = string.IsNullOrEmpty(skinCfg.src_id_model) and resmodelCfg.res_Name or skinCfg.src_id_model
  end
  return cfg
end

function SkinController:CheckSourceValid(skinId)
  if skinId == nil or not PlayerDataCenter.skinData:IsSkinUnlocked(skinId) then
    return false, nil
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    return false, nil
  end
  for _, condition in ipairs(skinCfg.conditions) do
    local func = SkinConditionFunc[condition]
    if func ~= nil and func(skinCfg, self) then
      return true, condition
    end
  end
  return false, skinCfg.conditions[1]
end

function SkinController:CanHideLive2dBg(skinId)
  local skinCfg = ConfigData.skin_live2d[skinId]
  if skinCfg ~= nil then
    return skinCfg.is_open_hide_bg
  end
  return false
end

function SkinController:CanCloseLive2dSfx(skinId)
  local skinCfg = ConfigData.skin_live2d[skinId]
  if skinCfg ~= nil then
    return skinCfg.is_has_l2d_sfx
  end
  return false
end

function SkinController:IsHaveVoice(skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg ~= nil then
    return skinCfg.has_voice
  end
  return false
end

function SkinController:GetAllSourceValid(skinId)
  if skinId == nil or not PlayerDataCenter.skinData:IsSkinUnlocked(skinId) then
    return table.emptytable
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    return table.emptytable
  end
  local list
  for _, condition in ipairs(skinCfg.conditions) do
    local func = SkinConditionFunc[condition]
    if func ~= nil and func(skinCfg, self) then
      if list == nil then
        list = {}
      end
      table.insert(list, condition)
    end
  end
  if list ~= nil then
    return list
  end
  return table.emptytable
end

function SkinController:CheckMouseOpen(heroId, skinId)
  if (skinId or 0) == 0 then
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg ~= nil then
      skinId = heroCfg.default_skin
    end
  end
  return ConfigData.skin_live2d[skinId] == nil or ConfigData.skin_live2d[skinId].mouth_shape == 1
end

function SkinController:HeroSkinChange(heroId, nowSkinCfg, callback)
  local skinId = 0
  if nowSkinCfg ~= nil and not nowSkinCfg.isdefault_skin then
    skinId = nowSkinCfg.id
  end
  local heroNetCtr = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetCtr:CS_HERO_SkinChange(heroId, skinId, callback)
  AudioManager:PlayAudioById(1119)
end

function SkinController:CheckItemListsForSkins(itemIdList, callback, CRData)
  self.itemIdList = itemIdList
  self._callback = callback
  self.index = 0
  self:_DoNext(CRData)
end

function SkinController:GetGoodsBySkinCfg(skinCfg)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) then
    return nil
  end
  
  local function residentBpParam()
    local actData = self:GetActFrameDataBySkinCfg(skinCfg)
    if actData ~= nil then
      local actId = actData:GetActId()
      local passInfo = PlayerDataCenter.battlepassData.passInfos[actId]
      if passInfo ~= nil and passInfo:IsResidentBP() and ConfigData.battlepass_skin[ConfigData.buildinConfig.RadioChoiceBpShowId][skinCfg.id] ~= nil then
        return {703, 704}
      end
    end
    return table.emptytable
  end
  
  local param = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Store]
  for _, shopId in ipairs(residentBpParam()) do
    if param == nil then
      param = {}
    end
    if not table.contain(param, shopId) then
      table.insert(param, shopId)
    end
  end
  if param == nil then
    return nil
  end
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  for i, v in ipairs(param) do
    if shopCtrl:ShopIsUnlockOnly(v) then
      local shopData = shopCtrl.shopDataDic[v]
      local goodsData = shopData ~= nil and shopData:GetShopGoodDataByItemId(skinCfg.id, true) or nil
      if goodsData ~= nil then
        local isLimitTime, isInTime = goodsData:GetStillTime()
        if not isLimitTime or isInTime then
          return goodsData
        end
      end
    end
  end
  return nil
end

function SkinController:GetGiftBySkinCfg(skinCfg)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Gift) then
    return nil
  end
  local param = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Gift]
  if param == nil then
    return nil
  end
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  if payGiftCtrl == nil then
    return nil
  end
  for _, giftId in ipairs(param) do
    local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    if giftInfo ~= nil and giftInfo:IsUnlock() then
      return giftInfo
    end
  end
  return nil
end

function SkinController:GetActFrameDataBySkinCfg(skinCfg)
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local param = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active]
  if param == nil then
    return nil
  end
  for i, v in ipairs(param) do
    local actData = actFrameCtr:GetActivityFrameData(v)
    if actData ~= nil and actData:IsActivityOpen() then
      return actData
    end
  end
  local curBPActDataDic = actFrameCtr:GetShowByActType(ActivityFrameEnum.eActivityType.BattlePass)
  for actframeId, _ in pairs(curBPActDataDic) do
    local actData = actFrameCtr:GetActivityFrameData(actframeId)
    local actId = actData:GetActId()
    local passInfo = PlayerDataCenter.battlepassData.passInfos[actId]
    if passInfo ~= nil and passInfo:IsResidentBP() and ConfigData.battlepass_skin[ConfigData.buildinConfig.RadioChoiceBpShowId][skinCfg.id] ~= nil then
      return actData
    end
  end
  return nil
end

function SkinController:_DoNext(CRData)
  self.index = self.index + 1
  if self.index > #self.itemIdList then
    if self._callback ~= nil then
      self._callback()
    end
    return
  end
  local item = ConfigData.item[self.itemIdList[self.index]]
  local isFirstGetSkin = true
  if CRData ~= nil and CRData.crItemTransDic ~= nil and CRData.crItemTransDic[item.id] ~= nil then
    isFirstGetSkin = false
  end
  if item.type == eItemType.Skin and isFirstGetSkin then
    local skin = ConfigData.skin[item.id]
    
    local function showWindowFunc()
      UIManager:HideWindow(UIWindowTypeID.CommonReward)
      UIManager:ShowWindowAsync(UIWindowTypeID.GetHeroSkin, function(window)
        if window == nil then
          return
        end
        window:InitGetHeroSkin(skin, function()
          self:_DoNext(CRData)
        end)
      end)
    end
    
    if not string.IsNullOrEmpty(skin.skin_avg) then
      ControllerManager:GetController(ControllerTypeId.Avg, true):ShowAvg(skin.skin_avg, showWindowFunc)
    else
      showWindowFunc()
    end
    return
  end
  self:_DoNext(CRData)
end

function SkinController:ReqSkinUpgrade(skinId, callback)
  local costId, costNum = PlayerDataCenter.skinData:GetSkinUpgradeCost(skinId)
  if costNum > PlayerDataCenter:GetItemCount(costId) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
    return
  end
  local heroId = self:GetHeroId(skinId)
  NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_Skin_Upgrade(heroId, skinId, function()
    if callback then
      callback()
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHeroSkin, function(window)
      if window == nil then
        return
      end
      local skinCfg = ConfigData.skin[skinId]
      window:InitGetHeroSkin(skinCfg)
    end)
  end)
end

function SkinController:TryAdjSkinUpgrage(heroId, skinId)
  PlayerDataCenter.allAdjCustomData:AdjUpdateSkinData(heroId, skinId)
end

function SkinController:SkinLimitTimeOut(skinId)
  local heroId = self:GetHeroId(skinId)
  local skinCfg = ConfigData.skin[skinId]
  PlayerDataCenter.allAdjCustomData:TryAdjSkinLimitChange(heroId, skinId)
  cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(9708), LanguageUtil.GetLocaleText(skinCfg.name)))
end

function SkinController:SkinLimitEnd(skinId)
  local heroId = self:GetHeroId(skinId)
  PlayerDataCenter.allAdjCustomData:TryAdjSkinLimitEnd(heroId, skinId)
end

return SkinController
