local StageInitialStateDetailView, Super = NewClass("StageInitialStateDetailView", BaseView)
StageInitialStateDetailView.uiResCls = UI_Dbgcopy_Popup_VibesResource
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TYPEOF_TextMeshProUGUI = typeof(CS.TMPro.TextMeshProUGUI)
local Type_UIGrabPassRawImage = typeof(CS.UIGrabPassRawImage)
local TagStateTitleBuff = 100
local TagStateDesc = 101
local TitleCellWidth, TitleCellHeight
local CellType = {Title = 1, Desc = 2}
local CellsGameObject = {
  [CellType.Title] = {
    tag = TagStateTitleBuff,
    go = "Root_Title",
    textGo = "Text_Title",
    imageGo = "Image_Feedback"
  },
  [CellType.Desc] = {
    tag = TagStateDesc,
    go = "Text_Introduce_1"
  }
}

function StageInitialStateDetailView:ctor(stageId)
  Super.ctor(self)
  self.stageId = stageId
  self.stateList = {}
  self.frameWaiterGroup = {}
  self:GenStateList()
end

function StageInitialStateDetailView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function StageInitialStateDetailView:OnEnterView()
  Super.OnEnterView(self)
  self.descTmpComp = self.ui.Text_Introduce_1:GetComponent(TYPEOF_TextMeshProUGUI)
  self.descOriSize = self.ui.Text_Introduce_1:GetComponent(TYPEOF_RectTransform).sizeDelta
  self:SetText(self.ui.Text_Resonance_Empty, "")
  self:SetText(self.ui.Text_Hint, LT.Text("DisasterReliefKuroshioTipsDesc"))
  self:_InitStateList()
  self:AddViewComponentOnce(self.ui.UI_Common_Melt_Disaster, UICompStageInitialStateShowItem, self.stageId)
end

function StageInitialStateDetailView:AfterSetRenderTrue()
  if not self.ui or not self.ui.uiNode then
    return
  end
  local comp = self.ui.uiNode:GetComponentInChildren(Type_UIGrabPassRawImage, true)
  if not comp then
    return
  end
  if not comp.GrabPassRenderTexture then
    comp.enabled = false
    comp.enabled = true
  end
end

function StageInitialStateDetailView:_InitStateList()
  for idx, stateCellData in ipairs(self.stateList) do
    self.frameWaiterGroup[idx] = FrameWaiter.OnNextFrame(function()
      local cellType = stateCellData.cellType
      local cellCfg = CellsGameObject[cellType]
      local go = GameObject.Instantiate(self.ui[cellCfg.go], self.ui.Content.transform)
      if cellType == CellType.Title then
        self:_ProcessTitleCellAtIndex(go, stateCellData)
      else
        self:_ProcessDescCellAtIndex(go, stateCellData)
      end
    end, idx)
  end
end

function StageInitialStateDetailView:_ProcessTitleCellAtIndex(cell, data)
  local cellCfg = CellsGameObject[data.cellType]
  local titleTextObj = cell.gameObject.transform:Find(cellCfg.textGo)
  if titleTextObj then
    self:SetText(titleTextObj, data.title)
  end
  local titleImageObj = cell.gameObject.transform:Find(cellCfg.imageGo)
  local titleImage = CommonRes.StageInitialStateTitleFrame.Debuff
  if data.isBuff then
    titleImage = CommonRes.StageInitialStateTitleFrame.Buff
  end
  if titleImageObj then
    self:SetImage(titleImageObj, titleImage)
  end
end

function StageInitialStateDetailView:_GetStateCellSize(_, index)
  local stateCellData = self.stateList[index]
  if stateCellData.cellType == CellType.Title then
    return TitleCellWidth, TitleCellHeight
  end
  local desc = self:_GetStateDesc(stateCellData.stateId) or ""
  self:SetText(self.ui.Text_Introduce_1, desc)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Text_Introduce_1)
  local width, height = self.descOriSize.x, self.descOriSize.y
  if self.descTmpComp then
    self.descTmpComp:ForceMeshUpdate()
    height = self.descTmpComp.preferredHeight
  end
  return width, height
