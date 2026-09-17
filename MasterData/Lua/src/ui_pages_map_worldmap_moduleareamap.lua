local this = class("moduleAreaMap", G_UIModuleBase)
local areaTpl = L_GameTpl:getAreaTpl()
local domainTpl = L_GameTpl:getDomainTpl()
local worldAreaTpl = L_GameTpl:getWorldAreaTpl()

local function refreshStackTopState()
  local stack = C_UIMgr.GetGroup(CS.Azur.Gameplay.EUIGroup.Stack)
  if stack then
    stack:OnTopUIChange()
  end
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    curSelectAreaId = nil,
    lastSelectAreaItem = nil,
    allAreaConfig = {}
  }
end

function this.bind()
  return {
    list_domain = {
      moduleName = "pages/map/worldMap/cellDomainItem"
    },
    go_btn_autoCollect = false,
    go_btn_autoCollect_mask = false,
    img_bg = ""
  }
end

function this.methods()
  return {
    onClick_activity = function(self)
    end,
    onClick_dragonRelics = function(self)
    end,
    onClick_tower = function(self)
    end,
    onClick_autoCollect = function(self)
      if self.bind.go_btn_autoCollect_mask then
        return
      end
      local collections = {}
      if table.isEmpty(collections) then
        return
      end
      local res = {}
      for i, v in pairs(collections) do
        table.insert(res, v.guid)
      end
    end,
    list_domain = {
      onClick_selectDomain = function(self, config, areaPos)
        self.bindComponents.aniPage:Play("anim_AreaMap_ToBig")
        L_TimerManager:newOrResetTimer(self, "toBigAni", function()
          L_UI:open("pageBigMap", {
            areaId = config.worldAreaId,
            areaPos = areaPos,
            ani = "anim_bigmap_in",
            exitName = self.data.exitName,
            mode = "replaceSwiftly",
            openCallback = refreshStackTopState
          })
        end, 0)
        local domainId = domainTpl:getDomainId(config)
        local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.DomainNew, domainId) == 0
        if bRed then
          L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.DomainNew, domainId, true)
        end
      end
    },
    scrollList_area = {
      onClick_selectItem = function(self, bind)
        for k, v in pairs(self.modules.list_domain) do
          if v.bind.config.domainId == bind.config.domainId then
            self:selectNode(v.bindComponents.trans)
            v:setSelect(true)
          else
            v:setSelect(false)
          end
        end
        for k, v in pairs(self.modules.scrollList_area) do
          if v.bind.config.domainId == bind.config.domainId then
            v.bind.go_normal = false
            v.bind.go_active = true
          else
            v.bind.go_normal = true
            v.bind.go_active = false
          end
        end
        local domainId = domainTpl:getDomainId(bind.config)
        local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.DomainNew, domainId) == 0
        if bRed then
          L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.DomainNew, domainId, true)
        end
      end
    }
  }
end

function this:open()
  L_ReddotStore:listenCallFunc(L_ReddotStore.event.reddotUpdate, self.refreshReddotNew, self)
end

function this:show()
  self:configTouch("+")
end

function this:initAreaMap(_areaId)
  self.data.allAreaConfig = {}
  if _areaId then
    self.data.curSelectAreaId = _areaId
  else
    local playerPos = L_PlayerManager:getMainControlEntityPos()
    local areaId = AzurWorld.areaManager:QueryAreaId(playerPos.x, playerPos.y, playerPos.z)
    if areaId then
      local domainLine = domainTpl:getTplByWorldAreaId(areaId)
      if domainLine then
        self.data.curSelectAreaId = domainTpl:getAreaId(domainLine)
      end
    end
  end
  for i, v in pairs(areaTpl:getConfig()) do
    local bShow = false
    local conds = areaTpl:getUnlockCondition(v)
    if conds then
      local complete = L_ConditionManager:isComplete(conds)
      bShow = complete
    else
      bShow = true
    end
    if bShow then
      table.insert(self.data.allAreaConfig, v)
    end
  end
  table.sort(self.data.allAreaConfig, function(a, b)
    return areaTpl:getSortId(a) < areaTpl:getSortId(b)
  end)
  self.index = 1
  self.maxIndex = #self.data.allAreaConfig
  self.data.curSelectAreaId = self.data.curSelectAreaId or 1
  for i, v in ipairs(self.data.allAreaConfig) do
    if self.data.curSelectAreaId == areaTpl:getAreaId(v) then
      self.index = i
      break
    end
  end
  self:initSystem()
  self:init()
end

function this:hide()
  self:configTouch("-")
end

