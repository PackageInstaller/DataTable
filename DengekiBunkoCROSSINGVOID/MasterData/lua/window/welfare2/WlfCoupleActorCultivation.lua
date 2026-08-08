local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local AU = require("Common/ActorUtil")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local GotoUtil = require("Common/GotoUtil")
local RU = require("Common/RedMarkUtil")
local GotoData = {
  [1] = {
    DungeonType = PB.enum.DungeonType.Normal,
    Title = WU.GetString("CoupleActorCultivation_GotoDungeon1"),
    SubTitle = WU.GetString("CoupleActorCultivation_GotoDungeonSub1"),
    GotoWindow = "ChapterNormal",
    FullSpriteName = "story_activities"
  },
  [2] = {
    DungeonType = PB.enum.DungeonType.WeekActivity,
    ActivityType = PB.enum.ActivityType.CollectionDungeon,
    Title = WU.GetString("CoupleActorCultivation_GotoDungeon2"),
    SubTitle = WU.GetString("CoupleActorCultivation_GotoDungeonSub2"),
    GotoWindow = "ActivityStageChoose2"
  },
  [3] = {
    DungeonType = PB.enum.DungeonType.WeekActivity,
    FullSpriteName = "new_year_activities",
    Title = WU.GetString("CoupleActorCultivation_GotoDungeon3"),
    SubTitle = WU.GetString("CoupleActorCultivation_GotoDungeonSub3"),
    GotoWindow = "EventCNYStage"
  },
  [4] = {
    DungeonType = PB.enum.DungeonType.Gold,
    ActivityType = PB.enum.ActivityType.GoldDungeon,
    Title = WU.GetString("CoupleActorCultivation_GotoDungeon4"),
    SubTitle = WU.GetString("CoupleActorCultivation_GotoDungeonSub4"),
    GotoWindow = "DungeonGold"
  }
}
local ActivityType = PB.enum.ActivityType.Couple
local m_activityManager = S:Get("ActivityManager")
local m_activity, m_curCulPlan, m_actorIdDisplayInCultivation, m_curActor, m_currentScore

function Awake()
  for i = 1, #GotoData do
    local data = GotoData[i]
    local ref = _ENV["$"](REF["GotoDungeon" .. i])
    ref.FrontSprite.UISprite.spriteName = fif(data.ActivityType ~= nil, "activities_" .. tostring(data.ActivityType), data.FullSpriteName)
    ref.DungeonTypeTitle.UILabel.text = data.Title
    ref.DungeonTypeHint.UILabel.text = data.SubTitle
    WU.BindButtonEvent(ref["$"], function()
      GotoUtil.Goto(data.GotoWindow, {})
    end)
  end
  WU.BindButtonEvent(REF.ButtonSelect1, OnClickSelect)
  WU.BindButtonEvent(REF.ButtonSelect2, OnClickSelect)
  WU.BindButtonEvent(REF.ButtonOpen, OnClickOpen)
  WU.BindButtonEvent(REF.SectionStarLevelup, OnClickStar)
  WU.BindButtonEvent(REF.SectionLevelup, OnClickLevel)
  WU.TraverseChildren(REF.Rewards, function(go, i)
    WU.BindButtonEvent(go, function()
      OnClickReward(i + 1)
    end)
  end)
end

function OnEnable()
  RU.SetRedMark("Welfare/CoupleActorCultivation", false)
  WU.SetGameDataCache("Welfare/CoupleActorCultivation", false)
  WU.SetActive(REF.EffectExp, false)
  SetNodeActive(nil)
  this:Bind("fci/resource/ResCoupleScore_0", UpdateProgress)
  this:Bind("CoupleActorCultivation/CurActivity", OnActivity, false)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  local activities = m_activityManager.GetActivitiesByTypeSync(ActivityType)
  this:SetData("CoupleActorCultivation/CurActivity", activities[1])
  this:RegisterGameEvent("OnCoupleReward", RewardGameRequest)
end

