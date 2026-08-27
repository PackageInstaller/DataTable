local UINStioListBase = require("Game.StrategyOverview.UI.UINStioListBase")
local UINStOCareerList = class("UINStOCareerList", UINStioListBase)
local base = UINStioListBase
local UINStOTechItem = require("Game.StrategyOverview.UI.StOList.UINStOTechItem")
local UINStOTechLineItem = require("Game.StrategyOverview.UI.StOList.UINStOTechLineItem")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINStOCareerList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.techItemPool = UIItemPool.New(UINStOTechItem, self.prefabUITable.prefab_techItem)
  self.techLinePool = UIItemPool.New(UINStOTechLineItem, self.prefabUITable.prefab_obj_Line)
  self.ui.rect.enabled = false
  self.__RefreshCostShow = BindCallback(self, self.RefreshCostShow)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshCostShow)
  self._orderList = ConfigData.building.careerBuilds
  self._canLevelBuildItemCount = 0
  self.__IsCanSelctNextLevelupItem = BindCallback(self, self.IsCanSelctNextLevelupItem)
  self.__SelectNextCanLevelUpItem = BindCallback(self, self.SelectNextCanLevelUpItem)
end

function UINStOCareerList:InitStOCareer(resLoader, techList)
  self.isInit = true
  self.resLoader = resLoader
  self:ResetTechItemDic()
  local afterBuildDic = {}
  local beforeBuildDic = {}
  local limitY = 0
  for k, techData in ipairs(techList) do
    local row = techData.buildingData.dynData.stcData.row
    local posIndex = techData.buildingData.dynData.stcData.strategy_career
    local pos = self:_GetTechPos(row, posIndex)
    local techItem = self.techItemPool:GetOne()
    techItem.transform:SetParent(self.ui.rect.transform)
    techItem.gameObject.name = tostring(k)
    techItem.transform.anchoredPosition = pos
    local buildingData = techData.buildingData
    local edge = self:GetTechItemEdge(buildingData)
    techItem:InitStOTechItem(buildingData, resLoader, self, edge)
    self:AddTechItem(buildingData.id, techItem)
    if limitY > pos.y then
      limitY = pos.y
    end
    if techData.selected then
      self:SelectStOTechItem(techItem, techData.buildingData)
    end
    local preBuildingIds = buildingData.dynData:GetPreBuildingId(1)
    for _, preBuildingId in ipairs(preBuildingIds) do
      local childList = afterBuildDic[preBuildingId]
      if childList == nil then
        childList = {}
        afterBuildDic[preBuildingId] = childList
      end
      table.insert(childList, techItem)
    end
    beforeBuildDic[buildingData.id] = preBuildingIds
  end
  self:_ResetRectSize(limitY)
  for id, beforeIds in pairs(beforeBuildDic) do
    if table.count(beforeIds) == 0 then
      beforeBuildDic[id] = nil
    else
      local beforeItems = {}
      for _, buildId in ipairs(beforeIds) do
        local item = self:GetTechItem(buildId)
        table.insert(beforeItems, item)
      end
      beforeBuildDic[id] = beforeItems
    end
  end
  self:_DrawLineNew(afterBuildDic, beforeBuildDic)
  for _, techItem in pairs(self.techItemDic) do
    techItem:InitStOTechItemLine()
  end
  self:RefreshCostShow()
  self:__RefreshCanLevelupItemDic()
  self:__SelectItemInTheMiddle()
end

function UINStOCareerList:_GetTechPos(row, posIndex)
  local padding = self.ui.rect.padding
  local cellSize = self.ui.rect.cellSize
  local spacing = self.ui.rect.spacing
  local x = padding.left + (posIndex - 0.5) * cellSize.x + spacing.x * (posIndex - 1)
  local y = (padding.top + (row - 0.5) * cellSize.y + spacing.y * (row - 1)) * -1
  return Vector2.New(x, y)
end

function UINStOCareerList:_ResetRectSize(limitY)
  local cellSize = self.ui.rect.cellSize
  local padding = self.ui.rect.padding
  local height = math.abs(limitY)
  height = height + cellSize.y / 2 + padding.bottom
  local rectTr = self.ui.rect:GetComponent(typeof(CS.UnityEngine.RectTransform))
  rectTr.sizeDelta = Vector2.New(rectTr.sizeDelta.x, height)
end

