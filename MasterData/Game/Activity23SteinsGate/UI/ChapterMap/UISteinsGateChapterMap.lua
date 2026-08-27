local base = UIBaseWindow
local UISteinsGateChapterMap = class("UISteinsGateChapterMap", base)
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_UIMnager = CS.UIManager.Instance
local CS_DOTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_LoopType = CS.DG.Tweening.LoopType
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local UISteinsGateChapterMapHelper = require("Game.Activity23SteinsGate.UI.ChapterMap.UISteinsGateChapterMapHelper")
local UINSGChapterMapDownNode = require("Game.Activity23SteinsGate.UI.ChapterMap.DownNode.UINSGChapterMapDownNode")
local UINSGChapterMapStoryNode = require("Game.Activity23SteinsGate.UI.ChapterMap.Node.UINSGChapterMapStoryNode")
local UINSGChapterMapStageNode = require("Game.Activity23SteinsGate.UI.ChapterMap.Node.UINSGChapterMapStageNode")
local UINSGChapterMapEndDeco = require("Game.Activity23SteinsGate.UI.ChapterMap.Node.UINSGChapterMapEndDeco")
local UINSGChapterMapLineNode = require("Game.Activity23SteinsGate.UI.ChapterMap.Node.UINSGChapterMapLineNode")
local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")

function UISteinsGateChapterMap:OnInit()
  self.__lineDic = {}
  self.__lineDecoDic = {}
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.__CloseDetail)
  self.linePool = UIItemPool.New(UINSGChapterMapLineNode, self.ui.line, false)
  self.lineEndDecoPool = UIItemPool.New(UINSGChapterMapEndDeco, self.ui.lineEndDeco, false)
  self.stagePool = UIItemPool.New(UINSGChapterMapStageNode, self.ui.questItem, false)
  self.storyPool = UIItemPool.New(UINSGChapterMapStoryNode, self.ui.storyItem, false)
  self.arrowPool = UIItemPool.New(UIBaseNode, self.ui.arrowRight, false)
  self.downNode = UINSGChapterMapDownNode.New()
  self.downNode:Init(self.ui.obj_downNode)
  self.__Roate90 = Quaternion.Euler(0, 0, 90)
  self.__Roate270 = Quaternion.Euler(0, 0, -90)
  local BackgroundStretchSize = UIManager.BackgroundStretchSize
  self.__notchSize = BackgroundStretchSize.x * (CS_UIMnager.CurNotchValue / 100)
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__onFingerInactive = BindCallback(self, self.OnFingerInactive)
  self.__onClickNode = BindCallback(self, self.__OnClickNode)
  self.__AfterClickOutRewardPickedBind = BindCallback(self, self.AfterClickOutRewardPicked)
  CS_LeanTouch.OnGesture("+", self.__onGesture)
  CS_LeanTouch.OnFingerInactive("+", self.__onFingerInactive)
  self.ui.map.onValueChanged:AddListener(BindCallback(self, self.OnMapRollValueChange))
  UIUtil.SetTopStatus(self, self.Close)
  self.canOpenNewStoryLineAnim = false
  self.resloader = CS.ResLoader.Create()
  MsgCenter:AddListener(eMsgEventId.StageOutPickReward, self.__AfterClickOutRewardPickedBind)
end

function UISteinsGateChapterMap:InitAct21SGChaperMap(sgData, closeCallback, afteOpenFunc)
  self.sgData = sgData
  self.sgStoryData = sgData:GetSteinsGateStotyData()
  self.closeCallback = closeCallback
  self.downNode:InitSGChapterMapDownNode(self)
  self:TryReGenAll()
  self:__TryPlayFoceSelectDiff(function()
    self:__FocusFarrestCouldBattleNode(0)
    if afteOpenFunc ~= nil then
      afteOpenFunc()
    end
    self:PlaySGMapNodeItemUnlockedAnim()
  end)
end

