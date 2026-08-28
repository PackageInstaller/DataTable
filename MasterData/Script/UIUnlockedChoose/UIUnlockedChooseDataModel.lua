local View = require("UIUnlockedChoose/UIUnlockedChooseView")
local DataModel = {}
local MoneyItemId = 11400001
local DiamondItemId = 11400005

local function GetItemId(itemId)
  return tonumber(itemId) or itemId
end

local function GetItemConfig(itemId)
  itemId = GetItemId(itemId)
  return PlayerData:GetFactoryData(itemId, "ItemFactory") or PlayerData:GetFactoryData(itemId)
end

local function SetText(node, value)
  if node and node.SetText then
    node:SetText(value or "")
  end
end

local function SetSprite(node, value)
  if node and node.SetSprite and value ~= nil and value ~= "" then
    node:SetSprite(value)
  end
end

local function GetItemIcon(itemCfg)
  if itemCfg == nil then
    return ""
  end
  return itemCfg.tipsPath or itemCfg.iconPath or itemCfg.icon or ""
end

local function OpenLackItemTips(itemId)
  local item = GetItemConfig(itemId) or {}
  CommonTips.OpenTips(string.format(GetText(80601070), item.name or ""))
end

local function MarkChangePosterGirlSerialize()
  local ok, changePosterGirlDataModel = pcall(require, "UIChangePosterGirl/UIChangePosterGirlDataModel")
  if ok and changePosterGirlDataModel.MarkSerializeOnGetwayJump then
    changePosterGirlDataModel.MarkSerializeOnGetwayJump()
  end
end

local function MarkSourceReturn()
  local data = DataModel.data or {}
  if data.source == "RoomBack" then
    local ok, roomBackDataModel = pcall(require, "UIChoseBG/UIChoseBGDataModel")
    if ok and roomBackDataModel.MarkReturnSelectRoomBackId then
      roomBackDataModel.MarkReturnSelectRoomBackId(data.itemId)
    end
  end
end

local function CloseSelfAndMarkSerialize()
  MarkSourceReturn()
  MarkChangePosterGirlSerialize()
  UIManager:CloseTip()
end

local function GetItemGetwayList(itemCfg)
  if itemCfg == nil then
    return nil
  end
  return itemCfg.Getway or itemCfg.GetWay
end

local function JumpToFirstGetway(itemId)
  local itemCfg = GetItemConfig(itemId)
  local getwayList = GetItemGetwayList(itemCfg)
  local getway = getwayList and getwayList[1]
  if getway == nil or getway.UIName == nil or getway.UIName == "" then
    OpenLackItemTips(itemId)
    return
  end
  local getwayDataModel = require("UIGroup_GetWay/UIGroup_GetWayDataModel")
  getwayDataModel.isTrainWeapon = DataManager:GetFactoryNameById(GetItemId(itemId)) == "HomeWeaponFactory"
  getwayDataModel.getwayList = getwayList
  getwayDataModel.goback_num = 1
  CloseSelfAndMarkSerialize()
  local getwayViewFunction = require("UIGroup_GetWay/UIGroup_GetWayViewFunction")
  getwayViewFunction.Group_GetWay_Img_WayBg_ScrollGrid__Group_Item_Group_Forward_Btn_Forward_Click(nil, "1")
end

local function JumpToMoneyMakingGuide()
  CloseSelfAndMarkSerialize()
  UIManager:Open("UI/MoneyMakingGuide/MoneyMakingGuide")
end

local function JumpToDiamondStore()
  CloseSelfAndMarkSerialize()
  CommonTips.OpenStoreBuy()
end

local function JumpToNotEnoughItemGetway(itemId)
  local id = GetItemId(itemId)
  if id == MoneyItemId then
    JumpToMoneyMakingGuide()
    return
  end
  if id == DiamondItemId then
    JumpToDiamondStore()
    return
  end
  JumpToFirstGetway(itemId)
end

local function OpenNotEnoughItemPrompt(itemId)
  local itemCfg = GetItemConfig(itemId) or {}
  local content = string.format(GetText(80612568), itemCfg.name or "")
  CommonTips.OnPrompt(content, nil, nil, function()
    JumpToNotEnoughItemGetway(itemId)
  end, nil, true)
end

local function GetMaterialData(elementIndex)
  local data = DataModel.data
  if data == nil or data.cfg == nil or data.cfg.materialList == nil then
    return nil
  end
  return data.cfg.materialList[elementIndex]
end

local function GetConsumeIndex(elementIndex)
  local offset = -1
  offset = DataModel.data and DataModel.data.indexOffset ~= nil and tonumber(DataModel.data.indexOffset) or offset
  return elementIndex + offset
end

local function RefreshUseItemIfNeeded(json, data)
  if data == nil or data.id == nil or data.num == nil then
    return
  end
  if json ~= nil and json.consumables ~= nil then
    return
  end
  PlayerData:RefreshUseItems({
    [data.id] = data.num
  })
end

local function RefreshRoomBackAfterUnlock(json)
  local data = DataModel.data or {}
  if data.source ~= "RoomBack" then
    return
  end
  local okViewFunction, choseBGViewFunction = pcall(require, "UIChoseBG/UIChoseBGViewFunction")
  if okViewFunction and choseBGViewFunction.RefreshAll then
    choseBGViewFunction.RefreshAll()
  end
end

local function FinishUnlock(json, materialData)
  RefreshUseItemIfNeeded(json, materialData)
  RefreshRoomBackAfterUnlock(json)
  if View.self and View.self.Confirm then
    View.self:Confirm()
  end
  UIManager:CloseTip()
end

local function SendUnlock(elementIndex, materialData)
  local initData = DataModel.data or {}
  local unlockProto = initData.unlockProto
  if unlockProto ~= nil and unlockProto ~= "" then
    Net:SendProto(unlockProto, function(json)
      FinishUnlock(json, materialData)
    end, tostring(initData.itemId), tostring(GetConsumeIndex(elementIndex)))
    return
  end
  Net:SendProto("main.add_show", function(json)
    FinishUnlock(json, materialData)
  end, elementIndex - 1)
end

function DataModel.SetElement(data, element)
  local itemCfg = GetItemConfig(data.id) or {}
  local icon = GetItemIcon(itemCfg)
  SetSprite(element.Btn_Bg.Img_Icon, icon)
  SetText(element.Btn_Bg.Txt_Name, itemCfg.name)
  SetText(element.Btn_Bg.Txt_Des, itemCfg.description or itemCfg.desc or "")
  SetSprite(element.Btn_Bg.Group_Num.Img_Item, icon)
  SetText(element.Btn_Bg.Group_Num.Txt_Num, data.num)
end

function DataModel.RefreshCurrency()
  if View.Btn_Money and View.Btn_Money.Txt_Num then
    View.Btn_Money.Txt_Num:SetText(PlayerData:GetGoodsById(MoneyItemId).num)
  end
  if View.Btn_Diamond and View.Btn_Diamond.Txt_Num then
    View.Btn_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(DiamondItemId).num)
  end
end

function DataModel.OpenMoneyGetway()
  JumpToMoneyMakingGuide()
end

function DataModel.OpenDiamondGetway()
  JumpToDiamondStore()
end

function DataModel.ClickElement(elementIndex)
  local data = GetMaterialData(elementIndex)
  if data == nil then
    return
  end
  if PlayerData:GetGoodsById(data.id).num < data.num then
    OpenNotEnoughItemPrompt(data.id)
    return
  end
  SendUnlock(elementIndex, data)
end

return DataModel
