local View = require("UIBattlePass_Quest/UIBattlePass_QuestView")
local CommonItem = require("Common/BtnItem")
local QuestData = {}
local Index

function QuestData.SortTable(data)
  table.sort(data, function(a, b)
    if a.index == b.index then
      if a.recv == b.recv then
        return a.id < b.id
      end
      return a.recv < b.recv
    end
    return a.index < b.index
  end)
end

function QuestData.SwitchQuestTable(kind)
  if Index and Index == QuestData.TableIndex then
    return
  end
  local Group_BattlePassQuest = View.Group_Reward_Quest.Group_BattlePassQuest
  Group_BattlePassQuest.Btn_Bp.Group_Off.self:SetActive(true)
  Group_BattlePassQuest.Btn_Bp.Group_On.self:SetActive(false)
  Group_BattlePassQuest.Btn_Quest.Group_Off.self:SetActive(true)
  Group_BattlePassQuest.Btn_Quest.Group_On.self:SetActive(false)
  Group_BattlePassQuest.Btn_TakeAll.self:SetActive(false)
  Group_BattlePassQuest.Btn_Bp.Group_Off.Img_RedPoint:SetActive(false)
  Group_BattlePassQuest.Btn_Quest.Group_Off.Img_RedPoint:SetActive(false)
  local row_1 = PlayerData:GetBattlePassRedState(kind)
  QuestData.NowList = {}
  if QuestData.TableIndex == 1 then
    Group_BattlePassQuest.Btn_Bp.Group_On.self:SetActive(true)
    local finishNum = 0
    for k, v in pairs(QuestData.DailyQuest) do
      local row = {}
      row = Clone(v)
      row.id = tonumber(k)
      row.CA = PlayerData:GetFactoryData(k)
      local ratio = 1
      local isTravel = false
      if row.CA.conditionList[1] and row.CA.conditionList[1].key == "travel" then
        isTravel = true
        ratio = ratio * PlayerData:GetFactoryData(99900014).disRatio
      end
      row.isTravel = isTravel
      row.ratio = ratio
      row.index = 0
      local pcnt = math.floor(row.pcnt * ratio)
      if row.recv == 0 and pcnt >= row.CA.num * ratio then
        row.index = 1
        finishNum = finishNum + 1
      end
      if row.recv == 0 and pcnt < row.CA.num * ratio then
        row.index = 2
      end
      if row.recv ~= 0 then
        row.index = 3
      end
      table.insert(QuestData.NowList, row)
    end
    QuestData.SortTable(QuestData.NowList)
    local count = table.count(QuestData.NowList)
    Group_BattlePassQuest.ScrollGrid_Quest.grid.self:SetDataCount(count)
    Group_BattlePassQuest.ScrollGrid_Quest.grid.self:RefreshAllElement()
    Group_BattlePassQuest.ScrollGrid_Quest.grid.self:MoveToTop()
    if PlayerData.ServerData.liveness_rewards and PlayerData.ServerData.liveness_rewards["0"] then
      Group_BattlePassQuest.Btn_Bp2.Img_Recevie:SetActive(true)
      Group_BattlePassQuest.Btn_Bp2.Img_Off:SetActive(true)
    else
      Group_BattlePassQuest.Btn_Bp2.Img_Recevie:SetActive(false)
      Group_BattlePassQuest.Btn_Bp2.Img_Off:SetActive(false)
    end
    local Group_Bar = Group_BattlePassQuest.Btn_Bp2.Group_Bar
    for i = 1, 5 do
      local obj = "Img_On" .. i
      Group_Bar.Group_On[obj]:SetActive(false)
      if i <= PlayerData:GetDailyVitality() then
        Group_Bar.Group_On[obj]:SetActive(true)
      end
    end
    if row_1.count_3 == true then
      Group_BattlePassQuest.Btn_Quest.Group_Off.Img_RedPoint:SetActive(true)
    end
    if row_1.count_2 == true then
      Group_BattlePassQuest.Btn_TakeAll.self:SetActive(true)
    end
  elseif QuestData.TableIndex == 2 then
    Group_BattlePassQuest.Btn_Quest.Group_On.self:SetActive(true)
    for k, v in pairs(QuestData.WeekQuest) do
      local row = {}
      row = Clone(v)
      row.id = tonumber(k)
      row.CA = PlayerData:GetFactoryData(k)
      local ratio = 1
      local isTravel = false
      if row.CA.conditionList[1] and row.CA.conditionList[1].key == "travel" then
        isTravel = true
        ratio = ratio * PlayerData:GetFactoryData(99900014).disRatio
      end
      row.isTravel = isTravel
      row.ratio = ratio
      row.index = 0
      local pcnt = math.floor(row.pcnt * ratio)
      if row.recv == 0 and pcnt >= row.CA.num * ratio then
        row.index = 1
      end
      if row.recv == 0 and pcnt < row.CA.num * ratio then
        row.index = 2
      end
      if row.recv ~= 0 then
        row.index = 3
      end
      table.insert(QuestData.NowList, row)
    end
    QuestData.SortTable(QuestData.NowList)
    local count = table.count(QuestData.NowList)
    Group_BattlePassQuest.ScrollGrid_Quest.grid.self:SetDataCount(count)
    Group_BattlePassQuest.ScrollGrid_Quest.grid.self:RefreshAllElement()
    Group_BattlePassQuest.ScrollGrid_Quest.grid.self:MoveToTop()
    if row_1.count_2 == true then
      Group_BattlePassQuest.Btn_Bp.Group_Off.Img_RedPoint:SetActive(true)
    end
    if row_1.count_3 == true then
      Group_BattlePassQuest.Btn_TakeAll.self:SetActive(true)
    end
  end
  Index = QuestData.TableIndex
