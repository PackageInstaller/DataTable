local CommonItem = require("Common/BtnItem")
local View = require("UIMaterialBattle/UIMaterialBattleView")
local DataModel = require("UIMaterialBattle/UIMaterialBattleDataModel")
local Controller = {}

function Controller:Init()
  View.Group_Left.ScrollGrid_Left.grid.self:SetDataCount(#DataModel.BattleList)
  View.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Left.grid.self:MoveToTop()
  for k, v in pairs(DataModel.BattleList) do
    local data = DataModel.BattleList[k]
    View.Group_Right[data.nodeName]:SetActive(false)
  end
  Controller:ClickBattleLeftList(DataModel.BattleLeftIndex)
end

function Controller:SetBtnLabelGridElelment(element, elementIndex)
  local row = DataModel.BattleList[elementIndex]
  element.Btn_Label:SetClickParam(elementIndex)
  local pathCa = PlayerData:GetFactoryData(99900021)
  if pathCa then
    element.Btn_Label.Img_Icon:SetSprite(pathCa.materialBattleIconPath[elementIndex].path)
  end
  element.Btn_Label.Group_On.Txt_T:SetText(row.nameText)
  element.Btn_Label.Group_Off.Txt_T:SetText(row.nameText)
  element.Btn_Label.Group_On.Txt_D:SetText(row.desText)
  element.Btn_Label.Group_Off.Txt_D:SetText(row.desText)
  local x = -56
  local color = "#FFFFFF"
  if elementIndex == DataModel.BattleLeftIndex then
    element.Btn_Label.Group_On:SetActive(true)
    element.Btn_Label.Group_Off:SetActive(false)
    x = -26
    color = "#000000"
  else
    element.Btn_Label.Group_On:SetActive(false)
    element.Btn_Label.Group_Off:SetActive(true)
  end
  element.Btn_Label.Img_Icon:SetLocalPositionX(x)
  element.Btn_Label.Img_Icon:SetColor(color)
end

function Controller:ClickBattleLeftList(index)
  if DataModel.BattleLeftIndex then
    local data = DataModel.BattleList[DataModel.BattleLeftIndex]
    View.Group_Right[data.nodeName]:SetActive(false)
  end
  DataModel:SetBattleLeftListIndex(index)
  local data = DataModel.BattleList[DataModel.BattleLeftIndex]
  View.Group_Right[data.nodeName]:SetActive(true)
  View.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
  View.Group_Right[data.nodeName].Group_Info.Txt_Name:SetText(data.nameText)
  View.Group_Right[data.nodeName].Group_Info.Img_Des.Txt_Des:SetText(data.desText)
  View.Group_Right[data.nodeName].Group_Level.ScrollGrid_Level.grid.self:SetDataCount(#DataModel.ChooseLeftData)
  View.Group_Right[data.nodeName].Group_Level.ScrollGrid_Level.grid.self:RefreshAllElement()
  View.Group_Right[data.nodeName].Group_Level.ScrollGrid_Level.grid.self:MoveToTop()
  local reduice = DataModel.BattleList[DataModel.BattleLeftIndex].materialLevelTimes - DataModel.BattleCurrentNum
  reduice = reduice < 0 and 0 or reduice
  View.Group_Right[data.nodeName].Group_Info.Txt_Times:SetText(reduice .. "/" .. DataModel.BattleList[DataModel.BattleLeftIndex].materialLevelTimes)
  Controller:SetBattleInfoReduceTime()
end

function Controller:SetBattleInfoReduceTime()
  local data = DataModel.BattleList[DataModel.BattleLeftIndex]
  local timeTable = TimeUtil:SecondToTable(data.targetTime - TimeUtil:GetServerTimeStamp())
  if timeTable.day >= 1 then
    View.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80612071), timeTable.day, timeTable.hour))
  elseif 1 <= timeTable.hour then
    View.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80612072), timeTable.hour))
  elseif 1 <= timeTable.minute then
    View.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80612073), timeTable.minute))
  else
    View.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80612073), 0))
  end
end

function Controller:SetBattleLevelGridElelment(element, elementIndex)
  local row = DataModel.ChooseLeftData[elementIndex]
  element.Btn_Enter:SetClickParam(elementIndex)
  element.Txt_Name:SetText(row.name)
  element.Img_Mask.Spine_Head:SetData(row.resDir)
  element.Img_Mask.Spine_Head.transform.localPosition = Vector3(row.spineX, row.spineY, 0)
  element.Img_Mask.Spine_Head:SetLocalScale(Vector3(row.spineScale, row.spineScale, 1))
  element.Group_Cost.Txt_Num:SetText("-" .. row.cost)
  element.Group_Reward.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
  element.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(table.count(row.rewardViewList))
  element.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
  element.Group_Reward.ScrollGrid_Reward.grid.self:MoveToTop()
  element.Group_Reward.ScrollGrid_Reward.grid.self.ScrollRect.enabled = true
  element.Group_Closed:SetActive(not row.isActivity)
  element.Group_Closed.Txt_Tip:SetText(GetText(row.closedTextId))
end

function Controller:SetRewardGridElelment(element, elementIndex)
  local index = tonumber(element.ParentParam)
  local row = DataModel.ChooseLeftData[index]
  local rewardList = row.rewardViewList
  CommonItem:SetItem(element.Group_Item, {
    id = rewardList[elementIndex].id,
    num = rewardList[elementIndex].num
  }, EnumDefine.ItemType.Item)
  element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
end

function Controller:ClickEnterBattleBtn(index)
  if DataModel.BattleList[DataModel.BattleLeftIndex].materialLevelTimes - DataModel.BattleCurrentNum <= 0 then
    CommonTips.OpenTips(80610269)
    return
  end
  local row = DataModel.BattleList[DataModel.BattleLeftIndex]
  local data = DataModel.ChooseLeftData[tonumber(index)]
  if data.isActivity == false then
    CommonTips.OpenTips(80610399)
    return
  end
  if CommonTips.GuideAsset() then
    return
  end
  UIManager:Open(row.prefabPath, Json.encode({
    id = data.id,
    maxNum = row.materialLevelTimes,
    titleIndex = DataModel.TitleChoose,
    battleLeftIndex = DataModel.BattleLeftIndex,
    activityId = DataModel.ActivityId
  }))
end

return Controller
