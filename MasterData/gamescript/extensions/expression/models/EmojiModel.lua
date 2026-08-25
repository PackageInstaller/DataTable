local EmojiModel = NewClass("EmojiModel", BaseModel)
local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType

function EmojiModel:OnInit()
  self:OnReset()
end

function EmojiModel:OnReset()
  self.show = true
  self.lastTime = 0
end

function EmojiModel:GetUsingEmojiList()
  do return end
  return PlayerDataUtils.GetUsingEmojiList
end

function EmojiModel:SetUsingEmojiList(list)
  PlayerDataUtils.SetUsingEmojiList(list)
end

function EmojiModel:GetOwnEmojiList()
  local list = {}
  for _, v in pairs(DataCenter.itemData.BagItemData) do
    if not v then
    else
      local config = ItemDataUtils.GetItemConfig(v.tid)
      if config.Type == ItemType.Special and config.SubType == ItemSubType.Emoji then
        local itemData = {
          tid = v.tid,
          uid = v.uid
        }
        table.insert(list, itemData)
      end
    end
  end
  table.sort(list, function(a, b)
    local aCfg = ItemDataUtils.GetItemConfig(a.tid)
    local bCfg = ItemDataUtils.GetItemConfig(b.tid)
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  return list
end

function EmojiModel:SetEnemyEmojiState(show)
  self.show = show
end

function EmojiModel:GetEnemyEmojiState()
  return self.show
end

function EmojiModel:GetLastReqShowTime()
  return self.lastTime
end

function EmojiModel:UpdateLastReqShowTime()
  local EmojiCoolTime = DT.GetConstant("EmojiCoolTime")
  self.lastTime = TimeUtils.GetServerTime() + EmojiCoolTime + 1
end

return EmojiModel
