local View = require("UIFireMission/UIFireMissionView")
local DataModel = require("UIFireMission/UIFireMissionDataModel")
local CommonItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.InitQuestInfo()
  View.NewScrollGrid_Mission.grid.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    View.NewScrollGrid_Mission.grid.self:SetDataCount(#DataModel.questInfo)
    View.NewScrollGrid_Mission.grid.self:MoveToTop()
    View.NewScrollGrid_Mission.grid.self:RefreshAllElement()
  end))
end

function Controller:SetQuestElement(element, elementIndex)
  local info = DataModel.questInfo[elementIndex]
  local questCA = PlayerData:GetFactoryData(info.id)
  if questCA.showType == "Txt" then
    element.Group_Des.Txt_TxtType:SetActive(true)
    element.Group_Des.Txt_TxtType:SetText(questCA.story)
  else
    element.Group_Des.Txt_TxtType:SetActive(false)
  end
  element.Txt_TypeName:SetText(questCA.name)
  element.ScrollGrid_Rewards.grid.self:SetParentParam(elementIndex)
  element.ScrollGrid_Rewards.grid.self:SetDataCount(#questCA.rewardsList)
  element.ScrollGrid_Rewards.grid.self:RefreshAllElement()
  element.Btn_Completed:SetActive(info.state == EnumDefine.EQuestState.Finish)
  element.Group_Got:SetActive(info.state == EnumDefine.EQuestState.Receive)
  local setElement
  if info.state == EnumDefine.EQuestState.Finish then
    setElement = element.Btn_Completed
    setElement:SetClickParam(elementIndex)
  elseif info.state == EnumDefine.EQuestState.Receive then
    setElement = element.Group_Got
  end
  if setElement then
    if setElement.Txt_TypeName then
      setElement.Txt_TypeName:SetText(questCA.name)
    end
    if setElement.Group_Des and setElement.Group_Des.Txt_TxtType then
      setElement.Group_Des.Txt_TxtType:SetText(questCA.story)
    end
  end
end

function Controller:ClickComplete(btn, str)
  local idx = tonumber(str)
  local info = DataModel.questInfo[idx]
  Net:SendProto("quest.recv_rewards", function(json)
    local serverActivityQuest = PlayerData.ServerData.quests.activity_quests
    local detailServerInfo = serverActivityQuest[tostring(info.id)]
    detailServerInfo.recv = TimeUtil:GetServerTimeStamp()
    info.state = EnumDefine.EQuestState.Receive
    DataModel.SortQuestInfo()
    View.NewScrollGrid_Mission.grid.self:RefreshAllElement()
    CommonTips.OpenShowItem(json.reward)
  end, info.id)
end

function Controller:SetRewardElement(element, elementIndex)
  local info = DataModel.questInfo[tonumber(element.ParentParam)]
  local questCA = PlayerData:GetFactoryData(info.id)
  local rewardInfo = questCA.rewardsList[elementIndex]
  CommonItem:SetItem(element.Group_CommonItem, {
    id = rewardInfo.id,
    num = rewardInfo.num
  }, EnumDefine.ItemType.Item)
  element.Group_CommonItem.Btn_Item:SetClickParam(rewardInfo.id)
end

function Controller:ClickRewardItem(btn, str)
  local itemId = tonumber(str)
  CommonTips.OpenPreRewardDetailTips(itemId)
end

function Controller:Return()
  UIManager:GoBack()
end

function Controller:Home()
  UIManager:GoHome()
end

return Controller
