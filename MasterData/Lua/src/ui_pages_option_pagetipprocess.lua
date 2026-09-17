local this = class("pageTipProcess", G_UIPageBase)

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    txt_dec = "",
    txt_percent = "",
    slider_process = nil,
    txt_capacity = ""
  }
end

function this.methods()
  return {
    module_commonTipSmall = {
      onClick_close = function(self)
        if self._params.closeCallbackTemp then
          self._params.closeCallbackTemp()
        end
        self.isStart = false
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        if self._params.cancelCallback then
          self._params.cancelCallback()
        end
        self.isStart = false
        C_PlayerPrefsUtility.SetBool(self.language, false)
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

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:refreshPage(options)
end

function this:refreshPage(params)
  self._params = params or {}
  self.modules.module_commonTipSmall:initModule(params)
  self.capacity = params.capacity or 100
  self.optionID = params.optionID
  self.languageIndex = params.languageIndex or 1
  self.currentSize = 0
  self.isStart = false
  self.success = params.success
  self.showType = L_Const.commonTipsShowType.OkCancel
  self.language = L_Const.settingText[L_Const.settingType.language][tonumber(self.languageIndex)]
  self.bind.txt_dec = L_WordsTpl:getValue("ui_option_down_tips")
  self.bind.txt_percent = " (0%)"
  self:startDownProcess()
  if params.showType then
    self.showType = params.showType
  end
end

function this:startDownProcess()
  self.isStart = true
  self:updateDownProcess()
  self.bind.slider_process = 0
  L_SettingStore:downLangPack(self.languageIndex)
end

function this:updateDownProcess()
  self.currentSize = L_SettingStore:getCurrentLangPackDownSize()
  self.capacity = L_SettingStore:getLangPackSize(self.languageIndex)
  local percent = self.currentSize / self.capacity
  if 1 < percent then
    percent = 1
  end
  self.bind.txt_percent = "(" .. math.floor(percent * 100) .. "%)"
  self.bind.txt_capacity = L_SettingStore:byteToGBText(self.currentSize) .. "/" .. L_SettingStore:byteToGBText(self.capacity)
  self.bind.slider_process = percent
end

function this:update()
  if self.isStart then
    if not L_SettingStore:getIsLangPackDownComplete() then
      self:updateDownProcess()
    else
      self.isStart = false
      C_PlayerPrefsUtility.SetBool(self.language, true)
      L_UI:close(self.pageName, nil, function()
        self.isStart = false
        if self.closeCallbackTemp then
          self.closeCallbackTemp()
        end
        L_GameUtil.showCommonTip({
          txtTitle = L_WordsTpl:getValue("notice_pageTipProcess"),
          txtContent = L_WordsTpl:getValue("ui_option_down_use_tips"):gsub("{language}", L_SettingStore:getSelectLangText()),
          confirmCallback = function()
            if self.success then
              self.success(self.optionID, self.languageIndex, L_SettingStore:getSelectLangText())
            end
          end
        })
      end)
    end
  end
end

function this:close()
  this.super.close(self)
  if self._params.pageClosedCallback then
    self._params.pageClosedCallback()
  end
end

function this:escHandle()
  if self._params.closeCallbackTemp then
    self._params.closeCallbackTemp()
  end
  L_UI:close(self.pageName)
end

return this
