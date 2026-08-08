inherit("Window/Guild/GuildSensitiveBase", _ENV)
local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local m_dungeonType, m_initedToggle, m_dungeonId, m_rankList, m_guildId, m_dungeonMonster, m_myPlayerId

function SetupWindow()
  WU.BindButtonEvent(REF.BtnPrepare, OnBtnPrepareClick)
  WU.BindButtonEvent(REF.NodeTeam, OnNodeMonsterClick)
  SetupToggleAutoFight()
end

function InitWindow()
  REF.EffectBg.UITexture.enabled = false
  REF.ClickMask.gameObject:SetActive(false)
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
  end)
  REF.NodeContribution.gameObject:SetActive(false)
  REF.NodeChallenge.gameObject:SetActive(false)
  m_dungeonId = this:GetData("WindowDungeon/DungeonId")
  UpdateDungeonInfoUI()
  UpdatePlayerInfoUI()
  this:GameRequest("fci/guild-dungeon/v2/" .. m_guildId .. "/record/" .. m_dungeonId):Get(function(res)
    _ENV["$"](REF.NodeTeam).WidgetDungeonGroup["$SetHp2"](m_dungeonMonster, res.enemyHpList)
  end)
end

function ShowEnter()
  WU.ToggleTopBar("DungeonGuildPrepare", false)
  local soundPath = "Sound/system/s_System_GuildIn"
  CS.SoundManager.Instance:PlaySound(soundPath, 1.0)
  WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
  REF.EffectBg.UITexture.enabled = true
  local index = this:GetData("DungeonGuild/Index")
  local tex = WU.AcquireAsset("Texture/UnionFB/UI_UnionFB_EnterV0" .. index)
  REF.BGtext01.MeshRenderer.material:SetTexture("_MainTex", tex)
  REF.BGtext02.MeshRenderer.material:SetTexture("_MainTex", tex)
  REF.BGtext03.MeshRenderer.material:SetTexture("_MainTex", tex)
  REF.EffectEnter.gameObject:SetActive(true)
  REF.ClickMask.gameObject:SetActive(true)
  REF.EffectEnter.EffectGenerator:Play()
  this:DelayInvokeInSeconds(1.4, function()
    WU.ToggleTopBar("DungeonGuildPrepare", true)
    WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
    REF.EffectBg.UITexture.enabled = false
    REF.ClickMask.gameObject:SetActive(false)
  end)
end

function Focus(on)
  if on then
    WU.SetWindowTitle("DungeonGuildPrepare", "RacePVPPrepare")
  end
end

function UpdatePlayerInfoUI()
  local summary = this:GetData("DungeonGuild/Summary")
  REF.LabelContribution.UILabel.text = summary.contribution.fightContributionDegree or 0
  WU.SetActive(REF.NodeContribution, true)
  local _, v = table.find(summary.dungeonRecords, function(k1, v1)
    return v1.dungeonId == m_dungeonId
  end)
  local showChallengeScore = v and v.dungeonType == PB.enum.DungeonType.ChallengeGuild
  if v then
    InitAutoFight(v.dungeonType)
  end
  WU.SetActive(REF.NodeChallenge, showChallengeScore)
  if showChallengeScore then
    REF.LabelChallengeScore.UILabel.text = summary.challengeRecord.maxBattleScore or 0
  end
end

function UpdateDungeonInfoUI()
  m_dungeonMonster = PB.get("DungeonMonster", m_dungeonId)
  if m_dungeonMonster == nil then
    error("Activity", "no dungeonId " .. m_dungeonId .. " in DungeonMonster! ")
  else
    local actors = GU.MonsterGroup(m_dungeonMonster.monsterId)
    local showTypeList = m_dungeonMonster.showType or {}
    _ENV["$"](REF.NodeTeam).WidgetDungeonGroup["$SetTips"](showTypeList, true)
    _ENV["$"](REF.NodeTeam).WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
  end
  REF.AffixWidget["$ShowAffixWidget"](m_dungeonId)
end

function OnBtnPrepareClick()
  GU.SetGroupMode(PB.enum.ActorGroupType.Guild)
  this:GameRequest("fci/guild/" .. m_guildId .. "/rent-actor/"):Get(function(res)
    local rentActors = res and res.rentActorInfo or _ENV["!"]({})
    local myPlayerId = this:GetData("playerId")
    local actorList = _ENV["!"]({})
    for i = 1, #rentActors do
      local rentInfo = rentActors[i]
      if rentInfo.playerId ~= myPlayerId then
        local actor = rentInfo.actor
        actor.kind = PB.get("ActorConfig", actor.id).kind
        actor.isGuildActor = true
        actor.cultivationTotal = rentInfo.cultivationDegree
        actor.posEquip = rentInfo.posEquip
        actor.speed = U.GetAttrValue(actor.attrs, PB.enum.AttrType.Speed)
        actor.actorName = WU.GetString("ActorNameEn_" .. actor.id)
        table.insert(actorList, actor)
      end
    end
    this:SetData("DungeonGuild/RentActors", actorList)
    WU.AcquireWindowAsync("DungeonGuildActorSelect")
  end)
end

function OnNodeMonsterClick()
  WU.AcquireWindowAsync("EnemyTeamDetail", function(window)
    _ENV["$"](window)["$$SetGuildValidate"]()
  end)
end

function SetupToggleAutoFight()
  if REF.ToggleAutoFight then
    CS.EventDelegate.Add(REF.ToggleAutoFight.UIToggle.onChange, function()
      if m_initedToggle then
        DU.SetAutoFight(m_dungeonType, CS.UIToggle.current.value)
        DU.SendAutoFightSetting()
      end
    end)
  else
  end
end

function InitAutoFight(dungeonType)
  m_dungeonType = dungeonType
  if REF.ToggleAutoFight then
    local unlock = not WU.WindowIsLocked(PB.enum.UnlockWindow.AutoFight)
    REF.ToggleAutoFight.gameObject:SetActive(unlock)
    REF.ToggleAutoFight.UIToggle.value = DU.IsAutoFightOpen(m_dungeonType)
    m_initedToggle = true
  else
  end
  if REF.RightBottomGrid then
    REF.RightBottomGrid.UIGrid:Reposition()
  end
end
