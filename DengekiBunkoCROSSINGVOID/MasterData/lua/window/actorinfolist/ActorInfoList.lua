local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local SU = require("Common/SortUtil")
local GU = require("Common/GroupUtil")
local m_actorList, m_advancedFilters, m_displayOption, m_displayNumbers

function SetupWindow()
  LU.Bind(REF.WrapContentActors, {
    updateRow = UpdateActorSlot
  })
end

function InitWindow()
  this:Bind("SortFinished", OnSortFinished)
end

function OnSortFinished(data)
  if data ~= nil and REF["$SortMate"] == data.sortMate then
    m_actorList = data.list
    local sortMate = data.sortMate
    m_advancedFilters = data.advancedFilters
    REF.SortFullScreenFilters["$FilterContext"](m_advancedFilters)
    m_actorList = SU.ApplyFilters(data.list, m_advancedFilters)
    m_displayOption = SU.DisplayOption[data.advancedFilters.displayOption]
    local id = sortMate.ids[sortMate.tabIndex]
    for _, ids in pairs(SU.DisplayNumbers) do
      if table.find(ids, function(_, v)
        return v == id
      end) then
        m_displayNumbers = ids
      end
    end
    RefreshWrapContent()
  end
end

function RefreshWrapContent()
  LU.Set(REF.WrapContentActors, #m_actorList)
  local index = table.find(m_actorList, function(k, v)
    return v.uid == this:GetData("Actor/SelectedUid")
  end)
  if index then
    local movement = math.clamp(REF.AnchorScrollViewActors.UIWidget.width / 2 - (index - 0.5) * REF.WrapContentActors.UIWrapContent.itemSize, REF.AnchorScrollViewActors.UIWidget.width - #m_actorList * REF.WrapContentActors.UIWrapContent.itemSize + 50, 0)
    this:DelayInvokeInFrames(1, function()
      REF.ScrollViewActors.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(movement, 0, 0))
    end)
  end
end

function UpdateActorSlot(slotRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_actorList and realIndex < #m_actorList then
    local actor = m_actorList[realIndex + 1]
    slotRef["$$BindActor"](actor)
    slotRef["$$SetHighlighted"](actor.uid == this:GetData("Actor/SelectedUid"))
    local inWhichGroup
    if m_displayOption == SU.DisplayOption.group then
      inWhichGroup = GU.GetActorInWhichGroups(actor.uid)
    end
    slotRef["$$ShowCustom"]({
      showEquips = m_displayOption == SU.DisplayOption.equip,
      showName = m_displayOption == SU.DisplayOption.name,
      showArm = m_displayOption == SU.DisplayOption.arm,
      showCultivationTotal = m_displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = m_displayNumbers == SU.DisplayNumbers.Speed,
      showStar = m_displayNumbers == SU.DisplayNumbers.Star,
      showGroup = inWhichGroup
    })
    slotRef["$$SetClickCallback"](function()
      this:SetData("Actor/SelectedUid", actor.uid)
      WU.RecycleWindow(this)
    end)
  end
end
