local this = class("pageMountFeed", G_UIPageBase)
local _foodTpl = L_GameTpl:getFoodTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    txt_name = nil,
    txt_desc = nil,
    module_selectNum = L_Const.ModuleInfo.SelectNum,
    pos_mountScroll = C_Vector2(69, 109),
    scrollList_mount = {
      moduleName = "pages/mount/cellMountFeed"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_bg = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_cancel = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_confirm = function(self)
      local curSatiety = L_SatietyStore:getPetSatiety(self._selectMountId)
      local maxSatiety = L_SatietyStore:getPetMaxSatiety(self._selectMountId)
      local needSatiety = maxSatiety - curSatiety
      if math.isEmpty(needSatiety) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cookingHungry_06"))
        return
      end
      C_BagMgr:ReqUseItem(self._foodId, self._curNum, {
        L_Const.UseFoodTarget.UFT_PET,
        self._selectMountId
      }, function()
        if math.isEmpty(C_BagMgr:getItemNumByItemId(self._foodId)) then
          L_UI:close(self.pageName)
          return
        end
        self._curNum = 1
        self:initMountList()
        self:initSelectNumModule()
        for i, v in pairs(self.modules.scrollList_mount) do
          local cell = v
          if cell.bind.guid == self._selectMountId then
            cell:playFx()
          end
        end
      end)
    end,
    scrollList_mount = {
      onClick_select = function(self, bind)
        if self._selectMountId == bind.guid then
          return
        end
        self._selectMountId = bind.guid
        self._curNum = 1
        self:setMountListActive()
        self:initSelectNumModule()
        L_AudioUtil.playSound("Play_SFX_System_UI_Bag_Food_QIBO_Click")
      end
    }
  }
end

function this:check(options, callback)
  local mountMap = L_MountStore:getMountMap()
  if table.isEmpty(mountMap) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cookingHungry_07"))
    callback(false)
    return
  end
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._foodId = options.foodId
  local tpl_food = _foodTpl:getTplById(self._foodId)
  self._satietyOnce = _foodTpl:getSatietyScore(tpl_food)
  self._curNum = 1
  local tpl_commonItem = _commonItemTpl:getTplById(self._foodId)
  self.bind.txt_name = _commonItemTpl:getName(tpl_commonItem)
  local satiety = _foodTpl:getSatietyScore(tpl_food)
  self.bind.txt_desc = string.concat(L_WordsTpl:getValue("ui_pet_food_desc"), satiety, "。", _commonItemTpl:getDesc(tpl_commonItem))
  self:initMountList()
  self:initSelectNumModule()
end

function this:initMountList()
  local data = L_MountStore:getMountMap()
  local tmp = {}
  for i, v in pairs(data) do
    table.insert(tmp, {guid = v})
  end
  self._selectMountId = self._selectMountId or tmp[1].guid
  if self._initList then
    self.bind.scrollList_mount:freshAll(tmp)
    self.bind.pos_mountScroll = 5 < #tmp and C_Vector2(9, 109) or C_Vector2(69, 109)
  else
    self.bind.scrollList_mount:clear()
    self.bind.scrollList_mount:insert_array(tmp)
    self.bind.pos_mountScroll = 5 < #tmp and C_Vector2(9, 109) or C_Vector2(69, 109)
  end
  self._initList = true
  self:setMountListActive()
end

function this:setMountListActive()
  for i, v in pairs(self.modules.scrollList_mount) do
    local module = v
    module:setActive(self._selectMountId == module.bind.guid)
    if v.bind.guid == self._selectMountId then
      local addSatiety = self._satietyOnce * self._curNum
      module:setAddSatiety(addSatiety)
    end
  end
end

function this:initSelectNumModule()
  local function max()
    local curSatiety = L_SatietyStore:getPetSatiety(self._selectMountId)
    
    local maxSatiety = L_SatietyStore:getPetMaxSatiety(self._selectMountId)
    local needSatiety = maxSatiety - curSatiety
    return math.max(math.min(math.ceil(needSatiety / self._satietyOnce), C_BagMgr:getItemNumByItemId(self._foodId)), 1)
  end
  
  local function func(num)
    self._curNum = num
    self:refreshNum()
  end
  
  self.modules.module_selectNum:initModule(func, max)
end

function this:refreshNum()
  for i, v in pairs(self.modules.scrollList_mount) do
    if v.bind.guid == self._selectMountId then
      local module = v
      local addSatiety = self._satietyOnce * self._curNum
      module:setAddSatiety(addSatiety)
      break
    end
  end
end

return this
