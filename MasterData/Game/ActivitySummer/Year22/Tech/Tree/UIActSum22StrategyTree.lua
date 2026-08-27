local UIActSum22StrategyTree = class("UIActSum22StrategyTree", UIBaseWindow)
local base = UIBaseWindow
local UINActSum22StrategyTreeItem = require("Game.ActivitySummer.Year22.Tech.UINActSum22StrategyTreeItem")
local UINActSum22StgMainTitleItem = require("Game.ActivitySummer.Year22.Tech.Main.UINActSum22StgMainTitleItem")
local UINActSum22TechInfo = require("Game.ActivitySummer.Year22.Tech.UINActSum22TechInfo")
local ActTechData = require("Game.ActivitySectorII.Tech.Data.ActTechData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local MAXCOL = 15
local cs_ResLoader = CS.ResLoader

function UIActSum22StrategyTree:OnInit()
  self._resloder = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self._OnClickClose)
  self.ui.obj_Line.gameObject:SetActive(false)
  self._techInfoNode = UINActSum22TechInfo.New()
  self._techInfoNode:Init(self.ui.techInfoNode)
  self._techInfoNode:SetActSum22TechInfoHideFnc(function()
    self.ui.tran_Select.gameObject:SetActive(false)
  end)
  self._techInfoNode:Hide()
  self._OnClickTechItemFunc = BindCallback(self, self._OnClickTechItem)
  self._techItemPool = UIItemPool.New(UINActSum22StrategyTreeItem, self.ui.techItem, false)
  self._branchTitleItemPool = UIItemPool.New(UINActSum22StgMainTitleItem, self.ui.titleItem, false)
end

function UIActSum22StrategyTree:InitActSum22TechTree(sum22Data, closeFunc)
  self._sum22Data = sum22Data
  self._closeFunc = closeFunc
  local techDataDic = sum22Data:GetSectorIIITechDic()
  local branchDataDic = {}
  self._branchDataDic = branchDataDic
  local brachNumDic = {}
  local lastRow = 0
  for k, techId in ipairs(ConfigData.activity_tech.actTechTypeList[sum22Data:GetActSct3TechType()].techIds) do
    local techData = techDataDic[techId] or ActTechData.CreatAWTechData(techId, ActivityFrameEnum.eActivityType.SectorIII, sum22Data.actId)
    local techItem = self._techItemPool:GetOne()
    techItem:InitActSum22StrategyItem(techData, self._resloder, self._OnClickTechItemFunc)
    techItem.transform:SetParent(self.ui.treeLayout.transform)
    local row, col = techData:GetActTechRowCol()
    local posX, posY = self:_GenTreeItemPos(row, col)
    techItem.transform.anchoredPosition = Vector2.Temp(posX, -posY)
    lastRow = math.max(lastRow, row)
    local branchId = techData:GetActTechBranch()
    brachNumDic[branchId] = brachNumDic[branchId] or {}
    brachNumDic[branchId][col] = true
    branchDataDic[branchId] = branchDataDic[branchId] or {}
    branchDataDic[branchId][techId] = techData
    self:_NewLine(techData, posX, posY, col)
  end
  local _, height = self:_GenTreeItemPos(lastRow, 0)
  local size = self.ui.treeLayout.transform.sizeDelta
  size.y = height + self.ui.treeLayout.cellSize.y * self.ui.techItem.transform.localScale.y
  self.ui.treeLayout.transform.sizeDelta = size
  local techType = sum22Data:GetActSct3TechType()
  self:_InitActBranch(techType, brachNumDic)
  self:_UpdBranchTitle()
end

