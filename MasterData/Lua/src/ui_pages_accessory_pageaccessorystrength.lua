local this = class("pageAccessoryStrength", G_UIPageBase)
local toggleTable = {
  [1] = "anim_strengthToggle",
  [2] = "anim_starUpToggle",
  [3] = "anim_inheritToggle"
}
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessoryLevelTpl = L_GameTpl:getAccessoryLevelTpl()
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _accessoryMainTpl = L_GameTpl:getAccessoryMainTpl()
local _wordTpl = L_GameTpl:getWordsTpl()
local CONST_AUTOSTRENGTH = "auto_Strength"
local compContent = L_WordsTpl:getValue("ui_accessory_auto_level_up_text")
local _heroTpl = L_GameTpl.getHeroTpl()
local uptip_time = 0.6
local attCell_baseTime = 0.15

function this.bind()
  return {
    go_bg = false,
    img_icon = "",
    img_iconEft = "",
    go_img_FX = false,
    txt_name = "",
    active_maxLvNode = true,
    active_previewLvNode = true,
    txt_levelCur = "",
    txt_levelCurPreview = "",
    txt_levelNext = "",
    list_subMainAtt = {
      moduleName = "pages/accessory/cellAccessorySubMainAttStrength"
    },
    active_maxLvCostNode = false,
    active_previewLvCostNode = false,
    list_cost = L_Const.ModuleInfo.CellIconBag,
    btn_levelUp = L_Const.ModuleInfo.ModuleBtn,
    go_mask = false,
    go_accessoryUpgrade = true,
    txt_AccessoryDynamicModuleName = "",
    accessoryDynamicModule = {
      type = "toggleModule",
      moduleAccessoryStarUp = {
        assetName = "UI/Pages/Accessory/moduleAccessoryStarUp",
        moduleName = "pages/accessory/moduleAccessoryStarUp"
      },
      moduleAccessoryInherit = {
        assetName = "UI/Pages/Accessory/moduleAccessoryInherit",
        moduleName = "pages/accessory/moduleAccessoryInherit"
      }
    },
    go_quailtyNode = true,
    go_btnContent = true,
    go_inheritToggle = true,
    go_autoNode = false,
    txt_autoDes = "",
    go_autoIcon = true,
    go_autoLightIcon = false,
    txt_autoContent = compContent,
    go_LightBgNode = true,
    go_BlackBgNode = true,
    go_FX_Lineglow = true,
    go_starUpFx = false,
    go_toggleMask = false
  }
end

