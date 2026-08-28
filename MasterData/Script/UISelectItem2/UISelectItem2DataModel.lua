local View = require("UISelectItem2/UISelectItem2View")
local CommonItem = require("Common/BtnItem")
local DataModel = {}
DataModel.itemId = 11400339
DataModel.maxUseNum = 0
DataModel.selectNum = 0
DataModel.exchangeList = {}
DataModel.selectExchangeIndex = nil
DataModel.exchangeElementList = {}
DataModel.showSelectDetail = 0

function DataModel.SetJsonData(initParams)
  if initParams then
    local data = Json.decode(initParams)
    DataModel.itemId = data.itemId and tonumber(data.itemId) or DataModel.itemId
    DataModel.showSelectDetail = data.showSelectDetail and tonumber(data.showSelectDetail) or 0
  end
end

function DataModel.InitData()
  DataModel.exchangeList = {}
  DataModel.selectExchangeIndex = nil
  local itemCA = PlayerData:GetFactoryData(DataModel.itemId, "ItemFactory")
  for i, v in ipairs(itemCA.exchangeList) do
    table.insert(DataModel.exchangeList, {
      itemId = v.itemId,
      num = v.num
    })
  end
end

function DataModel.RefreshOnShow()
  local itemId = DataModel.itemId
  if not itemId then
    return
  end
  DataModel.exchangeElementList = {}
  View.ScrollGrid_List.grid.self:SetDataCount(#DataModel.exchangeList)
  View.ScrollGrid_List.grid.self:RefreshAllElement()
  local maxUseNum = PlayerData:GetGoodsById(itemId).num
  local itemCA = PlayerData:GetFactoryData(itemId, "ItemFactory")
  if maxUseNum > itemCA.useLimitNum then
    maxUseNum = itemCA.useLimitNum
  end
  DataModel.maxUseNum = maxUseNum
  View.Group_SelectQuantity:SetActive(itemId ~= 11400339)
  if itemId == 11400339 then
    View.Group_SelectQuantity.Group_Slider.Group_Num.Txt_Max:SetText(maxUseNum)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetMinAndMaxValue(1, maxUseNum, true)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(1)
  end
  if View.Group_SelectQuantity.IsActive then
    View.Group_SelectQuantity.Group_Slider.Group_Num.Txt_Max:SetText(maxUseNum)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetMinAndMaxValue(1, maxUseNum, true)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(1)
  end
  DataModel.SelectExchangeItem(1)
  View.Txt_Title:SetText(itemCA.name)
  View.Btn_Cancel:SetActive(DataModel.showSelectDetail == 0)
  View.Btn_Confirm:SetActive(DataModel.showSelectDetail == 0)
end

function DataModel.RefreshSelectNum(num)
  num = tonumber(num)
  if num < 1 or num > DataModel.maxUseNum then
    return
  end
  DataModel.selectNum = math.floor(num)
  View.Group_SelectQuantity.Group_Slider.Group_Num.Txt_Select:SetText(math.floor(num))
end

function DataModel.SelectExchangeItem(index)
  if DataModel.selectExchangeIndex == index then
    return
  end
  local info = DataModel.exchangeList[index]
  local itemId = info.itemId
  local itemCA = PlayerData:GetFactoryData(itemId)
  if PlayerData:GetGoodsById(itemId).num ~= 0 then
    View.Group_Have:SetActive(DataModel.itemId == 11400339)
  else
    View.Group_Have:SetActive(false)
  end
  CommonItem.SetItem(self, View.Group_Item, {id = itemId})
  View.Group_Num.Txt_Num:SetText(PlayerData:GetGoodsById(itemId).num)
  View.Txt_Name:SetText(itemCA.name)
  View.ScrollView_Describe.Viewport.Txt_Describe:SetText(itemCA.des or itemCA.describe)
  if DataModel.selectExchangeIndex then
    local element = DataModel.exchangeElementList[DataModel.selectExchangeIndex]
    if element then
      element.Img_Selected:SetActive(false)
    end
  end
  local element = DataModel.exchangeElementList[index]
  if element then
    element.Img_Selected:SetActive(true)
  end
  
  local function isHavePartSkin(id)
    for skinUid, v in pairs(PlayerData.CaptainSkinSystem:GetAllSkinData()) do
      if v.id == tostring(id) then
        return true
      end
    end
    return false
  end
  
  local itemExchangeList = itemCA.exchangeList
  if itemExchangeList and 0 < #itemExchangeList then
    local haveCount = 0
    for i = 1, #itemExchangeList do
      local isHave = isHavePartSkin(itemExchangeList[i].itemId)
      if isHave then
        haveCount = haveCount + 1
      end
    end
    if 0 < haveCount then
      View.Group_HaveClo:SetActive(true)
      if haveCount >= #itemExchangeList then
        View.Group_HaveClo.Txt_1:SetActive(true)
        View.Group_HaveClo.Txt_2:SetActive(false)
      else
        View.Group_HaveClo.Txt_1:SetActive(false)
        View.Group_HaveClo.Txt_2:SetActive(true)
      end
    else
      View.Group_HaveClo:SetActive(false)
    end
  else
    View.Group_HaveClo:SetActive(false)
  end
  DataModel.selectExchangeIndex = index
end

return DataModel
