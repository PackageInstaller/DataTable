local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local BUFF_ICON_MAX_NUM = 8
local FRAME_TIME = 0.0333
local m_uid = 0
local m_playerID = ""
local m_spriteCom
local m_spriteName = ""
local m_state = ""
local m_spriteSequence = {}
local m_startTime = 0
local m_curFrameIndex = 0
local m_curFrameTime = 0
local m_delayTime = 0
local m_tweenScaleCom, m_tweenPosXCom, m_tweenPosYCom
local m_isAttack = false
local m_parentWidget
local m_actorBuffInfoList = {}
local m_cur_state = {}
local m_last_state = {}
local m_showBuffTime = 0
local m_actorBuffList = {}
local m_mergeBuffList = {}
local m_recordBuff
local m_pressHeadTime = 0
local m_pressBuffTime = 0
local m_pressBuffOpen = false
local m_dead = false
local m_skill_title_1 = ""
local m_skill_title_2 = ""
local m_skill_info = {}
local m_skill_actor = {}
local m_roundActorInfo

function GetAllActorInfo()
  return m_skill_actor
end

function GetHeadTexPath()
  return {
    REF.headmain.UITexture.mainTexturePath,
    REF.headlink.UITexture.mainTexturePath
  }
end

function GetUID()
  return m_uid
end

function InitAllSkillInfo(skill)
  m_skill_info = skill
end

function SetActorDead()
  m_dead = true
end

function AddSupportActor(uid, id, animRes, left, selfTeamInfo)
  local dir = ""
  if not left then
    dir = "_r"
  end
  m_skill_title_2 = WU.GetString("ActorName_" .. id)
  table.insert(m_skill_actor, uid)
  REF.headlink.UITexture.mainTexturePath = "Texture/ActorInfightHead/sub" .. dir .. "/" .. "infight_head_" .. animRes
  REF.headlink.gameObject:SetActive(true)
  local team, seat = DEFINE.RoundActorInfoUniqueId(uid)
  local fightLuaLogic = CS.FightLuaLogic.Instance
  local selfTeam = fightLuaLogic.SelfTeam
  local firstBuffRef = _ENV["$"](m_actorBuffInfoList[1])
  WU.SetActive(firstBuffRef.SubWeapon, false)
  if selfTeamInfo and team == selfTeam then
    m_roundActorInfo = FH.getActorByUid(selfTeamInfo, uid)
    if m_roundActorInfo then
      local uniqueWeaponId = m_roundActorInfo.actorInfo.uniqueWeaponId
      if uniqueWeaponId and 0 < uniqueWeaponId then
        table.remove(m_actorBuffInfoList, 1)
        WU.SetActive(firstBuffRef.effect_show, false)
        WU.SetActive(firstBuffRef.buff_sprite, false)
        WU.SetActive(firstBuffRef.SubWeapon, true)
        local skin = m_roundActorInfo.actorInfo.uniqueWeaponSkin or 0
        firstBuffRef.SubWeaponTex.UITexture.mainTexturePath = "Texture/FightImpressionHead/FightImpressionSkillHead/impression_skill_head_" .. uniqueWeaponId .. "_" .. skin
      end
    end
  end
end

function InitFightHeadInfo(uid, id, animRes, playerID, left, widget)
  m_parentWidget = widget
  m_uid = uid
  m_skill_title_1 = WU.GetString("ActorName_" .. id)
  table.insert(m_skill_actor, uid)
  m_playerID = playerID
  m_spriteName = "infight_head_" .. animRes
  m_spriteCom = REF.headmain.UITexture
  local dir = ""
  if not left then
    dir = "_r"
  end
  m_spriteCom.mainTexturePath = "Texture/ActorInfightHead/main" .. dir .. "/" .. m_spriteName
  REF.headlink.gameObject:SetActive(false)
  WU.SetActive(REF.position, false)
  REF.headeffect.gameObject:SetActive(false)
  REF.talk.gameObject:SetActive(false)
  m_tweenScaleCom = REF["$"].TweenScale
  m_tweenPosXCom = REF.anchor1.TweenPosition
  m_tweenPosYCom = REF.anchor2.TweenPosition
  this:RegisterGameEvent("OnRoleUIEffect" .. uid, OnRoleEffectChange)
  this:RegisterGameEvent("OnRoleUIPosChange", OnRoleChangePos)
  WU.BindButtonEvent(REF.btn, OnClickHead)
  WU.BindPressEvent(REF.btn, OnPressHead)
  WU.BindButtonEvent(REF.buffBtn, OnClickBuff)
  WU.BindPressEvent(REF.buffBtn, OnPressBuff)
  local buffGrid = REF.buffGrid
  for i = 0, buffGrid.transform.childCount - 1 do
    local newBtn = buffGrid.transform:GetChild(i).gameObject
    local ref = _ENV["$"](newBtn)
    ref.effect_show.gameObject:SetActive(false)
    ref.effect_hide.gameObject:SetActive(false)
    ref.effect_broke.gameObject:SetActive(false)
    ref.buff_sprite.gameObject:SetActive(false)
    ref.effect_sign.gameObject:SetActive(false)
    WU.SetActive(ref.SubWeapon, false)
    table.insert(m_actorBuffInfoList, newBtn)
  end
  for i = 1, #m_actorBuffInfoList do
    table.insert(m_cur_state, {
      0,
      0,
      0,
      0,
      0,
      0,
      0
    })
  end
