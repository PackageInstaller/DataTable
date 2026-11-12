local LocalData = require("GameCore.Data.LocalData")
local ChapterLineCtrl = class("ChapterLineCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local GameCameraStackManager = CS.GameCameraStackManager
ChapterLineCtrl._mapNodeConfig = {
  tranContent = {
    sNodeName = "Content",
    sComponentName = "RectTransform"
  },
  scrollRect = {
    sNodeName = "Scroll View",
    sComponentName = "ScrollRect"
  },
  imgMask = {
    sNodeName = "ImgMask",
    sComponentName = "RectTransform"
  },
  goImgMaskRoot = {},
  layoutContent = {
    sNodeName = "Content",
    sComponentName = "HorizontalLayoutGroup"
  }
}
ChapterLineCtrl._mapEventConfig = {
  Story_RewardClosed = "OnEvent_Story_RewardClosed",
  Story_Done = "OnEvent_Story_Done"
}

function ChapterLineCtrl:Awake()
  self.bCanClick = true
  
  local function callback()
    self.bHasAchievementData = true
  end
  
  PlayerData.Achievement:SendAchievementInfoReq(callback)
  local tbParam = self:GetPanelParam()
  self.curChapter = tbParam[1]
  self.curTimeStamp = 0
  self.curNodeDepth = 1
  self.tbImgFocusNode = {}
  self.tbLockedPlayedAnim = {}
  self.lineAnimTime = 0.14
  self.tbBranchGrid = {}
  self.tbLockedBranchGrid = {}
  self.tbDiscNodeParentGrid = {}
  self.bFocusNotReadNode = true
  self.Rect = self._mapNode.tranContent:GetComponent("RectTransform")
  self:CacheCurChapterConfig()
  self:CacheChapterBranchNode()
  self:Refresh()
  self:AddTimer(1, 0.5, function()
    if self.bNeedPlayUnlockAnim or self.bNeedPlayBranchAnim then
      if self.bNeedPlayBranchAnim and self.tbNeedPlayUnlockAnimGird[1] ~= nil then
        self.curShouldPlayDepth = self.tbNeedPlayUnlockAnimGird[1].depth
      end
      self:DoPlayUnlockAnim(self.curShouldPlayDepth)
    end
  end, true, true, true)
end

function ChapterLineCtrl:RefreshFocusNode()
  self.tbFocusNode = {}
  self.bFocusLastNode = false
  local tbNewNodes = AvgData:CheckNewStory(self.curChapter)
  for k, v in pairs(tbNewNodes) do
    if v == true then
      table.insert(self.tbFocusNode, k)
    end
  end
  if #self.tbFocusNode == 0 then
    local firstNode = self._mapNode.tranContent:GetChild(1):Find("goGrid"):GetChild(0)
    local avgId = firstNode.name
    local storyConfig = AvgData:GetStoryCfgData(avgId)
    if not AvgData:IsStoryReaded(storyConfig.Id) then
      table.insert(self.tbFocusNode, storyConfig.Id)
    else
      self.bFocusLastNode = true
      table.insert(self.tbFocusNode, AvgData:GetRecentStoryId(self.curChapter))
    end
  end
  self.bNeedPlayUnlockAnim = false
  self.bNeedPlayBranchAnim = false
  for k, v in ipairs(self.tbFocusNode) do
    local storyConfig = ConfigTable.GetData_Story(v)
    local bHasPlayedAnim = LocalData.GetPlayerLocalData("MainlineUnlock_" .. v)
    if bHasPlayedAnim == nil or tonumber(bHasPlayedAnim) == 0 then
      if storyConfig.IsBranch == true then
        self.bNeedPlayBranchAnim = true
        break
      end
      self.bNeedPlayUnlockAnim = true
      break
    end
    local avgId = storyConfig.StoryId
    if 0 < table.indexof(self.tbLockedBranchGrid, avgId) and self.tbBranch[avgId] ~= nil then
      for _, branchGrid in ipairs(self.tbBranch[avgId]) do
        local bUnlock = AvgData:IsUnlock(branchGrid.ConditionId, branchGrid.StoryId)
        if bUnlock then
          self.bNeedPlayBranchAnim = true
          break
        end
      end
    end
  end
end

function ChapterLineCtrl:RefreshGridDepthInfo()
  for i = 1, self._mapNode.tranContent.childCount - 1 do
    local gridRoot = self._mapNode.tranContent:GetChild(i):Find("goGrid")
    local goTimeStamp = self._mapNode.tranContent:GetChild(i):Find("goTimeStamp")
    self.tbDepthLockCount[i] = {
      Node = self._mapNode.tranContent:GetChild(i),
      ChildCount = gridRoot.childCount,
      DisableCount = 0
    }
    for j = 1, gridRoot.childCount do
      local goGrid = gridRoot:GetChild(j - 1)
      local avgId = goGrid.name
      table.insert(self.tbGridList, {
        avgId = avgId,
        grid = goGrid,
        depth = i
      })
      local storyConfig = AvgData:GetStoryCfgData(avgId)
      if storyConfig == nil then
        print("Error: Story config not found for avgId: " .. avgId)
      end
      local bUnlock = AvgData:IsUnlock(storyConfig.ConditionId, storyConfig.StoryId)
      if storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.DiscType then
        if self.tbDiscNodeParentGrid[avgId] == nil then
          self.tbDiscNodeParentGrid[avgId] = {}
          for k, v in pairs(storyConfig.ParentStoryId) do
            table.insert(self.tbDiscNodeParentGrid[avgId], v)
          end
        end
      elseif storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.LastEndType then
        self.LastEndNodeAvgId = avgId
      end
      if i > self.maxStoryDepth then
        self.maxStoryDepth = i
      end
      if bUnlock and i > self.maxUnlockDepth then
        self.maxUnlockDepth = i
      end
    end
    table.insert(self.tbTimeStampList, goTimeStamp)
  end
  table.sort(self.tbGridList, function(a, b)
    return a.depth < b.depth
  end)
end

function ChapterLineCtrl:Refresh()
  self._mapNode.goImgMaskRoot.transform:SetParent(self._mapNode.tranContent)
  self._mapNode.goImgMaskRoot.transform:SetAsFirstSibling()
  self:RefreshFocusNode()
  self.tbGridList = {}
  self.tbTimeStampList = {}
  self.tbDepthLockCount = {}
  self.maxUnlockDepth = 1
  self.maxStoryDepth = 1
  self:RefreshGridDepthInfo()
  self:RefreshCurNodeDepthByNewUnlock()
  self:RefreshUnlockAnimList()
  self.tbBranchOverflowDepths = {}
  self.maxLockRootDepth = 0
  for k, v in ipairs(self.tbGridList) do
    self:RefreshGrid(v.grid, v.depth)
  end
  self:ApplyLayoutContentRightPadding()
  local isComplete = self:IsAllStoryCompleted()
  self.curTimeStamp = isComplete and self.curTimeStamp or self.maxUnlockDepth
  for i = 1, #self.tbTimeStampList do
    self:RefreshTimeStamp(self.tbTimeStampList[i], i)
  end
  self:AddTimer(1, 0.1, function()
    local posX = self.curNodeDepth < 4 and 0 or (self.curNodeDepth - 1) * -512
    self._mapNode.tranContent.anchoredPosition = Vector2(posX, 0)
  end, true, true, true)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.tranContent)
  for k, v in ipairs(self.tbGridList) do
    self:RecordGridBorderPos(v.grid)
  end
  for k, v in ipairs(self.tbGridList) do
    self:CheckLineReasonable(v.grid)
  end
  if self.curTimeStamp - 1 < 0 then
    self._mapNode.imgMask.gameObject:SetActive(false)
  else
    self._mapNode.imgMask.gameObject:SetActive(true)
    local node = self._mapNode.tranContent:Find(tostring(self.curNodeDepth))
    local layout = self._mapNode.tranContent:GetComponent("HorizontalLayoutGroup")
    local pos = node.localPosition.x - layout.padding.left
    self._mapNode.imgMask.anchoredPosition = Vector2(pos, -6)
  end