function UISteinsGateChapterMap:__GenLines()
  local lineList = self.sgStoryData:Act23Gs_GetLineData()
  local maxLength = UISteinsGateChapterMapHelper.GetCurMaxLineSize(self.sgStoryData)
  maxLength = math.max(self.ui.viewport.rect.width, maxLength)
  self.ui.content.sizeDelta = Vector2.Temp(maxLength, self.ui.content.sizeDelta.y)
  local headShirnk = UISteinsGateChapterMapHelper.GetContentLeftNeedShirnkSize(self.sgStoryData)
  local padding = self.ui.layout_content.padding
  padding.left = -headShirnk
  self.ui.layout_content.padding = padding
  local curLineNum = 0
  self.linePool:HideAll()
  self.lineEndDecoPool:HideAll()
  for lineIndex, lineData in ipairs(lineList) do
    if lineData:Act23GSLN_GetIsLineCouldShow() then
      local item = self.linePool:GetOne()
      item.transform.sizeDelta = Vector2.Temp(maxLength, item.transform.sizeDelta.y)
      self.__lineDic[lineIndex] = item
      local decoItem = self.lineEndDecoPool:GetOne()
      decoItem:RefreshAct23SGDecoNum(lineData:Act23GSLN_Get())
      self.__lineDecoDic[lineIndex] = decoItem
      curLineNum = curLineNum + 1
    end
  end
  local lineHeight = 264
  local lineSize = (5 * lineHeight - curLineNum * lineHeight) / 2
  if 0 < lineSize then
    padding.top = lineSize
    padding.bottom = lineSize
    self.ui.layout_content.padding = padding
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.content)
  self:__FitLineEndDeco()
end

function UISteinsGateChapterMap:__GenItems()
  local nodeDic = self.sgStoryData:Act23SG_GetAllNodeData()
  self.stagePool:HideAll()
  self.storyPool:HideAll()
  self.arrowPool:HideAll()
  for sNodeId, nodeData in pairs(nodeDic) do
    if nodeData:Act23GSSN_GetIsChoulShow() then
      local lineIndex = nodeData:Act23GSSN_GetLineIndex()
      local xPos = UISteinsGateChapterMapHelper.GetNodePos(nodeData)
      local nodeItem
      if lineIndex == -1 then
        nodeItem = self.storyPool:GetOne(true)
        local preNodeId = nodeData:Act23GSSN_GetPreNodeId()
        local preNodeData = self.sgStoryData:Act23SG_GetNodeData(preNodeId)
        if preNodeData == nil then
          error("sp end node not have pre node")
          return
        end
        local preLineIndex = preNodeData:Act23GSSN_GetLineIndex()
        local lineItem = self.__lineDic[preLineIndex]
        nodeItem.transform:SetParent(lineItem.transform)
        nodeItem.transform.localPosition = Vector2.Temp(xPos, -lineItem.transform.sizeDelta.y)
      else
        if nodeData:Act23GSSN_GetIsBattleNode() then
          nodeItem = self.stagePool:GetOne(true)
        else
          nodeItem = self.storyPool:GetOne(true)
        end
        local lineItem = self.__lineDic[lineIndex]
        if lineItem ~= nil then
          nodeItem.transform:SetParent(lineItem.transform)
          nodeItem.transform.localPosition = Vector2.Temp(xPos, -lineItem.transform.sizeDelta.y / 2)
        end
      end
      nodeItem:InitNSGChapterMapNode(self.sgStoryData, nodeData)
      nodeItem:Act23SGSetClickCallback(self.__onClickNode)
      self:__TryGenConnect(nodeData)
    end
  end
end

function UISteinsGateChapterMap:__TryGenConnect(nodeData)
  local nextNodeId = nodeData:Act23GSSN_GetNextNodeId()
  if nextNodeId == nil or nextNodeId == 0 then
    return
  end
  local nextNodeData = self.sgStoryData:Act23SG_GetNodeData(nextNodeId)
  if nextNodeData == nil then
    return
  end
  if not nextNodeData:Act23GSSN_GetIsChoulShow() then
    return
  end
  local lineIndex = nodeData:Act23GSSN_GetLineIndex()
  local gridIndex = nodeData:Act23GSSN_GetGridIndex()
  local nextLineIndex = nextNodeData:Act23GSSN_GetLineIndex()
  local nextGridIndex = nextNodeData:Act23GSSN_GetGridIndex()
  local lineItem = self.__lineDic[lineIndex]
  if nextLineIndex == -1 then
    self.ui.arrowEx1.transform:SetParent(lineItem.transform)
    local xPos = UISteinsGateChapterMapHelper.GetNodePos(nodeData)
    local yPos = -(lineItem.transform.sizeDelta.y + 6)
    self.ui.arrowEx1.transform.localPosition = Vector2.Temp(xPos, yPos)
    return
  end
  if lineIndex == nextLineIndex and nextGridIndex - gridIndex == 1 then
    local arrowItem = self.arrowPool:GetOne()
    arrowItem.transform:SetParent(lineItem.transform)
    local xPos = UISteinsGateChapterMapHelper.GetNodePos(nodeData)
    local nextXPos = UISteinsGateChapterMapHelper.GetNodePos(nextNodeData)
    arrowItem.transform.localPosition = Vector2.Temp((xPos + nextXPos) / 2, -lineItem.transform.sizeDelta.y / 2)
  elseif gridIndex == nextGridIndex and math.abs(nextLineIndex - lineIndex) == 1 then
    local arrowItem = self.arrowPool:GetOne()
    arrowItem.transform:SetParent(lineItem.transform)
    local xPos = UISteinsGateChapterMapHelper.GetNodePos(nodeData)
    local yPos = -(lineItem.transform.sizeDelta.y + 6)
    if lineIndex < nextLineIndex then
      arrowItem.transform.localRotation = self.__Roate270
      arrowItem.transform.localPosition = Vector2.Temp(xPos, yPos)
    else
      arrowItem.transform.localRotation = self.__Roate90
      arrowItem.transform.localPosition = Vector2.Temp(xPos, 0)
    end
  elseif 2 <= math.abs(gridIndex - nextGridIndex) then
    self.ui.arrowEx2.transform:SetParent(lineItem.transform)
    local xPos = UISteinsGateChapterMapHelper.GetNodePos(nodeData)
    local nextXPos = UISteinsGateChapterMapHelper.GetNodePos(nextNodeData)
    local yPos = -lineItem.transform.sizeDelta.y / 2
    self.ui.arrowEx2.transform.localPosition = Vector2.Temp((xPos + nextXPos) / 2, yPos)
    self.ui.arrowEx2.transform.sizeDelta = Vector2.New(nextXPos - xPos, self.ui.arrowEx2.transform.sizeDelta.y)
  end
