local this = {}
local _colorLockStar = C_LuaUtility.ParseHtmlStringColor("#c9bcaf")
local _colorCanUpgrade = C_LuaUtility.ParseHtmlStringColor("#A78B71")
local _colorLevelMax = C_LuaUtility.ParseHtmlStringColor("#86CA5E")
local _startX = 234.7
local _startY = -115
local _spaceX = 467.1
local _spaceY = 135.4
local _homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()

function this:updateScienceTree(technologyType, jump)
  if not self.isBind then
    return
  end
  local isRefresh = false
  if not technologyType then
    isRefresh = true
    technologyType = self.tabId2TechType[self.selectTabId]
  end
  local treeItems = self.listTechnologyTreeItem[technologyType]
  if not self.treeItemDic then
    self.treeItemDic = {}
  end
  if not treeItems then
    local itemDic = {}
    local temp = {}
    for i, v in pairs(_homeTechnologyTreeTpl.data) do
      local techType = _homeTechnologyTreeTpl:getType(v)
      if technologyType == techType then
        local tier = _homeTechnologyTreeTpl:getTier(v)
        if not temp[tier] then
          temp[tier] = {
            tier = tier,
            items = {}
          }
        end
        local posttechnologyTypeId = _homeTechnologyTreeTpl:getPosttechnologyTypeId(v)
        local item = {
          techTreeId = i,
          tplTechTree = v,
          nextIds = table.clone(posttechnologyTypeId),
          gridX = 0,
          gridY = _homeTechnologyTreeTpl:getLocation(v),
          prevIds = {}
        }
        itemDic[i] = item
        table.insert(temp[tier].items, item)
      end
    end
    treeItems = table.toArray(temp)
    table.sort(treeItems, function(a, b)
      return a.tier < b.tier
    end)
    for i = 1, #treeItems do
      for _, item in ipairs(treeItems[i].items) do
        item.gridX = i
        for _, id in pairs(item.nextIds) do
          if itemDic[id] then
            table.insert(itemDic[id].prevIds, item.techTreeId)
          end
        end
      end
    end
    
    local function sortFunc(a, b)
      return itemDic[a].gridY < itemDic[b].gridY
    end
    
    for k, item in pairs(itemDic) do
      table.sort(item.prevIds, sortFunc)
      table.sort(item.nextIds, sortFunc)
      self.treeItemDic[k] = item
    end
    self.listTechnologyTreeItem[technologyType] = treeItems
    if #treeItems % 2 == 1 then
      do
        local last = treeItems[#treeItems]
        local fakeGroup = {
          tier = last.tier + 1,
          items = {}
        }
        table.insert(treeItems, fakeGroup)
      end
    end
  end
  if not isRefresh then
    self:setGroupData(treeItems)
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.scroll.transform)
  end
  self:setItembyGroup(treeItems, isRefresh)
  if jump then
    local treeId = self:getFirtSelectId(technologyType)
    local gridX = self.treeItemDic[treeId].gridX
    local groups = self.bind.listScienceGroup:getItemCls()
    self.bindComponents.scroll:ScrollTo(groups[gridX].gameObject.transform, true)
  end
end

function this:setGroupData(treeItems)
  local goups = {}
  local curLevel = L_PlayerStore:getLv()
  local maxGridY = 0
  for i = 1, #treeItems do
    goups[i] = {
      gridX = i,
      txtLevel = tostring(treeItems[i].tier),
      lock = curLevel < treeItems[i].tier
    }
    for _, item in ipairs(treeItems[i].items) do
      if maxGridY < item.gridY then
        maxGridY = item.gridY
      end
    end
  end
  self.bind.listScienceGroup:clear()
  self.bind.listScienceGroup:insert_array(goups)
end

function this:checkItemIfNeedActiveLineRight(item)
  for _, nextId in pairs(item.nextIds) do
    local nextItem = self.treeItemDic[nextId]
    if nextItem.gridX > item.gridX and nextItem.gridY ~= item.gridY then
      return true
    end
  end
  return false
end

