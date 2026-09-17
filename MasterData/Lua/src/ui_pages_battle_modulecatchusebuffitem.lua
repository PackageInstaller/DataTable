local this = class("moduleCatchUseBuffItem", G_UIModuleBase)
local _foodTpl = L_GameTpl:getFoodTpl()
local _adapter = CS.Lens.Gameplay.Modules.Azur.WorldAdapter
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

local function _playSfx(eventName)
  if string.isEmpty(eventName) then
    return
  end
  if L_AudioUtil and L_AudioUtil.playSound then
    L_AudioUtil.playSound(eventName)
  end
end

local function _getLensLevelById(lensId)
  if not lensId or lensId == 0 then
    return 0
  end
  if not L_PetConst or not L_PetConst.PetCatchLensItemIds then
    return 0
  end
  for i, v in ipairs(L_PetConst.PetCatchLensItemIds) do
    if v == lensId then
      return i
    end
  end
  return 0
end

function this.bind()
  return {
    activeUnSelect = true,
    activeSelect = false,
    imgIcon = "",
    txtNum = "",
    txtName = "",
    activeBg = false,
    activeName = false,
    activeDesc = false,
    iconCGAlpha = 1,
    active_ScanList = false,
    active_arrows = true,
    active_iconRoot = true,
    list_scan = {
      moduleName = "pages/battle/cellCatchScanItem"
    },
    fillAmount_longpress = 0,
    active_longProess = false
  }
end

function this.methods()
  return {
    onBtnUse = function(self)
      self:onBtnUseItem()
    end,
    onBtnOpenScanList = function(self)
      self:onOpenScanList(true)
    end,
    onBtnUseScan = function(self)
      if self.isScan then
        self.index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
        if self.index < 0 then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lens_no_kibo_target"))
          return
        end
        local num = C_BagMgr:getItemNumByItemId(self.curSelectScanId)
        if self.curSelectScanId == 0 or num <= 0 then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lens_num_zero"))
          return
        end
        self:SendScanPetInfo()
      end
    end,
    list_scan = {
      onclick_Select = function(self, id)
        local oldId = self.curSelectScanId or 0
        self.bind.active_arrows = true
        self.bind.active_iconRoot = true
        self.bind.active_ScanList = false
        if id and id ~= 0 and id ~= oldId then
          _playSfx("Play_SFX_System_UI_CatchLens_Switch")
        end
        if not C_BagMgr:checkScanUsingItem(id) then
          local _itemid = id
          C_BagMgr:UseBagItem(_itemid, function(rspData, errCode)
            C_BagMgr:setScanUsingItemId(_itemid)
            self:setBuffItemData(_itemid, L_Const.resType.commonItem, nil, true)
          end)
        end
      end
    }
  }
end

