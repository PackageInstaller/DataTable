local page = class("pageMoneyShop", G_UIPageBase)
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _shopTpl = L_GameTpl:getShopTpl()
local _systemTpl = L_GameTpl:getSystemUnlockTpl()

function page.bind()
  return {
    txtName = "",
    scrollListTypeList = {
      moduleName = "pages/moneyShop/cellTypeBtn"
    },
    scrollListShopList = {
      moduleName = "pages/moneyShop/cellShopBtn"
    },
    moduleShopTypeMenu = {
      moduleName = "pages/moneyShop/moduleShopTypeMenu"
    },
    moduleShopGroupMenu = {
      moduleName = "pages/moneyShop/moduleShopGroupMenu"
    },
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    toggleModuleBar = {
      type = "toggleModule",
      moduleMShopCell = {
        assetName = "UI/Pages/MoneyShop/moduleMShopCell",
        moduleName = "pages/moneyShop/moduleMShopCell"
      }
    },
    toggleModuleName = ""
  }
end

function page.methods()
  return {
    onClickBack = function(self)
      L_UI:close(self.pageName)
    end,
    onClickMain = function(self)
      L_UI:backToRoot()
    end
  }
end

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {
    canRefreshBuyTimes = false,
    npcVirtualCamera = nil,
    resetCam = nil,
    goodsList = {},
    curShopId = nil,
    shopRefreshTimer = nil,
    selShopGrouId = -1,
    selShopId = -1
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  if options and options.jumpParams then
    options.shopId = tonumber(options.jumpParams[1])
  end
  self:refresh(options)
end

function page:refresh(options)
  if options ~= nil and options.shopId ~= nil then
    self.data.selShopId = options.shopId
    self.data.selShopGrouId = _shopTpl:getGroupId(_shopTpl:getTplById(options.shopId))
  end
  self:initShopGroupMenu()
end

function page:close(options)
end

function page:initPage()
  local dataTpl = _shopTpl:getTplById(self.data.selShopId)
  if dataTpl == nil then
    return
  end
  self.bind.txtName = L_WordsTpl:getValue("ui_moneyshop_returntitle")
end

function page:initShopGroupMenu()
  local shopGroupTpl = L_GameTpl:getShopGroupTpl()
  if not shopGroupTpl or not shopGroupTpl.data then
    print("[PAGE ERROR pageMoneyShop] ShopGroup Is Nil Or ShopGroupTpl.data Is Nil")
    return
  end
  local groupList = {}
  for _, v in pairs(shopGroupTpl.data) do
    if v.isMall then
      local tplData = v
      if self:checkShopGroupTab(tplData) then
        if self.data.selShopGrouId < 0 then
          self.data.selShopGrouId = shopGroupTpl:getShopGroupId(tplData)
          self.data.curShopId = shopGroupTpl:getShopGroupId(tplData)
        end
        table.insert(groupList, {
          shopGroupId = shopGroupTpl:getShopGroupId(tplData),
          shopName = shopGroupTpl:getShopGroupName(tplData),
          shopIcon = shopGroupTpl:getShopIcon(tplData)
        })
      end
    end
  end
  if #groupList <= 0 then
    return
  end
  
  local function func(selectID)
    self.data.selShopGrouId = selectID
    self.data.curShopId = selectID
    self:initSecondList(selectID)
  end
  
  func(self.data.selShopGrouId)
  self.modules.moduleShopGroupMenu:initModule(groupList, self.data.selShopGrouId, func)
end

function page:checkShopGroupTab(tplData)
  local shopGroupTpl = L_GameTpl:getShopGroupTpl()
  for _, v in pairs(shopGroupTpl:getShopList(tplData)) do
    local tpl_sys = _systemTpl:getTplByTab(L_SystemConst.enum.shop, v)
    if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(_systemTpl:getId(tpl_sys)) then
      return true
    end
  end
  return false
end

function page:initSecondList(selectID)
  local shopGroupTpl = L_GameTpl:getShopGroupTpl()
  local tplData = shopGroupTpl:getTplById(selectID)
  local groupList = {}
  local firstShopId = -1
  local isChange = true
  for _, v in pairs(shopGroupTpl:getShopList(tplData)) do
    local tpl_sys = _systemTpl:getTplByTab(L_SystemConst.enum.shop, v)
    if _systemTpl:getButtonShow(tpl_sys) or C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(_systemTpl:getId(tpl_sys)) then
      local sTplData = _shopTpl:getTplById(v)
      if sTplData ~= nil then
        if self.data.selShopId == v then
          isChange = false
        end
        if firstShopId < 0 then
          firstShopId = v
        end
        table.insert(groupList, {
          shopGroupId = v,
          shopName = _shopTpl:getShopName(sTplData)
        })
      end
    end
  end
  if isChange then
    self.data.selShopId = firstShopId
  end
  
  local function func(selectID)
    local tpl_sys = _systemTpl:getTplByTab(L_SystemConst.enum.shop, selectID)
    self.data.selShopId = selectID
    self:initSecondModulePage()
    self:showCurrencyModule()
    self:initPage()
  end
  
  func(self.data.selShopId)
  self.modules.moduleShopTypeMenu:initModule(groupList, self.data.selShopId, func)
end

function page:showCurrencyModule()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplByTab(L_SystemConst.enum.shop, self.data.selShopId)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
end

function page:initSecondModulePage()
  self.bind.toggleModuleName = "moduleMShopCell"
  self.modules.toggleModuleBar.moduleMShopCell:initModule(self.data.selShopId)
end

function page:check(options, callback)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.MoneyShop, true) then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.shop)
  callback(result)
end

return page