end

function UISteinsGateChapterMap:__RefreCurNode()
  self.curNodeData = self.sgStoryData:GetCurNode()
  local lineIndex = self.curNodeData:Act23GSSN_GetLineIndex()
  if lineIndex == -1 then
    self.downNode:RefreshWorldLine(ConfigData.activity_23steinsgate_line[0].digit)
  else
    local lineData = self.sgStoryData:Act23SG_GetLineData(lineIndex)
    if lineData ~= nil then
      self.downNode:RefreshWorldLine(lineData:Act23GSLN_Get())
    end
  end
end

function UISteinsGateChapterMap:RefreshWinTween()
  self:__PlayUITween(EUIAnimaType.SlowScaleUp)
end

function UISteinsGateChapterMap:__RefreshDiffDeco()
  local diff = self.sgStoryData:Act23Gs_GetDiffIndex()
  local isHard = 1 < diff
  self.ui.img_BoardNormal:SetActive(not isHard)
  self.ui.img_BoardHard:SetActive(isHard)
  self.ui.img_MaskHard:SetActive(isHard)
end

function UISteinsGateChapterMap:__RefreshDiffNodeChange()
  for _, nodeItem in pairs(self.stagePool.listItem) do
    nodeItem:SGNode_RefreshNodeState()
  end
  if self.__seletedNodeId ~= nil then
    self:__SelectNode(self.__seletedNodeId, 0)
  end
end

function UISteinsGateChapterMap:__FocusFarrestCouldBattleNode(costTime)
  if costTime == nil then
    costTime = 0
  end
  local diff = self.sgStoryData:Act23Gs_GetDiffIndex()
  local nodeData = self.sgStoryData:GetCurNeedBattleNode(diff)
  if nodeData == nil then
    self:__FocusNode(self.curNodeData:Act23GSSN_GetNodeID(), costTime)
    return
  end
  self:__FocusNode(nodeData:Act23GSSN_GetNodeID(), costTime)
end

function UISteinsGateChapterMap:TryReGenAll()
  self:__GenLines()
  self:__GenItems()
  self:__RefreCurNode()
  self:__RefreshDiffDeco()
end

function UISteinsGateChapterMap:OnGesture(fingerList)
  local result = CS_LeanTouch.RaycastGui(fingerList[0].ScreenPosition)
  if result.Count == 0 or not result[0].gameObject.transform:IsChildOf(self.ui.map.gameObject.transform) then
    return
  end
  if GuideManager.inGuide then
    return
  end
  if fingerList.Count == 1 then
    local finger = fingerList[0]
    if not self._isDraging and Vector2.Distance(finger.StartScreenPosition, finger.ScreenPosition) > 30 then
      self._isDraging = true
    end
  elseif fingerList.Count >= 2 then
    self.ui.map.enabled = false
    local touch1 = fingerList[0]
    local touch2 = fingerList[1]
    self:_CalculateScale(touch1, touch2)
  end
end

function UISteinsGateChapterMap:OnFingerInactive(leanFinger)
  if CS_LeanTouch.Fingers.Count <= 1 then
    self.ui.map.enabled = true
  end
  self._isDraging = false
