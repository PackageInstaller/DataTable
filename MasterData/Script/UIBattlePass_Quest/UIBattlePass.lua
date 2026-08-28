local View = require("UIBattlePass_Quest/UIBattlePass_QuestView")
local CommonItem = require("Common/BtnItem")
local PassData = {}
PassData.lastIndex = nil

function PassData.ShowRightItem(index, row, titleIndex)
  if PassData.lastIndex and PassData.lastIndex == index then
    return
  end
  PassData.RightReward = row
  local Group_RewardPreview = View.Group_Reward_Quest.Group_BattlePass.Group_RewardPreview
  local row = PassData.PassRewardList[tonumber(titleIndex)]
  Group_RewardPreview.Txt_5:SetText(titleIndex)
  local Group_Item1 = Group_RewardPreview.Group_Item1
  Group_Item1.Img_Got:SetActive(false)
  Group_Item1.Img_Lock:SetActive(true)
  Group_Item1.Group_Item.Img_BlackMask:SetActive(true)
  CommonItem:SetItem(Group_Item1.Group_Item, {
    id = row.freeID,
    num = row.freeNum
  })
  local Group_Item2 = Group_RewardPreview.Group_Item2
  Group_Item2.Img_Got:SetActive(false)
  Group_Item2.Img_Lock:SetActive(true)
  Group_Item2.Img_BlackMask1:SetActive(true)
  CommonItem:SetItem(Group_Item2.Group_Item, {
    id = row.upgradeID,
    num = row.upgradeNum
  })
  if row.state_1 == 1 then
    Group_Item1.Img_Lock:SetActive(false)
    Group_Item1.Group_Item.Img_BlackMask:SetActive(false)
  elseif row.state_1 == 2 then
    Group_Item1.Img_Lock:SetActive(false)
    Group_Item1.Img_Got:SetActive(true)
    Group_Item1.Group_Item.Img_BlackMask:SetActive(true)
  end
  if row.state_2 == 1 then
    Group_Item2.Img_Lock:SetActive(false)
    Group_Item2.Img_BlackMask1:SetActive(false)
  elseif row.state_2 == 2 then
    Group_Item2.Img_Lock:SetActive(false)
    Group_Item2.Img_BlackMask1:SetActive(true)
    Group_Item2.Img_Got:SetActive(true)
  end
end

function PassData.Init(isInit, kind)
  PassData.isFirst = not isInit
  PassData.RewardPreview = {}
  local count = table.count(PassData.PassRewardList)
  local battlePass = PlayerData:GetBattlePass(kind)
  local revice = 0
  for k, v in pairs(PassData.PassRewardList) do
    local state_reward = battlePass.point_reward[tostring(k)]
    local free = state_reward and state_reward.free or 0
    local pay = state_reward and state_reward.pay or 0
    local state_1 = 0
    local state_2 = 0
    if k <= battlePass.pass_level then
      if free == 1 then
        state_1 = 2
      else
        state_1 = 1
        revice = revice + 1
      end
      if battlePass.pass_type ~= 0 then
        if pay == 0 then
          state_2 = 1
          revice = revice + 1
        else
          state_2 = 2
        end
      end
    end
    v.state_1 = state_1
    v.state_2 = state_2
  end
  local Group_Obj = View.Group_Reward_Quest.Group_BattlePass
  if revice == 0 then
    View.Group_Reward_Quest.Group_BattlePass.Btn_TakeAll.self:SetActive(false)
  else
    View.Group_Reward_Quest.Group_BattlePass.Btn_TakeAll.self:SetActive(true)
  end
  PassData.lastIndex = nil
  Group_Obj.ScrollGrid_BattlePass.grid.self:SetDataCount(count)
  Group_Obj.ScrollGrid_BattlePass.grid.self:RefreshAllElement()
  if not isInit then
    battlePass = PlayerData:GetBattlePass(kind)
    Group_Obj.ScrollGrid_BattlePass.grid.self:MoveToPos(battlePass.pass_level)
    local index = math.ceil(battlePass.pass_level / 5)
    if PassData.isFirst == true then
      index = math.max(1, index)
    end
    if index * 5 > table.count(PassData.PassRewardList) then
      index = math.floor(table.count(PassData.PassRewardList) / 5)
    end
    local titleIndex = index * 5
    local data = PassData.PassRewardList[titleIndex]
    PassData.ShowRightItem(index, data, titleIndex)
  end
  PassData.isFirst = false
end

function PassData.SetGrid(element, elementIndex, row, select, max)
  element.Img_Select:SetActive(false)
  local Group_Item1 = element.Group_Item1
  Group_Item1.Img_Lock:SetActive(true)
  Group_Item1.Img_Got:SetActive(false)
  Group_Item1.Img_HightLight1:SetActive(false)
  Group_Item1.Group_Item.Img_BlackMask1:SetActive(true)
  CommonItem:SetItem(Group_Item1.Group_Item, row.caFree)
  Group_Item1.Group_Item.Txt_Num:SetText(row.freeNum)
  local Group_Item2 = element.Group_Item2
  Group_Item2.Img_Lock:SetActive(true)
  Group_Item2.Img_Got:SetActive(false)
  Group_Item2.Img_HightLight2:SetActive(false)
  Group_Item2.Group_Item.Img_BlackMask2:SetActive(true)
  CommonItem:SetItem(Group_Item2.Group_Item, row.caUpgrade)
  Group_Item2.Group_Item.Txt_Num:SetText(row.upgradeNum)
  element.Txt_Index:SetText(elementIndex)
  if select and elementIndex == select then
    element.Img_Select:SetActive(true)
  end
  if elementIndex == max then
    element.Img_Line1:SetActive(false)
  else
    element.Img_Line1:SetActive(true)
  end
  element.Group_Item1.Group_Item.Btn_Item:SetClickParam(elementIndex)
  element.Group_Item2.Group_Item.Btn_Item:SetClickParam(elementIndex)
  if row.state_1 == 1 then
    Group_Item1.Img_Lock:SetActive(false)
    Group_Item1.Img_HightLight1:SetActive(true)
    Group_Item1.Group_Item.Img_BlackMask1:SetActive(false)
  elseif row.state_1 == 2 then
    Group_Item1.Img_Lock:SetActive(false)
    Group_Item1.Group_Item.Img_BlackMask1:SetActive(true)
    Group_Item1.Img_Got:SetActive(true)
  end
  if row.state_2 == 1 then
    Group_Item2.Img_Lock:SetActive(false)
    Group_Item2.Img_HightLight2:SetActive(true)
    Group_Item2.Group_Item.Img_BlackMask2:SetActive(false)
  elseif row.state_2 == 2 then
    Group_Item2.Img_Lock:SetActive(false)
    Group_Item2.Group_Item.Img_BlackMask2:SetActive(true)
    Group_Item2.Img_Got:SetActive(true)
  end
end

function PassData.Clear()
end

return PassData
