local ReinforceUtil = {}
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ReinforceUtil.LoadReinforceCfg()
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_card_main)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_card_star)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_color_group)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_func_group)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_label)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_room_group)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_exploration_continue_diff)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_exploration_main)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_collect_card_main)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_collect_collect_theme)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_collect_collect_reward)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_exploration_verify_exploration)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_pool_card_main)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_pool_card_set)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_pool_card_pool)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_exploration_reward_group)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_card_chip_score)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_exploration_infinite_score)
  ConfigData:LoadDynCfg(eDynConfigData.reinforce_exploration_layer_group)
  ReinforceUtil.InitCardLowestStar()
end

function ReinforceUtil.UnloadReinforceCfg()
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_card_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_card_star)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_color_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_func_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_label)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_room_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_exploration_continue_diff)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_exploration_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_collect_card_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_collect_collect_theme)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_collect_collect_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_exploration_verify_exploration)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_pool_card_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_pool_card_set)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_pool_card_pool)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_exploration_reward_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_card_chip_score)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_exploration_infinite_score)
  ConfigData:ReleaseDynCfg(eDynConfigData.reinforce_exploration_layer_group)
end

function ReinforceUtil.ShowRfCdDetailChipFloat(chipData, cardTransfrom, floatTargetTransform, xOffset, hideFunc)
  local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
  local HAType = FloatAlignEnum.HAType
  local VAType = FloatAlignEnum.VAType
  local hAType = cardTransfrom.position.x < floatTargetTransform.position.x and HAType.autoTightRight or HAType.autoTightLeft
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipDetailFloat, function(win)
    win:InitChipDetailFloat(chipData, floatTargetTransform, hAType, xOffset)
    win:SetChipDetailFloatHideFunc(hideFunc)
  end)
end

function ReinforceUtil.ReqRfCardFactorData(rfDataAll)
  if rfDataAll:GetRfFactorCardDataDic() ~= nil then
    return
  end
  local actFrameId = rfDataAll:GetRfCdAllActFrameId()
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_GetFactorCards(actFrameId, function(objList)
    local msg = objList[0]
    rfDataAll:InitRfFactorCardDataDic(msg)
  end)
end

function ReinforceUtil.SetRfCardGroupData(rfDataAll)
  if rfDataAll:GetRfCardGroup() == nil then
    return
  end
  local groupData = rfDataAll:GetRfCardGroup()
  local actFrameId = rfDataAll:GetRfCdAllActFrameId()
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_Reinforce_StartList(actFrameId, groupData, nil)
end

function ReinforceUtil.ReqRfCardGroupData(rfDataAll)
  if rfDataAll:GetRfCardGroup() ~= nil then
    return
  end
  local actFrameId = rfDataAll:GetRfCdAllActFrameId()
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_GetReinforce_StartList(actFrameId, function(objList)
    local rfMsg = objList[0]
    rfDataAll:UpdRfCardGroupListData(rfMsg)
  end)
end

local GetDataAllFuncDic = {
  [59001] = function()
    local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    local rfDataAll = actAn24Ctrl:GetActFirstData():GetActAnv24RfCardDataAll()
    return rfDataAll
  end
}

function ReinforceUtil.GetRfDataAllByActFrameId(actFrameId)
  local func = GetDataAllFuncDic[actFrameId]
  if func == nil then
    error("Cant get GetDataAllFunc, actFrameId:" .. tostring(actFrameId))
    return
  end
  return func()
end

function ReinforceUtil.InitCardLowestStar()
  if ConfigData.reinforce_card_card_star == nil then
    return
  end
  ReinforceUtil.CardLowestStar = {}
  for id, starCfglist in pairs(ConfigData.reinforce_card_card_star) do
    local lowestStar = math.huge
    for star, value in pairs(starCfglist) do
      if star < lowestStar then
        lowestStar = star
      end
    end
    ReinforceUtil.CardLowestStar[id] = lowestStar
  end
end

function ReinforceUtil.GetCardLowestStar(cardId)
  if ReinforceUtil.CardLowestStar == nil then
    ReinforceUtil.InitCardLowestStar()
  end
  return ReinforceUtil.CardLowestStar[cardId]
end

function ReinforceUtil.GetRfCdCactorOrderStr(cardOrder)
  return string.char(64 + cardOrder)
end

function ReinforceUtil.RfCdShowTween(canvasGroup)
  canvasGroup:DOFade(0, 0.21):From():SetLink(canvasGroup.gameObject)
  canvasGroup.transform:DOScale(0.6, 0.21):From():SetLink(canvasGroup.gameObject)
end

function ReinforceUtil.SwitchRfCardTween(canvasGroup, initFunc)
  canvasGroup.blocksRaycasts = false
  local seq = CS.DG.Tweening.DOTween.Sequence():Append(canvasGroup:DOFade(0, 0.1)):AppendCallback(function()
    initFunc()
    canvasGroup.transform.localScale = Vector3.Temp(0.6, 0.6, 0.6)
  end):Append(canvasGroup:DOFade(1, 0.21)):Join(canvasGroup.transform:DOScale(1, 0.21):SetEase(CS.DG.Tweening.Ease.OutBack)):AppendCallback(function()
    canvasGroup.blocksRaycasts = true
  end):SetLink(canvasGroup.gameObject)
  return seq
end

function ReinforceUtil.CalEffectBySelectCardData(dataList, actFrameId, diffId)
  local diffCfg = ConfigData.reinforce_exploration_continue_diff[actFrameId][diffId]
  local effectNum = diffCfg.base_combat
  local maxNum = 0
  for i, data in pairs(dataList) do
    local group = data:GetRfCdRoomGroup()
    if group ~= nil then
      for index, id in pairs(group) do
        local groupCfg = ConfigData.reinforce_card_room_group[id]
        if maxNum < groupCfg.base_combat then
          maxNum = groupCfg.base_combat
        end
      end
    end
  end
  effectNum = effectNum + (100 + diffCfg.combat_bonus) * maxNum // 100
  return effectNum
end

function ReinforceUtil.CalEffectBySelectCardId(list, facCardId, supportfacCardUID, actFrameId, diffId)
  local diffCfg = ConfigData.reinforce_exploration_continue_diff[actFrameId][diffId]
  local effectNum = diffCfg.base_combat
  local dataAll = GetDataAllFuncDic[actFrameId]()
  local maxNum = 0
  for i, id in pairs(list) do
    local data
    if id == facCardId then
      local dic = dataAll:GetRfFactorCardDataDic()
      data = dic[id]
    elseif id == supportfacCardUID then
      dataAll:TryGetSupportFacCardByUID(supportfacCardUID, function(cardData)
        data = cardData
      end)
    else
      data = dataAll:GetRfCardSysDataById(id)
    end
    local group = data:GetRfCdRoomGroup()
    if group ~= nil then
      for index, id in pairs(group) do
        local groupCfg = ConfigData.reinforce_card_room_group[id]
        if maxNum < groupCfg.base_combat then
          maxNum = groupCfg.base_combat
        end
      end
    end
  end
  effectNum = effectNum + (100 + diffCfg.combat_bonus) * maxNum // 100
  return effectNum
end

function ReinforceUtil.GetHasCheckSetSupportBlueDot()
  return ReinforceUtil.hasCheckSetSupportBlueDot
end

function ReinforceUtil.SetHasCheckSetSupportBlueDot(value)
  ReinforceUtil.hasCheckSetSupportBlueDot = value
end

return ReinforceUtil
