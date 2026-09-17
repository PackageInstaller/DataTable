local page = class("pagePlayerDisplay", G_UIPageBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()
local _playerDressListTpl = L_GameTpl:getPlayercardDressListTpl()
local _itemConfigDict
local this = page

function page:created(obj, pageConfig)
  page.super.created(self, obj, pageConfig)
  self:initConfigData()
  self:initFields()
end

function page:initFields()
  self.curSelItemId = -1
  self.remScrollPos = {}
  self.remSel = {}
end

function page:preBind()
  return {}
end

function page:bind()
  return {
    moduleCharacterStandee = {
      moduleName = "pages/playerCard/moduleCharacterStandee"
    },
    itemList = {
      moduleName = "pages/playerCard/playerDisplay/cellPlayerDressItem"
    },
    tabList = {
      moduleName = "pages/playerCard/playerDisplay/cellPlayerDisplayTab"
    },
    curTabID = 0,
    isActive_btnShoot = false,
    txt_itemDesTitle = "Title",
    txt_itemDesContent = "Content",
    txt_btnShoot = "",
    txt_type = "",
    contentAlpha = nil
  }
end

function page:methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onSelect_tab = function(self, tabID)
      if self.bind.curTabID == tabID then
        return
      end
      self.remScrollPos[self.bind.curTabID] = self.bindComponents.itemList.verticalNormalizedPosition
      self.bind.curTabID = tabID
      self:initItemList(tabID)
      self.bindComponents.listAnim:Rewind()
      self.bindComponents.listAnim:Play("anim_itemlistroot")
    end,
    onClick_shot = function(self)
      self:sendPhotoId(self.curSelItemId)
    end,
    onClick_Wear = function(self)
      self:onClickWear()
    end,
    itemList = {
      onClick = function(self, bind)
        self:onClickItem(bind)
      end,
      onClick_shot = function(self, selItemId)
        self:sendPhotoId(selItemId)
      end
    }
  }
end

function page:check(options, callback)
  callback(true)
end

function page:preOpen(options)
  self:initStandee()
  L_PlayerDisplayStore:listenCallFunc(L_PlayerDisplayStore.event.dressItemSync, self.onEvent_dressItemSync, self)
  self:initTab()
  if self.bind.curTabID ~= 0 then
    self:initItemList(self.bind.curTabID)
  end
end

function page:open(options)
  page.super.open(self, options)
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    self:escHandle()
  end)
end

function page:show(options)
  if self.bind.curTabID ~= 0 then
    self:initItemList(self.bind.curTabID, true)
  end
end

function page:hide()
end

function page:close(options)
  L_PlayerDisplayStore:unListenCallFunc(L_PlayerDisplayStore.event.dressItemSync, self.onEvent_dressItemSync)
end

function page:destroy(options)
end

function page:escHandle()
  local hasChange, data = self:checkChanged()
  if hasChange then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_player_card_customed_not_saved"),
      confirmCallback = function()
        self:onClickWear(function()
          self:refreshOnChange()
          L_UI:close(self.pageName)
        end)
      end,
      cancelCallback = function()
        L_UI:close(self.pageName)
      end
    })
    return
  end
  L_UI:close(self.pageName)
end

function page:initTab()
  local allDressTypeConfig = _playerDressListTpl.data
  local allTabInfo = {}
  for _, config in pairs(allDressTypeConfig) do
    if config ~= nil and config.team == 2 and config.show == 1 and L_ConditionManager:isComplete(config.condition) then
      local tabName = L_Config:provider(config.name)
      local tabInfo = {
        tabId = config.id,
        name = tabName,
        order = config.order,
        txtNameOn = tabName,
        txtNameOff = tabName
      }
      table.insert(allTabInfo, tabInfo)
      self.remScrollPos[config.id] = 1
    end
  end
  table.sort(allTabInfo, function(a, b)
    return a.order < b.order
  end)
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(allTabInfo)
  self.bind.curTabID = self.bind.tabList[1].tabId
end

