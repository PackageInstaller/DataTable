local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local LU = require("Common/ListUtil")
local SE = require("Common/SkillEffect")
local Mode = {ActorInherit = 1, ActorDecrepitTransport = 2}
local m_actorRawList, m_actorInfo, m_actorInfoTalentScore, m_compActorInfo, m_selectedUid, m_lastSelectedWidget, m_useRightTalents, m_showHint, m_firstSelect, m_activityInfo, m_mode
local m_repeatedContext = {}
local m_shouldRecycle, m_talentEffectDelayHandle

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirm)
  LU.Bind(REF.InheritWrapContent, {
    updateRow = UpdateSlot,
    delta = 0.01
  })
end

function InitWindow()
  this:Bind("ActorTalentInherit/Mode", SwitchMode)
  this:Bind("Actor/SelectedUid", function(uid)
    if uid ~= nil then
      m_shouldRecycle = false
      m_firstSelect = true
      REF.NodeEmpty.gameObject:SetActive(false)
      m_showHint = false
      m_useRightTalents = false
      m_selectedUid = nil
      m_compActorInfo = nil
      REF.TalentInheritData[0].NSelected.gameObject:SetActive(true)
      REF.TalentInheritData[0].Selected.gameObject:SetActive(false)
      m_actorInfo = this:GetData("fci/actor/" .. uid)
      if m_actorInfo == nil then
        m_shouldRecycle = true
        return
      end
      REF.TalentInheritData[0]["$$SetActorInfo"](m_actorInfo, true, m_mode == Mode.ActorDecrepitTransport)
      REF.TalentInheritData[0].TitleLabel.UILabel.text = WU.GetString("Window_TalentInheritCurrent")
      WU.ToggleRendering(REF.TalentInheritData[1]["$gameObject"], false)
      WU.ToggleRendering(REF.TalentInheritData[2]["$gameObject"], false)
      WU.ToggleRendering(REF.ShowWhenSelection, false)
      WU.ToggleRendering(REF.D.gameObject, true)
    end
  end)
  this:Bind("SortFinished", OnSortFinished)
  this:RegisterGameEvent("TalentInherit/Switch", function(isLeft)
    m_useRightTalents = not isLeft
    SetInheritData(true)
  end)
  SortFocusBase.InitWindowActor()
  WU.PreloadWindow("ActorTalentResult")
end

function SaveContext()
  table.insert(m_repeatedContext, {mode = m_mode})
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    SwitchMode(context.mode)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnSortFinished(data)
  if data ~= nil and data.sortMate == REF["$SortMate"] and m_actorInfo then
    local filteredResult = {}
    if m_mode == Mode.ActorInherit then
      for i = 1, #data.list do
        local actor = data.list[i]
        if actor.id == m_actorInfo.id and actor.uid ~= m_actorInfo.uid then
          table.insert(filteredResult, actor)
        end
      end
    else
      for _, v in pairs(m_activityInfo.targetId) do
        for i = 1, #data.list do
          local target = data.list[i]
          if target.id == v then
            table.insert(filteredResult, target)
          end
        end
      end
    end
    m_actorRawList = filteredResult
    local col = #m_actorRawList
    LU.Set(REF.InheritWrapContent, col)
    REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3((col + 2) * REF.InheritWrapContent.UIWrapContent.itemSize, 0)
    REF.BottomBarSpace.gameObject:SetActive(0 < col)
    REF.NodeEmpty.gameObject:SetActive(col == 0)
  end
end

function UpdateSlot(ref, wrapIdx, realIdx)
  if m_actorRawList ~= nil and realIdx ~= nil and realIdx < #m_actorRawList then
    local index = realIdx + 1
    local actor = m_actorRawList[index]
    ref["@actor"] = actor
    ref["$$SetAlpha"](fif(actor.isLock, 0.4, 1))
    ref["$$BindActor"](actor)
    ref["$$SetClickCallback"](fif(actor.isLock, nil, OnSlotClicked))
    ref["$$ShowCustom"]({lock = true})
    if m_selectedUid and actor.uid == m_selectedUid then
      m_lastSelectedWidget = ref
      ref["$$SetHighlighted"](true)
    else
      ref["$$SetHighlighted"](false)
    end
  end