function this:close(options)
  this.super.close(self, options)
  L_ReddotStore:unListenCallFunc(L_ReddotStore.event.reddotUpdate, self.refreshReddotNew)
  L_TimerManager:clearTimer(self)
end

function this:toggleAreaList(b)
  if b then
    self.bind.go_areaList = true
    self.bindComponents.aniAreaList:Play("anim_AreaMap_listin")
  else
    self.bindComponents.aniAreaList:Play("anim_AreaMap_listout")
    if self.data.areaListCloseTimer then
      self.data.areaListCloseTimer:stop()
      Timer.remove(self.data.areaListCloseTimer)
      self.data.areaListCloseTimer = nil
    end
    self.data.areaListCloseTimer = Timer.once(0.4, function()
      self.bind.go_areaList = false
      self.data.areaListCloseTimer = nil
    end)
  end
  self.bind.go_topBar = not b
  self.bind.go_btnAreaList = not b
end

function this:refreshAreaList(bind)
  for k, v in pairs(self.modules.list_domain) do
    if v.bind.config.domainId == bind.config.domainId then
      self:selectNode(v.bindComponents.trans)
      v:setSelect(true)
    else
      v:setSelect(false)
    end
  end
  local domainId = domainTpl:getDomainId(bind.config)
  local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.DomainNew, domainId) == 0
  if bRed then
    L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.DomainNew, domainId, true)
  end
end

function this:init()
  self:initPage()
  self:generateUnlockNodeData()
  self:refreshReddotNew()
  self.parent:toggleAreaList(false)
  self.parent:initAreaMapScrollList(self.data.curSelectAreaId)
  self.parent:refreshAreaName(self.data.curSelectAreaId)
end

function this:initPage()
  local tpl = areaTpl:getTplById(self.data.curSelectAreaId)
  self.bind.img_bg = areaTpl:getMapResource(tpl)
  self.bindComponents.mapImg:SetNativeSize()
  self:initDomainList()
end

function this:initAreaScrollList()
  local tempData = {}
  local data = domainTpl:getAllTpl()
  for k, v in pairs(data) do
    local bShow = false
    local conds = domainTpl:getUnlockCondition(v)
    if conds then
      local complete = L_ConditionManager:isComplete(conds)
      bShow = complete
    else
      bShow = true
    end
    if bShow and domainTpl:getAreaId(v) == self.data.curSelectAreaId then
      local icon = domainTpl:getDomainIcon(v)
      local name = domainTpl:getDomainName(v)
      table.insert(tempData, {
        config = v,
        go_active = false,
        go_normal = true,
        go_lock = false,
        txt_name_active = name,
        txt_name_normal = name,
        txt_name_lock = name
      })
    end
  end
  self.bind.scrollList_area:clear()
  self.bind.scrollList_area:insert_array(tempData)
end

function this:initDomainList()
  self.bind.list_domain:clear()
  local tempData = {}
  local data = domainTpl:getAllTpl()
  for i, v in pairs(data) do
    if domainTpl:getAreaId(v) == self.data.curSelectAreaId then
      local worldAreaId = domainTpl:getWorldAreaId(v)
      local pos = worldAreaTpl:getEnterFocusPoint(worldAreaTpl:getTplById(worldAreaId))
      table.insert(tempData, {
        config = v,
        txt_name = domainTpl:getDomainName(v),
        img_icon = domainTpl:getDomainIcon(v),
        areaPos = pos,
        localPosition_position = Unity.Vector3(domainTpl:getCoordinate(v)[1], domainTpl:getCoordinate(v)[2], 0)
      })
    end
  end
  self.bind.list_domain:insert_array(tempData)
end