end

function UISteinsGateChapterMap:_CalculateScale(touch1, touch2)
  local lastDiffX = touch1.LastScreenPosition.x - touch2.LastScreenPosition.x
  local lastDiffY = touch1.LastScreenPosition.y - touch2.LastScreenPosition.y
  local curDiffX = touch1.ScreenPosition.x - touch2.ScreenPosition.x
  local curDiffY = touch1.ScreenPosition.y - touch2.ScreenPosition.y
  local diff = Mathf.Sqrt(Mathf.Pow(curDiffX, 2) + Mathf.Pow(curDiffY, 2)) - Mathf.Sqrt(Mathf.Pow(lastDiffX, 2) + Mathf.Pow(lastDiffY, 2))
  local min = self.ui.viewport.rect.height / self.ui.content.sizeDelta.y
  if 1 < min then
    return
  end
  local scale = self.ui.content.localScale.x + diff / 500 * (1 - min)
  scale = math.clamp(scale, min, 1)
  self.ui.content.localScale = Vector3.New(scale, scale, 1)
  local centerPos = (touch1.ScreenPosition + touch2.ScreenPosition) / 2
  local uiPos = UIManager:Screen2UIPosition(centerPos, self.ui.viewport, UIManager.UICamera)
  self:__OnScale(uiPos)
end

function UISteinsGateChapterMap:__OnScale(uiPos)
  local delX = uiPos.x - self.ui.content.localPosition.x
  local delY = uiPos.y - self.ui.content.localPosition.y
  local pivotX = delX / self.ui.content.rect.width / self.ui.content.localScale.x
  local pivotY = delY / self.ui.content.rect.height / self.ui.content.localScale.y
  self.ui.content.pivot = self.ui.content.pivot + Vector2.New(pivotX, pivotY)
  self:_UpdateBound(true)
  local targetPos = self.ui.content.localPosition + Vector3.New(delX, delY, 0)
  self:_SetLimit(targetPos)
  self.ui.content.localPosition = targetPos
  self:__FitLineEndDeco()
end

function UISteinsGateChapterMap:_UpdateBound(onDrag, isForce, detailWidth)
  if self.bound ~= nil and not onDrag and not isForce then
    return
  end
  if self.bound == nil then
    self.bound = {}
  end
  local scale = self.ui.content.localScale
  local width = self.ui.content.rect.width * scale.x
  local height = self.ui.content.rect.height * scale.y
  local pivot = self.ui.content.pivot
  local parentRect = self.ui.viewport.rect
  local xMin = parentRect.xMin + width * pivot.x - self.__notchSize
  local xMax = parentRect.xMax - width * (1 - pivot.x) + self.__notchSize
  local yMin = parentRect.yMin + height * pivot.y
  local yMax = parentRect.yMax - height * (1 - pivot.y)
  if detailWidth ~= nil then
    xMax = xMax - detailWidth
  end
  self.bound.xMin = xMin
  self.bound.xMax = xMax
  self.bound.yMin = yMin
  self.bound.yMax = yMax
end

function UISteinsGateChapterMap:_SetLimit(targetPos)
  if self.bound.xMin <= self.bound.xMax then
    targetPos.x = math.clamp(targetPos.x, self.bound.xMin, self.bound.xMax)
  else
    targetPos.x = math.clamp(targetPos.x, self.bound.xMax, self.bound.xMin)
  end
  if self.bound.yMin <= self.bound.yMax then
    targetPos.y = math.clamp(targetPos.y, self.bound.yMin, self.bound.yMax)
  else
    targetPos.y = math.clamp(targetPos.y, self.bound.yMax, self.bound.yMin)
  end
end

function UISteinsGateChapterMap:OnMapRollValueChange(vecPos)
  if math.abs((self.__oldRollY or -1) - vecPos.y) < 0.001 then
    return
  end
  self.__oldRollY = vecPos.y
  self:__FitLineEndDeco()
end

local DECO_PADDING_UP = -100
local DECO_PADDING = -125

function UISteinsGateChapterMap:__FitLineEndDeco()
  local lineList = self.sgStoryData:Act23Gs_GetLineData()
  for lineIndex, lineData in ipairs(lineList) do
    if lineData:Act23GSLN_GetIsLineCouldShow() then
      local lineItem = self.__lineDic[lineIndex]
      local decoItem = self.__lineDecoDic[lineIndex]
      decoItem.transform.localScale = self.ui.content.localScale
      decoItem.transform.position = lineItem.transform.position
      local offset = -(lineItem.transform.sizeDelta.y / 4) * self.ui.content.localScale.y
      local x = self.ui.map.transform.localPosition.x - self.ui.map.transform.rect.width / 2
      local y = decoItem.transform.localPosition.y + offset
      local holderSize = -self.ui.map.transform.parent.transform.rect.height
      if y > DECO_PADDING_UP then
        decoItem:Hide()
      elseif y < holderSize - DECO_PADDING then
        decoItem:Hide()
      else
        decoItem:Show()
        decoItem.transform.localPosition = Vector2.Temp(x, y)
        decoItem.transform:SetAsLastSibling()
      end
    end
  end
