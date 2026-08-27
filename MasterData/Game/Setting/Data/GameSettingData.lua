local GameSettingData = class("GameSettingData")

function GameSettingData:ctor()
end

function GameSettingData:InitGameSettingData(clientRecord)
  if clientRecord == nil then
    self:_InitDescribes({})
    self:_InitSetting({})
    self:_InitNewTitleItems({})
    self:_InitActEntered({})
    return
  end
  self:_InitDescribes(clientRecord.describes)
  self:_InitSetting(clientRecord.setting)
  self:_InitNewTitleItems(clientRecord.newTitleItems)
  self:_InitActEntered(clientRecord.actLongIdEnter)
end

function GameSettingData:_InitDescribes(describes)
  self.describes = describes
  if table.IsEmptyTable(describes) then
    local oldDescribes = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData):GetDescribeSettingOld()
    if oldDescribes ~= nil and not table.IsEmptyTable(oldDescribes) then
      for k, v in ipairs(oldDescribes) do
        describes[k] = v
      end
      return
    end
    for index, id in pairs(ConfigData.game_set_group[eGameSetType.detail].order) do
      local cfg = ConfigData.game_set_describe[id]
      describes[index] = cfg.defalt_detail ~= 0
    end
  end
end

function GameSettingData:_InitSetting(setting)
  self.setting = setting or {}
end

function GameSettingData:_InitNewTitleItems(newTitleItems)
  self.newTitleItemDic = {}
  for i, v in pairs(newTitleItems) do
    self.newTitleItemDic[v] = true
  end
end

function GameSettingData:GetNewTitleItemDic()
  return self.newTitleItemDic
end

function GameSettingData:SetNewTitleItemDicEmpty()
  self.newTitleItemDic = {}
end

function GameSettingData:GetNewTitleItemNum()
  return table.count(self.newTitleItemDic)
end

function GameSettingData:TryAddTitleItem(itemData)
  if itemData.type == eItemType.Title or itemData.type == eItemType.TitleBackground then
    self.newTitleItemDic[itemData.dataId] = true
    local ok, newTitleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Title)
    if ok then
      newTitleNode:SetRedDotCount(1)
    end
  end
end

function GameSettingData:GetGSIsShowDetailDescribeValue(eDescTypeId)
  local bool = self:GetGSIsShowDetailDescribe(eDescTypeId)
  return bool and 1 or 0
end

function GameSettingData:GetGSIsShowDetailDescribe(eDescTypeId)
  if self.describes == nil then
    return true
  end
  return self.describes[eDescTypeId]
end

function GameSettingData:GetSetting()
  return self.setting
end

function GameSettingData:SetGSDescribe(eDescTypeId, bool)
  local val = self.describes[eDescTypeId]
  if val ~= bool then
    self.describes[eDescTypeId] = bool
    MsgCenter:Broadcast(eMsgEventId.DescribeSettingChange, eDescTypeId)
    self._isDirty = true
  end
end

function GameSettingData:SetGSSetting(eSettingTypeId, bool)
  local val = self.setting[eSettingTypeId]
  if val ~= bool then
    self.setting[eSettingTypeId] = bool
    MsgCenter:Broadcast(eMsgEventId.SettingSettingChange, eSettingTypeId)
    self._isDirty = true
  end
end

function GameSettingData:IsGSDataDirty()
  self.newTitleRead = 0
  return self._isDirty, self
end

function GameSettingData:ClearGSDataDirty()
  self._isDirty = nil
end

function GameSettingData:_InitActEntered(dic)
  self._actEnteredDic = dic
end

function GameSettingData:IsActEntered(actFrameId)
  return self._actEnteredDic[actFrameId] ~= nil
end

function GameSettingData:SetActEntered(actFrameId)
  if self._actEnteredDic[actFrameId] ~= nil then
    return
  end
  self._actEnteredDic[actFrameId] = true
end

return GameSettingData
