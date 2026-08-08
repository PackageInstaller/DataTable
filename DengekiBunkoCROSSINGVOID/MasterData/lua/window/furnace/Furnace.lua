local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_materials = {}
local m_materialUsed = {}
local m_rowCount

function SetupWindow()
  LU.Bind(REF.WrapContentMaterial, {
    updateRow = UpdateMaterial
  })
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    for k, v in pairs(m_materials) do
      if v.selectCnt > 0 then
        local reqItem = {
          type = v.type,
          id = v.id,
          count = v.selectCnt
        }
        table.insert(m_materialUsed, reqItem)
      end
    end
    if #m_materialUsed <= 0 then
      WU.ShowHintText(WU.GetString("UniqueWeapon_ChooseMaterialFirst"))
      return
    end
    this:GameRequest("fci/furnace/"):Post({materials = m_materialUsed}, function(resp)
      DBH.ResChange(resp.resChange)
      REF.EffectRefine.EffectGenerator:Play(function()
        WU.AcquireWindowAsync("HintEasy", function(win)
          _ENV["$"](win)["$$SetContent"](resp.resChange, "UI_panle_bg_Sa", "UI_panle_bg_Sb", InitialData)
        end)
      end)
    end)
  end)
end

function InitWindow()
  this:RegisterGameEvent("Furnace/OnCountChange", function()
    LU.Set(REF.WrapContentMaterial, GetRow())
  end)
  m_rowCount = #_ENV["$"](REF.WidgetSlotRow3).root
  LU.Set(REF.WrapContentMaterial, 0)
  InitialData()
end

function InitialData()
  m_materialUsed = {}
  m_materials = {}
  GetMaterials()
  LU.Set(REF.WrapContentMaterial, GetRow())
end

function GetMaterials()
  local furnaceInfo = PB.all("FurnaceMaterials")
  for k, v in pairs(furnaceInfo) do
    local item = this:GetData("fci/item/" .. v.material.id)
    if item.count > 0 then
      local copy = {
        type = v.material.type,
        id = item.id,
        count = item.count,
        selectCnt = 0
      }
      table.insert(m_materials, copy)
    end
  end
end

function UpdateMaterial(ref, wrapIndex, realIndex)
  if m_materials == nil or realIndex >= #m_materials then
    return
  end
  for i = 1, m_rowCount do
    local idx = realIndex * m_rowCount + i
    local gasket = ref.root[i - 1]
    local curItem = m_materials[idx]
    if curItem then
      gasket.root.gameObject:SetActive(true)
      gasket["$$SetData"](curItem.type, curItem.id, curItem.count)
      gasket["$$SetCount"](curItem.selectCnt)
      gasket["$$SetClickCallback"](function()
        if curItem.selectCnt > 1 then
          WU.AcquireWindowAsync("FurnaceItemDetail", function(window)
            _ENV["$"](window)["$$SetItem"](curItem)
          end)
        else
          SetCount(curItem, 1, gasket)
          SetItemBack()
          return true
        end
      end)
      gasket["$$SetRemoveCallback"](function()
        SetCount(curItem, -1, gasket)
        SetItemBack()
        return true
      end)
    else
      gasket["$$ClearSlot"]()
    end
  end
  SetItemBack()
end

function SetCount(item, pace, gasket)
  item.selectCnt = math.clamp(item.selectCnt + pace, 0, item.count)
  gasket["$$SetCount"](item.selectCnt)
end

function SetItemBack()
  local itemBack = WU.GetFurnaceItemBack(m_materials)[1]
  REF.ItemGet["$SetData"](itemBack.type, itemBack.id, itemBack.count)
end

function GetRow()
  local row, rest = math.modf(#m_materials / m_rowCount)
  if rest ~= 0 then
    row = row + 1
  end
  return row
end
