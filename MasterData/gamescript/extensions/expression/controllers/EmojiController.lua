local EmojiController = NewClass("EmojiController", BaseController)

function EmojiController:OnInit()
end

function EmojiController:OnReset()
end

function EmojiController:ReqShowPVPEmoji(iconId)
  if self:ShowEmojiInCD() then
    return
  end
  local record = {
    time = nil,
    eventId = BattleRenderEvent.ShowEmoji,
    data = {
      emoji = iconId,
      sendCamp = bg.battleDataCenter:GetMyCamp()
    }
  }
  local sendData = {
    frameList = {record}
  }
  ProtoManager.Instance:ReqServer("GameRequest", "SendEmoji", function(data)
    Logger.Info("========== 请求发送表情成功 ==========\n", table.tostring(data or {}))
    EmojiModel.Instance:UpdateLastReqShowTime()
  end, function(data)
    Logger.Info("========== 请求发送表情失败 ==========\n", table.tostring(data or {}))
  end, iconId, BattleCommand.lg_ClientAction, sendData)
end

function EmojiController:ReqUpdateEmojiList(list, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "SetEmoji", function(data)
    Logger.Info("========== 请求更新表情成功 ==========\n", table.tostring(data or {}))
    EmojiModel.Instance:SetUsingEmojiList(list)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求更新表情失败 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, list)
end

function EmojiController:GetOwnEmojiList()
  local groupMap = {}
  local resultList = {}
  local ownList = EmojiModel.Instance:GetOwnEmojiList()
  for i, itemData in ipairs(ownList) do
    local itemId = itemData.tid
    local itemUid = itemData.uid
    local itemCfg = DT.Item[itemId]
    local groupType = itemCfg.ClassificationParam[1]
    local group = groupMap[groupType]
    if nil == group then
      group = {}
      group.emojiList = {}
      group.title = LT.Text(DT.CommonID[groupType].Desc)
      groupMap[groupType] = group
      table.insert(resultList, group)
    end
    local data = {
      iconId = itemId,
      uid = itemUid,
      selected = self:IsUsing(itemId)
    }
    table.insert(group.emojiList, data)
  end
  return resultList
end

function EmojiController:IsUsing(iconId)
  local iconList = EmojiModel.Instance:GetUsingEmojiList()
  for i, itemId in ipairs(iconList) do
    if itemId == iconId then
      return true
    end
  end
  return false
end

function EmojiController:ShowEmojiInCD()
  local curTime = TimeUtils.GetServerTime()
  local grayEndTime = EmojiModel.Instance:GetLastReqShowTime()
  return curTime < grayEndTime
end

function EmojiController:SetEnemyEmojiState(show)
  EmojiModel.Instance:SetEnemyEmojiState(show)
end

function EmojiController:GetEnemyEmojiState()
  do return EmojiModel.Instance.GetEnemyEmojiState end
  return EmojiModel.Instance.GetEnemyEmojiState, EmojiModel.Instance
end

function EmojiController:GetUsingEmojiList()
  local resultList = {}
  local iconList = EmojiModel.Instance:GetUsingEmojiList()
  for i, itemId in ipairs(iconList) do
    table.insert(resultList, self:AddUsingEmoji(itemId))
  end
  return resultList
end

function EmojiController:AddUsingEmoji(iconId)
  return {iconId = iconId}
end

return EmojiController
