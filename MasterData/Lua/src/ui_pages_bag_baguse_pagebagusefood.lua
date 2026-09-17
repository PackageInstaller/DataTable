local this = class("pageBagUseFood", G_UIPageBase)
local foodTpl = L_GameTpl:getFoodTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    curItemId = nil,
    curNum = 1,
    curFormationType = nil,
    useCondition = {hpOverFlow = false},
    curFoodType = nil,
    curFood = nil,
    isHeroTab = true
  }
end

function this.bind()
  return {
    scrollList_hero = {
      moduleName = "modulePages/cellIconUnit"
    },
    module_selectNum = L_Const.ModuleInfo.SelectNum,
    desc = "",
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    scrollList_pet = {
      moduleName = "pages/mount/cellMountFeed"
    },
    btn_hidePetTab = false,
    go_animation = true,
    txt_RemainingNum = "",
    scrollList_buff = {
      moduleName = "pages/battle/cellBuffElement"
    },
    go_heroBuff = false,
    active_selectNumProgress = false,
    active_remainingNum = false
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
        if self.data.isHeroTab then
          self:checkHasFoodBuff(function()
            C_BagMgr:ReqUseItem(self.data.curItemId, self.data.curNum, {
              L_Const.UseFoodTarget.UFT_HERO,
              0
            }, function()
              L_FlyMsgManager:showNormalMsg(wordsTpl:getValue("notice_bag_useSuccess"))
              L_UI:close(self.pageName)
            end)
          end)
        else
          if not self:chargeOverMount() then
            return
          end
          C_BagMgr:ReqUseItem(self._foodId, self.data.curNum, {
            L_Const.UseFoodTarget.UFT_PET,
            self._selectMountId
          }, function()
            L_FlyMsgManager:showNormalMsg(wordsTpl:getValue("notice_bag_useSuccess"))
            if math.isEmpty(C_BagMgr:getItemNumByItemId(self._foodId)) then
              L_UI:close(self.pageName)
              return
            end
            self.data.curNum = 1
            self:refreshSelectMountAfterUse()
            self:initSelectNumModule()
            self:updateNum()
            for i, v in pairs(self.modules.scrollList_pet) do
              local cell = v
              if cell.bind.guid == self._selectMountId then
                cell:playFx()
              end
            end
          end)
        end
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    },
    onToggleHero = function(self, isOn)
      self.data.isHeroTab = isOn
      self.data.curNum = 1
      self:refreshUI()
    end,
    onClick_hidemask = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cookingHungry_07"))
    end,
    scrollList_pet = {
      onClick_select = function(self, bind)
        if self._selectMountId == bind.guid then
          return
        end
        self._selectMountId = bind.guid
        self.data.curNum = 1
        self:setMountListActive()
        self:initSelectNumModule()
        L_AudioUtil.playSound("Play_SFX_System_UI_Bag_Food_QIBO_Click")
      end
    },
    module_selectNum = {
      onClick_add = function(self)
        self:selectNumRefresh()
      end,
      onClick_decrease = function(self)
        self:selectNumRefresh()
      end,
      onClick_max = function(self)
        self.modules.module_selectNum:changeNum(self:getMaxItemNum())
        self:selectNumRefresh()
      end,
      onClick_min = function(self)
        self:selectNumRefresh()
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.data.curItemId = options.itemId
  self.data.curNum = 1
  self.data.curFormationType = L_FormationManager:getCurFormationType()
  local food = foodTpl:getTplById(options.itemId)
  self.data.curFoodType = food.foodType
  self.data.curFood = food
  self:updateNum()
  self.bind.btn_hidePetTab = self:checkMountList()
  self:refreshUI()
end

function this:updateNum()
  local num = 0
  if self.data.curFoodType == L_BagConst.bagTag.taskProp then
    num = tostring(AzurWorld.TaskMgr:GetTaskUIModule():GetTaskPropNum(self.data.curItemId))
  else
    num = tostring(C_BagMgr:getItemNumByItemId(self.data.curItemId))
  end
  self.bind.txt_RemainingNum = string.format(L_WordsTpl:getValue("residual_code_pagebagusefood_01") .. num)
end

function this:selectNumRefresh()
  if self.data.isHeroTab then
    self:refreshNum()
  else
    self:setMountListActive()
  end
end

function this:refreshUI()
  local navMgr = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UINavigationBinding))
  if navMgr then
    if self.data.isHeroTab then
      navMgr:DisableAllArea()
    else
      navMgr:SelectArea("AreaPetList")
    end
  end
  local food = self.data.curFood
  self._foodId = foodTpl:getId(food)
  if self.data.isHeroTab then
    self.bind.scrollList_pet:clear()
    local heroSatiety = foodTpl:getCharge(food)
    local tpl_commonItem = _commonItemTpl:getTplById(self.data.curItemId)
    self.bind.desc = _commonItemTpl:getDesc(tpl_commonItem)
    if food.foodType == L_Const.foodType.heal then
      self:initHeroList(food)
    elseif food.foodType == L_Const.foodType.reborn then
      self:initHeroList(food)
    elseif food.foodType == L_Const.foodType.defence or food.foodType == L_Const.foodType.attack then
      self:initHeroList(food)
    elseif food.foodType == L_Const.foodType.adventure then
    end
    self.bind.active_selectNumProgress = false
    self.bind.active_remainingNum = false
  else
    self._selectMountId = nil
    self.bind.scrollList_hero:clear()
    self.bind.go_heroBuff = false
    local satiety = foodTpl:getSatietyScore(food)
    self.bind.desc = string.concat(L_WordsTpl:getValue("ui_pet_food_desc"), satiety)
    self._satietyOnce = satiety
    self:initMountList()
    self.bind.active_selectNumProgress = true
    self.bind.active_remainingNum = true
  end
  self:initSelectNumModule()
  self:initCommonTipModule()
