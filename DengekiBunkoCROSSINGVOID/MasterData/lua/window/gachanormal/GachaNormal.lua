local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local DU = require("Common/DungeonUtil")
local m_gachaId = 1
local m_gachaDetail, m_gachaCustomDetail, m_gachaInfo, m_activityId
local GM_activityId = 14001
local lastClickIndex = 1
local m_srcBGMusic
local m_inited = false
local m_boradActorId

function Focus(on)
  WU.RecordWindowFocus(100113, on)
end

function InitWindow()
  WU.SetActive(REF.BoardPanel, false)
  WU.ToggleRendering(REF.GachaActivitySelection, false)
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), OnGachaInfoChanged)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  this:Bind("gachaCustomActorID", OnGachaCustomActorIDChanged)
  REF.GM_AdChangeButton.gameObject:SetActive(false)
  REF.WidgetGachaInsertCoin["$SetGachaId"](m_gachaId)
  REF.WidgetGachaInsertCoin["$SetGachaClickCallback"](function(times)
    if not DU.IsWaitingForJob(function()
      DoGacha(times)
    end) then
      DoGacha(times)
    end
  end)
  REF.GachaActivitySelection["$SetToggleCallback"](function(activityInfo)
    SetStatus(activityInfo)
    if activityInfo.type == PB.enum.ActivityType.GachaCustom then
      m_gachaId = 7
      m_gachaCustomDetail.nextGetPurpleCount = activityInfo.nextGetPurpleCount
      REF.WidgetGachaInsertCoin["$SetGachaId"](7)
      if m_gachaCustomDetail.customPoolStatus >= PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
        local gachaCustomActorID = this:GetData("gachaCustomActorID")
        if gachaCustomActorID then
          PlayBoradActor(gachaCustomActorID)
          WU.SetActive(REF.BoardPanel, true)
        end
      end
      WU.SetActive(REF.GachaCustomEffect, true)
    else
      m_gachaId = 1
      REF.WidgetGachaInsertCoin["$SetGachaId"](1)
      WU.SetActive(REF.BoardPanel, false)
      WU.SetActive(REF.GachaCustomEffect, false)
    end
  end)
  REF.GachaActivitySelection["$SetButtonCallback"](GachaActivitySelectionButtonCallBack)
end

function GachaActivitySelectionButtonCallBack(activityInfo, index)
  if activityInfo.type == PB.enum.ActivityType.GachaCustom and m_gachaCustomDetail.customPoolStatus < PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
    ShowGachaCustomRuleMsgBox()
  end
end

function UninitWindow()
  CS.SoundManager.Instance:PlayMusic(m_srcBGMusic)
end

function SetupWindow()
  m_srcBGMusic = CS.SoundManager.Instance:GetCurrentMusic()
  WU.BindButtonEvent(REF.ButtonActorCollections, function()
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
      NU.GetCollectionsActor(function()
        WU.AcquireWindowAsync("CollectionsActor")
      end)
    end
  end)
  local gachaCustomActivities = _ENV["!"](this:GetData("ActivityList")):where(function(k, v)
    if v.type == PB.enum.ActivityType.GachaCustom then
      return ACU.IsOpenForDoing(v)
    end
  end)
  if table.count(gachaCustomActivities) ~= 0 then
    PlayBillboardAnimation()
  end
end

