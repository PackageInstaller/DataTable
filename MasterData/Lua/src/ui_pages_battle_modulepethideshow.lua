local this = class("modulePetHideShow", G_UIModuleBase)
local _ColorWhite = C_Color(1, 1, 1)
local _ColorGray = C_Color(0.498, 0.498, 0.498)

function this.bind()
  return {
    txt_hideShowCdPet = "0",
    fill_maskHideShowPet = 0,
    go_petHideShowCd = false,
    go_petHideShow = false,
    desaturate_up = _ColorWhite,
    desaturate_down = _ColorWhite
  }
end

function this.methods()
  return {
    onClick_petHideShow = function(self)
      L_PlayerManager:firePetHideShow()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "modulePetHideShow.update")
  L_PlayerManager:addListener(L_PlayerManager.event.petEntityLoadFinish, self.refreshSkillIcon, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_PlayerManager:addListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:addListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
  self:refreshSkillIcon()
  self:setContentShow(not L_PlayerManager:isInMounting() and L_PlayerManager:getMainHeroEntity() ~= nil)
end

function this:onEvent_CsEntityStateChange()
  self:setContentShow(not L_PlayerManager:isInMounting())
end

function this:onPlayerOnMount()
  self:setContentShow(false)
end

function this:onPlayerOutMount()
  self:setContentShow(true)
  self.petHideShowAnimOnStage = nil
end

function this:show()
  self.petHideShowAnimOnStage = nil
  self:showModules()
end

function this:setMainControl()
  self:refreshSkillIcon()
end

function this:setContentShow(bShow)
  local bChange = L_CommonUtil.setObjActive(self.gameObject, bShow)
  if bChange then
    L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
  end
end

function this:setPetHideShow(bShow)
  if self.bind.go_petHideShow ~= bShow then
    self.bind.go_petHideShow = bShow
    L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
  end
end

function this:refreshSkillIcon()
  self:setContentShow(not L_PlayerManager:isInMounting() and L_PlayerManager:getMainHeroEntity() ~= nil)
  if not L_PlayerManager:getPlayerUnit() then
    return
  end
  local petCsEntity = L_PlayerManager:getPlayerUnit():getMainPetEntity_cs()
  if not petCsEntity then
    self:setPetHideShow(false)
    return
  end
  self:setPetHideShow(true)
end

function this:update()
  if not L_PlayerManager:getPlayerUnit() then
    return
  end
  local petCsEntity = L_PlayerManager:getPlayerUnit():getMainPetEntity_cs()
  if petCsEntity and petCsEntity.data then
    local hsCdTime, hsTotalTime, hsState = petCsEntity.entity:PetHideShowCdTime()
    if hsTotalTime == 0 then
      self:setPetHideShow(false)
    else
      self:setPetHideShow(true)
      if 0 < hsCdTime then
        self:setDesaturateGray(false)
        self:setPetHideShowAnimOnStage(hsState == 2)
      elseif hsState == 3 then
        self:setDesaturateGray(true)
      else
        self:setDesaturateGray(false)
        self:setPetHideShowAnimOnStage(hsState == 2)
      end
    end
    return
  end
  self:setPetHideShow(false)
end

function this:setDesaturateGray(gray)
  if self.desaturateGray == gray then
    return
  end
  self.desaturateGray = gray
  if self.desaturateGray then
    self.bind.desaturate_down = _ColorGray
    self.bind.desaturate_up = _ColorGray
  else
    self.bind.desaturate_down = _ColorWhite
    self.bind.desaturate_up = _ColorWhite
  end
end

function this:setPetHideShowAnimOnStage(onStage)
  if self.petHideShowAnimOnStage ~= onStage then
    self.petHideShowAnimOnStage = onStage
    self.bindComponents.petHideShowAnim:SetBool("OnStage", onStage)
  end
end

function this:close(...)
  this.super.close(self, ...)
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  L_PlayerManager:removeListener(L_PlayerManager.event.petEntityLoadFinish, self.refreshSkillIcon, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:removeListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
  L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
end

return this
