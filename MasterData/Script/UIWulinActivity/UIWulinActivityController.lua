local View = require("UIWulinActivity/UIWulinActivityView")
local DataModel = require("UIWulinActivity/UIWulinActivityDataModel")
local ActivityMainController = require("UIActivityMain/UIActivityMainController")
local CardPackDataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local missionDataModel = require("UIWulinMission/UIWulinMissionDataModel")
local Controller = {}

function Controller.JoinActivity(isShunyi)
  if DataModel.isJoin then
    return
  end
  if isShunyi then
    Net:SendProto("main.participate", function(Jsons)
      if Jsons.activity then
        PlayerData.ServerData.all_activities.ing[tostring(DataModel.activityId)] = Jsons.activity
      end
      DataModel.JoinActivity()
    end, DataModel.activityId)
    return
  end
  Net:SendProto("main.participate", function(Jsons)
    if Jsons.activity then
      PlayerData.ServerData.all_activities.ing[tostring(DataModel.activityId)] = Jsons.activity
    end
    View.Group_Join.Group_Store.Txt_Num:SetText(PlayerData:GetGoodsById(11401048).num or 0)
    DataModel.JoinActivity()
    View.Group_Join:SetActive(DataModel.isJoin)
    View.Group_NotJoin:SetActive(not DataModel.isJoin)
    local isOver = DataModel.ActivityOver()
    View.Group_Join.Group_Finish:SetActive(isOver)
    View.Group_Join.Group_Level:SetActive(not isOver)
    if DataModel.skipQuestId == 0 or DataModel.skipQuestId == -1 or DataModel.skipQuestId == nil then
      View.Group_Join.Group_Skip:SetActive(false)
    else
      View.Group_Join.Group_Skip:SetActive(not isOver)
    end
    if isOver then
      View.Group_Join.Group_Finish.Txt_Time:SetText(DataModel.GetCloseTimeInfo())
    end
    require("UIActivityMain/UIActivityMainView").Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_Join.Group_Skip.Group_Finish:SetActive(DataModel.sideQuestIsComplete)
    View.Group_Join.Group_Level.Group_Quest:SetActive(not DataModel.levelQuestIsComplete)
  end, DataModel.activityId)
end

function Controller.QuestIsFinish(mainQuestId, activityQuestId, levelQuestId)
  local isFinish1 = false
  if mainQuestId == 0 or mainQuestId == -1 or mainQuestId == nil then
    isFinish1 = true
  else
    isFinish1 = ActivityMainController:QuestIsFinish(mainQuestId)
  end
  local isFinish2 = false
  if activityQuestId == 0 or activityQuestId == -1 or activityQuestId == nil then
    isFinish2 = true
  else
    isFinish2 = ActivityMainController:QuestIsFinish(activityQuestId)
  end
  local isFinish3 = false
  if levelQuestId == 0 or levelQuestId == -1 or levelQuestId == nil then
    isFinish3 = true
  else
    isFinish3 = ActivityMainController:QuestIsFinish(levelQuestId)
  end
  DataModel.SetIsCanJoin(isFinish1)
  DataModel.SetSideQuestStatus(isFinish2)
  DataModel.SetlevelQuestStatus(isFinish3)
end

function Controller.RefreshCardInfo(cardPackId)
  local info = CardPackDataModel.GetCardPackInfo(cardPackId)
  View.Group_Join.Group_Card.Img_RedPoint:SetActive(info.extraCardStatus == 1)
  View.Group_Join.Group_Card.Txt_Num:SetText(string.format(GetText(80611433), info.ownCount, info.allCount))
end

function Controller.RefreshQuestRedDot()
  local isRedDot = false
  if not missionDataModel then
    return false
  end
  isRedDot = missionDataModel.IsHadQuestCanGet(DataModel.activityId)
  View.Group_Join.Group_Quest.Img_RedPoint:SetActive(isRedDot)
  View.Group_Join.Group_Quest.Group_Progress.Txt_Num:SetText(string.format("%.0f%%", missionDataModel.GetQuestCompletePercent(DataModel.activityId) * 100))
end

function Controller.RefreshPanelDot(cardPackId)
  Controller.RefreshCardInfo(cardPackId)
  Controller.RefreshQuestRedDot()
end

function Controller.PanelRedDotStatus(activityId)
  local cfg = PlayerData:GetFactoryData(activityId)
  local isCanJoin = false
  if cfg.questId == 0 or cfg.questId == -1 or cfg.questId == nil then
    isCanJoin = true
  else
    isCanJoin = ActivityMainController:QuestIsFinish(cfg.questId)
  end
  if isCanJoin == false then
    return false
  end
  local cardPackId = cfg.activityCardPack
  local isJoin = PlayerData:GetActivityAct(activityId)
  if not isJoin then
    local serverTime = TimeUtil:GetServerTimeStamp()
    local enTime = TimeUtil:TimeStamp(cfg.endTime)
    if 0 < enTime - serverTime or cfg.isTriggerTime then
      return true
    end
  end
  local info = CardPackDataModel.GetCardPackInfo(cardPackId)
  if info.extraCardStatus == 1 then
    return true
  end
  if missionDataModel and missionDataModel.IsHadQuestCanGet(DataModel.activityId) == true then
    return true
  end
  return false
end

return Controller