function ReqCustomGachainfo()
  local customActivities = _ENV["!"](this:GetData("ActivityList")):where(function(k, v)
    if v.type == PB.enum.ActivityType.GachaCustom then
      return ACU.IsOpenForDoing(v)
    end
  end) or {}
  local _, customGacha = table.find(m_gachaInfo, function(k, v)
    return v.id == 7
  end)
  m_gachaCustomDetail = customGacha
  for _, a in pairs(customActivities) do
    local _, temp = table.find(m_gachaCustomDetail.activityInfo, function(k, v)
      return v.activityId == a.activityId
    end)
    if temp == nil then
      temp = {
        type = a.type,
        activityId = a.activityId,
        curDropActivityActor = 0,
        preDropActivityActor = 0,
        getActivityActorCount = 0,
        nextGetPurpleCount = PB.get("GachaType", m_gachaDetail.id).actorDropCount
      }
    end
    temp.type = a.type
    table.insert(m_gachaCustomDetail.activityInfo, temp)
    local temp2 = {
      type = temp.type,
      activityId = temp.activityId,
      curDropActivityActor = temp.curDropActivityActor,
      preDropActivityActor = temp.preDropActivityActor,
      getActivityActorCount = temp.getActivityActorCount,
      nextGetPurpleCount = temp.nextGetPurpleCount
    }
    table.insert(m_gachaDetail.activityInfo, temp2)
    local gachaAd = PB.get("GachaAd", a.activityId)
    if not m_inited and gachaAd then
      REF.GachaCustomEffect.EffectGenerator.m_EffectName = gachaAd.frontEffectName
      REF.GachaCustomEffect.EffectGenerator:Reset()
    end
  end
  if not m_inited and m_gachaCustomDetail.customPoolStatus >= PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
    this:GameRequest("fci/gacha-custom/choose-pool/"):Get(function(res)
      this:SetData("gachaCustomActorID", res.activityRes.chooseResId)
      m_inited = true
      SetActivity()
      WU.ToggleRendering(REF.GachaActivitySelection, true)
    end)
  else
    WU.ToggleRendering(REF.GachaActivitySelection, true)
    SetActivity()
  end
end

function OnGachaCustomActorIDChanged(actorId)
  if actorId then
    WU.SetActive(REF.BoardPanel, m_gachaId == 7)
    PlayBoradActor(actorId)
    if m_inited then
      REF.GachaActivitySelection["$SetCurInfo"]()
    else
      WU.SetActive(REF.BoardPanel, false)
    end
  else
    WU.SetActive(REF.BoardPanel, false)
  end
end

function OnGachaInfoChanged(gachaInfo)
  if gachaInfo then
    m_gachaInfo = gachaInfo
    local _, gacha = table.find(gachaInfo, function(k, v)
      return v.id == 1
    end)
    m_gachaDetail = gacha
    OnActivityChanged()
  end
end

function OnActivityChanged()
  local activities = _ENV["!"](this:GetData("ActivityList")):where(function(k, v)
    if v.type == PB.enum.ActivityType.GachaProbabilityUp then
      return ACU.IsOpenForDoing(v)
    end
  end)
  activities = activities or {}
  local activityInfo = _ENV["!"](m_gachaDetail.activityInfo)
  local tempList = {}
  for _, a in pairs(activities) do
    local _, temp = activityInfo:find(function(k, v)
      return v.activityId == a.activityId
    end)
    if temp == nil then
      table.insert(tempList, {
        type = a.type,
        activityId = a.activityId,
        curDropActivityActor = 0,
        preDropActivityActor = 0,
        getActivityActorCount = 0,
        nextGetPurpleCount = PB.get("GachaType", m_gachaDetail.id).actorDropCount
      })
    else
      table.insert(tempList, temp)
    end
  end
  m_gachaDetail.activityInfo = tempList
  activityInfo = _ENV["!"](m_gachaDetail.activityInfo)
  local _, temp = activityInfo:find(function(k, v)
    return v.activityId == 0
  end)
  if temp == nil then
    table.insert(activityInfo, 1, {
      activityId = 0,
      curDropActivityActor = 0,
      preDropActivityActor = 0,
      getActivityActorCount = 0,
      nextGetPurpleCount = m_gachaDetail.nextGetPurpleCount
    })
  else
    temp.nextGetPurpleCount = m_gachaDetail.nextGetPurpleCount
    temp.nextWillFreeTime = m_gachaDetail.nextFreeGachaTime
  end
  m_gachaDetail.activityInfo = tempList
  ReqCustomGachainfo()
end

