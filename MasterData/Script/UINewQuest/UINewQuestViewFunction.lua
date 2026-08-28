local View = require("UINewQuest/UINewQuestView")
local Controller = require("UINewQuest/UINewQuestController")
local DataModel = require("UINewQuest/UINewQuestDataModel")
local ViewFunction = {
  NewQuest_Img_ZC_Btn_Effect_Click = function(btn, str)
    local totalInfo = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx]
    local isLock = #totalInfo.questList == 0
    if isLock == true then
      return
    end
    CommonTips.OnPrompt(80600256, nil, nil, function()
      Net:SendProto("quest.change", function(json)
        PlayerData.ServerData.quests.unlock_week = DataModel.WeekSelectIdx - 1
        View.Img_ZC.ScrollGrid_WeekSwitch.grid.self:RefreshAllElement()
        View.Img_ZC.Btn_Effect.self:SetActive(false)
        View.Img_ZC.Btn_NotEffect.self:SetActive(true)
        View.Group_Main.Txt_EffectTips:SetActive(false)
      end, DataModel.WeekSelectIdx - 1)
    end)
  end,
  NewQuest_Img_ZC_Btn_NotEffect_Click = function(btn, str)
  end,
  NewQuest_Img_ZC_ScrollGrid_WeekSwitch_SetGrid = function(element, elementIndex)
    local totalInfo = DataModel.WeeklyQuestInfo[elementIndex]
    local info = totalInfo.questList
    local text = string.format(GetText(80600276), elementIndex)
    local isSelected = DataModel.WeekSelectIdx == elementIndex
    local questCount = #info
    if isSelected then
      element.Txt_SelectWeek:SetText(text)
      element.Txt_SelectSuccessNum:SetText(totalInfo.recvCount .. "/" .. questCount)
    else
      element.Txt_Week:SetText(text)
      element.Txt_SuccessNum:SetText(totalInfo.recvCount .. "/" .. questCount)
    end
    local isActive = elementIndex == PlayerData.ServerData.quests.unlock_week + 1
    local lock = questCount == 0
    element.Txt_SelectWeek:SetActive(isSelected)
    element.Txt_SelectSuccessNum:SetActive(isSelected and not lock)
    element.Txt_Week:SetActive(not isSelected)
    element.Txt_SuccessNum:SetActive(not isSelected and not lock)
    element.Img_Select:SetActive(isSelected)
    element.Img_Effect:SetActive(isActive)
    element.Img_NotPass:SetActive(not isSelected and lock)
    element.Img_SelectNotPass:SetActive(isSelected and lock)
    element.Btn_S:SetClickParam(elementIndex)
  end,
  NewQuest_Img_ZC_ScrollGrid_WeekSwitch_Group_Item_Btn_S_Click = function(btn, str)
    local idx = tonumber(str)
    DataModel.WeekSelectIdx = idx
    Controller:RefreshWeeklyQuestPanelDetail(idx)
    View.Img_ZC.ScrollGrid_WeekSwitch.grid.self:RefreshAllElement()
  end,
  NewQuest_Group_Main_Group_BattlePassGrade_Btn_BattlePass_Click = function(btn, str)
  end,
  NewQuest_Group_Main_Group_BattlePassGrade_Group_BattlePassBox_Btn_OpenBox_Click = function(btn, str)
    local state, battlePassId, passInfo = PlayerData:GetNowPassData()
    if state == false then
      return
    end
    local passKind = passInfo and passInfo.kind or 1
    local passData = PlayerData:GetBattlePass(passKind)
    if passData == nil then
      return
    end
    Net:SendProto("battle_pass.multi_pass_rewards", function(json)
      CommonTips.OpenShowItem(json.reward)
      passData.pass_level = (passData.pass_level or 0) + 1
      local seasonBattle = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
      local needExp = seasonBattle.Points
      passData.points = (passData.points or 0) - needExp
      Controller:RefreshBattlePassGrade()
    end, passKind, 0, passData.pass_level, 0)
  end,
  NewQuest_Group_Main_Group_BattlePassGrade_Group_BattlePassBox_Btn_CloseBox_Click = function(btn, str)
    local state, battlePassId, passInfo = PlayerData:GetNowPassData()
    if state == false then
      return
    end
    local passData = PlayerData:GetBattlePass(passInfo and passInfo.kind or 1)
    if passData == nil then
      return
    end
    local seasonBattle = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
    local passRewardList = seasonBattle.PassRewardList
    local curBattlePassLv = passData.pass_level
    if curBattlePassLv > #passRewardList then
      return
    end
    View.Group_BoxPreview.self:SetActive(true)
    local previewReward = passRewardList[curBattlePassLv]
    local itemId = previewReward.freeID
    local factoryName = DataManager:GetFactoryNameById(itemId)
    local data = PlayerData:GetFactoryData(itemId, factoryName)
    View.Group_BoxPreview.Group_Item.Img_Item:SetSprite(data.iconPath)
    View.Group_BoxPreview.Group_Item.Txt_Num:SetText(previewReward.freeNum)
    View.Group_BoxPreview.Group_Item.Btn_Item:SetClickParam(itemId)
    View.Group_BoxPreview.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
    View.Group_BoxPreview.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
  end,
  NewQuest_Group_Main_Group_DailyBox_Btn_Box_Click = function(btn, str)
    if DataModel.DailyBoxStatus == 1 then
      Net:SendProto("item.recv_liveness_rewards", function(json)
        CommonTips.OpenShowItem(json.reward)
        if PlayerData.ServerData.liveness_rewards == nil then
          PlayerData.ServerData.liveness_rewards = {}
        end
        PlayerData.ServerData.liveness_rewards[tostring(DataModel.DailyBoxIndex)] = TimeUtil:GetServerTimeStamp()
        Controller:RefreshDailyBox()
        DataModel.DailyBoxIndex = DataModel.DailyBoxIndex + 1
      end, DataModel.DailyBoxIndex)
    elseif DataModel.DailyBoxStatus == 0 then
      View.Group_DayPreview.self:SetActive(true)
      local dailyQuestConfig = PlayerData:GetFactoryData(99900010, "ConfigFactory")
      local apRewardList = dailyQuestConfig.apRewardList
      local curInfo = apRewardList[1]
      local itemId = curInfo.id
      local factoryName = DataManager:GetFactoryNameById(itemId)
      local data = PlayerData:GetFactoryData(itemId, factoryName)
      View.Group_DayPreview.Group_Item.Img_Item:SetSprite(data.iconPath)
      View.Group_DayPreview.Group_Item.Txt_Num:SetText(curInfo.num)
      View.Group_DayPreview.Group_Item.Btn_Item:SetClickParam(itemId)
      View.Group_DayPreview.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
      View.Group_DayPreview.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
    end
  end,
  NewQuest_Group_Main_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  NewQuest_Group_Main_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  NewQuest_Group_Main_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  NewQuest_Group_Main_Group_BottomBar_Btn_Get_Click = function(btn, str)
    local isDaily = DataModel.CurQuestType == DataModel.QuestType.Daily
    local questType = isDaily and "Daily" or "Weekly"
    local noWeek = isDaily and -1 or DataModel.WeekSelectIdx - 1
    local _, _, passInfo = PlayerData:GetNowPassData()
    local passKind = passInfo and passInfo.kind or 1
    Net:SendProto("quest.multi_pass_rec_quests_rewards", function(json)
      CommonTips.OpenShowItem(json.reward)
      local t = {}
      if isDaily then
        t = DataModel.AcceptedQuestInfo
      else
        t = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx].questList
      end
      for k, v in pairs(t) do
        if v.pcnt == v.maxPcnt and v.recv == 0 then
          if isDaily then
            PlayerData.ServerData.quests.daily_quests[tostring(v.id)].recv = TimeUtil:GetServerTimeStamp()
          else
            PlayerData.ServerData.quests.weekly_quests[tostring(DataModel.WeekSelectIdx - 1)][tostring(v.id)].recv = TimeUtil:GetServerTimeStamp()
          end
          v.recv = TimeUtil:GetServerTimeStamp()
          DataModel.CalcRewardToBattlePassScore(v.id)
        end
      end
      Controller:RefreshBattlePassGrade()
      if isDaily then
        Controller:RefreshDailyBox()
        DataModel.RefreshDailyQuestAcceptInfo()
        View.ScrollGrid_DailyQuestHurdle.grid.self:RefreshAllElement()
        local text = string.format(GetText(80600277), table.count(DataModel.AcceptedQuestInfo), DataModel.DailyQuestCanAcceptCount + DataModel.DailyDefaultQuestNum)
        View.Group_Main.Group_BottomBar.Txt_DailySuccessNum:SetText(text)
      else
        DataModel.RefreshWeeklyQuestInfo()
        View.Img_ZC.ScrollGrid_WeekSwitch.grid.self:RefreshAllElement()
        View.ScrollGrid_WeekQuestHurdle.grid.self:RefreshAllElement()
        local totalInfo = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx]
        local info = totalInfo.questList
        local text = string.format(GetText(80600278), totalInfo.recvCount, #info)
        View.Group_Main.Group_BottomBar.Txt_WeekSuccessNum:SetText(text)
      end
      View.Group_Main.Group_BottomBar.Btn_Get.self:SetActive(false)
    end, passKind)
  end,
  NewQuest_ScrollGrid_DailyQuestHurdle_SetGrid = function(element, elementIndex)
    local info = DataModel.AcceptedQuestInfo[elementIndex]
    if info == nil or info.id == nil then
      Controller:RefreshSingleDailyQuestRarityBg(element, 0)
      element.Group_txt.self:SetActive(false)
      element.Img_Empty.self:SetActive(true)
      element.Img_Empty.Btn_JRW:SetClickParam(elementIndex)
    else
      element.Img_Empty.self:SetActive(false)
      Controller:RefreshSingleQuestPanel(info, element, elementIndex)
      local isGet = 0 < info.recv
      element.Group_txt.Img_Complete:SetActive(isGet)
    end
  end,
  NewQuest_ScrollGrid_DailyQuestHurdle_Group_DailyItem_Group_txt_Btn_LQ_Click = function(btn, str)
    if str == nil then
      return
    end
    local idx = tonumber(str)
    local info = DataModel.AcceptedQuestInfo[idx]
    Net:SendProto("quest.recv_rewards", function(json)
      CommonTips.OpenShowItem(json.reward)
      DataModel.CalcRewardToBattlePassScore(info.id)
      PlayerData.ServerData.quests.daily_quests[tostring(info.id)].recv = TimeUtil:GetServerTimeStamp()
      info.recv = TimeUtil:GetServerTimeStamp()
      DataModel.RefreshDailyQuestAcceptInfo()
      Controller:RefreshBattlePassGrade()
      Controller:RefreshDailyBox()
      Controller:RefreshOneKeyGetShow(DataModel.AcceptedQuestInfo)
      View.ScrollGrid_DailyQuestHurdle.grid.self:RefreshAllElement()
      local text = string.format(GetText(80600277), table.count(DataModel.AcceptedQuestInfo), DataModel.DailyQuestCanAcceptCount + DataModel.DailyDefaultQuestNum)
      View.Group_Main.Group_BottomBar.Txt_DailySuccessNum:SetText(text)
    end, info.id)
  end,
  NewQuest_ScrollGrid_DailyQuestHurdle_Group_DailyItem_Img_Empty_Btn_JRW_Click = function(btn, str)
    Controller:RefreshQuestPondPanel()
  end,
  NewQuest_ScrollGrid_WeekQuestHurdle_SetGrid = function(element, elementIndex)
    local info = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx].questList[elementIndex]
    Controller:RefreshSingleQuestPanel(info, element, elementIndex)
    local isGet = info.recv > 0
    element.Group_txt.Img_Complete:SetActive(isGet)
  end,
  NewQuest_ScrollGrid_WeekQuestHurdle_Group_WeekItem_Group_txt_Btn_LQ_Click = function(btn, str)
    if str == nil then
      return
    end
    local idx = tonumber(str)
    local info = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx].questList[idx]
    Net:SendProto("quest.recv_rewards", function(json)
      CommonTips.OpenShowItem(json.reward)
      PlayerData.ServerData.quests.weekly_quests[tostring(DataModel.WeekSelectIdx - 1)][tostring(info.id)].recv = TimeUtil:GetServerTimeStamp()
      DataModel.RefreshWeeklyQuestInfo()
      DataModel.CalcRewardToBattlePassScore(info.id)
      info.recv = TimeUtil:GetServerTimeStamp()
      Controller:RefreshBattlePassGrade()
      Controller:RefreshOneKeyGetShow(DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx].questList)
      View.Img_ZC.ScrollGrid_WeekSwitch.grid.self:RefreshAllElement()
      View.ScrollGrid_WeekQuestHurdle.grid.self:RefreshAllElement()
      local totalInfo = DataModel.WeeklyQuestInfo[DataModel.WeekSelectIdx]
      local info = totalInfo.questList
      local text = string.format(GetText(80600278), totalInfo.recvCount, #info)
      View.Group_Main.Group_BottomBar.Txt_WeekSuccessNum:SetText(text)
    end, info.id, DataModel.WeekSelectIdx - 1)
  end,
  NewQuest_Group_QuestPond_Group_BottomBar_Btn_Confirm_Click = function(btn, str)
    if #DataModel.QuestPond == 0 then
      View.Group_QuestPond.self:SetActive(false)
      return
    end
    local selectCount = #DataModel.QuestPondSelect
    if 0 < selectCount then
      local idToNet = ""
      for k, v in pairs(DataModel.QuestPondSelect) do
        if idToNet == "" then
          idToNet = idToNet .. v
        else
          idToNet = idToNet .. "|" .. v
        end
      end
      CommonTips.OnPrompt(80600273, nil, nil, function()
        Net:SendProto("quest.receive_quests", function(json)
          for k, v in pairs(DataModel.QuestPondSelect) do
            for k1, v1 in pairs(PlayerData.ServerData.quests.daily_pool) do
              if v1 == v then
                table.remove(PlayerData.ServerData.quests.daily_pool, k1)
                break
              end
            end
            local t = {}
            t.pcnt = 0
            t.unlock = 1
            t.recv = 0
            PlayerData.ServerData.quests.daily_quests[tostring(v)] = t
          end
          DataModel.RefreshDailyQuestAcceptInfo()
          DataModel.RefreshQuestPondInfo()
          View.ScrollGrid_DailyQuestHurdle.grid.self:RefreshAllElement()
          local text = string.format(GetText(80600277), table.count(DataModel.AcceptedQuestInfo), DataModel.DailyQuestCanAcceptCount + DataModel.DailyDefaultQuestNum)
          View.Group_Main.Group_BottomBar.Txt_DailySuccessNum:SetText(text)
          View.Group_QuestPond.self:SetActive(false)
        end, idToNet)
      end)
    else
      CommonTips.OpenTips(80600254)
    end
  end,
  NewQuest_Group_QuestPond_Group_BottomBar_Btn_Cancel_Click = function(btn, str)
    DataModel.ClearQuestPondSelectInfo()
    View.Group_QuestPond.self:SetActive(false)
  end,
  NewQuest_Group_QuestPond_ScrollGrid_QuestPond_SetGrid = function(element, elementIndex)
    local info = DataModel.QuestPond[elementIndex]
    local questCA = PlayerData:GetFactoryData(info.id, "QuestFactory")
    Controller:RefreshSingleDailyQuestRarityBg(element, questCA.Rarity)
    element.Txt_QuestName:SetText(questCA.name)
    element.Txt_QuestDescribe:SetText(questCA.describe)
    local rewardList = questCA.rewardsList
    for k, v in pairs(rewardList) do
      if v.id ~= 11400013 then
        local itemFactory = PlayerData:GetFactoryData(v.id, "ItemFactory")
        element.Img_Award:SetSprite(itemFactory.iconPath)
        local rewardShow = itemFactory.name .. "x" .. v.num
        element.Txt_NotGet:SetText(rewardShow)
        break
      end
    end
    if info.select == true then
      Controller:RefreshSingleDailyQuestRaritySelect(element, questCA.Rarity)
    else
      Controller:RefreshSingleDailyQuestRaritySelect(element, 0)
    end
    element.Btn_Select:SetClickParam(elementIndex)
  end,
  NewQuest_Group_QuestPond_ScrollGrid_QuestPond_Group_Item_Btn_Select_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.QuestPond[idx]
    if info.select == true then
      info.select = false
      for k, v in pairs(DataModel.QuestPondSelect) do
        if v == info.id then
          table.remove(DataModel.QuestPondSelect, k)
          break
        end
      end
    else
      if #DataModel.QuestPondSelect >= DataModel.DailyQuestCanAcceptCount - DataModel.GetAccpetedQuestCount() then
        CommonTips.OpenTips(80600274)
        return
      end
      info.select = true
      table.insert(DataModel.QuestPondSelect, info.id)
    end
    View.Group_QuestPond.Group_BottomBar.Txt_Receive:SetText(string.format(GetText(80600275), #DataModel.QuestPondSelect, DataModel.DailyQuestCanAcceptCount - DataModel.GetAccpetedQuestCount()))
    View.Group_QuestPond.ScrollGrid_QuestPond.grid.self:RefreshAllElement()
  end,
  NewQuest_Group_DayPreview_Btn_Close_Click = function(btn, str)
    View.Group_DayPreview.self:SetActive(false)
  end,
  NewQuest_Group_DayPreview_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    local param = {}
    param.itemId = itemId
    CommonTips.OpenItem(param)
  end,
  NewQuest_Group_BoxPreview_Btn_Close_Click = function(btn, str)
    View.Group_BoxPreview.self:SetActive(false)
  end,
  NewQuest_Group_BoxPreview_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    local param = {}
    param.itemId = itemId
    CommonTips.OpenItem(param)
  end,
  NewQuest_Group_Main_Group_BottomBar_Btn_Day_Click = function(btn, str)
    Controller:RefreshChangeQuestType(DataModel.QuestType.Daily)
  end,
  NewQuest_Group_Main_Group_BottomBar_Btn_Week_Click = function(btn, str)
    if not DataModel.IsInPassBattleTime then
      CommonTips.OpenTips(80600283)
      return
    end
    Controller:RefreshChangeQuestType(DataModel.QuestType.Weekly)
  end,
  NewQuest_ScrollGrid_DailyQuestHurdle_Group_DailyItem_Group_txt_Btn_YL_Click = function(btn, str)
    local itemId = tonumber(str)
    local param = {}
    param.itemId = itemId
    CommonTips.OpenItem(param)
  end,
  NewQuest_ScrollGrid_WeekQuestHurdle_Group_WeekItem_Group_txt_Btn_YL_Click = function(btn, str)
    local itemId = tonumber(str)
    local param = {}
    param.itemId = itemId
    CommonTips.OpenItem(param)
  end
}
return ViewFunction