function this.methods()
  return {
    onClick_StrengthToggle = function(self, isOn)
      if isOn then
        self.bindComponents.anim:Play("anim_AStrength_change_stength")
        self:togglePlayAnim("anim_AStrength_cell_btn_selected", 1)
        self.bind.go_FX_Lineglow = true
        self.bind.go_accessoryUpgrade = true
        self.bind.go_quailtyNode = true
        self.bind.go_LightBgNode = true
        self.bind.go_BlackBgNode = true
        self.bind.go_starUpFx = false
        self.bind.txt_AccessoryDynamicModuleName = ""
        self:clearTimer()
        self:initAccessoryInfo()
      end
    end,
    onClick_StarUp = function(self, isOn)
      if isOn then
        self.bindComponents.anim:Play("anim_AStrength_change_homology")
        self:togglePlayAnim("anim_AStrength_cell_btn_selected", 2)
        self.bind.go_FX_Lineglow = false
        self.bind.go_accessoryUpgrade = false
        self.bind.go_quailtyNode = true
        self.bind.go_BlackBgNode = true
        self.bind.go_LightBgNode = true
        self.bind.txt_AccessoryDynamicModuleName = "moduleAccessoryStarUp"
        self.modules.accessoryDynamicModule.moduleAccessoryStarUp:InitModule({
          guid = self._strengthGuid,
          onAddItemFunc = function()
            self:setAuailtyNodeActive(false)
          end,
          onClosePage = function()
            self:setAuailtyNodeActive(true)
          end
        })
        self:refreshAccessory()
        self:clearTimer()
      end
    end,
    onClick_Inherit = function(self, isOn)
      if isOn then
        self.bindComponents.anim:Play("anim_AStrength_change_inherit")
        self:togglePlayAnim("anim_AStrength_cell_btn_selected", 3)
        self.bind.go_accessoryUpgrade = false
        self.bind.go_quailtyNode = false
        self.bind.go_BlackBgNode = false
        self.bind.go_starUpFx = false
        self.bind.go_LightBgNode = false
        self.bind.txt_AccessoryDynamicModuleName = "moduleAccessoryInherit"
        self.modules.accessoryDynamicModule.moduleAccessoryInherit:InitModule({
          guid = self._strengthGuid
        })
        self:clearTimer()
      end
    end,
    onClick_showCompartion = function(self)
      self.autoStrengthLevel = 0
      self.autoStrength = not self.autoStrength
      self:refreshAutoBtnStat(self.autoStrength)
      self:refreshStrengthPreview(false)
    end
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:checkAndTip(L_SystemConst.enum.accessoryStrength)
  if not result then
    callback(result)
    return
  end
  callback(true)
end

function this:setAuailtyNodeActive(state)
  self.bind.go_btnContent = state
  self.bind.go_quailtyNode = state
end

function this:onEvent_upgradeAccessorySuccess(oldData)
  self:clearTimer()
  self.isPlayingAnim = true
  self.serverData = C_AccessoryMgr:getAccessory(self._strengthGuid)
  self.isMaxLv = C_AccessoryMgr:getIsMaxLevel(self._strengthGuid)
  self.bindComponents.anim:Play("anim_AStrength_levelup")
  C_AudioManager.Play("Play_SFX_System_UI_Equipment_Succeed")
  self:newOrResetTimer("timer1", function()
    self.bindComponents.animUpgrade:Play(self.isMaxLv and "anim_AStrength_uptip_max" or "anim_AStrength_uptip")
    self:newOrResetTimer("timer7", function()
      for i = 1, self.bind.list_subMainAtt:getLength() do
        self:newOrResetTimer("cell_Timer" .. tostring(i), function()
          self.bind.list_subMainAtt:getItemCls(i):onPlayAnim()
        end, attCell_baseTime * (i - 1))
      end
    end, uptip_time)
    self:refreshStrengthPreview(true)
  end, 1)
  self.bind.go_mask = true
  self:newOrResetTimer("timer2", function()
    self.isPlayingAnim = false
    self.bind.go_mask = false
  end, 2.5)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_reqClosePage, self)
  local isAuto = L_CommonUtil.getLocalBoolValue(CONST_AUTOSTRENGTH)
  self._strengthGuid = options.accessoryId
  self.isPlayingAnim = false
  self.autoStrengthLevel = 0
  self.animQueue = {}
  self:refreshAutoBtnStat(isAuto)
  self:registerToggleEvent()
  self:togglePlayAnim("anim_AStrength_cell_btn_selected", 1)
  self:initPage()
end

function this:open(options)
  self.onEvent_upgradeAccessorySuccessHandle = handler(self, self.onEvent_upgradeAccessorySuccess)
  C_BagEvent.instance:Listen(C_EBagEvent.UpgradeAccessorySuccess, self.onEvent_upgradeAccessorySuccessHandle)
  self.onEvent_homologyAccessorySuccessHandle = handler(self, self.onEvent_homologyAccessorySuccess)
  C_BagEvent.instance:Listen(C_EBagEvent.HomologyAccessorySuccess, self.onEvent_homologyAccessorySuccessHandle)
  self.onEvent_refreshAccessoryHandle = handler(self, self.onEvent_refreshAccessory)
  C_BagEvent.instance:Listen(C_EBagEvent.AccessoryPartChange, self.onEvent_refreshAccessoryHandle)
end