end

function ChapterLineCtrl:IsAvgIdPendingUnlockAnim(avgId)
  if table.indexof(self.tbLockedPlayedAnim, avgId) > 0 then
    return false
  end
  for k, v in ipairs(self.tbNeedPlayUnlockAnimGird) do
    if v.avgId == avgId then
      return true
    end
  end
  return false
end

function ChapterLineCtrl:RefreshGrid(goGrid, gridDepth)
  local avgId = goGrid.name
  local storyConfig = AvgData:GetStoryCfgData(avgId)
  local bUnlock = AvgData:IsUnlock(storyConfig.ConditionId, avgId)
  local bAllLock = 1 < gridDepth and true or false
  local bSelfNeedPlayUnlockAnim = self:IsAvgIdPendingUnlockAnim(avgId)
  local allParentDepthLock = false
  if bSelfNeedPlayUnlockAnim then
    allParentDepthLock = 1 < gridDepth and true or false
    for i = 1, #storyConfig.ParentStoryId do
      local parentId = storyConfig.ParentStoryId[i]
      local parentConfig = AvgData:GetStoryCfgData(parentId)
      local parentUnlock = AvgData:IsUnlock(parentConfig.ConditionId, parentConfig.StoryId)
      if parentUnlock and not self:IsAvgIdPendingUnlockAnim(parentId) then
        allParentDepthLock = false
      end
    end
  end
  for i = 1, #storyConfig.ParentStoryId do
    local parentConfig = AvgData:GetStoryCfgData(storyConfig.ParentStoryId[i])
    local parentUnlock = AvgData:IsUnlock(parentConfig.ConditionId, parentConfig.StoryId)
    if parentUnlock then
      bAllLock = false
    end
  end
  if bAllLock then
    self.tbDepthLockCount[gridDepth].DisableCount = self.tbDepthLockCount[gridDepth].DisableCount + 1
  end
  self.tbDepthLockCount[gridDepth].Node.gameObject:SetActive(self.tbDepthLockCount[gridDepth].DisableCount < self.tbDepthLockCount[gridDepth].ChildCount)
  local bPlayedLockAnim = table.indexof(self.tbLockedPlayedAnim, avgId) > 0
  local bShowGrid = not bAllLock and not allParentDepthLock and not bSelfNeedPlayUnlockAnim or bPlayedLockAnim
  bShowGrid = (storyConfig.MemoryType ~= GameEnum.MainlineMemoryNodeType.LastEndType or bUnlock) and bShowGrid
  goGrid.gameObject:SetActive(bShowGrid)
  local bReaded = AvgData:IsStoryReaded(storyConfig.Id)
  local btnEnter = goGrid:Find("btnEnter"):GetComponent("UIButton")
  local NormalRoot = btnEnter.transform:Find("AnimRoot/NormalRoot")
  local BattleRoot = btnEnter.transform:Find("AnimRoot/BattleRoot")
  local SpecialRoot = btnEnter.transform:Find("AnimRoot/SpecialRoot")
  local BranchRoot = goGrid:Find("BranchRoot")
  local LockRoot = btnEnter.transform:Find("AnimRoot/LockRoot")
  local imgClue = goGrid:Find("imgClue")
  local lineContinue = goGrid:Find("lineContinue")
  local goRightBorder = goGrid:Find("goRightBorder")
  local goLeftBorder = goGrid:Find("goLeftBorder")
  local imgLeftPoint_1 = goGrid:Find("imgLeftPoint_1")
  local imgRightPoint_1 = goGrid:Find("imgRightPoint_1")
  local txtUnlock = LockRoot:Find("txtUnlock"):GetComponent("TMP_Text")
  local imgTips = NormalRoot:Find("imgTips")
  local cgComp = storyConfig.IsBattle and NormalRoot:GetComponent("CanvasGroup") or BattleRoot:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(cgComp, bUnlock and 1 or 0.5)
  local bShowLockRoot = not bUnlock or bPlayedLockAnim
  LockRoot.gameObject:SetActive(bShowLockRoot)
  if bShowLockRoot and gridDepth > (self.maxLockRootDepth or 0) then
    if bShowGrid then
      if self.tbDepthLockCount[gridDepth].Node.gameObject.activeInHierarchy then
        self.maxLockRootDepth = gridDepth
      end
    elseif bNeedPlayUnlockAnim then
      self.maxLockRootDepth = gridDepth
    end
  end
  imgClue.gameObject:SetActive(storyConfig.HasEvidence and bUnlock and not bReaded)
  local bShowLineContinue = not bUnlock and gridDepth > self.maxUnlockDepth
  lineContinue.gameObject:SetActive(bShowLineContinue)
  local isSpecial = storyConfig.MemoryType ~= GameEnum.MainlineMemoryNodeType.None
  local rootTrans = storyConfig.IsBattle and BattleRoot or NormalRoot
  if isSpecial then
    if SpecialRoot == nil then
      return
    end
    for i = 1, SpecialRoot.childCount do
      if i == storyConfig.MemoryType then
        SpecialRoot:GetChild(i - 1).gameObject:SetActive(true)
        rootTrans = SpecialRoot:GetChild(i - 1)
      else
        SpecialRoot:GetChild(i - 1).gameObject:SetActive(false)
      end
    end
  end
  NormalRoot.gameObject:SetActive(not storyConfig.IsBattle and not isSpecial)
  BattleRoot.gameObject:SetActive(storyConfig.IsBattle and not isSpecial)
  if imgTips ~= nil then
    imgTips.gameObject:SetActive(false)
  end
  if isSpecial and SpecialRoot ~= nil then
    SpecialRoot.gameObject:SetActive(not bNeedPlayUnlockAnim)
  end
  rootTrans.gameObject:SetActive(bUnlock)
  local imgFocus = rootTrans:Find("imgFocus")
  local RedDot = rootTrans:Find("RedDot")
  local bFocus = 0 < table.indexof(self.tbFocusNode, storyConfig.Id) and (not bReaded or self.bFocusLastNode)
  imgFocus.gameObject:SetActive(bFocus and not bPlayedLockAnim)
  RedDot.gameObject:SetActive(bFocus and not bReaded and not bPlayedLockAnim)
  if self.tbBranch[avgId] ~= nil then
    for k, v in ipairs(self.tbBranch[avgId]) do
      if 0 < table.indexof(self.tbFocusNode, v.Id) then
        bFocus = true
        break
      end
    end
  end
  if bUnlock then
    local nodeTimeStampIndex = tonumber(goGrid.transform.parent.parent.name)
    if nodeTimeStampIndex > self.curTimeStamp then
      if self.tbImgFocusNode[self.curTimeStamp] ~= nil then
        for k, v in ipairs(self.tbImgFocusNode[self.curTimeStamp]) do
          v.gameObject:SetActive(false)
        end
      end
      self.curTimeStamp = nodeTimeStampIndex
    end
    if self.tbImgFocusNode[self.curTimeStamp] == nil then
      self.tbImgFocusNode[self.curTimeStamp] = {}
    end
    table.insert(self.tbImgFocusNode[self.curTimeStamp], imgFocus)
  end
  if bUnlock then
    local goReaded = rootTrans:Find("goReaded")
    local goNotRead = rootTrans:Find("goNotRead")
    local txtNotRead = goNotRead:Find("txtNotRead"):GetComponent("TMP_Text")
    local txtNewUnlock = goNotRead:Find("txtNewUnlock"):GetComponent("TMP_Text")
    goNotRead.gameObject:SetActive(not bReaded and goNotRead ~= nil or goReaded == nil)
    if goReaded ~= nil then
      local txtLevelName = goReaded:Find("txtLevelName"):GetComponent("TMP_Text")
      local txtLevelIndex = goReaded:Find("txtLevelIndex"):GetComponent("TMP_Text")
      goReaded.gameObject:SetActive(bReaded)
      NovaAPI.SetTMPText(txtLevelName, storyConfig.Title)
      NovaAPI.SetTMPText(txtLevelIndex, storyConfig.Index)
    end
    NovaAPI.SetTMPText(txtNotRead, storyConfig.Index)
    NovaAPI.SetTMPText(txtNewUnlock, ConfigTable.GetUIText("Story_NewStory_Unlock"))
    if not storyConfig.IsBattle and not isSpecial and goReaded ~= nil then
      local imgClueReaded = goReaded:Find("imgClueReaded")
      imgClueReaded.gameObject:SetActive(storyConfig.HasEvidence)
    end
    self:PlayUnlockAnim(rootTrans, "Empty")
    if isSpecial and SpecialRoot ~= nil then
      if storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.DiscType then
        local zsBg1 = rootTrans:Find("imgBg/zsBg1")
        local zsBg2 = rootTrans:Find("imgBg/zsBg2")
        zsBg2.gameObject:SetActive(not bFocus)
        zsBg1.gameObject:SetActive(not bFocus)
      end
      goLeftBorder.gameObject:SetActive(false)
      goRightBorder.gameObject:SetActive(false)
      imgRightPoint_1.gameObject:SetActive(false)
      imgLeftPoint_1.gameObject:SetActive(false)
    end
  end
  NovaAPI.SetTMPText(txtUnlock, ConfigTable.GetUIText("Story_Unkown_Chapter"))
  for i = 1, goRightBorder.childCount do
    goRightBorder:GetChild(i - 1).gameObject:SetActive(not bShowLineContinue)
  end
  if not isSpecial then
    local isParentSpecial = self:CheckIsParentSpecialNode(avgId)
    local isChildSpecial, specialType = self:CheckIsChildSpecialNode(avgId)
    if isChildSpecial then
      if specialType == GameEnum.MainlineMemoryNodeType.DiscType then
        goLeftBorder.gameObject:SetActive(not isParentSpecial)
        goRightBorder.gameObject:SetActive(not isChildSpecial)
        imgRightPoint_1.gameObject:SetActive(not isChildSpecial)
        imgLeftPoint_1.gameObject:SetActive(not isParentSpecial and 1 < gridDepth)
      elseif specialType == GameEnum.MainlineMemoryNodeType.LastEndType then
        local lastEndState = AvgData:GetLastEndState()
        if lastEndState == AllEnum.MainlineLastEndState.WaitUnlock and imgTips ~= nil then
          imgTips.gameObject:SetActive(true)
          local txtTips = imgTips:Find("txtTips"):GetComponent("TMP_Text")
          NovaAPI.SetTMPText(txtTips, ConfigTable.GetUIText("Mainline_Last_End_WaitUnlock"))
        end
      end
    end
  end
  if self.tbBranch[avgId] ~= nil then
    if bNeedPlayUnlockAnim == false and 0 < table.indexof(self.tbLockedBranchGrid, avgId) then
      bNeedPlayUnlockAnim = true
    end
    self:RefreshBranchGrid(BranchRoot, avgId, gridDepth, bNeedPlayUnlockAnim)
  end
  btnEnter.onClick:RemoveAllListeners()
  btnEnter.onClick:AddListener(function()
    self:OnClickGrid(avgId)
  end)
