local cls = class("modulePetHatchEggInfoNew", G_UIModuleBase)
local _EggTpl = L_GameTpl:getPetEggTpl()

function cls.bind()
  return {
    txt_envName = L_WordsTpl:getValue("ui_modulePetHatchEggInfoNew_01"),
    txt_eggName = "",
    img_quality = "",
    img_icon = "",
    list_star = {},
    txt_shortDesc = "",
    txt_longDesc = "",
    txt_time = "",
    active_startBtn = true,
    active_hatchingBtn = false
  }
end

function cls.methods()
  return {
    onClick_startHatch = function(self)
      local function callback()
        self:startHatch()
      end
      
      local isStartHatch = true
      self:emit("onClick_startHatch", isStartHatch, callback)
    end
  }
end

function cls:hideModules()
  if self.activeTag == nil or self.activeTag then
    self.activeTag = false
  end
end

function cls:showModules()
  if not self.activeTag then
    self.activeTag = true
  end
end

function cls:open(options)
  function self._refreshView()
    if not self.eggUid then
      return
    end
    self:refreshView()
  end
  
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshView)
end

function cls:close(options)
  L_TimerManager:clearTimer(self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshView)
end

function cls:InitModule(eggUid, buildUid)
  self.eggUid = eggUid
  self.buildUid = buildUid
  self:refreshView()
end

function cls:InitEggInfo(petEggCfgId, petEggCfg, specialDesc)
  self.bind.txt_eggName = petEggCfg.name
  self.bind.txt_shortDesc = petEggCfg.desc
  self.bind.txt_longDesc = specialDesc
  self.bind.img_icon = petEggCfg.icon
  self.bind.img_quality = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", tostring(petEggCfg.quality - 1))
  local starNum = L_ItemTplManager:getItemShowStarNum(L_Const.resType.petEgg, petEggCfgId)
  self:_setStars(starNum)
end

function cls:_setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function cls:refreshView()
  L_TimerManager:clearTimer(self)
  local petEggData = L_PetStore:getPetEggItem(self.eggUid)
  if not petEggData then
    return
  end
  local productUid = L_ProductManager:getProductGuidBySpecialGuid(self.buildUid, self.eggUid)
  local state = L_ProductManager:getProductState(self.buildUid, productUid)
  local csHomeBuildProductData = L_ProductManager:getProductByGuid(self.buildUid, productUid)
  local petEggCfg = L_ItemTplManager:getPetEggItem(petEggData.configId, self.eggUid)
  local eggTpl = _EggTpl:getTplById(petEggData.configId)
  local specialDesc = _EggTpl:getSpecialDesc(eggTpl)
  self:refreshState(state, petEggData, csHomeBuildProductData, false)
  self:InitEggInfo(petEggData.configId, petEggCfg, specialDesc)
end

function cls:refreshState(state, petEggData, csHomeBuildProductData, bPlayTimeBarDisappearAnim)
  if state == L_HomeConst.ProductQueueState.NONE then
    self.bind.txt_time = L_TimeUtil.secondToLangString(L_PetStore:getEggIncubationTime(petEggData.configId, self.buildUid))
    return
  end
  local nowTime = L_TimeUtil.getServerTimeWithFloor()
  if state == L_HomeConst.ProductQueueState.FINISH then
    return
  end
  if state == L_HomeConst.ProductQueueState.WAITING then
    return
  end
  if state == L_HomeConst.ProductQueueState.RUNNING then
    return
  end
end

function cls:startHatch()
  local petEggData = L_PetStore:getPetEggItem(self.eggUid)
  local eggTpl = _EggTpl:getTplById(petEggData.configId)
  local productId = _EggTpl:getProduct(eggTpl)
  if not C_HomeUtil.CheckBuildCanProduct(self.buildUid, productId) then
    return
  end
  L_PetStore:req_hatchPetEgg(self.buildUid, self.eggUid)
end

function cls:quitHatch()
  L_GameUtil.showCommonTip({
    txtContent = L_WordsTpl:getValue("ui_modulePetHatchEggInfoNew_02"),
    confirmCallback = function()
      L_PetStore:req_cancelHatchPetEgg(self.buildUid, self.eggUid)
    end
  })
end

function cls:getHatch()
  L_PetStore:onClickHatchOutPetEgg(self.buildUid, self.eggUid)
end

return cls
