_class("UISeasonMazeRoomBox", UISeasonMazeRoomBase)
UISeasonMazeRoomBox = UISeasonMazeRoomBox

function UISeasonMazeRoomBox:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomBox:OnShowUI(uiParams)
  self._selected = {false, false}
  self._haveHalidom = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Chest_All_Reward) > 0
  self:_InitWidget()
  self:_OnValue()
end

function UISeasonMazeRoomBox:_InitWidget()
  self._rewards = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._choiceTips = self:GetUIComponent("UILocalizationText", "ChoiceTips")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._choiceMarkGO = self:GetGameObject("ChoiceMark")
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeRoomBox:_OnValue()
  if self._haveHalidom then
    self._choiceTips:SetText(StringTable.Get("str_season_maze_room_box2", "圣物名字"))
  else
    self._choiceTips:SetText(StringTable.Get("str_season_maze_room_box"))
  end
  self._rewards:SpawnObjects("UISeasonMazeRoomBoxItem", 2)
  self._itemWidgets = self._rewards:GetAllSpawnList()
  for key, widget in ipairs(self._itemWidgets) do
    widget:SetData(key, self._roomInfo.rand_box[key], function(index)
      self:OnClickItem(index)
    end, function(index, position)
      self:_ShowTips(index, position)
    end)
  end
  self._choiceMarkGO:SetActive(true)
end

function UISeasonMazeRoomBox:ChoiceBtnOnClick(go)
  local index = -1
  if self._selected[1] then
    index = 0
  end
  if self._selected[2] then
    index = 1
  end
  if self._selected[1] and self._selected[2] then
    index = 2
  end
  if index < 0 or self._haveHalidom and index ~= 2 then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_room_not_choice"))
    return
  end
  self:Lock("UISeasonMazeRoomBox")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local result = self._component:HandleSeasonMazeBox(TT, res, index)
    if not res:GetSucc() then
      Log.error("宝箱房间UI结算失败:", res:GetResult())
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
      return
    end
    self:UnLock("UISeasonMazeRoomBox")
    if result.reward then
      self._waitNotifyReward = result.reward
      local showRewards = {}
      for _, value in ipairs(result.reward) do
        local reward = value
        if reward.type == SeasonMazeEffectType.SMET_Bead then
          table.insert(showRewards, reward)
        end
      end
      for index, isSelected in ipairs(self._selected) do
        if isSelected then
          local effect = self._roomInfo.rand_box[index]
          if effect and (effect.type == SeasonMazeEffectType.SMET_Pro or effect.type == SeasonMazeEffectType.SMET_Relic) then
            table.insert(showRewards, effect)
          end
        end
      end
      SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
    end
  end, self)
end

function UISeasonMazeRoomBox:OnSeasonMazeShowRewardsFinish(flag)
  self:OnHideUI(self._waitNotifyReward)
end

function UISeasonMazeRoomBox:OnClickItem(index)
  self._selected[index] = true
  if not self._haveHalidom then
    for _index, _ in ipairs(self._selected) do
      if _index ~= index then
        self._selected[_index] = false
        break
      end
    end
  end
  for index, value in ipairs(self._itemWidgets) do
    value:OnSelected(self._selected[index])
  end
  if self._haveHalidom then
    if self._selected[1] and self._selected[2] then
      self._choiceMarkGO:SetActive(false)
    end
  else
    self._choiceMarkGO:SetActive(false)
  end
end

function UISeasonMazeRoomBox:_ShowTips(index, position)
  local data = self._roomInfo.rand_box[index]
  local totalCount = 0
  if data.type == SeasonMazeEffectType.SMET_Pro then
    totalCount = self._component:GetAttrValue(data.id)
  elseif data.type == SeasonMazeEffectType.SMET_Bead then
    if self._comInfo.m_auto_bead_map then
      for _, value in pairs(self._comInfo.m_auto_bead_map) do
        local bead = value
        if data.id == bead.bead_info.cfg_id then
          totalCount = totalCount + 1
        end
      end
    end
  else
    totalCount = self._component:GetEffectNum(data.type, data.id)
  end
  self._tips:SetSeasonMazeData(data, totalCount, position)
end