end

function ChapterLineCtrl:RecordGridBorderPos(goGrid)
  local avgId = goGrid.name
  if self.tbGridBorderPos == nil then
    self.tbGridBorderPos = {}
  end
  local uiCamera = GameCameraStackManager.Instance.uiCamera
  local imgLeftPoint_1 = goGrid:Find("imgLeftPoint_1"):GetComponent("RectTransform")
  local imgRightPoint_1 = goGrid:Find("imgRightPoint_1"):GetComponent("RectTransform")
  local leftScreenPos = imgLeftPoint_1 and RectTransformUtility.WorldToScreenPoint(uiCamera, imgLeftPoint_1.position) or nil
  local rightScreenPos = imgRightPoint_1 and RectTransformUtility.WorldToScreenPoint(uiCamera, imgRightPoint_1.position) or nil
  self.tbGridBorderPos[avgId] = {
    left = leftScreenPos,
    right = rightScreenPos,
    grid = goGrid
  }
end

function ChapterLineCtrl:RefreshBranchGrid(root, avgId, depth, isNeedPlayUnlockAnim)
  local nUnlockBranchCount = 0
  table.sort(self.tbBranch[avgId], function(a, b)
    local aUnlock = AvgData:IsUnlock(a.ConditionId, a.StoryId)
    local bUnlock = AvgData:IsUnlock(b.ConditionId, b.StoryId)
    if aUnlock ~= bUnlock then
      return aUnlock
    end
    return a.StoryId < b.StoryId
  end)
  for k, v in ipairs(self.tbBranch[avgId]) do
    if AvgData:IsUnlock(v.ConditionId, v.StoryId) then
      nUnlockBranchCount = nUnlockBranchCount + 1
    end
  end
  local index = 1
  local bHasUnlockBranch = false
  local bHasUnReadBranch = false
  for k, v in ipairs(self.tbBranch[avgId]) do
    local bUnlock = AvgData:IsUnlock(v.ConditionId, v.StoryId)
    local bReaded = AvgData:IsStoryReaded(v.Id)
    local branchGrid = root:Find("BranchGrid_" .. k)
    local storyConfig = AvgData:GetStoryCfgData(v.StoryId)
    if bUnlock then
      bHasUnlockBranch = true
    end
    if bUnlock and not bReaded then
      local hasPlay = LocalData.GetPlayerLocalData("MainlineUnlock_" .. storyConfig.Id)
      if hasPlay == nil or tonumber(hasPlay) == 0 then
        bHasUnReadBranch = true
      end
    end
    if 0 >= table.indexof(self.tbLockedBranchGrid, avgId) then
      table.insert(self.tbLockedBranchGrid, avgId)
    end
    if bUnlock and 0 < table.indexof(self.tbLockedBranchGrid, avgId) then
      table.removebyvalue(self.tbLockedBranchGrid, avgId)
    end
    if isNeedPlayUnlockAnim and bUnlock then
      if not bReaded then
        root.gameObject:SetActive(false)
      end
      table.insert(self.tbNeedPlayUnlockAnimGird, {
        grid = root,
        avgId = storyConfig.StoryId,
        depth = depth,
        index = index,
        totalCount = nUnlockBranchCount
      })
    end
    if branchGrid ~= nil then
      local lastEndState = AvgData:GetLastEndState()
      local goUnlock = branchGrid:Find("AnimRoot/goUnlock")
      local goLock = branchGrid:Find("AnimRoot/goLock")
      local goLevelIndex = branchGrid:Find("AnimRoot/goUnlock/txtLevelIndex")
      local txtLevelIndex = goLevelIndex:GetComponent("TMP_Text")
      local txtLevelName = txtLevelIndex.transform:Find("txtLevelName"):GetComponent("TMP_Text")
      local cgLevelIndex = goLevelIndex:GetComponent("CanvasGroup")
      local imgNewUnlockBg = branchGrid:Find("AnimRoot/goUnlock/imgNewUnlockBg")
      local imgNewUnlock = branchGrid:Find("AnimRoot/goUnlock/imgNewUnlock")
      NovaAPI.SetCanvasGroupAlpha(cgLevelIndex, 1)
      NovaAPI.SetTMPText(txtLevelIndex, storyConfig.Index)
      goUnlock.gameObject:SetActive(bUnlock)
      goLock.gameObject:SetActive(not bUnlock or lastEndState == AllEnum.MainlineLastEndState.Fobidden)
      local goLockEffect = goLock:Find("rtZsing")
      if goLockEffect ~= nil then
        goLockEffect.gameObject:SetActive(lastEndState == AllEnum.MainlineLastEndState.Fobidden)
      else
        goLockEffect = self:CreatePrefabInstance("UI/MainlineEx/FX/fx_BranchLockEffect.prefab", goLock)
        goLockEffect.name = "rtZsing"
        goLockEffect.gameObject:SetActive(lastEndState == AllEnum.MainlineLastEndState.Fobidden)
      end
      txtLevelIndex.gameObject:SetActive(bUnlock)
      if bReaded then
        NovaAPI.SetTMPText(txtLevelName, storyConfig.Title)
      else
        NovaAPI.SetTMPText(txtLevelName, ConfigTable.GetUIText("Story_NewEnd_Unlock"))
      end
      if #self.tbBranch[avgId] == 1 then
      end
      local imgLockBg = branchGrid:Find("AnimRoot/goLock/imgBranchGridBgLock")
      imgLockBg.gameObject:SetActive(not bUnlock)
      local txtUnlock = branchGrid:Find("AnimRoot/goUnlock/txtUnlock"):GetComponent("TMP_Text")
      txtUnlock.gameObject:SetActive(false)
      NovaAPI.SetTMPText(txtUnlock, ConfigTable.GetUIText("Story_Unkown_End"))
      local imgLock = branchGrid:Find("AnimRoot/goLock/imgLock")
      imgLock.gameObject:SetActive(not bUnlock)
      local RedDot = branchGrid:Find("AnimRoot/RedDot")
      local bNew = 0 < table.indexof(self.tbFocusNode, v.Id) and not bReaded
      RedDot.gameObject:SetActive(bNew)
      imgNewUnlock.gameObject:SetActive(bNew)
      imgNewUnlockBg.gameObject:SetActive(bNew)
      local btnEnter = branchGrid:GetComponent("UIButton")
      btnEnter.onClick:RemoveAllListeners()
      btnEnter.onClick:AddListener(function()
        if lastEndState == AllEnum.MainlineLastEndState.Fobidden then
          local sTip = ConfigTable.GetUIText("Mainline_Last_End_Fobidden_Click")
          EventManager.Hit(EventId.OpenMessageBox, sTip)
          return
        end
        self:OnClickGrid(v.StoryId)
      end)
    end
    index = index + 1
  end
  root.gameObject:SetActive(bHasUnlockBranch)
  if bHasUnlockBranch then
    if not isNeedPlayUnlockAnim or not bHasUnReadBranch then
      self:PlayUnlockAnim(root, "BranchRoot_loop" .. nUnlockBranchCount)
    else
      self:PlayUnlockAnim(root, "BranchRoot_Empty")
    end
  end
  if 2 < nUnlockBranchCount then
    if self.tbBranchOverflowDepths == nil then
      self.tbBranchOverflowDepths = {}
    end
    table.insert(self.tbBranchOverflowDepths, depth)
  end
