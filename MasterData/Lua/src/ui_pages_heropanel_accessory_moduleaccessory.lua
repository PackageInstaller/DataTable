local this = class("moduleAccessory", require("ui.pages.HeroPanel.moduleHeroBase"))
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _heroTpl = L_GameTpl.getHeroTpl()
local pageAccessorySoulEssenceListContentName = "pageAccessorySoulEssenceEquipment"
local quality_color = {
  [L_Const.quality.n_] = "#A0AEB7",
  [L_Const.quality.n] = "#8BBAAE",
  [L_Const.quality.r] = "#3AB3FF",
  [L_Const.quality.sr] = "#A264FF",
  [L_Const.quality.ssr] = "#FFBF35"
}
local accessory = {
  L_AccessoryConst.accessoryType.earring,
  L_AccessoryConst.accessoryType.pants,
  L_AccessoryConst.accessoryType.weapon,
  L_AccessoryConst.accessoryType.coat,
  L_AccessoryConst.accessoryType.ring
}

function this.bind()
  return {
    go_moduleHeroAccessory = true,
    list_slot = {
      moduleName = "pages/heroPanel/accessory/cellAccessorySlot"
    },
    go_infoMask = false,
    moduleSoulEssence = {
      moduleName = "pages/heroPanel/accessory/moduleAccessoryShowSoulEssence"
    },
    deatilBtn = L_Const.ModuleInfo.ModuleBtn,
    equipBtn = L_Const.ModuleInfo.ModuleBtn
  }
end

function this.methods()
  return {
    onClick_unequipAccessory = function(self)
      L_GameUtil.showCommonTip({
        txtContent = L_Lang:get(L_WordsTpl:getValue("ui_accessory_remove_all_notice")),
        confirmCallback = function()
          C_AccessoryMgr:req_removeAccessory(self._heroGuid, 0, true)
        end
      })
    end,
    list_slot = {
      onClick_item = function(self, data)
        if data ~= nil then
          local isBlockJump = self:GetSourceLuaPageOptions("failure_jump")
          L_UI:open(pageAccessorySoulEssenceListContentName, {
            isSoulEssence = false,
            heroGuid = data.selectHeroGuid,
            accessoryType = data.accessoryType,
            selectGuid = data.guid,
            isBlockJump = isBlockJump
          })
        end
      end
    },
    onClick_CloseListContent = function()
      local page = C_UIMgr.GetPage(pageAccessorySoulEssenceListContentName)
      if page ~= nil then
        L_UI:close(pageAccessorySoulEssenceListContentName)
      end
    end
  }
end

function this:open()
  self.modules.deatilBtn:setData({
    txtName = L_WordsTpl:getValue("ui_talent_btn_detail"),
    callback = handler(self, function()
      L_UI:open("pageHeroProperty", {
        heroGuid = self._heroGuid,
        showCurrentProperty = self:showCurrentProperty(),
        showArrow = true,
        bPreview = self:isPreviewMode()
      })
    end)
  })
  self.modules.equipBtn:setData({
    txtName = L_WordsTpl:getValue("ui_accessory_auto_equip_btn"),
    callback = handler(self, function()
      self:onClickQuickEquipAccessory()
    end)
  })
  self.refreshModuleActiveHandle = handler(self, self.onEvent_refreshModuleActive)
  C_BagEvent.instance:Listen(C_EBagEvent.ModuleAccessoryActive, self.refreshModuleActiveHandle)
end

function this:show()
  self:refreshPage()
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  self.onEvent_upgradeAccessorySuccessHandle = handler(self, self.onEvent_upgradeAccessorySuccess)
  C_BagEvent.instance:Listen(C_EBagEvent.UpgradeAccessorySuccess, self.onEvent_upgradeAccessorySuccessHandle)
  self.onChangeLockHandle = handler(self, self.onChangeLock)
  C_BagEvent.instance:Listen(C_EBagEvent.AccessoryLockChange, self.onChangeLockHandle)
  self.onEvent_WearAccessoryChangeHandle = self.onEvent_WearAccessoryChangeHandle or L_CommonUtil.handle(self.onEvent_WearAccessoryChange, self)
  C_WorldEvent.instance:Listen(C_EWorldEvent.HeroWearAccessoryChange, self.onEvent_WearAccessoryChangeHandle)
  self.switchHandle = handler(self, self.onEvent_EquipSoulEssenceChange)
  C_BagEvent.instance:Listen(C_EBagEvent.SoulEssenceSwitch, self.switchHandle)
  self.refreshSoulessenceHandle = handler(self, self.onEvent_refreshSoulessence)
  C_BagEvent.instance:Listen(C_EBagEvent.SoulEssenceChange, self.refreshSoulessenceHandle)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Accessory, true)
