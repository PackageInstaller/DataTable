local this = class("pageBagUseSelectGift", G_UIPageBase)
local _commonItemChangeTpl = L_GameTpl:getCommonItemChangeTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    cell_before = L_Const.ModuleInfo.CellIconBag,
    cell_after = L_Const.ModuleInfo.CellIconBag,
    module_selectNum = L_Const.ModuleInfo.SelectNum,
    txt_name_before = "",
    txt_name_after = "",
    img_icon = nil,
    txt_amount = "",
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
        if self._itemType == L_Const.resType.currency and self._itemId == L_Const.currencyType.tiedDiamond then
          local isUnlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.payToFreeExchangeSystem)
          if not isUnlock then
            return
          end
        end
        L_UI:close(self.pageName, nil, function()
          local data = {
            itemType = self._itemType,
            itemId = self._itemId,
            itemNum = self._selectNum
          }
          C_BagMgr:reqExchangeItem(data)
        end)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._itemType = options.itemType or L_Const.resType.commonItem
  self._itemId = options.itemId
  self:initPage()
end

function this:initPage()
  self.modules.cell_before:setGeneralContent(self._itemType, self._itemId)
  local tpl_change = _commonItemChangeTpl:getTplByTypeAndId(self._itemType, self._itemId)
  local reward = L_DataUtil.parseRewardConfigItem(_commonItemChangeTpl:getChange(tpl_change)[1])
  self.modules.cell_after:setGeneralContent(reward.itemType, reward.itemId)
  local param = {}
  param.txtTitle = _commonItemChangeTpl:getTitle(tpl_change)
  param.txtConfirm = L_WordsTpl:getValue("ui_pageMallBuyTip_exchange_btntext")
  self.modules.moduleCommonTipMedium:initModule(param)
  local beforeConf = L_ItemTplManager:getItemConfig(self._itemType, self._itemId)
  self.bind.txt_name_before = beforeConf.name
  self.bind.img_icon = beforeConf.icon
  local afterConf = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self.bind.txt_name_after = afterConf.name
  local max = math.floor(L_ItemTplManager:getItemNum(self._itemType, self._itemId) / _commonItemChangeTpl:getItemNum(tpl_change))
  local debtNum = 0
  if C_BagMgr then
    debtNum = C_BagMgr:GetDebtNum(L_Const.currencyType.diamond)
  end
  if 0 < debtNum and 0 < reward.itemNum then
    self._selectNum = math.min(math.ceil(debtNum / reward.itemNum), max)
  else
    self._selectNum = max
  end
  
  local function func(num)
    self._selectNum = num
    self:changeNum()
  end
  
  self.modules.module_selectNum:initModule(func, max, 1, self._selectNum)
  func(self._selectNum)
end

function this:changeNum()
  self.modules.cell_before:setNumInfo(self._selectNum)
  local tpl_change = _commonItemChangeTpl:getTplByTypeAndId(self._itemType, self._itemId)
  local reward = L_DataUtil.parseRewardConfigItem(_commonItemChangeTpl:getChange(tpl_change)[1])
  self.modules.cell_after:setNumInfo(reward.itemNum * self._selectNum)
  self.bind.txt_amount = string.format("x%d", self._selectNum)
end

return this
