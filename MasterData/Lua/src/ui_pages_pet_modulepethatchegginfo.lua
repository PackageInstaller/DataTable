local cls = class("modulePetHatchEggInfo", G_UIModuleBase)
local _EggTpl = L_GameTpl:getPetEggTpl()

function cls.bind()
  return {
    active_state_empty = false,
    active_eggInfoNode = false,
    img_eggIcon_old = "",
    img_eggIcon_now = "",
    txt_hatch_time = "",
    img_timeBar2 = 0,
    txt_left_time = "",
    active_txt_statusName_hatching = false,
    active_txt_statusName_queueing = false,
    active_txt_statusName_hatched = false,
    active_btn_startHatch = false,
    active_btn_quitHatch = false,
    active_btn_getHatch = false,
    txt_eggName = "",
    active_imgTime = false,
    active_imgPause = false,
    active_timeBar = false
  }
end

function cls.methods()
  return {
    onClick_startHatch = function(self)
      self:startHatch()
    end,
    onClick_quitHatch = function(self)
      self:quitHatch()
    end,
    onClick_getHatch = function(self)
      self:getHatch()
    end
  }
end

function cls:hideModules()
  if self.activeTag == nil or self.activeTag then
    self.lastState = nil
    self.activeTag = false
  end
end

function cls:showModules()
  if not self.activeTag then
    self.lastState = nil
    self.activeTag = true
  end
end

function cls:open(options)
  self.lastEggUid = -1
  self.lastState = nil
  
  function self._refreshView()
    if not self.eggUid then
      return
    end
    self:refreshView()
  end
  
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshView)
end

function cls:close(options)
  self.lastEggUid = -1
  self.lastState = nil
  L_TimerManager:clearTimer(self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshView)
end

function cls:InitModule(eggUid, buildUid)
  self.eggUid = eggUid
  self.buildUid = buildUid
  self:refreshView()
end

function cls:refreshView()
  L_TimerManager:clearTimer(self)
  if not self.eggUid or self.eggUid <= 0 then
    self.bind.active_state_empty = true
    self.bind.active_eggInfoNode = false
    return
  end
  self.bind.active_state_empty = false
  self.bind.active_eggInfoNode = true
  local petEggData = L_PetStore:getPetEggItem(self.eggUid)
  if not petEggData then
    return
  end
  local productUid = L_ProductManager:getProductGuidBySpecialGuid(self.buildUid, self.eggUid)
  local state = L_ProductManager:getProductState(self.buildUid, productUid)
  local csHomeBuildProductData = L_ProductManager:getProductByGuid(self.buildUid, productUid)
  if self.lastState == nil then
    self.bindComponents.egg:SetTrigger(C_CsAnimator.StringToHash("ForceInit"))
  end
  self.bindComponents.egg:SetBool(C_CsAnimator.StringToHash("Done"), state == L_HomeConst.ProductQueueState.FINISH)
  if self.lastEggUid and 0 < self.lastEggUid and self.lastEggUid ~= self.eggUid then
    local lastPetEggData = L_PetStore:getPetEggItem(self.lastEggUid)
    if not lastPetEggData then
      self.lastEggUid = -1
    else
      local lastPetEggCfg = L_ItemTplManager:getPetEggItem(lastPetEggData.configId, self.lastEggUid)
      self.bind.img_eggIcon_old = lastPetEggCfg.icon
      if state == L_HomeConst.ProductQueueState.FINISH then
        self.bindComponents.egg:SetTrigger(C_CsAnimator.StringToHash("Switch2Done"))
      else
        self.bindComponents.egg:SetTrigger(C_CsAnimator.StringToHash("Switch2Base"))
      end
    end
  end
  local petEggCfg = L_ItemTplManager:getPetEggItem(petEggData.configId, self.eggUid)
  self.bind.img_eggIcon_now = petEggCfg.icon
  if self.lastState and self.lastState ~= state and self.lastEggUid == self.eggUid then
    if state == L_HomeConst.ProductQueueState.RUNNING and self.lastState == L_HomeConst.ProductQueueState.WAITING then
      self:refreshState(state, petEggData, csHomeBuildProductData, false)
    else
      self.bindComponents.info:Play("anim_egg_info_fresh1")
      self.info1Timer = Timer.once(0.165, function()
        self.bindComponents.info:Play("anim_egg_info_fresh2")
        self:refreshState(state, petEggData, csHomeBuildProductData, state == L_HomeConst.ProductQueueState.FINISH)
      end, self)
      if state == L_HomeConst.ProductQueueState.FINISH then
        self.bindComponents.TimeBar:Play("anim_egg_timebar_finish")
        self.timerBar1Timer = Timer.once(0.528, function()
          self.bind.active_timeBar = false
        end, self)
      end
    end
  elseif self.lastEggUid ~= self.eggUid then
    local isSameBtnState = self.lastState == state or (self.lastState == L_HomeConst.ProductQueueState.WAITING or self.lastState == L_HomeConst.ProductQueueState.RUNNING) and (state == L_HomeConst.ProductQueueState.WAITING or state == L_HomeConst.ProductQueueState.RUNNING)
    if not isSameBtnState then
      self.bindComponents.info:Play("anim_egg_info_switch1")
      self.info2Timer = Timer.once(0.165, function()
        self.bindComponents.info:Play("anim_egg_info_switch2")
        self:refreshState(state, petEggData, csHomeBuildProductData, false)
        self.bind.txt_eggName = petEggCfg.name
      end, self)
    else
      self.bindComponents.info:Play("anim_egg_info_switch3")
      self.info2Timer = Timer.once(0.165, function()
        self.bindComponents.info:Play("anim_egg_info_switch4")
        self:refreshState(state, petEggData, csHomeBuildProductData, false)
        self.bind.txt_eggName = petEggCfg.name
      end, self)
    end
    local isShowTime = state == L_HomeConst.ProductQueueState.WAITING or state == L_HomeConst.ProductQueueState.RUNNING
    if not isShowTime then
      self.bindComponents.TimeBar:Play("anim_egg_timebar_hide")
      self.timerBar1Timer = Timer.once(0.264, function()
        self.bind.active_timeBar = false
      end, self)
    end
  else
    self:refreshState(state, petEggData, csHomeBuildProductData, false)
    self.bind.txt_eggName = petEggCfg.name
  end
  self.lastEggUid = self.eggUid
  self.lastState = state
