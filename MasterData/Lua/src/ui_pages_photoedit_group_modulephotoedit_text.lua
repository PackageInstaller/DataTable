local this = class("modulePhotoEdit_text", require("ui.pages.photoEdit.group.modulePhotoEdit_base"))
local photographTextTpl = L_GameTpl:getPhotographTextTpl()
local fontInfo = {
  [1] = "sdf_a00",
  [2] = "sdf_b00"
}
local defaultText = L_WordsTpl:getValue("residual_code_modulephotoedit_text_01")

function this.bind()
  return {
    colorList = {
      moduleName = "pages/photoEdit/cellPhotoEditColorTab"
    },
    curColorId = 0,
    tabList = {
      moduleName = "pages/photoEdit/cellPhotoEditTab"
    },
    subList = {
      moduleName = "pages/photoEdit/cellPhotoEditTab"
    },
    modulePhotoTextHandle = {
      moduleName = "pages/photoEdit/modulePhotoTextHandle"
    },
    txt_subTitle = "",
    curTabId = 0,
    curSubTabId = 0,
    color_text = C_Color.white,
    color_bg = C_Color.white,
    isActive_bg = false,
    txt_content = defaultText,
    rayCast = false,
    active_subTab = nil
  }
end

function this.methods()
  return {
    onSelectColor = function(self, id)
      if self.curTabId == 1 then
        if id == self.curTextColorId then
          return
        end
        self.curTextColorId = id
      elseif self.curTabId == 2 then
        if id == self.curBgColorId then
          return
        end
        self.curBgColorId = id
      end
      self:onSelectColor(self.colorDict[id].color)
    end,
    onSelectTab = function(self, id)
      if id == self.curTabId then
        return
      end
      self.curTabId = id
      self:onSwitchTab(id)
    end,
    onSelectSub = function(self, id)
      if self.curTabId == 1 then
        if id == self.curTextSubTabId then
          return
        end
        self.curTextSubTabId = id
        self:onSelectFont(id)
      elseif self.curTabId == 2 then
        if id == self.curBgSubTabId then
          return
        end
        self.curBgSubTabId = id
        self:onSwitchBg(id)
      end
    end,
    modulePhotoTextHandle = {
      onClickDel = function(self)
        self.textRoot.gameObject:SetActive(false)
        if self.onClick_deleteCallBack then
          self.onClick_deleteCallBack()
        end
      end
    }
  }
end

function this:initParam(params)
  this.super.initParam(self, params)
  self:syncPhotoMask()
  self.curTabId = 1
  self:initTab()
  self.bind.curTabId = 1
  self:initSubTab()
  self:initColorList()
  self:moveTextRoot()
  self:reset()
end

function this:reset()
  self.textRoot.gameObject:SetActive(true)
  self.curTabId = 1
  self.curTextSubTabId = 1
  self.curBgSubTabId = 2
  self.bind.isActive_bg = true
  self.bind.curTabId = 1
  self.curTextColorId = 2
  self.curBgColorId = 1
  self.bind.color_text = self.colorDict[2].color
  self.bind.color_bg = self.colorDict[1].color
  self.bind.curSubTabId = 1
  self.bind.curColorId = 2
  self.bind.txt_content = defaultText
  self.textRoot.rotation = C_Quaternion.identity
  self:onSelectFont(1)
  self.modules.modulePhotoTextHandle:bindTextRect(self.textRoot, self.bindComponents.textContent, self.bindComponents.bgRect)
end

function this:show()
  self:syncPhotoMask()
  if self.isInit and not self.textRoot.gameObject.activeSelf then
    self:reset()
  end
  self.bind.rayCast = true
  self.modulePhotoTextHandle:setActive(true)
end

function this:hide()
  self.modulePhotoTextHandle:setActive(false)
  self.bind.rayCast = false
end

function this:open()
  self.colorDict = {}
  for i, v in pairs(photographTextTpl.data) do
    local colorText = photographTextTpl:getTextColor(v)
    local enText = photographTextTpl:getText(v)
    local r, color = C_ColorUtility.TryParseHtmlString("#" .. colorText)
    self.colorDict[i] = {color = color, enText = enText}
  end
  self.textRoot = self.bindComponents.textComponent
  self.modulePhotoTextHandle = self.modules.modulePhotoTextHandle