function OnDisable()
  this:Unbind("CoupleActorCultivation/CurActivity", OnActivity)
  this:Unbind("fci/resource/ResCoupleScore_0", UpdateProgress)
  this:Unbind("fci/couple/", OnPlan)
  this:UnregisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:UnregisterGameEvent("OnCoupleReward", RewardGameRequest)
end

function SetNodeActive(...)
  WU.SetActive(REF.NodeDecorate, false)
  WU.SetActive(REF.NodeStart, false)
  WU.SetActive(REF.NodeSelect, false)
  WU.SetActive(REF.NodeCultivation, false)
  local nodes = {
    ...
  }
  for i = 1, #nodes do
    WU.SetActive(nodes[i], true)
  end
end

function OnActivity(activity)
  m_activity = activity
  if m_activity then
    REF.LabelTime1.UILabel.text = ACU.RenderTimeSlice(m_activity.timestampStart, m_activity.timestampEnd, "CultivationPvP_TimeLimit")
  end
  this:Unbind("fci/couple/", OnPlan)
  this:BindRemote(this:GameRequest("fci/couple/"), OnPlan)
end

function OnPlan(result)
  if result == nil then
    return
  end
  m_curCulPlan = result
  local rewardPreview = WU.GetGameDataCache("couple/reward-preview")
  if m_curCulPlan.coupleActorId == 0 then
    if rewardPreview == nil then
      SetNodeStart()
    else
      m_curCulPlan.previewActorId = rewardPreview.actorId
      SetNodeSelect(rewardPreview.actorId, rewardPreview.rewards)
    end
  else
    local score = this:GetData("fci/resource/ResCoupleScore_0") or 0
    local accurateScore = math.max(score, m_curCulPlan.totalCoupleScore)
    this:SetData("fci/resource/ResCoupleScore_0", accurateScore)
    SetNodeCultivation()
  end
end

function OnWindowUninited(window)
  if window.name == "ActorInfo" or window.name == "ActorMain" or window.name == "ActorDecompose" or window.name == "ActorTalentInherit" or window.name == "ActorCultivationBuy" then
    UpdateCulActor()
  end
end

function SetNodeStart()
  SetNodeActive(REF.NodeStart, REF.NodeDecorate)
end

function SetNodeSelect(actorId, rewards)
  SetNodeActive(REF.NodeSelect, REF.NodeDecorate)
  SetActorEmote(actorId, _ENV["$"](REF.NodeActor1))
  REF.SpriteActorEmblem1.UISprite.spriteName = "actor_type_" .. actorId
  REF.SpriteActorNameSelect.UISprite.spriteName = "actor_name_" .. PB.get("ActorConfig", actorId).animRes
  REF.SpriteActorNameSelect.UISprite:MakePixelPerfect()
  for i = 0, #REF.GridRewardsPreview - 1 do
    local reward = rewards[i + 1]
    WU.SetActive(REF.GridRewardsPreview[i]["$"], reward ~= nil)
    if reward then
      REF.GridRewardsPreview[i].WidgetIconSlot["$SetData"](reward.type, reward.id)
    end
  end
end

function SetNodeCultivation()
  SetNodeActive(REF.NodeCultivation)
  REF.LabelTime2.UILabel.text = WU.GetString("CoupleActorCultivation_TimeLimit", ACU.RenderTime2(m_activity.timestampStart, false, false), ACU.RenderTime2(m_activity.timestampEnd, false, false))
  WU.SetActive(REF.SpriteVip, m_curCulPlan.vip)
  WU.SetActive(REF.EffectVip, not m_curCulPlan.vip)
  UpdateCulActor()
  UpdateProgress(this:GetData("fci/resource/ResCoupleScore_0") or 0)
  this:DelayInvokeInFrames(2, CheckAlternative)
end

