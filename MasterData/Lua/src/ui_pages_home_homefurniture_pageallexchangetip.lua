local this = class("pageAllExchangeTip", G_UIPageBase)
local foodTpl = L_GameTpl:getFoodTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    curItemId = nil,
    curNum = 1,
    selectHeroId = nil,
    curFormationType = nil,
    useCondition = {hpOverFlow = false},
    curFoodType = nil,
    curFood = nil
  }
end

function this.bind()
  return {
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip,
    subText = "",
    list_item = L_Const.ModuleInfo.CellIconBag
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
        local itemId = self.optionsData.currencyId
        local itemNum = self.optionsData.totalPrice
        if itemNum > L_PlayerStore:getCurrencyNum(itemId) then
          local showMsg = L_WordsTpl:getValue("notice_homefurniture_shop_nomoney")
          L_FlyMsgManager:showNormalMsg(showMsg)
          return
        end
        if self.optionsData.confirmCallback then
          self.optionsData.confirmCallback()
        end
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.optionsData = options
  self:initCommonTipModule()
  self.bind.subText = options.txtBottomSubContent
  self.bind.list_item:clear()
  self.bind.list_item:insert_array(options.itemList)
end

function this:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  local param = {}
  param.txtTitle = self.optionsData.txtTitle
  moduleTip:initModule(param)
end

return this
