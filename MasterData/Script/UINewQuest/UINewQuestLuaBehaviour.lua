local View = require("UINewQuest/UINewQuestView")
local DataModel = require("UINewQuest/UINewQuestDataModel")
local Controller = require("UINewQuest/UINewQuestController")
local ViewFunction = require("UINewQuest/UINewQuestViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    print_r(PlayerData.ServerData.liveness_rewards)
    print_r(PlayerData:GetBattlePass())
    print_r(PlayerData.ServerData.quests)
    DataModel.CurQuestType = 0
    DataModel.WeekSelectIdx = PlayerData.ServerData.quests.unlock_week + 1
    DataModel.RefreshAllInfo()
    Controller:RefreshAll()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.CurQuestType == DataModel.QuestType.Weekly then
      local totalInfo = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx]
      if totalInfo ~= nil and #totalInfo.questList == 0 then
        Controller:RefreshWeekCountDownTime(DataModel.WeekSelectIdx)
      end
    end
    local curTime = os.date("*t", TimeUtil:GetServerTimeStamp())
    if DataModel.TodayInfo.day ~= curTime.day then
      Net:SendProto("quest.list", function(json)
        PlayerData.ServerData.quests = json.quests
        Controller:ZeroRefresh()
      end, EnumDefine.QuestListDefine.BattlePassQuest)
    end
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