end

function ChapterLineCtrl:ApplyLayoutContentRightPadding()
  local maxLockDepth = self.maxLockRootDepth or 0
  local bWide = false
  local tbOverflow = self.tbBranchOverflowDepths or {}
  for _, branchDepth in ipairs(tbOverflow) do
    if branchDepth >= maxLockDepth then
      bWide = true
      break
    end
  end
  local targetRight = bWide and 400 or 200
  local layoutContent = self._mapNode.layoutContent
  if layoutContent.padding.right ~= targetRight then
    local padding = layoutContent.padding
    NovaAPI.SetLayoutGroupPadding(layoutContent.gameObject, padding.left, targetRight, padding.top, padding.bottom)
  end
end

function ChapterLineCtrl:RefreshTimeStamp(goTimeStamp, index)
  local timeStampName
  local nId = self.curChapter * 100 + index
  local config = ConfigTable.GetData("StoryChapterTimeStamp", nId)
  if config == nil then
    return
  end
  timeStampName = config.TimeStamp
  if timeStampName == nil then
    goTimeStamp.gameObject:SetActive(false)
    return
  end
  local tranTimeStamp = goTimeStamp:GetChild(0)
  local imgFocus = tranTimeStamp:Find("imgFocus")
  imgFocus.gameObject:SetActive(index == self.curTimeStamp)
  local imgBg = tranTimeStamp:Find("imgBg")
  imgBg.gameObject:SetActive(index ~= self.curTimeStamp)
  local txtTimeTitle = tranTimeStamp:Find("imgFocus/txtTimeTitle"):GetComponent("TMP_Text")
  local imgStage = txtTimeTitle.transform:Find("imgStage")
  imgStage.gameObject:SetActive(index == self.curTimeStamp)
  if index > self.maxUnlockDepth and 0 < self.curTimeStamp then
    timeStampName = ConfigTable.GetUIText("No_Arrived_Future")
  end
  NovaAPI.SetTMPText(txtTimeTitle, timeStampName)
  local txtTimeTitle = tranTimeStamp:Find("imgBg/txtTimeTitle"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtTimeTitle, timeStampName)
