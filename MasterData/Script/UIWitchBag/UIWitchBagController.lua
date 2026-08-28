local View = require("UIWitchBag/UIWitchBagView")
local DataModel = require("UIWitchBag/UIWitchBagDataModel")
local UIWitchMainDataController = require("UIWitchMain/UIWitchMainDataController")
local Controller = {}

function Controller.RefreshOnShow()
  Controller.RefreshItemGrid()
  Controller.RefreshSelectItemInfo()
end

function Controller.RefreshItemGrid()
  local showItem = #DataModel.items > 0
  View.ScrollGrid_.self:SetActive(showItem)
  View.Group_ItemInfo.self:SetActive(showItem)
  if showItem then
    View.ScrollGrid_.grid.self:SetDataCount(#DataModel.items)
    View.ScrollGrid_.grid.self:RefreshAllElement()
    View.ScrollGrid_.grid.self:MoveToTop()
  end
end

function Controller.RefreshSelectItemInfo()
  local selectIndex = DataModel.selectIndex
  local itemId = DataModel.items[selectIndex]
  View.Group_ItemInfo.Btn_Use:SetActive(itemId and DataModel.IsItemCanUseInBag(itemId))
  if itemId then
    local itemCA = PlayerData:GetFactoryData(itemId, "ItemFactory")
    View.Group_ItemInfo.Img_Item:SetSprite(itemCA.tipsPath)
    View.Group_ItemInfo.Txt_Des:SetText(itemCA.des)
    View.Group_ItemInfo.Txt_Name:SetText(itemCA.name)
  end
end

function Controller.ClickBagItems(index)
  index = tonumber(index)
  if DataModel.selectIndex and index == DataModel.selectIndex then
    return
  end
  DataModel.selectIndex = index
  View.ScrollGrid_.grid.self:RefreshAllElement()
  Controller.RefreshSelectItemInfo()
end

function Controller.UseItem()
  local itemId = DataModel.items[DataModel.selectIndex]
  if not DataModel.IsItemCanUseInBag(itemId) then
    return
  end
  local itemCA = PlayerData:GetFactoryData(itemId, "ItemFactory")
  local itemType = itemCA.playerParkItemType
  if itemCA.parkBuildingGrid and itemCA.parkBuildingGrid > 0 and PlayerData.ServerData.user_witches.map[tostring(itemCA.parkBuildingGrid)] and PlayerData.ServerData.user_witches.map[tostring(itemCA.parkBuildingGrid)].seal then
    CommonTips.OpenTips(string.format(GetText(80610470), itemCA.name))
    return
  end
  
  local function callBack()
    Controller.UseItemRefresh()
    if itemType == "SealInquiry" or itemType == "floatInquiry" then
      UIManager:Open("UI/Witches/Main/ItemFloatInquirySettlement", Json.encode({
        id = itemId,
        type = itemType,
        parkBuildingGrid = itemCA.parkBuildingGrid
      }))
    end
  end
  
  if itemType == "Broom" then
    UIManager:GoBack()
    UIWitchMainDataController.UseItemCalculateNextTriggers(itemId)
  elseif itemType == "energizer" then
    if WitchData.GetStamina() == WitchData.GetStaminaMax() then
      CommonTips.OpenWitchTip(80610567)
      return
    end
    
    local function cb()
      Controller.UseItemRefresh()
      CommonTips.OpenWitchTip(string.format(GetText(80610499), itemCA.parkEnergyNum))
      if UIManager:IsPanelOpened("UI/Witches/Main/WitchMain") then
        local UIWitchMainView = require("UIWitchMain/UIWitchMainView")
        UIWitchMainView.Group_Stamina.Txt_Num:SetText(WitchData.GetStamina() .. "/" .. WitchData.GetStaminaMax())
      end
    end
    
    WitchData.ReqUseItem(itemId, 1, cb)
  elseif itemType == "Sealconvert" then
    local preItemId = itemCA.parkChangeItem
    local afterItemId = itemCA.parkChangeNewItem
    local sealList = WitchData.GetWitchesData().user_seal
    for i, v in ipairs(sealList) do
      if tostring(v) == tostring(preItemId) then
        local function cb()
          Controller.UseItemRefresh()
          
          PlayerData.ServerData.user_witches.user_seal[i] = tostring(afterItemId)
          UIManager:Open("UI/Witches/Main/Seal", Json.encode({index = i, targetId = afterItemId}))
        end
        
        WitchData.ReqUseItem(itemId, 1, cb)
        return
      end
    end
  elseif itemType == "guka" then
    local function cb(json)
      Controller.UseItemRefresh()
      
      local selectInfo = json.temp_select and json.temp_select.item_guka
      if selectInfo and 0 < #selectInfo then
        UIManager:Open("UI/Witches/Guka/GuKaChoose", Json.encode({rewardType = "item_guka"}))
      end
    end
    
    WitchData.ReqUseItem(itemId, 1, cb)
  else
    WitchData.ReqUseItem(itemId, 1, callBack)
  end
end

function Controller.UseItemRefresh()
  local itemId = DataModel.items[DataModel.selectIndex]
  local num = WitchData.GetItemNumById(itemId)
  if num == 0 then
    table.remove(DataModel.items, DataModel.selectIndex)
  end
  DataModel.selectIndex = 1
  Controller.RefreshItemGrid()
  Controller.RefreshSelectItemInfo()
end

return Controller
