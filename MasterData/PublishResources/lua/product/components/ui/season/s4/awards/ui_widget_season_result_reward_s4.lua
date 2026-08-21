_class("UIWidgetSeasonResultRewardS4", UICustomWidget)
UIWidgetSeasonResultRewardS4 = UIWidgetSeasonResultRewardS4

function UIWidgetSeasonResultRewardS4:OnShow()
  self._trans = self:GetGameObject()
  self._itemID = nil
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UISeasonResultItemS4")
  self.uiItem:SetForm(UIItemForm.Result, nil, true)
  self.uiItem:SetClickCallBack(function()
    self:BGOnClick()
  end)
  self.effStartTime = 2150
end

function UIWidgetSeasonResultRewardS4:SetShotEffStartTime()
  self.effStartTime = 750
end

function UIWidgetSeasonResultRewardS4:Init(count, iconID, threeStar, returnPrism, firstPass, extAward, doubleExtAward, activityAward, returnHelpAward)
  local itemCfg = Cfg.cfg_item
  local templateData = itemCfg[iconID]
  local taskID = -1
  if templateData then
    local showNumber = false
    self._itemID = iconID
    local icon = itemCfg[iconID].Icon
    local quality = templateData.Color
    local text1 = count
    local resultType = UIItemResultType.None
    local resultText = ""
    local normalText = ""
    local activityText = ""
    local returnHelpText = ""
    if threeStar then
      resultType = UIItemResultType.ThreeStar
      taskID = self:StartTask(function(TT)
        YIELD(TT, self.effStartTime)
        self.uiItem:PlayAni("uieff_UiItem_GetSpecialItem")
      end)
    elseif firstPass then
      resultType = UIItemResultType.First
      taskID = self:StartTask(function(TT)
        YIELD(TT, self.effStartTime)
        self.uiItem:PlayAni("uieff_UiItem_GetSpecialItem")
      end)
    elseif extAward then
      resultType = UIItemResultType.Ext
    elseif doubleExtAward then
      resultType = UIItemResultType.DoubleExt
    elseif returnPrism then
      resultType = UIItemResultType.Result
      if returnPrism == 1 then
        resultText = StringTable.Get("str_battle_return_prism")
        showNumber = true
      elseif returnPrism == 2 then
        resultText = StringTable.Get("str_battle_return_double")
      else
        resultText = StringTable.Get("str_battle_failed_return", returnPrism)
      end
    elseif activityAward then
      activityText = StringTable.Get("str_item_xianshi")
    elseif returnHelpAward then
      returnHelpText = StringTable.Get("str_return_system_reward_title")
    else
      resultType = UIItemResultType.Normal
      normalText = self:GetNormalTxt()
    end
    self.uiItem:SetData({
      icon = icon,
      quality = quality,
      text1 = text1,
      showNumber = showNumber,
      resultType = resultType,
      resultText = resultText,
      normalText = normalText,
      itemId = self._itemID,
      activityText = activityText,
      returnHelpText = returnHelpText
    })
  end
  return taskID
end

function UIWidgetSeasonResultRewardS4:GetNormalTxt()
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  local isNormal = true
  if MatchType.MT_Mission == enterData._match_type then
    local missionID = enterData:GetMissionCreateInfo().mission_id
    local dataList = UICommonHelper:GetInstance():GetPassAward(AwardHeadType.Mission, missionID)
    isNormal = self:HasItem(dataList)
  elseif MatchType.MT_ExtMission == enterData._match_type then
    local createData = enterData:GetMissionCreateInfo()
    local dataList = UICommonHelper:GetInstance():GetPassAward(AwardHeadType.ExtMisson, createData.m_nExtTaskID)
    isNormal = self:HasItem(dataList)
  elseif MatchType.MT_ResDungeon == enterData._match_type then
    local createData = enterData:GetResDungeonInfo()
    local dataList = UICommonHelper:GetInstance():GetPassAward(AwardHeadType.ResInstance, createData.res_dungeon_id)
    isNormal = self:HasItem(dataList)
  end
  if isNormal then
    return StringTable.Get("str_season_normal_award")
  else
    return StringTable.Get("str_season_normal_award")
  end
end

function UIWidgetSeasonResultRewardS4:HasItem(dataList)
  local isNormal = false
  if dataList then
    for i, v in ipairs(dataList) do
      if v.ItemID == self._itemID then
        isNormal = true
        break
      end
    end
  end
  return isNormal
end

function UIWidgetSeasonResultRewardS4:BGOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetSeasonResultRewardS4",
    input = "BGOnClick",
    args = {}
  })
  if self._itemID then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._itemID, self._trans.transform.position)
  end
end

function UIWidgetSeasonResultRewardS4:SetLevelDiff(levelDiff)
  local typeMainBg = "exp_s4_map_daoju_di01"
  if levelDiff then
    if levelDiff == UISeasonLevelDiff.Normal then
      typeMainBg = "exp_s4_map_daoju_di01"
    elseif levelDiff == UISeasonLevelDiff.Hard then
      typeMainBg = "exp_s4_map_daoju_di02"
    end
  end
  local atlasName = "UIS4Scene.spriteatlas"
  self.uiItem:SetBtnImageByName(typeMainBg, atlasName)
end
