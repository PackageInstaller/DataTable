local this = class("moduleShopGroupMenu", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {selectType = nil, checkTypeFunc = nil}
end

function this.bind()
  return {
    scrollList_type = {
      moduleName = "pages/MoneyShop/cellShopBtn"
    }
  }
end

function this.methods()
  return {
    scrollList_type = {
      onClickSelect = function(self, type)
        self.data.checkTypeFunc(type)
        self.data.selectType = type
        self:setTypeListActive()
      end
    }
  }
end

function this:open()
  this.super.open(self)
end

function this:close()
  this.super.close(self)
end

function this:initModule(typeList, defaultSelectType, func)
  self.data.checkTypeFunc = func
  self.data.selectType = defaultSelectType
  self:initTypeList(typeList)
  self:setTypeListActive()
end

function this:initTypeList(typeList)
  local tmp = {}
  local commonItemTypeIconTpl = L_GameTpl:getShopGroupTpl()
  for i, v in pairs(typeList) do
    local tpl = commonItemTypeIconTpl:getTplById(v.shopGroupId)
    local icon = ""
    if tpl ~= nil then
      icon = commonItemTypeIconTpl:getShopIcon(tpl)
    end
    table.insert(tmp, {
      commondId = v.shopGroupId,
      shopNameShow = v.shopName,
      shopNameOut = v.shopName,
      shopImageShow = icon,
      shopImageOut = icon
    })
  end
  self.bind.scrollList_type:clear()
  self.bind.scrollList_type:insert_array(tmp)
end

function this:setTypeListActive()
  for i = 1, #self.bind.scrollList_type do
    local active = false
    local commondId = self.bind.scrollList_type:getValue(i, "commondId")
    if commondId == self.data.selectType then
      active = true
    end
    self.bind.scrollList_type:change(i, {
      isActive = active,
      isNomarl = not active
    })
  end
end

return this