function page:initItemList(tabId, ignore)
  self.bind.itemList:clear()
  local items = self:getItemListData(tabId)
  self.bind.itemList:insert_array(items)
  if items ~= nil and 0 < #items then
    if self.remSel[tabId] == nil then
      self.remSel[tabId] = items[1].id
    end
    local sel
    for i = 1, #self.bind.itemList do
      if self.bind.itemList:getValue(i, "id") == self.remSel[tabId] then
        sel = self.bind.itemList:getValue(i)
        break
      end
    end
    self:onClickItem(sel)
  end
  if self.remScrollPos[tabId] ~= nil and not ignore then
    local y = self.remScrollPos[tabId]
    self.bind.contentAlpha = 0
    FrameScheduler.add(function()
      if self.bindComponents and self.bindComponents.itemList then
        self.bind.contentAlpha = 1
        self.bindComponents.itemList.verticalNormalizedPosition = y
      end
    end, 1)
  end
end

function page:initConfigData()
  if _itemConfigDict ~= nil then
    return
  end
  _itemConfigDict = {}
  local allDressConfig = _playerDressTpl.data
  for _, config in pairs(allDressConfig) do
    local type = config.type
    local set = _itemConfigDict[type]
    if set == nil then
      set = {}
      _itemConfigDict[type] = set
    end
    local data = {config = config}
    table.insert(set, data)
  end
end

function page:getItemListData(tabId)
  local t = _itemConfigDict[tabId]
  if t ~= nil then
    local dataT = {}
    for _, v in pairs(t) do
      if v.config.show then
        local config = v.config
        local has = L_PlayerDisplayStore:hasItem(config.id)
        has = has or config.customize == 1
        local temp = {
          config = config,
          id = config.id,
          isActive_reddot = false,
          isActive_select = self.curSelItemId == config.id,
          lock = not has
        }
        table.insert(dataT, temp)
      end
    end
    table.sort(dataT, function(a, b)
      local weara = L_PlayerDisplayStore:isCurDress(a.id)
      local wearb = L_PlayerDisplayStore:isCurDress(b.id)
      if weara ~= wearb then
        return weara
      end
      local geta = L_PlayerDisplayStore:getItem(a.id) ~= nil
      local getb = L_PlayerDisplayStore:getItem(b.id) ~= nil
      if geta ~= getb then
        return geta
      end
      return a.id < b.id
    end)
    return dataT
  end
  return {}
end

function page:onClickItem(bind)
  self.curSelItemId = bind.id
  for i = 1, #self.bind.itemList do
    if self.bind.itemList:getValue(i, "id") == self.curSelItemId then
      self.bind.itemList:change(i, {isActive_select = true})
    else
      self.bind.itemList:change(i, {isActive_select = false})
    end
  end
  self:refreshInfo(self.curSelItemId)
  self.remSel[self.bind.curTabID] = bind.id
  self:changeStandeeShow(bind)
end

function page:refreshInfo(id)
  local config = _playerDressTpl:getTplById(id)
  self.bind.txt_itemDesTitle = L_Config:provider(config.name)
  self.bind.txt_itemDesContent = L_Config:provider(config.txt)
  local type = _playerDressTpl:getType(config)
  self.bind.txt_type = _playerDressListTpl:getName(_playerDressListTpl:getTplById(type))
  local has = L_PlayerDisplayStore:hasItem(id)
  has = has or config.customize == 1
  local item = L_PlayerDisplayStore:getItem(id)
  if L_PlayerDisplayStore:isCurDress(id) then
    self.bind.isActive_itemState = true
    self.bind.txt_itemState = L_WordsTpl:getValue("ui_playercard_lipai_selected")
    self.bind.isActive_btnWear = false
  elseif not has then
    self.bind.isActive_itemState = true
    self.bind.txt_itemState = L_WordsTpl:getValue("ui_playercard_lipai_lock")
    self.bind.isActive_btnWear = false
  elseif has then
    self.bind.isActive_itemState = false
    self.bind.isActive_btnWear = true
    if config.customize == 1 and (item == nil or string.isEmpty(item.url)) then
      self.bind.isActive_itemState = true
      self.bind.isActive_btnWear = false
      self.bind.txt_itemState = L_WordsTpl:getValue("ui_playercard_lipai_unshoot")
    else
    end
  else
    self.bind.isActive_itemState = false
    self.bind.isActive_btnWear = false
    self.bind.isActive_btnShoot = false
  end
  if config.customize == 1 then
    self.bind.isActive_btnShoot = true
    if item == nil or string.isEmpty(item.url) then
      self.bind.txt_btnShoot = L_WordsTpl:getValue("ui_playercard_lipai_shoot")
    else
      self.bind.txt_btnShoot = L_WordsTpl:getValue("ui_playercard_lipai_reshoot")
    end
  else
    self.bind.isActive_btnShoot = false
  end