function this:close(options)
  self:clearTimer()
  L_CommonUtil.setLocalBoolValue(CONST_AUTOSTRENGTH, self.autoStrength)
  L_UI:removeListener(L_UI.pageEvent.reqClose, self.onEvent_reqClosePage, self)
  C_BagEvent.instance:Cancel(C_EBagEvent.UpgradeAccessorySuccess, self.onEvent_upgradeAccessorySuccessHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.HomologyAccessorySuccess, self.onEvent_homologyAccessorySuccessHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.AccessoryPartChange, self.onEvent_refreshAccessoryHandle)
  if L_CommonUtil.isValid(self.handle) and self.handle.IsValid then
    self.handle:Dispose()
  end
  if L_UI:checkPageOpen("PageAccessoryStarUpMaterialBag") then
    L_UI:close("PageAccessoryStarUpMaterialBag")
  end
  this.super.close(self, options)
end

function this:onEvent_homologyAccessorySuccess(oldData)
  self:clearTimer()
  self.serverData = C_AccessoryMgr:getAccessory(self._strengthGuid)
  self.isMaxLv = C_AccessoryMgr:getIsMaxLevel(self._strengthGuid)
  self:refreshStrengthPreview(true)
end

function this:onEvent_refreshAccessory()
  local acessory = C_AccessoryMgr:getAccessory(self._strengthGuid)
  if acessory == nil then
    L_UI:close(self.pageName)
  end
end

function this:registerToggleEvent()
  self.actionTab = {}
  local EventTrigger = Unity.EventSystems.EventTrigger
  local EventTriggerType = Unity.EventSystems.EventTriggerType
  local animName_highlight = "anim_AStrength_cell_btn_highlighted"
  local animName_normal = "anim_AStrength_cell_btn_normal"
  local entryEnter_detailToggleEnter = EventTrigger.Entry()
  entryEnter_detailToggleEnter.eventID = EventTriggerType.PointerEnter
  entryEnter_detailToggleEnter.callback = EventTrigger.TriggerEvent()
  entryEnter_detailToggleEnter.callback:AddListener(function(eventData)
    self:togglePlayAnim(animName_highlight, 1)
  end)
  local entryEnter_detailToggleExit = EventTrigger.Entry()
  entryEnter_detailToggleExit.eventID = EventTriggerType.PointerExit
  entryEnter_detailToggleExit.callback = EventTrigger.TriggerEvent()
  entryEnter_detailToggleExit.callback:AddListener(function(eventData)
    self:togglePlayAnim(animName_normal, 1)
  end)
  self.bindComponents.event_strengthToggle.triggers:Add(entryEnter_detailToggleEnter)
  self.bindComponents.event_strengthToggle.triggers:Add(entryEnter_detailToggleExit)
  local entryEnter_breakToggleEnter = EventTrigger.Entry()
  entryEnter_breakToggleEnter.eventID = EventTriggerType.PointerEnter
  entryEnter_breakToggleEnter.callback = EventTrigger.TriggerEvent()
  entryEnter_breakToggleEnter.callback:AddListener(function(eventData)
    self:togglePlayAnim(animName_highlight, 2)
  end)
  local entryEnter_breakToggleExit = EventTrigger.Entry()
  entryEnter_breakToggleExit.eventID = EventTriggerType.PointerExit
  entryEnter_breakToggleExit.callback = EventTrigger.TriggerEvent()
  entryEnter_breakToggleExit.callback:AddListener(function(eventData)
    self:togglePlayAnim(animName_normal, 2)
  end)
  self.bindComponents.event_starUpToggle.triggers:Add(entryEnter_breakToggleEnter)
  self.bindComponents.event_starUpToggle.triggers:Add(entryEnter_breakToggleExit)
  local entryEnter_inheritToggleEnter = EventTrigger.Entry()
  entryEnter_inheritToggleEnter.eventID = EventTriggerType.PointerEnter
  entryEnter_inheritToggleEnter.callback = EventTrigger.TriggerEvent()
  entryEnter_inheritToggleEnter.callback:AddListener(function(eventData)
    self:togglePlayAnim(animName_highlight, 3)
  end)
  local entryEnter_inheritToggleExit = EventTrigger.Entry()
  entryEnter_inheritToggleExit.eventID = EventTriggerType.PointerExit
  entryEnter_inheritToggleExit.callback = EventTrigger.TriggerEvent()
  entryEnter_inheritToggleExit.callback:AddListener(function(eventData)
    self:togglePlayAnim(animName_normal, 3)
  end)
  self.bindComponents.event_inheritToggle.triggers:Add(entryEnter_inheritToggleEnter)
  self.bindComponents.event_inheritToggle.triggers:Add(entryEnter_inheritToggleExit)
