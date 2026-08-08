local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local m_toggleCallback, m_buttonCallback, m_info, m_gachaDetail, m_curIndex
local m_delayUpdate = false
local m_gachaCustomActorID

function Start()
  WU.TraverseChildren(REF.Grid, function(g, i)
    local ref = _ENV["$"](g)
    CS.EventDelegate.Add(ref.root.UIToggle.onChange, function()
      local index = i + 1
      if m_curIndex ~= index and m_gachaDetail then
        m_curIndex = index
        this:SetData("gacha/" .. m_gachaDetail.id .. "/SelectedActivityId", index)
        if CS.UIToggle.current.value and m_toggleCallback ~= nil then
          m_toggleCallback(m_info[index])
        end
        this:BroadcastGameEvent("ResetGachaTimes")
        SetCurInfo()
      end
    end)
    WU.BindButtonEvent(ref.root, function()
      if m_buttonCallback ~= nil then
        m_buttonCallback(m_info[i + 1], i + 1)
      end
    end)
  end)
  WU.BindPressEvent(REF.TextureHead, OnTipsClick)
  this:RegisterGameEvent("OnGachaResponse", function()
    m_delayUpdate = true
  end)
end

function OnTipsClick(go, pressed)
  if pressed then
    if m_gachaDetail.id == 10 then
      WU.ShowHoverTips3(WU.GetString("WindowGacha_WillGetTipsArm"))
    else
      WU.ShowHoverTips3(WU.GetString("WindowGacha_WillGetTips"))
    end
  else
    WU.HideHoverTips()
  end
end

function SetToggleCallback(callback)
  m_toggleCallback = callback
end

function SetButtonCallback(callback)
  m_buttonCallback = callback
end

function SetView(info, gachaDetail)
  m_gachaDetail = gachaDetail
  m_info = info
  local selectedActivityId = this:GetData("gacha/" .. m_gachaDetail.id .. "/SelectedActivityId") or 1
  if this:GetData("CurrentTutorial") == 32 then
    selectedActivityId = #m_info
  end
  REF.Grid[selectedActivityId - 1]["$UIToggle"].value = true
  if #m_info == 1 then
    WU.TraverseChildren(REF.Grid, function(g, i)
      g:SetActive(false)
    end)
  else
    WU.TraverseChildren(REF.Grid, function(g, i)
      SetItem(_ENV["$"](g), m_info[i + 1], gachaDetail)
    end)
  end
  if m_delayUpdate then
    m_delayUpdate = false
    this:DelayInvokeInSeconds(1.0, function()
      SetCurInfo()
    end)
  else
    SetCurInfo()
  end
  REF.Grid.UIGrid:Reposition()
end

function SetCurInfo()
  this:SetData("GachaMaxDropCnt", nil)
  this:SetData("GachaDropActorId", nil)
  local selectedActivityId = this:GetData("gacha/" .. m_gachaDetail.id .. "/SelectedActivityId") or 1
  if this:GetData("CurrentTutorial") == 32 then
    selectedActivityId = #m_info
  end
  local info = m_info[selectedActivityId]
  if info == nil or info.activityId == nil or info.activityId == 0 then
    REF.Progress.gameObject:SetActive(false)
    return
  end
  REF.Progress.gameObject:SetActive(false)
  local gachaId = m_gachaDetail.id
  local willDropCnt = 0
  local actorId
  if gachaId == 1 or gachaId == 2 or gachaId == 10 then
    if gachaId == 1 then
      if info.type == PB.enum.ActivityType.GachaCustom then
        actorId = this:GetData("gachaCustomActorID")
        willDropCnt = 91 - info.curDropActivityActor
        this:SetData("GachaMaxDropCnt", 91)
        this:SetData("GachaDropActorId", actorId)
        local actorConfig = PB.get("ActorConfig", actorId)
        SetActor(actorConfig, willDropCnt, info)
      else
        local data = PB.get("ActivityGachaNormalUp", info.activityId)
        actorId = data.dropResInfo[1].dropActorId
        willDropCnt = data.dropActorCount - info.curDropActivityActor
        this:SetData("GachaMaxDropCnt", data.dropActorCount)
        this:SetData("GachaDropActorId", actorId)
        local actorConfig = PB.get("ActorConfig", actorId)
        SetActor(actorConfig, willDropCnt, info)
      end
    elseif gachaId == 2 then
      local data = PB.get("ActivityGachaLimited", info.activityId)
      local drop = data.dropResInfo[1].dropRes
      if drop.type ~= PB.enum.ResourceType.ResActor then
        error("activityId " .. tostring(info.activityId) .. " drop type is not Acotr in ActivityGachaLimited.xlsx")
      else
        actorId = drop.id
        willDropCnt = data.dropActorCount - info.curDropActivityActor
        this:SetData("GachaMaxDropCnt", data.dropActorCount)
        this:SetData("GachaDropActorId", actorId)
      end
      local actorConfig = PB.get("ActorConfig", actorId)
      SetActor(actorConfig, willDropCnt, info)
    elseif gachaId == 10 and info.activityId > 0 then
      local armConfig = PB.get("GachaArmActivity", info.activityId)
      this:SetData("GachaMaxDropCnt", 80)
      willDropCnt = 80 - info.curDropActivityActor
      SetArm(armConfig, willDropCnt, info)
    end
  end
end

