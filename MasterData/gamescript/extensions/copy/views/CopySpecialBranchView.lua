local Stage_Comp_Show_Duration = 3.6
local TYPE_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
local CopySpecialBranchView, Super = NewClass("CopySpecialBranchView", BaseView)
CopySpecialBranchView.uiResCls = UI_Chapter_Dream_ViewResource

function CopySpecialBranchView:ctor(_, targetStageGroupTid, stageGroupList)
  Super.ctor(self)
  self._targetStageGroupTid = targetStageGroupTid
  table.sort(stageGroupList, function(a, b)
    local stageGroupCfgA = DT.StageGroup[a]
    local stageGroupCfgB = DT.StageGroup[b]
    return stageGroupCfgA.Sequence < stageGroupCfgB.Sequence
  end)
  self.showStageGroups = stageGroupList
  self:InitViewData()
  self:SetItemComp()
  self:SetCloseAnim()
  RedPointDataUtils.ClearFeatureFirstOpen(cd.FeatureId.SpecialSubplotTab)
end

function CopySpecialBranchView:InitViewData()
  self.showCompList = {}
  self.frameWaiterGroup = {}
  self._initialContentPosX = nil
end

function CopySpecialBranchView:SetItemComp()
  self.itemComp = CopySpecialBranchItem
end

function CopySpecialBranchView:SetCloseAnim()
  self.closeAnim = "UI_Chapter_Dream_View_Close"
end

function CopySpecialBranchView:RegisterEvents()
end

function CopySpecialBranchView:OnEnterView()
  Super.OnEnterView(self)
  self:InitStageGroupList()
  self:InitCurrencyGroup()
  self:_ReqSubplotBranchStageData()
  local contentRT = self.ui.Content.transform
  if not self._initialContentPosX then
    self._initialContentPosX = contentRT.anchoredPosition.x
  else
    contentRT.anchoredPosition = CS.UnityEngine.Vector2(self._initialContentPosX, contentRT.anchoredPosition.y)
  end
  self:JumpToTargetStageGroup()
  self:PlayEnterAnim(System.fn(self, self.OnEnterAnimFinish))
end

function CopySpecialBranchView:InitCurrencyGroup()
  self:BindCurrency(self.ui.Guoup_SmallBranch, DT.Constant.SpecialSubplotCurrencies.Data)
end

function CopySpecialBranchView:InitStageGroupList()
  for idx, stageGroupId in ipairs(self.showStageGroups) do
    local stageGroupCfg = DT.StageGroup[stageGroupId] or {}
    local prefabPath = stageGroupCfg.DailyIcon and stageGroupCfg.DailyIcon[1]
    if not prefabPath then
    else
      local prefab = self:LoadAsset(prefabPath)
      local gameObject = GameObject.Instantiate(prefab, self.ui.Content.transform)
      gameObject.name = gameObject.name:replace("(Clone)", "", true)
      local prefabName = StrUtils.GetPrefabNameFromPath(prefabPath)
      local comp = self:AddViewComponentOnce(gameObject, self.itemComp, {
        resource = UI_Chapter_Item_Dream_01Resource,
        stageGroupId = stageGroupId,
        prefabName = prefabName
      })
      self.showCompList[idx] = comp
    end
  end
end

function CopySpecialBranchView:RefreshOnRendered()
  self:_ReqSubplotBranchStageData()
  self:PlayEnterAnim(System.fn(self, self.OnEnterAnimFinish))
end

function CopySpecialBranchView:_ReqSubplotBranchStageData()
  CopyController.Instance:ReqSubplotBranchStageData(self.showStageGroups, System.fn(self, self._RefreshAllBranchItems))
end

function CopySpecialBranchView:_RefreshAllBranchItems()
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  for _, comp in ipairs(self.showCompList) do
    if comp and comp.RefreshDisplay then
      comp:RefreshDisplay()
    end
  end
end

