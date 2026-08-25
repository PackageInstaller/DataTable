local System = require("System.System")
local AudioManager = require("Managers.AudioManager")
local Logger = require("Utility.Logger")
local bc = require("Battle.BattleConst")
local AwakerAudioManager = require("Managers.AwakerAudioManager")
local EventMgr = require("Managers.EventManager.EventMgr")
local CommonDefine = require("World.Enums.CommonDefine")
local bg = require("Battle.DbgRender.BattleGlobal")
local BattleAudioUtils = System.NewClass("BattleAudioUtils")

function BattleAudioUtils.PostAudio(eventName, gameObject, curSkin, delay)
  if AwakerSkinUtils.IsReplaceBattleAudio(curSkin) then
    eventName = AwakerSkinUtils.ReplaceSkinRes(eventName, curSkin)
  end
  AudioManager.Instance:PostSoundEvent(eventName, gameObject, delay)
end

function BattleAudioUtils.PostTalk(eventName, gameObject, curSkin, delay)
  if AwakerSkinUtils.IsReplaceBattleTalk(curSkin) then
    eventName = AwakerSkinUtils.ReplaceSkinRes(eventName, curSkin)
  end
  AudioManager.Instance:PostSoundEvent(eventName, gameObject, delay)
end

function BattleAudioUtils.PlayBattleActionAudio(roleId, gameObj, curSkin, delay)
  local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceIdFromBattle(CommonDefine.AwakerVoiceTrigger.StageStart, roleId, curSkin)
  if 0 == voiceId then
    return
  end
  local voiceConfig = bg.DT.Voice[voiceId]
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  EventMgr.Instance.ShowAwakerBubble:Dispatch(voiceConfig.AwakerVoiceContent, duration, delay, voiceConfig.AwakerID)
  BattleAudioUtils.PostTalk(soundEventName, gameObj, nil, delay)
end

function BattleAudioUtils.PlayAttackAudio(roleId, gameObj, curSkin, delay)
  local DT = bg.DT
  local voiceCfg = DT.VoiceConfig[roleId]
  if not voiceCfg then
    return
  end
  if voiceCfg.AttackAudio then
    BattleAudioUtils.PostAudio(voiceCfg.AttackAudio, gameObj, curSkin, delay)
  end
  if voiceCfg.AttackSound then
    BattleAudioUtils.PostAudio(voiceCfg.AttackSound, gameObj, curSkin, delay)
  end
end

function BattleAudioUtils.PlayBuffAudio(roleId, gameObj, curSkin, delay)
  local DT = bg.DT
  local voiceCfg = DT.VoiceConfig[roleId]
  if not voiceCfg then
    return
  end
  if voiceCfg.BuffAudio then
    BattleAudioUtils.PostAudio(voiceCfg.BuffAudio, gameObj, curSkin, delay)
  end
  if voiceCfg.BuffSound then
    BattleAudioUtils.PostAudio(voiceCfg.BuffSound, gameObj, curSkin, delay)
  end
end

function BattleAudioUtils.PlayDebuffAudio(roleId, gameObj, curSkin, delay)
  local DT = bg.DT
  local voiceCfg = DT.VoiceConfig[roleId]
  if not voiceCfg then
    return
  end
  if voiceCfg.DebuffAudio then
    BattleAudioUtils.PostAudio(voiceCfg.DebuffAudio, gameObj, curSkin, delay)
  end
  if voiceCfg.DebuffSound then
    BattleAudioUtils.PostAudio(voiceCfg.DebuffSound, gameObj, curSkin, delay)
  end
end

function BattleAudioUtils.PlayExclusiveAudio(roleId, gameObj, curSkin, delay)
  local DT = bg.DT
  if DT.VoiceConfig[roleId] and DT.VoiceConfig[roleId].ExclusiveAudio then
    BattleAudioUtils.PostAudio(DT.VoiceConfig[roleId].ExclusiveAudio, gameObj, curSkin, delay)
  else
    Logger.Warn("[BattleAudio] 动画id: %s ExclusiveAudio 不存在", tostring(roleId))
  end
end

function BattleAudioUtils.PlayVictoryAudio(roleId, gameObj, curSkin, delay)
  local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceIdFromBattle(CommonDefine.AwakerVoiceTrigger.StageVictory, roleId, curSkin)
  if 0 == voiceId then
    return
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  BattleAudioUtils.PostTalk(soundEventName, gameObj, nil, delay)
end

