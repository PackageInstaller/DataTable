local this = class("pageCommonTextBox", G_UIPageBase)

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    txt_tip = nil,
    txt_renamePlaceHolder = nil,
    txt_renameContent = nil,
    txt_signaturePlaceHolder = nil,
    txt_signatureContent = nil,
    txt_pureNumberPlaceHolder = nil,
    txt_pureNumberContent = nil,
    txt_serverLinePlaceHolder = nil,
    txt_serverLineContent = nil,
    txt_serverLineTip = nil,
    active_txt_rename = false,
    active_txt_signature = false,
    active_txt_pureNumber = false,
    active_txt_serverLine = false,
    sortingOrder_page = nil,
    active_edit_icon = true
  }
end

function this.methods()
  return {
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
          local txt
          if self._params.textBoxType == L_Const.CommonTextBoxType.Rename then
            txt = self.bindComponents.Input_text_rename.text
          elseif self._params.textBoxType == L_Const.CommonTextBoxType.Signature then
            txt = self.bindComponents.Input_text_signature.text
          elseif self._params.textBoxType == L_Const.CommonTextBoxType.PureNumber then
            txt = self.bindComponents.Input_text_pureNumber.text
          elseif self._params.textBoxType == L_Const.CommonTextBoxType.MultiPlayerCityLine then
            txt = self.bindComponents.Input_text_serverLine.text
          end
          self._params.confirmCallback(txt)
          if self.clearText then
            self.bindComponents.Input_text_rename.text = ""
            self.bindComponents.Input_text_signature.text = ""
            self.bindComponents.Input_text_pureNumber.text = ""
            self.bindComponents.Input_text_serverLine.text = ""
          end
          if not self.keepPageOpen then
            L_UI:close(self.pageName)
          end
        end
      end,
      onClick_bg = function(self)
        if not self.ignoreBgClose then
          L_UI:close(self.pageName)
        end
      end
    },
    onValueChanged_renameInput = function(self, value)
      if not self.limit or self.limit <= 0 then
        return
      end
      if self.notNewLine then
        local valueS = string.gsub(value, "\n", "")
        valueS = string.gsub(valueS, "\r", "")
        if valueS and valueS ~= value then
          self.bindComponents.Input_text_rename.text = valueS
          return
        end
      end
      local filterValue = CS.Lens.Framework.UI.LTextMeshProUtilty.UnicodeWhiteFilter(value, self.unicodeWhiteLevel or 1)
      if string.len(value) > self.limit then
        self.bindComponents.Input_text_rename.text = C_LuaUtility.StringSub(filterValue, 0, self.limit)
      elseif filterValue ~= value then
        self.bindComponents.Input_text_rename.text = filterValue
      end
    end,
    onValueChanged_signatureInput = function(self, value)
      if not self.limit or self.limit <= 0 then
        return
      end
      local filterValue = CS.Lens.Framework.UI.LTextMeshProUtilty.UnicodeWhiteFilter(value, self.unicodeWhiteLevel or 0)
      if C_LuaUtility.StringLength(value) > self.limit then
        self.bindComponents.Input_text_signature.text = C_LuaUtility.StringSub(filterValue, 0, self.limit)
      elseif filterValue ~= value then
        self.bindComponents.Input_text_signature.text = filterValue
      end
    end,
    onValueChanged_pureNumberInput = function(self, value)
      if string.find(value, "-") then
        value = string.gsub(value, "-", "")
        self.bindComponents.Input_text_pureNumber.text = value
      end
      if not self.limit or self.limit <= 0 then
        return
      end
      if C_LuaUtility.StringLength(value) > self.limit then
        self.bindComponents.Input_text_pureNumber.text = C_LuaUtility.StringSub(value, 0, self.limit)
      end
    end,
    onValueChanged_serverLineInput = function(self, value)
      if not self.limit or self.limit <= 0 then
        return
      end
      if tonumber(value) == nil then
        self.bindComponents.Input_text_serverLine.text = ""
      else
        value = tonumber(value)
        if value < 1 then
          self.bindComponents.Input_text_serverLine.text = "1"
        elseif value > self.limit then
          self.bindComponents.Input_text_serverLine.text = tostring(self.limit)
        end
      end
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:refreshPage(options)
end

function this:refreshPage(params)
  self._params = params or {}
  self.modules.module_commonTipSmall:initModule(params)
  if params.textBoxType == L_Const.CommonTextBoxType.Rename then
    self.bind.active_txt_rename = true
    self.bind.txt_renamePlaceHolder = params.placeHolder
    self.bind.txt_renameContent = params.txtContent
    self.bind.txt_tip = params.tip or ""
  elseif params.textBoxType == L_Const.CommonTextBoxType.Signature then
    self.bind.active_txt_signature = true
    self.bind.txt_signaturePlaceHolder = params.placeHolder
    self.bind.txt_signatureContent = params.txtContent
  elseif params.textBoxType == L_Const.CommonTextBoxType.PureNumber then
    self.bind.active_txt_pureNumber = true
    self.bind.txt_pureNumberPlaceHolder = params.placeHolder
    self.bind.txt_pureNumberContent = params.txtContent
    self.bind.active_edit_icon = params.active_edit_icon
  elseif params.textBoxType == L_Const.CommonTextBoxType.MultiPlayerCityLine then
    self.bind.active_txt_serverLine = true
    self.bind.txt_serverLinePlaceHolder = params.placeHolder
    self.bind.txt_serverLineContent = params.txtContent
    self.bind.txt_serverLineTip = params.tip or ""
  end
  self.unicodeWhiteLevel = params.unicodeWhiteLevel
  if params.textBoxType == L_Const.CommonTextBoxType.MultiPlayerCityLine then
    self.limit = params.limit and params.limit or 0
  else
    self.limit = params.limit and params.limit * 2 or 0
  end
  self.notNewLine = params.notNewLine
  self.keepPageOpen = params.keepPageOpen
  self.ignoreBgClose = params.ignoreBgClose
  self.clearText = params.clearText
  if not math.isEmpty(params.overrideSortingOrder) then
    self.bind.sortingOrder_page = params.overrideSortingOrder
  end
  if self._params.pageOpenCallback then
    self._params.pageOpenCallback()
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
