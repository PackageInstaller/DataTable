local View = require("UINewQuest/UINewQuestView")
local DataModel = require("UINewQuest/UINewQuestDataModel")
local Controller = {}

function Controller:RefreshAll()
  Controller:RefreshBattlePassGrade()
  Controller:RefreshDailyBox()
  Controller:RefreshCalendar()
  Controller:RefreshChangeQuestType(DataModel.QuestType.Daily)
end

function Controller:RefreshBattlePassGrade()
  View.Group_Main.Group_BattlePassGrade.self:SetActive(DataModel.IsInPassBattleTime)
  View.Group_Main.Txt_NotPassTips:SetActive(not DataModel.IsInPassBattleTime)
  if not DataModel.IsInPassBattleTime then
    return
  end
  local state, battlePassId, passInfo = PlayerData:GetNowPassData()
  if state then
    local seasonBattle = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
    local passData = PlayerData:GetBattlePass(passInfo and passInfo.kind or 1)
    if passData == nil then
      return
    end
    local needExp = seasonBattle.Points
    local curExp = passData.points or 0
    View.Group_Main.Group_BattlePassGrade.Txt_Level:SetText(passData.pass_level or 0)
    View.Group_Main.Group_BattlePassGrade.Img_NowGrade:SetFilledImgAmount(curExp / needExp)
    View.Group_Main.Group_BattlePassGrade.Txt_NowGrade:SetText(needExp <= curExp and needExp or curExp)
    View.Group_Main.Group_BattlePassGrade.Txt_Grade:SetText(needExp)
    local complete = needExp <= curExp
    View.Group_Main.Group_BattlePassGrade.Group_BattlePassBox.Btn_OpenBox:SetActive(complete)
    View.Group_Main.Group_BattlePassGrade.Group_BattlePassBox.Btn_CloseBox:SetActive(not complete)
  end
end

function Controller:RefreshDailyBox()
  local dayCompleteQuest = 0
  for k, v in pairs(PlayerData.ServerData.quests.daily_quests) do
    if 0 < v.recv then
      dayCompleteQuest = dayCompleteQuest + 1
    end
  end
  local dailyQuestConfig = PlayerData:GetFactoryData(99900010, "ConfigFactory")
  local apRewardList = dailyQuestConfig.apRewardList
  local idx = PlayerData.ServerData.liveness_rewards and table.count(PlayerData.ServerData.liveness_rewards) + 1 or 1
  local curInfo = apRewardList[idx]
  local needCompleteQuest = curInfo and curInfo.ap or apRewardList[idx - 1].ap
  dayCompleteQuest = dayCompleteQuest > needCompleteQuest and needCompleteQuest or dayCompleteQuest
  View.Group_Main.Group_DailyBox.Txt_QuestNum:SetText(dayCompleteQuest .. "/" .. needCompleteQuest)
  View.Group_Main.Group_DailyBox.Img_NowGrade:SetFilledImgAmount(dayCompleteQuest / needCompleteQuest)
  local isGetBox = idx > #apRewardList
  if isGetBox == true then
    View.Group_Main.Group_DailyBox.Btn_Box.Group_NotGet.self:SetActive(true)
    View.Group_Main.Group_DailyBox.Btn_Box.Group_CanGet.self:SetActive(false)
    View.Group_Main.Group_DailyBox.Btn_Box.Group_UnGet.self:SetActive(false)
    DataModel.DailyBoxStatus = 2
  else
    View.Group_Main.Group_DailyBox.Btn_Box.Group_NotGet.self:SetActive(false)
    local isComplete = dayCompleteQuest >= needCompleteQuest
    View.Group_Main.Group_DailyBox.Btn_Box.Group_CanGet.self:SetActive(isComplete)
    View.Group_Main.Group_DailyBox.Btn_Box.Group_UnGet.self:SetActive(not isComplete)
    DataModel.DailyBoxStatus = isComplete and 1 or 0
  end
