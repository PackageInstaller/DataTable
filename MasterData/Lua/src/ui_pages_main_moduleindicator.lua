local this = class("moduleIndicator", G_UIModuleBase)
local cellPath = "UI/Pages/BattlePage/cellIndicatorPoint.prefab"
local scriptPath = "ui.pages.main.cellIndicatorPoint"

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.showData = {}
  self.showDataList = {}
  self.recycleList = {}
  self.handleList = {}
  self.bDestroy = false
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleIndicator.update")
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleMonsterEntityInfoChange, self.onEvent_battleMonsterEntityInfoChange, self)
end

function this:show(options)
  self.settingShow = L_SettingStore:getSetData(L_Const.settingType.indicatorHud) == "true"
  if not self.settingShow then
    self:recycleAll()
    return
  end
end

function this:update()
  if not self.settingShow then
    return
  end
  local monsters = L_BattleDataManager:getMonsterCsEntityDic()
  for id, v in pairs(monsters) do
    if v.data.campType == C_ECampType.Monster then
      self:refreshMonsterIndicator(id, v:GetIndicatorInfo())
    end
  end
  self:orderShowData()
end

function this:orderShowData()
  table.clear(self.showDataList)
  for _, v in pairs(self.showData) do
    if v.script then
      table.insert(self.showDataList, v.script)
    end
  end
  table.sort(self.showDataList, function(a, b)
    local weightA = a.indicatorInfo.state * 1000000 - a.indicatorInfo.distance
    local weightB = b.indicatorInfo.state * 1000000 - b.indicatorInfo.distance
    return weightA < weightB
  end)
  for i, v in ipairs(self.showDataList) do
    if v.gameObject.transform:GetSiblingIndex() ~= i - 1 then
      v.gameObject.transform:SetSiblingIndex(i - 1)
    end
  end
end

function this:refreshMonsterIndicator(id, indicatorInfo)
  if not indicatorInfo.isShow then
    self:recycleCell(id)
    return
  end
  if self.showData[id] and (self.showData[id].isLoading or self.showData[id].script) then
    if self.showData[id].script then
      self.showData[id].script:refreshView(indicatorInfo, self.bindComponents.showRect)
    end
    return
  end
  self:getCell(id, indicatorInfo)
end

function this:getCell(id, indicatorInfo)
  if #self.recycleList > 0 then
    local cell = table.remove(self.recycleList, 1)
    L_CommonUtil.setObjActive(cell.gameObject, true)
    cell.gameObject.transform:SetParent(self.bindComponents.showRect.transform)
    cell:refreshView(indicatorInfo, self.bindComponents.showRect)
    self.showData[id] = {script = cell}
    return
  end
  self.showData[id] = {isLoading = true}
  local handler
  handler = C_LuaUtility.InstantiateAsync(cellPath, function(go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. cellPath)
      return
    end
    if self.bDestroy then
      C_LuaUtility.DestroyObject(handler)
      self.showData[id] = nil
      return
    end
    local monsters = L_BattleDataManager:getMonsterCsEntityDic()
    if not monsters[id] or not monsters[id]:GetIndicatorInfo().isShow then
      C_LuaUtility.DestroyObject(handler)
      self.showData[id] = nil
      return
    end
    table.insert(self.handleList, handler)
    local script = require(scriptPath).new(G_UIModuleBase.ModuleType.Static)
    self.showData[id] = {script = script}
    script:created()
    script:toBind(go:GetComponent(typeof(C_UIBinding)))
    script:refreshView(monsters[id]:GetIndicatorInfo(), self.bindComponents.showRect)
  end, self.bindComponents.showRect.transform)
end

function this:recycleCell(entityId)
  if not self.showData[entityId] then
    return
  end
  if self.showData[entityId].script then
    table.insert(self.recycleList, self.showData[entityId].script)
    self.showData[entityId].script:reset()
    self.showData[entityId].script.gameObject.transform:SetParent(self.bindComponents.recycleRect.transform)
  end
  self.showData[entityId] = nil
end

function this:recycleAll()
  if not self.showData then
    return
  end
  for _, v in pairs(self.showData) do
    if v.script then
      table.insert(self.recycleList, v.script)
      v.script.gameObject.transform:SetParent(self.bindComponents.recycleRect.transform)
      v.script:reset()
    end
  end
  table.clear(self.showData)
end

function this:onEvent_battleMonsterEntityInfoChange(bAdd, entityId)
  if bAdd then
    return
  end
  self:recycleCell(entityId)
end

function this:close()
  self:recycleAll()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleMonsterEntityInfoChange, self.onEvent_battleMonsterEntityInfoChange, self)
end

function this:unBind()
  this.super.unBind(self)
  self:destroy()
end

function this:destroy()
  self.bDestroy = true
  if self.showData then
    for _, v in pairs(self.showData) do
      if v.script then
        v.script:_ensureUnbind()
        v.script:_dispose()
      end
    end
    self.showData = nil
  end
  if self.recycleList then
    for _, v in ipairs(self.recycleList) do
      v:_ensureUnbind()
      v:_dispose()
    end
    self.recycleList = nil
  end
  if self.handleList then
    for _, v in ipairs(self.handleList) do
      C_LuaUtility.DestroyObject(v)
    end
    self.handleList = nil
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
