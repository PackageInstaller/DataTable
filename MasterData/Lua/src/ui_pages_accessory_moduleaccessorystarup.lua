local this = class("moduleAccessoryStarUp", G_UIModuleBase)
local _wordTpl = L_GameTpl:getWordsTpl()
local _fightProhibitTbl = L_GameTpl:getFightProhibitTpl()
local costNum = 4
local limitConditions = {
  _wordTpl:getTplById("accessory_upgrade_ui_accessory_not_strengthen"),
  _wordTpl:getTplById("accessory_upgrade_ui_accessory_not_limited")
}
local conditionTypeEnum = {NotStrength = 1, Normal = 2}
local animRefreshStar = false
local initLoad = true
local isAttLevelUpAnim = false

function this.bind()
  return {
    list_star = {
      moduleName = "pages/accessory/cellAccessoryPreviewStarUp"
    },
    list_subAtt = {
      moduleName = "pages/accessory/cellAccessorySubAttStarUp"
    },
    list_option = {
      moduleName = "pages/accessory/cellAccessoryStarUpSortFilterDropdown"
    },
    costList = L_Const.ModuleInfo.CellAddItem,
    btn_StarLevelUp = L_Const.ModuleInfo.ModuleBtn,
    txt_content = "",
    txt_currentFilter = "",
    txt_autoContent = "",
    go_lvNotMax = true,
    go_lvMax = true,
    go_jumpCurLv = true,
    go_filterContentActive = false,
    go_arrowNormal = true,
    go_arrowActive = false,
    color_filterName = C_Color.white,
    color_filterIcon = C_Color.white,
    go_mask = false
  }
end

function this.methods()
  return {
    list_option = {
      onClick_select = function(self, itemBind)
        self.filterConditionType = itemBind.conditionType
        self.filterActive = false
        self:RefreshArrowStat(self.filterActive)
        self:refreshOptionList()
        self:InitBagList()
      end
    },
    onclick_Next = function(self)
      if self.isMax or self.previewStarLv >= self.limitStarLv then
        return
      end
      self.animRefreshStar = true
      isAttLevelUpAnim = false
      self.previewStarLv = self.previewStarLv >= self.limitStarLv and self.limitStarLv or self.previewStarLv + 1
      self:refreshPreviewInfo()
      for i = 1, self.bind.list_star:getLength() do
        if i <= self.starLv then
          self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellIconStar_FadeIn")
        elseif i < self.previewStarLv - 1 then
          self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellYellowStar_2_FadeIn")
        end
      end
      self:stopTimer("RefreshStar")
      self:newOrResetTimer("RefreshStar", function()
        for i = 1, self.bind.list_star:getLength() do
          if i <= self.starLv then
            self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellIconStar_FadeIn")
          elseif i == self.previewStarLv - 1 then
            self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellYellowStar_2_FadeIn")
          elseif i == self.previewStarLv then
            self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellPreviewStar_FadeIn")
          end
        end
      end, 0.23)
      self.bindComponents.starListAnim:Stop()
      self.bindComponents.starListAnim:Play("anim_starPreviewNode_Next")
    end,
    onclick_Last = function(self)
      if self.isMax or self.previewStarLv <= self.starLv + 1 then
        return
      end
      isAttLevelUpAnim = false
      self.animRefreshStar = true
      self.previewStarLv = self.previewStarLv <= self.starLv + 1 and self.starLv + 1 or self.previewStarLv - 1
      self:refreshPreviewInfo()
      for i = 1, self.bind.list_star:getLength() do
        if i <= self.starLv then
          self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellIconStar_FadeIn")
        elseif i > self.previewStarLv + 1 then
          self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_Disable")
        end
      end
      self:stopTimer("RefreshStar")
      self:newOrResetTimer("RefreshStar", function()
        for i = 1, self.bind.list_star:getLength() do
          if i <= self.starLv then
            self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellIconStar_FadeIn")
          elseif i == self.previewStarLv + 1 then
            self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_Disable")
          elseif i == self.previewStarLv then
            self.bind.list_star:getItemCls(i):animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellPreviewStar_FadeIn")
          end
        end
      end, 0.23)
      self.bindComponents.starListAnim:Stop()
      self.bindComponents.starListAnim:Play("anim_starPreviewNode_Last")
    end,
    onclick_JumpCurLv = function(self)
      if self.lastNormal then
        return
      end
      self.previewStarLv = self.starLv == self.limitStarLv and self.limitStarLv or self.starLv + 1
      self.initStar = true
      self.isJump = true
      animRefreshStar = false
      self:refreshPreviewInfo()
    end,
    onclick_Auto = function(self)
      if #self.selectDatas >= self.limitCostNum then
        local index = 1
        table.clear(self.selectDatas)
        self:refreshCostList()
        return
      end
      local res = self.bagDataList
      for i = 1, #res do
        local flag = false
        if self.filterConditionType ~= conditionTypeEnum.NotStrength or not (res[i].level > 0) and res[i].bLock ~= true then
          for j = 1, #self.selectDatas do
            if self.selectDatas[j] == res[i].guid then
              flag = true
              break
            end
          end
          if not flag then
            table.insert(self.selectDatas, res[i].guid)
          end
        end
        if #self.selectDatas >= self.limitCostNum then
          break
        end
      end
      if #self.selectDatas < self.limitCostNum then
        L_FlyMsgManager:showNormalMsg(_wordTpl:getTplById("accessory_upgrade_notice_accessory_not_enough"))
      end
      self:refreshCostList()
    end,
    onClick_filterBtn = function(self)
      self.filterActive = not self.filterActive
      self:RefreshArrowStat(self.filterActive)
    end,
    onClick_Aquire = function(self)
      local serverData = C_AccessoryMgr:getAccessory(self.guid)
      L_UI:open("pageAccessoryInfoTipLarge", {
        itemId = serverData.accessoryId,
        scrollToAccess = true,
        isBlockJump = self:GetSourceLuaPageOptions("notShowAccess")
      })
    end
  }
