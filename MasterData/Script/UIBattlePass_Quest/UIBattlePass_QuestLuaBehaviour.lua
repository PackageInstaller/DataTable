local View = require("UIBattlePass_Quest/UIBattlePass_QuestView")
local DataModel = require("UIBattlePass_Quest/UIBattlePass_QuestDataModel")
local ViewFunction = require("UIBattlePass_Quest/UIBattlePass_QuestViewFunction")
local PassData = require("UIBattlePass_Quest/UIBattlePass")
local QuestData = require("UIBattlePass_Quest/UIBattleQuest")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.Serialize())
  end,
  deserialize = function(initParams)
    DataModel.SerializeList = {}
    DataModel.diffTime = -1
    local openPayPanel
    if initParams then
      local data = Json.decode(initParams)
      if data.openPay then
        openPayPanel = data.openPay
      else
        DataModel.SerializeList = data
      end
    end
    DataModel.isActive = false
    DataModel.InitTabList()
    if openPayPanel then
      DataModel.ClickPayPage()
      View.self:PlayAnim("buyBpIn")
      View.Group_Pay.Group_Right.Group_Price1.Img_Icon:SetSprite(GetResPath(88300009))
      View.Group_Pay.Group_Right.Group_Price2.Img_Icon:SetSprite(GetResPath(88300010))
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.CA then
      local lastTime = TimeUtil:LastTime(DataModel.CA.PassEndTime)
      local Group_Common = View.Group_Reward_Quest.Group_Common
      if 0 < lastTime then
        DataModel.isActive = true
        local time = TimeUtil:SecondToTable(lastTime)
        if 0 < time.second then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600155), time.second))
        end
        if 0 < time.minute then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600154), time.minute))
        end
        if 0 < time.hour then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600152), time.hour, time.minute))
        end
        if 0 < time.day then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600150), time.day, time.hour))
        end
        if View.Group_Pay.self.IsActive then
          local Group_Right = View.Group_Pay.Group_Right
          Group_Right.Group_TimeLeft.Img_TimeLeft.Txt_TimeLeft:SetText(TimeUtil:GetBattlePassTime(time))
        end
      else
        DataModel.isActive = false
        Group_Common.Group_Left.Txt_LeftTime2a:SetText(GetText(80602313))
      end
    end
  end,
  ondestroy = function()
    DataModel.Clear()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