function SetArm(armConfig, willDropCnt, info)
  if armConfig then
    REF.Progress.gameObject:SetActive(true)
    REF.TextureHead.UITexture.mainTexturePath = "Texture/ActorGachaHead/impression_head_" .. armConfig.armId
    REF.HasNotGet.gameObject:SetActive(false)
    REF.HasGet.gameObject:SetActive(false)
    if 0 < willDropCnt then
      REF.HasNotGet.gameObject:SetActive(true)
      if willDropCnt == 1 then
        REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowGacha_WillGetNextArm") .. WU.GetString("UniqueWeaponName_" .. armConfig.armId)
      else
        REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowGacha_WillGetArm", willDropCnt) .. WU.GetString("UniqueWeaponName_" .. armConfig.armId)
      end
    else
      REF.LabelGet.UIHtmlLabel.text = WU.GetString("WindowGacha_HasGet", info.getActivityActorCount)
      REF.HasGet.gameObject:SetActive(true)
    end
  else
    error("GachaArmActivity", "Cannot find Arm by activityId: " .. info.activityId)
    REF.Progress.gameObject:SetActive(false)
  end
end

function SetActor(actorConfig, willDropCnt, info)
  if actorConfig then
    REF.Progress.gameObject:SetActive(true)
    if actorConfig == nil then
      error("ActorConfig", "Cannot find ActorConfig by id: " .. tostring(actorId))
    else
      REF.TextureHead.UITexture.mainTexturePath = "Texture/ActorGachaHead/gacha_head_" .. actorConfig.animRes
    end
    REF.HasNotGet.gameObject:SetActive(false)
    REF.HasGet.gameObject:SetActive(false)
    if 0 < willDropCnt then
      REF.HasNotGet.gameObject:SetActive(true)
      if willDropCnt == 1 then
        REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowGacha_WillGetNext") .. WU.GetString("RoleName_" .. actorConfig.role)
      else
        REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowGacha_WillGet", willDropCnt) .. WU.GetString("RoleName_" .. actorConfig.role)
      end
    else
      REF.LabelGet.UIHtmlLabel.text = WU.GetString("WindowGacha_HasGet", info.getActivityActorCount)
      REF.HasGet.gameObject:SetActive(true)
    end
  else
    REF.Progress.gameObject:SetActive(false)
  end
end

function SetItem(ref, info, gachaDetail)
  ref.root.gameObject:SetActive(info ~= nil)
  if info == nil then
    return
  end
  local gachaId = gachaDetail.id
  local actorId
  ref.GameGacha.gameObject:SetActive(false)
  ref.GameActor.gameObject:SetActive(false)
  ref.CustomGacha.gameObject:SetActive(false)
  ref.GameArm.gameObject:SetActive(false)
  ref.GameNormalArm.gameObject:SetActive(false)
  if info.activityId > 0 then
    if gachaId == 10 then
      ref.GameArm.gameObject:SetActive(true)
      local armInfo = PB.get("GachaArmActivity", info.activityId)
      if armInfo then
        ref.SpriteArm.UITexture.mainTexturePath = "Texture/ActorGachaHead/impression_head_" .. armInfo.armId
      else
        error("GachaArmActivity has no this activityId " .. info.activityId)
      end
    else
      if gachaId == 1 then
        if info.type == PB.enum.ActivityType.GachaCustom then
          ref.CustomGacha.gameObject:SetActive(true)
          ref.root.transform.name = "GachaCustomActivity"
          _ENV["$"](ref.CustomGacha).LabelGachaName.UILabel.text = WU.GetString("Window_GachaCustomPush")
        else
          ref.GameActor.gameObject:SetActive(true)
          local data = PB.get("ActivityGachaNormalUp", info.activityId)
          if data then
            actorId = data.dropResInfo[1].dropActorId
          else
            warning("Debug", "ActivityGachaNormalUp no activityId:" .. info.activityId)
          end
        end
      elseif gachaId == 2 then
        ref.GameActor.gameObject:SetActive(true)
        local data = PB.get("ActivityGachaLimited", info.activityId)
        if data then
          local drop = data.dropResInfo[1].dropRes
          if drop.type ~= PB.enum.ResourceType.ResActor then
            error("activityId " .. tostring(info.activityId) .. " drop type is not Acotr in ActivityGachaLimited.xlsx")
          else
            actorId = drop.id
          end
        else
          warning("Debug", "ActivityGachaLimited no activityId:" .. info.activityId)
        end
      end
      local actorConfig = PB.get("ActorConfig", actorId)
      if actorConfig ~= nil then
        ref.SpriteActor.UITexture.mainTexturePath = "Texture/ActorGachaHead/gacha_head_" .. actorConfig.animRes
        ref.LabelActorName.UILabel.text = WU.GetString("RoleName_" .. actorConfig.role)
      end
    end
  elseif gachaId == 10 then
    ref.GameNormalArm.gameObject:SetActive(true)
  else
    ref.GameGacha.gameObject:SetActive(true)
    ref.LabelGachaName.UILabel.text = WU.GetString("WindowGacha_NormalGacha")
  end
end

function ResetToggle()
  WU.TraverseChildren(REF.Grid, function(g, i)
    local ref = _ENV["$"](g)
    ref.root.UIToggle.optionCanBeNone = true
    ref.root.UIToggle.value = false
    ref.root.UIToggle.optionCanBeNone = false
  end)
end

function SetToggle(index)
  REF.Grid[index - 1].root.UIToggle.value = true
end