function UIActSum22StrategyTree:_InitActBranch(techType, brachNumDic)
  local cellSize = self.ui.treeLayout.cellSize
  local spacing = self.ui.treeLayout.spacing
  local branchList = ConfigData.activity_tech_branch.techBranchTypeList[techType]
  self.branchTitleDic = {}
  for k, branchId in ipairs(branchList) do
    local branchCfg = ConfigData.activity_tech_branch[techType][branchId]
    local titleItem = self._branchTitleItemPool:GetOne()
    titleItem:InitActSum22StgMainTitleItem(branchCfg)
    self.branchTitleDic[branchId] = titleItem
    local colNum = 0
    if brachNumDic[branchId] ~= nil then
      colNum = table.count(brachNumDic[branchId])
    end
    local width = (cellSize.x + spacing.x) * colNum
    titleItem:SetActSum22StgMainTitleItemWidth(width)
  end
  local padding = self.ui.titleLayout.padding
  local offset = (spacing.x + (1 - self.ui.techItem.transform.localScale.x) * cellSize.x) * 0.5
  padding.left = math.floor(self.ui.treeLayout.padding.left - offset)
  self.ui.titleLayout.padding = padding
end

function UIActSum22StrategyTree:_GenTreeItemPos(row, col)
  local padding = self.ui.treeLayout.padding
  local spacing = self.ui.treeLayout.spacing
  local cellSize = self.ui.treeLayout.cellSize
  local x = padding.left + (col - 1) * (cellSize.x + spacing.x)
  local y = padding.top + (row - 1) * (cellSize.y + spacing.y)
  return x, y
end

function UIActSum22StrategyTree:_NewLine(techData, posX, posY, col)
  local preTechData = techData:GetPreTechData()
  if preTechData == nil then
    return
  end
  local cellSize = self.ui.treeLayout.cellSize
  local itemScale = self.ui.techItem.transform.localScale
  cellSize.x = cellSize.x * itemScale.x
  cellSize.y = cellSize.y * itemScale.y
  local preRow, preCol = preTechData:GetActTechRowCol()
  local prePosX, prePosY = self:_GenTreeItemPos(preRow, preCol)
  local lineTranV = self.ui.obj_Line:Instantiate()
  lineTranV.gameObject:SetActive(true)
  lineTranV.sizeDelta = Vector2.Temp(2, posY - prePosY - cellSize.y)
  if preCol == col then
    lineTranV.anchoredPosition = Vector2.Temp(prePosX - 1 + cellSize.x * 0.5, -prePosY - cellSize.y)
  else
    local halfSpaceY = lineTranV.sizeDelta.y * 0.5
    lineTranV.sizeDelta = Vector2.Temp(2, posY - prePosY - cellSize.y - halfSpaceY)
    lineTranV.anchoredPosition = Vector2.Temp(posX - 1 + cellSize.x * 0.5, -prePosY - cellSize.y - halfSpaceY)
    local lineTranH = self.ui.obj_Line:Instantiate()
    lineTranH.gameObject:SetActive(true)
    lineTranH.sizeDelta = Vector2.Temp(math.abs(posX - prePosX), 2)
    lineTranH.anchoredPosition = Vector2.Temp(prePosX + cellSize.x * 0.5, -prePosY + 1 - cellSize.y - halfSpaceY)
  end
end

function UIActSum22StrategyTree:_UpdBranchTitle()
  for branchId, techDataDic in pairs(self._branchDataDic) do
    local titleItem = self.branchTitleDic[branchId]
    if titleItem ~= nil then
      local curNum, maxNum = 0, 0
      for techId, techData in pairs(techDataDic) do
        if 0 < techData:GetCurLevel() then
          curNum = curNum + 1
        end
        maxNum = maxNum + 1
      end
      titleItem:SetActSum22StgMainTitleItemNum(curNum, maxNum)
    end
  end
end

function UIActSum22StrategyTree:_OnClickTechItem(techItem, techData)
  self.ui.tran_Select.gameObject:SetActive(true)
  self.ui.tran_Select:SetParent(techItem.transform)
  self.ui.tran_Select.anchoredPosition = Vector2.zero
  self._techInfoNode:Show()
  self._techInfoNode:InitActSum22TechInfo(techData, techItem.transform)
end

function UIActSum22StrategyTree:_OnClickClose()
  self:Delete()
  if self._closeFunc ~= nil then
    self._closeFunc()
  end
end

function UIActSum22StrategyTree:OnDelete()
  self._techItemPool:DeleteAll()
  if self._resloder ~= nil then
    self._resloder:Put2Pool()
    self._resloder = nil
  end
  self._techInfoNode:OnDelete()
  base.OnDelete(self)
end

return UIActSum22StrategyTree