end

function this:moveTextRoot()
  self.textRoot:SetParent(self.photoMask.transform)
  self.textRoot:SetAsLastSibling()
  self.textRoot.anchoredPosition = C_Vector2.zero
  self.textRoot.localScale = C_Vector3.one
  self.modulePhotoTextHandle.gameObject.transform:SetParent(self.imgRoot)
end

function this:initTab()
  local info = {
    {
      tabId = 1,
      txt_name = L_WordsTpl:getValue("notice_photo_edit_word"),
      txt_nameOff = L_WordsTpl:getValue("notice_photo_edit_word"),
      tabGroup = self.bindComponents.tabGroup,
      isTextTab1 = true
    },
    {
      tabId = 2,
      txt_name = L_WordsTpl:getValue("notice_photo_edit_background"),
      txt_nameOff = L_WordsTpl:getValue("notice_photo_edit_background"),
      tabGroup = self.bindComponents.tabGroup
    }
  }
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(info)
end

function this:initSubTab()
  self.bind.active_subTab = true
  self.bind.subList:clear()
  local info
  if self.curTabId == 0 or self.curTabId == nil then
    self.curTabId = 1
  end
  if self.curTabId == 1 then
    info = {
      {
        tabId = 1,
        txt_name = L_WordsTpl:getValue("notice_photo_edit_font_1"),
        txt_nameOff = L_WordsTpl:getValue("notice_photo_edit_font_1"),
        font = fontInfo[1]
      },
      {
        tabId = 2,
        txt_name = L_WordsTpl:getValue("notice_photo_edit_font_2"),
        txt_nameOff = L_WordsTpl:getValue("notice_photo_edit_font_2"),
        font = fontInfo[2]
      }
    }
    self.bind.txt_subTitle = L_WordsTpl:getValue("notice_photo_edit_font")
    if L_DeviceTpl:getIsMobile() then
      self.bind.active_subTab = false
    end
  elseif self.curTabId == 2 then
    info = {
      {
        tabId = 1,
        txt_name = L_WordsTpl:getValue("notice_photo_edit_hide"),
        txt_nameOff = L_WordsTpl:getValue("notice_photo_edit_hide")
      },
      {
        tabId = 2,
        txt_name = L_WordsTpl:getValue("notice_photo_edit_show"),
        txt_nameOff = L_WordsTpl:getValue("notice_photo_edit_show")
      }
    }
    self.bind.txt_subTitle = L_WordsTpl:getValue("notice_photo_edit_background")
  end
  for i, v in pairs(info) do
    v.tabGroup = self.bindComponents.subTabGroup
  end
  self.bind.subList:insert_array(info)
end

function this:initColorList()
  local list = {}
  for i, v in pairs(self.colorDict) do
    local temp = {
      tabId = i,
      color = v.color,
      enText = v.enText,
      tabGroup = self.bindComponents.colorTabGroup
    }
    table.insert(list, temp)
  end
  self.bind.colorList:clear()
  self.bind.colorList:insert_array(list)
end

function this:onSelectColor(color)
  if self.curTabId == 1 then
    self.bind.color_text = color
  elseif self.curTabId == 2 then
    self.bind.color_bg = color
  end
end

function this:onSwitchTab(id)
  self:initSubTab()
  if id == 1 then
    self.bind.curSubTabId = self.curTextSubTabId
    self.bind.curColorId = self.curTextColorId
  elseif id == 2 then
    self.bind.curSubTabId = self.curBgSubTabId
    self.bind.curColorId = self.curBgColorId
  end
end

function this:onSelectFont(id)
  local name = fontInfo[id]
  if name ~= nil then
    self.bindComponents.textContent:SetFontAsset(name)
  end
end

function this:onSwitchBg(id)
  if id == 1 then
    self.bind.isActive_bg = false
  elseif id == 2 then
    self.bind.isActive_bg = true
  end
end

function this:onSave()
  self.modulePhotoTextHandle:setActive(false)
end

function this:close()
  self.super.close(self)
end

return this
