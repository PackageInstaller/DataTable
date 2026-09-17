local this = class("moduleFishingGame", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _fishQteTpl = L_GameTpl:getFishQteTpl()
local _fishTpl = L_GameTpl:getFishTpl()
local _fishRodTpl = L_GameTpl:getFishRodTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    list_playerStamina = {
      moduleName = "pages/fishing/cellPlayerStamina"
    },
    list_fishingGame = {
      moduleName = "pages/fishing/cellFishingGame"
    }
  }
end

function this.methods()
  return {
    list_fishingGame = {
      onClick_ring = function(self, res, pos)
        if res then
          self._fishStamina = math.clamp(self._fishStamina - self._strengthNum, 0, self._fishStaminaMax)
          self:changeLoopAni(pos)
        else
          self._playerStamina = math.clamp(self._playerStamina - 1, 0, self._playerStaminaMax)
        end
        self:setStaminaFill(false, res)
        self:dealWithResult()
      end
    }
  }
end

function this:open(options)
  this.super.open(self, options)
end

function this:close(options)
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
end

function this:setFishId(itemId, callback, pageRootRect)
  self._callback = callback
  self._pageRootRect = pageRootRect
  self:initCellFishingGameR()
  local tpl_commonItem_fish = _commonItemTpl:getTplById(itemId)
  local fishId = _commonItemTpl:getSubId(tpl_commonItem_fish)
  local tpl_fish = _fishTpl:getTplById(fishId)
  local musicScore = _fishTpl:getMusicScore(tpl_fish)
  local musicIndex = math.random(1, #musicScore)
  self._qteId = musicScore[musicIndex]
  self._playerStamina = _fishTpl:getErrors(tpl_fish)
  self._fishStamina = _fishTpl:getStrength(tpl_fish)
  self._playerStaminaMax = _fishTpl:getErrors(tpl_fish)
  self._fishStaminaMax = _fishTpl:getStrength(tpl_fish)
  local tpl_commonItem_rod = _commonItemTpl:getTplById(L_FishingStore:getCurRodId())
  local rodId = _commonItemTpl:getSubId(tpl_commonItem_rod)
  local tpl_fishRod = _fishRodTpl:getTplById(rodId)
  self._strengthNum = _fishRodTpl:getStrengthNum(tpl_fishRod)
  self._qteOrder = 1
  self._isRes = false
  self:setStaminaFill(true)
  self:removeAllGameCell()
  self:createGameCell()
end

function this:setStaminaFill(init, isSuccess)
  self.bind.fill_stamina_fish = self._fishStamina / self._fishStaminaMax
  if init then
    self.bindComponents.hpScript_fishStamina:InitHp(self._fishStamina / self._fishStaminaMax)
    local tmp = {}
    for i = 1, self._playerStaminaMax do
      table.insert(tmp, {go_active = true})
    end
    self.bind.list_playerStamina:clear()
    self.bind.list_playerStamina:insert_array(tmp)
  else
    self.bindComponents.hpScript_fishStamina:SetHp(self._fishStamina / self._fishStaminaMax)
    if not isSuccess then
      for i, v in ipairs(self.modules.list_playerStamina) do
        if i == self._playerStamina + 1 then
          v:playHideFX()
        end
      end
    end
  end
end

function this:createGameCell()
  if self._fishStamina <= 0 or 0 >= self._playerStamina then
    return
  end
  local tpl_curQte = _fishQteTpl:getTplByTeamAndOrder(self._qteId, self._qteOrder)
  L_TimerManager:newOrResetTimer(self, "doNext", function()
    local tplVec3 = _fishQteTpl:getCoordinate(tpl_curQte)
    local maxAbs = self._pageRootRect.rect.width / 2 - self.rectCellFishingR
    local PosX = math.min(math.abs(tplVec3.x), maxAbs) * (tplVec3.x >= 0 and 1 or -1)
    local maxYAbs = self._pageRootRect.rect.height / 2 - self.rectCellFishingR
    local PosY = math.min(math.abs(tplVec3.y), maxYAbs) * (0 <= tplVec3.y and 1 or -1)
    self.bind.list_fishingGame:insert({
      order = self._qteOrder,
      disappearTime = _fishQteTpl:getDisappear(tpl_curQte),
      localPos_cell = L_Vector3.new(PosX, PosY, 0)
    })
    local tplTeam_curQte = _fishQteTpl:getTplTeam(self._qteId)
    self._qteOrder = self._qteOrder + 1
    if self._qteOrder > table.count(tplTeam_curQte) then
      self._qteOrder = 1
    end
    self:createGameCell()
  end, _fishQteTpl:getInterval(tpl_curQte) / 1000)
end

function this:dealWithResult()
  if self._isRes then
    return
  end
  local res
  if self._fishStamina <= 0 then
    self._isRes = true
    res = true
  elseif 0 >= self._playerStamina then
    self._isRes = true
    res = false
  end
  if res ~= nil then
    self:removeAllGameCell()
    L_TimerManager:newOrResetTimer(self, "dealWithResult", function()
      self._callback(res)
    end, 0.666)
  end
end

function this:removeAllGameCell()
  L_TimerManager:clearTimer(self)
  for i, v in pairs(self.modules.list_fishingGame) do
    v:removeSelf()
  end
end

function this:changeLoopAni(pos)
  local size = math.min(Unity.Screen.width / 1920, Unity.Screen.height / 1080)
  local screenHeight = Unity.Screen.height / size
  local screenWidth = Unity.Screen.width / size
  local maxCos = L_Vector3.dot(L_Vector3.up, L_Vector3.new(screenWidth, screenHeight, 0).normalized)
  local curCos = L_Vector3.dot(L_Vector3.up, pos.normalized)
  local dir
  if maxCos <= curCos then
    dir = L_FishingConst.FishMoveDir.Front
  elseif curCos <= -maxCos then
    dir = L_FishingConst.FishMoveDir.Back
  elseif 0 >= pos.x then
    dir = L_FishingConst.FishMoveDir.Left
  elseif 0 <= pos.x then
    dir = L_FishingConst.FishMoveDir.Right
  end
  L_FishingManager:changeGameDir(dir)
end

function this:initCellFishingGameR()
  self.rectCellFishingR = self.bindComponents.rectCellFishingGame.rect.width / 2
end

return this
