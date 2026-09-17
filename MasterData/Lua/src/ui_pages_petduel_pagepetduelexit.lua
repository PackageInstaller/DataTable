local this = class("pagePetDuelExit", G_UIPageBase)
local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local commonConditionTpl = L_GameTpl:getCommonConditionTpl()

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    targetList = {
      moduleName = "pages/petDuel/cellDuelTarget"
    },
    txtContent = ""
  }
end

function this.methods()
  return {
    onClick_setting = function(self)
      CS.Lens.Gameplay.Setting.GameSettingUtil.OpenPageOptionCoexist()
    end,
    module_commonTipSmall = {
      onClick_close = function(self)
        if self._params.closeCallbackTemp then
          self._params.closeCallbackTemp()
        end
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        if self._params.cancelCallback then
          self._params.cancelCallback()
        end
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        if self._params.confirmCallback then
          self._params.confirmCallback()
        end
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:refreshPage(options)
  if options and options.isFull then
    self.bindComponents.blur.enabled = true
  end
end

function this:refreshPage(params)
  self._params = params or {}
  self.modules.module_commonTipSmall:initModule(self._params)
  if not params then
    return
  end
  local duelId = params.duelId
  local tpl = kiBoDuelTpl:getTplById(duelId)
  local duelTime = kiBoDuelTpl:getTime(tpl)
  self.bind.txtContent = L_WordsTpl:getValue("notice_kibo_duel_in_battle_11")
end

function this:close()
  this.super.close(self)
  if self._params.pageClosedCallback then
    self._params.pageClosedCallback()
  end
end

function this:escHandle()
  if self._params and self._params.closeCallbackTemp then
    self._params.closeCallbackTemp()
  end
  L_UI:close(self.pageName)
end

return this
