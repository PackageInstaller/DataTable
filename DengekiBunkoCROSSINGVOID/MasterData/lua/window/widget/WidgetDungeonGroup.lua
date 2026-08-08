local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local m_memberCenterPos = CS.UnityEngine.Vector3(0, -10, 0)
local m_favourIds
local m_skipActorAnim = false
local m_dontShowQuality
local m_customActorId = -3

function Awake()
  for i = 0, 2 do
    REF.HP[i].SpriteProgress.UISprite.spriteName = "tower_vs_bar_1"
  end
  REF.MonsterInfo.gameObject:SetActive(false)
  for i = 0, 2 do
    REF.DeadInfo[i]["$gameObject"]:SetActive(false)
  end
  REF.Exp.gameObject:SetActive(false)
  REF.HP.gameObject:SetActive(false)
  REF.NodeAdd.gameObject:SetActive(false)
end

function Start()
  WU.SetActive(REF.NPC, false)
  for index = 1, 6 do
    local barRef = _ENV["$"](_ENV["$"](REF.Exp)["Bar" .. index])
    local played = false
    CS.EventDelegate.Add(barRef.SpriteExpNew.TweenScale.onFinished, function()
      if played or m_skipActorAnim then
        return
      end
      local expInfo = barRef["@expInfo"]
      local actorRef = _ENV["$"](_ENV["$"](REF.Members)["WidgetIconActor" .. index])
      if expInfo.level ~= expInfo.levelNew then
        played = true
        actorRef.ActorLevel.UILabel.text = WU.GetString("Window_Level", expInfo.levelNew)
        actorRef.ActorLevel.UILabel.text = WU.GetString("Window_Level", expInfo.levelNew)
        actorRef.root.TweenScale:PlayForward()
        barRef.LevelupEffect.EffectGenerator:Play()
        this:DelayInvokeInSeconds(0.8, function()
          PlayFavourEffect(actorRef)
        end)
      else
        PlayFavourEffect(actorRef)
      end
    end)
  end
end

function SetView(group, centerAlign)
  REF.Members.transform.localPosition = fif(centerAlign, m_memberCenterPos, CS.UnityEngine.Vector3.zero)
  for index = 1, 6 do
    local member = group.members[index]
    if member then
      WU.SetActive(REF.NPC, true)
      WU.SetActive(REF["NPC" .. index], member.isNpc)
      local actor = member.actor
      if actor == nil then
        if member.isNpc then
          actor = PB.get("DungeonNPC", member.npcId)
          AU.RenameDungeonNPCFields(actor)
        elseif member.actorUid == nil or member.actorUid == 0 then
          actor = {id = m_customActorId}
        else
          actor = this:GetData("fci/actor/" .. member.actorUid)
        end
      end
      local refActor = _ENV["$"](REF.Members)["WidgetIconActor" .. index]
      refActor["$SetActorCustom"](actor)
      refActor["$ShowCustom"]({showLock = false})
      local actorConfig = PB.get("ActorConfig", actor.id)
      if actorConfig then
        _ENV["$"](refActor)["@role"] = actorConfig.role
      end
    end
  end
end

function SetFavourChangeIds(ids)
  m_favourIds = ids
end

function SetViewByActors(actors, centerAlign, isReversed)
  REF.Members.transform.localPosition = fif(centerAlign, m_memberCenterPos, CS.UnityEngine.Vector3.zero)
  for index = 1, 6 do
    local actorIndex = index
    if isReversed then
      actorIndex = 7 - index
    end
    local showArmAble = false
    local actor = actors[actorIndex]
    if actor and actor.id and actor.id ~= 0 then
      if m_dontShowQuality then
        local copyActor = {}
        table.copy(actor, copyActor, true)
        copyActor.talentInfo = {}
        actor = copyActor
      end
      _ENV["$"](REF.Members)["WidgetIconActor" .. index]["$SetActorCustom"](actor)
      if actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0 then
        showArmAble = true
      end
    else
      _ENV["$"](REF.Members)["WidgetIconActor" .. index]["$SetActorCustom"]({id = m_customActorId})
    end
    _ENV["$"](REF.Members)["WidgetIconActor" .. index]["$ShowCustom"]({showLock = false, showArm = showArmAble})
  end
end

function SetTips(titleIds, isReversed)
  REF.MonsterInfo.gameObject:SetActive(true)
  for index = 1, 6 do
    local trueIndex = index
    if isReversed then
      trueIndex = 7 - index
    end
    WU.ClearPressEvent(REF["ShowDesc" .. index])
    local flag = titleIds[trueIndex] and titleIds[trueIndex] ~= 0
    WU.ToggleRendering(REF["ShowDesc" .. index], flag)
    if flag then
      WU.BindPressEvent(REF["ShowDesc" .. index], function(go, pressed)
        if pressed then
        else
        end
      end)
    end
  end
