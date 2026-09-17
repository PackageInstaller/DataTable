local this = L_BevTree:registClass("guide.findTargetListItem", L_BevTree.action)
local guideStuckTime = L_GameTpl:getGameConstTpl():getData("GUIDE_SKIP_BUTTON_DISPLAY_TIME", L_Const.GameTplType.int)
local _guideClickPathTpl = L_GameTpl:getGuideClickPathTpl()
local C_LTableView = CS.Lens.Framework.UI.LTableView

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.guideClickPathId = 0
  self.targetId = 0
  self.listType = 0
  self.listIndex = 0
  self.inputActions = ""
  self.childPath = ""
  self.forceCloseRecoverInputOne = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.guideClickPathId = self:getParam("guideClickPathId", true) or 0
  self.targetId = self:getParam("targetId", true)
  self.listType = self:getParam("listType", true)
  self.listIndex = self:getParam("listIndex", true)
  self.inputActions = self:getParam("inputActions")
  self.childPath = self:getParam("childPath")
  self.forceCloseRecoverInputOne = self:getParam("forceCloseRecoverInputOne", true) ~= 0
end

function this:onEnter()
  self.lastStuck = false
  self.curCheckTime = C_Time.time
  self.curCheckFindTargetTime = C_Time.time
  if self.guideClickPathId > 0 then
    local guideClickPathTpl = _guideClickPathTpl:getTplById(self.guideClickPathId)
    if guideClickPathTpl ~= nil then
      self.targetPath, self.childPath = _guideClickPathTpl:getPath(guideClickPathTpl)
    end
  end
  self:dealHighInputAction()
  self.result = L_BevTree.taskResult.Running
end

function this:onFinish()
  if not self.forceCloseRecoverInputOne then
    self:dealDisableHighInputAction()
  end
end

function this:dealHighInputAction()
  if not string.isEmpty(self.inputActions) then
    local actions = string.split(self.inputActions, "|")
    C_InputManager.EnableHighLevelControl(actions, nil)
    return true
  end
  return false
end

function this:dealDisableHighInputAction()
  if not string.isEmpty(self.inputActions) and not self.forceCloseRecoverInputOne then
    C_InputManager.DisableHighLevelControl()
  end
end

function this:execute()
  if self.result == L_BevTree.taskResult.Running then
    local page = L_UI:getPage(self.pageName)
    if L_UI:checkPageShown(self.pageName) then
      local target = page.gameObject.transform:Find(self.targetPath)
      if not target then
        self:checkFindTargetItem()
        return L_BevTree.taskResult.Running
      end
      local tableView = target:GetComponent(typeof(C_LTableView))
      if tableView ~= nil then
        return self:getTableViewItemById(tableView)
      end
      local isLList = false
      local targetList = target:GetComponent(typeof(C_LScrollRect))
      if targetList == nil then
        targetList = target:GetComponent(typeof(C_LScrollView))
        if targetList ~= nil then
          return self:getScrollViewItemById(targetList)
        end
      end
      if targetList == nil then
        isLList = true
        targetList = target:GetComponent(typeof(C_LList))
      end
      local isLuaTable = targetList:CheckIsLuaTable()
      if targetList ~= nil then
        if self.listIndex and self.listIndex ~= 0 then
          local item
          if isLuaTable then
            item = targetList:GetItemById(self.listIndex - 1)
            if not item or not item.uiBinding then
              self:checkFindTargetItem()
              return L_BevTree.taskResult.Running
            end
          else
            item = targetList:GetCSharpItemById(self.listIndex - 1)
            if not item then
              self:checkFindTargetItem()
              return L_BevTree.taskResult.Running
            end
          end
          self.tree.targetListItem = item.uiBinding
          if not string.isEmpty(self.childPath) then
            self.tree.targetListItem = self.tree.targetListItem.gameObject.transform:Find(self.childPath)
          end
          if L_CommonUtil.isValid(self.tree.targetListItem) then
            return L_BevTree.taskResult.Success
          end
        end
        
        local function checkFuc(itemCls, itemData, isLuaTable)
          return self:matchListItem(itemCls, itemData, isLuaTable)
        end
        
        if isLuaTable then
          for k, cellData in ipairs(targetList.luaTable) do
            local result = checkFuc(targetList.luaTable:getItemCls(k), cellData, true)
            if result == L_BevTree.taskResult.Success then
              return L_BevTree.taskResult.Success
            end
          end
        else
          for k, item in pairs(targetList.tableComponent) do
            local result = checkFuc(item)
            if result == L_BevTree.taskResult.Success then
              return L_BevTree.taskResult.Success
            end
          end
        end
      end
    end
  end
  self:checkFindTargetItem()
  return L_BevTree.taskResult.Running
