local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_itemList

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnUIClose)
  REF.ButtonClose["$SetCallback"](OnUIClose)
  REF.Black["$SetCallback"](OnUIClose)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateItemSlot
  })
end

function OnUIClose()
  WU.RecycleWindow(this)
end

function SetItemList(itemList)
  m_itemList = itemList:select(function(v)
    return {
      id = v.id,
      count = v.count
    }
  end)
  if 0 < #m_itemList then
    local totalPrice = 0
    for _, item in pairs(m_itemList) do
      local itemInfo = PB.get("ItemInfo", item.id)
      totalPrice = totalPrice + itemInfo.sellPrice.count * item.count
    end
    local sellPrice = PB.get("ItemInfo", m_itemList[1].id).sellPrice
    local icon = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[sellPrice.type] .. "_" .. sellPrice.id .. "' />"
    REF.LabelPrice.UIHtmlLabel.text = WU.GetString("Window_ItemSellPriceTotal", icon .. tostring(totalPrice))
  end
  REF.ScrollView.UIScrollView.contentPivot = fif(#itemList <= 6, CS.UIWidget.Pivot.Center, CS.UIWidget.Pivot.Left)
  LU.Set(REF.WrapContent, #m_itemList)
  local postTable = {itemsell = m_itemList}
  local wireFormatTable = ProtobufT("ApiItemSell", postTable)
  this:GameRequest("fci/itemsell"):Post(wireFormatTable, function(result)
    DBH.ResChange(result.resChange)
  end)
end

function UpdateItemSlot(slotRef, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if itemIndex <= #m_itemList then
    local item = m_itemList[itemIndex]
    slotRef["$$SetData"](PB.enum.ResourceType.ResItem, item.id, item.count)
    slotRef["$$ShowCustom"]({showTimeLimit = false, dropUp = false})
  end
end
