local View = require("UISelectItem2/UISelectItem2View")
local DataModel = require("UISelectItem2/UISelectItem2DataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  SelectItem2_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
  end,
  SelectItem2_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local info = DataModel.exchangeList[elementIndex]
    local data = {
      id = info.itemId,
      num = info.num
    }
    CommonItem.SetItem(self, element.Group_Item, data)
    local itemCA = PlayerData:GetFactoryData(info.itemId, "ItemFactory")
    element.Txt_Name:SetText(itemCA.name)
    element.Group_Item.Btn_Item:SetClickParam(info.itemId)
    element.Btn_Item:SetClickParam(elementIndex)
    element.Img_Selected:SetActive(elementIndex == DataModel.selectExchangeIndex)
    DataModel.exchangeElementList[elementIndex] = element
  end,
  SelectItem2_ScrollGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.SelectExchangeItem(tonumber(str))
  end,
  SelectItem2_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  SelectItem2_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  SelectItem2_Group_SelectQuantity_Btn_Min_Click = function(btn, str)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(tonumber(str))
  end,
  SelectItem2_Group_SelectQuantity_Btn_Dec_Click = function(btn, str)
    local num = DataModel.selectNum - 1
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(num)
  end,
  SelectItem2_Group_SelectQuantity_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel.RefreshSelectNum(value)
  end,
  SelectItem2_Group_SelectQuantity_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  SelectItem2_Group_SelectQuantity_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  SelectItem2_Group_SelectQuantity_Btn_Add_Click = function(btn, str)
    local num = DataModel.selectNum + 1
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(num)
  end,
  SelectItem2_Group_SelectQuantity_Btn_Max_Click = function(btn, str)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(DataModel.maxUseNum)
  end,
  SelectItem2_Btn_Confirm_Click = function(btn, str)
    local info = DataModel.exchangeList[DataModel.selectExchangeIndex]
    if info then
      local function isHavePartSkin(id)
        for skinUid, v in pairs(PlayerData.CaptainSkinSystem:GetAllSkinData()) do
          if v.id == tostring(id) then
            return true
          end
        end
        return false
      end
      
      local itemCA = PlayerData:GetFactoryData(info.itemId, "ItemFactory")
      local itemExchangeList = itemCA.exchangeList
      
      local function sendFunc()
        Net:SendProto("item.use_items", function(json)
          PlayerData:RefreshUseItems({
            [DataModel.itemId] = DataModel.selectNum
          })
          View.self:CloseUI(true)
          CommonTips.OpenShowItem(json.reward)
        end, tostring(DataModel.itemId), DataModel.selectNum, DataModel.selectExchangeIndex - 1)
      end
      
      local function doFunc()
        CommonTips.OnPrompt(string.format(GetText(80607353), itemCA.name), "80600068", "80600067", function()
          sendFunc()
        end)
      end
      
      local haveCount = 0
      if itemExchangeList and 0 < #itemExchangeList then
        for i = 1, #itemExchangeList do
          local isHave = isHavePartSkin(itemExchangeList[i].itemId)
          if isHave then
            haveCount = haveCount + 1
          end
        end
        if 0 < haveCount then
          if haveCount >= #itemExchangeList then
            CommonTips.OnPrompt(GetText(80611482), "80600068", "80600067", function()
              sendFunc()
            end)
          else
            CommonTips.OnPrompt(GetText(80611483), "80600068", "80600067", function()
              sendFunc()
            end)
          end
        else
          doFunc()
        end
      else
        doFunc()
      end
    end
  end,
  SelectItem2_Btn_Cancel_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