function OnActivityStatusChanged(category, activityId, status, type, activity)
  if type == PB.enum.ActivityType.GachaProbabilityUp then
    local activityInfo = _ENV["!"](m_gachaDetail.activityInfo)
    local opened = ACU.IsOpenForDoing(activity)
    local i, a = activityInfo:find(function(k, v)
      return v.activityId == activityId
    end)
    if opened then
      if a == nil then
        table.insert(activityInfo, {
          activityId = activityId,
          curDropActivityActor = 0,
          preDropActivityActor = 0,
          nextGetPurpleCount = PB.get("GachaType", m_gachaDetail.id).actorDropCount
        })
      end
    elseif i ~= nil then
      table.remove(activityInfo, i)
    end
    this:SetData("gacha/1/SelectedActivityId", 1)
    SetActivity()
  end
  if type == PB.enum.ActivityType.GachaCustom then
    local activityInfo = _ENV["!"](m_gachaCustomDetail.activityInfo)
    local opened = ACU.IsOpenForDoing(activity)
    local i, a = activityInfo:find(function(k, v)
      return v.activityId == activityId
    end)
    if opened then
      if a == nil then
        local temp = {
          type = a.type,
          activityId = a.activityId,
          curDropActivityActor = 0,
          preDropActivityActor = 0,
          getActivityActorCount = 0,
          nextGetPurpleCount = PB.get("GachaType", m_gachaDetail.id).actorDropCount
        }
        table.insert(activityInfo, temp)
        local temp2 = {
          type = temp.type,
          activityId = temp.activityId,
          curDropActivityActor = temp.curDropActivityActor,
          preDropActivityActor = temp.preDropActivityActor,
          getActivityActorCount = temp.getActivityActorCount,
          nextGetPurpleCount = temp.nextGetPurpleCount
        }
        table.insert(m_gachaDetail.activityInfo, temp2)
      end
    elseif i ~= nil then
      table.remove(activityInfo, i)
      local i2, a2 = table.find(m_gachaDetail.activityInfo, function(k, v)
        return v.activityId == activityId
      end)
      if i2 ~= nil then
        table.remove(m_gachaDetail.activityInfo, i2)
      end
    end
    this:SetData("gacha/1/SelectedActivityId", 1)
    SetActivity()
  end
end

function SetActivity()
  local activities = m_gachaDetail.activityInfo
  table.sort(activities, function(a, b)
    if a.activityId == 0 then
      return true
    end
    if b.activityId == 0 then
      return false
    end
    return a.activityId < b.activityId
  end)
  local selectedActivityId = this:GetData("gacha/1/SelectedActivityId") or 1
  local jumpActivityId = this:GetData("GachaJumpId")
  if jumpActivityId and jumpActivityId ~= 0 then
    local index, activity = table.find(activities, function(k, v)
      return v.activityId == jumpActivityId
    end)
    this:SetData("GachaJumpId", nil)
    if index then
      selectedActivityId = index
      this:SetData("gacha/1/SelectedActivityId", index)
    end
    if activity and activity.type == PB.enum.ActivityType.GachaCustom then
      m_gachaId = 7
      REF.WidgetGachaInsertCoin["$SetGachaId"](7)
      WU.SetActive(REF.GachaCustomEffect, true)
      if m_gachaCustomDetail.customPoolStatus < PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
        ShowGachaCustomRuleMsgBox()
      end
      if m_gachaCustomDetail.customPoolStatus >= PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
        local gachaCustomActorID = this:GetData("gachaCustomActorID")
        if gachaCustomActorID then
          PlayBoradActor(gachaCustomActorID)
          WU.SetActive(REF.BoardPanel, true)
        end
      end
    end
  elseif this:GetData("EnterFromButtonGachaNormal") then
    this:SetData("EnterFromButtonGachaNormal", false)
    m_gachaId = 1
    WU.SetActive(REF.GachaCustomEffect, false)
    WU.SetActive(REF.BoardPanel, false)
    selectedActivityId = 1
    REF.WidgetGachaInsertCoin["$SetGachaId"](1)
    this:SetData("gacha/1/SelectedActivityId", 1)
  end
  WU.SetActive(REF.BoardPanel, m_gachaId == 7)
  if this:GetData("CurrentTutorial") == 5 then
    selectedActivityId = ACU.GetNormalGachaTabId(activities)
  end
  SetStatus(activities[selectedActivityId])
  REF.GachaActivitySelection["$SetView"](activities, m_gachaDetail)