end

function this:hide()
end

function this:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.UpgradeAccessorySuccess, self.onEvent_upgradeAccessorySuccessHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.AccessoryLockChange, self.onChangeLockHandle)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.HeroWearAccessoryChange, self.onEvent_WearAccessoryChangeHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.SoulEssenceSwitch, self.switchHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.SoulEssenceChange, self.refreshSoulessenceHandle)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Accessory, false)
  C_BagEvent.instance:Cancel(C_EBagEvent.ModuleAccessoryActive, self.refreshModuleActiveHandle)
end

function this:onEvent_hidePage(pageName)
  if pageName == "pageSoulEssenceUpgrade" then
    self:playEnterAni()
  end
end

function this:onChangeLock(param)
  self.isChangeLock = param.lock
end

function this:initPage(params)
  this.super.initPage(self)
  self.initSlot = true
  self._isPageReady = false
  if self.bindComponents and self.bindComponents.anim_Accessory then
    self.bindComponents.anim_Accessory:Stop()
    self.bindComponents.anim_Accessory:Rewind()
    self.bindComponents.anim_Accessory:Play("anim_accessory_in")
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Inventory_Enter")
  self:refreshPage()
  self._isPageReady = true
  self.bind.txt_autoEquipBtn = L_WordsTpl:getValue("ui_accessory_auto_equip_btn")
end

