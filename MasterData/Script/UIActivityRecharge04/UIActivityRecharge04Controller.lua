local View = require("UIActivityRecharge04/UIActivityRecharge04View")
local DataModel = require("UIActivityRecharge04/UIActivityRecharge04DataModel")
local ActivityMainController = require("UIActivityMain/UIActivityMainController")
local Controller = {}

function Controller:InitData(id)
  local isRed = false
  local Data = PlayerData:GetFactoryData(id, "ActivityFactory")
  local cumulative_rw = {}
  DataModel.bm_rock = 0
  local userInfo = PlayerData:GetUserInfo()
  local isMan = false
  if userInfo ~= nil then
    cumulative_rw = userInfo.cumulative_rw or {}
    if userInfo.cumulative_rw_dict ~= nil then
      cumulative_rw = userInfo.cumulative_rw_dict[tostring(id)] or {}
    end
    if userInfo.act_amount_dict ~= nil then
      DataModel.bm_rock = userInfo.act_amount_dict[tostring(id)] or 0
    else
      DataModel.bm_rock = userInfo.act_amount or 0
    end
    isMan = userInfo.gender == 1
  end
  DataModel.endTime = Data.endTime
  DataModel.rewardsList = Data.rewardsList or {}
  if next(DataModel.rewardsList) ~= nil and userInfo ~= nil then
    local data = {}
    local index = 1
    for key, value in pairs(DataModel.rewardsList) do
      local temp = {}
      temp.num = 0
      temp.itemID = -1
      local url = ""
      if isMan then
        url = value.iconMan or ""
      else
        url = value.iconWoman or ""
      end
      local item = PlayerData:GetFactoryData(value.rewardsListId, "ActivityListFactory").rewardsList[1] or nil
      if item ~= nil then
        temp.itemID = item.id
        temp.num = item.num
        local caData = PlayerData:GetFactoryData(item.id)
        if url == "" and caData ~= nil then
          url = caData.iconPath or ""
        end
      end
      temp.url = url
      temp.amount = value.amount
      local IsGot = false
      if cumulative_rw[index] then
        IsGot = true
      end
      temp.isGot = IsGot
      temp.isRed = IsGot == false and value.amount <= DataModel.bm_rock
      if temp.isRed then
        isRed = true
      end
      data[index] = temp
      index = index + 1
    end
    DataModel.rewardsList = data
  end
  return isRed
end

function Controller:InitView()
  if next(DataModel.rewardsList) ~= nil then
    View.StaticGrid_RewardsList.grid.self:SetDataCount(#DataModel.rewardsList)
    View.StaticGrid_RewardsList.grid.self:RefreshAllElement()
    local data = TimeUtil:SecondToTable(TimeUtil:LastTime(DataModel.endTime))
    View.Txt_Time:SetText(string.format(GetText(80610478), data.day, data.hour))
    local amount = math.floor(DataModel.bm_rock)
    local maxAmount = math.floor(DataModel.rewardsList[#DataModel.rewardsList].amount)
    if amount > maxAmount then
      amount = maxAmount
    end
    View.Group_Total.Txt_Now:SetText(amount)
    View.Group_Total.Txt_Max:SetText(maxAmount)
    View.Img_PB:SetFilledImgAmount(amount / maxAmount)
    View.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    View.Img_Title:SetSprite(GetResPath(88300305))
  end
end

function Controller:SetElement(element, elementIndex)
  element.Btn_Item:SetClickParam(elementIndex)
  local data = DataModel.rewardsList[elementIndex]
  element.Group_Amount.Txt_Num:SetText(data.amount)
  element.Group_Num:SetActive(not data.isGot and data.num > 0)
  if data.num > 0 then
    element.Group_Num.Txt_Num:SetText(string.format(GetText(80610487), data.num))
  end
  element.Img_Icon:SetSprite(data.url)
  element.Img_Btm01:SetActive(not data.isGot)
  element.Img_Btm02:SetActive(data.isGot)
  local isLocked = not data.isGot and not data.isRed
  element.Img_Btn03:SetActive(isLocked)
  element.Txt_UR:SetActive(isLocked)
  element.Txt_R:SetActive(not data.isGot and data.isRed)
  element.Txt_RD:SetActive(data.isGot)
  local isNomalNode = elementIndex < 8
  element.Img_Icon:SetActive(isNomalNode)
  element.Group_Amount.Txt_A:SetActive(isNomalNode)
  element.Group_Num:SetActive(isNomalNode)
  element.Txt_Index:SetActive(isNomalNode)
  if isNomalNode == false then
    local color = "#FFFFFF"
    if data.isGot then
      color = "#CDCDCD"
    elseif not data.isGot and data.isRed then
      color = "#FFB800"
    end
    element.Group_Amount.Txt_Num:SetColor(color)
    element.Img_UR:SetActive(isLocked)
    element.Img_R:SetActive(not data.isGot and data.isRed)
    element.Img_RD:SetActive(data.isGot)
    element.Img_Btm01:SetActive(data.isGot or not data.isRed)
    element.Img_Btm02:SetActive(not data.isGot and data.isRed)
    element.Img_Btn03:SetActive(data.isGot)
  end
end

function Controller:OnClick(index)
  local data = DataModel.rewardsList[index]
  if data.isGot == false and data.isRed then
    index = index - 1
    Net:SendProto("main.cumulative_reward", function(json)
      Controller:InitData(DataModel.id)
      Controller:InitView()
      CommonTips.OpenShowItem(json.reward)
      ActivityMainController:RefreshLeftRedState()
    end, index, 1, DataModel.id)
  elseif data.itemID > 0 then
    CommonTips.OpenPreRewardDetailTips(data.itemID)
  end
end

return Controller
