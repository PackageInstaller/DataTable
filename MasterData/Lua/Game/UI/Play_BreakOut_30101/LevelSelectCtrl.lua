local LevelSelectCtrl = class("LevelSelectCtrl", BaseCtrl)
local BreakOutData_00 = require("GameCore.Data.DataClass.Activity.BreakOutData_00")
local DifficultyState = {
  "Entry",
  "Newbie",
  "Advanced",
  "Expert"
}
LevelSelectCtrl._mapNodeConfig = {
  btn_Left = {
    sNodeName = "btn_Left",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btn_Right = {
    sNodeName = "btn_Right",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  txt_DifficultyTitle = {sComponentName = "TMP_Text"},
  img_RightIcon = {},
  img_LeftIcon = {},
  goLevel = {},
  LevelList = {
    sComponentName = "RectTransform"
  },
  Grids = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  goGrid_ = {
    nCount = 6,
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutLevelCellCtrl"
  },
  DotList = {
    sComponentName = "RectTransform"
  },
  imgPointBg = {nCount = 4}
}
LevelSelectCtrl._mapEventConfig = {
  DragLevelList = "OnDrag_ActBanner",
  BreakOutLevelCell_OnSelected = "OnEvent_LevelSelected",
  SetSelectedTab = "SetSelectedTab"
}
LevelSelectCtrl._mapRedDotConfig = {}

function LevelSelectCtrl:Awake()
  self.bIsActEnd = false
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.BreakOut_30101Data = PlayerData.Activity:GetActivityGroupDataById(self.nActId)
  if self.BreakOut_30101Data == nil then
    printError("活动组 id:" .. self.nActId .. " 数据为空")
    return
  end
  local nIndex = AllEnum.ActivityThemeFuncIndex.Level
  local actData = self.BreakOut_30101Data:GetActivityDataByIndex(nIndex)
  self.nActId = actData.ActivityId
  self.BreakOutData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    self.BreakOutData_00 = BreakOutData_00.new()
    printError("活动 id:" .. self.nActId .. " 数据为空，开始初始化本地备用数据")
    local tableData = {}
    
    local function ForeachActivity(mapData)
      if self.nActId == mapData.ActivityId then
        table.insert(tableData, mapData.Id)
      end
    end
    
    ForEachTableLine(ConfigTable.Get("BreakOutLevel"), ForeachActivity)
    self.BreakOutData_00:RefreshBreakOutData(tableData)
  end
end

function LevelSelectCtrl:OnDisable()
  for index, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[index] = nil
  end
  self.tbGridCtrl = {}
  if self.tweener ~= nil then
    self.tweener:Kill()
    self.tweener = nil
  end
end

function LevelSelectCtrl:OnEnable()
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    printError("活动 id:" .. self.nActId .. " 数据为空，无法记录当前的难度状态默认定位初始难度")
  else
    local param = self:GetPanelParam()
    if type(param) == "table" then
      self.nSelectedTabIndex = param[2] == nil and self.BreakOutData:GetCurrentSelectedTabIndex() or param[2]
    end
  end
  self.tbInitPos = {}
  for _, v in ipairs(self._mapNode.Grids) do
    self.nGridsWidth = v.sizeDelta.x
    table.insert(self.tbInitPos, v.anchoredPosition)
  end
  self.bCanClick = true
  if self.nSelectedTabIndex == nil then
    self.nSelectedTabIndex = 1
  end
  self.bIsActEnd = self.BreakOut_30101Data:IsActCloseTime()
  self:Init()
end

function LevelSelectCtrl:Init()
  self.tbLevel = {}
  self.tbGridCtrl = {}
  self:SetBanner()
  self:RefreshTabIcon()
  self:RefreshDotsIcon()
  self:RefreshLevelTitle()
end

function LevelSelectCtrl:RefreshLevel(tbCurLevelList, index)
  if self.tbGridCtrl ~= nil then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
  end
  for i = 1, #tbCurLevelList do
    if index == 1 then
      self:OnRefreshLevelGrid(i, tbCurLevelList[i].Id, self.bIsActEnd)
    end
    if index == 2 then
      self:OnRefreshLevelGrid(i + 2, tbCurLevelList[i].Id, self.bIsActEnd)
    end
    if index == 3 then
      self:OnRefreshLevelGrid(i + 4, tbCurLevelList[i].Id, self.bIsActEnd)
    end
  end
end

function LevelSelectCtrl:OnRefreshLevelGrid(gridIndex, goLevelId, bIsActEnd)
  self._mapNode.goGrid_[gridIndex]:SetData(self.nActId, goLevelId, bIsActEnd)
end

function LevelSelectCtrl:OnBtnClick_Left()
  if not self.bCanClick then
    return
  end
  self.bCanClick = false
  self.nSelectedTabIndex = math.max(self.nSelectedTabIndex - 1, GameEnum.ActivityBreakoutLevelType.Entry)
  self.nTypeIdx = self.nSelectedTabIndex
  self:RemoveGridsToRight()
end

function LevelSelectCtrl:OnBtnClick_Right()
  if not self.bCanClick then
    return
  end
  self.bCanClick = false
  self.nSelectedTabIndex = math.min(self.nSelectedTabIndex + 1, GameEnum.ActivityBreakoutLevelType.Expert)
  self.nTypeIdx = self.nSelectedTabIndex
  self:RemoveGridsToLeft()
end

function LevelSelectCtrl:RefreshLevelState()
  self:RefreshGrids()
  self:RefreshTabIcon()
  self:RefreshDotsIcon()
end

function LevelSelectCtrl:RefreshTabIcon()
  local bisMin = self.nSelectedTabIndex ~= GameEnum.ActivityBreakoutLevelType.Entry
  local bisMax = self.nSelectedTabIndex ~= GameEnum.ActivityBreakoutLevelType.Expert
  self._mapNode.btn_Left.gameObject:SetActive(bisMin)
  self._mapNode.btn_Right.gameObject:SetActive(bisMax)
  self:RefreshTabRedIcon()
end

function LevelSelectCtrl:RefreshTabRedIcon()
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    self._mapNode.img_RightIcon:SetActive(false)
    self._mapNode.img_LeftIcon:SetActive(false)
    return
  end
  local nMinLevelId = self.BreakOutData:GetUnFinishEasyLevel()
  if nMinLevelId == nil or not self.BreakOutData:IsLevelTimeUnlocked(nMinLevelId) then
    self._mapNode.img_RightIcon:SetActive(false)
    self._mapNode.img_LeftIcon:SetActive(false)
  else
    local MinType = self.BreakOutData:GetBreakoutLevelDifficult(nMinLevelId)
    if self.nSelectedTabIndex == MinType then
      self._mapNode.img_RightIcon:SetActive(false)
      self._mapNode.img_LeftIcon:SetActive(false)
    elseif MinType < self.nSelectedTabIndex then
      self._mapNode.img_RightIcon:SetActive(false)
      self._mapNode.img_LeftIcon:SetActive(true)
    elseif MinType > self.nSelectedTabIndex then
      self._mapNode.img_RightIcon:SetActive(true)
      self._mapNode.img_LeftIcon:SetActive(false)
    end
  end
end

function LevelSelectCtrl:RefreshDotsIcon()
  local nMaxNum = 4
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    nMaxNum = self.BreakOutData_00:GetBreakoutLevelTypeNum()
  else
    nMaxNum = self.BreakOutData:GetBreakoutLevelTypeNum()
  end
  for i = 1, nMaxNum do
    if nil ~= self._mapNode.imgPointBg[i] then
      self._mapNode.imgPointBg[i].transform:Find("imgPoint").gameObject:SetActive(false)
    end
  end
  self._mapNode.imgPointBg[self.nSelectedTabIndex].transform:Find("imgPoint").gameObject:SetActive(true)
end

function LevelSelectCtrl:RefreshLevelTitle()
  local sDifficultState = ConfigTable.GetUIText(DifficultyState[self.nSelectedTabIndex])
  local sTitle = orderedFormat(ConfigTable.GetUIText("DifficultyType") or "", sDifficultState)
  NovaAPI.SetTMPText(self._mapNode.txt_DifficultyTitle, sTitle)
end

function LevelSelectCtrl:SetBanner()
  self.tbGridsList = {}
  self:AddGrids()
  if nil == self.tbGridsList or nil == next(self.tbGridsList) then
    self._mapNode.goLevel.gameObject:SetActive(false)
  else
    self._mapNode.goLevel.gameObject:SetActive(true)
    self.nTypeIdx = self.nSelectedTabIndex
    self.nLastTypeIdx = 1
    self:RefreshGrids()
  end
end

function LevelSelectCtrl:AddGrids()
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    local nAllLevelType = self.BreakOutData_00:GetBreakoutLevelTypeNum()
    for i = 1, nAllLevelType do
      table.insert(self.tbGridsList, self.BreakOutData_00:GetLevelsByTab(i))
    end
  else
    local nAllLevelType = self.BreakOutData:GetBreakoutLevelTypeNum()
    for i = 1, nAllLevelType do
      table.insert(self.tbGridsList, self.BreakOutData:GetLevelsByTab(i))
    end
  end
end

function LevelSelectCtrl:RefreshGrids()
  local lastIndex = self.nTypeIdx - 1 <= 0 and 1 or self.nTypeIdx - 1
  local nextIndex = self.nTypeIdx + 1 > #self.tbGridsList and #self.tbGridsList or self.nTypeIdx + 1
  local tbCurLevelList = {}
  table.insert(tbCurLevelList, self.tbGridsList[lastIndex])
  table.insert(tbCurLevelList, self.tbGridsList[self.nTypeIdx])
  table.insert(tbCurLevelList, self.tbGridsList[nextIndex])
  for k, _ in ipairs(self._mapNode.Grids) do
    self:RefreshLevel(tbCurLevelList[k], k)
  end
  self.nSelectedTabIndex = self.nTypeIdx
  self:RefreshLevelTitle()
  self:RefreshTabIcon()
  self:RefreshDotsIcon()
end

function LevelSelectCtrl:OnDrag_ActBanner(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nBannerDragPosX = 0
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    if not self:CanOnDrag(mDrag.EventData.delta.x) then
      return
    end
    self.nBannerDragPosX = self.nBannerDragPosX + mDrag.EventData.delta.x
    if math.abs(self.nBannerDragPosX) >= self.nGridsWidth then
      if self.nBannerDragPosX > 0 then
        self.nBannerDragPosX = self.nGridsWidth
      else
        self.nBannerDragPosX = -self.nGridsWidth
      end
    end
    for k, v in ipairs(self._mapNode.Grids) do
      v.anchoredPosition = Vector2(self.tbInitPos[k].x + self.nBannerDragPosX, self.tbInitPos[k].y)
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local nPos = 0
    if self.nBannerDragPosX > 0 then
      nPos = self.nGridsWidth
      self.nTypeIdx = math.max(self.nTypeIdx - 1, 1)
    elseif self.nBannerDragPosX < 0 then
      nPos = -self.nGridsWidth
      self.nTypeIdx = math.min(self.nTypeIdx + 1, #self.tbGridsList)
    end
    for k, v in ipairs(self._mapNode.Grids) do
      self.tweener = v:DOAnchorPosX(self.tbInitPos[k].x + nPos, 0.2):SetUpdate(true)
    end
    
    local function _cb()
      for k, v in ipairs(self._mapNode.Grids) do
        v.anchoredPosition = self.tbInitPos[k]
      end
      self:RefreshGrids()
    end
    
    self.tweener.onComplete = dotween_callback_handler(self, _cb)
    self.nBannerDragPosX = 0
  end
end

function LevelSelectCtrl:RemoveGridsToLeft()
  local function onCompleteCb()
    self:GridsEnd()
  end
  
  for k, v in ipairs(self._mapNode.Grids) do
    if k == #self._mapNode.Grids then
      v:DOAnchorPosX(self.tbInitPos[k].x - self.nGridsWidth, 0.2):SetUpdate(true):OnComplete(onCompleteCb)
    else
      v:DOAnchorPosX(self.tbInitPos[k].x - self.nGridsWidth, 0.2):SetUpdate(true)
    end
  end
end

function LevelSelectCtrl:RemoveGridsToRight()
  local function onCompleteCb()
    self:GridsEnd()
  end
  
  for k, v in ipairs(self._mapNode.Grids) do
    if k == #self._mapNode.Grids then
      v:DOAnchorPosX(self.tbInitPos[k].x + self.nGridsWidth, 0.2):SetUpdate(true):OnComplete(onCompleteCb)
    else
      v:DOAnchorPosX(self.tbInitPos[k].x + self.nGridsWidth, 0.2):SetUpdate(true)
    end
  end
end

function LevelSelectCtrl:GridsEnd()
  for k, v in ipairs(self._mapNode.Grids) do
    v.anchoredPosition = self.tbInitPos[k]
  end
  self:RefreshLevelState()
  self.bCanClick = true
end

function LevelSelectCtrl:CanOnDrag(nMove_x)
  if 0 < nMove_x and self.nSelectedTabIndex == GameEnum.ActivityBreakoutLevelType.Entry then
    return false
  end
  if nMove_x < 0 and self.nSelectedTabIndex == GameEnum.ActivityBreakoutLevelType.Expert then
    return false
  end
  return true
end

function LevelSelectCtrl:SetSelectedTab(nSelectedTab)
  self._panel._tbParam[2] = nSelectedTab
end

return LevelSelectCtrl
