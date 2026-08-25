local Text = CS.UnityEngine.UI.Text
local TMP_Text = CS.TMPro.TMP_Text
local Canvas = CS.UnityEngine.Canvas
local BattleAwakerUltiSkillPainting = {}
BattleAwakerUltiSkillPainting.MainTexId = CS.UnityEngine.Shader.PropertyToID("_Texture1")
BattleAwakerUltiSkillPainting.AssetPath = "UI/UI_Battle/UI_Battle_Timeline/Battle_UltiSkill_Painting.prefab"
local taweiAssetPath = "UI/UI_Battle/UI_Battle_Timeline/Battle_UltiSkill_Painting_C15.prefab"

function BattleAwakerUltiSkillPainting.Preload(poolRoot)
  BattleTimelinedeprecated.Preload(BattleAwakerUltiSkillPainting.AssetPath, poolRoot)
end

function BattleAwakerUltiSkillPainting.GetBinder()
  if bg.battleScene then
    do return bg.battleScene.binder.createChild end
    return bg.battleScene.binder.createChild, bg.battleScene.binder
  end
end

function BattleAwakerUltiSkillPainting.GetAssetPath(awakerTid)
  return 54116 == awakerTid and taweiAssetPath or BattleAwakerUltiSkillPainting.AssetPath
end

function BattleAwakerUltiSkillPainting.Play(awakerClient, skillConfig, onComplete, abortSignal)
  local assetPath = BattleAwakerUltiSkillPainting.GetAssetPath(awakerClient.tid)
  local timeline = BattleTimelinedeprecated.Get(assetPath)
  local binder = BattleAwakerUltiSkillPainting.GetBinder()
  binder:UpdateLocalizedTextAndResouce(timeline.rootNode)
  local uiRes = Battle_UltiSkill_PaintingResource(timeline.rootNode)
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(awakerClient)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(awakerClient)
  local skillName = BattleSkillUtils.GetSkillName(skillConfig, breakSkillLevel, potencyLevel)
  local textComp = uiRes.Text_Skill_Name:GetComponent(typeof(Text)) or uiRes.Text_Skill_Name:GetComponent(typeof(TMP_Text))
  textComp.text = skillName
  local uniqStatePrefab = BattleAwakerUltiSkillPainting.GetStateUniqPainting(awakerClient)
  local resNum = bg.battleDataCenter:GetAwakerResNum(awakerClient.tid)
  local com = binder:BindComponent(AwakerPortraitComp(uiRes.Container_Awaker, nil, resNum, nil, nil, {prefabPath = uniqStatePrefab}))
  com:ChangeMaterialMask(CommonRes.UIPortraitMask.UltiSkillMask)
  com:SetUseScreenSpaceMask(true)
  com:SetDissolveKeyOn(false)
  com:SetAlpha(1)
  local bgCanvas = uiRes.BackgroundCanvas:GetComponent(typeof(Canvas))
  bgCanvas.worldCamera = bg.mainCamera
  local fgCanvas = uiRes.ForegroundCanvas:GetComponent(typeof(Canvas))
  fgCanvas.worldCamera = bg.uiCamera
  fgCanvas.sortingLayerID = 0
  fgCanvas.sortingOrder = 0
  timeline:Play(function()
    binder:Unbind()
    if onComplete then
      onComplete()
    end
  end, nil, abortSignal)
end

function BattleAwakerUltiSkillPainting.GetStateUniqPainting(awakerClient)
  local uniqList = bg.DT.GetOriginalConstant("Awaker_EX_24_2")
  for stateId, paintingPrefab in table.iteraDouble(uniqList) do
    local stateList = bg.battleDataCenter.stateData:GetStateListByOwnerAndStateId(awakerClient.uid, stateId)
    if #(stateList or {}) > 0 then
      return paintingPrefab
    end
  end
end

function BattleAwakerUltiSkillPainting.PlayByAwakerId(awakerId, skillName, onComplete, abortSignal)
  local assetPath = BattleAwakerUltiSkillPainting.GetAssetPath(awakerId)
  local timeline = BattleTimelinedeprecated.Get(assetPath)
  local uiRes = Battle_UltiSkill_PaintingResource(timeline.rootNode)
  local textComp = uiRes.Text_Skill_Name:GetComponent(typeof(Text)) or uiRes.Text_Skill_Name:GetComponent(typeof(TMP_Text))
  textComp.text = skillName or ""
  local binder = BattleAwakerUltiSkillPainting.GetBinder()
  local resNum = bg.battleDataCenter:GetAwakerResNum(awakerId)
  local com = binder:BindComponent(AwakerPortraitComp(uiRes.Container_Awaker, nil, resNum))
  com:ChangeMaterialMask(CommonRes.UIPortraitMask.UltiSkillMask)
  com:SetUseScreenSpaceMask(true)
  local bgCanvas = uiRes.BackgroundCanvas:GetComponent(typeof(Canvas))
  bgCanvas.worldCamera = bg.mainCamera
  local fgCanvas = uiRes.ForegroundCanvas:GetComponent(typeof(Canvas))
  fgCanvas.worldCamera = bg.uiCamera
  fgCanvas.sortingLayerID = 0
  fgCanvas.sortingOrder = 0
  timeline:Play(function()
    binder:Unbind()
    if onComplete then
      onComplete()
    end
  end, nil, abortSignal)
end

return BattleAwakerUltiSkillPainting