end

function OnSlotClicked(widget)
  local widgetRef = _ENV["$"](widget)
  if widgetRef["@actor"] == nil then
    return
  end
  if m_selectedUid and m_lastSelectedWidget ~= nil then
    m_lastSelectedWidget["$$SetHighlighted"](false)
  end
  m_lastSelectedWidget = widgetRef
  m_compActorInfo = widgetRef["@actor"]
  m_selectedUid = m_compActorInfo.uid
  widgetRef["$$SetHighlighted"](true)
  local ref = REF.TalentInheritData[1]
  REF.TalentInheritData[0]["$$SetActorInfo"](m_actorInfo, true, m_mode == Mode.ActorDecrepitTransport)
  ref["$$SetActorInfo"](m_compActorInfo, false, m_mode == Mode.ActorDecrepitTransport)
  ref.TitleLabel.UILabel.text = WU.GetString("Window_TalentInheritTarget")
  WU.ToggleRendering(ref["$gameObject"], true)
  WU.ToggleRendering(REF.D.gameObject, false)
  m_actorInfoTalentScore = AU.ActorTalentScore(m_actorInfo)
  m_useRightTalents = m_actorInfoTalentScore < AU.ActorTalentScore(m_compActorInfo)
  SetInheritData(false)
  WU.ToggleRendering(REF.ShowWhenSelection, true)
  WU.TriggerUnforcedTutorial(1110)
end

function SetInheritData(onlyTalentsChange)
  if m_compActorInfo ~= nil and m_actorInfo ~= nil then
    REF.TalentInheritData[0].NSelected.gameObject:SetActive(m_useRightTalents)
    REF.TalentInheritData[1].NSelected.gameObject:SetActive(not m_useRightTalents)
    REF.TalentInheritData[0].Selected.gameObject:SetActive(not m_useRightTalents)
    REF.TalentInheritData[1].Selected.gameObject:SetActive(m_useRightTalents)
    local resultActor, decomposeActor, effectShow = MixActor(m_actorInfo, m_compActorInfo, m_useRightTalents)
    if resultActor == nil or decomposeActor == nil then
      return
    end
    local result = AU.GetDecomposeResult(decomposeActor)
    if m_mode == Mode.ActorDecrepitTransport then
      WU.ToggleRendering(REF.TalentInheritData[1].TitleLabel, false)
      WU.ToggleRendering(REF.TalentInheritData[2].TitleLabel, false)
      WU.ToggleRendering(REF.TalentInheritData[1].LabelDecrepitValue, true)
      WU.ToggleRendering(REF.TalentInheritData[1].LabelDecrepitName, true)
      WU.ToggleRendering(REF.TalentInheritData[2].LabelDecrepitValue, true)
      WU.ToggleRendering(REF.TalentInheritData[2].LabelDecrepitName, true)
    else
      WU.ToggleRendering(REF.TalentInheritData[1].TitleLabel, true)
      WU.ToggleRendering(REF.TalentInheritData[2].TitleLabel, true)
      WU.ToggleRendering(REF.TalentInheritData[1].LabelDecrepitValue, false)
      WU.ToggleRendering(REF.TalentInheritData[1].LabelDecrepitName, false)
      WU.ToggleRendering(REF.TalentInheritData[2].LabelDecrepitValue, false)
      WU.ToggleRendering(REF.TalentInheritData[2].LabelDecrepitName, false)
    end
    REF.BottomLabel.UIHtmlLabel.text = WU.GetString("Window_ActorTalentInheritPreview", result.chips[1].id, result.chips[1].count)
    REF.TalentInheritData[2]["$$SetMixedActor"](resultActor, m_mode == Mode.ActorDecrepitTransport)
    REF.TalentInheritData[2].TitleLabel.UILabel.text = WU.GetString("Window_TalentInheritPromotion")
    REF.TalentInheritData[2].NSelected.gameObject:SetActive(true)
    REF.TalentInheritData[2].Selected.gameObject:SetActive(false)
    WU.ToggleRendering(REF.TalentInheritData[2]["$gameObject"], true)
    m_showHint = true
    PlaySelectActorAnimation(onlyTalentsChange)
  end