function UINStOCareerList:_DrawLineNew(afterBuildDic, beforeBuildDic)
  local buildXYDic = {}
  local pointXYDic = {}
  
  local function CreateXYDicFunc(dic, x, y, val)
    if dic[x] == nil then
      dic[x] = {}
    end
    if dic[x][y] == nil then
      dic[x][y] = val
    end
  end
  
  local function GetXYDicFunc(dic, x, y)
    if dic[x] == nil then
      return nil
    end
    return dic[x][y]
  end
  
  for buildId, _ in pairs(afterBuildDic) do
    local techItem = self:GetTechItem(buildId)
    local y = techItem.buildingData.dynData.stcData.row * 2
    local x = techItem.buildingData.dynData.stcData.strategy_career
    CreateXYDicFunc(buildXYDic, x, y, techItem)
    CreateXYDicFunc(pointXYDic, x, y, {
      x = x,
      y = y / 2
    })
  end
  for buildId, _ in pairs(beforeBuildDic) do
    local techItem = self:GetTechItem(buildId)
    local y = techItem.buildingData.dynData.stcData.row * 2
    local x = techItem.buildingData.dynData.stcData.strategy_career
    CreateXYDicFunc(buildXYDic, x, y, techItem)
    CreateXYDicFunc(pointXYDic, x, y, {
      x = x,
      y = y / 2
    })
  end
  for preBuildId, techItems in pairs(afterBuildDic) do
    local preTechItem = self:GetTechItem(preBuildId)
    local preRow = preTechItem.buildingData.dynData.stcData.row
    local pointIndex = preTechItem.buildingData.dynData.stcData.strategy_career
    if #techItems ~= 1 or techItems[1].buildingData.dynData.stcData.strategy_career ~= pointIndex then
      local topRow
      for _, techItem in ipairs(techItems) do
        if topRow == nil or topRow > techItem.buildingData.dynData.stcData.row then
          topRow = techItem.buildingData.dynData.stcData.row
        end
      end
      local raw = topRow + preRow
      CreateXYDicFunc(pointXYDic, pointIndex, raw, {
        x = pointIndex,
        y = raw / 2
      })
      for _, techItem in ipairs(techItems) do
        local rearPointIndex = techItem.buildingData.dynData.stcData.strategy_career
        if rearPointIndex ~= pointIndex then
          CreateXYDicFunc(pointXYDic, rearPointIndex, raw, {
            x = rearPointIndex,
            y = raw / 2
          })
        end
      end
    end
  end
  
  local function SeekPointFunc(startPoint, endPoint)
    if endPoint.x == startPoint.x and endPoint.y == startPoint.y then
      error("同点 " .. tostring(endPoint.x) .. "," .. tostring(endPoint.y) .. "  " .. tostring(startPoint == endPoint))
    end
    local isRow
    if endPoint.x == startPoint.x then
      isRow = true
    elseif endPoint.y == startPoint.y then
      isRow = false
    else
      error("非同行也非同列 " .. tostring(endPoint.x) .. "," .. tostring(endPoint.y) .. "  " .. tostring(startPoint.x) .. "," .. tostring(startPoint.y))
    end
    local sortMul = isRow and endPoint.y - startPoint.y or endPoint.x - startPoint.x
    sortMul = 0 < sortMul and 1 or -1
    local points = {}
    if isRow then
      for _, point in pairs(pointXYDic[startPoint.x]) do
        table.insert(points, point)
      end
    else
      for x, Ypoints in pairs(pointXYDic) do
        if Ypoints[startPoint.y * 2] ~= nil then
          table.insert(points, Ypoints[startPoint.y * 2])
        end
      end
    end
    table.sort(points, function(a, b)
      if isRow then
        return a.y * sortMul < b.y * sortMul
      else
        return a.x * sortMul < b.x * sortMul
      end
    end)
    local prePoint
    for i, point in ipairs(points) do
      if point == startPoint then
        prePoint = point
      elseif prePoint ~= nil then
        local prePointDic = point.prePointDic
        if prePointDic == nil then
          prePointDic = {}
          point.prePointDic = prePointDic
        end
        prePointDic[prePoint] = true
        prePoint = point
      end
      if point == endPoint then
        break
      end
    end
  end
  
  for preBuildId, techItems in pairs(afterBuildDic) do
    local preTechItem = self:GetTechItem(preBuildId)
    local startY = preTechItem.buildingData.dynData.stcData.row * 2
    local startX = preTechItem.buildingData.dynData.stcData.strategy_career
    if #techItems == 1 and techItems[1].buildingData.dynData.stcData.strategy_career == preTechItem.buildingData.dynData.stcData.strategy_career then
      local endTechItem = techItems[1]
      local endY = endTechItem.buildingData.dynData.stcData.row * 2
      local endX = endTechItem.buildingData.dynData.stcData.strategy_career
      SeekPointFunc(pointXYDic[startX][startY], pointXYDic[endX][endY])
    else
      local preRow = preTechItem.buildingData.dynData.stcData.row
      local topRow
      for _, techItem in ipairs(techItems) do
        if topRow == nil or topRow > techItem.buildingData.dynData.stcData.row then
          topRow = techItem.buildingData.dynData.stcData.row
        end
      end
      local pointIndex = preTechItem.buildingData.dynData.stcData.strategy_career
      local raw = topRow + preRow
      local joinPoint = pointXYDic[pointIndex][raw]
      local startPoint = pointXYDic[pointIndex][preRow * 2]
      SeekPointFunc(startPoint, joinPoint)
      for _, techItem in ipairs(techItems) do
        local rearPointIndex = techItem.buildingData.dynData.stcData.strategy_career
        local rearRow = techItem.buildingData.dynData.stcData.row * 2
        local endPoint = pointXYDic[rearPointIndex][rearRow]
        if rearPointIndex ~= pointIndex then
          local newJoinPoint = pointXYDic[rearPointIndex][raw]
          SeekPointFunc(joinPoint, newJoinPoint)
          SeekPointFunc(newJoinPoint, endPoint)
        else
          SeekPointFunc(joinPoint, endPoint)
        end
      end
    end
  end
  
  local function drawLineFunc(startPos, endPos)
    local lineItem = self.techLinePool:GetOne()
    lineItem:InitStOTechLineItem(startPos, endPos)
    lineItem.transform:SetParent(self.ui.lineObj.transform)
    lineItem.transform.anchoredPosition = startPos
    return lineItem
  end
  
  local function CreateLineFunc(point)
    if point.prePointDic == nil or table.count(point.prePointDic) == 0 then
      return
    end
    local techItem = GetXYDicFunc(buildXYDic, point.x, point.y * 2)
    local endPos = techItem ~= nil and techItem:GetStOTechItemUpPointPos() or self:_GetTechPos(point.y, point.x)
    point.prePointLineDic = {}
    for prePoint, _ in pairs(point.prePointDic) do
      if prePoint.prePointLineDic ~= nil and prePoint.prePointLineDic[point] ~= nil then
        point.prePointLineDic[prePoint] = prePoint.prePointLineDic[point]
      else
        local preTechItem = GetXYDicFunc(buildXYDic, prePoint.x, prePoint.y * 2)
        local startPos = preTechItem ~= nil and preTechItem:GetStOTechItemDownPointPos() or self:_GetTechPos(prePoint.y, prePoint.x)
        local line = drawLineFunc(startPos, endPos)
        point.prePointLineDic[prePoint] = line
        prePoint.tech = preTechItem
      end
    end
    point.prePointDic = nil
  end
  
  self.pointDic = pointXYDic
  for x, Ypoints in pairs(self.pointDic) do
    for y, point in pairs(Ypoints) do
      if point.prePointDic == nil or table.count(point.prePointDic) == 0 then
        self.pointDic[x][y] = nil
      else
        CreateLineFunc(point)
      end
    end
  end