end

function SetOldExp(expChange, group)
  REF.Members.transform.localPosition = CS.UnityEngine.Vector3.zero
  REF.Exp.gameObject:SetActive(true)
  for i = 1, 6 do
    local member = group.members[i]
    local index = member.index + 1
    local uid = member.actorUid
    local _, expInfo = table.find(expChange, function(k, v)
      return v.actorUid == uid
    end)
    local barRef = _ENV["$"](_ENV["$"](REF.Exp)["Bar" .. index])
    barRef.root.gameObject:SetActive(expInfo ~= nil)
    if expInfo ~= nil then
      do
        local actor = this:GetData("fci/actor/" .. uid)
        if actor == nil then
          local actors = this:GetData("fci/actor/")
          local _, actorRaw = table.find(actors, function(k, v)
            return v.uid == uid
          end)
          actorRaw.level = expInfo.levelNew
          this:SetData("fci/actor/", actors)
        else
          actor.curExp = expInfo.expNew
          actor.level = expInfo.levelNew
          DBH.UpdateActors(actor)
        end
        barRef["@expInfo"] = expInfo
        local levelNew = expInfo.levelNew
        local maxActorLevel = AU.GetActorMaxLevel()
        local nextLevelInfo = PB.get("ActorLevelup", expInfo.level + 1)
        barRef.ExpLabel.gameObject:SetActive(true)
        if levelNew ~= maxActorLevel then
          local addExp = expInfo.addExp
          if addExp and 0 < addExp then
            barRef.ExpLabel.UILabel.text = "+" .. tostring(addExp)
          else
            barRef.ExpLabel.gameObject:SetActive(false)
          end
          if nextLevelInfo == nil then
            barRef.SpriteProgress.UISprite.fillAmount = 1
          else
            barRef.SpriteProgress.UISprite.fillAmount = expInfo.exp / nextLevelInfo.exp
          end
        else
          barRef.ExpLabel.UILabel.text = "MAX"
        end
        barRef.SpriteMaxProgress.gameObject:SetActive(levelNew == maxActorLevel)
        barRef.SpriteProgress.gameObject:SetActive(levelNew ~= maxActorLevel)
        barRef.SpriteExpNew.gameObject:SetActive(levelNew ~= maxActorLevel)
        if nextLevelInfo and levelNew == expInfo.level and levelNew ~= maxActorLevel then
          barRef.SpriteExpNew.UISprite.fillAmount = expInfo.expNew / nextLevelInfo.exp
        else
          barRef.SpriteExpNew.UISprite.fillAmount = 1
        end
        _ENV["$"](_ENV["$"](REF.Members)["WidgetIconActor" .. index]).ActorLevel.UILabel.text = WU.GetString("Window_Level", expInfo.level)
      end
    end
  end
end

function SetLevelupExp(expChange, group, playTween)
  m_skipActorAnim = not playTween
  for index = 1, 6 do
    local uid = group.members[index].actorUid
    local _, expInfo = table.find(expChange, function(k, v)
      return v.actorUid == uid
    end)
    local barRef = _ENV["$"](_ENV["$"](REF.Exp)["Bar" .. index])
    barRef.root.gameObject:SetActive(expInfo ~= nil)
    if expInfo ~= nil then
      do
        local levelNew = expInfo.levelNew
        local maxActorLevel = AU.GetActorMaxLevel()
        local resActorLevelup = PB.get("ActorLevelup", levelNew + 1)
        if resActorLevelup == nil then
          if levelNew == maxActorLevel then
            barRef.ExpLabel.UILabel.text = "MAX"
          end
          return
        end
        barRef.ExpLabel.gameObject:SetActive(true)
        if levelNew ~= maxActorLevel then
          local addExp = expInfo.addExp
          if addExp and 0 < addExp then
            barRef.ExpLabel.UILabel.text = "+" .. tostring(addExp)
          else
            barRef.ExpLabel.gameObject:SetActive(false)
          end
        else
          barRef.ExpLabel.UILabel.text = "MAX"
        end
        barRef.SpriteMaxProgress.gameObject:SetActive(levelNew == maxActorLevel)
        barRef.SpriteExpNew.gameObject:SetActive(levelNew ~= maxActorLevel)
        barRef.SpriteExpNew.UISprite.fillAmount = expInfo.expNew / resActorLevelup.exp
        local oldExpFillAmount = 0
        if levelNew == expInfo.level then
          oldExpFillAmount = expInfo.exp / resActorLevelup.exp
        end
        barRef.SpriteProgress.UISprite.fillAmount = oldExpFillAmount
        barRef.SpriteProgress.gameObject:SetActive(levelNew == expInfo.level)
        if playTween and levelNew ~= expInfo.level then
          barRef.SpriteExpNew.TweenScale:ResetToBeginning()
          barRef.SpriteExpNew.TweenScale:PlayForward()
        elseif not playTween then
          local actorRef = _ENV["$"](_ENV["$"](REF.Members)["WidgetIconActor" .. index])
          actorRef.ActorLevel.UILabel.text = WU.GetString("Window_Level", expInfo.levelNew)
          PlayFavourEffect(actorRef)
        end
      end
    end
  end
