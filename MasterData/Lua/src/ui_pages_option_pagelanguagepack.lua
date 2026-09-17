local this = class("pageLanguagePack", G_UIPageBase)

function this.bind()
  return {
    title = "",
    btnClose = true,
    module_commonTipBoard = L_Const.ModuleInfo.CommonTipBoard,
    list_language = {
      moduleName = "pages/Option/cellLanguage"
    }
  }
end

function this.methods()
  return {
    list_language = {
      onClick = function(self, language, code, id)
        print("目前点击的按钮是：" .. language .. " " .. id)
        self.selectIndexCode = code
        self:refreshList(id)
      end
    },
    onClick_close = function(self)
      L_UI:close(self.pageName, nil, function()
        if self.onClose then
          self.onClose()
        end
      end)
    end,
    onClick_close2 = function(self)
    end,
    oncClick_cancel = function(self)
      L_UI:close(self.pageName)
    end,
    oncClick_delete = function(self)
      local text = L_WordsTpl:getValue("notice_notarizeDelete") .. self:getCodeToText(self.selectIndexCode) .. "?"
      if self.selectIndexCode == L_SettingStore:getSetNumData(L_Const.settingType.language) then
        text = L_WordsTpl:getValue("notice_pageLanguagePack_01")
      elseif self.selectIndexCode == nil then
        text = L_WordsTpl:getValue("notice_pageLanguagePack_02")
      end
      if self.selectIndexCode == L_SettingStore:getSetNumData(L_Const.settingType.language) or not self.selectIndexCode then
        L_FlyMsgManager:showNormalMsg(text)
      else
        L_GameUtil.showCommonTip({
          txtTitle = L_WordsTpl:getValue("notice_pageLanguagePack_03"),
          txtContent = text,
          confirmCallback = function()
            local isOK = L_SettingStore:deleteLangPack(self.selectIndexCode)
            if isOK then
              self:refreshList()
              if self.deleteCallBack then
                self.deleteCallBack(6)
              end
            end
          end
        })
      end
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  self.txtContent = self.bindComponents.txtContent
  self.txtContent2 = self.bindComponents.content2
end

function this:setSortingOrder(order)
  self.bindComponents.csOrder.sortingOrder = order
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:updateOptions(options)
  self:setButtonShow()
end

function this:updateOptions(options)
  options = options or {}
  self.onOK = options.ok
  self.onImmediateOk = options.immediateOk
  self.onCancel = options.cancel
  self.onClose = options.close
  self.onExit = options.exit
  self.showType = L_Const.commonTipsShowType.OkCancel
  self.selectIndexCode = nil
  self.deleteCallBack = options.deleteCallBack
  self.bind.txtOK = options.txtOK or L_WordsTpl:getRawValue("common_window_1")
  self.bind.txtCancel = options.txtCancel or L_WordsTpl:getRawValue("common_window_2")
  self.txtContent.gameObject:ActiveTrans(options.content1 ~= nil)
  self.txtContent2.gameObject:ActiveTrans(options.content2 ~= nil)
  self.bind.title = options.title or L_WordsTpl:getRawValue("notice_title_hint")
  if options.content1 then
    self.txtContent.richText = ""
  end
  if options.content2 then
    self.txtContent2.richText = ""
  end
  if options.showType then
    self.showType = options.showType
  end
  self:refreshList()
end

function this:refreshList(index)
  local tempTable1 = {}
  self.bind.list_language:clear()
  for i, v in ipairs(L_Const.settingText[L_Const.settingType.language]) do
    if L_SettingStore:getIsExistsLangPackByTag(v) then
      local size = "  (" .. L_SettingStore:byteToGBText(L_SettingStore:getLangPackSizeByTag(v)) .. ")"
      local name = self:getCodeToText(v)
      local isUse = v == L_SettingStore:getSetNumData(L_Const.settingType.language)
      local select = index == i
      table.insert(tempTable1, {
        id = i,
        code = v,
        txt_language = name,
        txt_capacity = size,
        txt_using = isUse,
        img_gou = select,
        img_border = select
      })
    end
  end
  if #tempTable1 == 0 then
    self.txtContent2.richText = ""
  else
    self.txtContent2.richText = ""
  end
  self.bind.list_language:insert_array(tempTable1)
end

function this:getCodeToText(code)
  if code == nil then
    return ""
  end
  if not self.mapCode then
    self.mapCode = {
      [C_I18NConst.LanguageChs] = L_WordsTpl:getRawValue("ui_pageLanguagePack_01"),
      [C_I18NConst.LanguageJp] = L_WordsTpl:getRawValue("ui_pageLanguagePack_02"),
      [C_I18NConst.LanguageKr] = L_WordsTpl:getRawValue("ui_pageLanguagePack_03"),
      [C_I18NConst.LanguageEn] = L_WordsTpl:getRawValue("ui_pageLanguagePack_04")
    }
  end
  if self.mapCode[code] then
    return self.mapCode[code]
  else
    return ""
  end
end

function this:setButtonShow()
  if self.showType == L_Const.commonTipsShowType.OkCancel then
    self.bind.btnCancel = true
    self.bind.btnOK = true
    self.bind.btnClose = true
  elseif self.showType == L_Const.commonTipsShowType.OnlyOk then
    self.bind.btnCancel = false
    self.bind.btnOK = true
    self.bind.btnClose = true
  elseif self.showType == L_Const.commonTipsShowType.OnlyCancel then
    self.bind.btnCancel = true
    self.bind.btnOK = false
    self.bind.btnClose = true
  elseif self.showType == L_Const.commonTipsShowType.OnlyClose then
    self.bind.btnCancel = false
    self.bind.btnOK = false
    self.bind.btnClose = true
  end
end

function this:close()
  this.super.close(self)
  if self.onExit then
    self.onExit()
  end
end

function this:escHandle()
  L_UI:close(self.pageName)
  if self.onClose then
    self.onClose()
  end
end

return this
