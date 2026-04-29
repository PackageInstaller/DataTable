_class("UIMedalItemData", Object)
UIMedalItemData = UIMedalItemData

function UIMedalItemData:Constructor()
  self._template = nil
  self._tplItem = nil
  self.data = nil
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self._itemPstId = nil
end

function UIMedalItemData:Init(medal)
  self.data = medal
  self._template = Cfg.cfg_item_medal[self.data.medal_id]
  self._tplItem = Cfg.cfg_item[self.data.medal_id]
  if not self._template then
    Log.error("[UIMedalItemData] can't find cfg_item_medal with id = " .. self.data.medal_id)
  end
  if self:IsReceive() then
    if GameSingle then
      self._itemPstId = self.data.medal_id
    end
    local items = self.itemModule:GetItemByTempId(self.data.medal_id)
    if items and table.count(items) > 0 then
      for key, value in pairs(items) do
        self._itemPstId = key
        break
      end
    end
  else
    self._itemPstId = nil
  end
end

function UIMedalItemData:GetPstId()
  return self._itemPstId
end

function UIMedalItemData:GetID()
  if self.data then
    return self.data.medal_id
  end
end

function UIMedalItemData:GetTemplID()
  if self._template then
    return self._template.ID
  end
  return nil
end

function UIMedalItemData:GetTempl()
  return self._template
end

function UIMedalItemData:GetTemplateItem()
  return self._tplItem
end

function UIMedalItemData:GetIconItem()
  local cfgv = self:GetTemplateItem()
  return cfgv.Icon
end

function UIMedalItemData:IsNew()
  if not self:IsReceive() then
    return false
  end
  if not self._tplItem.ShowNew or self._tplItem.ShowNew ~= 1 then
    return false
  end
  local item = self.itemModule:FindItem(self._itemPstId)
  if not item then
    return false
  end
  return item:IsNew()
end

function UIMedalItemData:IsReceive()
  return self.data.status == RewardStatus.E_MEDAL_REWARD_RECVED
end

function UIMedalItemData:IsFunctionLock()
  return self.data.status == RewardStatus.E_MEDAL_REWARD_FUNCTION_LOCK
end

function UIMedalItemData:GetStatus()
  return self.data.status
end

function UIMedalItemData:GetProgress()
  local progress = 0
  local curInfo = ""
  local totalInfo = ""
  local molecule = 0
  local denominator = 0
  molecule = self.data.cur_progress
  denominator = self.data.total_progress
  curInfo = self.data.cur_progress
  totalInfo = self.data.total_progress
  if 0 < denominator then
    progress = math.min(1, molecule / denominator)
  end
  return progress, curInfo, totalInfo
end