end

function AdjustSpectialTalent(resultActor)
  local talentsOfTheActor = m_actorInfo.talentInfo
  local talentsOfTheCompActor = m_compActorInfo.talentInfo
  local talentsOfResultActor = resultActor.talentInfo
  local actorHasSpectialTalent = false
  local resultActorHasSpectialTalent = false
  local actorSpectialTalent, resultActorSpecialTalent
  for _, v in pairs(talentsOfResultActor) do
    local talent = PB.get("ActorTalent", v.talentId)
    if talent.spectial == 1 then
      resultActorSpecialTalent = v
      resultActorHasSpectialTalent = true
    end
  end
  for _, v in pairs(talentsOfTheActor) do
    local talent = PB.get("ActorTalent", v.talentId)
    if talent.spectial == 1 then
      actorHasSpectialTalent = true
      actorSpectialTalent = v
    end
  end
  local allTalents = PB.all("ActorTalent")
  local RTalentId
  for _, v in pairs(allTalents) do
    if v.actorID == m_compActorInfo.id and v.spectial == 1 then
      RTalentId = v.id
    end
  end
  if resultActorHasSpectialTalent then
    local allTalents = PB.all("ActorTalent")
    for _, v in pairs(allTalents) do
      if v.id == resultActorSpecialTalent.talentId and v.actorID == m_actorInfo.id then
        resultActorSpecialTalent.talentId = RTalentId
      end
    end
  end
end

function GetActroSpecialTalent(actor)
  local all = PB.all("ActorTalent")
  for _, v in pairs(all) do
    if v.actorID == actor.id and v.spectial == 1 then
      return v
    end
  end
end