function CopySpecialBranchView:JumpToTargetStageGroup()
  if not self._targetStageGroupTid then
    return
  end
  for idx, stageGroupId in ipairs(self.showStageGroups or {}) do
    if stageGroupId == self._targetStageGroupTid then
      local comp = self.showCompList[idx]
      if comp and not IsNil(comp.gameObject) then
        local contentRT = self.ui.Content.transform
        local layoutGroup = contentRT:GetComponent(T_HorizontalLayoutGroup)
        if layoutGroup then
          local itemWidth = comp.gameObject.transform.sizeDelta.x
          local spacing = layoutGroup.spacing
          local padLeft = layoutGroup.padding.left
          local itemOffsetInContent = padLeft + idx * itemWidth + (idx - 1) * spacing
          local viewportWidth = contentRT.parent.parent.rect.width
          local centerOffset = contentRT.sizeDelta.x / 2 - viewportWidth / 2
          local targetPosX = self._initialContentPosX - (itemOffsetInContent + centerOffset)
          contentRT.anchoredPosition = CS.UnityEngine.Vector2(targetPosX, contentRT.anchoredPosition.y)
        end
      end
      break
    end
  end
  self._targetStageGroupTid = nil
end

function CopySpecialBranchView:SetRendered(isRendered)
  self:_ClearCloseAnimTimer()
  self:HideListComp()
  if not isRendered then
    self:PlayCloseAnim()
    local closeAnimLen = self:_GetAnimCtr():GetClip(self.closeAnim).length
    self.closeAnimTimer = self:BindTimer(closeAnimLen, 0, nil, function()
      Super.SetRendered(self, isRendered)
    end)
  else
    Super.SetRendered(self, isRendered)
  end
end

function CopySpecialBranchView:OnEnterAnimFinish()
  self:PlayLoopingAnim()
end

function CopySpecialBranchView:HideListComp()
  for idx, comp in ipairs(self.showCompList) do
    comp:Hide()
  end
end

function CopySpecialBranchView:PlayEnterAnim(callback)
  self:_PlayUIAnim("UI_Chapter_Dream_View_Open", callback)
  self:PlayListAnim()
end

function CopySpecialBranchView:PlayCloseAnim(callback)
  self:_PlayUIAnim(self.closeAnim, callback)
end

function CopySpecialBranchView:PlayLoopingAnim(callback)
  self:_PlayUIAnim("UI_Chapter_Dream_View_Loop", callback, true)
end

function CopySpecialBranchView:PlayListAnim()
  self:_ClearWaiterTimer()
  self.listAnimTimer = self:BindTimer(0.1, 0, nil, function()
    for idx, comp in ipairs(self.showCompList) do
      self.frameWaiterGroup[idx] = FrameWaiter.OnNextFrame(function()
        comp:PlayEnterAnim()
      end, idx * Stage_Comp_Show_Duration)
    end
  end)
end

function CopySpecialBranchView:_PlayUIAnim(clipName, callback, isLoop)
  if not clipName or type(clipName) ~= "string" then
    return
  end
  self:StopPlayableGraph()
  if isLoop then
    self:_GetAnimCtr():LoopPlayState(clipName)
  else
    self:_GetAnimCtr():PlayState(clipName, function()
      if callback then
        callback()
      end
    end)
  end
end

function CopySpecialBranchView:StopPlayableGraph()
  self:_GetAnimCtr():StopPlayableGraph()
  for idx, comp in ipairs(self.showCompList) do
    comp:StopPlayableGraph()
  end
end

function CopySpecialBranchView:OnExitView()
  self:_ClearWaiterTimer()
  Super.OnExitView(self)
end

function CopySpecialBranchView:_ClearWaiterTimer()
  for _, waiter in ipairs(self.frameWaiterGroup) do
    FrameWaiter.RemoveWaiter(waiter)
  end
  self:_ClearListAnimTimer()
  self:_ClearCloseAnimTimer()
end

function CopySpecialBranchView:_ClearCloseAnimTimer()
  if self.closeAnimTimer then
    self:StopTimer(self.closeAnimTimer)
    self.closeAnimTimer = nil
  end
end

function CopySpecialBranchView:_ClearListAnimTimer()
  if self.listAnimTimer then
    self:StopTimer(self.listAnimTimer)
    self.listAnimTimer = nil
  end
end

function CopySpecialBranchView:_GetAnimCtr()
  if not self.uiAnimCtr then
    self.uiAnimCtr = self.ui.uiNode:GetComponent(TYPE_UIAnimationController)
  end
  return self.uiAnimCtr
end

return CopySpecialBranchView
