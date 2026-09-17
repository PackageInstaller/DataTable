local this = class("moduleBattleBuff", G_UIModuleBase)
local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()
local HPType = {
  ModuleOneHP = 1,
  ModuleTwoHP = 2,
  ModuleThreeHP = 3
}

function this.bind()
  return {
    scrollStack = {
      moduleName = "pages/battle/cellStackElement"
    },
    scrollBuff = {
      moduleName = "pages/battle/cellBuffElement"
    },
    buffShortShow = false,
    buffShow = false,
    debuffShow = false
  }
end

function this.methods()
  return {
    scrollBuff = {
      onEnter = function(self, buffId, elementType, layer)
        self:emit("onEnter", buffId, elementType, layer)
      end,
      onLeave = function(self)
        self:emit("onLeave")
      end
    }
  }
end

function this:open()
  self.timer = Timer.repeated(0.1, self.update, self)
  self._buffMaps = {}
  self._stackList = {}
  self.onStackPointChangeHandel = handler(self, self.OnStackPointChange)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.buffRefresh, self)
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  self:resetStack()
  self:removeListener()
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.buffRefresh, self)
end

function this:initBuff(csEntity, stackLimit, buffLimit, subBuff)
  self.stackLimit = stackLimit or 6
  self.buffLimit = buffLimit or 10
  self.IsSubBuff = subBuff
  self.bind.scrollBuff:clear()
  self:removeListener()
  if csEntity == nil then
    return
  end
  self.csEntity = csEntity
  self.csEntityId = self.csEntity.data.entityId
  self:buffRefresh()
  self:addListener()
end

function this:SetHPType(listCount)
  if listCount == HPType.ModuleThreeHP then
    self.bind.buffShortShow = true
    self.bind.buffShow = false
    self.bind.debuffShow = false
  end
end

function this:removeListener()
  if self.csEntity and self.m_elementMonitorId and self.m_elementMonitorId >= 0 then
    C_ElementMonitorManager.UnRegisterCheck(self.csEntityId, self.m_elementMonitorId)
    self.m_elementMonitorId = -1
  end
end

function this:addListener()
  self.m_elementMonitorId = C_ElementMonitorManager.RegisterCheckForLua(self.csEntityId, handler(self, self.buffRefresh), handler(self, self.buffRefresh))
end

function this:onAddElement(element)
  if self:checkBuffIsShow(element) then
    self:AddStack(element)
    self:buffRefresh()
  end
end

function this:onRemoveElement(element)
  if self:checkBuffIsShow(element) then
    self:emit("onLeave")
    self:buffRefresh()
    self:RemoveStack(element)
  end
end

function this:checkBuffIsShow(element)
  local config = element and element.config
  if config then
    local buffTpl = _buffInfoTpl:getTplById(config.elementConfigId)
    if buffTpl then
      for i, v in pairs(L_Const.elementType) do
        if v == config.elementType then
          return true
        end
      end
    end
  end
  return false
end

function this:AddStack(element)
  if element and element.config.elementType == L_Const.elementType.stack then
    table.insert(self._stackList, element)
    element.OnStackPointChange:Add(self.onStackPointChangeHandel)
    self:RefreshStack()
  end
end

function this:RemoveStack(element)
  if element and element.config.elementType == L_Const.elementType.stack then
    for i, ele in ipairs(self._stackList) do
      if element == ele then
        table.remove(self._stackList, i)
      end
    end
    element.OnStackPointChange:Remove(self.onStackPointChangeHandel)
    self:RefreshStack()
  end
end

function this:OnStackPointChange(obj)
  self:RefreshStack()
end