end

function ChapterLineCtrl:CheckLineReasonable(grid)
  local avgId = grid.name
  local storyConfig = AvgData:GetStoryCfgData(avgId)
  local goLeftBorder = grid:Find("goLeftBorder")
  local uiCamera = GameCameraStackManager.Instance.uiCamera
  if grid.gameObject.activeInHierarchy == false then
  end
  if self.tbShortenedLines == nil then
    self.tbShortenedLines = {}
  end
  for i = 1, goLeftBorder.childCount do
    local line = goLeftBorder:GetChild(i - 1)
    local lineRect = line:GetComponent("RectTransform")
    for index = 1, #storyConfig.ParentStoryId do
      local parentAvgId = storyConfig.ParentStoryId[index]
      local curBorderPos = self.tbGridBorderPos and self.tbGridBorderPos[avgId]
      local parentBorderPos = self.tbGridBorderPos and self.tbGridBorderPos[parentAvgId]
      if curBorderPos ~= nil and curBorderPos.left ~= nil and parentBorderPos ~= nil and parentBorderPos.right ~= nil then
        local isHitA, worldPosA = RectTransformUtility.ScreenPointToWorldPointInRectangle(grid, parentBorderPos.right, uiCamera)
        local isHitB, worldPosB = RectTransformUtility.ScreenPointToWorldPointInRectangle(grid, curBorderPos.left, uiCamera)
        local localPosA = grid:InverseTransformPoint(worldPosA)
        local localPosB = grid:InverseTransformPoint(worldPosB)
        local dir = parentBorderPos.right - curBorderPos.left
        local expectedAngle = math.deg(math.atan(dir.y, dir.x))
        local lineAngle = lineRect.eulerAngles.z
        local angleDiff = ((expectedAngle - lineAngle) % 180 + 180) % 180
        if 90 < angleDiff then
          angleDiff = 180 - angleDiff
        end
        if not (5 < angleDiff) then
          local screenDist = (localPosA - localPosB).magnitude
          local lineWidthScreen = lineRect.sizeDelta.x
          local newSizeDelta = screenDist
          if not (math.abs(screenDist - lineWidthScreen) <= 18) then
            if 1 > lineRect.pivot.x then
              lineRect.pivot = Vector2(1, 0.5)
              lineRect.anchoredPosition = Vector2(0, 0)
            end
            if screenDist > lineWidthScreen then
              lineRect.sizeDelta = Vector2(newSizeDelta, lineRect.sizeDelta.y)
            elseif screenDist < lineWidthScreen then
              lineRect.sizeDelta = Vector2(newSizeDelta, lineRect.sizeDelta.y)
              self.tbShortenedLines[avgId] = {
                lineIndex = i,
                parentAvgId = parentAvgId,
                originalWidth = newSizeDelta
              }
            end
          end
        end
      end
    end
  end
end

function ChapterLineCtrl:RefreshCurNodeDepthByNewUnlock()
  local tbGridList = self.tbGridList or {}
  local snapshotKey = "MainlineUnlockSnapshot_" .. tostring(self.curChapter)
  local depthKey = "MainlineCurNodeDepth_" .. tostring(self.curChapter)
  local prevUnlockSet = {}
  local snapshotRaw = LocalData.GetPlayerLocalData(snapshotKey)
  if type(snapshotRaw) == "string" and snapshotRaw ~= "" then
    for storyId in string.gmatch(snapshotRaw, "([^,]+)") do
      prevUnlockSet[storyId] = true
    end
  end
  local deepestDepth
  local curUnlockIds = {}
  local parentDepthMap = {}
  for _, v in ipairs(tbGridList) do
    parentDepthMap[v.avgId] = v.depth
    local storyConfig = AvgData:GetStoryCfgData(v.avgId)
    if storyConfig ~= nil then
      local bUnlock = AvgData:IsUnlock(storyConfig.ConditionId, storyConfig.StoryId)
      if bUnlock then
        local storyIdKey = tostring(storyConfig.Id)
        table.insert(curUnlockIds, storyIdKey)
        if not prevUnlockSet[storyIdKey] and (deepestDepth == nil or deepestDepth < v.depth) then
          deepestDepth = v.depth
        end
      end
    end
  end
  local tbBranch = self.tbBranch or {}
  for parentAvgId, branchList in pairs(tbBranch) do
    local parentDepth = parentDepthMap[parentAvgId]
    for _, branchData in ipairs(branchList) do
      local bUnlock = AvgData:IsUnlock(branchData.ConditionId, branchData.StoryId)
      if bUnlock then
        local branchIdKey = tostring(branchData.Id)
        table.insert(curUnlockIds, branchIdKey)
        if not prevUnlockSet[branchIdKey] and parentDepth ~= nil and (deepestDepth == nil or deepestDepth < parentDepth) then
          deepestDepth = parentDepth
        end
      end
    end
  end
  if deepestDepth ~= nil then
    self.curNodeDepth = deepestDepth
    LocalData.SetPlayerLocalData(depthKey, deepestDepth)
  else
    local savedDepth = LocalData.GetPlayerLocalData(depthKey)
    local nSavedDepth = tonumber(savedDepth)
    if nSavedDepth ~= nil and 0 < nSavedDepth then
      self.curNodeDepth = nSavedDepth
    end
  end
  LocalData.SetPlayerLocalData(snapshotKey, table.concat(curUnlockIds, ","))
