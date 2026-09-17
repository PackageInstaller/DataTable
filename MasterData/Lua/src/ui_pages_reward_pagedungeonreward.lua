local this = class("pageDungeonReward", G_UIPageBase)
local _staminaChestTpl = L_GameTpl:getStaminaChestDropTpl()
local STAMINA_RESOURCE_BAR_ITEM_TPL_ID = 400
local WEEKLY_RESOURCE_BAR_ITEM_TPL_ID = 104
local ShowType = {
  NormalDungeon = 1,
  WorldBoss = 2,
  MaterialDungeon = 3,
  WeeklyBoss = 4
}

function this.bind()
  return {
    go_up_left = false,
    txt_leftTimes = nil,
    go_leftTimes = false,
    title_txt = "",
    list_icon = L_Const.ModuleInfo.CellIconBag,
    go_up_btn = false,
    txt_upLeftTimes = nil,
    module_currency = L_Const.ModuleInfo.Currency,
    go_dropClickMask = false,
    detailedInfoList1 = {
      moduleName = "pages/reward/rewardTimesItemOption"
    },
    moduleDoubleRewardCenter = {
      moduleName = "pages/gameAct/doubleDrop/moduleDoubleRewardTipItem"
    },
    moduleDoubleRewardTop = {
      moduleName = "pages/gameAct/doubleDrop/moduleDoubleRewardTipItem"
    },
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    go_weeklyCountLimit = false,
    go_rewardTimeOpen = true,
    go_rewardTimeLine = true
  }
end

function this.methods()
  return {
    detailedInfoList1 = {
      onChange = function(self, val)
        self:changeSetting(val)
        self.bind.go_dropClickMask = false
        self:onDropdownClosed("select")
      end,
      changeDropdown = function(self, callback)
        function self.dropMaskCallback()
          callback()
          
          self:onDropdownClosed("mask")
        end
        
        self.bind.go_dropClickMask = true
      end
    },
    onClick_changeDropdown = function(self)
      self.bind.go_dropClickMask = false
      if self.dropMaskCallback then
        self.dropMaskCallback()
      end
    end,
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        self:cancelReward()
      end,
      onClick_confirm = function(self)
        self:checkGetReward()
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:check(options, callback)
  local tpl = _staminaChestTpl:getTplById(options.staminaChestId)
  local lastTime = _staminaChestTpl:getTime(tpl)
  local serverData = AzurWorld.StaminaChestMgr:GetStaminaChestData(options.staminaChestId)
  local totalPauseTime = serverData.totalPauseTime
  local filter = _staminaChestTpl:getWorldFilter(tpl)[1]
  if AzurWorldInstance.IsMulitPlayerOnlineMode or filter == L_Const.StaminaBoxSystemType.SBST_WORLD_ENEMY then
    totalPauseTime = 0
  end
  if L_TimeUtil.getServerTime() >= serverData.finishTime + totalPauseTime + lastTime then
    L_FlyMsgManager:showNormalMsgByKey("ui_pageStaminaReward_02")
    callback(false)
    return
  end
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.pauseTimeStart = L_TimeUtil.getServerTime()
  self._staminaChestId = options.staminaChestId
  self.openFromType = options.openFromType
  self._callback = options.callback
  self.rewardTimes = self:getLastSaveRate()
  self.staminaReward = {}
  table.insert(self.staminaReward, 1)
  local rewardTql = L_GameTpl:getGameConstTpl():getEntrustStaminaReward()
  for i = 1, #rewardTql do
    table.insert(self.staminaReward, rewardTql[i])
  end
  self:refreshView()
  self.modules.detailedInfoList1:refresh_dropMenu(self.staminaReward, self:getLastSaveRate())
  local params = {}
  if self.openFromType == ShowType.NormalDungeon or self.openFromType == ShowType.MaterialDungeon or self.openFromType == ShowType.WeeklyBoss then
    params.txtTitle = L_WordsTpl:getValue("ui_stamina_chest_01")
    params.txtCancel = L_WordsTpl:getValue("dungeon_entrust_stamina_no_get")
    params.txtConfirm = L_WordsTpl:getValue("dungeon_entrust_stamina_get")
  elseif self.openFromType == ShowType.WorldBoss then
    params.txtTitle = L_WordsTpl:getValue("ui_stamina_chest_01")
    params.txtCancel = L_WordsTpl:getValue("ui_stamina_chest_03")
    params.txtConfirm = L_WordsTpl:getValue("ui_stamina_chest_02")
  else
    params.txtTitle = L_WordsTpl:getValue("ui_stamina_chest_01")
    params.txtCancel = L_WordsTpl:getValue("ui_stamina_chest_03")
    params.txtConfirm = L_WordsTpl:getValue("dungeon_entrust_stamina_get")
  end
  self.modules.moduleCommonTipMedium:initModule(params)
  if self.openFromType == ShowType.NormalDungeon then
    local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
    local tpl = _dungeonEntrustTpl:getTplByDungeonId(AzurWorld.DungeonMgr.DungeonID)
    if tpl then
      local groupId = _dungeonEntrustTpl:getGroupId(tpl)
      self.modules.moduleDoubleRewardTop:SetHideByDroptype(groupId)
      self.modules.moduleDoubleRewardCenter:SetHideByDroptype(groupId)
    end
  elseif self.openFromType == ShowType.MaterialDungeon then
    local dungeonMaterialTpl = L_GameTpl:getDungeonMaterialTpl()
    local tpl = dungeonMaterialTpl:getTplById(AzurWorld.DungeonEntrustManager.store:GetCurChallengeId())
    if tpl then
      local typeId = dungeonMaterialTpl:getTypeId(tpl)
      self.modules.moduleDoubleRewardTop:SetHideByMaterialType(typeId)
      self.modules.moduleDoubleRewardCenter:SetHideByMaterialType(typeId)
    end
  else
    self.modules.moduleDoubleRewardTop:SetHideByCustom()
    self.modules.moduleDoubleRewardCenter:SetHideByCustom()
  end
  if not self.moduleCountLimit then
    local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
    local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleWeeklyBossCountLimit, CS.UnityEngine.GameObject)
    self.moduleCountLimit = addModule(self.csharpPage, self.csharpPage, self.bindComponents.moduleCountLimit.gameObject)
  end
