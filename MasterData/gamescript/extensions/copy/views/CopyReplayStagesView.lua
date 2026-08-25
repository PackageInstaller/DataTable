local CopyReplayStagesView, Super = NewClass("CopyReplayStagesView", BaseView)
CopyReplayStagesView.uiResCls = "UI/UI_Dungeous/UI_Dungeous_Prefab/UI_Dungeons_Tip_ReplayRecord.prefab"

function CopyReplayStagesView:ctor(stagesList, isTop, positionNode)
  Super.ctor(self)
  self.stagesList = stagesList
  self.isTop = isTop
  self.positionNode = positionNode
  print("CopyReplayStagesView stageList", table.tostring(stagesList))
end

function CopyReplayStagesView:OnBuildView()
  Super.OnBuildView(self)
  self.stageNodes = {
    self.ui.UI_Dungeons_Item_ReplayRecord
  }
end

function CopyReplayStagesView:RegisterEvents()
  self:AddUICustomInputlistener(self.ui.ScrollView, function(hover)
    if not hover then
      self:Close()
    end
  end)
end

function CopyReplayStagesView:OnEnterView()
  Super.OnEnterView(self)
  if self.isTop then
    self.ui.ScrollView.transform.pivot = CS.UnityEngine.Vector2(0, 1)
  else
    self.ui.ScrollView.transform.pivot = CS.UnityEngine.Vector2(0, 0)
  end
  self:_UpdatePosition()
  self:_RefreshStagesList()
  LateUpdateBeat.Instance:Add(self._UpdatePosition, self)
end

function CopyReplayStagesView:OnExitView()
  LateUpdateBeat.Instance:Remove(self._UpdatePosition, self)
  Super.OnExitView(self)
end

function CopyReplayStagesView:_UpdatePosition()
  self.ui.ScrollView.transform.position = self.positionNode.transform.position
end

function CopyReplayStagesView:_RefreshStagesList()
  local contentHeight = 0
  local space = 10
  local offsetX = 22
  local offsetY = 18
  local childSizeY = self.ui.UI_Dungeons_Item_ReplayRecord.transform.sizeDelta.y
  local contentSizeDelta = self.ui.ScrollView.transform.sizeDelta
  local cnt = #self.stagesList
  local childCount = #self.stageNodes
  local ct_transform = self.ui.Content.transform
  while cnt > childCount do
    local go = Instantiate(self.stageNodes[1].gameObject, ct_transform)
    childCount = childCount + 1
    table.insert(self.stageNodes, go)
  end
  contentHeight = contentHeight + offsetY
  for i = 1, cnt do
    local go = self.stageNodes[i].gameObject
    go:SetActive(true)
    local stageInfo = self.stagesList[i]
    local ui = UIBaseResource(go)
    local stageCfg = DT.Stage[stageInfo.stageId]
    if stageInfo.isExtra then
      local textExtra = LT.Text("AbyssChallengeHistoricalRecord")
      self:SetText(ui.Text_ReplayRecord, LT.Text(stageCfg.Name) .. textExtra)
    else
      self:SetText(ui.Text_ReplayRecord, LT.Text(stageCfg.Name))
    end
    self:AddButtonClickListener(ui.Btn_Click, function()
      CopyRecordsController.Instance:ReqPVEBattleRecord(self.stagesList[i].battleUuid)
      self:Close()
    end)
    if 1 ~= i then
      contentHeight = contentHeight + space
    end
    CS.Framework.TransformUtil.SetAnchoredPos(go.transform, offsetX, contentHeight * -1)
    contentHeight = contentHeight + childSizeY
  end
  contentHeight = contentHeight + offsetY
  for i = cnt + 1, childCount do
    local go = self.stageNodes[i].gameObject
    go:SetActive(false)
  end
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = contentSizeDelta.x
  Vector2.y = contentHeight
  self.ui.Content.transform.sizeDelta = Vector2
end

return CopyReplayStagesView