end

function cls:setStateNodeShow(state, petEggData, bPlayTimeBarDisappearAnim)
  self.bind.active_txt_statusName_hatched = state == L_HomeConst.ProductQueueState.FINISH
  self.bind.active_txt_statusName_hatching = state == L_HomeConst.ProductQueueState.RUNNING
  self.bind.active_txt_statusName_queueing = state == L_HomeConst.ProductQueueState.WAITING
  self.bind.active_btn_getHatch = state == L_HomeConst.ProductQueueState.FINISH
  self.bind.active_btn_quitHatch = state == L_HomeConst.ProductQueueState.WAITING or state == L_HomeConst.ProductQueueState.RUNNING
  self.bind.active_btn_startHatch = state == L_HomeConst.ProductQueueState.NONE
  local isShowTime = state == L_HomeConst.ProductQueueState.WAITING or state == L_HomeConst.ProductQueueState.RUNNING
  if not isShowTime then
    self.bind.active_imgTime = false
    self.bind.active_imgPause = false
    if not bPlayTimeBarDisappearAnim then
      self.bind.active_timeBar = false
    end
  else
    self.bind.active_timeBar = true
    if self.bindComponents.TimeBar.isPlaying and self.bindComponents.TimeBar.clip.name ~= "anim_egg_timebar_show" then
      self.bindComponents.TimeBar:Stop()
      self.bindComponents.TimeBar:Play("anim_egg_timebar_show")
    end
  end
end

function cls:refreshEggSpineModelState(show, petEggData)
  if show then
    local eggCfg = _EggTpl:getTplById(petEggData.configId)
    local path = _EggTpl:getEggSpineModel(eggCfg)
    self.bind.eggSpineModule = path
    self.bind.eggSpineModActive = true
    self.bind.eggSpineModOffset = C_Vector3(-56, 0, 0)
    self.bind.eggSpineModScale = C_Vector3(1.1, 1.1, 1.1)
    return
  end
  self.bind.eggSpineModule = ""
  self.bind.eggSpineModActive = show
end

function cls:refreshState(state, petEggData, csHomeBuildProductData, bPlayTimeBarDisappearAnim)
  self:setStateNodeShow(state, petEggData, bPlayTimeBarDisappearAnim)
  if state == L_HomeConst.ProductQueueState.NONE then
    L_TimerManager:newOrResetTimer(self, "refresh", function()
      self:refreshView()
    end, 0.25, -1)
    self.bind.txt_hatch_time = L_TimeUtil.secondToLangString(L_PetStore:getEggIncubationTime(petEggData.configId, self.buildUid))
    return
  end
  local finishNum, total, amount = L_ProductManager:getProductProduceInfo(self.buildUid, csHomeBuildProductData)
  local nowTime = L_TimeUtil.getServerTimeWithFloor()
  if state == L_HomeConst.ProductQueueState.FINISH then
    return
  end
  if state == L_HomeConst.ProductQueueState.WAITING then
    L_TimerManager:newOrResetTimer(self, "refresh", function()
      self:refreshView()
    end, 0.25, -1)
    self.bind.img_timeBar2 = 0
    if L_SatietyStore:isBuildingPause(self.buildUid) then
      self.bind.active_imgTime = false
      self.bind.active_imgPause = true
    else
      self.bind.active_imgTime = true
      self.bind.active_imgPause = false
      self.bind.txt_left_time = L_TimeUtil.secondToString(L_PetStore:getEggIncubationTime(petEggData.configId, self.buildUid))
    end
    return
  end
  if state == L_HomeConst.ProductQueueState.RUNNING then
    L_TimerManager:newOrResetTimer(self, "refresh", function()
      self:refreshView()
    end, 0.25, -1)
    self.bind.active_imgTime = true
    self.bind.active_imgPause = false
    self.bind.img_timeBar2 = amount
    self.bind.txt_left_time = L_TimeUtil.secondToString(csHomeBuildProductData.startTime + L_PetStore:getEggIncubationTime(petEggData.configId, self.buildUid) - nowTime)
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