function this:setRightLines(item, data)
  local lenNext = #item.nextIds
  local ifNeedActiveLineRight = self:checkItemIfNeedActiveLineRight(item)
  data.activeLineR = ifNeedActiveLineRight
  if ifNeedActiveLineRight then
    data.maxX = item.gridX + 1
    data.activeLineR = true
    local upY = 0
    local downY = 0
    local ifUpItemStudied = false
    local ifDownItemStudied = false
    for i = 1, lenNext do
      local nextId = item.nextIds[i]
      local nextItem = self.treeItemDic[nextId]
      upY = math.max(item.gridY - nextItem.gridY, upY)
      downY = math.max(nextItem.gridY - item.gridY, downY)
      local curLevel = L_TechnologyStore:getCurTechnologyLevelById(nextId)
      if self.pendingNodeId == nextId then
        curLevel = self.pendingNodeLevel
      end
      local studied = 0 < curLevel
      local ifTechMaxLevel = curLevel >= L_TechnologyStore:getCurTechnologyMaxLevelById(nextId)
      if studied then
        local color = ifTechMaxLevel and _colorLevelMax or _colorCanUpgrade
        if nextItem.gridY < item.gridY then
          ifUpItemStudied = true
          data.colorLineRVerticalUp = color
        elseif nextItem.gridY > item.gridY then
          ifDownItemStudied = true
          data.colorLineRVerticalDown = color
        end
        if not data.colorLineRL or color == _colorCanUpgrade then
          data.colorLineRL = color
        end
      end
    end
    data.activeLineRPointL = data.colorLineRL == nil
    data.activeLineRL = data.colorLineRL ~= nil
    data.activeLineRVerticalUp = 0 < upY and ifUpItemStudied
    data.activeLineRVerticalDashedUp = 0 < upY and not ifUpItemStudied
    if 0 < upY then
      data.widthLineRVerticalUp = _spaceY * upY - 16.4
    end
    data.activeLineRVerticalDown = 0 < downY and ifDownItemStudied
    data.activeLineRVerticalDashedDown = 0 < downY and not ifDownItemStudied
    if 0 < downY then
      data.widthLineRVerticalDown = _spaceY * downY - 16.4
    end
    data.starPosList = {}
    table.insert(data.starPosList, C_Vector2(1.7, 0))
    for i = 1, lenNext do
      local nextId = item.nextIds[i]
      local nextItem = self.treeItemDic[nextId]
      if nextItem.gridX > item.gridX and nextItem.gridY ~= item.gridY then
        table.insert(data.starPosList, C_Vector2(1.7, (item.gridY - nextItem.gridY) * _spaceY))
      end
    end
  end
end

function this:setLeftLines(item, data)
  local studied = data.studied
  local lenPrev = #item.prevIds
  if 0 < lenPrev then
    local preItem = self.treeItemDic[item.prevIds[1]]
    local ifPreItemActiveRight = self:checkItemIfNeedActiveLineRight(preItem)
    if item.gridX ~= preItem.gridX then
      data.minX = preItem.gridX
      data.activeLineL = true
      data.activeLineLPointR = not studied
      data.activeLineLPointL = not studied
      data.activeLineLL = studied
      data.activeLineLR = studied
      data.activeLineLMiddle = true
      data.widthLineL = ifPreItemActiveRight and _spaceX * (item.gridX - preItem.gridX - 1) + 21.9 or _spaceX * (item.gridX - preItem.gridX - 1) + 55
      if item.gridX - preItem.gridX == 1 or ifPreItemActiveRight then
        data.activeLineLPointR = false
        data.activeLineLR = false
        data.activeLineLMiddle = false
      end
    else
      if item.gridY > preItem.gridY then
        data.activeAllLineUp = true
        data.activeLineUp = studied
        data.activeLineDashedUp = not studied
      elseif item.gridY < preItem.gridY then
        data.activeAllLineDown = true
        data.activeLineDown = studied
        data.activeLineDashedDown = not studied
      end
      data.widthLineVertical = _spaceY * math.abs(preItem.gridY - item.gridY) - 73.4
    end
  else
    data.activeLineL = false
    data.activeAllLineUp = false
    data.activeAllLineDown = false
  end
end

local function copyLineInfo(data)
  local new_t = {}
  for k, v in pairs(data) do
    new_t[k] = v
  end
  return new_t
end