end

function UISteinsGateChapterMap:__SGPlayMoveLeftTween(isOpenRight, width, duration, nodeItem, leftEdgeItem)
  self.ui.viewport:DOKill()
  self.ui.content:DOKill()
  local shift = -(width - 98)
  if isOpenRight then
    local function move()
      local lpos = UIManager.UICamera:WorldToScreenPoint(leftEdgeItem.transform.position)
      
      local posItemNeed2 = Vector2.New(lpos.x / 2, lpos.y)
      local uiPos = UIManager:Screen2UIPosition(posItemNeed2, nodeItem.transform.parent.transform, UIManager:GetUICamera())
      local localPos = nodeItem.transform.localPosition
      local move = (uiPos - Vector2.Temp(localPos.x, localPos.y)) * self.ui.content.localScale.x
      local targetPos = self.ui.content.localPosition + Vector3.Temp(move.x, move.y, 0)
      self:_UpdateBound(false, true, width)
      self:_SetLimit(targetPos)
      self.ui.map.enabled = false
      self.ui.content:DOLocalMove(targetPos, duration):SetLink(self.gameObject):OnComplete(function()
        self.ui.map.enabled = true
      end)
    end
    
    if self.ui.viewport.sizeDelta.x == shift then
      move()
    else
      self.ui.viewport:DOSizeDelta(Vector2.Temp(shift, 0), duration):SetLink(self.gameObject)
      move()
    end
  else
    self.ui.viewport:DOSizeDelta(Vector2.Temp(0, 0), duration):SetLink(self.gameObject)
    local targetPos = self.ui.content.localPosition
    self:_SetLimit(targetPos)
    self.ui.content:DOLocalMove(targetPos, duration):SetLink(self.gameObject)
  end
end

function UISteinsGateChapterMap:__OnClickNode(nodeData, nodeItem, delayTime)
  local storySectorId = self.sgData:GetSteinsGateStorySectorId()
  local diff = self.sgStoryData:Act23Gs_GetDiffIndex()
  local isBattle, isLocked, stageCfg, avgCfg, storyIdList, storySubTitleList
  if nodeData:Act23GSSN_GetIsBattleNode() then
    isBattle = true
    isLocked = not nodeData:Act23GSSN_GetIsUnlock(diff)
    local stageId = nodeData:Act23GSSN_GetStageId(diff)
    stageCfg = ConfigData.sector_stage[stageId]
    local playmoudle = SectorStageDetailHelper.PlayMoudleType.Ep
    local hasHasUncompletedEp, lastStageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(playmoudle)
    if hasHasUncompletedEp and lastStageId ~= stageId then
      SectorStageDetailHelper.TryToShowCurrentLevelTips(playmoudle)
      return
    end
    local isComplete = nodeData:Act23GSSN_GetIsClear()
    if isComplete then
      storyIdList, storySubTitleList = nodeData:Act23Gs_GetLevelAvgReview()
    end
  else
    isBattle = false
    isLocked = not nodeData:Act23GSSN_GetIsUnlock(diff)
    local avgid = nodeData:Act23GSSN_GetStageId(diff)
    avgCfg = ConfigData.story_avg[avgid]
  end
  self.__seletedNodeId = nodeData:Act23GSSN_GetNodeID()
  self.ui.obj_Selected:SetActive(true)
  self.ui.obj_Selected.transform:SetParent(nodeItem.transform)
  self.ui.obj_Selected.transform.anchoredPosition = Vector2.zero
  self:SteinsGateChapterMapSelectAnim(delayTime)
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    window:CloseLvDetailShowAudio()
    local width, duration = window:GetLevelDetailWidthAndDuration()
    local leftEdgeItem = window.ui.obj_leftEdge
    window:SetLevelDetaiHideStartEvent(function(toHome)
      if not toHome then
        self:__SGPlayMoveLeftTween(false, width, duration, nodeItem, leftEdgeItem)
      end
      self.__seletedNodeId = nil
      self.ui.obj_Selected:SetActive(false)
      self:__StopSelectAnim()
    end)
    window:SetLevelDetaiHideEndEvent(function()
    end)
    self:__SGPlayMoveLeftTween(true, width, duration, nodeItem, leftEdgeItem)
    local levelDetailExtrData = window:GetNewLevelDetailExtrData()
    levelDetailExtrData:Set_AdditionalFirstClearRewardList(nodeData:Act23GSSN_GetExtrReward(diff))
    if isBattle then
      levelDetailExtrData:Set_AdditionalReviewStoryList(storyIdList, storySubTitleList)
      window:InitSectorLevelDetail(stageCfg.sector, stageCfg.id, isLocked, levelDetailExtrData)
      window:SetDetailExBattleStartCallback(function()
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      end)
      window:SetDetailCloseCallUICallback(function()
        UIManager:HideWindow(UIWindowTypeID.Activity23SteinsGateChapterMap)
      end)
      window:SetDetailReopenCallUICallback(function()
        UIManager:ShowWindowOnly(UIWindowTypeID.Activity23SteinsGateChapterMap)
      end)
    else
      levelDetailExtrData:Set_SpecialLevelIdName(nodeData:Act23GSSN_GetNodeTitle())
      window:InitSectorLevelAvgDetail(storySectorId, avgCfg, function()
        self:TryReGenAll()
        self:__FocusNode(self.curNodeData:Act23GSSN_GetNodeID())
      end, isLocked, levelDetailExtrData)
    end
  end, UIWindowTypeID.SectorLevelDetailSteinsGate)
