local View = require("UISignBattleLevelRuby/UISignBattleLevelRubyView")
local DataModel = require("UISignBattleLevelRuby/UISignBattleLevelRubyDataModel")
local Controller = {}

function Controller:Init(id)
  DataModel:Init(id)
  View.Group_SpLevelDetails.self:SetActive(false)
  View.ScrollGrid_Map.grid.self:SetDataCount(DataModel.listCount)
  View.ScrollGrid_Map.grid.self:RefreshAllElement()
  View.ScrollGrid_Map.grid.self:MoveToPos(DataModel.GetCurrentIndex())
  local cur = 0
  local cs_activity = DataModel.signBattleData
  local data = cs_activity[tostring(DataModel.activityCA.id)]
  if data then
    cur = #data.pass_level_index
  end
  local progress = cur / #DataModel.activityCA.signLevelList
  progress = 1 < progress and 1 or progress
  View.Txt_Progress:SetText(PlayerData:GetPreciseDecimalFloor(progress * 100, 0) .. "%")
  View.Img_Bg2.Img_P:SetFilledImgAmount(progress)
  local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
  local isQuestFinish = DataModel.activityCA.questId ~= -1 and ActivityMainDataModel:QuestIsFinish(DataModel.activityCA.questId) == true or DataModel.activityCA.questId == -1
  View.Btn_Gacha:SetActive(isQuestFinish and TimeUtil:IsActive(DataModel.activityCA.startTime, DataModel.activityCA.endTime))
  View.Img_BG:SetActive(true)
  View.Img_BG2:SetActive(false)
end

function Controller:SetElement(element, elementIndex)
  local index = elementIndex
  element.Group_Level.Group_Current.Btn_Level:SetClickParam(index - 1)
  local currentState = false
  if index == DataModel.GetCurrentIndex() + 2 and DataModel.GetCurrentIndex() <= DataModel.GetUnlockIndex() then
    currentState = not DataModel.GetFinishIndex(index - 1)
  end
  element.Group_Level:SetActive(1 < index and index < DataModel.listCount)
  element.Group_Level.Group_UnLock:SetActive(index <= DataModel.GetUnlockIndex() + 2 and not DataModel.GetFinishIndex(index - 1))
  element.Group_Level.Group_Current:SetActive(currentState or index == DataModel.listCount - 1 and DataModel.GetFinishIndex(index - 1))
  element.Group_Level.Group_Current.Txt_T:SetActive(not DataModel.GetFinishIndex(index - 1))
  element.Group_Level.Group_Current.Txt_T2:SetActive(DataModel.GetFinishIndex(index - 1))
  element.Group_Level.Group_Finish:SetActive(DataModel.GetFinishIndex(index - 1) and index ~= DataModel.listCount - 1)
  element.Group_Level.Group_Lock:SetActive(index > DataModel.GetUnlockIndex() + 2)
  element.Group_Level.Group_Lock.Txt_T:SetActive(index == DataModel.GetUnlockIndex() + 3)
  element.Group_Level.Group_Lock.Txt_T2:SetActive(index ~= DataModel.GetUnlockIndex() + 3)
  element.Group_Level.Txt_Index:SetText("0" .. index - 1)
  local y = 0
  if (index - 1) % 2 == 1 then
    y = 80
  else
    y = -120
  end
  element.self:SetLocalPositionY(y)
end

function Controller:OpenRightPage(index)
  if index == 0 or index == DataModel.listCount - 1 then
    return
  end
  local data = DataModel.signBattleLevelList[index]
  if data == nil then
    return
  end
  local lastIndex = DataModel.openIndex
  DataModel.openIndex = index
  if index == lastIndex then
    return
  end
  View.ScrollGrid_Map.grid.self:RefreshAllElement()
  View.Group_SpLevelDetails.self:SetActive(true)
  local levelData = PlayerData:GetFactoryData(data.id, "LevelFactory")
  DataModel.chooseLevelData = levelData
  View.Group_SpLevelDetails.Txt_Name:SetText(levelData.levelName)
  View.Group_SpLevelDetails.Txt_Grade:SetText(string.format(GetText(80609197), levelData.recomGrade))
  View.Group_SpLevelDetails.Txt_Des:SetText(levelData.description)
  DataModel:SetDropList(levelData)
  if table.count(DataModel.dropList) ~= 0 then
    View.Group_SpLevelDetails.ScrollGrid_Reward.self:SetActive(true)
    View.Group_SpLevelDetails.ScrollGrid_Reward.grid.self:SetDataCount(table.count(DataModel.dropList))
    View.Group_SpLevelDetails.ScrollGrid_Reward.grid.self:RefreshAllElement()
    View.Group_SpLevelDetails.ScrollGrid_Reward.grid.self:MoveToTop()
  else
    View.Group_SpLevelDetails.ScrollGrid_Reward.self:SetActive(false)
  end
  View.Img_BG:SetActive(false)
  View.Img_BG2:SetActive(true)
end

function Controller:TryBattle()
  local info = DataModel.chooseLevelData
  local levelId = info.id
  local levelCA = info
  local levelDifficulty = PlayerData:GetLevelDifficulty(levelId)
  
  local function doSquad()
    if CommonTips.OpenBuyEnergyTips(levelId, nil, nil, nil, levelDifficulty) then
      return
    end
    local status = {
      Current = "Chapter",
      squadIndex = PlayerData.BattleInfo.squadIndex,
      hasOpenThreeView = false,
      difficulty = levelDifficulty,
      isAutoBattle = false,
      csActivityId = DataModel.activityCA.id,
      csIndex = DataModel.GetCurrentIndex()
    }
    local t = {}
    t.activityId = DataModel.activityCA.id
    t.index = DataModel.openIndex
    t.isBattleReturn = true
    status.extraUIParamData = t
    PlayerData.BattleInfo.battleStageId = levelId
    PlayerData.BattleCallBackPage = DataModel.activityCA.signBattleUI
    UIManager:Open("UI/Squads/Squads", Json.encode(status))
  end
  
  if not levelCA.isEnemyLvEquilsPlayer and levelCA.recomGrade + levelCA.extraLevelOffset * (levelDifficulty - 1) - PlayerData:GetPlayerLevel() >= 5 then
    local checkTipParam = {}
    checkTipParam.isCheckTip = true
    checkTipParam.checkTipKey = "SignBattleLevelRubyTip"
    checkTipParam.checkTipType = 1
    checkTipParam.showDanger = true
    checkTipParam.showSafe = true
    CommonTips.OnPrompt(80601227, nil, nil, doSquad, nil, nil, nil, nil, checkTipParam)
  else
    doSquad()
  end
end

function Controller:CloseChoose()
  View.Img_BG:SetActive(true)
  View.Img_BG2:SetActive(false)
  View.Group_SpLevelDetails.self:SetActive(false)
  View.ScrollGrid_Map.grid.self:RefreshAllElement()
  DataModel.openIndex = nil
end

return Controller