end

function SetStatus(activity)
  if activity then
    REF.WidgetGachaInsertCoin["$SetActivity"](activity)
    REF.NodeNormal.gameObject:SetActive(activity.activityId == 0)
    if activity.activityId ~= 0 then
      if m_activityId ~= activity.activityId then
        m_activityId = activity.activityId
        WU.RemoveAllChild(REF.NodeEffect)
        local ad = PB.get("GachaAd", activity.activityId)
        if ad == nil then
          error("Gacha", "no bg effect prefab for gacha activityId " .. activity.activityId .. " in GachaAd.xlsx")
        else
          GM_activityId = activity.activityId
          CreateEffect(ad)
          if ad.musicID and ad.musicID ~= "" then
            CS.SoundManager.Instance:PlayMusic(ad.musicID)
          else
            CS.SoundManager.Instance:PlayMusic(m_srcBGMusic)
          end
        end
      end
    else
      m_activityId = nil
      WU.RemoveAllChild(REF.NodeEffect)
    end
  end
end

function DoGacha(times)
  if m_gachaId == 1 then
    if m_gachaDetail then
      S:Get("Gacha").DoGacha(m_gachaDetail, {
        activityId = m_activityId,
        times = times,
        cinematic = "ATM",
        showContinue = false
      })
    end
  elseif m_gachaId == 7 and m_gachaCustomDetail then
    S:Get("Gacha").DoGacha(m_gachaCustomDetail, {
      activityId = m_activityId,
      times = times,
      cinematic = "ATM",
      showContinue = false,
      callBackWhenResponse = function()
        local i, aCustom = table.find(m_gachaCustomDetail.activityInfo, function(k, v)
          return v.activityId == m_activityId
        end)
        local i, aNormal = table.find(m_gachaDetail.activityInfo, function(k, v)
          return v.activityId == m_activityId
        end)
        if aCustom and aNormal then
          aNormal.curDropActivityActor = aCustom.curDropActivityActor
          aNormal.preDropActivityActor = aCustom.preDropActivityActor
          aNormal.nextGetPurpleCount = aCustom.nextGetPurpleCount
          aNormal.getActivityActorCount = aCustom.getActivityActorCount
          m_gachaCustomDetail.nextGetPurpleCount = aCustom.nextGetPurpleCount
          m_gachaCustomDetail.customPoolStatus = PB.enum.GachaCustomPoolStatus.GachaCustomPool_Locked
          this:SetData("fci/gachainfo", this:GetData("fci/gachainfo"))
        end
      end
    })
  end
end

function OnClickGM_AdChange()
  WU.RemoveAllChild(REF.NodeEffect)
  GM_activityId = GM_activityId + 1
  local ad = PB.get("GachaAd", GM_activityId)
  if ad == nil then
    GM_activityId = 14001
    ad = PB.get("GachaAd", GM_activityId)
  end
  CreateEffect(ad)
end

function CreateEffect(ad)
  local obj = WU.InstantiateWindowPrefab(REF.NodeEffect, ad.displayName)
  if _ENV["$"](obj)["$Animator"] ~= nil then
    _ENV["$"](obj)["$Animator"]:Play("Open", -1, 0)
  end
  WU.HandleGameObjectAttached(obj)
  SetActorButtons()
end

function SetActorButtons()
  local ref = reRef(REF.NodeEffect)
  if ref then
    WU.TraverseChildren(ref.RoleButtons, function(go)
      local name = go.name
      if string.sub(name, 1, 4) == "Role" then
        local id = U.ToInt(string.sub(name, string.len("Role") + 2, string.len(name)))
        WU.BindButtonEvent(go, function()
          if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
            NU.GetCollectionsActor(function(actors)
              local actor = {}
              if m_boradActorId ~= nil then
                id = m_boradActorId
              end
              for k, v in pairs(actors) do
                if v.id == id then
                  actor = v
                  break
                end
              end
              WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
                _ENV["$"](w)["$$SetActor"](actor)
              end)
            end)
          end
        end)
      end
    end)
  end