function this:setItembyGroup(treeItems, isRefresh)
  local itemData = {}
  local lineData = {}
  for i = #treeItems, 1, -1 do
    local tierItems = treeItems[i]
    for _, item in pairs(tierItems.items) do
      local data = {}
      local techTreeId = item.techTreeId
      data.techTreeId = techTreeId
      data.activeContent = true
      data.nextIds = item.nextIds
      data.gridX = item.gridX
      data.gridY = item.gridY
      data.minX = item.gridX
      data.maxX = item.gridX
      local tplTechTree = item.tplTechTree
      local iconKey = "Icon"
      if _homeTechnologyTreeTpl:getNodeType(tplTechTree) == 1 then
        iconKey = iconKey .. "2"
      end
      data["active" .. iconKey] = true
      data["img" .. iconKey] = _homeTechnologyTreeTpl:getIcon(tplTechTree)
      local curLevel = self:getCurLevel(item, data)
      data.studied = 0 < curLevel
      local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(techTreeId, curLevel)
      local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
      data.txtName = data.studied and _homeTechnologyTpl:getObjName(homeTechnologyTpl) or _homeTechnologyTreeTpl:getName(tplTechTree)
      local ifTechMaxLevel = curLevel >= L_TechnologyStore:getCurTechnologyMaxLevelById(techTreeId)
      if data.studied then
        data.starColor = ifTechMaxLevel and _colorLevelMax or _colorCanUpgrade
      else
        data.starColor = _colorLockStar
      end
      data.lineColor = data.starColor
      self:setRightLines(item, data)
      self:setLeftLines(item, data)
      for j = data.minX, data.maxX do
        lineData[j] = lineData[j] or {}
        local tmpData = copyLineInfo(data)
        if j < data.gridX then
          tmpData.activeLineR = false
        elseif j > data.gridX then
          tmpData.activeLineL = false
        end
        table.insert(lineData[j], tmpData)
      end
      itemData[data.gridX] = itemData[data.gridX] or {}
      table.insert(itemData[data.gridX], data)
    end
  end
  for i, v in ipairs(self.bind.listScienceGroup:getItemCls()) do
    if isRefresh then
      v:refreshItemData(itemData[i])
      v:setLineData(lineData[i])
    else
      v:setItemData(itemData[i])
      v:setLineData(lineData[i])
    end
  end
end

function this:getFirtSelectId(technologyType)
  local techTypeInfo = L_TechnologyStore:getTechTypeInfo(technologyType)
  local point = techTypeInfo and techTypeInfo.point or 0
  local curLevel = L_PlayerStore:getLv()
  local unlightId, lightId, maxId
  local treeItems = self.listTechnologyTreeItem[technologyType]
  for i = 1, #treeItems do
    if curLevel >= treeItems[i].tier then
      for _, item in ipairs(treeItems[i].items) do
        local techTreeId = item.techTreeId
        local techLv = L_TechnologyStore:getCurTechnologyLevelById(techTreeId)
        local maxLv = techLv == 0 and 1 or L_TechnologyStore:getCurTechnologyMaxLevelById(techTreeId)
        if techLv < maxLv then
          local techTpl = _homeTechnologyTpl:getTplById(item.techTreeId * 10 + 1)
          local upgradeCondition = _homeTechnologyTpl:getUnlockCondi1(techTpl)
          local isSatisfy, _ = L_ConditionManager:isComplete(upgradeCondition)
          if isSatisfy then
            local needPoint = _homeTechnologyTpl:getPoint(techTpl)
            if point >= needPoint then
              return techTreeId
            end
            lightId = lightId or techTreeId
          end
          unlightId = unlightId or techTreeId
        else
          maxId = techTreeId
        end
      end
    end
  end
  return unlightId or lightId or maxId or treeItems[1].items[1].techTreeId
end

function this:getCurLevel(item, data)
  local techTreeId = item.techTreeId
  local curLevel = L_TechnologyStore:getCurTechnologyLevelById(techTreeId)
  if self.pendingNodeId == techTreeId then
    curLevel = self.pendingNodeLevel
    data.pendingLevel = self.pendingNodeLevel
  end
  if self.lockingState[techTreeId] then
    data.shouldLock = true
  end
  return curLevel
end

function this:setPendingNode(nodeId, level, clear)
  if clear then
    self.previousPendingNodeId = nil
    self.lockingState = {}
  end
  self.pendingNodeId = nodeId
  self.pendingNodeLevel = level
  if nodeId and level == 0 then
    local item = self.treeItemDic[nodeId]
    if item then
      for i, v in ipairs(item.nextIds) do
        self.lockingState[v] = true
      end
    end
  end
end

function this:pendingNodeUpgrade()
  L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Unlock")
  self.pendingNodeId = nil
  self.pendingNodeLevel = nil
  self:updateScienceTree()
end

function this:lockingNodesUnlock()
  if not table.isEmpty(self.lockingState) then
    L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Unlock")
  end
  for k, v in pairs(self.lockingState) do
    self.lockingState[k] = nil
  end
  self:updateScienceTree()
end

return this
