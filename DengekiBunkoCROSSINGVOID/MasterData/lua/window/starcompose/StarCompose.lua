local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local m_composeItemId, m_composeItemType, m_composeNum

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function(go)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonCompose, OnButtonComposeClick)
end

function Reset()
  m_composeNum = 0
  REF.WidgetNumberEdit["$SetNumber"](m_composeNum)
end

function SetData(composeItemId, composeItemType)
  m_composeItemId = composeItemId
  m_composeItemType = composeItemType
  REF.WidgetNumberEdit["$SetNumberUpdateCallback"](OnComposeNumChanged)
  REF.WidgetNumberEdit["$SetNumberValidateCallback"](OnValidateComposeNum)
  m_composeNum = 1
  REF.WidgetNumberEdit["$SetNumber"](m_composeNum)
  REF.WidgetNumberEdit["$SetRange"](0, nil)
  local composeObjSlot = _ENV["$"](REF.ComposeObj).WidgetIconSlot
  composeObjSlot["$BindItem"](composeItemId)
end

function OnComposeNumChanged(num)
  m_composeNum = num
end

function OnValidateComposeNum(num)
  local hasEnoughMaterial, composeMaterialInfo = SetMaterials(num)
  if not hasEnoughMaterial then
    local composeItemName = WU.GetString("ItemName_" .. m_composeItemId)
    local materialItemName = WU.GetString("ItemName_" .. composeMaterialInfo.id)
    WU.ShowHintText(WU.GetString("Window_StarMaterialNotEnough", composeItemName, composeMaterialInfo.exchangeNum, materialItemName))
  end
  return hasEnoughMaterial
end

function OnButtonComposeClick()
  this:GameRequest("fci/resourcecompose/"):Post({
    count = m_composeNum,
    type = m_composeItemType,
    id = m_composeItemId
  }, function(result)
    DBH.ResChange(result.resChange)
    Reset()
    if result.resChange then
      for _, change in pairs(result.resChange) do
        if change.baseRes.id == m_composeItemId then
          REF.LabelUpgradeEffect.gameObject:SetActive(true)
          REF.LabelUpgradeEffect.UILabel.text = "+" .. change.baseRes.countDelta
          REF.LabelUpgradeEffect.UIPlayTween:Play(true)
          REF.UpgradeEffect.EffectGenerator:Play()
          break
        end
      end
    end
  end)
end

function SetMaterials(composeNum)
  local hasEnoughMaterial = false
  local materialsInfo = {}
  
  local function parseResourceCompose(id, type, count)
    local _, entry = PB.all("ResourceCompose"):find(function(_, v)
      return v.targetRes.id == id and v.targetRes.type == type and v.targetRes.count == 1
    end)
    if entry ~= nil then
      for i = 1, #entry.materialRes do
        local material = entry.materialRes[i]
        local hasCount = this:GetData("fci/item/" .. material.id).count
        local needCount = material.count * count
        local costCount = fif(0 <= hasCount - needCount, needCount, hasCount)
        local oweCount = needCount - hasCount
        if oweCount <= 0 then
          hasEnoughMaterial = true
          oweCount = 0
        end
        table.insert(materialsInfo, {
          id = material.id,
          type = material.type,
          cost = costCount,
          exchangeNum = material.count
        })
        parseResourceCompose(material.id, material.type, oweCount)
      end
    end
  end
  
  parseResourceCompose(m_composeItemId, m_composeItemType, composeNum)
  local materialNum = 0
  local composeMaterialInfo
  local canCompose = 0 < composeNum and hasEnoughMaterial
  for _, materialInfo in pairs(materialsInfo) do
    if composeMaterialInfo == nil then
      composeMaterialInfo = {
        id = materialInfo.id,
        exchangeNum = materialInfo.exchangeNum
      }
    end
    if hasEnoughMaterial then
      materialNum = materialNum + 1
      local hasCount = this:GetData("fci/item/" .. materialInfo.id).count
      local materialREF = REF.MaterialList[materialNum - 1]
      materialREF.WidgetIconSlot["$BindItem"](materialInfo.id)
      local label = ""
      local needDisplay = canCompose and 0 < materialInfo.cost
      if needDisplay then
        label = tostring(-materialInfo.cost)
      end
      materialREF.LabelCost.UILabel.text = label
      materialREF.SpriteCostBg.gameObject:SetActive(needDisplay)
      materialREF["$gameObject"]:SetActive(true)
    end
  end
  if hasEnoughMaterial then
    for i = materialNum + 1, #REF.MaterialList do
      REF.MaterialList[i - 1]["$gameObject"]:SetActive(false)
    end
    REF.ButtonCompose.UIButton.isEnabled = canCompose
  end
  return hasEnoughMaterial, composeMaterialInfo
end
