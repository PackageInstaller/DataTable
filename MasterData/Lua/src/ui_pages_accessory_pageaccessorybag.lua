local this = class("pageAccessoryBag", G_UIPageBase)
local TYPE_ICON = {
  [L_AccessoryConst.accessoryType.weapon] = "UI/Atlas/Accessory/tex_sidebar_btn_wuqi.png",
  [L_AccessoryConst.accessoryType.coat] = "UI/Atlas/Accessory/tex_sidebar_btn_yifu.png",
  [L_AccessoryConst.accessoryType.pants] = "UI/Atlas/Accessory/tex_sidebar_btn_kuzi.png",
  [L_AccessoryConst.accessoryType.earring] = "UI/Atlas/Accessory/tex_sidebar_btn_erhuan.png",
  [L_AccessoryConst.accessoryType.ring] = "UI/Atlas/Accessory/tex_sidebar_btn_jiezhi.png"
}

function this.bind()
  return {
    nodule_accessoryMenu = {
      moduleName = "modulePages/moduleMenu"
    },
    module_commonTop = L_Const.ModuleInfo.CommonTop,
    module_content = {
      moduleName = "pages/accessory/moduleAccessoryBagContent"
    },
    module_content_pc = {
      moduleName = "pages/accessory/moduleAccessoryBagContent"
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._selectType = options.accessoryType
  self._selectHeroGuid = options.selectHeroGuid
  self.onEvent_refreshAccessoryListHandle = handler(self, self.onEvent_refreshAccessoryList)
  C_BagEvent.instance:Listen(C_EBagEvent.AccessoryPartChange, self.onEvent_refreshAccessoryListHandle)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
  C_BagEvent.instance:Cancel(C_EBagEvent.AccessoryPartChange, self.onEvent_refreshAccessoryList)
end

function this:initPage()
  self:initAccessoryMenu()
  self:initCommonTopModule()
  self:getContentModule():setData(self._selectHeroGuid, self._selectType)
end

function this:initCommonTopModule()
  local data = {
    name = L_WordsTpl:getValue("residual_code_pageaccessorybag_01"),
    closeCurPage = function()
      L_UI:close(self.pageName)
    end
  }
  self.modules.module_commonTop:initModule(data)
end

function this:initAccessoryMenu()
  local typeList = {
    L_AccessoryConst.accessoryType.weapon,
    L_AccessoryConst.accessoryType.coat,
    L_AccessoryConst.accessoryType.pants,
    L_AccessoryConst.accessoryType.earring,
    L_AccessoryConst.accessoryType.ring,
    L_AccessoryConst.accessoryType.shoes
  }
  local menuList = {}
  for i, v in pairs(typeList) do
    table.insert(menuList, {
      type = v,
      icon = TYPE_ICON[v]
    })
  end
  
  local function func(selectType)
    self._selectType = selectType
    self:getContentModule():setData(self._selectHeroGuid, self._selectType)
  end
  
  self.modules.nodule_accessoryMenu:initModule(menuList, self._selectType, func)
end

function this:onEvent_refreshAccessoryList(isDelete)
  if isDelete then
    self:getContentModule():updateAccessoryList()
  end
end

function this:getContentModule()
  if L_DeviceTpl:getIsPc() then
    return self.modules.module_content_pc
  else
    return self.modules.module_content
  end
end

return this
