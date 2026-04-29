_class("UIN5ProgressItem", UICustomWidget)
UIN5ProgressItem = UIN5ProgressItem

function UIN5ProgressItem:Constructor()
  self._detailExpanded = false
  self._playerInfoBgCfg = {
    [1] = "n5_rank_rank1",
    [2] = "n5_rank_rank2",
    [3] = "n5_rank_rank3",
    [-1] = "n5_rank_rank4"
  }
end

function UIN5ProgressItem:OnShow(uiParams)
end

function UIN5ProgressItem:OnHide()
end

function UIN5ProgressItem:InitWidget()
  self._rewardArea = self:GetGameObject("RewardArea")
  self._detailArea = self:GetGameObject("DetailArea")
  self._tarPointTxt1 = self:GetUIComponent("UILocalizationText", "TarPointTxt1")
  self._tarPointTxt2 = self:GetUIComponent("UILocalizationText", "TarPointTxt2")
  self._rewardItemPool = self:GetUIComponent("UISelectObjectPath", "RewardItemPool")
  self._rankTitleText1 = self:GetUIComponent("UILocalizationText", "RankTitleText1")
  self._rankTitleText2 = self:GetUIComponent("UILocalizationText", "RankTitleText2")
  self._rankInfoText = self:GetUIComponent("UILocalizationText", "RankInfoText")
  self._rankInfoAreaGo1 = self:GetGameObject("RankInfoArea1")
  self._rankInfoAreaGo2 = self:GetGameObject("RankInfoArea2")
  self._canGetRewardObj = self:GetGameObject("CanGetReward")
  self._receivedRewardObj = self:GetGameObject("ReceivedReward")
  self._receivedRewardTex = self:GetUIComponent("UILocalizationText", "ReceivedStateTex")
  self._openDetailAreaGo = self:GetGameObject("OpenDetailTextBtn")
  self._closeDetailAreaGo = self:GetGameObject("CloseDetailTextArea")
  self._rankInfoTextBgRect = self:GetUIComponent("RectTransform", "RankInfoTextBg")
  if self._rankInfoTextBgRect then
    self._baseRankInfoTextBgRectSize = self._rankInfoTextBgRect.sizeDelta
  end
  self._rewardBgGo = self:GetGameObject("RewardBg")
  self._rewardBgImg = self:GetUIComponent("Image", "RewardBg")
  if self._rewardBgGo then
    self:AddUICustomEventListener(UICustomUIEventListener.Get(self._rewardBgGo), UIEvent.BeginDrag, function(pointData)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N5ProgressScrollDragBegin)
    end)
  end
  self._cardRawImg = self:GetUIComponent("RawImageLoader", "CardImg")
  self._playerInfoBg = self:GetUIComponent("Image", "PlayerInfoBg")
  self._playerTitleText = self:GetUIComponent("UILocalizationText", "PlayerTitleText")
  self._playerRollingTitleText = self:GetUIComponent("RollingText", "PlayerTitleText")
  self._playerNameText = self:GetUIComponent("RollingText", "PlayerNameText")
  self:AttachEvent(GameEventType.N5ProgressScrollDragBegin, self._OnScrollDragBegin)
end

function UIN5ProgressItem:SetData(index, count, itemInfo, componentInfo, callback, itemCallBack, specificData, cmptCfgId, onExpandCallBack)
  self._itemInfo = itemInfo
  self:InitWidget()
  self._index = index
  self._totalCellCount = count
  self._componentInfo = componentInfo
  self._cmptCfgId = cmptCfgId
  self._callback = callback
  self._itemCallback = itemCallBack
  self._specificData = specificData
  self._onExpandCallBack = onExpandCallBack
  self:_OnValue()
end

function UIN5ProgressItem:_OnValue()
  if not self.atlas then
    local atlasName = self._specificData:GetSpriteAtlasName()
    self.atlas = self:GetAsset(atlasName, LoadType.SpriteAtlas)
  end
  local target = self._itemInfo.target
  self._isSpecialAward = self._itemInfo.bSpecial
  self:_FillRewardArea()
  self:_FillNumArea(target)
  self:_FillInfoArea()
  self:_SetUIByRank()