function this:refreshPage()
  self._heroGuid = self:getModeController():getSelectGuid()
  self:initAccessorySlotList()
  self._spiritGuid = L_HeroStore:getHeroSoulEssenceGuid(self:getHero(self._heroGuid))
  if self.modules.moduleSoulEssence ~= nil then
    self.modules.moduleSoulEssence:initModule({
      spiritGuid = self._spiritGuid,
      heroGuid = self._heroGuid
    })
    self.modules.moduleSoulEssence:onGetShowSpiritFunc(function(spiritGuid, heroGuid)
      L_UI:open(pageAccessorySoulEssenceListContentName, {
        isSoulEssence = true,
        spiritGuid = self._spiritGuid,
        heroGuid = self._heroGuid,
        isBlockJump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end)
  end
end

function this:initAccessorySlotList()
  local tmp = {}
  for i, v in ipairs(accessory) do
    table.insert(tmp, {
      type = v,
      index = v,
      heroId = self._heroGuid,
      go_empty = true
    })
  end
  local accessoryList = self:dealAccessoryData(L_HeroStore:getHeroAccessoryGuidList(self:getHero(self._heroGuid)))
  for i, v in ipairs(accessoryList) do
    if not math.isEmpty(v) then
      local serverData = C_AccessoryMgr:getAccessory(v)
      local configData = L_ItemTplManager:getAccessoryItem(serverData.accessoryId)
      local tpl = _accessoryTpl:getTplById(serverData.accessoryId)
      tmp[i].go_equipped = true
      tmp[i].go_empty = false
      tmp[i].guid = v
      tmp[i].accessoryId = serverData.accessoryId
      tmp[i].isPreview = self:isPreviewMode()
      tmp[i].go_btnStrength = not C_AccessoryMgr:getIsMaxLevel(v)
      tmp[i].img_quality_angle = string.format("UI/Atlas/EquipmentRarityep/tex_icon_equipment_rarityep_%s.png", configData.quality + 1)
      if serverData.quality == 5 then
        local path = _accessoryTpl:getSlotIcon(tpl)
        tmp[i].img_icon = path:gsub("%.png$", "_G.png")
      else
        tmp[i].img_icon = _accessoryTpl:getSlotIcon(tpl)
      end
      tmp[i].txt_level = tostring(serverData.level)
      local headRank = _accessoryTpl:getHeadRank(tpl)
      tmp[i].go_headRank = 0 < headRank
      if 0 < headRank then
        tmp[i].img_headRank = C_AccessoryMgr:getAccessoryHeadRankIcon(headRank)
      end
    else
      tmp[i].go_equipped = false
    end
  end
  if self.initSlot then
    self.bind.list_slot:clear()
    self.bind.list_slot:insert_array(tmp)
    self.initSlot = false
  else
    self.bind.list_slot:freshAll(tmp)
  end
  self.accessoryData = tmp
end

function this:dealAccessoryData(accessoryList)
  local newAccessoryList = {}
  for i = 1, #accessoryList do
    if i == 1 then
      newAccessoryList[3] = accessoryList[i]
    elseif i == 2 then
      newAccessoryList[4] = accessoryList[i]
    elseif i == 3 then
      newAccessoryList[2] = accessoryList[i]
    elseif i == 4 then
      newAccessoryList[1] = accessoryList[i]
    else
      newAccessoryList[i] = accessoryList[i]
    end
  end
  return newAccessoryList
end

function this:onEvent_upgradeAccessorySuccess()
  self:initAccessorySlotList()
end

function this:onEvent_WearAccessoryChange(isEquip)
  self:playEquipChangeSound()
  self:initAccessorySlotList()
end

function this:onEvent_EquipSoulEssenceChange()
  if self._spiritGuid ~= 0 then
    self:playEquipChangeSound()
  end
end

function this:onEvent_refreshAccessory(entity)
  self._heroGuid = self:getModeController():getSelectGuid()
  self:initAccessorySlotList()
end

function this:onEvent_refreshSoulessence()
  self:refreshPage()
end

function this:onEvent_refreshModuleActive(_, c_varList)
  self.bind.go_moduleHeroAccessory = c_varList:GetBool(0)
  if self.bind.go_moduleHeroAccessory then
    self.modules.moduleSoulEssence:initModule({
      spiritGuid = self._spiritGuid,
      heroGuid = self._heroGuid
    })
  end
end

function this:getTimelineState()
  return L_Const.heroTimelineState.Equip
end

function this:onClickQuickEquipAccessory()
  local targetAccessoryGuidList, accessoryNeedOpenConfirmTip = self:getQuickEquipTargetAccessoryGuidList()
  local targetSoulEssenceGuid, soulEssenceNeedOpenConfirmTip = self:getQuickEquipTargetSoulEssenceGuid()
  local needOpenConfirmTip = accessoryNeedOpenConfirmTip or soulEssenceNeedOpenConfirmTip
  if table.isEmpty(targetAccessoryGuidList) and targetSoulEssenceGuid == nil then
    L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("ui_one_key_no_equip")))
    return
  end
  
  local function requestQuickEquipAccessory()
    if L_BattleDataManager:checkPlayerBattle() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_accessoryStore"))
      return
    end
    local data = {
      hero_guid = self._heroGuid,
      soulessence_guid = targetSoulEssenceGuid,
      ornament_guids = targetAccessoryGuidList
    }
    printf("6028 一键装备 参数data:", data)
    L_Net:sendMessage(MsgGenCode.CSProtoQuickWear, data, function(rspData, errorCode)
      if errorCode == L_Const.errorCode.ErrCodeSucc then
        self:playEquipChangeSound()
        self:onPlayAnimChange()
      end
    end)
  end
  
  if needOpenConfirmTip then
    L_GameUtil.showCommonTip({
      txtContent = L_Lang:get(L_WordsTpl:getValue("ui_notice_one_key_equip")),
      confirmCallback = requestQuickEquipAccessory
    })
  else
    requestQuickEquipAccessory()
  end
end

function this:playEquipChangeSound()
  if self.bInVoiceCD then
    return
  end
  self.bInVoiceCD = true
  local configId = L_HeroStore:getHero(self._heroGuid).configId
  L_AudioUtil.playSound("Play_VO_System_" .. configId .. "_ChangeEquip")
  self:newOrResetTimer("equipVoiceCD", function()
    self.bInVoiceCD = false
  end, L_GameTpl:getGameConstTpl():getData("CHARACTER_CHANGEEQUIP_VOICE_CD", L_Const.GameTplType.int))
end