end

function ChapterLineCtrl:RefreshUnlockAnimList()
  self.tbNeedPlayUnlockAnimGird = {}
  self.curShouldPlayDepth = 9999
  if not self.bNeedPlayUnlockAnim and not self.bNeedPlayBranchAnim then
    return
  end
  local cachedGird = {}
  for k, v in ipairs(self.tbGridList) do
    local storyConfig = AvgData:GetStoryCfgData(v.avgId)
    if table.indexof(self.tbFocusNode, storyConfig.Id) > 0 then
      local bHasPlayedAnim = LocalData.GetPlayerLocalData("MainlineUnlock_" .. storyConfig.Id)
      if (bHasPlayedAnim == nil or bHasPlayedAnim == 0) and cachedGird[v.avgId] == nil then
        table.insert(self.tbNeedPlayUnlockAnimGird, v)
        cachedGird[v.avgId] = v
        if self.curShouldPlayDepth > v.depth then
          self.curShouldPlayDepth = v.depth
        end
      end
    else
      for _, parentNode in pairs(storyConfig.ParentStoryId) do
        local panentConfig = AvgData:GetStoryCfgData(parentNode)
        local parentId = panentConfig.Id
        if cachedGird[parentNode] ~= nil then
          local parentStoryConfig = AvgData:GetStoryCfgData(parentNode)
          local bHasPlayedAnim = LocalData.GetPlayerLocalData("MainlineUnlock_" .. storyConfig.Id)
          local parentUnlock = AvgData:IsUnlock(parentStoryConfig.ConditionId, parentStoryConfig.StoryId)
          if cachedGird[v.avgId] == nil and (bHasPlayedAnim == nil or bHasPlayedAnim == 0) and parentUnlock then
            if storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.LastEndType then
              local lastEndState = AvgData:GetLastEndState()
              if lastEndState == AllEnum.MainlineLastEndState.WaitUnlock then
                table.insert(self.tbNeedPlayUnlockAnimGird, v)
              end
            else
              table.insert(self.tbNeedPlayUnlockAnimGird, v)
            end
            cachedGird[v.avgId] = v
            if self.curShouldPlayDepth > v.depth then
              self.curShouldPlayDepth = v.depth
            end
          end
        elseif table.indexof(self.tbFocusNode, parentId) > 0 then
          local parentStoryConfig = AvgData:GetStoryCfgData(parentNode)
          local bHasPlayedAnim = LocalData.GetPlayerLocalData("MainlineUnlock_" .. parentStoryConfig.Id)
          if bHasPlayedAnim == nil or bHasPlayedAnim == 0 then
            bHasPlayedAnim = LocalData.GetPlayerLocalData("MainlineUnlock_" .. storyConfig.Id)
            if cachedGird[v.avgId] == nil and (bHasPlayedAnim == nil or bHasPlayedAnim == 0) then
              table.insert(self.tbNeedPlayUnlockAnimGird, v)
              cachedGird[v.avgId] = v
              if self.curShouldPlayDepth > v.depth then
                self.curShouldPlayDepth = v.depth
              end
            end
          end
        end
      end
    end
  end
end

function ChapterLineCtrl:DoPlayUnlockAnim(depth)
  local nodes = {}
  for _, node in ipairs(self.tbNeedPlayUnlockAnimGird) do
    if node.depth == depth then
      table.insert(nodes, node)
    end
  end
  if #nodes == 0 then
    local nextDepth
    for _, node in ipairs(self.tbNeedPlayUnlockAnimGird) do
      if depth < node.depth and (nextDepth == nil or nextDepth > node.depth) then
        nextDepth = node.depth
      end
    end
    if nextDepth ~= nil then
      self:DoPlayUnlockAnim(nextDepth)
    end
    return
  end
  local samDepthAvgIds = {}
  for _, node in ipairs(nodes) do
    samDepthAvgIds[node.avgId] = true
  end
  local parentNodes = {}
  local childNodes = {}
  for _, node in ipairs(nodes) do
    local storyConfig = AvgData:GetStoryCfgData(node.avgId)
    local bIsSameDepthChild = false
    for _, parentId in pairs(storyConfig.ParentStoryId) do
      if samDepthAvgIds[parentId] then
        bIsSameDepthChild = true
        break
      end
    end
    if bIsSameDepthChild then
      table.insert(childNodes, node)
    else
      table.insert(parentNodes, node)
    end
  end
  self._samDepthChildNodes = self._samDepthChildNodes or {}
  self._samDepthChildNodes[depth] = childNodes
  self._samDepthParentCount = self._samDepthParentCount or {}
  self._samDepthParentCount[depth] = #parentNodes
  for _, node in ipairs(parentNodes) do
    self:PlayGridUnlockAnim(node, depth)
  end
end

function ChapterLineCtrl:DoPlaySameDepthChildAnim(depth)
  local childNodes = self._samDepthChildNodes and self._samDepthChildNodes[depth]
  if childNodes == nil or #childNodes == 0 then
    return
  end
  self._samDepthChildNodes[depth] = nil
  for _, node in ipairs(childNodes) do
    self:PlayGridUnlockAnim(node, depth)
  end
end

function ChapterLineCtrl:PlayGridUnlockAnim(nodeInfo, depth)
  local storyConfig = AvgData:GetStoryCfgData(nodeInfo.avgId)
  if storyConfig.IsBranch then
    nodeInfo.grid.gameObject:SetActive(true)
    self:PlayBranchNodeUnlockAnim(nodeInfo, depth)
  else
    self:PlayNormalNodeUnlockAnim(nodeInfo, depth)
  end
end

