local this = class("moduleCapture", G_UIModuleBase)

function this.bind()
  return {
    hudList = {
      moduleName = "pages/battle/cellCatchHud"
    },
    leftList = {
      moduleName = "pages/battle/cellCatchLeftRightHud"
    },
    rightList = {
      moduleName = "pages/battle/cellCatchLeftRightHud"
    }
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen()
  print("moduleCapture:preOpen")
  self.bindComponents.canvasGroupL.alpha = 0
  self.bindComponents.canvasGroupR.alpha = 0
  self.tweenScrollLeft = self.bindComponents.canvasGroupL:DOFade(1, 0.5)
  self.tweenScrollRight = self.bindComponents.canvasGroupR:DOFade(1, 0.5)
  self.tweenScrollLeft:OnComplete(function()
    self.tweenScrollLeft = nil
  end)
  self.tweenScrollRight:OnComplete(function()
    self.tweenScrollRight = nil
  end)
end

function this:open()
  self:prepareHudData()
  self._hudLoadIndex = 1
  self._hudLoadComplete = false
  self.bind.hudList:clear()
  self.bind.leftList:clear()
  self.bind.rightList:clear()
  if self:checkCanShowPetList() then
    self:generateCurPetsList()
    L_BattleDataManager:addListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_petCatch, self)
  end
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleCapture.update")
end

function this:checkCanShowPetList()
  return self.parent.name == "pageBattlePetCatch"
end

function this:close()
  if self.tweenScrollLeft then
    self.tweenScrollLeft:Kill()
    self.tweenScrollLeft = nil
  end
  if self.tweenScrollRight then
    self.tweenScrollRight:Kill()
    self.tweenScrollRight = nil
  end
  self:removeListener()
  L_TimerManager:clearTimer(self)
  if self.updateHandle then
    C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
    self.updateHandle = nil
  end
end

function this:removeListener()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_petCatch, self)
end

function this:generateCurPetsList()
  local monsters = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()
  local leftDataList = {}
  local rightDataList = {}
  for i = 0, monsters.Count - 1 do
    local monster = monsters[i]
    local monsterDataLeft = {monster = monster}
    local monsterDataRight = {monster = monster}
    table.insert(leftDataList, monsterDataLeft)
    table.insert(rightDataList, monsterDataRight)
  end
  self.bind.leftList:insert_array(leftDataList)
  self.bind.rightList:insert_array(rightDataList)
end

function this:onEvent_petCatch(args)
end

function this:processMonsterList(monsters, petList, tag)
  for i, v in pairs(petList) do
    local item = v
    local petIndex = i
    if item and item.bind.monster then
      do
        local index = -1
        local isInMonsters = false
        for j = 0, monsters.Count - 1 do
          if item.bind.monster == monsters[j] then
            isInMonsters = true
            index = j
            break
          end
        end
        if isInMonsters then
          if item.bind.playAnimation == "anim_sidebtn_hide" then
            L_TimerManager:stopTimer(self, "playHideAni" .. tag .. tostring(petIndex))
            item.bind.gameObj = true
            item.bind.playAnimation = "anim_sidebtn_show"
            item:refresh()
          elseif item.bind.gameObj ~= isInMonsters then
            item.bind.gameObj = true
            item.bind.playAnimation = "anim_sidebtn_show"
            item:refresh()
          end
        elseif item.bind.gameObj ~= isInMonsters and item.bind.playAnimation ~= "anim_sidebtn_hide" then
          item.bind.playAnimation = "anim_sidebtn_hide"
          L_TimerManager:newOrResetTimer(self, "playHideAni" .. tag .. tostring(petIndex), function()
            if self.isBind then
              item.bind.gameObj = false
              item.bind.playAnimation = ""
            end
          end, 0.5)
        end
      end
    end
  end
end

function this:RefreshChangePet()
  AzurWorld.PetCatchManagerMgr:SortLeftAndRight()
  if self.modules and self.modules.leftList and self.modules.rightList and self:checkCanShowPetList() then
    self:processMonsterList(AzurWorld.PetCatchManagerMgr:GetLeftMonsterList(), self.modules.leftList, "left")
    self:processMonsterList(AzurWorld.PetCatchManagerMgr:GetRightMonsterList(), self.modules.rightList, "right")
  end
end

function this:prepareHudData()
  self.hudDataList = {}
  local monsters = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()
  for i = 0, monsters.Count - 1 do
    table.insert(self.hudDataList, {
      monster = monsters[i]
    })
  end
end

function this:update()
  if self:checkCanShowPetList() then
    self:RefreshChangePet()
  end
  if not self._hudLoadComplete then
    if not self.hudDataList or #self.hudDataList == 0 then
      self:prepareHudData()
    end
    if self.hudDataList and self._hudLoadIndex <= #self.hudDataList then
      self.bind.hudList:insert(self.hudDataList[self._hudLoadIndex])
      self._hudLoadIndex = self._hudLoadIndex + 1
      return
    elseif self.hudDataList and #self.hudDataList > 0 then
      self._hudLoadComplete = true
    end
  end
end

function this:refresh()
end

return this
