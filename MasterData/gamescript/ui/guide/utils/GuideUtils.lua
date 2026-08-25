local CSRectTransform = typeof(CS.UnityEngine.RectTransform)
local Vector3 = CS.UnityEngine.Vector3
local Button = CS.UnityEngine.UI.Button
local Z1Button = CS.Z1Client.Z1Button
local GuideUtils, Super = System.NewClass("GuideUtils")

function GuideUtils.GetCurGuideCfg()
  local guideId = DataCenter.guideData.guideId
  local subGuideId = DataCenter.guideData.subGuideId
  local cfg = DT.GuideConfig[guideId]
  if cfg then
    return cfg.data_list[subGuideId]
  end
end

function GuideUtils.GetUIWorldRect(transform)
  local rectTransform = transform.gameObject:GetComponent(CSRectTransform)
  local rect = rectTransform.rect
  local center = rect.center
  local centerPos = transform:TransformPoint(Vector3(center.x, center.y, 0))
  return {
    centerPos = centerPos,
    width = rect.width,
    height = rect.height,
    lossyScale = transform.lossyScale
  }
end

function GuideUtils.GetRectCommon(uiPath)
  local nodeGo = GuidePanelUtils.GetNodeGo(uiPath)
  if nodeGo then
    do return GuideUtils.GetUIWorldRect end
    return GuideUtils.GetUIWorldRect, nodeGo.transform
  end
end

function GuideUtils.GetRect_GuideGearItem()
  do return GuideManager.Instance.GetGearRect end
  return GuideManager.Instance.GetGearRect, GuideManager.Instance
end

function GuideUtils.GetRect_GuideBattleAwakerHead()
  if bg.battlePanel then
    local ultiSkillPanel = bg.battlePanel.ultiSkillPanel
    local child = ultiSkillPanel:GetHead(DT.GetConstant("GuideAwaker"))
    do return GuideUtils.GetUIWorldRect, child:GetComponent(CSRectTransform) end
    return GuideUtils.GetUIWorldRect, child:GetComponent(CSRectTransform)
  end
end

function GuideUtils.Action_GuideForbidBattleEnd()
  if bg.battlePanel then
    local btnObj = bg.battlePanel.ui.Btn_Battle_EndOfTurn:GetComponent(typeof(Z1Button))
    if nil == btnObj then
      btnObj = bg.battlePanel.ui.Btn_Battle_EndOfTurn:GetComponent(typeof(Button))
    end
    btnObj.interactable = false
  end
end

function GuideUtils.Action_GuideResumeBattleEnd()
  if bg.battlePanel then
    local btnObj = bg.battlePanel.ui.Btn_Battle_EndOfTurn:GetComponent(typeof(Z1Button))
    if nil == btnObj then
      btnObj = bg.battlePanel.ui.Btn_Battle_EndOfTurn:GetComponent(typeof(Button))
    end
    btnObj.interactable = true
  end
end

return GuideUtils