end

local LastSaveRate = "pageDungeonReward_LastSaveRate"

function this:getLastSaveRate()
  local tpl_chest = _staminaChestTpl:getTplById(self._staminaChestId)
  local needCostList = L_DataUtil.parseRewardConfig(_staminaChestTpl:getNeed(tpl_chest))
  if needCostList then
    return 1
  end
  local rate = C_PlayerPrefsUtility.GetInt(L_PlayerStore:getPlayerId() .. LastSaveRate, 0)
  if 0 < rate then
    return rate
  end
  return 1
end

function this:saveLastSaveRate(rate)
  C_PlayerPrefsUtility.SetInt(L_PlayerStore:getPlayerId() .. LastSaveRate, rate)
end

function this:initWeeklyCurrencyList()
  self.modules.module_currency:refreshResByResBarTplIdList({STAMINA_RESOURCE_BAR_ITEM_TPL_ID})
end

function this:initMultidungeonCurrencyList()
  self.modules.module_currency:refreshResByResBarTplIdList({
    L_Const.currencyType.specialCrystalKeyStone,
    L_Const.currencyType.crystalKeyStone
  })
end

function this:initStaminaCurrencyList()
  self.modules.module_currency:refreshResByResBarTplIdList({STAMINA_RESOURCE_BAR_ITEM_TPL_ID})
end

function this:initStaminaCurrency()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.mainMenu)
  self.modules.module_currency:refreshRes(tpl_sys)
end