end

function Controller:RefreshCalendar()
  local serverTime = TimeUtil:GetServerTimeStamp()
  local tb = os.date("*t", serverTime)
  local month = tb.month
  local day = tb.day
  View.Group_Main.Group_Calendar.Group_Month.self.transform:GetChild(month - 1).gameObject:SetActive(true)
  View.Group_Main.Group_Calendar.Txt_Day:SetText(day)
end

function Controller:RefreshDailyQuestPanel()
  View.Img_ZC.self:SetActive(false)
  View.Group_Main.Group_OpenTips.self:SetActive(false)
  View.Group_Main.Txt_EffectTips:SetActive(false)
  View.ScrollGrid_WeekQuestHurdle.self:SetActive(false)
  View.ScrollGrid_DailyQuestHurdle.self:SetActive(true)
  local dailyQuestConfig = PlayerData:GetFactoryData(99900010, "ConfigFactory")
  local count = dailyQuestConfig.questNum + #dailyQuestConfig.defaultQuestList
  DataModel.DailyQuestCanAcceptCount = dailyQuestConfig.questNum
  DataModel.DailyDefaultQuestNum = #dailyQuestConfig.defaultQuestList
  View.ScrollGrid_DailyQuestHurdle.grid.self:SetDataCount(count)
  View.ScrollGrid_DailyQuestHurdle.grid.self:RefreshAllElement()
  local text = string.format(GetText(80600277), table.count(DataModel.AcceptedQuestInfo), DataModel.DailyQuestCanAcceptCount + DataModel.DailyDefaultQuestNum)
  View.Group_Main.Group_BottomBar.Txt_DailySuccessNum:SetText(text)
end

function Controller:RefreshSingleQuestPanel(info, element, elementIndex)
  local questCA = PlayerData:GetFactoryData(info.id, "QuestFactory")
  Controller:RefreshSingleDailyQuestRarityBg(element, questCA.Rarity)
  element.Group_txt.self:SetActive(true)
  element.Group_txt.Txt_QuestName:SetText(questCA.name)
  local sliderImg = Controller:RefreshSingleDailyQuestRaritySlider(element, questCA.Rarity)
  sliderImg:SetFilledImgAmount(info.pcnt / info.maxPcnt)
  element.Group_txt.Txt_QuestSuccessNum:SetText(info.pcnt .. "/" .. info.maxPcnt)
  element.Group_txt.Txt_QuestDescribe:SetText(questCA.describe)
  local rewardList = questCA.rewardsList
  for k, v in pairs(rewardList) do
    if v.id ~= 11400013 then
      local itemFactory = PlayerData:GetFactoryData(v.id, "ItemFactory")
      element.Group_txt.Img_Award:SetSprite(itemFactory.iconPath)
      local rewardShow = itemFactory.name .. "x" .. v.num
      element.Group_txt.Txt_Get:SetText(rewardShow)
      element.Group_txt.Txt_NotGet:SetText(rewardShow)
      element.Group_txt.Btn_YL:SetClickParam(v.id)
      break
    end
  end
  local icComplete = info.pcnt == info.maxPcnt
  element.Group_txt.Txt_Get:SetActive(icComplete)
  element.Group_txt.Btn_LQ:SetActive(icComplete)
  element.Group_txt.Txt_NotGet:SetActive(not icComplete)
  if icComplete then
    Controller:RefreshSingleDailyQuestRarityRecive(element, questCA.Rarity)
    element.Group_txt.Btn_LQ:SetClickParam(elementIndex)
  else
    Controller:RefreshSingleDailyQuestRarityRecive(element, 0)
  end
end

function Controller:RefreshSingleDailyQuestRarityBg(element, rarity)
  element.Img_Low.self:SetActive(rarity == EnumDefine.QuestRarity.low)
  element.Img_Middle.self:SetActive(rarity == EnumDefine.QuestRarity.middle)
  element.Img_High.self:SetActive(rarity == EnumDefine.QuestRarity.high)
  element.Img_Super.self:SetActive(rarity == EnumDefine.QuestRarity.super)