function this:onOpenScanList(isPass)
  if not self.isScan then
    return
  end
  if isPass then
    local function func()
      _playSfx("Play_SFX_System_UI_CatchLens_Open")
      
      self.bind.active_arrows = false
      self.bind.active_iconRoot = false
      self.bind.active_ScanList = true
      local tab = {}
      local keyId = 0
      local keyBase = 1
      for i, v in ipairs(L_PetConst.PetCatchLensItemIds) do
        table.insert(tab, {configId = v, keyId = keyId})
        keyId = keyId + keyBase
      end
      self.bind.list_scan:clear()
      self.bind.list_scan:insert_array(tab)
      local length = self.bind.list_scan:getLength()
      self.curSelectScanId = self.curSelectScanId == 0 and L_PetConst.PetCatchLensItemIds[1] or self.curSelectScanId
      for i = 1, length do
        self.curSelectKeyId = self.bind.list_scan:getItemCls(i):onShowSelectByConfigId(self.curSelectScanId)
        if self.curSelectKeyId ~= -1 then
          self.parent:onSetScanScalePos(self.curSelectKeyId)
          break
        end
      end
      self.parent:OnSetScanSelectState(function(value)
        for i = 1, length do
          local keyId = self.bind.list_scan:getItemCls(i):onShowSelectByKeyId(tonumber(value))
          self.curSelectScanId = keyId ~= -1 and keyId or self.curSelectScanId
        end
      end)
      self.bind.active_arrows = false
      self.bind.active_iconRoot = false
      self.bind.active_ScanList = true
      local tab = {}
      local keyId = 0
      local keyBase = 1
      for i, v in ipairs(L_PetConst.PetCatchLensItemIds) do
        table.insert(tab, {configId = v, keyId = keyId})
        keyId = keyId + keyBase
      end
      self.bind.list_scan:clear()
      self.bind.list_scan:insert_array(tab)
      local length = self.bind.list_scan:getLength()
      local selectScanId = self.curSelectScanId
      self.curSelectScanId = selectScanId == 0 and L_PetConst.PetCatchLensItemIds[1] or selectScanId
      for i = 1, length do
        self.curSelectKeyId = self.bind.list_scan:getItemCls(i):onShowSelectByConfigId(self.curSelectScanId)
        if self.curSelectKeyId ~= -1 then
          self.parent:onSetScanScalePos(self.curSelectKeyId)
          break
        end
      end
      self.parent:OnSetScanSelectState(function(value)
        for i = 1, length do
          local keyId = self.bind.list_scan:getItemCls(i):onShowSelectByKeyId(tonumber(value))
          self.curSelectScanId = keyId ~= -1 and keyId or self.curSelectScanId
        end
      end)
    end
    
    if L_DeviceTpl:getIsPc() then
      if self.tween then
        self.tween:Kill()
      end
      
      local function funcTween()
        self.tween:Kill()
        
        local function getter()
          return self.bind.fillAmount_longpress
        end
        
        local function setter(value)
          self.bind.fillAmount_longpress = value
        end
        
        self.tween = DOTween.To(getter, setter, 1, 1):OnComplete(function()
          self.isOpenList = true
          func()
        end)
      end
      
      local fromValue = 0
      local toValue = 1
      local timer = 0.1
      
      local function click_getter()
        return fromValue
      end
      
      local function click_setter(value)
        fromValue = value
      end
      
      self.tween = DOTween.To(click_getter, click_setter, toValue, timer):OnComplete(function()
        self.scenKeyCode = true
        funcTween()
      end)
    else
      func()
    end
  else
    if self.tween then
      self.bind.fillAmount_longpress = 0
      self.tween:Kill()
    end
    if self.scenKeyCode then
      if self.isOpenList then
        self.bind.active_arrows = true
        self.bind.active_iconRoot = true
        local _itemid = self.curSelectScanId
        local num = C_BagMgr:getItemNumByItemId(_itemid)
        if not C_BagMgr:checkScanUsingItem(_itemid) and 0 < num then
          C_BagMgr:UseBagItem(_itemid, function(rspData, errCode)
            self.isUseScan = true
            C_BagMgr:setScanUsingItemId(_itemid)
            self:setBuffItemData(_itemid, L_Const.resType.commonItem, nil, true)
          end)
        else
          self:setBuffItemData(_itemid, L_Const.resType.commonItem, nil, true)
        end
      end
    elseif self.isScan then
      self.index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
      if 0 > self.index then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lens_no_kibo_target"))
        return
      end
      local num = C_BagMgr:getItemNumByItemId(self.curSelectScanId)
      if self.curSelectScanId == 0 or num <= 0 then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lens_num_zero"))
        return
      end
      self:SendScanPetInfo()
      return
    end
    self.scenKeyCode = false
    self.isOpenList = false
  end
end

function this:show(options)
  this.super.show(self, options)
  self:bindPcKey()
end

function this:hide(options)
  this.super.hide(self, options)
  self.isInitShortCut = false
end

function this:checkOpenScanList()
  return self.isOpenList
end

function this:setBuffItemData(itemId, itemType, buffId, isScan)
  self.itemId = itemId
  self.itemType = itemType
  self.buffId = buffId
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleCatchUseBuffItem setBuffItemData 1")
  if not isScan and not buffId then
    local tpl = _foodTpl:getTplById(self.itemId)
    self.buffId = _foodTpl:getBuffId(tpl)
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
  self.isScan = isScan
  self.isHasItemBuff = false
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleCatchUseBuffItem setBuffItemData 2")
  self:refresh(true)
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:bindShortCutData(key, keyFlag)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  self._shortCutKey = key
  self._shortCutKeyFlag = keyFlag
  self.isInitShortCut = false
  self:bindPcKey()
end

function this:bindNestCoopShortCutData()
  self:bindShortCutData(C_InputManager_KeyType.EMainPetCatchUseBuffItem1, "Q")
end

