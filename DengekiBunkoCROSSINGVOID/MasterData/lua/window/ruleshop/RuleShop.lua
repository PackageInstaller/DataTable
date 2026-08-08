local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_commonShopId = 1
local m_EQUIP_SHOP_ID = 11
local m_suitEquipIds, m_singleEquipIds

function SetupWindow()
  LU.Bind(REF.WrapSuit, {
    dataSource = function(dataIndex)
      return m_suitEquipIds and m_suitEquipIds[dataIndex]
    end,
    updateSlot = OnSuitShow
  })
  LU.Bind(REF.WrapSingle, {
    dataSource = function(dataIndex)
      return m_singleEquipIds and m_singleEquipIds[dataIndex]
    end,
    updateSlot = OnSuitShow
  })
end

function InitWindow()
  REF.ScrollView.UIScrollView:ResetPosition()
end

function SetShopId(shopId)
  REF.Label1.UIHtmlLabel.text = WU.GetString("Help_Shop" .. shopId)
  REF.NodeShop.gameObject:SetActive(shopId ~= m_EQUIP_SHOP_ID)
  REF.NodeShopEquip.gameObject:SetActive(shopId == m_EQUIP_SHOP_ID)
  SetRuleInfo(shopId)
end

function SetRuleInfo(shopId)
  REF.LabelShopProbability.UIHtmlLabel.text = WU.GetString("Help_Shop" .. shopId .. "_1")
  local dropDisplayShopRes = PB.all("DropDisplayShop"):where(function(_, e)
    return e.shopId == shopId
  end):toarray()
  if shopId ~= m_EQUIP_SHOP_ID then
    for i = 1, #REF.AllQuality do
      local isActive = i <= #dropDisplayShopRes
      REF.AllQuality[i - 1]["$"].gameObject:SetActive(isActive)
      if isActive then
        local info = dropDisplayShopRes[i]
        local widgetIconSlot = REF.AllQuality[i - 1].WidgetIconSlot
        local resourceType = info.resourceType
        if resourceType == PB.enum.ResourceType.ResItem then
          local funcType = info.funcType
          if funcType == 1 then
            widgetIconSlot["$SetData"](PB.enum.ResourceType.ResItem, -4)
          elseif funcType == 3 then
            widgetIconSlot["$SetData"](PB.enum.ResourceType.ResItem, -1)
          end
        elseif resourceType == PB.enum.ResourceType.ResEquip then
          widgetIconSlot["$SetData"](PB.enum.ResourceType.ResItem, -3)
        end
        local labelProbability = REF.AllQuality[i - 1].LabelProbability
        labelProbability.UILabel.text = string.format("%.1f%%", info.probability / 100)
      end
    end
  else
    if m_suitEquipIds == nil then
      m_suitEquipIds = {}
      local suitRes = PB.all("DropDisplayShop"):where(function(_, e)
        return e.isSuit
      end):toarray()
      for i = 1, #suitRes do
        local suitInfo = PB.get("EquipSuitAttr", suitRes[i].id)
        if suitInfo then
          local tmp = suitInfo.equipId
          local equipIds = {}
          for j = 1, #tmp do
            local equip = PB.get("EquipInfo", tmp[j])
            if equip then
              equipIds[equip.pos] = tmp[j]
            end
          end
          for j = 0, 3 do
            table.insert(m_suitEquipIds, fif(equipIds[j] == nil, 0, equipIds[j]))
          end
        else
          error("DropDisplayShop.xlsx", "cannot find suit in EquipSuitAttr, id: " .. suitRes[i].id)
        end
      end
    end
    LU.Set(REF.WrapSuit, math.ceil(#m_suitEquipIds / 4), false)
    local offsetY = math.ceil(#m_suitEquipIds / 4) * 250
    REF.SpriteLabelSingle.transform.localPosition = REF.SpriteLabelSuit.transform.localPosition + CS.UnityEngine.Vector3(0, -100 - offsetY, 0)
    REF.WrapSingle.transform.localPosition = REF.SpriteLabelSuit.transform.localPosition + CS.UnityEngine.Vector3(0, -250 - offsetY, 0)
    if m_singleEquipIds == nil then
      m_singleEquipIds = {}
      local singleRes = PB.all("DropDisplayShop"):where(function(_, e)
        return e.resourceType == PB.enum.ResourceType.ResEquip and not e.isSuit
      end):toarray()
      local tempData = {}
      for i = 1, #singleRes do
        local equipInfo = PB.get("EquipInfo", singleRes[i].id)
        if equipInfo then
          table.insert(tempData, equipInfo)
        else
          error("DropDisplayShop.xlsx", "cannot find equip id in EquipInfo: " .. singleRes[i].id)
        end
      end
      table.sort(tempData, function(a, b)
        if a.quality > b.quality then
          return true
        elseif a.quality < b.quality then
          return false
        elseif a.pos < b.pos then
          return true
        elseif a.pos > b.pos then
          return false
        elseif a.equipId < b.equipId then
          return true
        else
          return false
        end
      end)
      for i = 1, #tempData do
        table.insert(m_singleEquipIds, tempData[i].equipId)
      end
    end
    LU.Set(REF.WrapSingle, math.ceil(#m_singleEquipIds / 4), false)
    REF.SpriteLabelSingle.gameObject:SetActive(not _ENV["!"](m_singleEquipIds):empty())
  end
  REF.AllQuality.UIGrid:Reposition()
  this:DelayInvokeInFrames(1, function()
    REF.Table.UITable:Reposition()
  end)
end

function OnSuitShow(ref, data)
  if data == 0 then
    ref["$$SetEmpty"](2)
  else
    ref["$$SetData"](PB.enum.ResourceType.ResEquip, data, 1)
  end
end