end

function UINStOCareerList:RefreshLine(techItem, valid)
  local y = techItem.buildingData.dynData.stcData.row * 2
  local x = techItem.buildingData.dynData.stcData.strategy_career
  if self.pointDic == nil or self.pointDic[x] == nil or self.pointDic[x][y] == nil then
    return
  end
  local techPoint = self.pointDic[x][y]
  if valid then
    local tempDic = {}
    
    local function Local_Unlock_RefreshLineItem(point, lastPoint)
      if point.prePointLineDic == nil then
        return
      end
      for prePoint, line in pairs(point.prePointLineDic) do
        line:RefreshStOTechLineItem(true)
        if prePoint ~= lastPoint then
          Local_Unlock_RefreshLineItem(prePoint, point)
        end
      end
    end
    
    Local_Unlock_RefreshLineItem(techPoint)
  else
    local preBuildUnlockDic = techItem.buildingData.dynData:GetPreBuildUnlockLevel(1)
    local count = 0
    local tmp = {}
    
    local function Local_Lock_RefreshLineItem(point, lastPoint, isInFlip)
      if point.tech ~= nil and point.tech ~= techItem then
        return (point.tech.buildingData.level or 0) >= preBuildUnlockDic[point.tech.buildingData.id]
      end
      if point.prePointLineDic == nil then
        error(" Line data is error :tech and prePointLineDic is empty ")
        return false
      end
      local activate = true
      for prePoint, line in pairs(point.prePointLineDic) do
        local isLastPoint = prePoint == lastPoint
        local banGo = isLastPoint and isInFlip
        if not banGo then
          local tempActivate = Local_Lock_RefreshLineItem(prePoint, point, isLastPoint or isInFlip)
          line:RefreshStOTechLineItem(tempActivate)
          if not tempActivate then
            activate = tempActivate
          end
        end
      end
      return activate
    end
    
    Local_Lock_RefreshLineItem(techPoint)
  end