end

function this:togglePlayAnim(animName, type)
  if self.animQueue[type] == nil then
    self.animQueue[type] = {isSelect = false}
  end
  if animName == "anim_AStrength_cell_btn_selected" then
    self.animQueue[type].isSelect = true
    self.bindComponents[toggleTable[type]]:Play(animName)
    for key, v in pairs(toggleTable) do
      if key ~= type then
        self.bindComponents[toggleTable[key]]:Play("anim_AStrength_cell_btn_normal")
        if self.animQueue[key] == nil then
          self.animQueue[key] = {isSelect = false}
        else
          self.animQueue[key].isSelect = false
        end
      end
    end
    return
  end
  if not self.animQueue[type].isSelect then
    self.animQueue[type].isSelect = false
    self.bindComponents[toggleTable[type]]:Play(animName)
  end
end

function this:initPage()
  self.bind.go_bg = not L_UI:checkPageOpen("pageHero")
  self:RefreshInheritToggle()
  self:initAccessoryInfo()
  C_AudioManager.Play("Play_SFX_System_UI_EquipmentEnhance_Open")
end

function this:RefreshInheritToggle()
  local serverData = C_AccessoryMgr:getAccessory(self._strengthGuid)
  self.bind.go_inheritToggle = serverData.quality > 0
end

function this:initAccessoryInfo()
  self:refreshAccessory()
  self:refreshStrengthPreview(false)
end

function this:refreshAccessory()
  local serverData = C_AccessoryMgr:getAccessory(self._strengthGuid)
  local accessoryCfg = _accessoryTpl:getTplById(serverData.accessoryId)
  self.quality = _accessoryTpl:getRarity(accessoryCfg)
  self.type = _accessoryTpl:getType(accessoryCfg)
  self.posMatch = false
  if _accessoryTpl:getPosition(accessoryCfg) > 0 and serverData.wearHero ~= 0 then
    local heroId = AzurWorld.heroMgr:GetHero(serverData.wearHero).configId
    local heroConfigData = _heroTpl:getTplById(heroId)
  end
  if serverData.quality == 5 then
    local path = _accessoryTpl:getLargeIconByTpl(accessoryCfg)
    self.bind.img_icon = path:gsub("%.png$", "_G.png")
    self.bind.go_img_FX = true
    self.handle = C_LuaUtility.LoadTexture(path:gsub("%.png$", "_G.png"), function(maskTex)
      self.bindComponents.fx_ui_golden_equipment.material:SetTexture("_MaskTex", maskTex)
      self.bindComponents.fx_ui_golden_equipment.material:SetTexture("_DissolveTex", maskTex)
    end)
  else
    self.bind.img_icon = _accessoryTpl:getLargeIconByTpl(accessoryCfg)
    self.bind.go_img_FX = false
  end
  self.bind.img_iconEft = _accessoryTpl:getLargeIconByTpl(accessoryCfg)
  for i = 0, self.bindComponents.bgEftRoot.childCount - 1 do
    local go = self.bindComponents.bgEftRoot:GetChild(i)
    L_CommonUtil.setObjActive(go.gameObject, 4 - self.quality == i)
  end
  self.bind.txt_name = _accessoryTpl:getName(accessoryCfg)
end

function this:refreshAutoBtnStat(isAuto)
  self.autoStrength = isAuto
  self.bind.go_autoIcon = not isAuto
  self.bind.go_autoLightIcon = isAuto
  self.bind.txt_autoContent = not isAuto and string.format("<color=#565756>%s</color>", compContent) or string.format("<color=#dd8d25>%s</color>", compContent)
end

