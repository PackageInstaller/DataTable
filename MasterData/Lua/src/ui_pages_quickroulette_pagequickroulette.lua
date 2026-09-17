local this = class("pageQuickRoulette", G_UIPageBase)

function this.bind()
  return {
    module_quickRoulette = {
      moduleName = "pages/quickRoulette/moduleQuickRoulette"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
    end,
    onClick_edit = function(self)
      self.needChangeSelect = false
      L_UI:open("pageQuickEditRoulette")
    end,
    module_quickRoulette = {
      onClick_cell = function(self)
      end
    }
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.quickRoulette)
  callback(result)
end

function this:initData()
  self.needChangeSelect = true
  self._type = L_Const.quickRouletteType.normal
  L_QuickRouletteStore:setCurSelectType(self._type)
end

function this:show(options)
  self.isShow = true
  self.isWaitForClose = false
  self:initData()
  self:initRouletteModule()
  AzurWorldInstance:PauseWorld()
end

function this:hide(options)
  self.isShow = false
  local index = self.modules.module_quickRoulette._selectIndex
  if self.needChangeSelect and index and 0 < index then
    L_QuickRouletteStore:changeSelect(self._type, index)
  end
  if self._rouletteModule then
    self._rouletteModule:onHide()
  end
  AzurWorldInstance:ResumeWorld()
  L_QuickRouletteStore.rouletteNeedClose = false
end

function this:initRouletteModule()
  self._rouletteModule = self.modules.module_quickRoulette
  self._rouletteModule:setData_roulette(self._type)
end

function this:escHandle()
end

function this:update()
  if L_QuickRouletteStore.rouletteNeedClose then
    L_UI:close(self.pageName)
    self.isWaitForClose = true
  end
  if self._isPause or self.isWaitForClose or not self.isShow then
    return
  end
  if self._rouletteModule then
    self._rouletteModule:update()
  end
end

return this
