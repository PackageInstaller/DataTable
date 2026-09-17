local this = class("quickRouletteManager", G_EventManagerBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
this.event = {}

function this:ctor()
  this.super.ctor(self)
end

function this:getItemInfo(itemId)
  if not itemId or itemId <= 0 then
    return table.empty
  end
  local info = {}
  local tpl = _commonItemTpl:getTplById(itemId)
  if not tpl then
    errorf(string.format("getItemInfo not find tpl, itemId:%s", itemId))
  else
    info.name = _commonItemTpl:getName(tpl)
    info.icon = _commonItemTpl:getIcon(tpl)
    info.num = C_BagMgr:getItemNumByItemId(itemId)
  end
  return info
end

function this:checkCanUseQuickItem(itemId, noShowMsg)
  local msg
  local canUse = false
  local tpl = _commonItemTpl:getTplById(itemId)
  local bagType = _commonItemTpl:getBagType(tpl)
  local itemType = _commonItemTpl:getType(tpl)
  if bagType == L_BagConst.bagTag.food then
    if L_BattleStore:getIsInBattle() then
      msg = L_WordsTpl:getValue("notice_quickRouletteManager")
    else
      canUse = true
    end
  else
    canUse = true
  end
  if not string.isEmpty(msg) and not noShowMsg then
    L_FlyMsgManager:showNormalMsg(msg)
  end
  return canUse
end

function this:useItem(itemId, callBack)
  if not self:checkCanUseQuickItem(itemId) then
    return
  end
  C_BagMgr:UseBagItem(itemId, callBack)
end

return this
