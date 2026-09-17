local this = class("modulePhotoMenu", G_UIModuleBase)
local _photoGroupTpl = L_GameTpl:getPhotographGroupTpl()
local _photoParamTpl = L_GameTpl:getPhotographParamTpl()
local STATE_MENU = {MAIN = 1, GROUP = 2}
local blockInPlatform = {
  L_Const.photoGroup.lightArrange,
  L_Const.photoGroup.pet,
  L_Const.photoGroup.template
}

function this.bind()
  return {
    menuTabList = {
      moduleName = "pages/photo/modulePhotoMenuTabList"
    },
    group = this.registBindGroup(),
    groupName = "",
    mainList = {
      moduleName = "pages/photo/cell/cellPhotoMenu"
    },
    groupId = 0
  }
end

function this.registBindGroup()
  local tab = {
    type = "toggleModule"
  }
  for key, groupId in pairs(L_Const.photoGroup) do
    if groupId ~= L_Const.photoGroup.situation then
      local cell = {
        assetName = "UI/Pages/Photo/Group/modulePhotoGroup_" .. key,
        moduleName = "pages/photo/group/modulePhotoGroup_" .. key
      }
      tab[tostring(groupId)] = cell
    end
  end
  return tab
end

function this.methods()
  return {
    mainList = {
      onClick_menu = function(self, groupId)
        self:refreshGroup(groupId)
      end
    }
  }
end

function this:toBind(...)
  this.super.toBind(self, ...)
  self.currentMenuTabId = L_Const.photoTabType.SIMPLE
  self.isGoScene = L_PhotoManager.isGoScene
  self:refreshTab()
end

function this:open()
  L_PhotoManager:addListener(L_PhotoManager.event.photoMenuForceRefresh, self.onEvent_photoMenuForceRefresh, self)
  L_PhotoManager:addListener(L_PhotoManager.event.hideGroup, self.hideGroup, self)
end

function this:show()
  if L_PhotoManager.tabCache then
    self:refreshMain(L_PhotoManager.tabCache)
  end
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoMenuForceRefresh, self.onEvent_photoMenuForceRefresh, self)
  L_PhotoManager:removeListener(L_PhotoManager.event.hideGroup, self.hideGroup, self)
end

function this:refreshMaskableList()
  if self.isBind then
    local rectMask2D = self.bindComponents.rectMask2D
    local gameObject = self.bindComponents.goMask
    if not rectMask2D or not gameObject then
      return
    end
    local iClippableArray = gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.UI.IClippable), true)
    if iClippableArray.Length == 0 then
      return
    end
    for i = 0, iClippableArray.Length - 1 do
      rectMask2D:AddClippable(iClippableArray[i])
    end
  end
end

function this:refreshTab()
  local tabList = {
    L_Const.photoTabType.SIMPLE,
    L_Const.photoTabType.PROFESSIONAL
  }
  self.modules.menuTabList:setData(tabList, handler(self, self.onSelectMenuTabId), L_Const.photoTabType.SIMPLE)
  self:refreshMain(self.currentMenuTabId)
end

function this:onSelectMenuTabId(tabId)
  if L_DeviceTpl:getIsPc() then
    if self.currentMenuTabId == tabId then
      return
    end
    self.currentMenuTabId = tabId
    self:refreshMain(tabId)
  else
    if self.currentMenuTabId == L_Const.photoTabType.SIMPLE and tabId == L_Const.photoTabType.SIMPLE then
      self.currentMenuTabId = L_Const.photoTabType.PROFESSIONAL
    elseif self.currentMenuTabId == L_Const.photoTabType.PROFESSIONAL and tabId == L_Const.photoTabType.PROFESSIONAL then
      self.currentMenuTabId = L_Const.photoTabType.SIMPLE
    else
      self.currentMenuTabId = tabId
    end
    self:refreshMain(self.currentMenuTabId)
  end
  self.modules.menuTabList:setSelectTabId(self.currentMenuTabId)
end