end

function Controller:RefreshSingleDailyQuestRaritySelect(element, rarity)
  element.Img_SelectLow.self:SetActive(rarity == EnumDefine.QuestRarity.low)
  element.Img_SelectMiddle.self:SetActive(rarity == EnumDefine.QuestRarity.middle)
  element.Img_SelectHigh.self:SetActive(rarity == EnumDefine.QuestRarity.high)
  element.Img_SelectSuper.self:SetActive(rarity == EnumDefine.QuestRarity.super)
end

function Controller:RefreshSingleDailyQuestRaritySlider(element, rarity)
  element.Group_txt.Img_NowLowGrade:SetActive(rarity == EnumDefine.QuestRarity.low)
  element.Group_txt.Img_NowMiddleGrade:SetActive(rarity == EnumDefine.QuestRarity.middle)
  element.Group_txt.Img_NowHighGrade:SetActive(rarity == EnumDefine.QuestRarity.high)
  element.Group_txt.Img_NowSuperGrade:SetActive(rarity == EnumDefine.QuestRarity.super)
  local img = element.Group_txt.Img_NowLowGrade
  if rarity == EnumDefine.QuestRarity.middle then
    img = element.Group_txt.Img_NowMiddleGrade
  elseif rarity == EnumDefine.QuestRarity.high then
    img = element.Group_txt.Img_NowHighGrade
  elseif rarity == EnumDefine.QuestRarity.super then
    img = element.Group_txt.Img_NowSuperGrade
  end
  return img
end

function Controller:RefreshSingleDailyQuestRarityRecive(element, rarity)
  element.Group_txt.Img_LowRecive:SetActive(rarity == EnumDefine.QuestRarity.low)
  element.Group_txt.Img_MiddleRecive:SetActive(rarity == EnumDefine.QuestRarity.middle)
  element.Group_txt.Img_HighRecive:SetActive(rarity == EnumDefine.QuestRarity.high)
  element.Group_txt.Img_SuperRecive:SetActive(rarity == EnumDefine.QuestRarity.super)
end

function Controller:RefreshOneKeyGetShow(questList)
  local hadCompletedQuest = false
  for k, v in pairs(questList) do
    if v ~= nil and v.pcnt >= v.maxPcnt and v.recv == 0 then
      hadCompletedQuest = true
      break
    end
  end
  View.Group_Main.Group_BottomBar.Btn_Get.self:SetActive(hadCompletedQuest)
end

function Controller:RefreshChangeQuestType(type)
  if DataModel.CurQuestType == type then
    return
  end
  DataModel.CurQuestType = type
  if type == DataModel.QuestType.Daily then
    Controller:RefreshDailyQuestPanel()
    View.Group_Main.Group_BottomBar.Txt_WeekSuccessNum:SetActive(false)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Img_CheckDailyQuest.self:SetActive(true)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Txt_DailyQuest:SetActive(false)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Txt_WeekQuest:SetActive(true)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Img_CheckWeekQuest.self:SetActive(false)
    Controller:RefreshOneKeyGetShow(DataModel.AcceptedQuestInfo)
  elseif type == DataModel.QuestType.Weekly then
    Controller:RefreshWeeklyQuestPanel()
    View.Group_Main.Group_BottomBar.Txt_WeekSuccessNum:SetActive(true)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Img_CheckDailyQuest.self:SetActive(false)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Txt_DailyQuest:SetActive(true)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Txt_WeekQuest:SetActive(false)
    View.Group_Main.Group_BottomBar.Group_QuestSwitch.Img_CheckWeekQuest.self:SetActive(true)
  end
end