function UpdateProgress(currentScore)
  if currentScore == nil or m_curCulPlan == nil then
    return
  end
  m_currentScore = currentScore
  WU.TraverseChildren(REF.Rewards, function(go)
    go:SetActive(false)
  end)
  local maxScore = 0
  for i = 1, #m_curCulPlan.coupleRewardInfo do
    if i <= #REF.Rewards then
      local ref = REF.Rewards[i - 1]
      local data = m_curCulPlan.coupleRewardInfo[i]
      WU.SetActive(ref["$"], true)
      ref.Label.UILabel.text = data.coupleScore
      local canReceive = not data.got and currentScore >= data.coupleScore
      WU.SetActive(ref.IconCanReceive, canReceive)
      WU.SetActive(ref.Icon, not canReceive)
      ref.Icon.UISprite.spriteName = fif(data.got, "CustomizedPlan_valentine_hart_3", "CustomizedPlan_valentine_hart_1")
      if maxScore < data.coupleScore then
        maxScore = data.coupleScore
      end
    else
      warning("WlfCoupleActorCultivation", "Rewards count out of bounds")
    end
  end
  local progressVal = currentScore / maxScore
  REF.CultivationProgress.UIProgressBar.value = progressVal
end

function UpdateCulActor()
  local uid = AU.GetHighestLevelActor(m_curCulPlan.coupleActorId)
  m_curActor = this:GetData("fci/actor/" .. uid)
  if m_actorIdDisplayInCultivation ~= m_curActor.id then
    SetActorEmote(m_curActor.id, _ENV["$"](REF.NodeActor2))
    m_actorIdDisplayInCultivation = m_curActor.id
  end
  REF.SpriteQuality.UISprite.spriteName = string.lower(AU.ActorQuality2Tag[m_curActor.quality])
  REF.LabelActorLevel.UILabel.text = WU.GetString("Window_Level", m_curActor.level)
  local reachMaxLevel = m_curActor.level >= AU.GetActorMaxLevel()
  local maxStar = PB.all("Misc"):first().maxStarLevel
  REF.WidgetStarGridL["$SetStar"](m_curActor.star, maxStar - m_curActor.star, true, 2)
  local isMaxStar = maxStar <= m_curActor.star
  if not reachMaxLevel then
    local levelupExp = PB.get("ActorLevelup", m_curActor.level + 1)
    local currentExp = m_curActor.curExp
    REF.NodeExpProgressBar.UIProgressBar.value = currentExp / levelupExp.exp
  else
    REF.NodeExpProgressBar.UIProgressBar.value = 1
  end
end

function CheckAlternative()
  local dontShow = WU.GetGameDataCache("ActorCultivationInheirtBOX")
  if dontShow then
    return
  end
  local actorList = AU.GetActorListById(m_curCulPlan.coupleActorId)
  local _, altActor = table.find(actorList, function(k, v)
    return v.quality > m_curActor.quality
  end)
  if altActor then
    WU.ShowMessageYesNo(WU.GetString("CustomActorCultivation_QualityHint"), function(action, toggleSelect)
      WU.SetGameDataCache("ActorCultivationInheirtBOX", toggleSelect)
      if action == "YES" then
        this:SetData("ActorTalentInherit/Mode", 1)
        this:SetData("Actor/SelectedUid", m_curActor.uid)
        WU.AcquireWindowAsync("ActorTalentInherit")
      end
    end, WU.GetString("ActorCultivation_GoToInherit"), nil, nil, nil, nil, WU.GetString("ActorCultivation_NeverShowAgain"))
  end
end

function SetActorEmote(actorId, ref)
  local actor = PB.get("ActorConfig", actorId)
  local roleId = actor.role
  local signboard = PB.all("Signboard")
  local array = _ENV["!"](signboard):where(function(k, v)
    return v.roleId == roleId and v.type == PB.enum.SignboardType.Emote
  end):toarray()
  table.sort(array, function(a, b)
    return a.BoardOfEmote < b.BoardOfEmote
  end)
  local emote = array[1]
  WU.SetActive(ref.WidgetBoardActor, true)
  WU.SetActive(ref.TextureActor, false)
  this:DelayInvokeInFrames(1, function()
    if ref.WidgetBoardActor.gameObject.activeInHierarchy then
      if emote then
        ref.WidgetBoardActor["$PlayByActorID"](emote.BoardOfEmote, "Gacha")
      else
        ref.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actor.animRes
        WU.SetActive(ref.TextureActor, true)
        WU.SetActive(ref.WidgetBoardActor, false)
      end
    end
  end)
  local portrait = PB.get("ActorPortrait", actorId, 0)
  if portrait and portrait.position[9] then
    local position = portrait.position[9]
    if position.scale and position.scale ~= 0 then
      ref.ActorHolder.transform.localScale = CS.UnityEngine.Vector3.one * position.scale
    end
    ref.ActorHolder.transform.localPosition = CS.UnityEngine.Vector3(position.Xoffset, position.Yoffset, 0)
  end
