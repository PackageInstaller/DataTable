local this = class("pageStarManual", G_UIPageBase)
local starManualTpl = L_GameTpl:getStarManualTpl()
local starManualLevelTpl = L_GameTpl:getStarManualLevelTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    starManual_list = {
      moduleName = "pages/StarManual/cellDungeonItem"
    },
    module_currency = {
      moduleName = "modulePages/moduleCurrency"
    },
    starManualModule = {
      type = "toggleModule",
      moduleDungeonList = {
        assetName = "UI/Pages/StarManual/Modules/moduleDungeonList",
        moduleName = "pages/starManual/moduleDungeonList"
      },
      moduleStarManualBoss = {
        assetName = "UI/Pages/StarManual/Modules/moduleStarManualBoss",
        moduleName = "pages/starManual/moduleStarManualBoss"
      }
    },
    starManualModuleName = "",
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_home = function(self)
      L_UI:backToRoot()
    end,
    starManual_list = {
      onClick = function(self, data)
        print("当前活动：", data.starManualId)
        self:refreshStarManualList(data.starManualId)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  if options ~= nil and options.starManualId ~= nil then
    self.starManualId = options.starManualId
  end
  self:initPage()
end

function this:open()
end

function this:close(options)
  this.super.close(self, options)
end

function this:initPage()
  local starManualData = starManualTpl:getAllData()
  self:initCurrencyList()
  local data = {
    name = L_WordsTpl:getValue("ui_pageStarManual"),
    helpBtnBool = false,
    mainBtnBool = true,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end,
    helpBtn = function()
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.closeCurPageFunc = nil
  self.modules.moduleCommonTop:initModule(data)
  self.allData = {}
  for i, v in ipairs(starManualData) do
    local can_insert = false
    if not math.isEmpty(v.show) then
      can_insert = v.show == 1
    end
    if can_insert == true then
      table.insert(self.allData, {
        name = starManualTpl:getName(v),
        order = starManualTpl:getOrder(v),
        name_selected = starManualTpl:getName(v),
        systemId = starManualTpl:getUnlock(v) or 0,
        lock = not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(starManualTpl:getUnlock(v)),
        module_function = L_Const.starManualModuleType[starManualTpl:getId(v)],
        starManualId = starManualTpl:getId(v),
        isEnd = false
      })
    end
  end
  self.bind.starManual_list:clear()
  if #self.allData > 0 then
    if #self.allData > 1 then
      table.sort(self.allData, function(a, b)
        if a.lock == b.lock then
          return a.order < b.order
        elseif a.lock == false then
          return true
        else
          return false
        end
      end)
    end
    self.allData[#self.allData].isEnd = true
    self.bind.starManual_list:insert_array(self.allData)
    self.starManualId = self.starManualId or self.allData[1].starManualId
    self:refreshStarManualList(self.starManualId)
  end
end

function this:refreshStarManualList(starManualId)
  for i = 1, #self.bind.starManual_list do
    if self.bind.starManual_list:getValue(i, "starManualId") == starManualId then
      self.bind.starManual_list:change(i, {show_selected_icon = true})
      local moduleName = self.bind.starManual_list:getValue(i, "module_function")
      self:initModulePage(moduleName, starManualId)
    else
      self.bind.starManual_list:change(i, {show_selected_icon = false})
    end
  end
end

function this:initModulePage(moduleName, starManualId)
  self.bind.starManualModuleName = moduleName
  local data = {id = starManualId}
  self.modules.starManualModule[moduleName]:initPage(data)
end

function this:initCurrencyList()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.starManual)
  self.modules.module_currency:refreshRes(tpl_sys)
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.starManual)
  callback(result)
end

return this