end

function BackWindow()
  WU.SetActive(REF.Billboard, false)
end

function PlayBillboardAnimation()
  WU.TraverseChildren(REF.Billboard, function(g, i)
    WU.SetActive(g, true)
  end)
  this:DelayInvokeInSeconds(0.5, function()
    if REF.GachaCustomActivity == nil then
      return
    end
    REF.Step1.EffectGenerator:Play(function()
      this:DelayInvokeInSeconds(1, function()
        WU.SetActive(REF.Step1, false)
        REF.Step2.EffectGenerator:Play()
        this:DelayInvokeInSeconds(0.05, function()
          WU.SetActive(REF.Step2, false)
          local fly = REF.Fly1
          local tween = fly.TweenPosition
          tween.from = fly.transform.localPosition
          fly.transform:SetParent(REF.GachaCustomActivity.transform)
          tween.to = tween.from - fly.transform.localPosition
          REF.Fly2.TweenPosition.to = tween.to
          REF.Fly3.TweenPosition.to = tween.to
          fly.transform:SetParent(REF.Billboard.transform)
          fly.transform.localScale = CS.UnityEngine.Vector3.one
          tween:ResetToBeginning()
          tween:PlayForward()
          fly.EffectGenerator:Play()
          REF.Fly2.EffectGenerator:Play()
          REF.Fly3.EffectGenerator:Play()
          REF.Fly2.TweenPosition:ResetToBeginning()
          REF.Fly3.TweenPosition:ResetToBeginning()
          REF.Fly2.TweenPosition:PlayForward()
          REF.Fly3.TweenPosition:PlayForward()
          this:DelayInvokeInSeconds(0, function()
            WU.SetActive(fly, false)
            local step3 = REF.Step3
            step3.transform:SetParent(REF.GachaCustomActivity.transform)
            local pos = step3.transform.localPosition
            step3.transform:SetParent(REF.Billboard.transform)
            step3.transform.localPosition = -pos
            step3.EffectGenerator:Play(function()
              WU.SetActive(step3, false)
            end)
          end)
        end)
      end)
    end)
  end)
end

function PlayBoradActor(actorId)
  m_boradActorId = actorId
  local actor = PB.get("ActorConfig", actorId)
  local roleId = actor.role
  local signboard = PB.all("Signboard")
  local index, value = table.find(signboard, function(k, v)
    return v.roleId == roleId
  end)
  WU.SetActive(REF.WidgetBoardActor, true)
  WU.SetActive(REF.TextureBoardActor, false)
  this:DelayInvokeInFrames(1, function()
    if REF.WidgetBoardActor.gameObject.activeInHierarchy then
      local hasEmote = true
      if value and value.type == PB.enum.SignboardType.Emote then
        REF.WidgetBoardActor["$PlayByActorID"](value.BoardOfEmote, "Gacha")
      end
      if value == nil or value.type == PB.enum.SignboardType.Erect then
        REF.TextureBoardActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actor.animRes
        WU.SetActive(REF.TextureBoardActor, true)
        WU.SetActive(REF.WidgetBoardActor, false)
      end
    end
  end)
end

function ShowGachaCustomRuleMsgBox()
  WU.AcquireWindowAsync("MessageBox", function(ui)
    _ENV["$"](ui)["$$ShowMessage"](WU.GetString("Window_GachaCustomHelp"), function(msg)
      if msg == "OK" then
        WU.AcquireWindowAsync("GachaSelectFateActor", function(w)
          _ENV["$"](w)["$$SetBackWindowCallback"](function()
            if m_gachaCustomDetail.customPoolStatus < PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
              _ENV["$"](REF.GachaActivitySelection).Grid[0].root.UIToggle.value = true
            end
          end)
        end)
      else
        _ENV["$"](REF.GachaActivitySelection).Grid[0].root.UIToggle.value = true
      end
    end, true, false, false, nil, nil, WU.GetString("Window_GachaCustomSelectActor"))
  end)
end
