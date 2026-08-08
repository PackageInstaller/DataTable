local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local SDU = require("Common/SoundUtil")
local m_balance, m_dungeonId, m_isChallenge, m_actorTexture, m_skipAnim
local m_anim = {
  curScore = {},
  highestScore = {},
  curContribution = {}
}

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.BindButtonEvent(REF.NodeBack, OnBackClick)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
  WU.BindButtonEvent(REF.NodeAgain, OnAgainClick)
end

function InitWindow()
  m_actorTexture = nil
  m_balance = this:GetData("DungeonBalance/result")
  m_dungeonId = this:GetData("WindowDungeon/DungeonId")
  WU.ToggleRendering(REF.LabelCurrentContribution, false)
  WU.ToggleRendering(REF.LabelCurrentScore, false)
  WU.ToggleRendering(REF.LabelHighestScore, false)
  SetActorTextureEffect()
  UpdateUI()
  if m_skipAnim then
    return
  end
  PlayAnim()
end

function SetActorTextureEffect()
  local displayActorID = this:GetData("FightWinActor")
  if displayActorID == nil or displayActorID == 0 then
    return
  end
  local actorConfig = PB.get("ActorConfig", displayActorID)
  if actorConfig == nil then
    return
  end
  SDU.PlayActorWin(displayActorID)
  m_actorTexture = WU.AcquireAsset("Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes, this)
  REF.Role_01.MeshRenderer.material:SetTexture("_MainTex", m_actorTexture)
  REF.Role_01ADD.MeshRenderer.material:SetTexture("_MainTex", m_actorTexture)
  REF.EffectRight.EffectGenerator:Play()
  local portraitOffset = CS.UnityEngine.Vector3(actorConfig.portraitOffsetX, actorConfig.portraitOffsetY, 0)
  local effectOffset = REF.Balance_01D2.transform:InverseTransformPoint(REF.EffectRight.transform:TransformPoint(portraitOffset))
  REF.Role_01.transform.localPosition = REF.Role_01.transform.localPosition + effectOffset
  REF.Role_01ADD.transform.localPosition = REF.Role_01ADD.transform.localPosition + effectOffset
end

function UpdateUI()
  local type = this:GetData("DungeonGuild/DungeonType")
  m_isChallenge = type == PB.enum.DungeonType.ChallengeGuild
  WU.SetActive(REF.NodeCurrentScore, m_isChallenge)
  WU.SetActive(REF.NodeHighestScore, m_isChallenge)
  m_anim.curContribution.num = m_balance.contribution
  if m_isChallenge then
    m_anim.curScore.num = m_balance.score
    local summary = this:GetData("DungeonGuild/Summary")
    local oriScore = summary.challengeRecord.maxBattleScore or 0
    m_anim.highestScore.num = oriScore
  end
  REF.ProgressHp.gameObject:SetActive(m_balance.progress ~= 100)
  REF.NodeComplete.gameObject:SetActive(m_balance.progress == 100)
  if m_balance.progress ~= 100 then
    REF.NodeBar.UIProgressBar.value = (100 - m_balance.progress) / 100.0
    REF.LabelRestHp.UILabel.text = WU.GetString("DungeonGuild_RestHp", 100 - m_balance.progress)
  end
end

function UpdateWindow(delta)
  DoNumberChangeAnim(REF.LabelCurrentContribution, m_anim.curContribution, delta)
  DoNumberChangeAnim(REF.LabelCurrentScore, m_anim.curScore, delta)
  DoNumberChangeAnim(REF.LabelHighestScore, m_anim.highestScore, delta)
end

function DoNumberChangeAnim(refLabel, config, delta)
  if config.on and config.during < 2 then
    config.during = math.min(config.during + delta, 2)
    local progressScore = math.floor(config.during * config.num / 2.0)
    refLabel.UILabel.text = progressScore
  else
    config.on = false
  end
end

function PlayAnim()
  WU.ToggleRendering(REF.AnimMask, true)
  REF.Right.UIPlayTween:Play(true)
  local delayTime = 0.8
  this:DelayInvokeInSeconds(delayTime, function()
    if m_skipAnim then
      return
    end
    WU.ToggleRendering(REF.LabelCurrentContribution, true)
    REF.LabelCurrentContribution.UILabel.text = 0
    m_anim.curContribution.on = true
    m_anim.curContribution.during = 0
  end)
  if m_isChallenge then
    delayTime = delayTime + 0.4
    this:DelayInvokeInSeconds(delayTime, function()
      if m_skipAnim then
        return
      end
      WU.ToggleRendering(REF.LabelCurrentScore, true)
      WU.ToggleRendering(REF.LabelHighestScore, true)
      REF.LabelCurrentScore.UILabel.text = 0
      REF.LabelHighestScore.UILabel.text = 0
      m_anim.curScore.on = true
      m_anim.curScore.during = 0
      m_anim.highestScore.on = true
      m_anim.highestScore.during = 0
    end)
  end
  delayTime = delayTime + 2
  this:DelayInvokeInSeconds(delayTime, function()
    if m_skipAnim then
      return
    end
    OnAnimFinished()
  end)
end

function OnSkipAnimClick()
  if m_skipAnim then
    return
  end
  m_skipAnim = true
  REF.Right.UIPlayTween:Play(true)
  REF.Right.UIPlayTween:Finish()
  m_anim.curContribution.on = false
  WU.ToggleRendering(REF.LabelCurrentContribution, true)
  REF.LabelCurrentContribution.UILabel.text = m_anim.curContribution.num
  if m_isChallenge then
    m_anim.curScore.on = false
    WU.ToggleRendering(REF.LabelCurrentScore, true)
    REF.LabelCurrentScore.UILabel.text = m_anim.curScore.num
    m_anim.highestScore.on = false
    WU.ToggleRendering(REF.LabelHighestScore, true)
    REF.LabelHighestScore.UILabel.text = m_anim.highestScore.num
  end
  OnAnimFinished()
end

function OnAnimFinished()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.SetActive(REF.BottomRight, true)
end

function OnDestroy()
  if m_actorTexture then
    WU.ReleaseAsset(m_actorTexture, this)
  end
end

function OnAgainClick()
  local windowParam = "RelationPortal, Guild, DungeonGuildStage, DungeonGuildPrepare"
  DU.LeaveDungeon(1, windowParam)
end

function OnBackClick()
  DU.LeaveDungeon(1)
end