function this:SendScanPetInfo(itemId)
  local req = {}
  req.tar_id = {}
  local scanId = itemId or self.curSelectScanId
  self.monsterEntity = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[self.index]
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local catchPetInfo = C_PetStore:GetTargetMonsterEntityHistoryCatchPetInfo(self.monsterEntity.data.UUID)
  if catchPetInfo == nil then
    return
  end
  if scanId <= catchPetInfo.petLenId then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lens_already_use"))
    return
  end
  table.insert(req.tar_id, self.monsterEntity.data.UUID)
  req.day_weather = C_GameTime.GetServerPeriod()
  req.reason = 1
  req.pet_len_id = scanId
  req.ObjID = self.monsterEntity.data.BelongGroup.ObjID
  req.Level = self.monsterEntity.data.level
  req.Index = self.monsterEntity.data.BelongUnit.ObjIndex
  local level = _getLensLevelById(scanId)
  if 1 <= level and level <= 3 then
    print(string.format("Play_SFX_System_UI_CatchLens_Use_%02d", level))
    _playSfx(string.format("Play_SFX_System_UI_CatchLens_Use_%02d", level))
  end
  AzurWorld.ScanMgr:OnSenCatchScanProtoLua(req)
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:Rewind()
  self.bindComponents.anim:Play("anim_buffitem_sp_use")
end

function this:onBtnUseItem()
  if not (self.itemId and self.itemType) or self.isPetCatching then
    return
  end
  if self.isScan then
    return
  end
  if self.parent ~= nil and self.parent.bBlockHand then
    return
  end
  local num = L_ItemTplManager:getItemNum(self.itemType, self.itemId)
  if num <= 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lack_star_link_meal"))
    L_ItemTplManager:showInfoTip(self.itemType, self.itemId)
    return
  end
  if self.isHasItemBuff then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_star_link_buff_already_exist"),
      confirmCallback = function()
        self:useBuffItem()
      end
    })
    return
  end
  self:useBuffItem()
end

function this:useBuffItem()
  C_BagMgr:ReqUseItem(self.itemId, 1, nil, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_bag_useSuccess"))
    self:playAnim("anim_buffitem_on")
    _playSfx("Play_SFX_System_UI_CatchLens_Food")
    L_PetStore:call(L_PetStore.event.refreshPetCatchFoodBuff, {})
  end)
end

function this:open()
  self.isOpenList = false
  self:addListener()
  if AzurWorld.PetCatchManagerMgr:IsNestCoopPetCatch() then
    self.onUpdateBuffTimer = handler(self, self.updateBuffTimer)
    L_TimerManager:newOrResetTimer(self, "moduleCatchUseBuffItem", self.onUpdateBuffTimer, 0.5, -1)
  end
end

function this:updateBuffTimer()
  if self.buff then
    self:refreshBuffTime(self.buff)
  end
end

function this:close()
  L_TimerManager:stopTimer(self, "moduleCatchUseBuffItem")
  self.onUpdateBuffTimer = nil
  if self._shortCutKeyFlag then
    L_ShortCutManager:clearShortKeyFlag(self)
  end
  self:removeListener()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:bindPcKey()
  if self.isInitShortCut then
    return
  end
  local pageName = self.parent.pageName
  if pageName == nil then
    pageName = "pageNestCoopPetCatch"
  end
  if self._shortCutKey and not self.isScan then
    L_ShortCutManager:registerShortCut(pageName, self._shortCutKey, function(value)
      self:onKeyUseBuffItem()
    end)
  end
  if self.isScan then
    self.bind.active_longProess = L_DeviceTpl:getIsPc()
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EMainPetCatchUseBuffItem4, function(isPass)
      if self.isLimitScan then
        return
      end
      self:onOpenScanList(isPass)
    end, true)
  end
  if self._shortCutKeyFlag then
    L_ShortCutManager:addShortKeyFlag(self, self._shortCutKeyFlag, L_Const.AnchorType.Middle, self.bindComponents.shortCutTran)
  end
  self.isInitShortCut = true
end

function this:onKeyUseBuffItem()
  self:onBtnUseItem()
end

function this:removeListener()
  self.onEventRefreshBagHandle = handler(self, self.onEventRefreshBag)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEventRefreshBagHandle)
  L_BuffStore:unListenCallFunc(L_BuffStore.event.buffRefresh, self.refreshWorldBuff, self)
  C_PetStoreEvent.instance:Cancel(C_EPetStoreEvent.refreshPetCatchHistoryInfos, self._onMonsterHistoryCatchInfoUpdate)
