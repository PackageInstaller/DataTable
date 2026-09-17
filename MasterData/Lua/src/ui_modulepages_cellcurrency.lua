local this = class("cellCurrency", G_UIModuleBase)
local _numType = {simple = 1, mul = 2}
local _resourceBarItemTpl = L_GameTpl:getResourceBarItemTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local _wordsTpl = L_GameTpl:getWordsTpl()

function this.bind()
  return {
    imgIcon = "",
    txtNum = "0",
    goBtnAdd = true,
    goImgIcon = true,
    goTxtName = false,
    txtName = ""
  }
end

function this.methods()
  return {
    onClick_add = function(self)
      local tpl = _resourceBarItemTpl:getTplById(self.bind.resId)
      local systemId = _resourceBarItemTpl:getSystem(tpl)
      L_SystemBreakManager:jumpTo(systemId)
    end,
    onClick_icon = function(self)
      if self.bind.resId == L_GameConstTpl:getData("ELEMENT_CURRENCY_BASE", L_Const.GameTplType.int) then
        if L_DeviceTpl:getIsMobile() then
          local pos = self.bindComponents.img_icon.position
          L_UI:open("PageTipElement", {pos = pos})
        end
      else
        local tpl = _resourceBarItemTpl:getTplById(self.bind.resId)
        local type = _resourceBarItemTpl:getResourceType(tpl)
        local id = _resourceBarItemTpl:getResourceID(tpl)
        L_ItemTplManager:showInfoTip(type, id)
      end
    end,
    onHover_icon = function(self)
      if L_DeviceTpl:getIsMobile() == false and self.bind.resId == L_GameConstTpl:getData("ELEMENT_CURRENCY_BASE", L_Const.GameTplType.int) then
        local pos = self.bindComponents.img_icon.position
        L_UI:open("PageTipElement", {pos = pos})
      end
    end
  }
end

function this:open()
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.syncAttrInfoComplete, self.refresh, self)
end

function this:close()
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.syncAttrInfoComplete, self.refresh, self)
end

function this:refresh()
  local tpl = _resourceBarItemTpl:getTplById(self.bind.resId)
  local type = _resourceBarItemTpl:getResourceType(tpl)
  local id = _resourceBarItemTpl:getResourceID(tpl)
  self:refreshNum()
  local bShowIcon = true
  if id == L_Const.currencyType.weeklyDungeonCount and type == L_Const.resType.currency then
    bShowIcon = false
    self.bind.txtName = _wordsTpl:getValue("ui_dungeon_weekly_times_limit")
  end
  self.bind.goImgIcon = bShowIcon
  self.bind.goTxtName = not bShowIcon
  if bShowIcon then
    if id == L_GameConstTpl:getValue("ELEMENT_CURRENCY_BASE") then
      self.bind.imgIcon = "UI/Icon/Currency/tex_icon_currency_particle_base.png"
    else
      local item = L_ItemTplManager:getItemConfig(type, id)
      self.bind.imgIcon = item.icon
    end
  end
  self.bind.goBtnAdd = _resourceBarItemTpl:getIsAddSign(tpl)
end

function this:refreshNum()
  local tpl = _resourceBarItemTpl:getTplById(self.bind.resId)
  local type = _resourceBarItemTpl:getResourceType(tpl)
  local id = _resourceBarItemTpl:getResourceID(tpl)
  local numType = _resourceBarItemTpl:getNumType(tpl)
  local num = L_ItemTplManager:getItemNum(type, id)
  local showTxt = ""
  if numType == _numType.simple then
    showTxt = L_GameUtil.itemShowNum(num)
  elseif numType == _numType.mul then
    local limit = self:getLimitNum(type, id)
    showTxt = string.format("%s/%s", num, limit)
  end
  self.bind.txtNum = showTxt
end

function this:getLimitNum(type, id)
  if id == L_Const.currencyType.stamina and type == L_Const.resType.currency then
    local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()
    return playerLevelTpl:getStamina(playerLevelTpl:getTplById(L_PlayerStore:getLv()))
  elseif id == L_Const.currencyType.crystalKeyStone and type == L_Const.resType.currency then
    local limit = _gameConstTpl:getMultiDungoenFeeLimit()
    if not limit then
      return 0
    end
    return limit[2]
  elseif id == L_Const.currencyType.specialCrystalKeyStone and type == L_Const.resType.currency then
    local limit = _gameConstTpl:getSpecialMultiDungoenFeeLimit()
    if not limit then
      return 0
    end
    return limit[2]
  elseif id == L_Const.currencyType.weeklyDungeonCount and type == L_Const.resType.currency then
    return _gameConstTpl:getWeeklyDungeonLimit()
  end
  return 0
end

return this
