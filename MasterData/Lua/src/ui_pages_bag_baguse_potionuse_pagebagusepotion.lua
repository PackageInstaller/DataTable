local this = class("pageBagUsePotion", G_UIPageBase)
local C_ItemCdStore = AzurWorld.ItemCdMgr:GetItemCdStore()
local L_GameTpl = _ENV.L_GameTpl
local medicineTpl = L_GameTpl:getMedicineTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local formationManager = L_FormationManager

function this.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    module_selectNum = L_Const.ModuleInfo.SelectNum,
    numActive = false,
    go_heroList = true,
    scrollList_hero = {
      moduleName = "pages/Bag/BagUse/potionUse/cellPotionHero"
    },
    txt_potionDesc = "",
    txt_useTarget = "",
    txt_cooldown = "",
    active_cooldown = false
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self:onClick_confirm()
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    },
    scrollList_hero = {
      onClick_selectHero = function(self, id, index)
        self:onClick_selectHero(id, index)
      end,
      onClick_charge = function(self)
        self.data.uiState.selectHeroId = 0
        self:setHeroListActive()
        self.modules.module_selectNum:changeNum(1)
      end
    }
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:check(options, callback)
  local isInHome = C_HomeUtil.IsInHome()
  local ableToUse = not isInHome
  if not ableToUse then
    local msg = wordsTpl:getValue("notice_medicine_forbid")
    L_FlyMsgManager:showNormalMsg(msg)
  end
  callback(ableToUse)
end

function this:preOpen(options)
  self.super.preOpen(self, options)
  self:resetState()
  self:fetchData(options)
  self:initializeView()
  self.updateTimer = Timer.repeated(0.02, handler(self, self.update))
end

function this:close()
  self.super.close(self)
  if self.updateTimer then
    Timer.remove(self.updateTimer)
    self.updateTimer = nil
  end
end

function this:resetState()
  self.data = {
    itemInfo = {
      id = nil,
      useType = nil,
      targetType = nil,
      cdGroup = nil,
      des = ""
    },
    uiState = {quantity = 1, selectedHeroId = nil},
    contextInfo = {
      heroGuidList = {},
      heroCellList = {},
      cellOnSelection = {},
      currentSceneType = nil,
      heroName = nil
    }
  }
  self.updateTimer = nil
end

function this:fetchData(options)
  local itemId = options.itemId
  self.data.itemInfo.id = itemId
  local potionTpl = medicineTpl:getTplById(itemId)
  if not potionTpl then
    return
  end
  self.data.itemInfo.des = medicineTpl:getDesc(potionTpl)
  self.data.itemInfo.targetType = medicineTpl:getTargetType(potionTpl)
  self.data.itemInfo.useType = medicineTpl:getMedicineType(potionTpl)
  self.data.itemInfo.cdGroup = medicineTpl:getBuffType(potionTpl)
  self.data.curFormationType = formationManager:getCurFormationType()
  local posData = L_FormationStore:getFormationPosData(self.data.curFormationType)
  for _, heroGuid in ipairs(posData) do
    if heroGuid and heroGuid ~= 0 then
      table.insert(self.data.contextInfo.heroGuidList, heroGuid)
    end
  end
  if 0 < #self.data.contextInfo.heroGuidList then
    self.data.uiState.selectedHeroId = self.data.contextInfo.heroGuidList[1]
    local hero = L_HeroStore:getHero(self.data.uiState.selectedHeroId)
    local heroCfgId = L_HeroStore:getHeroConfigId(hero)
    local heroTpl = L_GameTpl:getHeroTpl()
    self.data.contextInfo.heroName = heroTpl:getName(heroTpl:getTplById(heroCfgId))
  end
  local sceneId = AzurWorldInstance.CurWorldId
  if sceneId then
    local cityTpl = L_GameTpl:getWorldCityTpl()
    local tpl = cityTpl:getTplById(sceneId)
    self.data.contextInfo.currentSceneType = cityTpl:getType(tpl)
  end
end

function this:initializeView()
  self:initCommonTipModule()
  self:initHeroListView()
  self:initQuantitySelector()
  self:initTextView()
  self:updateCooldownView()
end

function this:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  local param = {}
  local tpl_commonItem = commonItemTpl:getTplById(self.data.itemInfo.id)
  param.txtTitle = commonItemTpl:getName(tpl_commonItem)
  moduleTip:initModule(param)
end

function this:initHeroListView()
  local temp_list = {}
  self.bind.scrollList_hero:clear()
  for _, heroGuid in ipairs(self.data.contextInfo.heroGuidList) do
    table.insert(temp_list, {heroId = heroGuid})
  end
  self.bind.scrollList_hero:insert_array(temp_list)
  self.data.contextInfo.heroCellList = {}
  for i = 1, #self.bind.scrollList_hero do
    local cell = self.bind.scrollList_hero:getItemCls(i)
    table.insert(self.data.contextInfo.heroCellList, i, cell)
    cell:setIndex(i)
  end
  self.data.contextInfo.cellOnSelection = {}
  if self.data.itemInfo.targetType == L_Const.MedicineTargeType.all then
    self.data.contextInfo.cellOnSelection = self.data.contextInfo.heroCellList
  elseif self.data.contextInfo.heroCellList[1] then
    table.insert(self.data.contextInfo.cellOnSelection, self.data.contextInfo.heroCellList[1])
  end
  for _, v in pairs(self.data.contextInfo.cellOnSelection) do
    v:setSelection(true)
  end
end

function this:initQuantitySelector()
  local function max()
    return 1
  end
  
  local function func(num)
    self.data.uiState.quantity = num
  end
  
  self.modules.module_selectNum:initModule(func, max)
  self.modules.module_selectNum:changeNum(1)
  self.bind.numActive = false