end

function this:addListener()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEventRefreshBagHandle)
  L_BuffStore:listenCallFunc(L_BuffStore.event.buffRefresh, self.refreshWorldBuff, self)
  self._onMonsterHistoryCatchInfoUpdate = handler(self, self.onEventScanRefreshBag)
  C_PetStoreEvent.instance:Listen(C_EPetStoreEvent.refreshPetCatchHistoryInfos, self._onMonsterHistoryCatchInfoUpdate)
end

function this:refreshWorldBuff()
  if not self.buffId then
    return
  end
  local buff = L_BuffStore:getBuffData(self.buffId)
  self.buff = buff
  if buff then
    local isPlayAnim = not self.isHasItemBuff
    self.isHasItemBuff = true
    self:refreshBuffTime(buff)
    if isPlayAnim then
      self:playAnim("anim_buffitem_on")
    end
  elseif self.isHasItemBuff then
    self.isHasItemBuff = false
    self:playAnim("anim_buffitem_off")
  end
end

function this:onEventRefreshBag()
  local num = C_BagMgr:getItemNumByItemId(self.itemId)
  self:refreshNum(num)
end

function this:onEventScanRefreshBag()
  if self.isScan and self.isUseScan then
    local num = C_BagMgr:getItemNumByItemId(self.itemId)
    self:refreshNum(num - 1)
    self.isUseScan = false
  end
end

function this:refreshNum(num)
  if 9999 < num then
    num = 9999
  end
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleCatchUseBuffItem refreshNum 1")
  local color = C_LuaUtility.ParseHtmlStringColor(0 < num and "#ffffff" or "#ff9292")
  self.bind.txtNum = tostring(num)
  self.bind.iconCGAlpha = 0 < num and 1 or 0.5
  self.bindComponents.txtNumColor.color = color
  if self.bindComponents.imgNumTran then
    L_GameUtil.forceRebuildLayout(self.bindComponents.imgNumTran)
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:refresh(isInit)
  if not (self.itemId and self.itemType) or not self.isBind then
    return
  end
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleCatchUseBuffItem refresh 1")
  if self.isScan then
    self.curSelectScanId = self.itemId
  end
  local buff = L_BuffStore:getBuffData(self.buffId)
  self.buff = buff
  self.isHasItemBuff = buff ~= nil
  local itemConfig = L_ItemTplManager:getItemConfig(self.itemType, self.itemId)
  self._itemName = itemConfig.name
  self.bind.imgIcon = itemConfig.icon
  self.bind.active_ScanList = false
  CS.UnityEngine.Profiling.Profiler.EndSample()
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleCatchUseBuffItem refresh 2")
  self:refreshBuffTime(buff)
  self:refreshNum(itemConfig.num)
  CS.UnityEngine.Profiling.Profiler.EndSample()
  self.bind.activeSelect = true
  self.bind.activeUnSelect = true
  self.bind.activeBg = true
  self.bind.activeName = true
  self.bind.activeDesc = true
  if isInit and not self.isScan then
    local animName = self.isHasItemBuff and "anim_buffitem_on" or "anim_buffitem_off_init"
    self:playAnim(animName)
  end
end

function this:refreshBuffTime(buff)
  local time = self:getBuffTime(buff)
  self.bind.txtName = L_WordsTpl:getValue("ui_star_link_buff_remain_time", {
    [0] = self._itemName or "",
    [1] = time
  })
end

function this:getBuffTime(buff)
  if not buff then
    return 0
  end
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleCatchUseBuffItem getBuffTime 1")
  local time = buff.remain_time or 0
  CS.UnityEngine.Profiling.Profiler.EndSample()
  return time
end

function this:playAnim(animName)
  if self.bindComponents.anim then
    self.bindComponents.anim:Stop()
    self.bindComponents.anim:Play(animName)
  end
end

function this:onLimitScanPet()
  self.isLimitScan = true
  self:hideSelectEffect()
end

function this:onStartCatch()
  self.isPetCatching = true
  self:hideSelectEffect()
end

function this:hideSelectEffect()
  if not self.isBind then
    return
  end
  self.bind.activeSelect = false
end

return this