end

function ShowFightTalk(playerID, content)
  if m_playerID == playerID then
    REF.talk.gameObject:SetActive(true)
    if string.match(content, "<img src=.*>") then
      content = WU.GetString("Window_ChatImagePlaceHoder")
    end
    REF.talkHtml.UILabel.text = content
    REF.talk.TweenAlpha:ResetToBeginning()
    REF.talk.TweenAlpha:PlayForward()
    REF.talk.TweenAlpha:SetOnFinished(function()
      REF.talk.gameObject:SetActive(false)
    end)
  end
end

function Update(delta)
  if 0 < m_showBuffTime then
    m_showBuffTime = m_showBuffTime - delta
    if m_showBuffTime <= 0 then
      m_showBuffTime = 0
      ShowNewBuff()
    end
  end
  if 0 < m_pressHeadTime then
    m_pressHeadTime = m_pressHeadTime - delta
    if m_pressHeadTime <= 0 then
      m_pressHeadTime = 0
      SetHeadSkill(true)
    end
  end
  if 0 < m_pressBuffTime then
    m_pressBuffTime = m_pressBuffTime - delta
    if m_pressBuffTime <= 0 then
      m_pressBuffTime = 0
      m_pressBuffOpen = true
      OnClickBuff()
    end
  end
end

function OnRoleChangePos(show)
  local box_y1 = CS.UnityEngine.Vector2(0, 5000)
  if show then
    box_y1 = CS.UnityEngine.Vector2(0, 0)
  end
  REF.btn.BoxCollider2D.offset = box_y1
  local box_y2 = CS.UnityEngine.Vector2(0, 0)
  if show then
    box_y2 = CS.UnityEngine.Vector2(0, -5000)
  end
  REF.buffBtn.BoxCollider2D.offset = box_y2
end

function OnRoleEffectChange(val)
  REF.headeffect.gameObject:SetActive(val)
end

function OnActorBuffChange(buffList)
  local same_buff = m_recordBuff ~= nil and #m_recordBuff == #buffList
  if same_buff and not table.empty(m_recordBuff) then
    local exclude = {
      isNewHit = true,
      rate = true,
      sourceId = true,
      mergeState = true
    }
    for j = 1, #buffList do
      for k, v in pairs(buffList[j]) do
        if (k == "buffKey" or type(v) ~= "table") and not exclude[k] then
          if k == "buffKey" then
            same_buff = m_recordBuff[j][k].id == v.id and m_recordBuff[j][k].owner == v.owner
          else
            same_buff = m_recordBuff[j][k] == v
          end
          if same_buff == false then
            break
          end
        end
      end
      if same_buff == false then
        break
      end
    end
  end
  if same_buff then
    return
  end
  m_recordBuff = buffList
  m_actorBuffList = {}
  m_mergeBuffList = {}
  m_last_state = {}
  local maxCount = #m_actorBuffInfoList
  for i = 1, maxCount do
    table.insert(m_last_state, m_cur_state[i])
    m_cur_state[i] = {
      0,
      0,
      0,
      0,
      0,
      0,
      0
    }
  end
  local delete_list = {}
  local index = 0
  for j = 1, #buffList do
    local buff = buffList[j]
    local buffData = PB.get("BuffData", buff.buffKey.id, buff.buffKey.owner)
    if buffData.hideFlag == 0 then
      if buff.state ~= PB.enum.BuffFightState.Delete then
        if buff.mergeState == 1 then
          table.insert(m_mergeBuffList, buff)
        elseif buff.mergeState == 0 then
          table.insert(m_actorBuffList, buff)
          index = index + 1
          if maxCount >= index then
            m_cur_state[index] = {
              buff.buffKey.Id,
              buff.buffKey.owner,
              buff.ownerUid,
              buff.indexId,
              buff.round,
              buff.stack,
              buff.exRound
            }
          end
        end
      end
      if buff.state == PB.enum.BuffFightState.Delete and buff.mergeState == 0 and buff.removeType == 1 then
        table.insert(delete_list, {
          buff.buffKey.id,
          buff.buffKey.owner,
          buff.ownerUid,
          buff.indexId
        })
      end
    end
  end
  local have_delete = false
  if m_parentWidget ~= nil and m_parentWidget.alpha == 1 then
    for i = 1, maxCount do
      local delete = false
      local old_buff_info = m_last_state[i]
      if old_buff_info[1] ~= 0 and old_buff_info[2] ~= 0 then
        delete = true
        for j = 1, maxCount do
          local new_buff_info = m_cur_state[j]
          if old_buff_info[1] == new_buff_info[1] and old_buff_info[2] == new_buff_info[2] and old_buff_info[3] == new_buff_info[3] and old_buff_info[4] == new_buff_info[4] then
            delete = false
            break
          end
        end
      end
      if delete then
        have_delete = true
        _ENV["$"](m_actorBuffInfoList[i]).buff_sprite.gameObject:SetActive(false)
        _ENV["$"](m_actorBuffInfoList[i]).effect_sign.gameObject:SetActive(false)
        local broken = false
        for b = 1, #delete_list do
          if old_buff_info[1] == delete_list[b][1] and old_buff_info[2] == delete_list[b][2] and old_buff_info[3] == delete_list[b][3] and old_buff_info[4] == delete_list[b][4] then
            broken = true
            break
          end
        end
        if not broken then
          _ENV["$"](m_actorBuffInfoList[i]).effect_hide.gameObject:SetActive(true)
        else
          _ENV["$"](m_actorBuffInfoList[i]).effect_broke.gameObject:SetActive(true)
        end
      end
    end
  end
  if have_delete then
    m_showBuffTime = 0.5
  else
    m_showBuffTime = 0
    ShowNewBuff()
  end
  CS.FightLuaLogic.Instance.mFightRoundSandBox.ShowBuffDetail(m_uid, m_actorBuffList, m_mergeBuffList, true, REF.buffGrid, m_roundActorInfo)
