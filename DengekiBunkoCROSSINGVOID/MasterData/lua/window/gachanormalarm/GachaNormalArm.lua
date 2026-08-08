local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local DU = require("Common/DungeonUtil")
local m_gachaId = 10
local m_gachaDetail, m_gachaInfo, m_activityId, m_srcBGMusic
local m_inited = false
local m_selectedActivityId
local m_activityList = {}
local m_costBackUp

function InitWindow()
  ResetWindow()
  this:SetData("gacha/10/SelectedActivityId", 1)
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), OnGachaInfoChanged)
  this:RegisterGameEvent("StartArmGachaEffect", OnStartArmGachaEffect)
  this:RegisterGameEvent("StopArmGachaEffect", OnStopArmGachaEffect)
  REF.GachaActivitySelection["$SetToggleCallback"](function(activityInfo)
    if activityInfo then
      m_activityId = activityInfo.activityId
      if m_activityId == 0 or m_activityId == nil then
        REF.NodeEffectBack.gameObject:SetActive(true)
        REF.NodeBGBack.gameObject:SetActive(false)
      else
        local info = PB.get("GachaArmActivity", m_activityId)
        if info then
          REF.TextureActivityBG.UITexture.mainTexturePath = info.bgPath
        else
          error("GachaArmActivity.xlsx has no this activity " .. m_activityId)
        end
        REF.NodeEffectBack.gameObject:SetActive(false)
        REF.NodeBGBack.gameObject:SetActive(true)
      end
    end
  end)
  m_costBackUp = nil
  RefreshInsertCoin(false)
  this:RegisterGameEvent("GachaWeaponCostBackUp", function()
    m_costBackUp = nil
    ResetWindow()
    REF.NodeInsertCoin.gameObject:SetActive(true)
    RefreshInsertCoin(false)
  end)
end

function ResetWindow()
  REF.effectFront.gameObject:SetActive(false)
  REF.GachaActivitySelection.gameObject:SetActive(false)
  REF.ButtonArmsCollections.gameObject:SetActive(false)
  REF.NodeResourceSelect.gameObject:SetActive(false)
  REF.NodeLabels.gameObject:SetActive(false)
  REF.NodeInsertCoin.gameObject:SetActive(false)
  REF.NodeEffectBack.gameObject:SetActive(true)
  REF.NodeBGBack.gameObject:SetActive(false)
  REF.GachaActivitySelection["$ResetToggle"]()
  REF.GachaActivitySelection["$SetToggle"](1)
end

function RefreshInsertCoin(data)
  if data ~= nil then
    if data == true then
      REF.NodeInsertCoin.Animator:Play("GachaNormalArm_open", -1, 0)
    else
      REF.NodeInsertCoin.Animator:Play("GachaNormalArm_close", -1, 0)
    end
    REF.GachaActivitySelection.gameObject:SetActive(data)
    REF.ButtonArmsCollections.gameObject:SetActive(data)
    REF.NodeResourceSelect.gameObject:SetActive(not data)
    if data == true then
      REF.NodeLabels.gameObject:SetActive(false)
    else
      this:DelayInvokeInSeconds(0.5, function()
        REF.NodeLabels.gameObject:SetActive(true)
      end)
    end
    RefreshWidgetGachaInsertCoin()
  end
end

function UninitWindow()
  CS.SoundManager.Instance:PlayMusic(m_srcBGMusic)
end

function SetupWindow()
  m_srcBGMusic = CS.SoundManager.Instance:GetCurrentMusic()
  WU.BindButtonEvent(REF.ButtonArmsCollections, function()
    WU.AcquireWindowAsync("CollectionsEquipment", function(window)
      _ENV["$"](window)["$$SetArmTab"]()
    end)
  end)
  WU.BindButtonEvent(REF.ButtonBookMark, function()
    m_costBackUp = false
    REF.NodeInsertCoin.gameObject:SetActive(true)
    RefreshInsertCoin(true)
  end)
  WU.BindButtonEvent(REF.ButtonCrystal, function()
    m_costBackUp = true
    REF.NodeInsertCoin.gameObject:SetActive(true)
    RefreshInsertCoin(true)
  end)
end

function OnGachaInfoChanged(gachaInfo)
  if gachaInfo then
    m_gachaInfo = gachaInfo
    local _, gacha = table.find(gachaInfo, function(k, v)
      return v.id == 10
    end)
    m_gachaDetail = gacha
    local featuredActivities = _ENV["!"](this:GetData("ActivityList")):where(function(k, v)
      if v.type == PB.enum.ActivityType.GachaWeaponFeatured then
        return ACU.IsOpenForDoing(v)
      end
    end) or {}
    local gachaType = PB.get("GachaType", m_gachaDetail.id)
    REF.LabelStockBookMark.ResourcePrinter:SetResource(gachaType.cost.type, gachaType.cost.id)
    REF.LabelStockCrystal.ResourcePrinter:SetResource(gachaType.costBackUp.type, gachaType.costBackUp.id)
    local activities = m_gachaDetail.activityInfo
    local tempList = {}
    for _, a in pairs(featuredActivities) do
      local _, temp = table.find(activities, function(k, v)
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
    local activities = m_gachaDetail.activityInfo
    local _, temp = table.find(activities, function(k, v)
      return v.activityId == 0
    end)
    if temp == nil then
      table.insert(activities, 1, {
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
    m_gachaDetail.activityInfo = activities
    m_activityList = activities
    m_selectedActivityId = this:GetData("gacha/10/SelectedActivityId") or 1
    REF.GachaActivitySelection["$SetView"](activities, m_gachaDetail)
  end
end

function RefreshWidgetGachaInsertCoin()
  REF.WidgetGachaInsertCoin["$SetActivity"](m_activityList[m_selectedActivityId])
  REF.WidgetGachaInsertCoin["$SetGachaId"](m_gachaId, m_costBackUp)
  REF.WidgetGachaInsertCoin["$SetGachaClickCallback"](function(times)
    if not DU.IsWaitingForJob(function()
      DoGacha(times)
    end) then
      DoGacha(times)
    end
  end)
end

function DoGacha(times)
  if m_gachaDetail then
    if m_activityId == nil or m_activityId == 0 then
      S:Get("Gacha").DoGacha(m_gachaDetail, {
        activityId = m_activityId,
        times = times,
        showContinue = false,
        gachaEffect = true,
        costBackUp = m_costBackUp
      })
    else
      S:Get("Gacha").DoGacha(m_gachaDetail, {
        activityId = m_activityId,
        times = times,
        showContinue = false,
        costBackUp = m_costBackUp
      })
    end
  end
end

function OnStartArmGachaEffect()
  REF.effectFront.gameObject:SetActive(true)
  REF.effectFront.EffectGenerator:Reset()
  REF.effectFront.EffectGenerator:Play()
  CS.SoundManager.Instance:PlaySound("Sound/system/arm_gacha")
  this:DelayInvokeInSeconds(0.8, function()
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
    S:Get("Gacha").TryToShowResult()
  end)
end

function OnStopArmGachaEffect()
  REF.effectFront.gameObject:SetActive(false)
end