function MixActor(actorL, actorR, useRightTalent)
  local resultActor = {}
  local decomposeActor = {}
  local effectShow = {
    level = false,
    skill = false,
    star = false,
    equip = 0,
    talents = {}
  }
  if m_compActorInfo ~= nil and m_actorInfo ~= nil then
    local equipScoreL = AU.GetActorEquipTotalScore(actorL)
    local equipScoreR = AU.GetActorEquipTotalScore(actorR)
    if equipScoreL >= equipScoreR then
      table.copy(actorL, resultActor)
    else
      table.copy(actorR, resultActor)
      effectShow.equip = table.count(actorR.bodyEquips)
    end
    table.copy(actorR, decomposeActor)
    resultActor.level = fif(actorL.level > actorR.level, actorL.level, actorR.level)
    resultActor.cultivationTotal = fif(actorL.cultivationTotal > actorR.cultivationTotal, actorL.cultivationTotal, actorR.cultivationTotal)
    decomposeActor.level = fif(actorL.level < actorR.level, actorL.level, actorR.level)
    if resultActor.level ~= actorL.level then
      effectShow.level = true
    end
    resultActor.quality = fif(actorL.quality > actorR.quality, actorL.quality, actorR.quality)
    decomposeActor.quality = fif(actorL.quality < actorR.quality, actorL.quality, actorR.quality)
    local needAddTalent = false
    if actorL.quality > actorR.quality then
      needAddTalent = useRightTalent
    elseif actorL.quality == actorR.quality then
      needAddTalent = false
    else
      needAddTalent = not useRightTalent
    end
    local leftTalentsAfterDecompose = {}
    local mainTalent = {}
    table.copy(fif(useRightTalent, actorR.talentInfo, actorL.talentInfo), mainTalent, true)
    local addTalent = {}
    table.copy(fif(useRightTalent, actorL.talentInfo, actorR.talentInfo), addTalent, true)
    local isMainHasSpecialTalent = false
    for i = 1, #mainTalent do
      local theMainTalent = mainTalent[i]
      local talent = PB.get("ActorTalent", theMainTalent.talentId)
      if talent.spectial == 1 then
        isMainHasSpecialTalent = true
        break
      end
    end
    if needAddTalent then
      local mainCount = #mainTalent
      local addCount = #addTalent
      if mainCount < addCount then
        local needAddCount = addCount - mainCount
        local addedCount = 0
        for i = 1, addCount do
          local theAddTalent = addTalent[i]
          local vTalentConfig = PB.get("ActorTalent", theAddTalent.talentId)
          if isMainHasSpecialTalent then
            if vTalentConfig.spectial == 1 then
              goto lbl_235
            end
            local found = false
            for j = 1, mainCount do
              local theMainTalent = mainTalent[j]
              local vTalentConfig2 = PB.get("ActorTalent", theMainTalent.talentId)
              if vTalentConfig.groupType == vTalentConfig2.groupType then
                found = true
                break
              end
            end
            if found then
              goto lbl_235
            end
            addedCount = addedCount + 1
            table.insert(mainTalent, theAddTalent)
            if addedCount == needAddCount then
              break
            end
          else
            local found = false
            for j = 1, mainCount do
              local theMainTalent = mainTalent[j]
              local vTalentConfig2 = PB.get("ActorTalent", theMainTalent.talentId)
              if vTalentConfig.groupType == vTalentConfig2.groupType then
                found = true
                break
              end
            end
            if not found then
              addedCount = addedCount + 1
              table.insert(mainTalent, theAddTalent)
              if addedCount == needAddCount then
                break
              end
            end
          end
          ::lbl_235::
        end
      end
    end
    if useRightTalent then
      for i = 1, #actorR.talentInfo do
        table.insert(effectShow.talents, i)
      end
    elseif needAddTalent then
      for i = #actorL.talentInfo + 1, #actorR.talentInfo do
        table.insert(effectShow.talents, i)
      end
    end
    resultActor.talentInfo = mainTalent
    local scoreOfLeft = AU.ActorTalentScore(actorL)
    local scoreOfRight = AU.ActorTalentScore(actorR)
    decomposeActor.talentInfo = fif(scoreOfLeft < scoreOfRight, actorL.talentInfo, actorR.talentInfo)
    if m_mode == Mode.ActorDecrepitTransport then
      resultActor.id = actorR.id
      AdjustSpectialTalent(resultActor)
    end
    local skillCount = GetSkillCount(actorL, actorR)
    local skillCountL = SE.GetSkillCount(actorL)
    local skillCountR = SE.GetSkillCount(actorR)
    resultActor.showSkillCount = skillCount
    decomposeActor.showSkillCount = fif(skillCountL < skillCountR, skillCountL, skillCountR)
    if resultActor.showSkillCount ~= skillCountL then
      effectShow.skill = true
    end
    resultActor.showStar = fif(actorL.star > actorR.star, actorL.star, actorR.star)
    decomposeActor.showStar = fif(actorL.star < actorR.star, actorL.star, actorR.star)
    if resultActor.showStar ~= actorL.star then
      effectShow.star = true
    end
  end
  return resultActor, decomposeActor, effectShow
end

function GetSkillCount(actorL, actorR)
  local curLevelSum = 0
  local skillsL = SE.GetActorSkills(actorL.id)
  local skillsR = SE.GetActorSkills(actorR.id)
  for i = 1, #skillsL do
    local skillL = skillsL[i][1]
    local skillR = skillsR[i][1]
    if skillL and skillR and skillL.displayIndex == skillR.displayIndex then
      local LvL = SE.GetSkillLevel(actorL, skillL.skillId)
      local LvR = SE.GetSkillLevel(actorR, skillR.skillId)
      curLevelSum = curLevelSum + fif(LvL > LvR, LvL, LvR)
    end
  end
  return curLevelSum