function this:getQuickEquipTargetAccessoryGuidList()
  local accessoryType2AccessoryList = {}
  for _, accessoryType in pairs(accessory) do
    local CStargetList = C_AccessoryMgr:GetQuickEquipTargetList(self._heroGuid, accessoryType)
    accessoryType2AccessoryList[accessoryType] = {}
    if CStargetList ~= nil then
      for i = 0, CStargetList.Count - 1 do
        accessoryType2AccessoryList[accessoryType][i + 1] = CStargetList[i]
      end
    end
    printf(string.format("一键装备 accessoryType:%d 排序后的装备list", accessoryType), accessoryType2AccessoryList[accessoryType])
  end
  local accessoryType2targetAccessory = {}
  for _, accessoryType in pairs(accessory) do
    accessoryType2targetAccessory[accessoryType] = accessoryType2AccessoryList[accessoryType][1]
  end
  local heroAccessoryGuidList = L_HeroStore:getHeroAccessoryGuidList(L_HeroStore:getHero(self._heroGuid))
  local accessoryType2HeroAccessoryGuid = {}
  for _, heroAccessoryGuid in pairs(heroAccessoryGuidList) do
    if heroAccessoryGuid ~= 0 then
      local heroAccessory = C_AccessoryMgr:getAccessory(heroAccessoryGuid)
      local accessoryTpl = _accessoryTpl:getTplById(heroAccessory.accessoryId)
      local heroAccessoryType = _accessoryTpl:getType(accessoryTpl)
      accessoryType2HeroAccessoryGuid[heroAccessoryType] = heroAccessoryGuid
    end
  end
  printf("一键装备 英雄身上的装备guidList", accessoryType2HeroAccessoryGuid)
  local needOpenConfirmTip = false
  for _, accessoryType in pairs(accessory) do
    local targetAccessory = accessoryType2targetAccessory[accessoryType]
    local heroAccessoryGuid = accessoryType2HeroAccessoryGuid[accessoryType]
    if targetAccessory and heroAccessoryGuid then
      if targetAccessory.guid == heroAccessoryGuid then
        accessoryType2targetAccessory[accessoryType] = nil
      else
        needOpenConfirmTip = true
      end
    end
  end
  local targetAccessoryGuidList = {}
  for _, accessoryType in pairs(accessory) do
    local taegetAccessory = accessoryType2targetAccessory[accessoryType]
    if taegetAccessory then
      table.insert(targetAccessoryGuidList, taegetAccessory.guid)
    end
  end
  return targetAccessoryGuidList, needOpenConfirmTip
end

function this:getQuickEquipTargetSoulEssenceGuid()
  local soulEssenceList = {}
  local CSsoulEssenceList = C_SoulEssenceMgr:GetQuickEquipTargetList(self._heroGuid)
  if CSsoulEssenceList ~= nil then
    for i = 0, CSsoulEssenceList.Count - 1 do
      soulEssenceList[i + 1] = CSsoulEssenceList[i]
    end
  end
  printf("一键装备 排序筛选后的灵子list", soulEssenceList)
  local needOpenConfirmTip = false
  local targetSpirition = soulEssenceList[1]
  local targetSoulEssenceGuid = targetSpirition and targetSpirition.guid or nil
  local heroSoulEssenceGuid = L_HeroStore:getHeroSoulEssenceGuid(self:getHero(self._heroGuid))
  printf("一键装备 英雄身上的灵子guid", heroSoulEssenceGuid)
  if not math.isEmpty(heroSoulEssenceGuid) then
    if targetSoulEssenceGuid == heroSoulEssenceGuid then
      targetSoulEssenceGuid = nil
    else
      needOpenConfirmTip = true
    end
  end
  return targetSoulEssenceGuid, needOpenConfirmTip
end

function this:onPlayAnimChange(lockChange)
  if lockChange then
    return
  end
  if not self.isBind or not self._isPageReady then
    return
  end
  if not self.bindComponents or not self.bindComponents.anim_Accessory then
    return
  end
  self.bindComponents.anim_Accessory:Stop("anim_accessory_change")
  self.bindComponents.anim_Accessory:Play("anim_accessory_change")
end

function this:playEnterAni()
  if self.bindComponents and self.bindComponents.anim_Accessory then
    self.bindComponents.anim_Accessory:Stop()
    self.bindComponents.anim_Accessory:Rewind()
    self.bindComponents.anim_Accessory:Play("anim_accessory_in")
  end
end

return this
