local page = class("pageStamina", G_UIPageBase)
local staminaTp = L_GameTpl:getStaminaTpl()
local staminaId = 100000
local wordsTpl = L_GameTpl:getWordsTpl()

function page.bind()
  return {
    go_buy = true,
    toggleProp = true,
    toggleBuy = false,
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    go_tipMain = false,
    txtTipMain = "",
    go_tipSub = false,
    txtTipSub = "",
    txt_time = "",
    moduleIconProp = {
      moduleName = "pages/stamina/cellStaminaItem"
    },
    moduleIconBuy = {
      moduleName = "pages/stamina/cellStaminaItem"
    },
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function page.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self._isBuyMode = self._allowDiamond and self.buyNum < self.max
        self._isUseMode = not self._isBuyMode and self.bind.toggleProp == true
        if self._isBuyMode then
          if self.maxStamina then
            L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_stamina_limit"))
            return
          end
          if not self.cost then
            L_FlyMsgManager:showNormalMsgByKey("notice_stamina_nomoney", {
              [0] = self.moneyName
            })
            return
          end
          if self.buyNum < self.max then
            L_PlayerStore:req_buyStamina(nil, function()
            end)
            local data = {
              {
                itemtype = L_Const.resType.currency,
                itemid = L_Const.currencyType.stamina,
                itemnum = self.staminaNum
              }
            }
            L_RewardManager:showPage(data)
          end
        elseif self._isUseMode then
          self:staminaUse()
        end
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.staminaNum = 0
  self.max = staminaTp:getMax()
  self.staminaLimit = tonumber(L_GameTpl:getGameConstTpl():getTplById("STAMINA_LIMIT"))
  self.staminaItem = L_ItemManager:parseCommonItem(staminaId)
  local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
  self.autoMax = playerLevelTpl:getStamina(playerLevelTpl:getTplById(L_PlayerStore:getLv()))
  self.maxStamina = false
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.stamina)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
  if tonumber(L_GameTpl:getGameConstTpl():getTplById("STAMINA_SWITCH")) == 1 then
    self._allowDiamond = true
  elseif tonumber(L_GameTpl:getGameConstTpl():getTplById("STAMINA_SWITCH")) == 0 then
    self._allowDiamond = false
  end
  L_PlayerStore:req_SyncStamina()
  self:initPage()
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.syncAttrInfoComplete, self.initPage, self)
end

function page:close(options)
  page.super.close(self, options)
  self:disposeTimer()
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.syncAttrInfoComplete, self.initPage, self)
end

function page:disposeTimer()
  if self._timer then
    self._timer:destroy()
    self._timer = nil
  end
end

function page:initPage()
  self.curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
  self.buyNum = L_PlayerStore:getCurrencyNum(L_Const.currencyType.staminaBuyTimes)
  self.time = L_PlayerStore:getCurrencyNum(L_Const.currencyType.staminaBuyTimeStamp)
  if C_BagMgr:getItem(staminaId) then
    self.propItemNum = C_BagMgr:getItem(staminaId).itemNum
  else
    self.propItemNum = 0
  end
  self:disposeTimer()
  local scale, minus, limit = L_PlayerStore:getMinuOrScale()
  
  local function func()
    if L_PlayerStore:getMinuOrScale() and self.curStamina < self.autoMax then
      self.bind.txt_time = L_WordsTpl:getValue("ui_pageStamina_02", {
        [0] = L_TimeUtil.secondToString(minus, 2),
        [1] = L_TimeUtil.secondToString((limit - self.curStamina - 1) * scale + minus, 2)
      })
      minus = math.max(0, minus - 1)
      if minus == 0 then
        L_PlayerStore:req_SyncStamina()
      end
    else
      self:disposeTimer()
      self.bind.txt_time = L_WordsTpl:getValue("residual_code_pagestamina_01")
    end
  end
  
  func()
  self._timer = Timer.repeated(1, func)
  self.selectIcon = L_StaminaManager:getSelectId()
  if self.selectIcon == 1 and self.propItemNum <= 0 then
    self.selectIcon = 2
  end
  self.modules.moduleIconProp:setGeneral(L_Const.resType.commonItem, staminaId, {
    itemNum = self.propItemNum,
    callback = function()
      self.bind.toggleProp = true
      L_StaminaManager:setSelectId(1)
      self:initProp()
      L_ItemTplManager:showInfoTip(L_Const.resType.commonItem, 100000)
    end
  })
  local currencyId = L_Const.currencyType.diamond
  self.modules.moduleIconBuy:setGeneral(L_Const.resType.currency, currencyId, {
    itemNum = L_ItemManager:parseCurrencyItem(currencyId).num,
    callback = function()
      self.bind.toggleBuy = true
      L_StaminaManager:setSelectId(2)
      self:initBuy()
    end
  })
  self.modules.moduleIconBuy.bind.tag = true
  self.modules.moduleIconBuy.bind.txtTag = L_WordsTpl:getValue("ui_pageStamina_01", {
    [0] = self.buyNum,
    [1] = self.max
  })
  self.bind.go_buy = self._allowDiamond
  self.bind.toggleProp = self.selectIcon == 1
  if self._allowDiamond then
    self.bind.toggleBuy = self.propItemNum <= 0 or self.selectIcon == 2
  elseif self.propItemNum <= 0 then
    self.bind.go_tipMain = true
    self.bind.txtTipMain = L_WordsTpl:getValue("residual_code_pagestamina_02")
  end
  if self.bind.toggleProp == true then
    self:initProp()
  elseif self.bind.toggleBuy == true then
    self:initBuy()
  end
  self:initCommonTipModule()
