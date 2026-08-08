local WU, DB = require("Common/WindowUtil")()
local LU = {}

function LU.UpdateGridSlot(dataSource, updateSlot, updateRow, slotsName)
  local function updateSingleRow(gameObject, wrapIndex, rowIndex)
    if rowIndex < 0 then
      rowIndex = -rowIndex
    end
    local rowRef = _ENV["$"](gameObject)
    if updateSlot then
      local slots
      if slotsName then
        slots = rowRef[slotsName]
      else
        slots = rowRef["$"]
      end
      if dataSource ~= nil then
        local isFunc = type(dataSource) == "function"
        local slotCnt = #slots
        for slotInRow = 0, slotCnt - 1 do
          local dataIndex = rowIndex * slotCnt + slotInRow + 1
          local context
          if isFunc then
            context = dataSource(dataIndex)
          elseif dataIndex <= #dataSource then
            context = dataSource[dataIndex]
          end
          local slot = slots[slotInRow]
          slot["@context"] = context
          slot["@dataIndex"] = dataIndex
          slot["$gameObject"]:SetActive(context ~= nil)
          if context then
            updateSlot(slot, context)
          end
        end
      end
    end
    if updateRow then
      updateRow(rowRef, wrapIndex, rowIndex)
    end
  end
  
  return updateSingleRow
end

function LU.Bind(gasket, options)
  local dataSource = options.dataSource
  local updateSlot = options.updateSlot
  local updateRow = options.updateRow
  local delta = options.delta
  local slotsName = options.slotsName
  local owner = gasket:queryParent("LuaInjector")
  local updateSlotProxy = updateSlot
  if delta ~= nil and updateSlot ~= nil then
    function updateSlotProxy(slotRef, data)
      local co = slotRef["@coroutine"]
      
      if co ~= nil then
        owner:StopCoroutine(co)
        slotRef["@coroutine"] = nil
      end
      if gasket["@instant"] then
        updateSlot(slotRef, data)
      else
        updateSlot(slotRef, nil)
        slotRef["@coroutine"] = owner:DelayInvokeInSeconds(slotRef["@dataIndex"] * delta, function()
          updateSlot(slotRef, data)
        end)
      end
    end
  end
  local updateRowProxy = updateRow
  if delta ~= nil and updateRow ~= nil then
    function updateRowProxy(rowRef, wrapIndex, rowIndex)
      local co = rowRef["@coroutine"]
      
      if co ~= nil then
        owner:StopCoroutine(co)
        rowRef["@coroutine"] = nil
      end
      if gasket["@instant"] then
        updateRow(rowRef, wrapIndex, rowIndex)
      else
        updateRow(rowRef, nil, nil)
        rowRef["@coroutine"] = owner:DelayInvokeInSeconds(rowIndex * delta, function()
          updateRow(rowRef, wrapIndex, rowIndex)
        end)
      end
    end
  end
  gasket.UIWrapContent.onInitializeItem = LU.UpdateGridSlot(dataSource, updateSlotProxy, updateRowProxy, slotsName)
end

function LU.Set(gasket, slots, resetPosition, forceInstant)
  if resetPosition == nil then
    resetPosition = true
  end
  if forceInstant == nil then
    forceInstant = false
  end
  gasket["@instant"] = forceInstant
  gasket.UIWrapContent:UpdateContent(slots, resetPosition)
  gasket["@instant"] = true
end

return LU