end

function page:refreshOnChange()
  for i = 1, #self.bind.itemList do
    self.modules.itemList[i]:refreshCurDress()
  end
  self:refreshInfo(self.curSelItemId)
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_showkibo_change"))
end

function page:initStandee()
  self.modules.moduleCharacterStandee:setStandeeByBaseInfo(L_PlayerStore:getPlayerBaseInfo())
end

function page:changeStandeeShow(itemBind)
  local config = itemBind.config
  if itemBind.config.type == L_Const.playerDressType.baseboard then
    self.modules.moduleCharacterStandee:setBase({
      isGray = itemBind.lock,
      id = config.id
    })
  elseif itemBind.config.type == L_Const.playerDressType.backboard then
    self.modules.moduleCharacterStandee:setBg({
      isGray = itemBind.lock,
      id = config.id
    })
  elseif itemBind.config.type == L_Const.playerDressType.hero then
    local item = L_PlayerDisplayStore:getItem(config.id)
    local url
    if item ~= nil and not string.isEmpty(item.url) then
      url = item.url
    end
    self.modules.moduleCharacterStandee:setCharacter({
      isGray = itemBind.lock,
      id = config.id,
      url = url
    })
  elseif itemBind.config.type == L_Const.playerDressType.pet then
    self.modules.moduleCharacterStandee:setPet({
      isGray = itemBind.lock,
      id = config.id
    })
  end
end

function page:onEvent_dressItemSync(id)
  if L_PlayerDisplayStore.redDotRootNode ~= nil then
    AzurWorld.RedDotMgr:MarkDirty(id)
  end
end

function page:onClickWear(callback)
  if not self:checkLegal() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_playercard_lipai_fail"))
    return
  end
  local hasChange, data = self:checkChanged()
  if hasChange then
    L_PlayerDisplayStore:req_setStandeeAll(data, callback or handler(self, self.refreshOnChange))
  end
end

function this:checkChanged()
  local hasChange = false
  local cur = L_PlayerDisplayStore:getCurStandeeInfo()
  local data = {
    backboard = cur.backboard,
    baseboard = cur.baseboard,
    pet_accessory = cur.pet_accessory,
    role = table.clone(cur.role)
  }
  for i, v in pairs(self.remSel) do
    if i == L_Const.playerDressType.baseboard then
      if data.baseboard ~= v then
        hasChange = true
        data.baseboard = v
      end
    elseif i == L_Const.playerDressType.backboard then
      if data.backboard ~= v then
        hasChange = true
        data.backboard = v
      end
    elseif i == L_Const.playerDressType.hero then
      local item = L_PlayerDisplayStore:getItem(v)
      local url = ""
      if item ~= nil then
        url = item.url
      end
      if data.role.config ~= v or data.role.config == v and data.role.url ~= url and url ~= nil then
        hasChange = true
        if data.role == nil then
          data.role = {}
        end
        data.role.config = v
        data.role.url = url
      end
    elseif i == L_Const.playerDressType.pet then
      if data.pet_accessory ~= v then
        hasChange = true
      end
      data.pet_accessory = v
    end
  end
  return hasChange, data
end

function this:checkLegal()
  for i, id in pairs(self.remSel) do
    local has = L_PlayerDisplayStore:hasItem(id)
    local config = _playerDressTpl:getTplById(id)
    if not config then
      return false
    end
    has = has or config.customize == 1
    if not has then
      return false
    end
    if i == L_Const.playerDressType.hero and config.customize == 1 then
      local item = L_PlayerDisplayStore:getItem(id)
      if item == nil or string.isEmpty(item.url) then
        return false
      end
    end
  end
  return true
end

function this:sendPhotoId(curSelItemId)
  L_UI:open("pageStandeeShoot", {slotId = curSelItemId})
end

return page