function BattleAudioUtils.PlayAwakerHitAudio(roleId, gameObj, curSkin, isNoLineVoice, trigger, delay)
  local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceIdFromBattle(trigger, roleId, curSkin, isNoLineVoice)
  if 0 == voiceId then
    return
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  BattleAudioUtils.PostTalk(soundEventName, gameObj, nil, delay)
end

function BattleAudioUtils.PlayMonsterHitAudio(animationId, gameObj, delay)
  local DT = bg.DT
  if DT.VoiceConfig[animationId] and DT.VoiceConfig[animationId].HitAudio then
    local tHitAudio = DT.VoiceConfig[animationId].HitAudio
    local index = math.random(1, #tHitAudio)
    BattleAudioUtils.PostAudio(tHitAudio[index], gameObj, nil, delay)
  else
    Logger.Warn("[BattleAudio] 受击语音id: %s HitAudio 不存在", tostring(animationId))
  end
end

function BattleAudioUtils.PlayMonsterHitSound(animationId, gameObj, delay)
  local DT = bg.DT
  if DT.VoiceConfig[animationId] and DT.VoiceConfig[animationId].HitSound then
    local tHitSound = DT.VoiceConfig[animationId].HitSound
    local index = math.random(1, #tHitSound)
    BattleAudioUtils.PostAudio(tHitSound[index], gameObj, nil, delay)
  else
    Logger.Warn("[BattleAudio] 音效id: %s HitSound 不存在", tostring(animationId))
  end
end

function BattleAudioUtils.PlayMonsterArriveAudio(animationId, gameObj, delay)
  local DT = bg.DT
  if DT.VoiceConfig[animationId] and DT.VoiceConfig[animationId].ArriveSound then
    local tArriveSound = DT.VoiceConfig[animationId].ArriveSound
    local index = math.random(1, #tArriveSound)
    BattleAudioUtils.PostAudio(tArriveSound[index], gameObj, nil, delay)
  else
    Logger.Warn("[BattleAudio] 动画id: %s ArriveSound 不存在", tostring(animationId))
  end
end

function BattleAudioUtils.PlaySkillAudio(roleId, skillNum, gameObj, curSkin, delay)
  local key = skillNum and "SkillAudio" .. tostring(skillNum) or "SkillAudio1"
  local DT = bg.DT
  if DT.VoiceConfig[roleId] and DT.VoiceConfig[roleId][key] then
    BattleAudioUtils.PostAudio(DT.VoiceConfig[roleId][key], gameObj, curSkin, delay)
  else
    Logger.Warn("[BattleAudio] 动画id: %s %s 不存在", tostring(roleId), key)
  end
end

function BattleAudioUtils.PlayDeathAudio(roleId, gameObj, curSkin, delay)
  local DT = bg.DT
  if DT.VoiceConfig[roleId] and DT.VoiceConfig[roleId].DeathAudio then
    local tDeathAudio = DT.VoiceConfig[roleId].DeathAudio
    for i, v in ipairs(tDeathAudio) do
      BattleAudioUtils.PostAudio(v, gameObj, curSkin, delay)
    end
  else
    Logger.Warn("[BattleAudio] 动画id: %s DeathAudio 不存在", tostring(roleId))
  end
  if DT.VoiceConfig[roleId] and DT.VoiceConfig[roleId].DeathSound then
    local tDeathSound = DT.VoiceConfig[roleId].DeathSound
    for i, v in ipairs(tDeathSound) do
      BattleAudioUtils.PostAudio(v, gameObj, curSkin, delay)
    end
  else
    Logger.Warn("[BattleAudio] 动画id: %s DeathSound 不存在", tostring(roleId))
  end
end

function BattleAudioUtils.PlaySfxAudio(sfxId, camp, gameObj, curSkin, delay)
  local DT = bg.DT
  local sfxConfig = DT.BattleSfxConfig[sfxId]
  assert(sfxConfig, "战斗特效找不到 " .. sfxId)
  local soundEvent = sfxConfig.SoundEventUs
  if camp == bc.BattleCamp.Camp2 then
    soundEvent = sfxConfig.SoundEventEnemy
  end
  if soundEvent then
    BattleAudioUtils.PostAudio(soundEvent, gameObj, curSkin, delay)
  end
end

return BattleAudioUtils
