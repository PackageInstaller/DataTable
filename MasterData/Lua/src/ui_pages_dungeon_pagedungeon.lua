local this = class("pageDungeon", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    go_win = false,
    txt_countdown = nil,
    module_task = {
      moduleName = "pages/Task/moduleTask"
    },
    module_moveBlock = {
      moduleName = "modulePages/moduleMovementBlock"
    },
    module_miniMap = {
      moduleName = "pages/Main/moduleMainMiniMap"
    },
    go_moduleHero = false,
    module_hero = {
      moduleName = "pages/Main/moduleMainPlayer"
    },
    module_screenGuide = {
      moduleName = "pages/Main/moduleScreenGuide"
    },
    module_mount = {
      moduleName = "pages/Main/moduleMount"
    }
  }
end

function this.methods()
  return {
    onClick_menu = function(self)
      L_UI:open("pageDungeonMenu")
    end,
    onClick_team = function()
      L_UI:open("pageFormationMain")
    end,
    onClick_bag = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.bag)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_UI:addListener(L_UI.pageEvent.preOpen, self.onEvent_showPage, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  self:dealWithDungeonStatus()
end

function this:show()
  self._pageReady = true
  L_ShortCutManager:registerPageMainShortCut()
  self:openWinCountdown()
end

function this:hide()
  self._pageReady = false
  self:stopWinCountdown()
end

function this:close(options)
  this.super.close(self, options)
  L_UI:removeListener(L_UI.pageEvent.preOpen, self.onEvent_showPage)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
end

function this:escHandle()
end

function this:update()
  if self._pageReady then
    self.modules.module_screenGuide:update()
    self.modules.module_miniMap:update()
  end
end

function this:stopWinCountdown()
  if not self._isWin then
    return
  end
  L_TimerManager:stopTimer(self, "win_countdown")
end

function this:onEvent_showPage(pageName)
  if pageName == "pageBattleSettle" then
    self.bind.go_moduleHero = false
  end
end

function this:onEvent_hidePage(pageName)
  if pageName == "pageBattleSettle" then
    self.bind.go_moduleHero = true
    self.modules.module_hero:show()
  end
end

return this
