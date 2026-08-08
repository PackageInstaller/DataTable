local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local SU = require("Common/SortUtil")
local NU = require("Common/NotepadUtil")
local m_kActorDataArray, m_kActorDataArrayNow, m_kActorCollectedArray, m_collectedCount, m_scrollViewInitX
local m_shareCount = 16
local m_advancedFilters

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnInitActorWikiItem
  })
end

function InitWindow()
  this:Bind("SortFinished", OnSortFinished)
  this:DelayInvokeEndOfFrame(function()
    this:BroadcastGameEvent("ApplySortAlternative", 0, false)
  end)
end

function OnSortFinished(data)
  if data ~= nil and REF["$SortMate"] == data.sortMate then
    m_kActorDataArray = data.list
    m_advancedFilters = fif(data.advancedFilters == nil, m_advancedFilters, data.advancedFilters)
    REF.SortFullScreenFilters["$FilterContext"](m_advancedFilters)
    m_kActorDataArrayNow = SU.ApplyFilters(data.list, m_advancedFilters)
    SetWindowData(m_kActorDataArrayNow)
    SetCount()
  end
end

function SetWindowData(allActors)
  if allActors == nil then
    return
  end
  m_kActorDataArray = allActors
  m_kActorCollectedArray = _ENV["!"]({})
  m_collectedCount = 0
  m_kActorCollectedArray = this:GetData("CollectionsActor/ActorsCollected")
  m_collectedCount = #m_kActorCollectedArray
  m_kActorDataArrayNow = _ENV["!"]({})
  m_kActorDataArrayNow = table.copy(m_kActorDataArrayNow, m_kActorDataArray)
  InitCombinedData()
  this:SetData("Share/CollectionsActorEnough", m_collectedCount and m_collectedCount >= m_shareCount)
end

function SetCount()
  InitCombinedData()
end

function UninitWindow()
  this:SetData("Share/CollectionsActorEnough", nil)
  DB:SetData("Share/SelectedActors", nil)
end

function InitCombinedData()
  if #m_kActorDataArrayNow <= 0 then
    REF.NodeEmpty.gameObject:SetActive(true)
    REF.NodeScrollView.gameObject:SetActive(false)
  else
    REF.NodeEmpty.gameObject:SetActive(false)
    REF.NodeScrollView.gameObject:SetActive(true)
  end
  local countStr = tostring(#m_kActorDataArrayNow)
  local firstletter = string.sub(countStr, 1, 1)
  local otherLetter = string.sub(countStr, 2, string.len(countStr))
  REF.LabelAllCountFirst.UILabel.text = firstletter or ""
  REF.LabelAllCountOthers.UILabel.text = otherLetter or ""
  local m_collectedCountStr = tostring(m_collectedCount)
  local firstletterCollected = string.sub(m_collectedCountStr, 1, 1)
  local otherLetterCollected = string.sub(m_collectedCountStr, 2, string.len(m_collectedCountStr))
  REF.LabelNowCountFirst.UILabel.text = firstletterCollected
  REF.LabelNowCountOthers.UILabel.text = otherLetterCollected
  SetTextMiddle(REF.LabelNowCountFirst, m_collectedCountStr)
  LU.Set(REF.WrapContent, #m_kActorDataArrayNow)
  this:DelayInvokeInFrames(5, function()
    m_scrollViewInitX = REF.ScrollView.transform.localPosition.x
  end)
  REF.WrapContent.UIPlayTween:Play(true)
end

function SetTextMiddle(gb, text)
  local factor = 15
  local posX = 60 - factor * string.len(text)
  local pos = gb.transform.localPosition
  gb.transform.localPosition = CS.UnityEngine.Vector3(posX, pos.y, pos.z)
end

function OnInitActorWikiItem(goRef, wrapIndex, realIndex)
  if m_kActorDataArrayNow ~= nil and realIndex ~= nil and realIndex < #m_kActorDataArrayNow then
    local dataCombined = m_kActorDataArrayNow[realIndex + 1]
    goRef["$$SetData"](dataCombined)
    goRef["@index"] = realIndex + 1
    goRef["$$SetSelected"](false)
    goRef["$$SetClickCallback"](function(go)
      WU.RecordButtonClick(100136602)
      WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
        _ENV["$"](w)["$$SetViewFrom"](1)
        _ENV["$"](w)["$$SetSortedActorList"](m_kActorDataArrayNow)
        _ENV["$"](w)["$$SetActor"](dataCombined, false)
      end)
    end)
  end
end

function SetShareInfo(window)
  local nowX = REF.ScrollView.transform.localPosition.x
  local itemWidth = REF.WrapContent.UIWrapContent.itemSize
  local index = math.floor((m_scrollViewInitX - nowX + itemWidth / 2) / itemWidth) + 1
  index = fif(0 < index, index, 1)
  local currentActor
  for i = index, #m_kActorDataArrayNow do
    if m_kActorDataArrayNow[i].unlock then
      currentActor = m_kActorDataArrayNow[i]
      break
    end
  end
  local currentIndex
  for i = 1, #m_kActorCollectedArray do
    local actor = m_kActorCollectedArray[i]
    actor.quality = actor.quality or 0
    if actor.config == nil then
      local actorConfig = PB.get("ActorConfig", actor.id)
      actor.config = actorConfig
    end
    if currentActor and currentActor.id == actor.id then
      currentIndex = i
    end
  end
  if currentIndex then
    if currentIndex > #m_kActorCollectedArray - m_shareCount + 1 then
      currentIndex = #m_kActorCollectedArray - m_shareCount + 1
    end
  else
    currentIndex = 1
  end
  local data = {
    actorList = m_kActorCollectedArray,
    currentIndex = currentIndex,
    count = m_shareCount,
    total = #m_kActorDataArray,
    have = #m_kActorCollectedArray
  }
  this:SetData("Share/CollectionsActor", data)
  this:SetData("ShareConfig", {
    shareName = "CollectionsActor",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
end

function Goto(actorId)
  local _, dataCombined = table.find(m_kActorDataArrayNow, function(k, v)
    return v.id == actorId
  end)
  if dataCombined then
    WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
      _ENV["$"](w)["$$SetViewFrom"](1)
      _ENV["$"](w)["$$SetSortedActorList"](m_kActorDataArrayNow)
      _ENV["$"](w)["$$SetActor"](dataCombined, false)
    end)
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001366, on)
end