function this:refreshPageInfo()
  self.bind.txt_areaName = areaTpl:getAreaName(areaTpl:getTplById(self.data.curSelectAreaId))
  self:initDomainList()
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.dungeon] = {
      self.bindComponents.transClimbTower
    },
    [L_SystemConst.enum.climbTower] = {
      self.bindComponents.transDungeon
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function this:configTouch(operator)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function this:onUI_dragHandle(gesture)
  if gesture:GetCurrentFirstPickedUIElement() ~= self.bindComponents.rectMap.gameObject then
    return
  end
  if not self.isDragInMapPos then
    return
  end
  local deltaPos = gesture.deltaPosition
  self:setMapPosition(deltaPos)
end

function this:onUI_dragStartHandle(gesture)
  self.canSwitch = false
  self.isDragInMapPos = true
end

function this:onUI_dragEndHandle(gesture)
  if self.canSwitch then
    self:init()
    self.bindComponents.aniPage:Play("anim_AreaMap_change")
  end
end

function this:setMapPosition(deltaPos)
  if self.isDragInMapPos == false then
    return
  end
  if deltaPos.x <= -50 then
    self.canSwitch = true
    if self.index >= self.maxIndex then
      self.index = 1
    else
      self.index = self.index + 1
    end
    self.data.curSelectAreaId = areaTpl:getAreaId(self.data.allAreaConfig[self.index])
    self.isDragInMapPos = false
  elseif deltaPos.x >= 50 then
    self.canSwitch = true
    if self.index <= 1 then
      self.index = self.maxIndex
    else
      self.index = self.index - 1
    end
    self.data.curSelectAreaId = areaTpl:getAreaId(self.data.allAreaConfig[self.index])
    self.isDragInMapPos = false
  end
  self:clampImgPos()
end

function this:clampImgPos()
  if not self.mapClampData then
    self.mapClampData = {x = -8, y = -6.5}
  end
  local prevPos = self.bindComponents.rectMap.anchoredPosition
  self.bindComponents.rectMap.anchoredPosition = C_Vector2(math.clamp(prevPos.x, self.mapClampData.x, self.mapClampData.x), math.clamp(prevPos.y, self.mapClampData.y, self.mapClampData.y))
  return prevPos.x ~= self.bindComponents.rectMap.anchoredPosition.x, prevPos.y ~= self.bindComponents.rectMap.anchoredPosition.y
end

function this:selectNode(trans, callBack)
  local duration = 0.5
  local interval = 0.02
  local loop = duration / interval
  local counter = 1
  local nodeScreen = C_CameraManager.uiCamera:WorldToScreenPoint(trans.position)
  local startPos = self.bindComponents.rectMap.anchoredPosition
  local endPos = self.bindComponents.rectMap.anchoredPosition + C_Vector2(Unity.Screen.width / 2 - nodeScreen.x, Unity.Screen.height / 2 - nodeScreen.y)
  local timer
  timer = Timer.new(function()
    self.bindComponents.rectMap.anchoredPosition = C_Vector2.Lerp(startPos, endPos, counter / loop)
    counter = counter + 1
    local bXModfied, bYModfied = self:clampImgPos()
    if bXModfied and bYModfied then
      self.bMovingAnim = false
      timer:destroy()
    else
      self.bMovingAnim = counter <= loop
    end
    if not self.bMovingAnim and callBack then
      callBack()
    end
  end, interval, loop)
  timer.autoDestroy = true
  timer:start()
end

function this:generateUnlockNodeData()
  local lockIdMap = {}
  self.unlockIdMap = {}
  local data = domainTpl:getAllTpl()
  for i, v in pairs(data) do
    if domainTpl:getAreaId(v) == self.data.curSelectAreaId then
      local conds = domainTpl:getUnlockCondition(v)
      if conds and not (#conds <= 0) then
        local domainId = domainTpl:getDomainId(v)
        local complete = L_ConditionManager:isComplete(conds)
        if not complete then
          lockIdMap[domainId] = true
        else
          local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.DomainAnim, domainId) == 0
          if bRed then
            L_ReddotStore:req_CSRedPointSetReq(L_ReddotStore.serverDotDef.DomainAnim, domainId, true)
            self.unlockIdMap[domainId] = true
          end
        end
      end
    end
  end
  for _, v in pairs(self.modules.list_domain) do
    if self.unlockIdMap[v.bind.config.domainId] or lockIdMap[v.bind.config.domainId] then
      v.bindComponents.trans.gameObject:ActiveTrans(false)
    end
  end
  self:unlockNode()
end

function this:unlockNode()
  if self.unlockIdMap then
    local k, v = next(self.unlockIdMap)
    if k ~= nil then
      for kk, vv in pairs(self.modules.list_domain) do
        if self.unlockIdMap[vv.bind.config.domainId] and k == vv.bind.config.domainId then
          self.unlockIdMap[k] = nil
          self:selectNode(vv.bindComponents.trans, function()
            vv.bindComponents.trans.gameObject:ActiveTrans(true)
            self:unlockNode()
          end)
        end
      end
    end
  end
end

function this:refreshReddotNew()
  for k, v in pairs(self.modules.list_domain) do
    local conds = domainTpl:getUnlockCondition(v.bind.config)
    if conds and 0 < #conds then
      local bRed = L_ReddotStore:hasDot(L_ReddotStore.serverDotDef.DomainNew, v.bind.config.domainId) == 0
      self.bind.list_domain:change(k, {goNew = bRed})
    end
  end
end

function this:playAni(aniName)
  self.bindComponents.aniPage:Play(aniName)
end

return this
