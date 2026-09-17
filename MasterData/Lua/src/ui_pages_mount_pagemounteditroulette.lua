local this = class("pageMountEditRoulette", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _mountTpl = L_GameTpl:getMountTpl()
local columnNum = 5
local minLineNum = 3
local NAV_AREA_MountGrid = "MountGrid"
local NAV_AREA_FilterBar = "FilterBar"
local BOTTOM_GROUP_CAN_ADD = "OnMountGridCanAdd"
local BOTTOM_GROUP_NO_ADD = "OnMountGridNoAdd"
local BOTTOM_GROUP_ON_FILTER_BAR = "OnFilterBar"
local ROULETTE_MAX_COUNT = 8

function this.bind()
  return {
    go_empty = false,
    scrollList_mount = {
      moduleName = "pages/mount/cellEditMount"
    },
    module_mountRoulette = {
      moduleName = "pages/mount/moduleMountRoulette"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:playAnimation(false)
    end,
    onClick_bgClose = function(self)
      self:playAnimation(false)
    end,
    scrollList_mount = {
      onClick_select = function(self, bind)
        L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Select")
        local isUnlockRiding, itemId = L_MountManager:getIsMountUnlock(bind.guid)
        if not isUnlockRiding then
          local configTpl = L_ItemTplManager:getMountSaddleItem(itemId)
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("petsaddle_no_saddles", {
            name = configTpl.name
          }))
          L_UI:open("pageMountRidingInfo", {
            petId = bind.guid
          })
          return
        end
        L_MountManager:reqSetMountRoulettePos(bind.guid, self._selectIndex, function()
          L_AudioUtil.stopSound(self.petVoiceWrap)
          self.petVoiceWrap = L_PetStore:playPetVoiceSound(bind.itemId, L_PetConst.PetSystemVoiceType.IntoWheel)
          C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Edit_MountOn")
          self:refreshGamepadCuts(NAV_AREA_MountGrid)
        end)
      end
    },
    module_mountRoulette = {
      onClick_empty = function(self, index)
        self:setRouletteModuleSelectIndex(index)
        C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Edit_Tab_Slide")
      end,
      onClick_inMounting = function(self)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_unable_replace"))
      end,
      onClick_equipped = function(self, index)
        self:removeFromRoulette(index)
      end,
      onClick_notEquipped = function(self, index)
        self:removeFromRoulette(index)
      end
    }
  }
end

function this:check(options, callback)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.EditMountRoulette))
    if callback ~= nil then
      callback(false)
    end
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  local isMountEditLock = result and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mountEditRoulette)
  if callback ~= nil then
    callback(isMountEditLock)
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  options = options or {}
  self._callback = options.callback
  self:initRouletteModule()
  self:initSortFilterModule()
  self:initMountList()
  self._ESyncMountRouletteServerDataHandler = handler(self, self.onEvent_refreshMount)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:open()
  self:playAnimation(true)
end

function this:show()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_L3, function()
    local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
    if navMng then
      navMng:AddPendingArea(NAV_AREA_FilterBar)
      self:refreshGamepadCuts(NAV_AREA_FilterBar)
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_Triangle, function()
    local guid = L_MountStore:getMountMap()[self._rouletteModule:getSelectIndex()]
    if math.isEmpty(guid) then
      return
    end
    self:removeFromRoulette(self._rouletteModule:getSelectIndex())
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_L2, function()
    self:switchTab(-1)
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_R2, function()
    self:switchTab(1)
  end)
  C_InputManager.SetGamepadUIInputMap(self.pageName, true)
end

function this:hide()
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_L3)
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_Triangle)
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_L2)
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EGamepadUI_R2)
  C_InputManager.SetGamepadUIInputMap(self.pageName, false)
end

function this:close()
  this.super.close(self)
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
  if self._callback then
    self._callback()
  end
  self:clearMountNew()
  L_AudioUtil.stopSound(self.petVoiceWrap)
end

function this:escHandle()
  local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
  if navMng.currentAreaName == NAV_AREA_FilterBar then
    navMng:AddPendingArea(NAV_AREA_MountGrid)
    self:refreshGamepadCuts(NAV_AREA_MountGrid)
    return
  end
  L_UI:close(self.pageName)
end

