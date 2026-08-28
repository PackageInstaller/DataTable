local View = require("UIActivitySignBattleLevelEmilie/UIActivitySignBattleLevelEmilieView")
local DataModel = require("UIActivitySignBattleLevelEmilie/UIActivitySignBattleLevelEmilieDataModel")
local ViewFunction = require("UIActivitySignBattleLevelEmilie/UIActivitySignBattleLevelEmilieViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.initParams)
  end,
  deserialize = function(initParams)
    DataModel.initParams = Json.decode(initParams)
    DataModel.activityId = DataModel.initParams.activityId
    DataModel:Init()
    View.Group_Main.Btn_Start.Txt_Time:SetText("")
    View.Group_Main.Img_Logo:SetSprite(GetResPath(88300336))
    Net:SendProto("activity.get_cs_activity", function(json)
      DataModel:SetSignBattleData(json)
      local state = DataModel:GetRewardButtonIsActive()
      DataModel.rewardState = state
      if DataModel.signBattleData[tostring(DataModel.activityCA.id)] then
        local end_ts = DataModel.signBattleData[tostring(DataModel.activityCA.id)].end_ts
        DataModel.end_Ts = end_ts
        local time = TimeUtil:GetNewTimeTable(end_ts)
        local show_time = time.month .. "/" .. time.day .. " " .. time.hour .. ":" .. time.min
        View.Group_Main.Btn_Start.Txt_Time:SetText(string.format(GetText(80610042), tostring(show_time)))
      end
      local cur = 0
      local cs_activity = DataModel.signBattleData
      local data = cs_activity[tostring(DataModel.activityCA.id)]
      if data then
        cur = #data.pass_level_index
      end
      local progress = cur / #DataModel.activityCA.signLevelList
      progress = 1 < progress and 1 or progress
      View.Group_Main.Txt_Progress:SetText(PlayerData:GetPreciseDecimalFloor(progress * 100, 0) .. "%")
      View.Group_Main.Img_Bg2.Img_P:SetFilledImgAmount(progress)
      if 0 < #DataModel.activityCA.signBattleRewards then
        View.Group_Main.Group_Reward.Btn_Reward.Group_Lock.self:SetActive(state == DataModel.BtnEnm.unFinish)
        View.Group_Main.Group_Reward.Btn_Reward.Group_On.self:SetActive(state == DataModel.BtnEnm.finish)
        View.Group_Main.Group_Reward.Btn_Reward.Group_Got.self:SetActive(state == DataModel.BtnEnm.receive)
      else
        View.Group_Main.Group_Reward.Btn_Reward.Group_Lock.self:SetActive(progress < 1)
        View.Group_Main.Group_Reward.Btn_Reward.Group_On.self:SetActive(false)
        View.Group_Main.Group_Reward.Btn_Reward.Group_Got.self:SetActive(progress == 1)
      end
      if state == DataModel.BtnEnm.finish and 0 < #DataModel.activityCA.signBattleRewards then
        Net:SendProto("activity.rec_cs_reward", function(json)
          DataModel.rewardState = DataModel.BtnEnm.receive
          CommonTips.OpenShowItem(json.reward)
          View.Group_Main.Group_Reward.Btn_Reward.Group_On.self:SetActive(false)
          View.Group_Main.Group_Reward.Btn_Reward.Group_Got.self:SetActive(true)
          local ActivityMainController = require("UIActivityMain/UIActivityMainController")
          ActivityMainController:RefreshLeftRedState()
        end, DataModel.activityCA.id)
      end
    end)
    local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    local isQuestFinish = DataModel.activityCA.questId ~= -1 and ActivityMainDataModel:QuestIsFinish(DataModel.activityCA.questId) == true or DataModel.activityCA.questId == -1
    DataModel.isQuestFinish = isQuestFinish
    View.Group_Main.Btn_Gacha:SetActive(isQuestFinish and TimeUtil:IsActive(DataModel.activityCA.startTime, DataModel.activityCA.endTime))
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
