local View = require("UIChildActivity/UIChildActivityView")
local DataModel = require("UIChildActivity/UIChildActivityDataModel")
local ViewFunction = require("UIChildActivity/UIChildActivityViewFunction")
local Controller = require("UIChildActivity/UIChildActivityController")
local param
local Luabehaviour = {
  serialize = function()
    return param
  end,
  deserialize = function(initParams)
    param = initParams
    local data = Json.decode(initParams)
    DataModel.Init(data.activityId, data.closeTime)
    Controller.QuestIsFinish(DataModel.questId, DataModel.skipQuestId, DataModel.levelQuestId)
    Controller.RefreshPanelDot(DataModel.cardPackId)
    View.Group_Bg.Img_Icon:SetSprite(GetResPath(88300326))
    View.Group_NotJoin.Group_Add.Group_Can.Img_:SetSprite(GetResPath(88300327))
    View.Group_NotJoin.Group_Add.Group_Quest.Img_:SetSprite(GetResPath(88300327))
    View.Group_NotJoin.Group_Add.Group_Finish.Img_bg:SetSprite(GetResPath(88300327))
    View.Group_Join.Group_Store.Img_:SetSprite(GetResPath(88300328))
    View.Group_Join.Group_Card.Img_main:SetSprite(GetResPath(88300329))
    View.Group_Join.Btn_Gacha.Img_:SetSprite(GetResPath(88300330))
    View.Group_Join.Group_Rank.Img_:SetSprite(GetResPath(88300331))
    View.Group_Join.Group_Quest.Img_:SetSprite(GetResPath(88300332))
    View.Group_Join.Group_Level.Group_Can.Img_:SetSprite(GetResPath(88300333))
    View.Group_Join.Group_Level.Group_Quest.Img_:SetSprite(GetResPath(88300333))
    View.Group_Join.Group_Finish.Img_:SetSprite(GetResPath(88300333))
    View.Group_Join.Group_Level.Group_Skin.Img_Bg:SetSprite(GetResPath(88300335))
    View.Group_Join.Group_Level.Group_SignBattle.Img_:SetSprite(GetResPath(88300334))
    local startY = string.sub(DataModel.startTime, 1, 4) or 0
    local startMonth = string.sub(DataModel.startTime, 6, 7) or 0
    local startDay = string.sub(DataModel.startTime, 9, 10) or 0
    local endY = string.sub(DataModel.endTime, 1, 4) or 0
    local endMonth = string.sub(DataModel.endTime, 6, 7) or 0
    local endDay = string.sub(DataModel.endTime, 9, 10) or 0
    View.Group_Time.Txt_StartTime:SetText(string.format(GetText(80612558), startY .. "/" .. startMonth .. "/" .. startDay))
    View.Group_Time.Txt_EndTime:SetText(string.format(GetText(80611407), endY .. "/" .. endMonth .. "/" .. endDay))
    View.Group_Join:SetActive(DataModel.isJoin)
    View.Group_NotJoin:SetActive(not DataModel.isJoin)
    local isOver = DataModel.ActivityOver()
    if not DataModel.isJoin then
      View.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.rewardPreviewList)
      View.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
      View.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:MoveToTop()
      View.Group_NotJoin.Group_Add.Group_Can:SetActive(DataModel.isCanJoin and not isOver)
      View.Group_NotJoin.Group_Add.Group_Quest:SetActive(not DataModel.isCanJoin and not isOver)
      View.Group_NotJoin.Group_Add.Group_Quest.Txt_Quest:SetText(DataModel.unlockTip)
      local remainDay = string.format(GetText(80607097), DataModel.GetRemainDays())
      View.Group_NotJoin.Group_Add.Group_Quest.Txt_Time:SetText(remainDay)
      View.Group_NotJoin.Group_Add.Group_Can.Txt_Time:SetText(remainDay)
      View.Group_NotJoin.Group_Add.Group_Finish:SetActive(isOver)
      if isOver then
        View.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText(DataModel.GetCloseTimeInfo())
      end
    else
      View.Group_Join.Group_Finish:SetActive(isOver)
      View.Group_Join.Group_Level:SetActive(not isOver)
      if DataModel.skipQuestId == 0 or DataModel.skipQuestId == -1 or DataModel.skipQuestId == nil then
        View.Group_Join.Group_Skip:SetActive(false)
      else
        View.Group_Join.Group_Skip:SetActive(not isOver)
      end
      View.Group_Join.Group_Skip.Group_Can:SetActive(not DataModel.sideQuestIsComplete)
      if DataModel.skipQuestId == 0 or DataModel.skipQuestId == -1 or DataModel.skipQuestId == nil then
        View.Group_Join.Group_Skip.Group_Finish:SetActive(false)
      else
        View.Group_Join.Group_Skip.Group_Finish:SetActive(DataModel.sideQuestIsComplete)
      end
      View.Group_Join.Group_Level.Group_Quest:SetActive(not DataModel.levelQuestIsComplete)
      local questCa = PlayerData:GetFactoryData(DataModel.levelQuestId)
      if questCa then
      end
      if isOver then
        View.Group_Join.Group_Finish.Txt_Time:SetText(DataModel.GetCloseTimeInfo())
      end
      if 0 < DataModel.SighBattleShow then
        View.Group_Join.Group_Level.Group_SignBattle:SetActive(true)
      end
      View.Group_Join.Group_Store.Txt_Num:SetText(PlayerData:GetGoodsById(11400962).num or 0)
    end
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