end

function TakeOffActorsFromEquip(data)
  local equips = {}
  for k, v in pairs(data) do
    local equip = this:GetData("fci/equip/" .. k)
    equip.actorUid = v
    table.insert(equips, equip)
  end
  DBH.UpdateEquips(equips)
end

function OnConfirm()
  if m_mode == Mode.ActorInherit then
    OnConfirmOfInherit()
  else
    OnConfirmOfDecrepiTransport()
  end
end

function OnConfirmOfDecrepiTransport()
  if m_compActorInfo == nil or m_actorInfo == nil then
    return
  end
  
  local function doCompose()
    local postData = {
      targetActorUid = m_compActorInfo.uid,
      actorUid = m_actorInfo.uid,
      useNewTalent = m_useRightTalents
    }
    this:GameRequest("fci/DiffActorInherit/"):Post(postData, function(result)
      OnInheritSuccess(result)
      local returnedChanges = _ENV["!"](result.resChange):where(function(_, change)
        return change.baseRes and change.baseRes.countDelta > 0
      end)
      local returnedRes = returnedChanges:select(function(change)
        return change.baseRes
      end):toarray()
      local theResultActor = DB:GetData("fci/actor/" .. m_compActorInfo.uid)
      WU.AcquireWindowAsync("ActorTalentDecrepitResult", function(window)
        _ENV["$"](window)["$$SetResult"](theResultActor, returnedRes)
      end)
      WU.RecycleWindow(this)
      WU.RecycleWindow("DecrepitTransportation")
    end)
  end
  
  WU.ShowMessageYesNo(WU.GetString("Confirm2Replace"), function(result)
    if result == "YES" then
      doCompose()
    end
  end)
end

function OnConfirmOfInherit()
  local function doCompose()
    local postData = {
      targetActorUid = m_compActorInfo.uid,
      
      useNewTalent = m_useRightTalents
    }
    if m_actorInfo ~= nil then
      this:GameRequest("fci/actor/" .. m_actorInfo.uid .. "/inheriting/"):Post(postData, function(result)
        OnInheritSuccess(result)
        for _, change in pairs(result.resChange) do
          if change.actor and change.actor.countDelta == 0 then
            this:SetData("Actor/SelectedUid", change.actor.uid)
          end
          if change.actor and change.actor.countDelta < 0 then
            RemoveActorFromRollerBind("Actor/RollerTraverse", change.actor.uid)
          end
        end
        WU.RecycleWindow(this)
        local returnedChanges = _ENV["!"](result.resChange):where(function(_, change)
          return change.baseRes and change.baseRes.countDelta > 0
        end)
        local returnedRes = returnedChanges:select(function(change)
          return change.baseRes
        end):toarray()
        WU.AcquireWindowAsync("ActorTalentResult", function(window)
          _ENV["$"](window)["$$SetResult"](m_actorInfo, nil, returnedRes)
        end)
      end)
    end
  end
  
  if m_compActorInfo == nil then
    WU.ShowHintText(WU.GetString("Window_ReplaceActorNotChoose"))
    return
  end
  if m_showHint then
    WU.ShowMessageYesNo(WU.GetString("Confirm2Replace"), function(result)
      if result == "YES" then
        doCompose()
      end
    end)
  else
    doCompose()
  end
end

function RemoveActorFromRollerBind(bindString, uid)
  local actorTraverse = this:GetData(bindString)
  if actorTraverse ~= nil then
    local idx = table.find(actorTraverse, function(k, v)
      return v.uid == uid
    end)
    if idx ~= nil then
      table.remove(actorTraverse, idx)
      this:SetData(bindString, actorTraverse)
    end
  end
end

