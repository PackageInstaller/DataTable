_class("UIMedalBgListData", Object)
UIMedalBgListData = UIMedalBgListData

function UIMedalBgListData:Constructor()
  self.defMedalID = nil
  self.medalList = {}
  self.totalMedal = 0
  self.collectMedal = 0
end

function UIMedalBgListData:Init(server_medal_info)
  self.visit = visit
  for i, v in pairs(server_medal_info) do
    if Cfg.cfg_item_medal_board[v.medal_id].IsDefault then
      self.defMedalID = v.medal_id
    end
    if v.status == RewardStatus.E_MEDAL_REWARD_LOCK and not Cfg.cfg_item_medal_board[v.medal_id].IsShow then
    else
      if v.status ~= RewardStatus.E_MEDAL_REWARD_LOCK and v.status ~= RewardStatus.E_MEDAL_REWARD_FUNCTION_LOCK then
        self.collectMedal = self.collectMedal + 1
      end
      self.totalMedal = self.totalMedal + 1
      self.medalList[v.medal_id] = v
    end
  end
end

function UIMedalBgListData:GetTotalNum()
  return self.totalMedal
end

function UIMedalBgListData:GetUnLockNum()
  return self.collectMedal
end

function UIMedalBgListData:GetDefMedalID()
  return self.defMedalID
end

function UIMedalBgListData:GetSortMedals()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local tb, newList, commentList, lockList = {}, {}, {}, {}
  for i, v in pairs(self.medalList) do
    local item_data, is_new
    local items = itemModule:GetItemByTempId(v.medal_id)
    if items and table.count(items) > 0 then
      for _, value in pairs(items) do
        item_data = value
        break
      end
    end
    if item_data then
      is_new = item_data:IsNewOverlay()
    end
    if v.status == RewardStatus.E_MEDAL_REWARD_LOCK then
      table.insert(lockList, i)
    elseif is_new then
      table.insert(newList, i)
    else
      table.insert(commentList, i)
    end
  end
  table.sort(newList)
  table.sort(commentList)
  table.sort(lockList)
  for _, v in pairs(newList) do
    table.insert(tb, self.medalList[v])
  end
  for _, v in pairs(commentList) do
    table.insert(tb, self.medalList[v])
  end
  for _, v in pairs(lockList) do
    table.insert(tb, self.medalList[v])
  end
  return tb
end

function UIMedalBgListData:GetMedalDataByID(medalID)
  return Cfg.cfg_item_medal_board[medalID]
end