end

function this:preOpen()
end

function this:close()
  animRefreshStar = false
  isAttLevelUpAnim = false
  initLoad = true
end

function this:InitModule(options)
  self.options = options
  self.guid = options.guid
  self.serverData = C_AccessoryMgr:getAccessory(options.guid)
  self.starLv = self.serverData.grade
  self.onAddItemFunc = options.onAddItemFunc
  self.onClosePage = options.onClosePage
  self.filterActive = false
  self.initStar = true
  local att = C_AccessoryMgr:getPackAtt(self.serverData)
  local tempItem = L_ItemTplManager:getItemConfig(L_Const.resType.accessory, self.serverData.accessoryId)
  local upgradeConfig = C_AccessoryMgr:getAccessoryUpgradeConfig(tempItem.quality, self.starLv + 1)
  self.filterConditionType = 1
  self.sub_att = att.subAtt
  self.limitStarLv = upgradeConfig.maxGrade
  self.isMax = self.starLv == self.limitStarLv
  self.previewStarLv = self.isMax and self.limitStarLv or self.starLv + 1
  if not self.isMax then
    self.limitCostNum = upgradeConfig.config.count
    self.selectDatas = {}
    local config = upgradeConfig.config
    local moduleBtn = self.modules.btn_StarLevelUp
    self.starUpNeedCurrency = config.cost[0][2]
    moduleBtn:setData({
      txtName = _wordTpl:getTplById("ui_soulessence_level_up"),
      callback = function()
        if not self.lastNormal then
          return
        end
        self:OrnamentGradeUp()
      end,
      itemType = config.cost[0][0],
      itemId = config.cost[0][1],
      itemNum = self.starUpNeedCurrency
    })
    self:InitBagList()
    self:refreshOptionList()
    self:refreshCostList()
  end
  self:RefreshArrowStat(self.filterActive)
  self:refreshPreviewInfo()