end

function StageInitialStateDetailView:_GetStateDesc(stateId)
  local stateConfig = StateDataUtils.GetConfig(stateId)
  local stateName = LT.Text(stateConfig and stateConfig.Name or "")
  local stateDesc = LT.Text(stateConfig and stateConfig.Desc or "")
  do return string.format, LT.Text("StageInitialStateContent"), stateName end
  return string.format, LT.Text("StageInitialStateContent"), stateName, stateDesc
end

function StageInitialStateDetailView:_ProcessDescCellAtIndex(cell, data)
  cell:SetActive(true)
  self:SetText(cell.gameObject, self:_GetStateDesc(data.stateId))
end

function StageInitialStateDetailView:GenStateCellData(cellType, stateId, isBuff)
  if not cellType then
    return
  end
  local cellData = {cellType = cellType}
  if cellType == CellType.Title then
    local _titleKey = "StageInitialStateTitle"
    if isBuff then
      _titleKey = "StageInitialStateTitle_1"
    end
    cellData.title = LT.Text(_titleKey)
    cellData.isBuff = isBuff
  elseif cellType == CellType.Desc then
    cellData.stateId = stateId
  end
  return cellData
end

function StageInitialStateDetailView:GenStateList()
  self.stateList = {}
  local buffStateList = StageInitialStateModel.Instance:GetPositiveInitialState(self.stageId) or {}
  local debuffStateList = StageInitialStateModel.Instance:GetInitialState(self.stageId) or {}
  if #buffStateList > 0 then
    for _, stateId in ipairs(buffStateList) do
      local stateConfig = StateDataUtils.GetConfig(stateId)
      if not stateConfig then
      else
        table.insert(self.stateList, self:GenStateCellData(CellType.Desc, stateId))
      end
    end
  end
  if #debuffStateList > 0 then
    for _, stateId in ipairs(debuffStateList) do
      local stateConfig = StateDataUtils.GetConfig(stateId)
      if not stateConfig then
      else
        table.insert(self.stateList, self:GenStateCellData(CellType.Desc, stateId))
      end
    end
  end
end

function StageInitialStateDetailView:_RefreshInitStateDetails()
  local initStates = StageInitialStateModel.Instance:GetInitialState(self.stageId)
  local existStates = nil ~= initStates and #initStates > 0
  self.ui.Text_Resonance_Empty:SetActive(not existStates)
  self:SetText(self.ui.Text_Resonance_Empty, "")
  self.ui.ScrollView_Effect:SetActive(existStates)
  if existStates then
    local transformCtx = self.ui.Content.transform
    local ctxCount = transformCtx.childCount
    local stateCount = #initStates
    while ctxCount < stateCount do
      Instantiate(self.ui.Text_Introduce_1, transformCtx)
      ctxCount = ctxCount + 1
    end
    for index = 1, stateCount do
      local uiNode = transformCtx:GetChild(index - 1).gameObject
      uiNode:SetActive(true)
      local stateCfg = DT.State[initStates[index]]
      local stateName = LT.Text(stateCfg and stateCfg.Name or "")
      local stateDesc = LT.Text(stateCfg and stateCfg.Desc or "")
      self:SetText(uiNode, string.format(LT.Text("StageInitialStateContent"), stateName, stateDesc))
    end
    for index = stateCount + 1, ctxCount do
      local uiNode = transformCtx:GetChild(index - 1).gameObject
      uiNode:SetActive(false)
    end
  end
end

function StageInitialStateDetailView:OnExitView()
  for _, waiter in ipairs(self.frameWaiterGroup) do
    FrameWaiter.RemoveWaiter(waiter)
  end
  Super.OnExitView(self)
end

return StageInitialStateDetailView
