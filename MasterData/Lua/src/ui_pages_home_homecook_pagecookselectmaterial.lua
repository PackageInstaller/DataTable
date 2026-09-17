local this = class("pageCookSelectMaterial", G_UIPageBase)
local _materialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _itemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    toggle_itemListAlignLeft = false,
    scroll_item = L_Const.ModuleInfo.CellIconBag,
    list_cookItem = L_Const.ModuleInfo.CellIconBag,
    txt_desc = "",
    txtItemName = "",
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self:onClickConfirm()
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    },
    onClickClose = function()
      L_UI:close("pageCookSelectMaterial")
    end,
    onClickBg = function()
      L_UI:close("pageCookSelectMaterial")
    end,
    onClickCancel = function()
      L_UI:close("pageCookSelectMaterial")
    end,
    onClickConfirm = function(self)
      self:onClickConfirm()
    end,
    onClickDetail = function(self)
      local node = self.parentTab
      L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, self._id, nil, node)
    end
  }
end

function this:check(options, callback)
  local isSelfPageShown = L_UI:checkPageShown("pageCookSelectMaterial")
  if isSelfPageShown then
    L_UI:close("pageCookSelectMaterial")
  end
  callback(true)
end

function this:preOpen(options)
  self.parentTab = options.parentTab
  local groupId = options.groupId
  local itemIds = _materialTpl:getGroupItemIds(groupId)
  local dataList = {}
  for i, id in pairs(itemIds) do
    local itemData = {
      callback = function()
        self:onClickItem(id, i)
      end,
      itemType = L_Const.resType.commonItem,
      itemId = id,
      itemNum = C_BagMgr:getItemNumByItemId(id)
    }
    table.insert(dataList, itemData)
  end
  self.bind.list_cookItem:clear()
  self.bind.scroll_item:clear()
  if 5 < #dataList then
    self.bind.scroll_item:insert_array(dataList)
    self.bind.toggle_itemListAlignLeft = true
  else
    self.bind.list_cookItem:insert_array(dataList)
    self.bind.toggle_itemListAlignLeft = false
  end
  self._callback = options.callback
  self:onClickItem(itemIds[options.select], options.select)
  self:initCommonTipModule()
end

function this:open()
  L_UI:addListener(L_UI.pageEvent.showed, self.onUIPageShowed, self)
end

function this:close()
  L_UI:removeListener(L_UI.pageEvent.showed, self.onUIPageShowed, self)
end

function this:onUIPageShowed(pageName)
  if pageName == "pageProduct" then
    L_UI:close("pageCookSelectMaterial")
  end
end

function this:onClickItem(id, rar)
  for i, module in ipairs(self.modules.list_cookItem) do
    module:setSel(id == module.bind.itemId)
  end
  for i, module in ipairs(self.modules.scroll_item) do
    module:setSel(id == module.bind.itemId)
  end
  self._id = id
  self._selectedRar = rar
  local tpl = _itemTpl:getTplById(id)
  self.bind.txt_desc = _itemTpl:getSpecialDesc(tpl)
  self.bind.txtItemName = _itemTpl:getName(tpl)
  self.bindComponents.scrollArea.vertical = self.bindComponents.txtDesc.preferredHeight > self.bindComponents.rectShowArea.rect.height
end

function this:onClickConfirm()
  if self._selectedRar then
    self._callback(self._selectedRar)
    L_UI:close("pageCookSelectMaterial")
  end
end

function this:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("home_product_material_select"),
    txtConfirm = L_WordsTpl:getValue("residual_code_pagehomeproductselectmaterial_01")
  })
end

return this