function Controller:RefreshQuestPondPanel()
  View.Group_QuestPond.self:SetActive(true)
  local allComplete = #DataModel.QuestPond == 0
  View.Group_QuestPond.Txt_TS:SetActive(allComplete)
  View.Group_QuestPond.ScrollGrid_QuestPond.self:SetActive(not allComplete)
  View.Group_QuestPond.Group_BottomBar.Txt_Receive:SetText(string.format(GetText(80600275), 0, DataModel.DailyQuestCanAcceptCount - DataModel.GetAccpetedQuestCount()))
  if not allComplete then
    View.Group_QuestPond.ScrollGrid_QuestPond.grid.self:SetDataCount(#DataModel.QuestPond)
    View.Group_QuestPond.ScrollGrid_QuestPond.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshWeeklyQuestPanel()
  View.ScrollGrid_DailyQuestHurdle.self:SetActive(false)
  local dailyQuestConfig = PlayerData:GetFactoryData(99900010, "ConfigFactory")
  View.Img_ZC.self:SetActive(dailyQuestConfig.isOpen)
  View.Img_ZC.ScrollGrid_WeekSwitch.grid.self:SetDataCount(#DataModel.WeeklyQuestInfo)
  View.Img_ZC.ScrollGrid_WeekSwitch.grid.self:RefreshAllElement()
  Controller:RefreshWeeklyQuestPanelDetail(DataModel.WeekSelectIdx)
end

function Controller:RefreshWeeklyQuestPanelDetail(idx)
  local totalInfo = DataModel.WeeklyQuestInfo[idx]
  local info = totalInfo.questList
  if #info == 0 then
    View.Group_Main.Group_OpenTips.self:SetActive(true)
    View.Group_Main.Txt_EffectTips:SetActive(false)
    View.ScrollGrid_WeekQuestHurdle.self:SetActive(false)
    View.Img_ZC.Btn_Effect.self:SetActive(true)
    View.Img_ZC.Btn_NotEffect.self:SetActive(false)
    Controller:RefreshWeekCountDownTime(idx)
  else
    local isActive = idx == PlayerData.ServerData.quests.unlock_week + 1
    View.Group_Main.Txt_EffectTips:SetActive(not isActive)
    local text = string.format(GetText(80600278), totalInfo.recvCount, #info)
    View.Group_Main.Group_BottomBar.Txt_WeekSuccessNum:SetText(text)
    View.Img_ZC.Btn_Effect.self:SetActive(not isActive)
    View.Img_ZC.Btn_NotEffect.self:SetActive(isActive)
    View.Group_Main.Group_OpenTips.self:SetActive(false)
    View.ScrollGrid_WeekQuestHurdle.self:SetActive(true)
    View.ScrollGrid_WeekQuestHurdle.grid.self:SetDataCount(#info)
    View.ScrollGrid_WeekQuestHurdle.grid.self:RefreshAllElement()
  end
  Controller:RefreshOneKeyGetShow(info)
end

function Controller:RefreshWeekCountDownTime(idx)
  local totalInfo = DataModel.WeeklyQuestInfo[idx]
  local remainTime = totalInfo.openTime - TimeUtil:GetServerTimeStamp()
  local t = TimeUtil:SecondToTable(remainTime)
  View.Group_Main.Group_OpenTips.Txt_Tips:SetText(string.format(GetText(80600281), idx, t.day, t.hour, t.minute, t.second))
end

function Controller:ZeroRefresh()
  DataModel.RefreshAllInfo()
  Controller:RefreshDailyBox()
  Controller:RefreshCalendar()
  if DataModel.CurQuestType == DataModel.QuestType.Daily then
    Controller:RefreshDailyQuestPanel()
  elseif DataModel.CurQuestType == DataModel.QuestType.Weekly then
    if DataModel.IsInPassBattleTime then
      Controller:RefreshWeeklyQuestPanel()
    else
      Controller:RefreshChangeQuestType(DataModel.QuestType.Daily)
    end
  end
end

return Controller
