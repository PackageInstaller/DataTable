local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_opChipList = {}
local m_ctChipList = {}
local m_actors = {}
local m_curChip, m_exchangeInfo
local m_setSuccessB4 = false
local m_confirmDesc, m_UIScrollView, m_top, m_bottom, m_togglesChips, m_ac

function SetupWindow()
  ManageButtonEvents()
  WU.TraverseChildren(REF.WrapContentCustom, function(go, index)
    local ref = _ENV["$"](go).root
    ref["$SetIndex"](index + 1)
  end)
  m_UIScrollView = REF.ScrollView.UIScrollView
  m_togglesChips = REF.TogglesChips
  local regionY = m_togglesChips.UIWidget.height - 212
  m_top = regionY / 2 - 7.5
  m_bottom = m_top - regionY + 5
end

function InitWindow()
  m_opChipList = this:GetData("ActorChipExchange/OptionalChipListNoOrder")
  m_ctChipList = InitData("ActorChipExchange/CustomChipList", {})
  m_exchangeInfo = this:GetData("fci/chipexchange/")
  for k, v in pairs(m_ctChipList) do
    for _k, _v in pairs(m_opChipList) do
      if v == _v.id then
        m_opChipList[_k].chosen = true
      end
    end
  end
  SetCustomListData()
  this:RegisterGameEvent("ActorChipSelectedChange", OnSelectedChange)
  this:BroadcastGameEvent("ActorChipSelectedByIndex", 1)
  LU.Set(REF.WrapContentOptional, 0)
  LU.Bind(REF.WrapContentOptional, {
    updateRow = UpdateActorChipSlot
  })
  LU.Set(REF.WrapContentOptional, #m_opChipList)
  LU.Set(REF.WrapContentCustom, 0)
  LU.Bind(REF.WrapContentCustom, {
    updateRow = UpdateActorCoupleChipSlot
  })
  LU.Set(REF.WrapContentCustom, math.floor(#m_opChipList * 0.5))
end

function UninitWindow()
  ResetData()
end

function SetCustomListData(reset)
  WU.TraverseChildren(REF.WrapContentCustom, function(go, index)
    local ref = _ENV["$"](go).root
    local data = fif(reset, {}, m_ctChipList)
    ref["$SetCustom"](data, index + 1)
  end)
end

function UpdateActorChipSlot(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_opChipList == nil or realIndex >= #m_opChipList then
    return
  end
  local gb = _ENV["$"](rowRef.root)
  local chip = m_opChipList[realIndex + 1]
  gb.root.UITexture.mainTexturePath = "Texture/ActorChipIcon/ResItem_" .. chip.id
  REF["SpriteSelect" .. realIndex + 1].gameObject:SetActive(m_opChipList[realIndex + 1].chosen)
end

function UpdateActorCoupleChipSlot(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_opChipList == nil or realIndex >= math.floor(#m_opChipList * 0.5) then
    return
  end
  local idx = realIndex + 1
  local chip1 = m_ctChipList[idx * 2 - 1]
  local chip2 = m_ctChipList[idx * 2]
  rowRef["$$SetData"](chip1, chip2)
end

function InitData(key, nilData)
  local data = this:GetData(key)
  local temp = _ENV["!"]({})
  if data then
    _ENV["!"](data):copy(temp)
  end
  return fif(data == nil, nilData, temp)
end

function ResetData()
  m_ctChipList = {}
  for k, v in pairs(m_opChipList) do
    v.chosen = false
  end
  this:SetData("ActorChipExchange/OptionalChipList", m_opChipList)
  this:BroadcastGameEvent("ActorChipSelectedByIndex", 1)
  SetCustomListData(true)
  LU.Set(REF.WrapContentOptional, #m_opChipList)
  LU.Set(REF.WrapContentCustom, math.floor(#m_opChipList * 0.5))
end

function ManageButtonEvents()
  for i = 1, #PB.index("Misc", 1).chipExchangeSet do
    WU.BindButtonEvent(REF["BottomChip" .. i].UIButton, function()
      if m_curChip == nil then
        return
      end
      local chip = m_opChipList[i]
      if not chip.chosen then
        if m_curChip.custom then
          for k, v in pairs(m_opChipList) do
            if v.id == m_curChip.custom then
              v.chosen = false
            end
          end
        end
        local idx = m_curChip.chipIndex
        m_curChip.custom = chip.id
        m_ctChipList[idx] = chip.id
        m_opChipList[i].chosen = true
        LU.Set(REF.WrapContentOptional, #m_opChipList, false)
        LU.Set(REF.WrapContentCustom, math.floor(#m_opChipList * 0.5), false)
        local nextIdx = m_curChip.chipIndex + 1
        if 8 < nextIdx then
          nextIdx = nextIdx - 8
        end
        if not m_ctChipList[nextIdx] or m_ctChipList[nextIdx] == 0 then
          this:BroadcastGameEvent("ActorChipSelectedByIndex", nextIdx)
        end
      elseif m_curChip.custom then
        local index, ctChip = table.find(m_ctChipList, function(key, val)
          return chip.id == val
        end)
        if m_curChip.custom == chip.id then
          m_ctChipList[index] = nil
          m_opChipList[i].chosen = false
          m_curChip.custom = nil
          LU.Set(REF.WrapContentOptional, #m_opChipList, false)
        else
          this:BroadcastGameEvent("ActorChipSelectedByIndex", index, function(targetItem)
            local tempChip = m_ctChipList[index]
            m_ctChipList[index] = m_ctChipList[m_curChip.chipIndex]
            m_ctChipList[m_curChip.chipIndex] = tempChip
            targetItem.custom = m_curChip.custom
            m_curChip.custom = chip.id
          end)
        end
        LU.Set(REF.WrapContentCustom, math.floor(#m_opChipList * 0.5), false)
      else
        local index, ctChip = table.find(m_ctChipList, function(key, val)
          return chip.id == val
        end)
        this:BroadcastGameEvent("ActorChipSelectedByIndex", index, function(targetItem)
          m_ctChipList[m_curChip.chipIndex] = m_ctChipList[index]
          m_curChip.custom = chip.id
          m_ctChipList[index] = nil
          targetItem.custom = nil
          LU.Set(REF.WrapContentCustom, math.floor(#m_opChipList * 0.5), false)
        end)
      end
    end)
  end
  WU.BindButtonEvent(REF.ButtonContent, function()
    WU.AcquireWindowAsync("ActorChipExchangePreview")
  end)
  WU.BindButtonEvent(REF.ButtonReset, ResetData)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    local condition, tip = ConfirmCondition()
    if not condition then
      WU.ShowHintText(WU.GetString(tip))
      return
    else
      WU.ShowMessageYesNo(WU.GetString(tip) .. m_confirmDesc, function(result)
        if result == "YES" then
          RequestChangePos()
        else
          return
        end
      end)
    end
  end)
end

function ConfirmCondition()
  local changePos = false
  local fullSet = true
  local notSet = true
  local tempList = NormalizeCtList()
  for k, v in pairs(m_ctChipList) do
    if v ~= nil and v ~= 0 then
      notSet = false
      break
    end
  end
  if notSet then
    return true, "Window_ConfirmToReset"
  end
  if 0 >= #m_exchangeInfo.settlePosInfo then
    changePos = true
  else
    for i = 1, #m_exchangeInfo.settlePosInfo do
      if m_exchangeInfo.settlePosInfo[i] ~= tempList[i] then
        changePos = true
        break
      end
    end
  end
  if not changePos then
    return false, "Window_NotChangePosChipExchange"
  end
  for i = 1, PB.enum.MiscEnum.ChipExchangePosMaxCount do
    if m_ctChipList[i] == nil or m_ctChipList[i] == 0 then
      fullSet = false
      break
    end
  end
  if not fullSet then
    return true, "Window_NotSetFullChipExchange"
  end
  return true, "Window_SureAbtActorChipExchange"
end

function RequestChangePos()
  local requestArray = NormalizeCtList()
  this:GameRequest("fci/chipexchange/"):Post({chips = requestArray}, function(resp)
    this:SetData("fci/chipexchange/", resp)
    this:BroadcastGameEvent("ActorChipExchangeEffectOn", 2, 0.034, 0.2)
    this:BroadcastGameEvent("ActorChipExchangeSuccess", resp)
    WU.RecycleWindow(this)
  end)
end

function SetDesc(preheat, ac)
  m_ac = ac
  if preheat then
    REF.LabelDesc.UIHtmlLabel.text = WU.GetString("Window_ActorChipExchangeDescPreheat", WU.RenderTime2(m_ac.timestampStart, true, true))
    m_confirmDesc = WU.GetString("Window_ConfirmToActorChipExchangePreheat", WU.RenderTime2(m_ac.timestampStart, true, true))
  else
    REF.LabelDesc.UIHtmlLabel.text = WU.GetString("Window_ActorChipExchangeDesc")
    m_confirmDesc = WU.GetString("Window_ConfirmToActorChipExchange")
  end
end

function NormalizeCtList()
  local temp = _ENV["!"]({})
  for i = 1, PB.enum.MiscEnum.ChipExchangePosMaxCount do
    if m_ctChipList[i] == nil then
      temp[i] = 0
    else
      temp[i] = m_ctChipList[i]
    end
  end
  return temp
end

function OnSelectedChange(item)
  m_curChip = item
  local relativePos = m_togglesChips.transform:InverseTransformPoint(item.transform.position)
  if relativePos.y > m_top then
    relativePos.x = 0
    relativePos.z = 0
    relativePos.y = m_top - relativePos.y
    m_UIScrollView:SpringRelative(relativePos, 12)
  elseif relativePos.y < m_bottom then
    relativePos.x = 0
    relativePos.z = 0
    relativePos.y = m_bottom - relativePos.y
    m_UIScrollView:SpringRelative(relativePos, 12)
  end
end