end

function page:initProp()
  self.bind.go_tipSub = false
  if self.propItemNum > 0 then
    self.bind.go_tipMain = true
    local str = "【" .. self.staminaItem.name .. "】"
    self.bind.txtTipMain = wordsTpl:getTplById("notice_stamina_recoveritem", {
      [0] = L_GameUtil.fillColor(str, L_Const.colorHtml.blue005),
      [1] = L_GameUtil.fillColor(" " .. self.staminaItem.config.useFunction[1] .. " ", L_Const.colorHtml.blue005)
    })
  elseif self._allowDiamond then
    self.bind.toggleBuy = true
    self.bind.toggleProp = false
    L_StaminaManager:setSelectId(2)
    self.selectIcon = 2
    self:initBuy()
  end
end

function page:initBuy()
  if not self._allowDiamond then
    return
  end
  self.bind.go_tipMain = true
  self.bind.go_tipSub = true
  if self.buyNum < self.max then
    local tpl = staminaTp:getTplById(self.buyNum + 1)
    if self.curStamina + staminaTp:getStamina(tpl) > self.staminaLimit and self.curStamina >= self.staminaLimit then
      self.maxStamina = true
    end
    self.moneyName = L_ItemManager:parseCurrencyItem(staminaTp:getPrice(tpl)[2]).name
    self.staminaNum = staminaTp:getStamina(tpl)
    if staminaTp:getPrice(tpl)[3] > L_ItemManager:parseCurrencyItem(staminaTp:getPrice(tpl)[2]).num then
      self.cost = false
    else
      self.cost = true
    end
    local str = "【" .. self.moneyName .. "x" .. staminaTp:getPrice(tpl)[3] .. "】"
    self.bind.txtTipMain = wordsTpl:getTplById("notice_stamina_buy1") .. wordsTpl:getTplById("notice_stamina_buy2", {
      [0] = L_GameUtil.fillColor(str, L_Const.colorHtml.blue005),
      [1] = L_GameUtil.fillColor(" " .. self.staminaNum .. " ", L_Const.colorHtml.blue005)
    })
    self.bind.txtTipSub = wordsTpl:getTplById("notice_stamina_buycount")
  else
    self.bind.txtTipMain = L_GameUtil.fillColor(wordsTpl:getTplById("notice_stamina_buylimit"), L_Const.colorHtml.red002)
    self.bind.go_tipSub = false
  end
end

function page:staminaUse()
  local staminaOne = self.staminaItem.config.useFunction[1]
  if self.curStamina + staminaOne <= self.staminaLimit or self.curStamina < self.staminaLimit then
    C_BagMgr:ReqUseItem(staminaId, 1, nil)
  elseif self.propItemNum <= 0 then
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_stamina_nothing"))
  else
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_stamina_limit"))
  end
end

function page:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  local param = {}
  self._isBuyMode = self._allowDiamond and self.buyNum < self.max
  self._isUseMode = not self._isBuyMode and self.bind.toggleProp == true
  param.hideConfirm = not self._isBuyMode and not self._isUseMode
  param.hideCancel = not self._isBuyMode and not self._isUseMode
  param.txtConfirm = self._isBuyMode and L_WordsTpl:getValue("residual_code_pagestamina_03") or "使用"
  param.txt_title = L_WordsTpl:getValue("residual_code_pagestamina_04")
  moduleTip:initModule(param)
end

return page
