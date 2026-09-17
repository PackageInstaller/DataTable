local this = class("pagePetDecryptRoulette", G_UIPageBase)

function this.bind()
  return {
    module_petDecryptRoulette = {
      moduleName = "pages/petDecryptRoulette/modulePetDecryptRoulette"
    },
    active_closeBtn = false
  }
end

function this.methods()
  return {
    onClick_editBtn = function(self)
      self:showAnimation(false)
    end,
    onClick_close = function(self)
      if self.needSecondPress then
        self.needSecondPress = false
        return
      end
      L_UI:close("pagePetDecryptRoulette")
    end
  }
end

function this:preOpen()
  self.bind.active_closeBtn = false
  self._isPause = false
  self.timer = Timer.once(0.2, function()
    self.bind.active_closeBtn = true
  end)
  if CS.UnityEngine.Input.GetMouseButton(0) then
    self.needSecondPress = true
  end
end

function this:open(options)
  L_QuickRouletteStore:listenCallFunc(L_QuickRouletteStore.event.refreshPetPuzzleRouletteInfo, self.onEvent_refreshPetPuzzleRouletteInfo, self)
end

function this:show()
  self:refreshView()
end

function this:check(options, callback)
  if C_IntegrateMgr.SystemUnlockModule:CheckIsDisableSystem(L_SystemConst.enum.petPuzzleRoulette, true) then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petPuzzleRoulette)
  if not result then
    callback(false)
    return
  end
  if C_HomeUtil.IsInHome() then
    callback(false)
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    callback(false)
    return
  end
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.Pet, true) then
    callback(false)
    return
  end
  if L_PlayerManager:inKiBoTransformMainControl() then
    callback(false)
    return
  end
  if AzurWorld.UIBattleDataMgr:GetPetPuzzleDoing() and not AzurWorld.UIBattleDataMgr:CheckPetPuzzleOutMaxCD() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_puzzle_cd_tips"))
    callback(false)
    return
  end
  local top = C_UIMgr.GetTopPage(0)
  if top and (top.name == "pageMainCity" or top.config.mode == CS.Azur.Gameplay.EUIMode.Coexist) then
    callback(true)
    return
  end
  callback(false)
end

function this:castPetDecryptSkill(guid)
  AzurWorld.UIBattleDataMgr:PetDecryptRoulette(guid)
end

function this:refreshView()
  local rouletteInfo = L_QuickRouletteStore:getRouletteInfoByType(L_Const.quickRouletteType.petPuzzle)
  local data = {}
  
  local function onClick_select(cell)
    if cell.bind.guid <= 0 then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_puzzla_roulette01"))
      return
    end
    local isSwimming = AzurWorld.playerMgr.myPlayerData:GetIsSwimming()
    if isSwimming then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_swim_petpuzzle_tip"))
      return
    end
    self:castPetDecryptSkill(cell.bind.guid)
    L_UI:close("pagePetDecryptRoulette")
  end
  
  local function onDragEnter_cell(cell)
    cell:setSelectState(true)
  end
  
  local function onDragExit_cell(cell)
    cell:setSelectState(false)
  end
  
  for index, guid in ipairs(rouletteInfo) do
    table.insert(data, {
      guid = guid,
      index = index,
      cbk = onClick_select,
      onDragEnter = onDragEnter_cell,
      onDragExit = onDragExit_cell
    })
  end
  local modulePetDecryptRoulette = self.modules.module_petDecryptRoulette
  modulePetDecryptRoulette:refreshPetData(data)
end

function this:onEvent_refreshPetPuzzleRouletteInfo()
  self:refreshView()
end

function this:close()
  L_QuickRouletteStore:unListenCallFunc(L_QuickRouletteStore.event.refreshPetPuzzleRouletteInfo, self.onEvent_refreshPetPuzzleRouletteInfo, self)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:showAnimation(isIn)
  if not self.isBind or not self.bindComponents.anim_commonEditRoulette then
    return
  end
  self._isPause = true
  self.bindComponents.anim_commonEditRoulette:Stop()
  self.bindComponents.anim_commonEditRoulette:Play("anim_petdecryptroulette_hide")
  L_TimerManager:newOrResetTimer(self, "petdecryptroulette_openEdit", function()
    if self.bindComponents.anim_commonEditRoulette.gameObject then
      self.bindComponents.anim_commonEditRoulette.gameObject:SetActive(false)
    end
    L_UI:open("pagePetDecryptEditRoulette", {
      callback = function()
        self._isPause = false
        if self.bindComponents and self.bindComponents.anim_commonEditRoulette and self.bindComponents.anim_commonEditRoulette.gameObject then
          self.bindComponents.anim_commonEditRoulette.gameObject:SetActive(true)
        end
        self.bindComponents.anim_commonEditRoulette:Stop()
        self.bindComponents.anim_commonEditRoulette:Play("anim_petdecryptroulette_show")
      end
    })
  end, 0.1)
end

return this