end

function QuestData.Init(data)
  Index = nil
  QuestData.CA = data.CA
  QuestData.kind = data.curKind
  QuestData.WeekQuest = PlayerData:GetQuestWeekly(data.curKind)
  QuestData.DailyQuest = PlayerData:GetQuestDaily(data.curKind)
  QuestData.MaxBoxNum = 5
  QuestData.SwitchQuestTable(data.curKind)
end

function QuestData.Refresh(data)
  QuestData.CA = data.CA
  QuestData.kind = data.curKind
  QuestData.WeekQuest = PlayerData:GetQuestWeekly(data.curKind)
  QuestData.DailyQuest = PlayerData:GetQuestDaily(data.curKind)
  QuestData.TableIndex = Index
  Index = nil
  QuestData.SwitchQuestTable(data.curKind)
end

function QuestData.SetGrid(element, elementIndex, row)
  element.Img_FinishedMark:SetActive(false)
  element.Btn_PerformQuest:SetActive(false)
  element.Btn_TakeReward:SetActive(false)
  element.Btn_Finished:SetActive(false)
  element.Group_QuestName.Txt_QuestNameDoing:SetActive(true)
  element.Group_QuestName.Txt_QuestName:SetActive(true)
  element.Group_Desc.Txt_QuestDescDoing:SetActive(true)
  element.Group_Desc.Txt_QuestDesc:SetActive(true)
  element.Group_QuestNum.Txt_QuestNumDoing:SetActive(true)
  element.Group_QuestNum.Txt_QuestNum:SetActive(true)
  element.Img_ReceiveMask:SetActive(false)
  element.Group_Bg.Img_BgFinish:SetActive(false)
  element.Group_Bg.Img_BgDoing:SetActive(false)
  element.Group_EXP.Txt_ExpDoing:SetActive(false)
  element.Group_EXP.Txt_Exp:SetActive(false)
  element.Group_QuestName.Txt_QuestNameDoing:SetText(row.CA.name)
  element.Group_QuestName.Txt_QuestName:SetText(row.CA.name)
  element.Group_Desc.Txt_QuestDescDoing:SetText(row.CA.describe)
  element.Group_Desc.Txt_QuestDesc:SetText(row.CA.describe)
  local pcnt = row.pcnt * row.ratio
  element.Group_QuestNum.Txt_QuestNumDoing:SetText(PlayerData:GetPreciseDecimalFloor(pcnt, 0) .. "/" .. PlayerData:GetPreciseDecimalFloor(row.CA.num * row.ratio, 0))
  element.Group_QuestNum.Txt_QuestNum:SetText(PlayerData:GetPreciseDecimalFloor(pcnt, 0) .. "/" .. PlayerData:GetPreciseDecimalFloor(row.CA.num * row.ratio, 0))
  row.state = 0
  if row.index == 2 then
    element.Btn_PerformQuest:SetActive(true)
    element.Group_Bg.Img_BgDoing:SetActive(true)
    element.Group_QuestName.Txt_QuestName:SetActive(false)
    element.Group_Desc.Txt_QuestDesc:SetActive(false)
    element.Group_QuestNum.Txt_QuestNum:SetActive(false)
    if row.CA.isSwitchUI == false then
      element.Btn_PerformQuest:SetActive(false)
    end
    element.Group_EXP.Txt_ExpDoing:SetActive(true)
  else
    element.Group_EXP.Txt_Exp:SetActive(true)
    element.Group_QuestName.Txt_QuestNameDoing:SetActive(false)
    element.Group_Desc.Txt_QuestDescDoing:SetActive(false)
    element.Group_QuestNum.Txt_QuestNumDoing:SetActive(false)
  end
  if row.index == 1 then
    element.Btn_TakeReward:SetActive(true)
    element.Group_Bg.Img_BgFinish:SetActive(true)
  end
  if row.index == 3 then
    element.Btn_Finished:SetActive(true)
    element.Img_FinishedMark:SetActive(true)
    element.Img_ReceiveMask:SetActive(true)
    element.Group_Bg.Img_BgFinish:SetActive(true)
  end
  local rewards = row.CA.rewardsList[1]
  for k, v in pairs(row.CA.rewardsList) do
    local reward = PlayerData:GetFactoryData(v.id)
    if reward.mod == "\233\128\154\232\161\140\232\175\129\233\129\147\229\133\183" then
      rewards = v
    end
  end
  local itemCsv = PlayerData:GetFactoryData(rewards.id)
  local singleExp = itemCsv.battlePassEXP
  local itemNum = math.floor(singleExp or 0) * rewards.num
  local itemNumDes = string.format(GetText(80601005), itemNum)
  element.Group_EXP.Txt_ExpDoing:SetText(itemNumDes)
  element.Group_EXP.Txt_Exp:SetText(itemNumDes)
  CommonItem:SetItem(element.Group_item1, rewards)
  element.Btn_PerformQuest:SetClickParam(elementIndex)
  element.Btn_TakeReward:SetClickParam(elementIndex)
  element.Btn_Finished:SetClickParam(elementIndex)
  element.Img_CircleBar2:SetFilledImgAmount(math.ceil(row.pcnt * row.ratio) / (row.CA.num * row.ratio))
end

function QuestData.Clear()
end

return QuestData
