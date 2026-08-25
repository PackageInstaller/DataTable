local GuidePanelUtils, Super = System.NewClass("GuidePanelUtils")
local DeepFindChild = CS.Framework.GameObjectUtil.DeepFindChild
GuidePanelUtils._warnedMissingNodeNames = {}

function GuidePanelUtils.IsViewAtTop(guideViewName)
  local panel = NewbieGuideManager.Instance:GetRegisterNewbiePanel(guideViewName)
  if panel then
    return panel
  end
  if GuidePanelUtils[guideViewName] then
    do return end
    return GuidePanelUtils[guideViewName], guideViewName
  end
  do return GuidePanelUtils._IsViewAtTop end
  return GuidePanelUtils._IsViewAtTop, guideViewName
end

function GuidePanelUtils._IsViewAtTop(viewUrl)
  viewUrl = Urls[viewUrl] or viewUrl
  local view = UIManager.Instance:GetWindow(viewUrl)
  if not view or not view.isRendering then
    return false
  end
  return not UIManager.Instance:HaveForwardPanel(view)
end

function GuidePanelUtils.GuidePanel_NormalSummon()
  if not GuidePanelUtils._IsViewAtTop(Urls.SummonPanel) then
    return false
  end
  local summonPanel = UIManager.Instance:GetWindow(Urls.SummonPanel)
  if not summonPanel then
    return false
  end
  return true
end

function GuidePanelUtils.GuidePanel_SummonResult()
  do return GuidePanelUtils._IsViewAtTop end
  return GuidePanelUtils._IsViewAtTop, Urls.SummonResultPanel
end

function GuidePanelUtils.IsNodeShow(guideNodeName)
  local nodeGo = GuidePanelUtils.GetNodeGo(guideNodeName)
  return nodeGo and nodeGo.activeInHierarchy
end

function GuidePanelUtils.GetNodeGo(guideNodeName)
  if string.find(guideNodeName, "GuideGo_", 0, true) then
    local nodeGo = NewbieGuideManager.Instance:GetRegisterGameObject(guideNodeName)
    return nodeGo
  end
  if GuidePanelUtils[guideNodeName] then
    do return end
    return GuidePanelUtils[guideNodeName], NewbieGuideManager.Instance, guideNodeName, 0, true, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local uiList = string.split(guideNodeName, ".")
  local rootName = uiList[1]
  local rootGo
  if "SceneRoot" == rootName then
    rootGo = UIRootMgr.GetSceneRoot()
  else
    rootGo = UIRootMgr.GetUIRoot()
  end
  local baseRoot = rootGo.transform
  local curTransform = baseRoot
  for _, uiName in ipairs(uiList) do
    if "SceneRoot" == uiName then
    else
      curTransform = DeepFindChild(curTransform, uiName)
      if not curTransform then
        if not GuidePanelUtils._warnedMissingNodeNames[uiName] then
          GuidePanelUtils._warnedMissingNodeNames[uiName] = true
          Logger.Warn("[Guide]找不到组件:" .. uiName)
        end
        return
      end
    end
  end
  return curTransform.gameObject
end

return GuidePanelUtils