function this:checkAutoStrengthLevel()
  local currentLevel = self.serverData.level
  local maxLevel = _accessoryLevelTpl:getMaxLevelByAccessoryId(self.serverData.accessoryId)
  local costItemMap = {}
  local canAuto = true
  local moneyNum = 0
  for level = currentLevel, maxLevel do
    local costList = _accessoryLevelTpl:getUpgradeCostByAccessoryIdAndLevel(self.serverData.accessoryId, level)
    for _, v in ipairs(costList) do
      local itemId = v[2]
      if itemId == L_Const.currencyType.gold then
        moneyNum = (moneyNum or 0) + v[3]
        local hasNum = L_ItemTplManager:getItemNum(L_Const.resType.currency, itemId)
        if moneyNum > hasNum then
          canAuto = false
          break
        end
      else
        if not costItemMap[itemId] then
          costItemMap[itemId] = {
            itemType = v[1],
            itemId = itemId,
            itemCostNum = 0
          }
        end
        costItemMap[itemId].itemCostNum = costItemMap[itemId].itemCostNum + v[3]
        local hasNum = L_ItemTplManager:getItemNum(v[1], itemId)
        if hasNum < costItemMap[itemId].itemCostNum then
          canAuto = false
          break
        end
      end
    end
    if not canAuto then
      self.autoStrengthLevel = level
      break
    end
  end
  if canAuto then
    self.autoStrengthLevel = maxLevel
  end
end

function this:refreshStrengthCost()
  if self.isMaxLv then
    return
  end
  local serverData = self.serverData
  local accessoryId = serverData.accessoryId
  local currentLevel = serverData.level
  local costMoneyInfo = {
    itemType = L_Const.resType.currency
  }
  local costItemMap = {}
  
  local function mergeCost(costList)
    for _, v in ipairs(costList) do
      if v[2] == L_Const.currencyType.gold then
        costMoneyInfo.itemId = v[2]
        costMoneyInfo.itemCostNum = (costMoneyInfo.itemCostNum or 0) + v[3]
      else
        local itemId = v[2]
        local found = false
        for _, v1 in ipairs(costItemMap) do
          if v1.itemId == itemId then
            v1.itemCostNum = v1.itemCostNum + v[3]
            found = true
            break
          end
        end
        if not found then
          table.insert(costItemMap, {
            itemType = v[1],
            itemId = itemId,
            itemCostNum = v[3]
          })
        end
      end
    end
  end
  
  local cost = _accessoryLevelTpl:getUpgradeCostByAccessoryIdAndLevel(accessoryId, currentLevel)
  mergeCost(cost)
  if self.autoStrength then
    self.bind.txt_autoDes = "Level +" .. tostring(self.autoStrengthLevel)
    if self.autoStrengthLevel > self.serverData.level then
      for level = currentLevel + 1, self.autoStrengthLevel - 1 do
        local levelCost = _accessoryLevelTpl:getUpgradeCostByAccessoryIdAndLevel(accessoryId, level)
        mergeCost(levelCost)
      end
    end
  end
  local costItemInfo = {}
  for _, v in ipairs(costItemMap) do
    table.insert(costItemInfo, v)
  end
  self.bCanUpgrade = true
  local itemListData = {}
  for _, v in ipairs(costItemInfo) do
    local hasNum = L_ItemTplManager:getItemNum(v.itemType, v.itemId)
    local isEnough = hasNum >= v.itemCostNum
    local itemNumTxt
    if isEnough then
      itemNumTxt = string.format("%d/%d", hasNum, v.itemCostNum)
    else
      itemNumTxt = string.format("<color=#ff0000ff>%d</color>/%d", hasNum, v.itemCostNum)
      self.bCanUpgrade = false
    end
    table.insert(itemListData, {
      itemType = v.itemType,
      itemId = v.itemId,
      itemNumTxt = itemNumTxt
    })
  end
  self.bind.list_cost:clear()
  self.bind.list_cost:insert_array(itemListData)
  self.bind.go_autoNode = self.autoStrength and self.autoStrengthLevel > self.serverData.level or false
  local moduleBtn = self.modules.btn_levelUp
  if costMoneyInfo.itemId == nil then
    return
  end
  moduleBtn:setData({
    txtName = _wordTpl:getTplById("equipment_upgrade_btn_text"),
    callback = function()
      self:reqStrength()
    end,
    itemType = costMoneyInfo.itemType,
    itemId = costMoneyInfo.itemId,
    itemNum = costMoneyInfo.itemCostNum or 0
  })
  if not self.bCanUpgrade then
    return
  end
  local hasMoneyNum = L_ItemTplManager:getItemNum(costMoneyInfo.itemType, costMoneyInfo.itemId)
  self.bCanCurrencyUpgrade = hasMoneyNum >= costMoneyInfo.itemCostNum
