local View = require("UIActivityRechargeCommon/UIActivityRechargeCommonView")
local DataModel = require("UIActivityRechargeCommon/UIActivityRechargeCommonDataModel")
local ActivityMainController = require("UIActivityMain/UIActivityMainController")
local Controller = {}

function Controller:InitData(id)
  local isRed = false
  local Data = PlayerData:GetFactoryData(id, "ActivityFactory")
  local cumulative_rw = {}
  DataModel.bm_rock = 0
  DataModel.Bg = Data.Bg
  DataModel.titleId = Data.titleId
  DataModel.TimeBg = Data.TimeBg
  DataModel.FullBgD = Data.FullBgD
  DataModel.FullBgU = Data.FullBgU
  DataModel.coinX = Data.coinX
  DataModel.coinY = Data.coinY
  DataModel.URDColor = Data.URDColor
  DataModel.RColor = Data.RColor
  DataModel.RDColor = Data.RDColor
  DataModel.logoX = Data.logoX
  DataModel.logoY = Data.logoY
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
      temp.Bg1 = value.Bg1
      temp.Bg2 = value.Bg2
      temp.Bg3 = value.Bg3
      temp.BgX = value.BgX
      temp.BgY = value.BgY
      temp.itemX = value.itemX
      temp.itemY = value.itemY
      temp.BgUR = value.BgUR
      temp.BgR = value.BgR
      temp.BgRD = value.BgRD
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
  View.Group_Bg.Img_BG:SetSprite(DataModel.Bg)
  View.Img_Title:SetSprite(GetResPath(DataModel.titleId))
  View.Img_Title:SetNativeSize()
  View.Img_Title:SetAnchoredPosition(Vector2(DataModel.logoX, DataModel.logoY))
  View.Img_TimeBG:SetSprite(DataModel.TimeBg)
  View.Img_PBBG:SetSprite(DataModel.FullBgD)
  View.Img_PB:SetSprite(DataModel.FullBgU)
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
  end
end

function Controller:SetElement(element, elementIndex)
  element.Btn_Item:SetClickParam(elementIndex)
  local data = DataModel.rewardsList[elementIndex]
  element:SetAnchoredPosition(Vector2(data.BgX, data.BgY))
  if data.Bg1 ~= "" then
    element.Img_Btn01:SetSprite(data.Bg1)
    element.Img_Btn01:SetNativeSize()
  end
  if data.Bg2 ~= "" then
    element.Img_Btn02:SetSprite(data.Bg2)
    element.Img_Btn02:SetNativeSize()
  end
  if data.Bg3 ~= "" then
    element.Img_Btn03:SetSprite(data.Bg3)
    element.Img_Btn03:SetNativeSize()
  end
  if data.BgUR ~= "" then
    element.Img_UR:SetSprite(data.BgUR)
    element.Img_UR:SetNativeSize()
  end
  if data.BgR ~= "" then
    element.Img_R:SetSprite(data.BgR)
    element.Img_R:SetNativeSize()
  end
  if data.BgRD ~= "" then
    element.Img_RD:SetSprite(data.BgRD)
    element.Img_RD:SetNativeSize()
  end
  element.Group_Amount.Txt_Num:SetText(data.amount)
  element.Group_Num:SetActive(data.num > 0)
  if data.num > 0 then
    element.Group_Num.Txt_Num:SetText(string.format(GetText(80610487), data.num))
    local color = DataModel.URDColor
    if data.isGot then
      color = DataModel.RDColor
    elseif not data.isGot and data.isRed then
      color = DataModel.RColor
    end
    element.Group_Num.Txt_Num:SetColor("#" .. color)
  end
  element.Img_Icon:SetSprite(data.url)
  element.Img_Icon:SetAnchoredPosition(Vector2(data.itemX, data.itemY))
  element.Img_Btn01:SetActive(not data.isGot)
  element.Img_Btn02:SetActive(data.isGot)
  local isLocked = not data.isGot and not data.isRed
  element.Img_Btn03:SetActive(isLocked)
  element.Txt_UR:SetActive(isLocked)
  element.Txt_R:SetActive(not data.isGot and data.isRed)
  element.Txt_RD:SetActive(data.isGot)
  local isNomalNode = elementIndex < 8
  element.Img_Icon:SetActive(isNomalNode)
  element.Group_Amount.Txt_A:SetActive(isNomalNode)
  element.Group_Num:SetActive(isNomalNode)
  element.Txt_Index:SetText(tonumber(elementIndex))
  element.Txt_Index:SetActive(isNomalNode)
  if isNomalNode == false then
    local color = "#FFFFFF"
    if data.isGot then
      color = "#CDCDCD"
    elseif not data.isGot and data.isRed then
      color = "#FFB800"
    end
    local X = tonumber(DataModel.coinX)
    local Y = tonumber(DataModel.coinY)
    element.Group_Amount:SetAnchoredPosition(Vector2(X, Y))
    local imgX = X - 68
    local imgY = Y - 17
    element.Img_UR:SetAnchoredPosition(Vector2(imgX, imgY))
    element.Img_R:SetAnchoredPosition(Vector2(imgX, imgY))
    element.Img_RD:SetAnchoredPosition(Vector2(imgX, imgY))
    local txtX = X + 43
    local txtY = Y - 37
    element.Txt_UR:SetAnchoredPosition(Vector2(txtX, txtY))
    element.Txt_UR:SetColor(color)
    element.Txt_R:SetAnchoredPosition(Vector2(txtX, txtY))
    element.Txt_R:SetColor(color)
    element.Txt_RD:SetAnchoredPosition(Vector2(txtX, txtY))
    element.Txt_RD:SetColor(color)
    element.Group_Amount.Txt_Num:SetColor(color)
    element.Img_UR:SetActive(isLocked)
    element.Img_R:SetActive(not data.isGot and data.isRed)
    element.Img_RD:SetActive(data.isGot)
    element.Img_Btn01:SetActive(data.isGot or not data.isRed)
    element.Img_Btn02:SetActive(not data.isGot and data.isRed)
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