end

function this:matchListItem(itemCls, itemData, isLuaTable)
  local itemBinding
  if not isLuaTable then
    itemData = itemCls
  end
  if self.listType == G_GuideClasses.listItemType.hero then
    if itemData.unitId ~= nil and itemData.unitId == self.targetId then
      itemBinding = itemCls.uiBinding
    end
    if itemData.id ~= nil and itemData.id == self.targetId then
      itemBinding = itemCls.uiBinding
    end
    if itemData.guid ~= nil then
      local hero = L_HeroStore:getHero(itemData.guid)
      if L_HeroStore:getHeroConfigId(hero) == self.targetId then
        itemBinding = itemCls.uiBinding
      end
    end
    if itemData.configId ~= nil and itemData.configId == self.targetId then
      itemBinding = itemCls.uiBinding
    end
  end
  if self.listType == G_GuideClasses.listItemType.soulEssence and itemData.serverData and itemData.serverData.soulEssenceId == self.targetId then
    itemBinding = itemCls.uiBinding
  end
  if self.listType == G_GuideClasses.listItemType.pet then
    if itemData.id and itemData.id == self.targetId then
      itemBinding = itemCls.uiBinding
    end
    if itemData.groupId and itemData.groupId == self.targetId then
      itemBinding = itemCls.uiBinding
    end
  end
  if self.listType == G_GuideClasses.listItemType.product and itemData.id and itemData.id == self.targetId then
    itemBinding = itemCls.uiBinding
  end
  if self.listType == G_GuideClasses.listItemType.mountPet and itemData.guid then
    local pet = L_PetStore:getPetItem(itemData.guid)
    if self.targetId == pet.petId then
      itemBinding = itemCls.uiBinding
    end
  end
  if itemBinding then
    if not string.isEmpty(self.childPath) then
      itemBinding = itemBinding.gameObject.transform:Find(self.childPath)
    end
    self.tree.targetListItem = itemBinding
    if L_CommonUtil.isValid(itemBinding) then
      return L_BevTree.taskResult.Success
    end
  end
end

function this:getTableViewItemById(tableView)
  local targetDataIndex
  if self.listIndex and self.listIndex ~= 0 then
    targetDataIndex = self.listIndex - 1
  else
    targetDataIndex = self:findDataIndexInTableView(tableView)
  end
  if targetDataIndex == nil then
    self:checkFindTargetItem()
    return L_BevTree.taskResult.Running
  end
  local cell = tableView:GetItemByIndex(targetDataIndex)
  if cell == nil then
    local totalCount = tableView.totalCount
    if totalCount and 0 <= targetDataIndex and targetDataIndex < totalCount then
      tableView:ScrollToCellImmediate(targetDataIndex)
      cell = tableView:GetItemByIndex(targetDataIndex)
    end
    if cell == nil then
      self:checkFindTargetItem()
      return L_BevTree.taskResult.Running
    end
  end
  local uiBinding = cell.gameObject:GetComponent(typeof(C_UIBinding))
  if uiBinding == nil then
    self:checkFindTargetItem()
    return L_BevTree.taskResult.Running
  end
  self.tree.targetListItem = uiBinding
  if not string.isEmpty(self.childPath) then
    self.tree.targetListItem = self.tree.targetListItem.gameObject.transform:Find(self.childPath)
  end
  if L_CommonUtil.isValid(self.tree.targetListItem) then
    return L_BevTree.taskResult.Success
  end
  self:checkFindTargetItem()
  return L_BevTree.taskResult.Running
end