function this:RefreshStack()
  local function sortFun(a, b)
    if b.stackPoint ~= a.stackPoint then
      return b.stackPoint < a.stackPoint
    else
      return b.beginLocalTime < a.beginLocalTime
    end
  end
  
  table.sort(self._stackList, sortFun)
  local index = 0
  local elestack = {}
  for i, ele in ipairs(self._stackList) do
    if 0 < ele.stackPoint then
      for j = 1, ele.stackPoint do
        if index < 7 then
          table.insert(elestack, {element = ele})
          index = index + 1
        end
      end
    end
  end
  self.bind.scrollStack:clear()
  self.bind.scrollStack:insert_array(elestack)
end

function this:resetStack()
  for i, ele in ipairs(self._stackList) do
    ele.OnStackPointChange:Remove(self.onStackPointChangeHandel)
  end
end

function this:buffRefresh()
  if self.csEntity == nil then
    return
  end
  local mainEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if mainEntity == nil then
    return
  end
  local lastBuffs = self._buffMaps
  self._buffMaps = {}
  self.buffList = {}
  self.bind.buffShow = false
  self.bind.debuffShow = false
  local elements = self.csEntity.data.elementProperty.existElements
  for i = 0, elements.Count - 1 do
    local buff = elements[i]
    if self:checkBuffIsShow(buff) then
      local buffData = {}
      buffData.element = buff
      buffData.isNew = not lastBuffs[buff.config.elementConfigId]
      self._buffMaps[buff.config.elementConfigId] = true
      if buff.config.elementType == L_Const.elementType.buff then
        table.insert(self.buffList, buffData)
        self:ShowDebuffOrBuff(buff.config.elementConfigId)
      elseif buff.config.elementType == L_Const.elementType.changeProperty then
        table.insert(self.buffList, buffData)
        self:ShowDebuffOrBuff(buff.config.elementConfigId)
      end
    end
  end
  
  local function sortFun(a, b)
    local proA = self:getDisplayPriority(a.element)
    local proB = self:getDisplayPriority(b.element)
    if proB ~= proA then
      return proA > proB
    else
      return a.element.beginLocalTime > b.element.beginLocalTime
    end
  end
  
  table.sort(self.buffList, sortFun)
  local _buffLimit = self.buffLimit
  local len = #self.buffList
  if 0 < len and _buffLimit <= len and 0 < _buffLimit then
    for i = len, _buffLimit, -1 do
      if i == _buffLimit then
        self.buffList[i] = {
          addNum = len - _buffLimit + 1
        }
      else
        table.remove(self.buffList, i)
      end
    end
  end
  self.bind.scrollBuff:clear()
  self.bind.scrollBuff:insert_array(self.buffList)
end

function this:ShowDebuffOrBuff(elementConfigId)
  local tpl = _buffInfoTpl:getTplById(elementConfigId)
  local type = _buffInfoTpl:getType(tpl)
  if type == 1 then
    self.bind.buffShow = true
  elseif type == 2 then
    self.bind.debuffShow = true
  end
end

function this:getDisplayPriority(element)
  local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()
  local elementConfigId = element.config.elementConfigId
  local tpl = _buffInfoTpl:getTplById(elementConfigId)
  local displayPriority = _buffInfoTpl:getDisplayPriority(tpl)
  return displayPriority
end

function this:update()
  if not self.csEntityId or C_EntityManager.GetEntity(self.csEntityId) == nil then
    if self.csEntity then
      self.csEntity = nil
      self.bind.scrollBuff:clear()
    end
    return
  end
  if not self.buffList then
    return
  end
  local count = 0
  local elements = self.csEntity.data.elementProperty.existElements
  local elementCount = elements.Count
  for i = 0, elementCount - 1 do
    if self:checkBuffIsShow(elements[i]) and elements[i].config.elementType ~= L_Const.elementType.stack then
      count = count + 1
    end
  end
  if count < #self.buffList then
    self:emit("onLeave")
    self:buffRefresh()
  end
  for i = 1, #self.bind.scrollBuff do
    local item = self.bind.scrollBuff:getItemCls(i)
    item:refreshLocalBuff()
  end
end

function this:hide()
  self:resetStack()
end

return this