end

function UIN5ProgressItem:_FillRewardArea()
  local target = self._itemInfo.target
  local cur = self._componentInfo.m_current_progress
  local received = self._componentInfo.m_received_progress
  self._state = self:_CalcState(target, cur, received)
  local rewards = self._componentInfo.m_progress_rewards[target]
  self:_SetRewardItem(rewards, "UIN5ProgressRewardItem")
  self:_SetStateCanGetReward(self._state == UIActivityProgressRewardState.STATE_UNLOCK)
  self:_SetStateReceivedReward(self._state == UIActivityProgressRewardState.STATE_RECEIVED)
end

function UIN5ProgressItem:_FillNumArea(target)
  self:_SetProgressText(target)
end

function UIN5ProgressItem:_FillInfoArea()
  local bShowDetail = false
  local cfgGroup = Cfg.cfg_activity_person_progress_extra_client({
    ComponentID = self._cmptCfgId,
    ItemCount = self._itemInfo.target
  })
  if cfgGroup and 0 < #cfgGroup then
    local curCfg = cfgGroup[1]
    local npcNameCfg = curCfg.NpcName
    if string.isnullorempty(npcNameCfg) then
    else
      do
        local titleStr = curCfg.RankTitle
        local rankIndex = self._itemInfo.rank
        if rankIndex then
          if self._rankTitleText1 then
            self._rankTitleText1:SetText(StringTable.Get(titleStr, rankIndex))
          end
          if self._rankTitleText2 then
            self._rankTitleText2:SetText(StringTable.Get(titleStr, rankIndex))
          end
        end
      end
      if self._playerNameText then
        local oriStr = curCfg.NpcName
        if not string.isnullorempty(oriStr) then
          self._playerNameText:RefreshText(StringTable.Get(oriStr))
        end
      end
      if self._playerRollingTitleText then
        local oriStr = curCfg.NpcTitle
        if not string.isnullorempty(oriStr) then
          self._playerRollingTitleText:RefreshText(StringTable.Get(oriStr))
        end
      end
      if self._cardRawImg then
        local oriStr = curCfg.NpcCard
        if not string.isnullorempty(oriStr) then
          self._cardRawImg:LoadImage(oriStr)
        end
      end
    end
    if self._rankInfoText then
      local detailStr = curCfg.DetailInfo
      if string.isnullorempty(detailStr) then
      else
        self._rankInfoText:SetText(StringTable.Get(detailStr))
        local height = self._rankInfoText.preferredHeight
        if 120 < height then
          self._openDetailAreaGo:SetActive(true)
        end
        bShowDetail = true
      end
    end
  end
  if self._detailArea then
    self._detailArea:SetActive(bShowDetail)
  end
end

function UIN5ProgressItem:_SetProgressText(point)
  local showStr = point
  if self._tarPointTxt1 then
    self._tarPointTxt1:SetText(showStr)
  end
  if self._tarPointTxt2 then
    self._tarPointTxt2:SetText(showStr)
  end
end

function UIN5ProgressItem:_SetRewardItem(infoList, classType)
  self._rewardItemPool:SpawnObjects(classType, table.count(infoList))
  local itemList = self._rewardItemPool:GetAllSpawnList()
  for i = 1, table.count(infoList) do
    itemList[i]:SetData(i, self._state, self._isSpecialAward, infoList[i], self._itemCallback)
  end
end

function UIN5ProgressItem:_SetStateCanGetReward(isShow)
  self._canGetRewardObj:SetActive(isShow)
end

function UIN5ProgressItem:_SetStateReceivedReward(isShow)
  self._receivedRewardObj:SetActive(isShow)
end