function this:refreshMain(tabId)
  L_PhotoManager:sendEvent(L_PhotoManager.event.hideGroup)
  local cfg = _photoGroupTpl:getConfig()
  local list = {}
  local curTabID
  for _, v in ipairs(cfg) do
    local t = _photoGroupTpl:getType(v)
    local id = _photoGroupTpl:getId(v)
    if not C_PhotoPlayUtil:IsMainControlInPLatform() or not table.containsValue(blockInPlatform, id) then
      if tabId == 1 then
        curTabID = 1
      elseif tabId == 2 then
        curTabID = 0
      end
      if self.isGoScene then
        if _photoGroupTpl:getShow(v) and (t == curTabID or t == 1) and id ~= 2 and id ~= 3 then
          local isSelected = id == (self.selGroupId or -1)
          table.insert(list, {
            id = id,
            txt_NameOff = _photoGroupTpl:getName(v),
            txt_NameOn = _photoGroupTpl:getName(v),
            tabGroup = self.bindComponents.mainGroup,
            img_iconOff = _photoGroupTpl:getTabIcon(v),
            img_iconOn = _photoGroupTpl:getTabIcon(v),
            order = v.order,
            goOn = isSelected,
            goOff = not isSelected
          })
        end
      else
        local isSelected = id == (self.selGroupId or -1)
        if _photoGroupTpl:getShow(v) and (t == curTabID or t == 1) then
          table.insert(list, {
            id = id,
            txt_NameOff = _photoGroupTpl:getName(v),
            txt_NameOn = _photoGroupTpl:getName(v),
            tabGroup = self.bindComponents.mainGroup,
            img_iconOff = _photoGroupTpl:getTabIcon(v),
            img_iconOn = _photoGroupTpl:getTabIcon(v),
            order = v.order,
            goOn = isSelected,
            goOff = not isSelected
          })
        end
      end
    end
  end
  table.sort(list, function(a, b)
    return a.order < b.order
  end)
  self.bind.mainList:clear()
  self.bind.mainList:insert_array(list)
  self:translateState(STATE_MENU.MAIN)
  self.bind.groupName = string.empty
  L_PhotoManager.tabCache = tabId
  if self.groupId ~= nil then
    self.bind.groupId = self.groupId
  end
  self.parent:refreshMoveBlockPos(-1)
end

function this:refreshGroup(groupId)
  if groupId == L_Const.photoGroup.situation then
    L_UI:open("pageSituation")
    return
  end
  self.selGroupId = groupId
  self:refreshMainListSelect()
  self.groupId = groupId
  if groupId == -1 then
    return
  end
  self:translateState(STATE_MENU.GROUP)
  self.bind.groupName = tostring(groupId)
  self.parent:refreshMoveBlockPos(self.groupId)
  L_PhotoManager:sendEvent(L_PhotoManager.event.photoMenuStateChange, false, self.groupId)
end

function this:refreshMainListSelect()
  local arr = self.bind.mainList
  if not arr then
    return
  end
  for i = 1, arr:getLength() do
    local item = arr[i]
    if item then
      local on = item.id == self.selGroupId
      item.goOn = on
      item.goOff = not on
      local md = arr:getItemCls(i)
      if md and md.isBind then
        md.bind.goOn = on
        md.bind.goOff = not on
      end
    end
  end
end

function this:translateState(state)
  self.state = state
  if self.state == STATE_MENU.MAIN then
    self.bind.groupName = string.empty
  elseif self.groupId == L_Const.photoGroup.wind then
    local tpl = _photoParamTpl:getTplById(L_Const.photoParam.windDirection)
    local name = _photoParamTpl:getName(tpl)
  elseif self.groupId == L_Const.photoGroup.pet then
  elseif self.groupId == L_Const.photoGroup.template then
  else
    local tpl = _photoGroupTpl:getTplById(self.groupId)
    if tpl then
      local name = _photoGroupTpl:getName(tpl)
    end
  end
end

function this:changeTxtSelecton_pet()
  if self.bind and self.bind.txtSelection then
    local Mediator = L_PhotoManager:getMediator()
    if Mediator and Mediator.isPetAction then
      self.bind.txtSelection = ""
    else
      local tpl = _photoGroupTpl:getTplById(L_Const.photoGroup.pet)
      if tpl then
        local name = _photoGroupTpl:getName(tpl)
        local str = string.format("%s(%s/%s)", name, L_PhotoManager:getPhotoPetEntityCount(), L_PhotoStore.canShowPetMaxVal)
        self.bind.txtSelection = str
      end
    end
  end
end

function this:onEvent_photoMenuForceRefresh()
  self:translateState(self.state)
end

function this:hideGroup()
  self:translateState(STATE_MENU.MAIN)
  self.groupId = -1
  self.bind.groupId = self.groupId
  self.parent:refreshMoveBlockPos(self.groupId)
  self:refreshMainListSelect()
end

return this
