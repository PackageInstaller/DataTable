local T_UITableview = typeof(CS.UITableview)
local tableCellSize = CS.UnityEngine.Vector2(0, 0)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local FadeInAnimType = CS.UITableview.FadeInAnimType
local UIMvvmComponent = System.NewClass("UIMvvmComponent")

function UIMvvmComponent:ctor()
end

function UIMvvmComponent:Setup(binder)
  binder:onDestroy(function()
    self:OnUnbind()
    if binder.OnDispose then
      binder:OnDispose()
    end
  end)
  self:OnBind(binder)
end

function UIMvvmComponent:OnBind(binder)
end

function UIMvvmComponent:OnUnbind()
  self:ClearTableviews()
end

function UIMvvmComponent:CreateTableview(owner, numberCellsInTableview, tableCellAtIndex, tableCellSizeForIndex, cleaner)
  local tableview = owner:GetComponent(T_UITableview)
  local methodCache = {
    AddChild = function(_, targetGo, ...)
      local cell = tableview:AddChild(targetGo, ...)
      if targetGo and not IsNil(targetGo) then
        targetGo:SetActive(false)
      end
      return cell
    end
  }
  local viewProxy = setmetatable({}, {
    __index = function(_, key)
      local cached = methodCache[key]
      if cached then
        return cached
      end
      local member = tableview[key]
      if type(member) == "function" then
        local function wrapper(_, ...)
          do return member, tableview, ... end
          
          return member, tableview, ...
        end
        
        methodCache[key] = wrapper
        return wrapper
      end
      return member
    end
  })
  local scrollRect = owner:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  if scrollRect then
    scrollRect.scrollSensitivity = cd.ScrollSensitivity
  end
  
  function tableview.numberCellsInTableview(tlv)
    local num = numberCellsInTableview(tlv)
    if num < 0 then
      num = 0
    end
    return num
  end
  
  function tableview.tableCellAtIndex(_, idx)
    do return tableCellAtIndex, viewProxy end
    return tableCellAtIndex, viewProxy, idx + 1
  end
  
  if tableCellSizeForIndex then
    function tableview.tableCellSizeForIndex(_, idx)
      local w, h = tableCellSizeForIndex(viewProxy, idx + 1)
      
      tableCellSize.x = w
      tableCellSize.y = h
      return tableCellSize
    end
  elseif not tableview.tableCellSizeForIndex and tableview.gridWidth then
    local gridW = tableview.gridWidth
    local gridH = tableview.gridHeight
    
    function tableview.tableCellSizeForIndex()
      tableCellSize.x = gridW
      tableCellSize.y = gridH
      return tableCellSize
    end
  end
  self.tableviews = self.tableviews or {}
  self.tableviews[tableview] = {cleaner = cleaner}
  return tableview
end

function UIMvvmComponent:DequeueCell(view, prefab)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(prefab)
  return cell
end

function UIMvvmComponent:DequeueCellByTag(view, tag, prefab)
  local cell = view:DequeueCellByTag(tag)
  cell = cell or view:AddChild(prefab)
  cell.tag = tag
  return cell
end

function UIMvvmComponent:ClearTableviews()
  if self.tableviews then
    for k, v in pairs(self.tableviews) do
      if not IsNil(k) then
        if v.cleaner then
          k:Travel(v.cleaner)
        end
        k:UnregisterAllCallbacks()
      end
    end
    self.tableviews = nil
  end
end

function UIMvvmComponent:PlayTableViewFadeInAnim(listGo)
  Logger.Debug("PlayTableViewFadeInAnim ", listGo.name)
  if not listGo then
    return
  end
  local tableview = listGo:GetComponent(typeof(T_UITableview))
  if not tableview then
    return
  end
  local reloadFinishCallback = tableview.reloadFinishCallback
  local isReady = tableview.isReady
  
  local function doPlayFadeInAnim(targetTableView)
    if not isReady then
      if reloadFinishCallback then
        targetTableView.reloadFinishCallback = reloadFinishCallback
        reloadFinishCallback(targetTableView)
      else
        targetTableView.reloadFinishCallback = nil
      end
    end
    local fadeInAnimName = targetTableView.fadeInAnimName
    if not fadeInAnimName or "" == fadeInAnimName then
      return
    end
    local gameObjectList = targetTableView:GetVisibleCellsList()
    if not gameObjectList or gameObjectList.Count <= 0 then
      return
    end
    if not self.listTimerDict then
      self.listTimerDict = {}
    end
    local fadeInAnimTimeType = targetTableView.fadeInAnimType
    local fadeInInterval = tableview.fadeInInterval
    local timer = self.listTimerDict[listGo]
    if timer then
      self.binder:StopTimer(timer)
      self.listTimerDict[listGo] = nil
    end
    local time = 0
    local interval = 0.01
    local objIndex = 0
    local fadeInIntervalArr = targetTableView.fadeInIntervalArr
    local animCtrlList = {}
    for i = 0, gameObjectList.Count - 1 do
      local obj = gameObjectList[i]
      local animCtrl
      if obj then
        animCtrl = obj.gameObject:GetComponent(T_UIAnimationController)
      end
      if not animCtrl then
      else
        table.insert(animCtrlList, animCtrl)
        obj.gameObject:SetActive(false)
      end
    end
    local fadeInAnimTimer
    fadeInAnimTimer = self.binder:BindTimer(interval, -1, function()
      local timeToPlay = fadeInInterval * objIndex
      if fadeInAnimTimeType == FadeInAnimType.NotFixed then
        timeToPlay = fadeInIntervalArr[objIndex]
      end
      if timeToPlay <= time then
        local animCtrl = animCtrlList[objIndex + 1]
        if animCtrl then
          animCtrl.gameObject:SetActive(true)
          animCtrl:PlayMultiState(fadeInAnimName, nil, 1, false)
        end
        objIndex = objIndex + 1
      end
      if objIndex > #animCtrlList then
        self.binder:StopTimer(fadeInAnimTimer)
        self.listTimerDict[listGo] = nil
      end
      time = time + interval
    end)
    self.listTimerDict[listGo] = fadeInAnimTimer
  end
  
  if not isReady then
    tableview.reloadFinishCallback = doPlayFadeInAnim
  else
    doPlayFadeInAnim(tableview)
  end
end

return UIMvvmComponent