end

function this:InitBagList()
  local res = {}
  local acc = C_AccessoryMgr:getHeroAccessory()
  for key, value in pairs(acc) do
    local serverData = C_AccessoryMgr:getAccessory(value.guid)
    if serverData.grade == 0 and value ~= nil and self.serverData ~= nil and value.wearHero == 0 and value.accessoryId == self.serverData.accessoryId and value.guid ~= self.serverData.guid then
      table.insert(res, {
        guid = value.guid,
        itemType = L_Const.resType.accessory,
        itemId = value.accessoryId,
        level = value.level,
        wearHero = value.wearHero,
        quality = value.quality,
        bLock = value.bLock
      })
    end
  end
  table.sort(res, function(x, y)
    if x.level ~= y.level then
      return x.level < y.level
    end
    if x.quality ~= y.quality then
      return x.quality < y.quality
    end
    return x.guid < y.guid
  end)
  self.bagDataList = res
end

function this:OrnamentGradeUp()
  if C_BattleManager.IsInBattle(C_EntityManager.MainPlayer) then
    local cfg = _fightProhibitTbl:getTplById(1030)
    L_FlyMsgManager:showNormalMsg(_fightProhibitTbl:getBlockTips(cfg))
    return
  end
  if #self.selectDatas < self.limitCostNum then
    L_FlyMsgManager:showNormalMsg(_wordTpl:getTplById("accessory_upgrade_notice_accessory_not_enough_2"))
    return
  end
  if L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) < self.starUpNeedCurrency then
    L_FlyMsgManager:showNormalMsg(_wordTpl:getTplById("accessory_upgrade_notice_money_not_enough"))
    return
  end
  C_AccessoryMgr:rsp_OrnamentGradeUp(self.guid, {
    costList = self.selectDatas
  }, function(errorCode, msgData)
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      return
    end
    self.parent.bindComponents.anim:Play("anim_AStrength_star_levellup")
    C_AudioManager.Play("Play_SFX_System_UI_Equipment_Upgrade")
    self.bind.go_mask = true
    self.parent:SetToggleState(true)
    self:newOrResetTimer("SetMaskState", function()
      self.parent:SetToggleState(false)
      self.bind.go_mask = false
    end, 1.3)
    if msgData and msgData.rewards and msgData.rewards.Count > 0 then
      local rewards = require("ui.manager.reward.rewardData").new()
      rewards.rewardShowType = L_Const.rewardShowType.full
      local rewardList = {}
      for i = 0, msgData.rewards.Count - 1 do
        table.insert(rewardList, msgData.rewards[i])
      end
      local data = L_DataUtil.parseRewardConfig(rewardList, true, true)
      rewards:constructList(data)
      L_RewardManager:ShowReward(rewards, false, nil, msgData.src)
    end
    self.canPlayLevelUpAnim = true
    self.notAttributeupAnim = true
    isAttLevelUpAnim = true
    self:InitModule(self.options)
    self.parent:RefreshInheritToggle()
    self.parent:refreshAccessory()
    for i = 1, self.bind.list_star:getLength() do
      if i == self.starLv then
        self.bind.list_star:getItemCls(i):playLevelUpAnim("anim_AStrength_cellAccessoryPreviewStarUp_LevelUp")
      elseif i == self.previewStarLv then
        self.bind.list_star:getItemCls(i):playLevelUpAnim("anim_AStrength_cellAccessoryPreviewStarUp_cellPreviewStar_FadeIn")
      end
    end
  end)
end

function this:ChangePreviewStarInfo(guid, starLv)
  local serverData = C_AccessoryMgr:getAccessory(guid)
  local att = C_AccessoryMgr:getPreviewStarSubAtt(serverData.accessoryId, starLv)
  self:RefreshSubAtt(att.subAtt)
end