function this:refreshView()
  local tpl_chest = _staminaChestTpl:getTplById(self._staminaChestId)
  local leftRewardTime, isUp = L_StaminaChestManager:getStaminaRewardTimes(self._staminaChestId)
  self.bind.go_up_btn = isUp
  self.bind.go_up_left = isUp
  if isUp then
    self.bind.txt_upLeftTimes = L_WordsTpl:getValue("ui_pageStaminaReward_01", {
      [0] = leftRewardTime
    })
    self.bind.go_leftTimes = true
    self.bind.txt_leftTimes = tostring(leftRewardTime)
  else
    local refreshType, canRewardTimes = table.unpack(_staminaChestTpl:getRewardChance(tpl_chest))
    local isInfinite = refreshType == L_Const.StaminaBoxCountType.SBCT_INFINITE
    self.bind.go_leftTimes = not isInfinite
    if not isInfinite then
      self.bind.txt_leftTimes = tostring(leftRewardTime)
    end
  end
  local rewardlist = isUp and _staminaChestTpl:getRewardDisplayUp(tpl_chest) or _staminaChestTpl:getRewardDisplay(tpl_chest)
  local rewardTimesItems = {}
  for i = 1, #rewardlist do
    local temp = {}
    temp[1] = rewardlist[i][1]
    temp[2] = rewardlist[i][2]
    if rewardlist[i][3] == -1 then
      temp[3] = rewardlist[i][3]
      if rewardlist[i][4] then
        temp[4] = rewardlist[i][4]
      end
    else
      temp[3] = rewardlist[i][3] * self.rewardTimes
      if rewardlist[i][4] then
        temp[4] = rewardlist[i][4] * self.rewardTimes
      end
    end
    table.insert(rewardTimesItems, temp)
  end
  local actualReward = L_DataUtil.parseRangeRewardConfig(rewardTimesItems)
  for _, v in pairs(actualReward) do
    local itemConf = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
    v.quality = itemConf.quality
  end
  self.bind.list_icon:clear()
  self.bind.list_icon:insert_array(actualReward)
  self.modules.moduleDoubleRewardCenter:setCount(self.rewardTimes)
  local currencyConfigData = L_ItemTplManager:getCurrencyItem(L_Const.currencyType.stamina)
  local needCostList = L_DataUtil.parseRewardConfig(_staminaChestTpl:getNeed(tpl_chest))
  local needCost = needCostList[1]
  self.bind.go_weeklyCountLimit = self:needWeeklyCount(needCostList)
  self.bind.go_rewardTimeOpen = not self.bind.go_weeklyCountLimit
  self.bind.go_rewardTimeLine = self.bind.go_rewardTimeOpen
  if self.bind.go_weeklyCountLimit then
    self.rewardTimes = 1
    self:initWeeklyCurrencyList()
  elseif needCost.itemId == L_Const.currencyType.crystalKeyStone or needCost.itemId == L_Const.currencyType.specialCrystalKeyStone then
    self:initMultidungeonCurrencyList()
    currencyConfigData = L_ItemTplManager:getCurrencyItem(needCost.itemId)
  else
    self:initStaminaCurrencyList()
  end
  self.bind.title_txt = string.format(L_WordsTpl:getValue("ui_pageStaminaReward_03", {
    [0] = "<p=%s w=25 h=25/><color=#3266b4>%s</color>"
  }), currencyConfigData.icon, needCost.itemNum * self.rewardTimes)
end

function this:checkGetReward()
  L_MultiDungeonStore:checkDungeonGetReward(self._staminaChestId, self.rewardTimes, self.pauseTimeStart, self.pageName)
end

function this:cancelReward()
  L_UI:close(self.pageName)
  if self.openFromType == ShowType.NormalDungeon then
    local list = C_VarList:Get()
    C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnDungeonEntrustChestAcquire, list)
  elseif self.openFromType == ShowType.MaterialDungeon or self.openFromType == ShowType.WeeklyBoss then
    C_WorldEvent.instance:Dispatch(C_EWorldEvent.OnDungeonEntrustChestSettle)
    L_MultiDungeonStore:req_CSProtoStaminaBoxGiveUp(self._staminaChestId)
  end
end

function this:changeSetting(index)
  self.bind.list_icon:clear()
  self.rewardTimes = self.staminaReward[index]
  self:refreshView()
  self:saveLastSaveRate(self.rewardTimes)
end

function this:needWeeklyCount(needCostList)
  for _, v in ipairs(needCostList) do
    if v.itemId == L_Const.currencyType.weeklyDungeonCount and v.itemType == L_Const.resType.currency then
      return true
    end
  end
  return false
end

function this:escHandle()
  if self.blockClose then
    self.blockClose = nil
    if C_InputManager.IsEnableGamePad then
      return
    end
  end
  L_UI:close(self.pageName)
end

function this:onDropdownClosed(reason)
  local state = CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance.CurrentState
  if state and self.pageName == state.pageName and state.areaName == "RewardMultiplier" then
    local ok, err = pcall(function()
      CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:Pop()
    end)
    if ok then
      self.blockClose = true
    else
      C_MJLog.LogError("pageDungeonReward:onDropdownClosed Invoke UIPageAreaStateMachine.Pop failed with error: " .. tostring(err))
    end
  end
end

return this