function ChapterLineCtrl:PlayNormalNodeUnlockAnim(nodeInfo, depth)
  local grid = nodeInfo.grid.transform
  local storyConfig = AvgData:GetStoryCfgData(nodeInfo.avgId)
  local imgLeftPoint_1 = grid:Find("imgLeftPoint_1")
  local imgRightPoint_1 = grid:Find("imgRightPoint_1")
  local goLeftBorder = grid:Find("goLeftBorder")
  local goRightBorder = grid:Find("goRightBorder")
  local allLine = {}
  for i = 0, goLeftBorder.transform.childCount - 1 do
    table.insert(allLine, goLeftBorder.transform:GetChild(i))
  end
  grid.gameObject:SetActive(true)
  local bLeftActived = imgLeftPoint_1.gameObject.activeInHierarchy
  local bRightActived = imgRightPoint_1.gameObject.activeInHierarchy
  local goLineContinue = grid:Find("lineContinue")
  imgRightPoint_1.gameObject:SetActive(false)
  imgLeftPoint_1.gameObject:SetActive(false)
  goLineContinue.gameObject:SetActive(false)
  local bUnlock = AvgData:IsUnlock(storyConfig.ConditionId, storyConfig.StoryId)
  local batteleNode = grid:Find("btnEnter/AnimRoot/BattleRoot")
  local normalNode = grid:Find("btnEnter/AnimRoot/NormalRoot")
  local lockNode = grid:Find("btnEnter/AnimRoot/LockRoot")
  local specialNode = grid:Find("btnEnter/AnimRoot/SpecialRoot")
  batteleNode.gameObject:SetActive(false)
  normalNode.gameObject:SetActive(false)
  lockNode.gameObject:SetActive(false)
  local isSpecial = storyConfig.MemoryType ~= GameEnum.MainlineMemoryNodeType.None
  if isSpecial then
    specialNode.gameObject:SetActive(false)
    if storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.LastEndType and not bUnlock then
      grid.gameObject:SetActive(false)
    end
  end
  local rootNode
  local bNewUnlock = 0 < table.indexof(self.tbLockedPlayedAnim, nodeInfo.avgId)
  if bNewUnlock then
    lockNode.gameObject:SetActive(true)
    table.removebyvalue(self.tbLockedPlayedAnim, nodeInfo.avgId)
  end
  if bUnlock then
    if isSpecial then
      local specialNode = specialNode:Find("Type" .. storyConfig.MemoryType)
      if specialNode ~= nil then
        rootNode = specialNode
      end
    else
      rootNode = storyConfig.IsBattle == true and batteleNode or normalNode
    end
  else
    rootNode = lockNode
    table.insert(self.tbLockedPlayedAnim, nodeInfo.avgId)
  end
  local PlayLineAnimTime = 0.01
  if 0 < #allLine and not bNewUnlock then
    PlayLineAnimTime = self.lineAnimTime
    for k, v in ipairs(allLine) do
      self:PlayLineAnim(v)
    end
    self:AddTimer(1, self.lineAnimTime, function()
      imgLeftPoint_1.gameObject:SetActive(bLeftActived)
    end, true, true, true)
  elseif bNewUnlock then
    imgLeftPoint_1.gameObject:SetActive(bLeftActived)
  end
  
  local function DoAfterAnim(time)
    self:AddTimer(1, time, function()
      imgRightPoint_1.gameObject:SetActive(bRightActived)
      if not bUnlock then
        local isParentSpecial = self:CheckIsParentSpecialNode(nodeInfo.avgId)
        if bRightActived or isParentSpecial then
          goLineContinue.gameObject:SetActive(true)
          self:PlayLineAnim(goLineContinue)
        end
      else
        local imgFocus = rootNode:Find("imgFocus")
        local bReaded = AvgData:IsStoryReaded(storyConfig.Id)
        local RedDot = rootNode:Find("RedDot")
        local bFocus = table.indexof(self.tbFocusNode, storyConfig.Id) > 0 and (not bReaded or self.bFocusLastNode)
        imgFocus.gameObject:SetActive(bFocus)
        RedDot.gameObject:SetActive(bFocus and not bReaded)
        if self._samDepthParentCount and self._samDepthParentCount[depth] ~= nil then
          self._samDepthParentCount[depth] = self._samDepthParentCount[depth] - 1
          if 0 >= self._samDepthParentCount[depth] then
            self._samDepthParentCount[depth] = nil
            self:DoPlaySameDepthChildAnim(depth)
            self:DoPlayUnlockAnim(depth + 1)
          end
        else
          self:DoPlayUnlockAnim(depth + 1)
        end
      end
    end, true, true, true)
  end
  
  self:AddTimer(1, PlayLineAnimTime, function()
    lockNode.gameObject:SetActive(false)
    if bUnlock or storyConfig.MemoryType ~= GameEnum.MainlineMemoryNodeType.LastEndType then
      rootNode.gameObject:SetActive(true)
    end
    if isSpecial then
      specialNode.gameObject:SetActive(true)
    end
    local animName = ""
    if isSpecial and bUnlock then
      if storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.DiscType then
        animName = "SpecialRoot_in"
      elseif storyConfig.MemoryType == GameEnum.MainlineMemoryNodeType.LastEndType then
        animName = "SpecialRoot02_in"
      end
    else
      animName = bUnlock and "BattleRoot_in" or "LockRoot_in"
    end
    if bUnlock then
      LocalData.SetPlayerLocalData("MainlineUnlock_" .. storyConfig.Id, 1)
      if isSpecial then
        WwiseAudioMgr:PostEvent("ui_mainline_memory_unlock")
      else
        WwiseAudioMgr:PostEvent("ui_mainline_level")
      end
    end
    local animTime = 0
    animTime = self:PlayUnlockAnim(rootNode, animName)
    animTime = animTime == 0 and 0.01 or animTime
    DoAfterAnim(animTime)
  end, true, true, true)
end

function ChapterLineCtrl:PlayBranchNodeUnlockAnim(nodeInfo, depth)
  self:PlayUnlockAnim(nodeInfo.grid, "BranchRoot_in" .. nodeInfo.totalCount)
  WwiseAudioMgr:PostEvent("ui_mainline_newending")
  local storyConfig = AvgData:GetStoryCfgData(nodeInfo.avgId)
  LocalData.SetPlayerLocalData("MainlineUnlock_" .. storyConfig.Id, 1)
end

function ChapterLineCtrl:PlayUnlockAnim(go, animName)
  local animator = go:GetComponent("Animator")
  animator.enabled = true
  animator:Play(animName)
  local nAnimLength = NovaAPI.GetAnimClipLength(animator, {animName})
  return nAnimLength
end