function UIN5ProgressItem:_SetUIByRank()
  local cellBgCfg = {}
  local cellFrontBgCfg = {}
  local rankInfoStyleCfg = {}
  local cellBgDefaultCfg, cellFrontBgDefaultCfg, rankInfoStyleDefaultCfg
  local curCfg = Cfg.cfg_activity_person_progress_ui[self._cmptCfgId]
  if curCfg then
    local cellBgVec = curCfg.CellBg
    if cellBgVec then
      for index, value in ipairs(cellBgVec) do
        local cfgStr = value
        local rank, res
        local params = string.split(cfgStr, ",")
        if #params == 2 then
          rank = tonumber(params[1])
          res = params[2]
          cellBgCfg[rank] = res
        end
      end
    end
    cellBgDefaultCfg = curCfg.CellBgDefault
    local cellFrontBgVec = curCfg.CellFrontBg
    if cellFrontBgVec then
      for index, value in ipairs(cellFrontBgVec) do
        local cfgStr = value
        local rank, res
        local params = string.split(cfgStr, ",")
        if #params == 2 then
          rank = tonumber(params[1])
          res = params[2]
          cellFrontBgCfg[rank] = res
        end
      end
    end
    cellFrontBgDefaultCfg = curCfg.CellFrontBgDefault
    local rankInfoStyleVec = curCfg.RankInfoStyle
    if rankInfoStyleVec then
      for index, value in ipairs(rankInfoStyleVec) do
        local cfgStr = value
        local rank, res
        local params = string.split(cfgStr, ",")
        if #params == 2 then
          rank = tonumber(params[1])
          res = tonumber(params[2])
          rankInfoStyleCfg[rank] = res
        end
      end
    end
    rankInfoStyleDefaultCfg = tonumber(curCfg.RankInfoStyleDefault)
  end
  local cellType = self._itemInfo.cellType
  local rank = self._itemInfo.rank
  local rankStyle = rankInfoStyleDefaultCfg
  if rankInfoStyleCfg[rank] then
    rankStyle = rankInfoStyleCfg[rank]
  end
  if self._rankInfoAreaGo1 then
    self._rankInfoAreaGo1:SetActive(rankStyle == 1)
  end
  if self._rankInfoAreaGo2 then
    self._rankInfoAreaGo2:SetActive(rankStyle == 2)
  end
  if self.atlas then
    local playerInfoBgRes = cellFrontBgDefaultCfg
    if cellFrontBgCfg[rank] then
      playerInfoBgRes = cellFrontBgCfg[rank]
    end
    if self._playerInfoBg then
      self._playerInfoBg.sprite = self.atlas:GetSprite(playerInfoBgRes)
    end
    local bgRes = cellBgDefaultCfg
    if cellBgCfg[rank] then
      bgRes = cellBgCfg[rank]
    end
    if self._rewardBgImg then
      self._rewardBgImg.sprite = self.atlas:GetSprite(bgRes)
    end
  end
end

function UIN5ProgressItem:GetRewardOnClick(go)
  if self._callback then
    self._callback(self._index)
  end
end

function UIN5ProgressItem:_CalcState(target, cur, received)
  local state = 0
  if target <= cur then
    state = 1
    for _, x in pairs(received) do
      if x == target then
        state = 2
      end
    end
  end
  return state
end

function UIN5ProgressItem:OpenDetailTextBtnOnClick(go)
  if self._closeDetailAreaGo then
    self._closeDetailAreaGo:SetActive(true)
  end
  if self._openDetailAreaGo then
    self._openDetailAreaGo:SetActive(false)
  end
  if self._rankInfoTextBgRect then
    local height = 228
    height = self._rankInfoText.preferredHeight + 15
    local x = self._rankInfoTextBgRect.sizeDelta.x
    self._rankInfoTextBgRect.sizeDelta = Vector2(x, height)
  end
  self._detailExpanded = true
  if self._onExpandCallBack then
    self._onExpandCallBack()
  end
end

function UIN5ProgressItem:CloseDetailTextAreaOnClick(go)
  if self._openDetailAreaGo then
    self._openDetailAreaGo:SetActive(true)
  end
  if self._closeDetailAreaGo then
    self._closeDetailAreaGo:SetActive(false)
  end
  if self._rankInfoTextBgRect then
    self._rankInfoTextBgRect.sizeDelta = self._baseRankInfoTextBgRectSize
  end
  self._detailExpanded = false
end

function UIN5ProgressItem:_OnScrollDragBegin()
  if self._detailExpanded then
    self:CloseDetailTextAreaOnClick(nil)
  end
end
