local this = {}
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this:showItemServerRewards(sData, ignoreQueueCheck, interactType)
  if sData == nil then
    return
  end
  table.sort(sData, function(a, b)
    return a.itemid < b.itemid
  end)
  for _, v in ipairs(sData) do
    if v.itemnum > 0 then
      self:showCommonRewardMsg(v.itemtype, v.itemid, v.itemnum, nil, true, ignoreQueueCheck, interactType)
    end
  end
end

function this:showItemServerRewardsNotSort(sData, ignoreQueueCheck, interactType)
  if sData == nil then
    return
  end
  for _, v in ipairs(sData) do
    if v.itemnum > 0 then
      self:showCommonRewardMsg(v.itemtype, v.itemid, v.itemnum, nil, true, ignoreQueueCheck, interactType)
    end
  end
end

function this:showRewardMsg(itemType, itemId, icon, name, quality, count, iconFilter, ignoreQueueCheck, interactType)
  local args = CS.Lens.Gameplay.UI.CellRewardParamOptions()
  args.itemId = itemId
  args.itemType = itemType
  args.count = count
  args.quality = quality
  args.name = name
  args.icon = icon
  args.iconFilter = iconFilter
  if interactType then
    args.interactLimitFlag = interactType.limitFlag
    args.interactSourcetype = interactType.sourcetype
    args.interactSourceToolType = interactType.sourceToolType
  end
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.rewardMsg, args)
end

function this:showCommonRewardMsg(itemType, itemId, itemNum, itemName, isPlayAudio, ignoreQueueCheck, interactType)
  local parse = L_ItemTplManager:getItemConfig(itemType, itemId)
  if table.isEmpty(parse) then
    return
  end
  local iconFilter
  if itemType == L_Const.resType.commonItem then
    iconFilter = _commonItemTpl:getFilterIcon(_commonItemTpl:getTplById(itemId))
  end
  itemName = string.isEmpty(itemName) and parse.name or itemName
  self:showRewardMsg(itemType, itemId, parse.icon, itemName, parse.quality, itemNum, iconFilter, ignoreQueueCheck, interactType)
  if isPlayAudio then
    L_PlayerManager:playVoice(L_Const.cvType.FoundRes)
  end
end

return this