end

function ShowNewBuff()
  local maxCount = #m_actorBuffInfoList
  for i = 1, maxCount do
    _ENV["$"](m_actorBuffInfoList[i]).effect_show.gameObject:SetActive(false)
    _ENV["$"](m_actorBuffInfoList[i]).effect_hide.gameObject:SetActive(false)
    _ENV["$"](m_actorBuffInfoList[i]).effect_broke.gameObject:SetActive(false)
    _ENV["$"](m_actorBuffInfoList[i]).buff_sprite.gameObject:SetActive(false)
    _ENV["$"](m_actorBuffInfoList[i]).effect_sign.gameObject:SetActive(false)
    if m_cur_state[i][1] ~= 0 and m_cur_state[i][2] ~= 0 then
      local buff = m_actorBuffList[i]
      local round_text = ""
      if 0 <= buff.round then
        round_text = tostring(buff.round)
      else
        round_text = WU.GetString("Buff_Desc_Infinite")
      end
      _ENV["$"](m_actorBuffInfoList[i]).buff_label.UILabel.text = round_text
      local buffData = PB.get("BuffData", buff.buffKey.id, buff.buffKey.owner)
      _ENV["$"](m_actorBuffInfoList[i]).buff_sprite.UISprite.spriteName = buffData.iconName
      _ENV["$"](m_actorBuffInfoList[i]).buff_sprite.gameObject:SetActive(true)
      if buffData.effect ~= 0 then
        _ENV["$"](m_actorBuffInfoList[i]).effect_sign.gameObject:SetActive(true)
      else
        _ENV["$"](m_actorBuffInfoList[i]).effect_sign.gameObject:SetActive(false)
      end
    end
  end
  if m_parentWidget ~= nil and m_parentWidget.alpha == 1 then
    for i = 1, maxCount do
      local add = false
      local new_buff_info = m_cur_state[i]
      if new_buff_info[1] ~= 0 and new_buff_info[2] ~= 0 then
        add = true
        for j = 1, maxCount do
          local old_buff_info = m_last_state[j]
          if old_buff_info[1] == new_buff_info[1] and old_buff_info[2] == new_buff_info[2] and old_buff_info[3] == new_buff_info[3] and old_buff_info[4] == new_buff_info[4] then
            add = false
            if new_buff_info[5] > old_buff_info[5] then
              add = true
            end
            if new_buff_info[6] > old_buff_info[6] then
              add = true
            end
            if new_buff_info[7] > old_buff_info[7] then
              add = true
            end
            break
          end
        end
      end
      if add then
        _ENV["$"](m_actorBuffInfoList[i]).effect_show.gameObject:SetActive(true)
      end
    end
  end
end

function OnClickHead(obj)
  if m_dead then
    return
  end
  if CS.FightRoundBase.Instance ~= nil then
    CS.FightRoundBase.Instance:TryDoPoseAction(m_uid)
  end
end

function OnPressHead(obj, pressed)
  if m_dead then
    return
  end
  if pressed then
    m_pressHeadTime = 0.3
  else
    m_pressHeadTime = 0
    SetHeadSkill(false)
  end
end

function OnPressBuff(obj, pressed)
  if pressed then
    m_pressBuffTime = 0.3
  else
    m_pressBuffTime = 0
    if m_pressBuffOpen then
      OnClickBuff(obj)
    end
  end
  m_pressBuffOpen = false
end

function SetHeadSkill(show)
  if 0 < #m_skill_info then
    CS.FightLuaLogic.Instance.mFightRoundSandBox.ShowAllSkill(m_uid, show, m_skill_title_1, m_skill_title_2, m_skill_info)
  end
end

function OnClickBuff(obj)
  CS.FightLuaLogic.Instance.mFightRoundSandBox.ShowBuffDetail(m_uid, m_actorBuffList, m_mergeBuffList, false, REF.buffGrid, m_roundActorInfo)
end

function WeaponTriggeredSpecial()
  if m_roundActorInfo then
    REF.buffGrid[0].WeaponTriggered.EffectGenerator:Play()
  end
end