end

function this:initTextView()
  self.bind.txt_potionDesc = self.data.itemInfo.des
  self:refreshUseTargetText()
end

function this:refreshUseTargetText()
end

function this:updateCooldownView()
  local cdGroup = self.data.itemInfo.cdGroup
  if not cdGroup then
    self.bind.active_cooldown = false
    return
  end
  local remainingTimeFloat = C_ItemCdStore:GetCurrentMedicineCDByType(cdGroup)
  if 0 < remainingTimeFloat then
    local cdText = self:formatTime(remainingTimeFloat)
    self.bind.txt_cooldown = wordsTpl:getValue("notice_medicine_cooldown_time") .. cdText
    self.bind.active_cooldown = true
  else
    self.bind.active_cooldown = false
  end
end

function this:onClick_confirm()
  local function showTipFunc(msg)
    L_FlyMsgManager:showNormalMsg(msg)
  end
  
  local canUse, reason = self:checkAllConditions(showTipFunc)
  if canUse then
    self:executeUsePotion()
  end
end

function this:onClick_selectHero(heroId, index)
  if self.data.uiState.selectedHeroId == heroId or self.data.itemInfo.targetType == L_Const.MedicineTargeType.all then
    return
  end
  self.data.uiState.selectedHeroId = heroId
  self.modules.module_selectNum:changeNum(1)
  L_AudioUtil.playSound("Play_SFX_System_UI_Bag_Food_CHAR_Click")
  for _, cell in ipairs(self.data.contextInfo.heroCellList) do
    local isSelected = cell.bind.heroId == self.data.uiState.selectedHeroId
    cell:setSelection(isSelected)
    if isSelected then
      self.data.contextInfo.cellOnSelection = {cell}
    end
  end
  local hero = L_HeroStore:getHero(heroId)
  local heroCfgId = L_HeroStore:getHeroConfigId(hero)
  local heroTpl = L_GameTpl:getHeroTpl()
  self.data.contextInfo.heroName = heroTpl:getName(heroTpl:getTplById(heroCfgId))
  self:refreshUseTargetText()
end

function this:checkAllConditions(showTipFunc)
  if self.data.contextInfo.currentSceneType ~= 1 and self.data.contextInfo.currentSceneType ~= 2 then
    showTipFunc(wordsTpl:getValue("notice_medicine_forbid"))
    return false, "scene"
  end
  local cdGroup = self.data.itemInfo.cdGroup
  if C_ItemCdStore:GetCurrentMedicineCDByType(cdGroup) > 0 then
    showTipFunc(wordsTpl:getValue("notice_medicine_cooldown"))
    return false, "cooldown"
  end
  if self.data.itemInfo.targetType == L_Const.MedicineTargeType.all then
    local useType = self.data.itemInfo.useType
    local heroList = self.data.contextInfo.heroGuidList
    if useType == L_Const.MedicineType.Relive then
      local hasDeadHero = false
      for _, heroGuid in ipairs(heroList) do
        if not self:checkIsAlive(heroGuid) then
          hasDeadHero = true
          break
        end
      end
      if not hasDeadHero then
        showTipFunc(wordsTpl:getValue("notice_medicine_survival"))
        return false, "all_target_alive"
      end
    elseif useType == L_Const.MedicineType.Resistance or useType == L_Const.MedicineType.Damage then
      local hasAliveHero = false
      for _, heroGuid in ipairs(heroList) do
        if self:checkIsAlive(heroGuid) then
          hasAliveHero = true
          break
        end
      end
      if not hasAliveHero then
        showTipFunc(wordsTpl:getValue("notice_medicine_Resurrection"))
        return false, "all_target_dead"
      end
    end
  else
    local useType = self.data.itemInfo.useType
    local targetId = self.data.uiState.selectedHeroId
    if not targetId then
      return false, "no_target"
    end
    local hp = L_FormationStore:getFormationHeroHp(targetId)
    if useType == L_Const.MedicineType.Relive and not self:checkIsAlive(targetId) then
      showTipFunc(string.format(wordsTpl:getValue("notice_medicine_survival")))
      return false, "target_alive"
    end
    if (useType == L_Const.MedicineType.Resistance or useType == L_Const.MedicineType.Damage) and self:checkIsAlive(targetId) then
      showTipFunc(wordsTpl:getValue("notice_medicine_Resurrection"))
      return false, "target_dead"
    end
  end
  return true, "ok"
end

function this:checkIsAlive(heroId)
  if math.isEmpty(heroId) then
    return false
  end
  local hero = L_PlayerManager:getAllHeroCsEntity()[heroId]
  if not hero and L_BattleStore:getIsInBattle() then
    return false
  end
  local csEntity = hero
  if not csEntity then
    return false
  end
  local aliveProperty = csEntity.data.aliveProperty
  local hp = aliveProperty.luaHp
  if hp <= 0 then
    return true
  end
end

function this:executeUsePotion()
  local args = {}
  if self.data.uiState.selectedHeroId then
    args = {
      self.data.uiState.selectedHeroId
    }
  end
  C_BagMgr:ReqUseItem(self.data.itemInfo.id, self.data.uiState.quantity, args, function(response)
    L_UI:close(self.pageName)
  end)
end

function this:update(dt)
  self:updateCooldownView()
end

function this:formatTime(total_seconds)
  total_seconds = math.floor(total_seconds)
  if total_seconds < 0 then
    total_seconds = 0
  end
  local hours = math.floor(total_seconds / 3600)
  local minutes = math.floor(total_seconds % 3600 / 60)
  local seconds = total_seconds % 60
  if 0 < hours then
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
  else
    return string.format("%02d:%02d", minutes, seconds)
  end
end

return this