end

function this:playAnim()
  local animation = self.bind.go_animation:GetComponent(typeof(C_Animation))
  animation:Play("anim_uiefood_change")
end

function this:checkHasFoodBuff(cb)
  local tpl = foodTpl:getTplById(self.data.curItemId)
  local buff = L_BuffStore:getBuffData(foodTpl:getBuffId(tpl))
  if buff then
    local data = {
      txtContent = "已食用该料理，是否再次食用",
      confirmCallback = function()
        cb()
      end
    }
    L_GameUtil.showCommonTip(data)
  else
    cb()
  end
end

function this:initSelectNumModule()
  local function max()
    local maxNum = C_BagMgr:getItemNumByItemId(self.data.curItemId)
    
    if self.data.isHeroTab then
      if self.data.curFoodType == L_Const.foodType.heal and maxNum > self:getMaxItemNum() then
        maxNum = self:getMaxItemNum()
      end
    elseif maxNum > self:getMaxItemNum() then
      maxNum = self:getMaxItemNum()
    end
    return maxNum
  end
  
  local function func(num)
    self.data.curNum = num
    self:refreshNum()
  end
  
  self.modules.module_selectNum:initModule(func, max)
  func(self.data.curNum)
end

function this:initHeroList(food)
  local temp_list = {}
  local posData = L_FormationStore:getFormationPosData(self.data.curFormationType)
  for i, heroGuid in pairs(posData) do
    if heroGuid ~= 0 then
      local hero = L_HeroStore:getHero(heroGuid)
      local heroItem = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(hero))
      local cell = {
        itemType = L_Const.resType.hero,
        guid = L_HeroStore:getHeroGuid(hero),
        star = L_HeroStore:getHeroStar(hero),
        lv = L_HeroStore:getHeroLevel(hero),
        quality = heroItem.quality,
        hideElement = true
      }
      table.insert(temp_list, cell)
    end
  end
  self.bind.go_heroBuff = false
  if not self.initHeroLst then
    self.bind.scrollList_hero:clear()
    self.bind.scrollList_hero:insert_array(temp_list)
    self.initHeroLst = true
  else
    self.bind.scrollList_hero:freshAll(temp_list)
  end
end

function this:checkBuffIsShow(element)
  local config = element and element.config
  if config then
    local buffTpl = _buffInfoTpl:getTplById(config.elementConfigId)
    if buffTpl then
      for i, v in pairs(L_Const.elementType) do
        if v == config.elementType then
          return true
        end
      end
    end
  end
  return false
end

function this:refreshNum()
  if self.data.curFoodType == L_Const.foodType.heal then
    self:refreshNum_hp()
  elseif self.data.curFoodType == L_Const.foodType.reborn then
    self:refreshNum_reborn()
  elseif self.data.curFoodType == L_Const.foodType.defence or self.data.curFoodType == L_Const.foodType.attack then
    self:refreshNum_hp()
  elseif self.data.curFoodType == L_Const.foodType.adventure then
    self:refreshNum_adventure()
  end
  self:updateNum()
end

function this:refreshNum_hp()
  for i = 1, #self.bind.scrollList_hero do
    self.bind.scrollList_hero:change(i, {})
  end
end

function this:refreshNum_reborn()
end

function this:refreshNum_adventure()
end

