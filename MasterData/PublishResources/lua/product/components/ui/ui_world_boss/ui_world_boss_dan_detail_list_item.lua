_class("UIWorldBossDanDetailListItem", UICustomWidget)
UIWorldBossDanDetailListItem = UIWorldBossDanDetailListItem

function UIWorldBossDanDetailListItem:Constructor()
end

function UIWorldBossDanDetailListItem:OnShow(uiParams)
  self:InitWidget()
end

function UIWorldBossDanDetailListItem:InitWidget()
  self._danText = self:GetUIComponent("UILocalizationText", "DanText")
  self._danTextGo = self:GetGameObject("DanText")
  self._danText1 = self:GetUIComponent("UILocalizationText", "DanText1")
  self._danText1Go = self:GetGameObject("DanText1")
  self._danExtraText = self:GetUIComponent("UILocalizationText", "DanExtraText")
  self._danExtraTextGo = self:GetGameObject("DanExtraText")
  self._normalConditionAreaGo = self:GetGameObject("NormalConditionArea")
  self._specialConditionAreaGo = self:GetGameObject("SpecialConditionArea")
  self._conditionText = self:GetUIComponent("UILocalizationText", "ConditionText")
  self._specialDonditionText = self:GetUIComponent("UILocalizationText", "SpConditionText")
  self._rewardList = self:GetGameObject("RewardList")
  self._selectFlagGo = self:GetGameObject("SelectFlag")
  self._imgLegendInfo = self:GetUIComponent("RectTransform", "imgLegendInfo")
  self._loadBadgeIcon = self:GetUIComponent("RawImageLoader", "BadgeIcon")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIWorldBossDanDetailListItem:SetIndex(itemIndex)
  self._itemIndex = itemIndex
end

function UIWorldBossDanDetailListItem:GetIndex()
  return self._itemIndex
end

function UIWorldBossDanDetailListItem:PlayAnimation(animName)
  self._animation:Play(animName)
end

function UIWorldBossDanDetailListItem:SetData(uiData, itemClickCallBack, spCondiTipsCallBack)
  self._bCurShowExtraText = false
  self._uiData = uiData
  self._itemClickCallBack = itemClickCallBack
  self._spCondiTipsCallBack = spCondiTipsCallBack
  self:_RefreshUi()
end

function UIWorldBossDanDetailListItem:_RefreshUi()
  self:DisposeCustomWidgets()
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeGen")
  self._spInfoImgGo = self:GetGameObject("SpInfoImg")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeGen")
  self._rewardGen = self:GetUIComponent("UISelectObjectPath", "Content")
  if self._uiData:IsPlayerCurDanData() then
    self._selectFlagGo:SetActive(true)
  else
    self._selectFlagGo:SetActive(false)
  end
  local nameStr = self._uiData:GetDanName()
  local bPlus = self._uiData:IsPlusDan()
  if nameStr then
    if bPlus then
      self._danText1:SetText(StringTable.Get(nameStr))
      self._danTextGo:SetActive(false)
      self._danText1Go:SetActive(true)
    else
      self._danText:SetText(StringTable.Get(nameStr))
      self._danTextGo:SetActive(true)
      self._danText1Go:SetActive(false)
    end
  end
  local condiStr = self._uiData:GetDanCondition()
  local bLegend = false
  local cfgRank = self._uiData:GetDanRankLevel()
  if 0 < cfgRank then
    bLegend = true
  end
  if bLegend then
    self._normalConditionAreaGo:SetActive(false)
    self._specialConditionAreaGo:SetActive(true)
    self._imgLegendInfo.gameObject:SetActive(true)
    self._danExtraTextGo:SetActive(false)
    local extraInfo = self._uiData:GetDanExtraInfo()
    if extraInfo then
      self._spCondiExtraInfo = extraInfo
      self._danExtraText:SetText(extraInfo)
      self._spInfoImgGo:SetActive(true)
    else
      self._spInfoImgGo:SetActive(false)
    end
    if condiStr then
      self._specialDonditionText:SetText(condiStr)
    end
  else
    self._normalConditionAreaGo:SetActive(true)
    self._specialConditionAreaGo:SetActive(false)
    self._imgLegendInfo.gameObject:SetActive(false)
    if condiStr then
      self._conditionText:SetText(condiStr)
    end
  end
  local cfgRank = self._uiData:GetDanRankLevel()
  UIWorldBossHelper.InitDanBadge(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._uiData:GetDanId(), cfgRank)
  local testShowBadge = false
  local rewardDatas = self._uiData:GetDanRewards()
  if rewardDatas and 0 < #rewardDatas then
    local totalCell = #rewardDatas
    if testShowBadge then
      totalCell = totalCell + 1
    end
    self._rewardGen:SpawnObjects("UIWorldBossDanRewardItem", totalCell)
    local rewardCells = self._rewardGen:GetAllSpawnList()
    if rewardCells then
      for index, value in ipairs(rewardCells) do
        local bIsBadge = false
        if testShowBadge and index == totalCell then
          local cfgRank = self._uiData:GetDanRankLevel()
          if 0 < cfgRank then
            cfgRank = 1
          end
          value:SetData(nil, nil, self._uiData:GetDanId(), cfgRank)
          bIsBadge = true
        end
        if not bIsBadge then
          value:SetData(rewardDatas[index], self._itemClickCallBack)
        end
      end
    end
  end
  if self._loadBadgeIcon ~= nil then
    local danId = self._uiData:GetDanId()
    local rankLevel = cfgRank
    if UIWorldBossHelper.IsNoDan(danId, rankLevel) then
      self._loadBadgeIcon.gameObject:SetActive(false)
    else
      self._loadBadgeIcon.gameObject:SetActive(true)
      local badgeBase = UIWorldBossHelper.GetDanBadgeBaseSimple(danId, 0)
      self._loadBadgeIcon:LoadImage(badgeBase)
    end
  end
end

function UIWorldBossDanDetailListItem:SpInfoImgOnClick(go)
  if self._spCondiTipsCallBack and self._spCondiExtraInfo then
    self._spCondiTipsCallBack(go, self._spCondiExtraInfo)
  end
end

function UIWorldBossDanDetailListItem:ImgLegendInfoOnClick(go)
  self:ShowDialog("UIWorldBossLegendDan")
end
