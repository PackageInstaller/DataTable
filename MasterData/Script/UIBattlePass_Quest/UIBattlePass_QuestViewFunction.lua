local CommonItem = require("Common/BtnItem")
local PassData = require("UIBattlePass_Quest/UIBattlePass")
local QuestData = require("UIBattlePass_Quest/UIBattleQuest")
local View = require("UIBattlePass_Quest/UIBattlePass_QuestView")
local DataModel = require("UIBattlePass_Quest/UIBattlePass_QuestDataModel")
local Count = 5

local function GetBattlePassState()
  local battle_pass = PlayerData:GetBattlePass(DataModel.curKind)
  local count = 0
  for k, v in pairs(PassData.PassRewardList) do
    if k <= battle_pass.pass_level and (v.state_1 == 1 or v.state_2 == 1) then
      count = count + 1
    end
  end
  if 0 < count then
    return true
  end
  return false
end

local ViewFunction = {
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Group_Top_Btn_PayForLevelUp_Click = function(btn, str)
    DataModel.OpenBuyLevel()
    View.self:PlayAnim("buyLvIn")
    View.Group_BuyLevel.Img_TipsBg.Img_Left:SetSprite(GetResPath(88300008))
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Group_Left_Btn_BuyBp_Click = function(btn, str)
    DataModel.ClickPayPage()
    View.self:PlayAnim("buyBpIn")
    View.Group_Pay.Group_Right.Group_Price1.Img_Icon:SetSprite(GetResPath(88300009))
    View.Group_Pay.Group_Right.Group_Price2.Img_Icon:SetSprite(GetResPath(88300010))
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Group_LevelReward_Btn_1_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Group_LevelReward_Btn_2_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Group_LevelReward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Group_LevelReward_Group_Item2_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Common_Img_Preview_Btn_Preview_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_ScrollGrid_BattlePass_SetGrid = function(element, elementIndex)
    local row = PassData.PassRewardList[tonumber(elementIndex)]
    local caFree = PlayerData:GetFactoryData(row.freeID)
    local caUpgrade = PlayerData:GetFactoryData(row.upgradeID)
    row.caFree = caFree
    row.caUpgrade = caUpgrade
    PassData.SetGrid(element, tonumber(elementIndex), row, DataModel.Data.lv, table.count(PassData.PassRewardList))
    local index = math.ceil(elementIndex / Count)
    if index * Count > table.count(PassData.PassRewardList) then
      index = math.floor(table.count(PassData.PassRewardList) / Count)
    end
    if PassData.isFirst == true then
      index = 1
    end
    local titleIndex = index * Count
    local data = PassData.PassRewardList[titleIndex]
    PassData.ShowRightItem(index, data, titleIndex)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_ScrollGrid_BattlePass_Group_BpReward_Group_Item1_Group_Item_Btn_Item_Click = function(btn, str)
    local row = PassData.PassRewardList[tonumber(str)]
    if row.state_1 == 1 then
      if DataModel.isActive == false then
        CommonTips.OpenTips("\230\180\187\229\138\168\229\183\178\231\187\147\230\157\159\239\188\129\239\188\129\239\188\129")
        return
      end
      Net:SendProto("battle_pass.multi_pass_rewards", function(json)
        print_r(json)
        
        local function callBack()
          if PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)] then
            PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)].free = 1
          else
            PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)] = {}
            PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)].free = 1
          end
          PassData.Init(true, DataModel.curKind)
          DataModel.RefreshData()
        end
        
        local reward = PlayerData:SortShowItem(json.reward)
        if reward and table.count(reward) > 0 then
          CommonTips.OpenShowItem(json.reward, callBack())
        else
          callBack()
        end
      end, DataModel.curKind, 0, tonumber(str), 0)
    else
      CommonTips.OpenPreRewardDetailTips(row.freeID)
    end
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_ScrollGrid_BattlePass_Group_BpReward_Group_Item2_Group_Item_Btn_Item_Click = function(btn, str)
    local row = PassData.PassRewardList[tonumber(str)]
    if row.state_2 == 1 then
      if DataModel.isActive == false then
        CommonTips.OpenTips("\230\180\187\229\138\168\229\183\178\231\187\147\230\157\159\239\188\129\239\188\129\239\188\129")
        return
      end
      Net:SendProto("battle_pass.multi_pass_rewards", function(json)
        print_r(json)
        
        local function callBack()
          if PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)] then
            PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)].pay = 1
          else
            PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)] = {}
            PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(str)].pay = 1
          end
          PassData.Init(true, DataModel.curKind)
          DataModel.RefreshData()
        end
        
        local reward = PlayerData:SortShowItem(json.reward)
        if reward and table.count(reward) > 0 then
          CommonTips.OpenShowItem(json.reward, callBack())
        else
          callBack()
        end
      end, DataModel.curKind, 1, tonumber(str), 0)
    else
      CommonTips.OpenPreRewardDetailTips(row.upgradeID)
    end
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_Btn_TakeAll_Click = function(btn, str)
    if DataModel.isActive == false then
      CommonTips.OpenTips("\230\180\187\229\138\168\229\183\178\231\187\147\230\157\159\239\188\129\239\188\129\239\188\129")
      return
    end
    if GetBattlePassState() == false then
      CommonTips.OpenTips(80600369)
      return
    end
    Net:SendProto("battle_pass.multi_pass_rewards", function(json)
      print_r(json)
      
      local function callBack()
        local battle_pass = PlayerData:GetBattlePass(DataModel.curKind)
        for k, v in pairs(PassData.PassRewardList) do
          if k <= battle_pass.pass_level then
            if PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)] then
              PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)].free = 1
              PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)].pay = 0
              if battle_pass.pass_type ~= 0 then
                PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)].pay = 1
              end
            else
              PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)] = {}
              PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)].free = 1
              PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)].pay = 0
              if battle_pass.pass_type ~= 0 then
                PlayerData:GetBattlePass(DataModel.curKind).point_reward[tostring(k)].pay = 1
              end
            end
          end
        end
        PassData.Init(true, DataModel.curKind)
        DataModel.RefreshData()
      end
      
      local reward = PlayerData:SortShowItem(json.reward)
      if reward and table.count(reward) > 0 then
        CommonTips.OpenShowItem(json.reward, callBack())
      else
        callBack()
      end
    end, DataModel.curKind, 2, 0, 1)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_Group_RewardPreview_Btn_2_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_Group_RewardPreview_Group_Item1_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(PassData.RightReward.freeID)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_Group_RewardPreview_Group_Item2_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(PassData.RightReward.upgradeID)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_Btn_BpFree_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePass_Btn_BpForPaid_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_ScrollGrid_Quest_SetGrid = function(element, elementIndex)
    local row = QuestData.NowList[tonumber(elementIndex)]
    QuestData.SetGrid(element, tonumber(elementIndex), row)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_ScrollGrid_Quest_Group_Item_Btn_PerformQuest_Click = function(btn, str)
    local row = QuestData.NowList[tonumber(str)]
    if row.CA.isSwitchUI == true then
      local list = Json.encode(DataModel.Serialize())
      UIManager:Open(row.CA.switchUI, list)
    end
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_ScrollGrid_Quest_Group_Item_Btn_TakeReward_Click = function(btn, str)
    if DataModel.isActive == false then
      CommonTips.OpenTips("\230\180\187\229\138\168\229\183\178\231\187\147\230\157\159\239\188\129\239\188\129\239\188\129")
      return
    end
    local row = QuestData.NowList[tonumber(str)]
    Net:SendProto("quest.recv_rewards", function(json)
      print_r(json)
      
      local function callBack()
        if QuestData.TableIndex == 1 then
          PlayerData:GetQuestDaily(DataModel.curKind)[tostring(row.id)].recv = 1
        elseif QuestData.TableIndex == 2 then
          PlayerData:GetQuestWeekly(DataModel.curKind)[tostring(row.id)].recv = 1
        end
        QuestData.Refresh(DataModel)
        DataModel.RefreshData()
      end
      
      local reward = PlayerData:SortShowItem(json.reward)
      if reward and table.count(reward) > 0 then
        CommonTips.OpenShowItem(json.reward, callBack())
      else
        callBack()
      end
    end, row.id)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_ScrollGrid_Quest_Group_Item_Btn_Finished_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_ScrollGrid_Quest_Group_Item_Group_item1_Btn_Item_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_Btn_TakeAll_Click = function(btn, str)
    if DataModel.isActive == false then
      CommonTips.OpenTips("\230\180\187\229\138\168\229\183\178\231\187\147\230\157\159\239\188\129\239\188\129\239\188\129")
      return
    end
    local list = {}
    for k, v in pairs(QuestData.DailyQuest) do
      local row = {}
      row = v
      row.id = tonumber(k)
      row.CA = PlayerData:GetFactoryData(k)
      row.index = 0
      if row.recv == 0 and row.pcnt >= row.CA.num then
        row.index = 1
      end
      if row.recv == 0 and row.pcnt < row.CA.num then
        row.index = 2
      end
      if row.recv ~= 0 then
        row.index = 3
      end
      if row.index == 1 then
        table.insert(list, v)
      end
    end
    for c, d in pairs(QuestData.WeekQuest) do
      local row = {}
      row = d
      row.id = tonumber(c)
      row.CA = PlayerData:GetFactoryData(c)
      row.index = 0
      if row.recv == 0 and row.pcnt >= row.CA.num then
        row.index = 1
      end
      if row.recv == 0 and row.pcnt < row.CA.num then
        row.index = 2
      end
      if row.recv ~= 0 then
        row.index = 3
      end
      if row.index == 1 then
        table.insert(list, d)
      end
    end
    Net:SendProto("quest.multi_pass_rec_quests_rewards", function(json)
      print_r(json)
      
      local function callBack()
        for k, v in pairs(list) do
          if PlayerData:GetQuestDaily(DataModel.curKind)[tostring(v.id)] then
            PlayerData:GetQuestDaily(DataModel.curKind)[tostring(v.id)].recv = 1
          end
          if PlayerData:GetQuestWeekly(DataModel.curKind)[tostring(v.id)] then
            PlayerData:GetQuestWeekly(DataModel.curKind)[tostring(v.id)].recv = 1
          end
        end
        QuestData.Refresh(DataModel)
        DataModel.RefreshData()
      end
      
      local reward = PlayerData:SortShowItem(json.reward)
      if reward and table.count(reward) > 0 then
        CommonTips.OpenShowItem(json.reward, callBack())
      else
        callBack()
      end
    end, DataModel.curKind)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_Btn_Bp_Click = function(btn, str)
    QuestData.TableIndex = 1
    QuestData.SwitchQuestTable(DataModel.curKind)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_Btn_Quest_Click = function(btn, str)
    QuestData.TableIndex = 2
    QuestData.SwitchQuestTable(DataModel.curKind)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_BattlePassQuest_Btn_Bp2_Click = function(btn, str)
    if PlayerData:GetDailyVitality() < QuestData.MaxBoxNum then
      CommonTips.OpenTips(80600373)
      return
    end
    if PlayerData:GetDailyVitality() >= QuestData.MaxBoxNum and PlayerData.ServerData.liveness_rewards and table.count(PlayerData.ServerData.liveness_rewards) == 0 then
      Net:SendProto("item.recv_liveness_rewards", function(json)
        print_r(json)
        PlayerData.ServerData.liveness_rewards["0"] = TimeUtil:GetServerTimeStamp()
        DataModel.RefreshData()
        QuestData.Refresh(DataModel)
        CommonTips.OpenShowItem(json.reward)
      end, 0)
    else
      CommonTips.OpenTips(80600372)
    end
  end,
  BattlePass_Quest_Group_Reward_Quest_Btn_Return_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Bottom_Img_BG_Btn_Bp_Click = function(btn, str)
    DataModel.TableOutSideIndex = 1
    DataModel.SwitchTable()
  end,
  BattlePass_Quest_Group_Reward_Quest_Group_Bottom_Img_BG_Btn_Quest_Click = function(btn, str)
    DataModel.TableOutSideIndex = 2
    DataModel.SwitchTable()
  end,
  BattlePass_Quest_Group_Pay_Group_LeftBottom_Btn_State2_Click = function(btn, str)
    DataModel.isSpine2 = not DataModel.isSpine2
    View.self:PlayAnim("showSpIn")
    DataModel.CharacterLoad(DataModel.isSpine2)
  end,
  BattlePass_Quest_Group_Pay_Group_Right_Group_Price1_ScrollGrid_RewardShow_SetGrid = function(element, elementIndex)
    local row = DataModel.CA.rewardShow[tonumber(elementIndex)]
    element.Group_Item.Btn_Item:SetClickParam(tostring(elementIndex))
    CommonItem:SetItem(element.Group_Item, {
      id = row.id,
      num = row.num
    }, EnumDefine.ItemType.Item)
  end,
  BattlePass_Quest_Group_Pay_Group_Right_Group_Price1_ScrollGrid_RewardShow_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(DataModel.CA.rewardShow[tonumber(str)].id, nil, true)
  end,
  BattlePass_Quest_Group_Pay_Group_Right_Group_Price1_Btn_Buy_Click = function(btn, str)
    DataModel.BuyBp(0)
  end,
  BattlePass_Quest_Group_Pay_Group_Right_Group_Price2_ScrollGrid_RewardShow_SetGrid = function(element, elementIndex)
    local row = DataModel.CA.extraReward[tonumber(elementIndex)]
    element.Group_Item.Btn_Item:SetClickParam(tostring(elementIndex))
    CommonItem:SetItem(element.Group_Item, {
      id = row.id,
      num = row.num
    }, EnumDefine.ItemType.Item)
  end,
  BattlePass_Quest_Group_Pay_Group_Right_Group_Price2_ScrollGrid_RewardShow_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(DataModel.CA.extraReward[tonumber(str)].id, nil, true)
  end,
  BattlePass_Quest_Group_Pay_Group_Right_Group_Price2_Btn_Buy_Click = function(btn, str)
    DataModel.BuyBp(1)
  end,
  BattlePass_Quest_Group_Pay_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.isSpine2 == true then
      DataModel.isSpine2 = not DataModel.isSpine2
      View.self:PlayAnim("showSpOut")
      DataModel.CharacterLoad(DataModel.isSpine2)
      return
    end
    DataModel.OtherPage = nil
    View.self:PlayAnim("buyBpOut")
    DataModel.SwitchTable()
    DataModel.RefreshData()
  end,
  BattlePass_Quest_Group_Pay_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  BattlePass_Quest_Group_Pay_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_Pay_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_BuyLevel_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  BattlePass_Quest_Group_BuyLevel_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Left_Img_Bg_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local row = DataModel.PassRewardList[tonumber(elementIndex)]
    element.Group_Item.Btn_Item:SetClickParam(tostring(elementIndex))
    CommonItem:SetItem(element.Group_Item, {
      id = row.id,
      num = row.num
    }, EnumDefine.ItemType.Item)
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Left_Img_Bg_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.PassRewardList[tonumber(str)].id)
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Right_Btn_Max_Click = function(btn, str)
    View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid.self:LocatElementImmediate(0)
  end,
  BattlePass_Quest_Group_BuyLevel_Btn_Buy_Click = function(btn, str)
    local function callBack()
      Net:SendProto("battle_pass.multi_upgrade", function(json)
        local trackArgs = {}
        
        trackArgs.reason = "buy_pass_lv"
        trackArgs.amount = DataModel.Price
        SdkReporter.TrackUseDiamond(trackArgs)
        PlayerData:GetBattlePass(DataModel.curKind).pass_level = DataModel.EndLv
        DataModel.SwitchTable()
        DataModel.RefreshData()
        DataModel.OtherPage = nil
        View.self:PlayAnim("buyLvOut")
        View.Group_BuyLevel.self:SetActive(false)
        CommonTips.OpenTips(80601249)
      end, DataModel.curKind, DataModel.EndLv - PlayerData:GetBattlePass(DataModel.curKind).pass_level)
    end
    
    PlayerData:AllBuyCommodity(11400005, DataModel.Price, callBack)
  end,
  BattlePass_Quest_Group_BuyLevel_Btn_Cancel_Click = function(btn, str)
    DataModel.OtherPage = nil
    View.self:PlayAnim("buyLvOut")
    View.Group_BuyLevel.self:SetActive(false)
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Right_Img_LvBg_Page_Level_SetPage = function(element, elementIndex)
    local row = DataModel.LevelList[elementIndex]
    row.element = element
    element.Txt_:SetText(row.txt)
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Right_Img_LvBg_Page_Level_PageDrag = function(dragOffsetPos)
    local index, offSetRation = math.modf(dragOffsetPos)
    if 0.5 < offSetRation then
      DataModel.selectedIndex = index + 2
    else
      DataModel.selectedIndex = index + 1
    end
    if 0 < offSetRation and DataModel.BeforeOffset and View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid[index + 2] then
      if 0 > DataModel.BeforeOffset - dragOffsetPos then
        View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid[index + 1]:SetColor(Color(1.0, 1.0, 1.0, 1 - offSetRation))
        View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid[index + 2]:SetColor(Color(1.0, 1.0, 1.0, offSetRation))
      else
        View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid[index + 2]:SetColor(Color(1.0, 1.0, 1.0, offSetRation))
        View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid[index + 1]:SetColor(Color(1.0, 1.0, 1.0, 1 - offSetRation))
      end
    end
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Right_Img_LvBg_Page_Level_PageDragComplete = function(index)
    DataModel.selectedIndex = index + 1
    local grid = View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid.self
    if DataModel.OldGridIndex == index and DataModel.IsDrag and not DataModel.IsFirst then
      DataModel.IsDrag = false
      return
    end
    DataModel.EndLv = tonumber(DataModel.LevelList[DataModel.selectedIndex].txt)
    DataModel.RefreshLeftInfo()
    DataModel.IsFirst = false
    DataModel.OldGridIndex = grid.Index
  end,
  BattlePass_Quest_Group_BuyLevel_Group_Right_Img_LvBg_Page_Level_PageDragBegin = function(dragOffsetPos)
    local grid = View.Group_BuyLevel.Group_Right.Img_LvBg.Page_Level.grid.self
    DataModel.IsDrag = true
    DataModel.BeforeOffest = dragOffsetPos
  end,
  BattlePass_Quest_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  BattlePass_Quest_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
  end,
  BattlePass_Quest_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  BattlePass_Quest_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  BattlePass_Quest_ScrollGrid_Time_SetGrid = function(element, elementIndex)
    local temp = DataModel.tabList[elementIndex]
    local battlePassId = temp.id
    element.Btn_Tab.Img_Selected:SetActive(elementIndex == DataModel.curSelectTab)
    element.Btn_Tab.Img_Unselected:SetActive(elementIndex ~= DataModel.curSelectTab)
    local isNew = PlayerData:GetPlayerPrefs("int", "battlePass" .. battlePassId)
    element.Btn_Tab.Img_New:SetActive(isNew ~= 1)
    local row = PlayerData:GetBattlePassRedState(temp.kind)
    element.Btn_Tab.Img_Red:SetActive(row.count_1 == true or row.count_2 == true or row.count_3 == true)
    if DataModel.onlyRefreshSelectTab then
      return
    end
    local cfg = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
    element.Btn_Tab:SetSprite(cfg.recommendStoreTabImg)
    element.Btn_Tab.Txt_Name:SetText(cfg.topicName)
    element.Btn_Tab:SetClickParam(elementIndex)
  end,
  BattlePass_Quest_ScrollGrid_Time_Group_Tab_Btn_Tab_Click = function(btn, str)
    DataModel.SelectTab(tonumber(str))
  end
}
return ViewFunction