end

function UISteinsGateChapterMap:SteinsGateChapterMapSelectAnim(delayTime)
  self:__StopSelectAnim()
  if delayTime == nil then
    delayTime = 0
  end
  self.ui.anim_SelectedCircle:DOFade(0, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_SelectedCircle.transform:DOScale(1.3, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_SelectedArrow:DOFade(0, 0.25):From():SetDelay(delayTime + 0.2):SetLink(self.gameObject)
  self.__SelectedArrowAnim = self.ui.anim_SelectedArrow.transform:DOLocalMove(Vector3.New(126, 97, 0), 0.4):SetDelay(delayTime + 0.2):SetLink(self.gameObject):SetLoops(-1, cs_LoopType.Yoyo):SetEase(cs_Ease.OutQuart)
end

function UISteinsGateChapterMap:__StopSelectAnim()
  self.ui.anim_SelectedCircle:DOComplete()
  self.ui.anim_SelectedCircle.transform:DOComplete()
  self.ui.anim_SelectedArrow:DOComplete()
  if self.__SelectedArrowAnim ~= nil then
    self.__SelectedArrowAnim:Rewind()
    self.__SelectedArrowAnim:Kill()
    self.__SelectedArrowAnim = nil
  end
end

function UISteinsGateChapterMap:__CloseDetail()
  if self._isDraging then
    return
  end
  local detailWin = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if detailWin ~= nil and detailWin.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
  end
end

function UISteinsGateChapterMap:__FocusOnNodeItem(nodeItem, moveTime)
  local screenMid = UIManager.BackgroundStretchSize / 2
  local uiPos = UIManager:Screen2UIPosition(screenMid, nodeItem.transform.parent.transform, UIManager:GetUICamera())
  local localPos = nodeItem.transform.localPosition
  local move = (uiPos - Vector2.Temp(localPos.x, localPos.y)) * self.ui.content.localScale.x
  local targetPos = self.ui.content.localPosition + Vector3.Temp(move.x, move.y, 0)
  self:_UpdateBound(false, true)
  self:_SetLimit(targetPos)
  self.ui.map.enabled = false
  moveTime = moveTime or 0.5
  if moveTime <= 0 then
    self.ui.content.localPosition = targetPos
  else
    self.ui.content:DOLocalMove(targetPos, moveTime):SetLink(self.gameObject):SetEase(cs_Ease.InOutQuint):OnComplete(function()
      self.ui.map.enabled = true
    end)
  end
end

function UISteinsGateChapterMap:Act23SG_TryLoacteStage(stageCfg)
  local stageId = stageCfg.id
  for _, nodeItem in pairs(self.stagePool.listItem) do
    local isHave, diff = nodeItem.nodeData:Act23GSSN_GetIsHaveStageId(stageId)
    if isHave then
      self:__FocusOnNodeItem(nodeItem)
      break
    end
  end
end

function UISteinsGateChapterMap:__SelectNode(NodeId, delayTime)
  local nodeItem = self:GetItemByNodeID(NodeId)
  if nodeItem == nil then
    return
  end
  self:__OnClickNode(nodeItem.nodeData, nodeItem, delayTime)
end

function UISteinsGateChapterMap:__FocusNode(NodeId, moveTime)
  self:__FocusOnNodeItem(self:GetItemByNodeID(NodeId), moveTime)
end

function UISteinsGateChapterMap:__TryPlayFoceSelectDiff(callback)
  if self.sgStoryData:Act23Gs_GetIsNeedFirstSelectDiff() then
    self.downNode:OpenAndForceSelectDiff(callback)
    return
  end
  if callback ~= nil then
    callback()
  end
end

function UISteinsGateChapterMap:PlayAct23GSMapPerform(perform_type, args)
  local function TryChageDiff(NodeId)
    local nodeItem = self:GetItemByNodeID(NodeId)
    
    if nodeItem == nil then
      return
    end
    local curDiff = self.sgStoryData:Act23Gs_GetDiffIndex()
    if curDiff == Act23SteinsGateEnum.eStoryDiff.Hard and not nodeItem.nodeData:Act23GSSN_GetIsUnlock(curDiff) then
      local diff = Act23SteinsGateEnum.eStoryDiff.Normal
      self.sgStoryData:Act23Gs_SetDiffIndex(diff)
      self:__RefreshDiffDeco()
      self:__RefreshDiffNodeChange()
    end
  end
  
  if perform_type == Act23SteinsGateEnum.performType.OpenStoryLine then
    local levelId = args[1]
    if args[2] == 1 then
      self.canOpenNewStoryLineAnim = true
    else
      self.canOpenNewStoryLineAnim = false
    end
    TryChageDiff(levelId)
    self:__SelectNode(levelId, 1.7, true)
  elseif perform_type == Act23SteinsGateEnum.performType.OpenAndExtendStoryLine then
    local levelId = args[1]
    local preLevelId = args[2]
    local perform_FX = args[3]
    UIUtil.AddOneCover("UISteinsGateChapterMap")
    TryChageDiff(levelId)
    local nodeItem = self:GetItemByNodeID(levelId)
    local preNodeItem = self:GetItemByNodeID(preLevelId)
    local lineIndex = nodeItem.nodeData:Act23GSSN_GetLineIndex()
    local lineItem = self.__lineDic[lineIndex]
    lineItem:Hide()
    nodeItem:Hide()
    if perform_FX == 1 then
      lineItem.ui.img_fxLine.gameObject:SetActive(true)
    end
    self.__seqTween = CS_DOTween.Sequence()
    self.__seqTween:AppendCallback(function()
      self:__FocusNode(preLevelId)
      preNodeItem:PlaySGChapterMapNodeCompletedAnim(0.5)
    end)
    self.__seqTween:AppendInterval(1)
    self.__seqTween:AppendCallback(function()
      AudioManager:PlayAudioById(1131)
      local min = self.ui.viewport.rect.height / self.ui.content.sizeDelta.y
      local scale = Vector3.Temp(min, min, 1)
      self.ui.content:DOScale(scale, 1.2):OnUpdate(function()
        self:__FitLineEndDeco()
      end)
    end)
    self.__seqTween:AppendInterval(1.4)
    self.__seqTween:AppendCallback(function()
      lineItem:Show()
      self.ui.content.pivot = Vector2.zero
      self.ui.content:DOLocalMoveY(-600, 1.9):OnUpdate(function()
        self:__FitLineEndDeco()
      end)
    end)
    self.__seqTween:AppendInterval(2)
    self.__seqTween:AppendCallback(function()
      if perform_FX == 1 then
        lineItem:PlaySGChapterMapSwitchNewLineAnimSP(0)
      end
      lineItem:PlaySGChapterMapSwitchNewLineAnim(0)
    end)
    self.__seqTween:AppendInterval(1)
    self.__seqTween:AppendCallback(function()
      self:__FocusNode(levelId, 5)
    end)
    self.__seqTween:AppendInterval(5)
    self.__seqTween:AppendCallback(function()
      self.ui.content.pivot = Vector2.Temp(0, 1)
      AudioManager:PlayAudioById(1132)
      self.ui.content:DOScale(1, 1.2):OnUpdate(function()
        self:__FitLineEndDeco()
      end)
      nodeItem:Show()
      nodeItem:PlaySGChapterMapNodeShowNextNodeAnim(0.2)
    end)
    self.__seqTween:AppendInterval(1.4)
    self.__seqTween:AppendCallback(function()
      self:__SelectNode(levelId)
      UIUtil.CloseOneCover("UISteinsGateChapterMap")
    end)
    self.__seqTween:AppendCallback(function()
    end)
  end
end

function UISteinsGateChapterMap:PlaySGMapNodeItemUnlockedAnim()
  local curNodeItem = self:GetItemByNodeID(self.curNodeData:Act23GSSN_GetNodeID())
  local isNewState, newState = self.curNodeData:GetIsNewState()
  if not isNewState then
    self:__TryAutoSelectNotCompleteStage()
    return
  end
  if isNewState and newState == Act23SteinsGateEnum.nodeType.isCompleted then
    if self.curNodeData:Act23GSSN__IsNeedShowFx() then
      self.__LastAvgTimerId = TimerManager:StartTimer(0.5, function()
        if IsNull(self.gameObject) then
          return
        end
        local prefab = self.resloader:LoadABAsset("FX/UI_effct/UI_shijiexian/FXP_shijiexian_zhenjieju.prefab")
        self.__effect = prefab:Instantiate(curNodeItem.transform)
        self.__effect.transform:SetAsFirstSibling()
      end, self, true, false, false)
      curNodeItem:PlaySGChapterMapNodeShowNextNodeAnim(1)
      curNodeItem:PlaySGChapterMapNodeCompletedAnim(1.4)
    else
      curNodeItem:PlaySGChapterMapNodeCompletedAnim(0.6)
    end
  elseif isNewState and newState == Act23SteinsGateEnum.nodeType.isUnlocked then
    curNodeItem:PlaySGChapterMapNodeShowNextNodeAnim(1.4)
    if self.canOpenNewStoryLineAnim then
      local lineItem = self.__lineDic[self.curNodeData:Act23GSSN_GetLineIndex()]
      lineItem:PlaySGChapterMapSwitchNewLineAnim(0.9)
      self.canOpenNewStoryLineAnim = false
    end
    local preNodeData = self.sgStoryData:Act23SG_GetNodeData(self.curNodeData:Act23GSSN_GetPreNodeId())
    if preNodeData == nil then
      return
    end
    local preIsNewState, preNewState = preNodeData:GetIsNewState()
    if preIsNewState and preNewState == Act23SteinsGateEnum.nodeType.isCompleted then
      local preNodeItem = self:GetItemByNodeID(preNodeData:Act23GSSN_GetNodeID())
      preNodeItem:PlaySGChapterMapNodeCompletedAnim(0.7)
    end
  end
  self.curNodeData:RecordNodeDataState()
end

function UISteinsGateChapterMap:GetItemByNodeID(NodeId)
  for _, nodeItem in pairs(self.stagePool.listItem) do
    if nodeItem.nodeData:Act23GSSN_GetNodeID() == NodeId then
      return nodeItem
    end
  end
  for _, nodeItem in pairs(self.storyPool.listItem) do
    if nodeItem.nodeData:Act23GSSN_GetNodeID() == NodeId then
      return nodeItem
    end
  end
end

function UISteinsGateChapterMap:__TryAutoSelectNotCompleteStage()
  local playmoudle = SectorStageDetailHelper.PlayMoudleType.Ep
  local hasHasUncompletedEp, lastStageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(playmoudle)
  if hasHasUncompletedEp then
    local curDiff = self.sgStoryData:Act23Gs_GetDiffIndex()
    for _, nodeItem in pairs(self.stagePool.listItem) do
      local isHave, diff = nodeItem.nodeData:Act23GSSN_GetIsHaveStageId(lastStageId)
      if isHave then
        if diff ~= curDiff then
          self.sgStoryData:Act23Gs_SetDiffIndex(diff)
          self:__RefreshDiffDeco()
          self:__RefreshDiffNodeChange()
        end
        self:__FocusOnNodeItem(nodeItem)
        self:__OnClickNode(nodeItem.nodeData, nodeItem, 0)
        break
      end
    end
    return
  end
end

function UISteinsGateChapterMap:AfterClickOutRewardPicked()
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
  aftertTeatmentCtrl:BindResultAfterAction(function()
    local actCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    if actCtrl then
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      actCtrl:OpenSteinsGate23(self.sgData:GetActId())
    end
  end)
end

function UISteinsGateChapterMap:Close()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UISteinsGateChapterMap:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.StageOutPickReward, self.__AfterClickOutRewardPickedBind)
  self:__StopSelectAnim()
  if self.____seqTween ~= nil then
    self.____seqTween:Kill()
    self.____seqTween = nil
  end
  CS_LeanTouch.OnGesture("-", self.__onGesture)
  CS_LeanTouch.OnFingerInactive("-", self.__onFingerInactive)
  if self.__LastAvgTimerId ~= nil then
    TimerManager:StopTimer(self.__LastAvgTimerId)
    self.__LastAvgTimerId = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UISteinsGateChapterMap
