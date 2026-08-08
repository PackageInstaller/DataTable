local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local IU = require("Common/ItemUtil")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local m_missionInfo
local m_remainTime = 0
local m_finished, m_oldstate

function Start()
  WU.BindButtonEvent(REF.root, OnDetailClick)
  WU.BindButtonEvent(REF.ButtonSpeedUp, OnSpeedUpClick)
  WU.BindButtonEvent(REF.ButtonGet, OnGetRewardClick)
  WU.BindButtonEvent(REF.ButtonPlay, OnPlayCartoonClick)
end

function Update()
  if m_missionInfo == nil or m_missionInfo.startTimestamp == 0 or m_remainTime < 0 then
    return
  end
  m_remainTime = m_missionInfo.endTimestamp - CS.GameTime.serverUtc
  m_finished = m_remainTime <= 0
  REF.ButtonGet.gameObject:SetActive(m_finished)
  if REF.ButtonGet.gameObject.activeSelf and m_oldstate ~= m_finished then
    m_oldstate = m_finished
    REF.EffectBox.UIPlayTween:Play(true)
  end
  REF.ButtonSpeedUp.gameObject:SetActive(not m_finished)
  REF.LabelRemainTime.gameObject:SetActive(not m_finished)
  if not m_finished then
    REF.LabelRemainTime.UIHtmlLabel.text = WU.RenderCountDownTime(m_remainTime, REF.LabelRemainTime.UIHtmlLabel.fontSize)
  end
end

function OnDetailClick()
  WU.RecordButtonClick(100132001)
  SaveSelectedMission()
  WU.AcquireWindowAsync("DeployMissionDetail")
end

function OnSpeedUpClick()
  WU.RecordButtonClick(100132003)
  SaveSelectedMission()
  WU.AcquireWindowAsync("DeploySpeedUp")
end

function OnGetRewardClick()
  this:GameRequest("fci/deploy/deploymissionreward/"):Post({
    id = m_missionInfo.id
  }, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    DB:SyncRemote(DB:GameRequest("fci/deploy/mission/"))
    NU.UpdateRoleFavour(result.favourChange)
  end)
end

function OnPlayCartoonClick()
  local cartoonId = m_missionInfo.config.storyId
  WU.EnterCartoonLevel(cartoonId, "Activity, Deploy")
end

function SaveSelectedMission()
  this:SetData("Deploy/SelectedMission", m_missionInfo)
end

function SetView(info)
  m_remainTime = 0
  m_missionInfo = info
  local config = m_missionInfo.config
  REF.SpriteMissionIcon.UISprite.spriteName = config.icon
  REF.LabelName.UILabel.text = WU.GetString("DeployMissionName_" .. config.id)
  WU.ToggleRendering(REF.SpriteGuildMission, config.guildMission)
  WU.SetActive(REF.SpriteUnavailableTip, not m_missionInfo.available)
  for i = 0, #REF.Rewards - 1 do
    local hasReward = i < #m_missionInfo.config.reward
    REF.Rewards[i].root.gameObject:SetActive(hasReward)
    if hasReward then
      local reward = m_missionInfo.config.reward[i + 1]
      REF.Rewards[i].root["$SetData"](reward.type, reward.id, reward.count)
      REF.Rewards[i].root["$SetClickCallback"](function()
        WU.ShowResourceDetail(reward.type, reward.id)
      end)
    end
  end
  local ongoing = m_missionInfo.startTimestamp ~= 0
  REF.Ongoing.gameObject:SetActive(ongoing)
  REF.Info.gameObject:SetActive(not ongoing)
  REF.ButtonPlay.gameObject:SetActive(ongoing and m_missionInfo.config.storyId ~= 0)
  if ongoing then
    for i = 0, #REF.Actors - 1 do
      local hasActor = i < m_missionInfo.config.needRoleNum
      REF.Actors[i].root.gameObject:SetActive(hasActor)
      if hasActor then
        local roleId = m_missionInfo.roleid[i + 1]
        local ref = REF.Actors[i]
        ref["$$SetActorByRoleId"](roleId)
        ref["$$ShowCustom"]({name = false})
      end
    end
    REF.Actors.UIGrid:Reposition()
  else
    REF.LabelActorCount.UILabel.text = m_missionInfo.config.needRoleNum
    REF.LabelTime.UILabel.text = WU.GetString("Window_Hour", m_missionInfo.config.time // 3600)
    local cost = m_missionInfo.config.cost
    local free = #cost == 0 or cost[1].count == 0
    REF.SpritePower.gameObject:SetActive(not free)
    if free then
      REF.LabelPower.UILabel.text = WU.GetString("Window_Free")
    else
      REF.LabelPower.UILabel.text = cost[1].count
    end
  end
  REF.Visual.UIPlayTween:Play(true)
end