function this:initSortFilterModule()
  self._sortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.mountEditRoulette, function()
    self.bindComponents.ani_verGridView_mount:Stop()
    self.bindComponents.ani_verGridView_mount:Play("anim_mounteditroulette_change")
    self:initMountList()
  end, function()
    self:initMountList()
  end)
  self._sortFilter:bindModule(self.modules.module_sortFilter)
end

function this:initRouletteModule()
  self._rouletteModule = self.modules.module_mountRoulette
  self._selectIndex = L_MountManager:getMinCanAddMountRoulettePos()
  self._rouletteModule:setData_rouletteEdit(self._selectIndex)
  self:refreshGamepadCuts(NAV_AREA_MountGrid)
end

function this:setRouletteModuleSelectIndex(index)
  self._selectIndex = index
  self._rouletteModule:setSelectIndex(self._selectIndex)
end

function this:initMountList()
  local petList = L_PetStore:getPetList()
  local dataList = {}
  for i, v in pairs(petList) do
    local tpl = _petTpl:getTplById(v.id)
    local isMount = _petTpl:getIsMount(tpl)
    if isMount then
      table.insert(dataList, {
        itemType = L_Const.resType.pet,
        itemId = v.id,
        guid = v.guid,
        firstSortKey = L_SortFilterManager:getNotDefaultFirstSortKey(L_SystemConst.enum.mountEditRoulette, self._sortFilter.sortKeyList)
      })
    end
  end
  self._sortFilter:sortFilterList(dataList)
  local isEmpty = table.isEmpty(dataList)
  self.bind.go_empty = isEmpty
  if not isEmpty then
    local lineNum = math.ceil(#dataList / columnNum)
    lineNum = math.max(minLineNum, lineNum)
    self.bindComponents.verGridView_mount.disableScroll = lineNum <= minLineNum
    local dataListCount = #dataList
    for i = 1, lineNum * columnNum - dataListCount do
      table.insert(dataList, {})
    end
  end
  self.bind.scrollList_mount:clear()
  self.bind.scrollList_mount:insert_array(dataList)
end

function this:clearMountNew()
  local allMount = _mountTpl.data
  for i, v in pairs(allMount) do
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.MountNew, _mountTpl:getId(v))
  end
end

function this:refreshMountList()
  for i, v in pairs(self.modules.scrollList_mount) do
    local cell = v
    cell:initCell()
  end
end

function this:removeFromRoulette(index)
  L_MountManager:reqRemoveMountFormRoulettePos(index, function()
    C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Edit_MountOff")
    self:setRouletteModuleSelectIndex(index)
    local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
    self:refreshGamepadCuts(navMng.currentAreaName)
  end)
end

function this:onEvent_refreshMount()
  self:refreshMountList()
end

function this:playAnimation(isIn)
  if not self.isBind or not self.bindComponents.anim_commonEditRoulette then
    return
  end
  local inStr = "in"
  if not isIn then
    inStr = "out"
    L_TimerManager:newOrResetTimer(self, "editroulette_out", function()
      L_UI:close(self.pageName)
    end, 0.15)
  end
  local mobileStr = ""
  self.bindComponents.anim_commonEditRoulette:Play(string.format("anim_common_editroulette_%s", inStr .. mobileStr))
end

function this:switchTab(delta)
  local newIdx = self._selectIndex + delta
  if newIdx > ROULETTE_MAX_COUNT then
    newIdx = 1
  elseif newIdx <= 0 then
    newIdx = ROULETTE_MAX_COUNT
  end
  self._selectIndex = newIdx
  self._rouletteModule:setSelectIndex(self._selectIndex)
end

function this:refreshGamepadCuts(currentNavArea)
  local groupName = BOTTOM_GROUP_CAN_ADD
  if currentNavArea == NAV_AREA_MountGrid then
    local pos = L_MountManager:getMinCanAddMountRoulettePos()
    groupName = math.isEmpty(pos) and BOTTOM_GROUP_NO_ADD or BOTTOM_GROUP_CAN_ADD
  elseif currentNavArea == NAV_AREA_FilterBar then
    groupName = BOTTOM_GROUP_ON_FILTER_BAR
  end
  local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    moduleOrPageName = self.pageName,
    changeGroupName = groupName
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
end

return this