end

function PlayFavourEffect(actorRef)
  if m_favourIds[actorRef["@role"]] ~= nil then
    actorRef.root["$PlayFavourEffect"]()
  end
end

function SetHp(group)
  REF.HP.gameObject:SetActive(true)
  for i = 1, 3 do
    local barRef = _ENV["$"](_ENV["$"](REF.HP)["Bar" .. i])
    local memberRef = _ENV["$"](_ENV["$"](REF.Members)["G0" .. i])
    if group.members[i] and group.members[i].actor then
      barRef["$gameObject"]:SetActive(true)
      local fill = GU.GetHpFillAmount(group.members, i)
      local dead = fill == 0
      barRef.SpriteProgress.UISprite.fillAmount = fill
      local tweens = memberRef["$transform"]:GetComponentsInChildren(typeof(CS.TweenAlpha))
      for i = 0, tweens.Length - 1 do
        tweens[i].to = fif(dead, 0.5, 1)
      end
      _ENV["$"](REF.DeadInfo)["SpriteDead" .. i].gameObject:SetActive(dead)
    else
      barRef["$gameObject"]:SetActive(false)
    end
  end
end

function SetHp2(monsterInfos, nowHpList)
  REF.HP.gameObject:SetActive(true)
  local count = 0
  local filledHp = 0
  local nowHp = 0
  local index = 3
  local mainIndex = 1
  local subIndex = 4
  local mainMonsterLv = 0
  for i = 1, 6 do
    local monsterID = 0
    local monsterLv = 0
    count = count + 1
    if (i - 1) % 2 == 0 then
      monsterID = monsterInfos.monsterId[mainIndex]
      monsterLv = monsterInfos.level[mainIndex]
      mainIndex = mainIndex + 1
    else
      monsterID = monsterInfos.monsterId[subIndex]
      monsterLv = monsterInfos.level[subIndex]
      subIndex = subIndex + 1
    end
    local ret = WU.GetMonsterAttr(monsterID, monsterLv)
    if ret and ret[PB.enum.AttrType.Hp] then
      filledHp = filledHp + ret[PB.enum.AttrType.Hp].value
      local ii = fif((i - 1) % 2 == 0, mainIndex - 1, subIndex - 1)
      if nowHpList[ii] then
        nowHp = nowHp + math.max(nowHpList[ii], 0)
      else
        nowHp = nowHp + ret[PB.enum.AttrType.Hp].value
      end
    end
    if count == 2 then
      local barRef = _ENV["$"](_ENV["$"](REF.HP)["Bar" .. index])
      local memberRef = _ENV["$"](_ENV["$"](REF.Members)["G0" .. index])
      if 0 < filledHp then
        barRef["$gameObject"]:SetActive(true)
        local dead = nowHp == 0
        barRef.SpriteProgress.UISprite.fillAmount = nowHp / 1.0 / filledHp
        local tweens = memberRef["$transform"]:GetComponentsInChildren(typeof(CS.TweenAlpha))
        for i = 0, tweens.Length - 1 do
          tweens[i].to = fif(dead, 0.5, 1)
        end
        _ENV["$"](REF.DeadInfo)["SpriteDead" .. index].gameObject:SetActive(dead)
      else
        _ENV["$"](REF.DeadInfo)["SpriteDead" .. index].gameObject:SetActive(false)
        barRef["$gameObject"]:SetActive(false)
      end
      count = 0
      filledHp = 0
      nowHp = 0
      index = index - 1
    end
  end
end

function SetFilledHp(count, isMonster)
  REF.HP.gameObject:SetActive(true)
  if isMonster then
    for i = 0, 2 do
      REF.HP[i].SpriteProgress.UISprite.spriteName = "tower_vs_bar_2"
    end
  end
  for i = 0, #REF.HP - 1 do
    local barRef = REF.HP[i]
    if i < count then
      barRef["$gameObject"]:SetActive(true)
      barRef.SpriteProgress.UISprite.fillAmount = 1
    else
      barRef["$gameObject"]:SetActive(false)
    end
  end
end

function DontShowQuality()
  m_dontShowQuality = true
end

function SetNodeAdd(data)
  REF.NodeAdd.gameObject:SetActive(data)
end

function SetSpriteLine(data)
  REF.SpriteLine1.gameObject:SetActive(data)
  REF.SpriteLine2.gameObject:SetActive(data)
end

function SetCustomActorId(id)
  m_customActorId = id
end