end

function UINStOCareerList:RefreshAllStOListTech(buildingData)
  base.RefreshAllStOListTech(self, buildingData)
  self:__RefreshCanLevelupItemDic()
end

function UINStOCareerList:EnterStOList()
  self:RefreshAllStOListTech()
  local selectItem = self.lastSelectTech
  if selectItem ~= nil then
    self:SelectStOTechItem(selectItem, selectItem.buildingData)
    self:__SelectItemInTheMiddle()
    return
  end
  if self._canLevelBuildItemCount == 0 then
    local selectItem = self.techItemDic[self._orderList[1]]
    self:SelectStOTechItem(selectItem, selectItem.buildingData)
    self:__SelectItemInTheMiddle()
    return
  end
  self:SelectNextCanLevelUpItem()
  self:__SelectItemInTheMiddle()
end

function UINStOCareerList:__RefreshCanLevelupItemDic()
  self._canLevelBuildItemCount = 0
  for k, techItem in pairs(self.techItemDic) do
    if techItem:IsTethCanLevelup() then
      self._canLevelBuildItemCount = self._canLevelBuildItemCount + 1
    end
  end
end

function UINStOCareerList:RefreshCostShow()
  local costIds = ConfigData.game_config.STOCareerCostIds
  for i, costText in ipairs(self.ui.headitemCountList) do
    if i <= #costIds then
      costText.text = PlayerDataCenter:GetItemCount(costIds[i])
    else
      costText.text = "0"
      error("game_config.STOCareerCostIds error")
    end
  end
end

function UINStOCareerList:IsCanSelctNextLevelupItem()
  if self._canLevelBuildItemCount == 0 then
    return false
  end
  if self.lastSelectTech ~= nil then
    return self._canLevelBuildItemCount ~= 1 or not self.lastSelectTech:IsTethCanLevelup()
  end
  return true
end

function UINStOCareerList:SelectNextCanLevelUpItem()
  if not self:IsCanSelctNextLevelupItem() then
    return
  end
  local selectBuildItem
  local beginNext = false
  for _, buildId in ipairs(self._orderList) do
    if buildId == self.lastSelectTechId then
      beginNext = true
    else
      local buildItem = self:GetTechItem(buildId)
      if buildItem ~= nil and buildItem:IsTethCanLevelup() then
        if beginNext then
          selectBuildItem = buildItem
          break
        end
        if selectBuildItem == nil then
          selectBuildItem = buildItem
        end
      end
    end
  end
  if selectBuildItem == nil then
    return
  end
  self:SelectStOTechItem(selectBuildItem, selectBuildItem.buildingData)
  self:__SelectItemInTheMiddle()
end

function UINStOCareerList:GetCareerListSelectNextFunc()
  return self.__IsCanSelctNextLevelupItem, self.__SelectNextCanLevelUpItem
end

function UINStOCareerList:__SelectItemInTheMiddle()
  if self.lastSelectTech == nil then
    return
  end
  local height = self.ui.list.transform.rect.height
  local rectHeight = self.ui.rect.transform.rect.height
  local rectY = self.ui.rect.transform.anchoredPosition.y
  local itemY = self.lastSelectTech.transform.anchoredPosition.y
  local rectAnchoredPos = self.ui.rect.transform.anchoredPosition
  if -itemY < height / 2 then
    rectAnchoredPos.y = 0
  elseif rectHeight + itemY < height / 2 then
    rectAnchoredPos.y = rectHeight - height
  else
    rectAnchoredPos.y = -(itemY + height / 2)
  end
  self.ui.list:StopMovement()
  if self._scrollTween ~= nil then
    self._scrollTween:Kill()
  end
  self.ui.rect.transform:DOAnchorPosY(rectAnchoredPos.y, 0.1)
end

function UINStOCareerList:OnDelete()
  self.techItemPool:DeleteAll()
  self.techLinePool:DeleteAll()
  self.ui.rect.transform:DOKill()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshCostShow)
  base.OnDelete(self)
end

return UINStOCareerList
