local this = class("pageMountRoulette", G_UIPageBase)

function this.bind()
  return {
    module_mountRoulette = {
      moduleName = "pages/mount/moduleMountRoulette"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_feed = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cookingHungry_08"))
    end,
    onClick_edit = function(self)
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.EditMountRoulette))
        return
      end
      self._isPause = true
      self.bindComponents.ani_pageMountRoulette:Stop()
      self.bindComponents.ani_pageMountRoulette:Play("anim_mountwheel_hide")
      L_UI:open("pageMountEditRoulette", {
        callback = function()
          self._isPause = false
          self.bindComponents.ani_pageMountRoulette:Stop()
          self.bindComponents.ani_pageMountRoulette:Play("anim_mountwheel_show")
        end
      })
    end,
    module_mountRoulette = {
      onClick_empty = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_inMounting = function(self)
        L_UI:close(self.pageName, nil, function()
          AzurWorld.mountMgr:ReqLeaveMount()
        end)
      end,
      onClick_equipped = function(self)
        L_UI:close(self.pageName)
        AzurWorld.mountMgr:ReqRideMount(AzurWorld.mountMgr:GetEquipMountId())
      end,
      onClick_notEquipped = function(self, index)
        L_UI:close(self.pageName)
        AzurWorld.mountMgr:ReqRideMount(L_MountStore:getMountMap()[index])
      end
    }
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  local isMountEditLock = result and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mountEditRoulette)
  callback(isMountEditLock)
end

function this:preOpen(options)
  self:initRouletteModule()
  self.bindComponents.ani_moduleMountRoulette:Play("anim_mountwheel_in")
end

function this:close(options)
end

function this:initRouletteModule()
  self._rouletteModule = self.modules.module_mountRoulette
  self._rouletteModule:setData_roulette()
end

function this:update()
  if self._isPause then
    return
  end
  self._rouletteModule:update()
end

function this:onRStickMove(v2)
end

return this
