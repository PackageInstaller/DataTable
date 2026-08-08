local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local m_dragDelta = CS.UnityEngine.Vector2.zero
local m_pageIndex
local m_switchInterval = 5
local m_timeElapsed = 0
local m_adList = {}

function Start()
  REF.AdGrid.UICenterOnChild.onCenter = OnCenterCallback
end

function OnEnable()
  this:Bind("ActivityList", OnActivityChanged)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
end

function OnDisable()
  this:Unbind("ActivityList", OnActivityChanged)
  this:UnregisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
end

function Update()
  if 0 < #m_adList then
    m_timeElapsed = m_timeElapsed + CS.GameTime.deltaTime
    if m_timeElapsed >= m_switchInterval then
      NavigateRelative(1)
    end
  end
end

function OnActivityChanged(activityList)
  if activityList == nil then
    return
  end
  m_adList = _ENV["!"]({})
  for _, activity in pairs(activityList) do
    if activity.type == PB.enum.ActivityType.GachaAd then
      CheckAd(activity.activityId, ACU.GetStatus(activity))
    end
  end
  InitAds()
end

function OnActivityStatusChanged(category, activityId, status, type)
  if type == PB.enum.ActivityType.GachaAd then
    CheckAd(activityId, status)
    InitAds()
  end
end

function OnCenterCallback(go)
  m_pageIndex = go.transform:GetSiblingIndex()
  REF.PageIndicatorGrid[m_pageIndex]["$UIToggle"].value = true
end

function CheckAd(activityId, status)
  if status == PB.enum.ActivityStatus.Started then
    local ad = PB.get("GachaAd", activityId)
    if ad == nil then
      error("Gacha", "no ad image config for gacha activityId " .. activityId .. " in GachaAd.xlsx")
    else
      table.insert(m_adList, ad)
    end
  else
    local index, _ = m_adList:find(function(k, v)
      return v.activityId == activityId
    end)
    if index ~= nil then
      table.remove(m_adList, index)
    end
  end
end

function InitAds()
  if WU.IsPreCommit() then
    m_adList = _ENV["!"]({})
  end
  table.sort(m_adList, function(a, b)
    return a.order < b.order
  end)
  local pageCount = #m_adList
  REF.SpriteDefaultAdImage.gameObject:SetActive(pageCount == 0)
  REF.AdRoot.gameObject:SetActive(pageCount ~= 0)
  if pageCount == 0 then
    m_pageIndex = nil
  else
    local ad = REF.AdGrid[0].root.gameObject
    for i = 1, pageCount - #REF.AdGrid do
      local g = CS.NGUITools.AddChild(REF.AdGrid.gameObject, ad)
      g.name = ad.name
    end
    for i = 0, pageCount - 1 do
      local ref = REF.AdGrid[i].root
      ref.gameObject:SetActive(i < pageCount)
      ref.UITexture.mainTexturePath = m_adList[i + 1].displayName
      WU.ClearButtonEvent(ref)
      WU.BindButtonEvent(ref, OnAdClick)
    end
    REF.AdGrid.UIGrid:Reposition()
  end
  ReserveIndicator(pageCount)
  if not m_pageIndex then
    NavigateAbsolute(0)
  end
end

function NavigateRelative(deltaIndex)
  if 0 < #m_adList then
    NavigateAbsolute((m_pageIndex + deltaIndex) % #m_adList)
  end
end

function NavigateAbsolute(targetIndex)
  if #m_adList == 0 then
    return
  end
  if targetIndex ~= m_pageIndex and 0 <= targetIndex and targetIndex < #m_adList then
    REF.AdGrid.UICenterOnChild:CenterOn(REF.AdGrid[targetIndex].root.transform)
    m_pageIndex = targetIndex
    REF.PageIndicatorGrid[m_pageIndex]["$UIToggle"].value = true
    m_timeElapsed = 0
  end
end

function ReserveIndicator(pageCount)
  REF.PageIndicatorGrid.gameObject:SetActive(1 < pageCount)
  local dotPrefab = REF.PageIndicatorGrid[0]["$gameObject"]
  while pageCount > #REF.PageIndicatorGrid do
    local dot = CS.UnityEngine.GameObject.Instantiate(dotPrefab, REF.PageIndicatorGrid.transform)
    dot.name = dotPrefab.name
  end
  for i = 0, #REF.PageIndicatorGrid - 1 do
    local ref = REF.PageIndicatorGrid[i].root
    ref.gameObject:SetActive(i < pageCount)
    WU.ClearButtonEvent(ref)
    WU.BindButtonEvent(ref, function(go)
      NavigateAbsolute(go.transform:GetSiblingIndex())
    end)
  end
  REF.PageIndicatorGrid.UIGrid:Reposition()
end

function OnAdClick(go)
  if WU.IsPreCommit() then
    return
  end
  local ad = m_adList[go.transform:GetSiblingIndex() + 1]
  if ad == nil then
    return
  end
  if ad.window == 1 then
    JumpInNormalgacha(ad)
  elseif ad.window == 2 then
    this:SetData("GachaJumpId", ad.jumpActivityId)
    WU.AcquireWindowAsync("GachaPeriodic")
  elseif ad.window == 3 then
    WU.AcquireWindowAsync("GachaChips")
  elseif ad.window == 4 then
    WU.ShowHintText(WU.GetString("Window_GachaToBeOpened"))
  elseif ad.window == 5 then
    WU.AcquireWindowAsync("GachaScoreShop")
  end
end

function JumpInNormalgacha(ad)
  local _, activity = table.find(this:GetData("ActivityList"), function(k, v)
    return v.activityId == ad.jumpActivityId
  end)
  if activity and activity.type == PB.enum.ActivityType.GachaCustom then
    DB:GameRequest("fci/gachainfo/"):Get(function(gachaInfo)
      if gachaInfo then
        local _, customGachaInfo = table.find(gachaInfo, function(k, v)
          return v.id == 7
        end)
        if customGachaInfo and customGachaInfo.customPoolStatus < PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
          WU.AcquireWindowAsync("MessageBox", function(ui)
            _ENV["$"](ui)["$$ShowMessage"](WU.GetString("Window_GachaCustomHelp"), function(msg)
              if msg == "OK" then
                WU.AcquireWindowAsync("GachaSelectFateActor", function(w)
                  _ENV["$"](w)["$$SetChooseCallback"](function(actorId)
                    if actorId then
                      this:SetData("GachaJumpId", ad.jumpActivityId)
                      WU.AcquireWindowAsync("GachaNormal")
                    end
                  end)
                end)
              end
            end, true, false, false, nil, nil, WU.GetString("Window_GachaCustomSelectActor"))
          end)
        else
          this:SetData("GachaJumpId", ad.jumpActivityId)
          WU.AcquireWindowAsync("GachaNormal")
        end
      end
    end)
  else
    this:SetData("GachaJumpId", ad.jumpActivityId)
    WU.AcquireWindowAsync("GachaNormal")
  end
end
