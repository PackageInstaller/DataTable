local Text = CS.UnityEngine.UI.Text
local TMP_Text = CS.TMPro.TMP_Text
local T_Canvas = typeof(CS.UnityEngine.Canvas)
local KeeperSkillNamePanel = {}
KeeperSkillNamePanel.MainTexId = CS.UnityEngine.Shader.PropertyToID("_Texture1")
KeeperSkillNamePanel.AssetPath = "UI/UI_Battle/UI_Battle_Timeline/Battle_Keeper_Skill_Name_Only.prefab"

function KeeperSkillNamePanel.Preload(poolRoot)
  BattleTimelinedeprecated.Preload(KeeperSkillNamePanel.AssetPath, poolRoot)
end

function KeeperSkillNamePanel.GetBinder()
  return bg.battleScene and bg.battleScene.binder
end

function KeeperSkillNamePanel.Play(skillName, onComplete, abortSignal)
  local timeline = BattleTimelinedeprecated.Get(KeeperSkillNamePanel.AssetPath)
  local binder = KeeperSkillNamePanel.GetBinder()
  if not binder then
    if onComplete then
      onComplete()
    end
    return
  end
  binder:UpdateLocalizedTextAndResouce(timeline.rootNode)
  local uiRes = Battle_Keeper_Skill_Name_OnlyResource(timeline.rootNode)
  local canvas = uiRes.ForegroundCanvas:GetComponent(T_Canvas)
  canvas.worldCamera = UIRootMgr.GetUICamera()
  local textComp = uiRes.Text_Skill_Name:GetComponent(typeof(Text)) or uiRes.Text_Skill_Name:GetComponent(typeof(TMP_Text))
  textComp.text = LT.Text(skillName)
  timeline:Play(function()
    if onComplete then
      onComplete()
    end
  end, nil, abortSignal)
end

return KeeperSkillNamePanel