function ChapterLineCtrl:PlayLineAnim(goLine)
  local lineRect = goLine:GetComponent("RectTransform")
  if lineRect.pivot.x > 0 then
    lineRect.pivot = Vector2(0, 0.5)
    local Pos = lineRect.localPosition
    local angle = math.rad(lineRect.localEulerAngles.z)
    lineRect.localPosition = Vector3(Pos.x - lineRect.rect.width * math.cos(angle), Pos.y - lineRect.rect.width * math.sin(angle), Pos.z)
  end
  lineRect.localScale = Vector3(0, 1, 1)
  lineRect:DOScaleX(1, self.lineAnimTime)
end

function ChapterLineCtrl:GetTimeUnlockLockText(remainTime)
  local lockTxt = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    lockTxt = orderedFormat(ConfigTable.GetUIText("Mainline_Open_Time_Day") or "", day, hour)
  end
  return lockTxt
end

function ChapterLineCtrl:OnClickGrid(avgId)
  if self.bCanClick == false then
    return
  end
  local storyConfig = AvgData:GetStoryCfgData(avgId)
  local configValue = ConfigTable.GetConfigValue("TimeUnlockStory", "")
  if configValue ~= nil and configValue == avgId then
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local time = ConfigTable.GetConfigValue("StoryUnlockTime", "")
    local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(time)
    if curTime < openTime then
      WwiseAudioMgr:PostEvent("ui_systerm_locked")
      local lockTxt = self:GetTimeUnlockLockText(openTime - curTime)
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = lockTxt
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
  end
  local bUnlock, tbResult = AvgData:IsUnlock(storyConfig.ConditionId, avgId)
  if not bUnlock then
    WwiseAudioMgr:PostEvent("ui_systerm_locked")
    if tbResult ~= nil then
      local lockTxt = AvgData:GetLockReasonText(tbResult, self.bHasAchievementData)
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = lockTxt
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
    return
  end
  WwiseAudioMgr:PostEvent("ui_common_menu3")
  local nRecentStoryId = AvgData:GetRecentStoryId(self.curChapter)
  local recentStoryAvgId = ConfigTable.GetData_Story(nRecentStoryId).StoryId
  local findCount = 0
  local recentStoryDepth = 0
  local curDepth = 0
  for k, v in ipairs(self.tbGridList) do
    local gridName = v.grid.name
    if gridName == avgId then
      findCount = findCount + 1
      curDepth = v.depth
    end
    if gridName == recentStoryAvgId then
      findCount = findCount + 1
      recentStoryDepth = v.depth
    end
    if findCount == 2 then
      break
    end
  end
  self.curChosenStory = avgId
  EventManager.Hit(EventId.ChoseMainlineStory, avgId, curDepth >= recentStoryDepth)
end

function ChapterLineCtrl:OnEvent_Story_RewardClosed()
  if self.bNeedPlayUnlockAnim or self.bNeedPlayBranchAnim then
    if self.bNeedPlayBranchAnim and self.tbNeedPlayUnlockAnimGird[1] ~= nil then
      self.curShouldPlayDepth = self.tbNeedPlayUnlockAnimGird[1].depth
    end
    self:DoPlayUnlockAnim(self.curShouldPlayDepth)
  end
end

function ChapterLineCtrl:OnEvent_Story_Done(bHasReward)
  if not bHasReward and (self.bNeedPlayUnlockAnim or self.bNeedPlayBranchAnim) then
    if self.bNeedPlayBranchAnim and self.tbNeedPlayUnlockAnimGird[1] ~= nil then
      self.curShouldPlayDepth = self.tbNeedPlayUnlockAnimGird[1].depth
    end
    self:AddTimer(1, 1.5, function()
      self:DoPlayUnlockAnim(self.curShouldPlayDepth)
    end, true, true, true)
  end
end

function ChapterLineCtrl:CacheCurChapterConfig()
  self.tbChapterStoryNumIds = AvgData:GetChapterStoryNumIds(self.curChapter)
end

function ChapterLineCtrl:CacheChapterBranchNode()
  self.tbBranch = {}
  for i, v in ipairs(self.tbChapterStoryNumIds) do
    local data = ConfigTable.GetData_Story(v)
    if data.IsBranch then
      if self.tbBranch[data.ParentStoryId[1]] == nil then
        self.tbBranch[data.ParentStoryId[1]] = {}
      end
      table.insert(self.tbBranch[data.ParentStoryId[1]], data)
    end
  end
end

function ChapterLineCtrl:IsAllStoryCompleted()
  for k, v in ipairs(self.tbGridList) do
    local avgId = v.grid.name
    local cfg = AvgData:GetStoryCfgData(avgId)
    if cfg.IsLast and self.curChosenStory == v.grid.name then
      local nStoryId = AvgData.CFG_Story[avgId]
      return AvgData:IsStoryReaded(nStoryId)
    end
  end
  return false
end

function ChapterLineCtrl:ForbidClick()
  self.bCanClick = false
  self:AddTimer(1, 1.5, function()
    self.bCanClick = true
  end, true, true, true)
end

function ChapterLineCtrl:CheckIsParentSpecialNode(avgId)
  local storyConfig = AvgData:GetStoryCfgData(avgId)
  if storyConfig == nil then
    return false
  end
  for _, parentId in pairs(storyConfig.ParentStoryId) do
    local parentConfig = AvgData:GetStoryCfgData(parentId)
    return parentConfig ~= nil and parentConfig.MemoryType ~= GameEnum.MainlineMemoryNodeType.None
  end
  return false
end

function ChapterLineCtrl:CheckIsChildSpecialNode(avgId)
  for k, v in pairs(self.tbDiscNodeParentGrid) do
    for _, parentId in ipairs(v) do
      if parentId == avgId then
        local childId = k
        local childConfig = AvgData:GetStoryCfgData(childId)
        local isUnlock = AvgData:IsUnlock(childConfig.ConditionId, childConfig.StoryId)
        return isUnlock, childConfig.MemoryType
      end
    end
  end
  if self.LastEndNodeAvgId ~= nil then
    local childConfig = AvgData:GetStoryCfgData(self.LastEndNodeAvgId)
    for _, parentId in ipairs(childConfig.ParentStoryId) do
      if parentId == avgId then
        local lastEndState = AvgData:GetLastEndState()
        if lastEndState ~= nil and lastEndState ~= AllEnum.MainlineLastEndState.None then
          return true, GameEnum.MainlineMemoryNodeType.LastEndType
        else
          return false, GameEnum.MainlineMemoryNodeType.None
        end
      end
    end
  end
  return false, GameEnum.MainlineMemoryNodeType.None
end

return ChapterLineCtrl