function this:findDataIndexInTableView(tableView)
  if tableView.luaTable == nil then
    return nil
  end
  local mds = tableView.luaTable:getItemCls()
  if mds == nil then
    return nil
  end
  for k, itemData in ipairs(tableView.luaTable) do
    local itemCls = tableView.luaTable:getItemCls(k)
    if itemCls ~= nil and self:matchTableViewData(itemCls, itemData) then
      return k - 1
    end
  end
  return nil
end

function this:matchTableViewData(itemCls, itemData)
  if self.listType == G_GuideClasses.listItemType.hero then
    if itemData.unitId ~= nil and itemData.unitId == self.targetId then
      return true
    end
    if itemData.id ~= nil and itemData.id == self.targetId then
      return true
    end
    if itemData.guid ~= nil then
      local hero = L_HeroStore:getHero(itemData.guid)
      if L_HeroStore:getHeroConfigId(hero) == self.targetId then
        return true
      end
    end
    if itemData.configId ~= nil and itemData.configId == self.targetId then
      return true
    end
  end
  if self.listType == G_GuideClasses.listItemType.soulEssence and itemData.serverData and itemData.serverData.soulEssenceId == self.targetId then
    return true
  end
  if self.listType == G_GuideClasses.listItemType.pet then
    if itemData.id and itemData.id == self.targetId then
      return true
    end
    if itemData.groupId and itemData.groupId == self.targetId then
      return true
    end
  end
  if self.listType == G_GuideClasses.listItemType.product and itemData.id and itemData.id == self.targetId then
    return true
  end
  if self.listType == G_GuideClasses.listItemType.mountPet and itemData.guid then
    local pet = L_PetStore:getPetItem(itemData.guid)
    if self.targetId == pet.petId then
      return true
    end
  end
  return false
end

function this:getScrollViewItemById(targetList)
  local item = targetList:GetItemById(self.listIndex - 1)
  if not item then
    self:checkFindTargetItem()
    return L_BevTree.taskResult.Running
  end
  self.tree.targetListItem = item
  if not string.isEmpty(self.childPath) then
    self.tree.targetListItem = self.tree.targetListItem.gameObject.transform:Find(self.childPath)
  end
  return L_BevTree.taskResult.Success
end

function this:checkUIShow()
  if string.isEmpty(self.inputActions) then
    return
  end
  local isStuck = C_Time.time - self.curCheckTime >= guideStuckTime
  if isStuck ~= self.lastStuck then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=findTargetListItem.checkUIShow guideId=%s isShow=%s skipNotSave=%s elapsed=%s threshold=%s pageName=%s targetPath=%s inputActions=%s", tostring(self.tree.param.guideId), tostring(isStuck), tostring(self.skipNotSave), tostring(C_Time.time - self.curCheckTime), tostring(guideStuckTime), tostring(self.pageName), tostring(self.targetPath), tostring(self.inputActions)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
      skipNotSave = self.skipNotSave,
      guideId = self.tree.param.guideId,
      isShow = isStuck
    })
    if not isStuck then
      self:dealHighInputAction()
    end
  end
  self.lastStuck = isStuck
  self.curCheckTime = C_Time.time
end

function this:checkFindTargetItem()
  local isStuck = C_Time.time - self.curCheckFindTargetTime >= guideStuckTime
  if string.isEmpty(self.inputActions) then
    if isStuck then
      L_GuideManager:clearAllControl()
      L_GuideManager:forceEndGuide(self.tree.param.guideId)
    end
    return
  end
  if isStuck ~= self.lastStuck then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=findTargetListItem.checkFindTargetItem guideId=%s isShow=%s skipNotSave=%s elapsed=%s threshold=%s pageName=%s targetPath=%s inputActions=%s", tostring(self.tree.param.guideId), tostring(isStuck), tostring(self.skipNotSave), tostring(C_Time.time - self.curCheckFindTargetTime), tostring(guideStuckTime), tostring(self.pageName), tostring(self.targetPath), tostring(self.inputActions)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
      skipNotSave = self.skipNotSave,
      guideId = self.tree.param.guideId,
      isShow = isStuck
    })
    if not isStuck then
      self:dealHighInputAction()
    end
  end
  self.lastStuck = isStuck
end

function this:onDestroy()
  if not self.forceCloseRecoverInputOne then
    self:dealDisableHighInputAction()
  end
end

return this