function this:chargeOverMount()
  local curSatiety = L_SatietyStore:getPetSatiety(self._selectMountId)
  local maxSatiety = L_SatietyStore:getPetMaxSatiety(self._selectMountId)
  local needSatiety = maxSatiety - curSatiety
  if math.isEmpty(needSatiety) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cookingHungry_06"))
    return false
  end
  if self._satietyOnce ~= 0 then
    local addNum = curSatiety + self.data.curNum * self._satietyOnce
    if maxSatiety < addNum then
      local exceedCharge = addNum - maxSatiety
      if exceedCharge >= self._satietyOnce then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cookingHungry_06"))
        return false
      end
    end
  end
  return true
end

function this:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  local param = {}
  param.txtConfirm = L_WordsTpl:getValue("residual_code_pagebagusefood_02")
  local tpl_commonItem = _commonItemTpl:getTplById(self.data.curItemId)
  param.txtTitle = _commonItemTpl:getName(tpl_commonItem)
  moduleTip:initModule(param)
end

function this:checkMountList()
  local mountMap = L_MountStore:getMountMap()
  local posData = L_FormationStore:getFormationPosData(self.data.curFormationType)
  local isHasPet = false
  for i, heroGuid in pairs(posData) do
    local v = L_FormationStore:getFormationPosPetGuid(self.data.curFormationType, L_FormationStore:getUsingTeamIndex(self.data.curFormationType), i)
    if v and 0 < v then
      isHasPet = true
    end
  end
  if table.isEmpty(mountMap) and not isHasPet then
    return true
  end
  return false
end

function this:initMountList()
  self._mountList = {}
  local data = L_MountStore:getMountMap()
  for i, v in pairs(data) do
    table.insert(self._mountList, {
      guid = v,
      isInBattle = false,
      curSatiety = L_SatietyStore:getPetSatiety(v)
    })
  end
  local posData = L_FormationStore:getFormationPosData(self.data.curFormationType)
  for i, heroGuid in pairs(posData) do
    local v = L_FormationStore:getFormationPosPetGuid(self.data.curFormationType, L_FormationStore:getUsingTeamIndex(self.data.curFormationType), i)
    if v and 0 < v then
      table.insert(self._mountList, {
        guid = v,
        isInBattle = true,
        curSatiety = L_SatietyStore:getPetSatiety(v)
      })
    end
  end
  table.sort(self._mountList, function(a, b)
    if a.curSatiety ~= b.curSatiety then
      return a.curSatiety < b.curSatiety
    elseif a.isInBattle and not b.isInBattle then
      return true
    elseif not a.isInBattle and b.isInBattle then
      return false
    else
      return false
    end
  end)
  local tmpId = self._mountList[1] and self._mountList[1].guid or nil
  self._selectMountId = self._selectMountId or tmpId
  if self._initList then
    self.bind.scrollList_pet:freshAll(self._mountList)
  else
    self.bind.scrollList_pet:clear()
    self.bind.scrollList_pet:insert_array(self._mountList)
  end
  self._initList = true
  self:setMountListActive()
end

function this:refreshSelectMountAfterUse()
  if not self._mountList then
    return
  end
  for _, item in ipairs(self._mountList) do
    if item.guid == self._selectMountId then
      item.curSatiety = L_SatietyStore:getPetSatiety(item.guid)
      break
    end
  end
  self:setMountListActive()
end

function this:setMountListActive()
  for i, v in pairs(self.modules.scrollList_pet) do
    local module = v
    module:setActive(self._selectMountId == module.bind.guid)
    if v.bind.guid == self._selectMountId then
      local addSatiety = self._satietyOnce * self.data.curNum
      module:setAddSatiety(addSatiety)
    end
  end
end

function this:getMaxItemNum()
  local maxNum = 0
  if self.data.isHeroTab then
    local tpl = foodTpl:getTplById(self.data.curItemId)
    local oneItemFunc = foodTpl:getCharge(tpl) or 0
    local chargeData = L_StarHealingStore:getCharge().cur_value
    local limitCharge = L_StarHealingStore:getMaxCharge()
    local needCharge = limitCharge - chargeData
    if oneItemFunc ~= 0 then
      maxNum = math.ceil(needCharge / oneItemFunc)
    end
  else
    local curSatiety = L_SatietyStore:getPetSatiety(self._selectMountId)
    local maxSatiety = L_SatietyStore:getPetMaxSatiety(self._selectMountId)
    local needSatiety = maxSatiety - curSatiety
    if self._satietyOnce ~= 0 then
      maxNum = math.ceil(needSatiety / self._satietyOnce)
    end
  end
  return maxNum
end

return this
