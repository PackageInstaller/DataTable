local Text = CS.UnityEngine.UI.Text
local TMP_Text = CS.TMPro.TMP_Text
local Canvas = CS.UnityEngine.Canvas
local BattleAwakerSuperUltiSkillPainting = {}
BattleAwakerSuperUltiSkillPainting.AssetPath = "UI/UI_Battle/UI_Battle_Timeline/Battle_UltiSkill_Painting_EX.prefab"
BattleAwakerSuperUltiSkillPainting.PortraitTimelineAssetPath = "TimelineRoot/AwakerPortrait/Battle_UltiSkill_Painting_EX_Common/Battle_UltiSkill_Painting_EX_Common.prefab"

function BattleAwakerSuperUltiSkillPainting.Preload(poolRoot)
  BattleTimelinedeprecated.Preload(BattleAwakerSuperUltiSkillPainting.AssetPath, poolRoot)
end

function BattleAwakerSuperUltiSkillPainting.GetBinder()
  if bg.battleScene then
    do return bg.battleScene.binder.createChild end
    return bg.battleScene.binder.createChild, bg.battleScene.binder
  end
end

function BattleAwakerSuperUltiSkillPainting.Play(awakerClient, skillConfig, onComplete, abortSignal)
  local skillTimelinePlayer = awakerClient.timelinePlayer
  local timeline = BattleTimelinedeprecated.Get(BattleAwakerSuperUltiSkillPainting.AssetPath)
  local binder = BattleAwakerSuperUltiSkillPainting.GetBinder()
  binder:UpdateLocalizedTextAndResouce(timeline.rootNode)
  local uiRes = Battle_UltiSkill_Painting_EXResource(timeline.rootNode)
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(awakerClient)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(awakerClient)
  local skillName = BattleSkillUtils.GetSkillName(skillConfig, breakSkillLevel, potencyLevel)
  local info = AwakerDataUtils.GetSuperUltiSkillInfo(awakerClient.tid)
  if info and info.name then
    skillName = LT.Text(info.name)
  end
  local textComp = uiRes.Text_Skill_Name:GetComponent(typeof(Text)) or uiRes.Text_Skill_Name:GetComponent(typeof(TMP_Text))
  textComp.text = skillName
  local textUltiSkillComp = uiRes.Text_UltiSkill:GetComponent(typeof(TMP_Text))
  textUltiSkillComp.text = LT.Text("SuperUltlSkillName")
  local skillNameGradientColor = AddLuaCompOnce(uiRes.Text_Skill_Name, TMPGradientColor)
  skillNameGradientColor:SetGradientZone(uiRes.Skill_Name_Zone.transform)
  local UltiSkillGradientColor = AddLuaCompOnce(uiRes.Text_UltiSkill, TMPGradientColor)
  UltiSkillGradientColor:SetGradientZone(uiRes.UltiSkillZone.transform)
  local uniqStatePrefab = BattleAwakerSuperUltiSkillPainting.GetStateUniqPainting(awakerClient)
  local resNum = bg.battleDataCenter:GetAwakerResNum(awakerClient.tid)
  local com = binder:BindComponent(AwakerPortraitComp(uiRes.Container_Awaker, nil, resNum, nil, nil, {prefabPath = uniqStatePrefab}))
  com:SetUseScreenSpaceMask(true)
  com:SetDissolveKeyOn(true)
  com:SetAlpha(0)
  local fgCanvas = uiRes.ForegroundCanvas:GetComponent(typeof(Canvas))
  fgCanvas.worldCamera = bg.uiCamera
  fgCanvas.sortingLayerID = 0
  fgCanvas.sortingOrder = 1
  local portraitTimeline = TimelinePlayer(com.portraitGo)
  local portraitTimelineCfg = TimelineConfig()
  portraitTimelineCfg.assetPath = BattleAwakerSuperUltiSkillPainting.PortraitTimelineAssetPath
  
  function portraitTimelineCfg.onEvent(eventId, eventParam)
    if eventId == rc.TimeLineEvent.PauseSkill then
      if skillTimelinePlayer and skillTimelinePlayer.amPlayer then
        skillTimelinePlayer.amPlayer.enabled = false
        skillTimelinePlayer:PauseVideoPlayers()
      end
      if bg.battleRender and bg.battleRender.recordMgr then
        bg.battleRender.recordMgr:SetRecordState(bc.BattleRecordPlayState.Pause)
      end
    elseif eventId == rc.TimeLineEvent.ResumeSkill then
      if skillTimelinePlayer and skillTimelinePlayer.amPlayer then
        skillTimelinePlayer.amPlayer.enabled = true
        skillTimelinePlayer:ResumeVideoPlayers()
      end
      if bg.battleRender and bg.battleRender.recordMgr then
        bg.battleRender.recordMgr:SetRecordState(bc.BattleRecordPlayState.Play)
      end
    end
  end
  
  portraitTimeline:SetLoadResSync(true)
  portraitTimeline:Play(portraitTimelineCfg)
  timeline:Play(function()
    binder:Unbind()
    if onComplete then
      onComplete()
    end
    if portraitTimeline then
      portraitTimeline:Dispose()
    end
  end, nil, abortSignal)
end

function BattleAwakerSuperUltiSkillPainting.GetStateUniqPainting(awakerClient)
  local uniqList = bg.DT.GetOriginalConstant("Awaker_EX_24_2")
  for stateId, paintingPrefab in table.iteraDouble(uniqList) do
    local stateList = bg.battleDataCenter.stateData:GetStateListByOwnerAndStateId(awakerClient.uid, stateId)
    if #(stateList or {}) > 0 then
      return paintingPrefab
    end
  end
end

return BattleAwakerSuperUltiSkillPainting
