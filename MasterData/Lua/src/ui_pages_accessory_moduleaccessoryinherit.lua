local this = class("moduleAccessoryInherit", G_UIModuleBase)
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local _wordTpl = L_GameTpl:getWordsTpl()
local _accessoryQualityTpl = L_GameTpl:getAccessoryQualityTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _fightProhibitTbl = L_GameTpl:getFightProhibitTpl()

function this.bind()
  return {
    module_cellInheritItem_Main = {
      moduleName = "pages/accessory/cellInheritItem"
    },
    module_cellInheritItem_Inherit = {
      moduleName = "pages/accessory/cellInheritItem"
    },
    btn_Inherit = L_Const.ModuleInfo.ModuleBtn,
    go_maxActive = false,
    go_InheritBtn = false,
    go_titleNode = false
  }
end

function this.methods()
  return {
    onclick_Revert = function(self)
      self:openAccessoryStarUpMaterialBag()
    end
  }
end

function this:InitModule(options)
  self.options = options
  self.guid = options.guid
  self.selectDatas = {}
  local moduleBtn = self.modules.btn_Inherit
  moduleBtn:setData({
    txtName = _wordTpl:getTplById("ui_accessory_inherit_text"),
    callback = function()
      self:OrnamentInherit()
    end,
    itemType = L_Const.resType.currency,
    itemId = L_Const.currencyType.gold,
    itemNum = _gameConstTpl:getData("ACCESSORY_INHERIT_CURRENCY_COST", L_Const.GameTplType.int)
  })
  self.bind.go_InheritBtn = false
  self.bind.go_titleNode = true
  self:OnInitModuleAddItemMain()
  self:OnInitModuleAddItemInherit()
end

function this:OnInitModuleAddItemMain()
  self.modules.module_cellInheritItem_Main:InitModule({
    guid = self.guid,
    isMax = false
  })
end

function this:OnInitModuleAddItemInherit()
  local serverData = C_AccessoryMgr:getAccessory(self.guid)
  self.bind.go_titleNode = serverData.quality ~= _accessoryQualityTpl:getMaxQuality()
  self.modules.module_cellInheritItem_Inherit:InitModule({
    guid = 0,
    callback = function()
      self:InitBagList()
      if #self.bagDataList == 0 then
        L_FlyMsgManager:showNormalMsg(_wordTpl:getTplById("notice_accessory_inherit_top_quality"))
        return
      end
      self:openAccessoryStarUpMaterialBag()
    end,
    isMax = serverData.quality == _accessoryQualityTpl:getMaxQuality()
  })
end

function this:openAccessoryStarUpMaterialBag()
  L_UI:open("PageAccessoryStarUpMaterialBag", {
    guid = self.guid,
    limitNum = 0,
    costList = self.selectDatas,
    bagList = self.bagDataList,
    isFliterLock = false,
    isInherit = true,
    onClickHandle = function(guid)
      self.selectDatas = {}
      table.insert(self.selectDatas, guid)
      self.modules.module_cellInheritItem_Inherit:refreshUI(guid)
      self.bind.go_InheritBtn = true
      self.bind.go_titleNode = false
    end,
    onRemoveHandle = function(guid)
      for i = 1, #self.selectDatas do
        if self.selectDatas[i] == guid then
          table.remove(self.selectDatas, i)
          break
        end
      end
      self.modules.module_cellInheritItem_Inherit:refreshUI(0)
      self.bind.go_InheritBtn = false
      self.bind.go_titleNode = true
    end
  })
end

function this:OrnamentInherit()
  if C_BattleManager.IsInBattle(C_EntityManager.MainPlayer) then
    local cfg = _fightProhibitTbl:getTplById(1031)
    L_FlyMsgManager:showNormalMsg(_fightProhibitTbl:getBlockTips(cfg))
    return
  end
  if #self.selectDatas < 1 then
    L_FlyMsgManager:showNormalMsg(_wordTpl:getTplById("notice_accessory_inherit_material_choose"))
    return
  end
  if L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) < _gameConstTpl:getData("ACCESSORY_INHERIT_CURRENCY_COST", L_Const.GameTplType.int) then
    L_FlyMsgManager:showNormalMsg(_wordTpl:getTplById("notice_accessory_inherit_lack_of_currency"))
    return
  end
  C_AccessoryMgr:rsp_OrnamentInherit(self.selectDatas[1], self.guid, function()
    self:InitModule(self.options)
  end)
end

function this:InitBagList()
  self.bagDataList = {}
  local res = {}
  local acc = C_AccessoryMgr:getHeroAccessory()
  local serverData = C_AccessoryMgr:getAccessory(self.guid)
  for key, value in pairs(acc) do
    local aTpl = _accessoryTpl:getTplById(value.accessoryId)
    local starUpATpl = _accessoryTpl:getTplById(serverData.accessoryId)
    if value.wearHero == 0 and value.accessoryId == serverData.accessoryId and value.guid ~= serverData.guid and 0 < value.quality and value.quality > serverData.quality then
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
    if x.quality ~= y.quality then
      return x.quality > y.quality
    end
    if x.level ~= y.level then
      return x.level < y.level
    end
    return x.guid < y.guid
  end)
  self.bagDataList = res
end

return this