function ShowDetailEffect(effectShow, onlyTalentsChange)
  if effectShow ~= nil then
    for i = 1, #effectShow.talents do
      REF.EffectTalent[effectShow.talents[i] - 1].root.EffectGenerator:Play()
    end
    if onlyTalentsChange then
      return
    end
    if effectShow.level then
      REF.EffectLevel.EffectGenerator:Play()
    end
    if effectShow.skill then
      REF.EffectSkill.EffectGenerator:Play()
    end
    if effectShow.star then
      REF.EffectStar.EffectGenerator:Play()
    end
    for i = 0, effectShow.equip - 1 do
      REF.EffectEquip[i].root.EffectGenerator:Play()
    end
  end
end

function PrepareForAimation(onlyTalent)
  local ref = REF.TalentInheritData[2]
  if not onlyTalent then
    if m_firstSelect then
      ref.SpriteQualityOld.gameObject:SetActive(false)
      ref.TextureActorOld.gameObject:SetActive(false)
      m_firstSelect = false
    else
      ref.SpriteQualityOld.gameObject:SetActive(true)
      ref.TextureActorOld.gameObject:SetActive(true)
    end
    WU.TraverseChildren(ref.EquipList, function(go)
      local equipRef = _ENV["$"](go)
      local active = equipRef["$gameObject"].activeSelf == true
      equipRef.SpriteIconBGbai.gameObject:SetActive(active)
    end)
    ref.WidgetTalentRow4.gameObject:SetActive(false)
  else
    ref.WidgetTalentRow4.gameObject:SetActive(true)
    ref.RayRamp.gameObject:SetActive(true)
    WU.TraverseChildren(ref.WidgetTalentRow4, function(go, index)
      if index < 4 then
        local talentRef = _ENV["$"](go)
        local active = talentRef["$gameObject"].activeSelf == true
        talentRef.TalentGlow.gameObject:SetActive(active)
        talentRef.TalentGlowLine01.gameObject:SetActive(active)
        talentRef.TalentGlowLine02.gameObject:SetActive(active)
        talentRef.TalentGlowLine03.gameObject:SetActive(active)
      end
    end)
  end
end

function PlaySelectActorAnimation(onlyTalent)
  if onlyTalent then
    PrepareForAimation(true)
    REF.TalentInheritData[2].WidgetTalentRow4.Animator:Play("Change", -1, 0)
  else
    PrepareForAimation(false)
    REF.TalentInheritData[2]["$Animator"]:Play("Change", -1, 0)
    if m_talentEffectDelayHandle then
      this:StopCoroutine(m_talentEffectDelayHandle)
      m_talentEffectDelayHandle = nil
    end
    m_talentEffectDelayHandle = this:DelayInvokeInSeconds(1, function()
      PrepareForAimation(true)
      REF.TalentInheritData[2].WidgetTalentRow4.Animator:Play("Change", -1, 0)
      m_talentEffectDelayHandle = nil
    end)
  end
end

function OnInheritSuccess(result)
  DBH.ResChange(result.resChange)
  GU.GroupTagCheck({
    m_compActorInfo.uid,
    m_actorInfo.uid
  })
  TakeOffActorsFromEquip(result.equipChange)
end

function Focus(on)
  SortFocusBase.FocusActor(on)
  if on and m_shouldRecycle then
    m_shouldRecycle = false
    WU.ShowHintText(WU.GetString("ForceRecycleWindow_ActorIsDecomposed"))
    WU.RecycleWindow(this)
  end
end

function SwitchMode(mode)
  if mode == nil then
    return
  end
  m_mode = mode
  local isInherit = mode == Mode.ActorInherit
  local path = fif(isInherit, "ActorTalentInherit", "ActorTalentDiffInherit")
  WU.SetWindowTitle("ActorTalentInherit", path)
  local labelConfirm = fif(isInherit, WU.GetString("TalentInherit_Inherit"), WU.GetString("TalentInherit_Transport"))
  REF.LabelConfirm.UILabel.text = labelConfirm
  if not isInherit then
    m_activityInfo = this:GetData("ActorTalentInherit/ActivityInfo")
  end
end