end

function this:getLevelShow(level)
  if level < 10 then
    return "0" .. tostring(level)
  end
  return tostring(level)
end

function this:refreshMainAtt(isRefresh)
  local elem_att = C_AccessoryMgr:getPackAtt(self.serverData).elemAtt
  local main_attsNext
  local tmp_tbl = {}
  if elem_att.groupId ~= 0 then
    if self.autoStrength then
      main_attsNext = _accessoryMainTpl:getTplByGroupIdAndLevel(elem_att.groupId, self.autoStrengthLevel > self.serverData.level and self.autoStrengthLevel or self.serverData.level + 1)
    else
      main_attsNext = _accessoryMainTpl:getTplByGroupIdAndLevel(elem_att.groupId, self.serverData.level + 1)
    end
    local newValue
    if not self.isMaxLv then
      newValue = _battleInfoTpl:getShowTxtIntByQuality(elem_att.attId, _accessoryMainTpl:getValue(main_attsNext[1]), self.serverData.quality, self.posMatch)
    end
    local battleTpl = _battleInfoTpl:getTplById(elem_att.attId)
    table.insert(tmp_tbl, {
      mainAttIcon = _battleInfoTpl:getIcon(battleTpl),
      mainAttName = elem_att.showName,
      mainValue = tostring(_battleInfoTpl:getShowTxtInt(elem_att.attId, elem_att.value, self.posMatch)),
      mainNewValue = newValue,
      isMax = self.isMaxLv,
      showEle = true,
      elementType = _battleInfoTpl:getElementType(battleTpl)
    })
  end
  local main_atts = C_AccessoryMgr:getPackAtt(self.serverData).mainAtt
  local main_attsNext
  if self.autoStrength then
    main_attsNext = _accessoryMainTpl:getTplByGroupIdAndLevel(main_atts[0].groupId, self.autoStrengthLevel > self.serverData.level and self.autoStrengthLevel or self.serverData.level + 1)
  else
    main_attsNext = _accessoryMainTpl:getTplByGroupIdAndLevel(main_atts[0].groupId, self.serverData.level + 1)
  end
  local main_att
  local index = 0
  for _, v in pairs(main_atts) do
    if main_att == nil then
      main_att = v
    end
    index = index + 1
    local tpl_mainAttBattleInfo = _battleInfoTpl:getTplById(v.attId)
    local newValue
    if not self.isMaxLv then
      newValue = _battleInfoTpl:getShowTxtIntByQuality(v.attId, _accessoryMainTpl:getValue(main_attsNext[index]), self.serverData.quality, self.posMatch)
    end
    table.insert(tmp_tbl, {
      mainAttIcon = _battleInfoTpl:getIcon(tpl_mainAttBattleInfo),
      mainAttName = v.showName,
      mainValue = _battleInfoTpl:getShowTxtInt(v.attId, v.value, self.posMatch),
      mainNewValue = newValue,
      isMax = self.isMaxLv,
      showEle = false
    })
  end
  if not isRefresh then
    self.bind.list_subMainAtt:clear()
    self.bind.list_subMainAtt:insert_array(tmp_tbl)
  else
    self.bind.list_subMainAtt:freshAll(tmp_tbl)
  end
end