end

function PlayAnimExp()
  REF.EffectExp.gameObject:SetActive(false)
  REF.EffectExp.gameObject:SetActive(true)
  this:SetData("fci/couple/", this:GetData("fci/couple/"))
end

function OnClickOpen()
  local uid = AU.GetHighestLevelActor(m_curCulPlan.previewActorId)
  if uid == nil or uid == 0 then
    WU.ShowHintText(WU.GetString("Window_CoupleActorCultivation_ActorNotFound"))
    return
  end
  WU.AcquireWindowAsync("CustomActorCultivationMessageBox", function(w)
    _ENV["$"](w)["$$SetActor"](uid, ActivityType)
  end)
end

function OnClickSelect()
  WU.AcquireWindowAsync("CustomActorCultivationSelect", function(ui)
    _ENV["$"](ui)["$$SetType"](ActivityType)
  end)
end

function OnClickStar()
  this:SetData("Actor/SelectedUid", m_curActor.uid)
  WU.AcquireWindowAsync("ActorInfo", function(window)
    _ENV["$"](window)["$$SetSelectedTab"]("TabStar")
    _ENV["$"](window)["$$ShowSwitch"]()
  end)
end

function OnClickLevel()
  this:SetData("Actor/SelectedUid", m_curActor.uid)
  WU.AcquireWindowAsync("ActorInfo", function(window)
    _ENV["$"](window)["$$SetSelectedTab"]("TabCultivation")
    _ENV["$"](window)["$$ShowSwitch"]()
  end)
end

function OnClickReward(i)
  local data = m_curCulPlan.coupleRewardInfo[i]
  if not data.got and m_currentScore >= data.coupleScore then
    RewardGameRequest({
      coupleScore = data.coupleScore
    })
  else
    WU.AcquireWindowAsync("PrizePreview", function(window)
      _ENV["$"](window)["$$SetPrizePreview"]("Couple", {playerRecord = m_currentScore})
    end)
  end
end

function RewardGameRequest(postData)
  this:GameRequest("fci/couple/reward/"):Post(postData, function(resp)
    DBH.ResChange(resp.resChange)
    local _, data = table.find(m_curCulPlan.coupleRewardInfo, function(_, v)
      return v.coupleScore == postData.coupleScore
    end)
    data.got = true
    local numExpItemGot = 0
    local numExpItemUse = 0
    for _, res in ipairs(resp.resChange) do
      if res.baseRes and res.baseRes.type == PB.enum.ResourceType.ResItem then
        local itemConfig = PB.get("ItemInfo", res.baseRes.id)
        if itemConfig and itemConfig.funcType == PB.enum.ItemFuncType.ActorExp then
          if 0 < res.baseRes.countDelta then
            numExpItemGot = numExpItemGot + res.baseRes.countDelta
          end
          if 0 > res.baseRes.countDelta then
            numExpItemUse = numExpItemUse - res.baseRes.countDelta
          end
        end
      end
    end
    if 0 < numExpItemUse then
      WU.ShowRewards(resp.resChange, function()
        this:DelayInvokeInFrames(1, function()
          PlayAnimExp()
        end)
      end)
    elseif 0 < numExpItemGot then
      WU.ShowHintText(WU.GetString("ActorCultivation_ExpOverflow"))
      this:SetData("fci/couple/", this:GetData("fci/couple/"))
    elseif not table.empty(resp.resChange) then
      WU.ShowRewards(resp.resChange)
      this:SetData("fci/couple/", this:GetData("fci/couple/"))
    end
  end)
end
