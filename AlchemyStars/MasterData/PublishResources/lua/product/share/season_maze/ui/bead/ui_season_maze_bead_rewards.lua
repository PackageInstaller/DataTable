_class("UISeasonMazeBeadRewards", UIController)
UISeasonMazeBeadRewards = UISeasonMazeBeadRewards

function UISeasonMazeBeadRewards:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeBeadRewards:OnShow(uiParams)
  self._ids = uiParams[1]
  self._callBack = uiParams[2]
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self:InitWidget()
  self:_FilterData()
  self:_OnValue()
end

function UISeasonMazeBeadRewards:InitWidget()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISeasonMazeBeadTips")
end

function UISeasonMazeBeadRewards:_OnValue()
  self._content:SpawnObjects("UISeasonMazeBeadItem", 5)
  self._widgets = self._content:GetAllSpawnList()
  for _, widget in ipairs(self._widgets) do
    widget:SetScale(0.8)
  end
  self:ShowFive()
end

function UISeasonMazeBeadRewards:_FilterData()
  self._fiveArray = {}
  self._arrayIndex = 1
  if table.count(self._ids) > 0 then
    local count = 1
    local arrayIndex = 1
    for _, uid in ipairs(self._ids) do
      if 5 < count then
        count = 1
        arrayIndex = arrayIndex + 1
      end
      if not self._fiveArray[arrayIndex] then
        self._fiveArray[arrayIndex] = {}
      end
      if count <= 5 then
        table.insert(self._fiveArray[arrayIndex], uid)
        count = count + 1
      end
    end
  end
end

function UISeasonMazeBeadRewards:ShowFive()
  for key, widget in ipairs(self._widgets) do
    local id = self._fiveArray[self._arrayIndex][key]
    if id then
      widget:SetActive(true)
      widget:SetData(nil, self:ForgeData(id), function(uid, id, position)
        self:ShowTips(uid, id, position)
      end, SeasonMazeBeadItemType.Reward)
    else
      widget:SetActive(false)
    end
  end
end

function UISeasonMazeBeadRewards:CloseBtnOnClick(go)
  if self._arrayIndex >= #self._fiveArray then
    self:CloseDialog()
    if self._callBack then
      self._callBack()
    end
  else
    self._arrayIndex = self._arrayIndex + 1
    self:ShowFive()
  end
end

function UISeasonMazeBeadRewards:ShowTips(uid, id, position)
  self._tips:SetData(uid, id, position)
end

function UISeasonMazeBeadRewards:ForgeData(id)
  local data = SeasonMazeAutoBeadClient:New()
  data.bead_info.unique_id = 0
  data.bead_info.cfg_id = id
  return data
end

function UISeasonMazeBeadRewards:InSlot(uid)
  return false
end

function UISeasonMazeBeadRewards:IsLock(data, itemType)
  return false
end

function UISeasonMazeBeadRewards:IsMark(data, itemType)
  return false
end