function this:refreshStrengthPreview(bAfterUpgrade)
  if not bAfterUpgrade then
    self.serverData = C_AccessoryMgr:getAccessory(self._strengthGuid)
    self.isMaxLv = C_AccessoryMgr:getIsMaxLevel(self._strengthGuid)
    self:checkAutoStrengthLevel()
    self.bind.active_maxLvNode = self.isMaxLv
    self.bind.active_previewLvNode = not self.isMaxLv
    if self.isMaxLv then
      self.bind.txt_levelCur = self:getLevelShow(self.serverData.level)
    else
      local nextLevel = self.serverData.level + 1
      local showLevel = self.autoStrength and self.autoStrengthLevel > self.serverData.level and self.autoStrengthLevel or nextLevel or nextLevel
      self.bind.txt_levelCurPreview = self:getLevelShow(self.serverData.level)
      self.bind.txt_levelNext = self:getLevelShow(showLevel)
    end
    self.bind.active_maxLvCostNode = self.isMaxLv
    self.bind.active_previewLvCostNode = not self.isMaxLv
    self:refreshStrengthCost()
    self:refreshMainAtt()
    self:mainAttValueChange()
    return
  end
  self.serverData = C_AccessoryMgr:getAccessory(self._strengthGuid)
  self.isMaxLv = C_AccessoryMgr:getIsMaxLevel(self._strengthGuid)
  if self.isMaxLv then
    self.bind.active_maxLvNode = true
    self.bind.active_maxLvCostNode = true
    self:newOrResetTimer("timer3", function()
      self.bind.active_previewLvNode = false
      self.bind.active_previewLvCostNode = false
    end, 1.5)
  else
    self.bind.active_maxLvNode = self.isMaxLv
    self.bind.active_previewLvNode = not self.isMaxLv
    self.bind.active_maxLvCostNode = self.isMaxLv
    self.bind.active_previewLvCostNode = not self.isMaxLv
  end
  if self.isMaxLv then
    self.bind.txt_levelCur = self:getLevelShow(self.serverData.level)
  else
    self:newOrResetTimer("timer4", function()
      self.bind.txt_levelCurPreview = self:getLevelShow(self.serverData.level)
    end, 0.265)
    self:newOrResetTimer("timer5", function()
      local nextLevel = self.serverData.level + 1
      local showLevel = self.autoStrength and self.autoStrengthLevel > self.serverData.level and self.autoStrengthLevel or nextLevel or nextLevel
      self.bind.txt_levelNext = self:getLevelShow(showLevel)
    end, 0.495)
  end
  self:refreshStrengthCost()
  self:refreshMainAtt(true)
  self:mainAttValueChange(true)
end

function this:mainAttValueChange(needAnim)
  if needAnim then
    for i = 1, self.bind.list_subMainAtt:getLength() do
      self:newOrResetTimer("cellTimer_change" .. tostring(i), function()
        self.bind.list_subMainAtt:getItemCls(i):changeValue()
      end, uptip_time + attCell_baseTime * i)
    end
  else
    for i = 1, self.bind.list_subMainAtt:getLength() do
      self.bind.list_subMainAtt:getItemCls(i):changeValue()
    end
  end
end

function this:SetToggleState(state)
  self.bind.go_toggleMask = state
end

function this:reqStrength()
  if self.isPlayingAnim then
    return
  end
  if not self.bCanUpgrade then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_accessory_level_up_lack_material"))
    return
  end
  if not self.bCanCurrencyUpgrade then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_accessory_level_up_lack_currency"))
    return
  end
  local autoCount = self.autoStrength and self.autoStrengthLevel > self.serverData.level and self.autoStrengthLevel - self.serverData.level or 1 or 1
  C_AccessoryMgr:req_upgradeAccessory(self._strengthGuid, autoCount)
end

function this:onEvent_reqClosePage(pageName)
  if pageName ~= self.pageName then
    self:refreshStrengthCost()
  end
end

function this:clearTimer()
  self:stopTimer("timer1")
  self:stopTimer("timer2")
  self:stopTimer("timer3")
  self:stopTimer("timer4")
  self:stopTimer("timer5")
  self:stopTimer("timer6")
  self:stopTimer("timer7")
end

return this