function this:refreshPreviewInfo()
  self:PreviewStar(self.previewStarLv)
  self:ChangePreviewStarInfo(self.guid, self.previewStarLv)
end

function this:RefreshContentUI(limitCostNum)
  self.bind.txt_autoContent = #self.selectDatas == limitCostNum and _wordTpl:getTplById("accessory_upgrade_ui_clear_selected_accessory") or _wordTpl:getTplById("accessory_upgrade_ui_auto_selecte_accessory")
  self.bind.txt_content = L_WordsTpl:getValue("accessory_upgrade_ui_accessory_required", {
    [0] = tostring(#self.selectDatas),
    [1] = tostring(limitCostNum)
  })
end

function this:RefreshSubAtt(subAtt)
  local subTmp = {}
  local index = 0
  for i, v in pairs(subAtt) do
    local nextLv = v.bLock and 0 or v.skillLv - self.sub_att[index].skillLv
    local lvNodeActive = self.previewStarLv ~= self.starLv and 0 < nextLv
    table.insert(subTmp, {
      id = v.id,
      skillEntryId = v.skillEntryId,
      name = v.skillName,
      level = v.skillLv,
      limitNum = self.limitCostNum,
      lvNodeActive = lvNodeActive,
      previewLv = nextLv,
      isLock = v.bLock,
      skillIconPath = v.iconPath,
      star = v.star,
      isCanUnlockSkill = self.sub_att[index].bLock and self.previewStarLv == v.firstUnlockLevel,
      canPlayLevelUpAnim = self.canPlayLevelUpAnim,
      notAttributeupAnim = self.notAttributeupAnim
    })
    index = index + 1
  end
  if initLoad then
    self.bind.list_subAtt:clear()
    self.bind.list_subAtt:insert_array(subTmp)
    initLoad = false
  else
    self.bind.list_subAtt:freshAll(subTmp)
    for i = 1, self.bind.list_subAtt:getLength() do
      if isAttLevelUpAnim and not self.bind.list_subAtt:getItemCls(i).bind.isCanUnlockSkill then
        self:newOrResetTimer("StarDaleyTime" .. tostring(i), function()
          self.bind.list_subAtt:getItemCls(i):LevelUpAnim()
          local index = i
          self:newOrResetTimer("attcell_DaleyTime" .. tostring(index), function()
            self.bind.list_subAtt:getItemCls(index):refreshUI()
          end, 0.23)
        end, 0.6 + i * 0.1)
      else
        self.bind.list_subAtt:getItemCls(i):refreshUI()
      end
    end
  end
  self.canPlayLevelUpAnim = false
  self.notAttributeupAnim = false
end

function this:PreviewStar(starLv)
  local starLv = starLv
  local isMax = self.limitStarLv <= self.starLv
  local isCurLv = self.previewStarLv == self.starLv + 1
  
  local function InitStarList()
    local tmp_tbl = {}
    for i = 1, self.limitStarLv do
      local tab = {
        isEmpty = i > self.starLv + 1 and i ~= starLv,
        isYellow = i == self.starLv + 1,
        isPreview = i == starLv and not isMax,
        isBlue = i <= self.starLv,
        animRefreshStar = animRefreshStar
      }
      table.insert(tmp_tbl, tab)
    end
    self.bind.list_star:clear()
    self.bind.list_star:insert_array(tmp_tbl)
    self.initStar = false
    animRefreshStar = true
  end
  
  if self.initStar then
    if not self.isJump then
      InitStarList()
    else
      self:stopTimer("RefreshStar")
      self:newOrResetTimer("RefreshStar", function()
        InitStarList()
      end, 0.23)
      self.bindComponents.starListAnim:Stop()
      self.bindComponents.starListAnim:Play("anim_starPreviewNode_Last")
    end
  end
  if isCurLv and not isMax then
    if self.isJump then
      self.bindComponents.animator:SetTrigger("Normal_FadeIn")
    else
      self.bindComponents.animator:SetTrigger("Normal")
    end
    self.isJump = false
    self.lastNormal = true
  end
  if isMax then
    if self.lastNormal then
      self.bindComponents.animator:SetTrigger("LevelMax")
      self.lastNormal = false
    else
      self.bindComponents.animator:SetTrigger("Max")
    end
    self.bind.go_jumpCurLv = false
    self.bind.go_lvNotMax = false
  end
  if not isCurLv and not isMax then
    if self.lastNormal and self.normal then
      self.bindComponents.animator:SetTrigger("PhaseMax")
    else
      self.bindComponents.animator:SetTrigger("Phase")
    end
    self.lastNormal = false
  end
end

function this:refreshCostList()
  if self.isMax then
    return
  end
  
  local function func()
    self:InitBagList()
    self.onAddItemFunc()
    L_UI:open("PageAccessoryStarUpMaterialBag", {
      guid = self.guid,
      limitNum = self.limitCostNum,
      conditionType = self.filterConditionType,
      costList = self.selectDatas,
      bagList = self.bagDataList,
      isFliterLock = true,
      isInherit = false,
      onClickHandle = function(guid)
        if #self.selectDatas >= self.limitCostNum then
          return
        end
        self:onClickHandle(guid)
      end,
      onRemoveHandle = function(guid)
        self:onRemoveHandle(guid)
      end,
      onClosePage = function()
        self:InitBagList()
        self.onClosePage()
      end
    })
  end
  
  local data = {}
  for i = 1, costNum do
    if i <= #self.selectDatas then
      local serverData = C_AccessoryMgr:getAccessory(self.selectDatas[i])
      table.insert(data, {
        itemType = L_Const.resType.accessory,
        itemId = serverData.accessoryId,
        guid = serverData.guid,
        selectMode = false,
        mutiSelect = true,
        addBtnActive = false,
        activeYellowReduce = true,
        onYellowReduce = function(guid)
          self:onRemoveHandle(guid)
        end
      })
    else
      table.insert(data, {
        isBasicItem = not self.isMax,
        addBtnActive = true,
        bgActive = false,
        callback = func,
        onAddClick = func
      })
    end
  end
  if #self.bind.costList == #data then
    for i = 1, #self.bind.costList do
      self.bind.costList:change(i, data[i])
    end
  else
    self.bind.costList:clear()
    self.bind.costList:insert_array(data)
  end
  self:RefreshContentUI(self.limitCostNum)
end

function this:onClickHandle(guid)
  table.insert(self.selectDatas, guid)
  self:refreshCostList()
end

function this:onRemoveHandle(guid)
  for i = 1, #self.selectDatas do
    if self.selectDatas[i] == guid then
      table.remove(self.selectDatas, i)
      self:refreshCostList()
      break
    end
  end
end

function this:refreshOptionList()
  local optionData = {}
  local conditionType = 0
  for k, condition in ipairs(limitConditions) do
    conditionType = conditionType + 1
    local isCurrent = self.filterConditionType == conditionType
    table.insert(optionData, {
      conditionType = conditionType,
      txt_onName = condition,
      txt_offName = condition,
      go_onActive = isCurrent,
      go_offActive = not isCurrent
    })
    if isCurrent then
      self.bind.txt_currentFilter = condition
    end
  end
  self.bind.list_option:clear()
  self.bind.list_option:insert_array(optionData)
end

function this:RefreshArrowStat(active)
  local strColor = active and "#E4B248" or "#4F525D"
  local colorValue = C_LuaUtility.ParseHtmlStringColor(strColor)
  if self.bind.go_filterContentActive ~= active then
    C_AudioManager.Play(active and "Play_SFX_System_UI_General_Drop_Open" or "Play_SFX_System_UI_General_Drop_Close")
  end
  self.bind.go_filterContentActive = active
  self.bind.go_arrowActive = active
  self.bind.color_filterName = colorValue
  self.bind.color_filterIcon = colorValue
  self.bind.go_arrowNormal = not active
end

return this
