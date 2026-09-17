local this = class("moduleCurrency", G_UIModuleBase)
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()

function this.bind()
  return {
    resList = {
      moduleName = "modulePages/cellCurrency"
    }
  }
end

function this:open()
  this.super.open(self)
  self.onEvent_refreshResHandle = handler(self, self.onEvent_refreshRes)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshResHandle)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshRes, self)
end

function this:close()
  this.super.close(self)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshRes)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshResHandle)
end

function this:refreshRes(tpl_system)
  if table.isEmpty(tpl_system) then
    self.bind.resList:clear()
    return
  end
  self.bind.resList:clear()
end

function this:refreshResByResBarTplIdList(resBarTplIdList)
  if table.isEmpty(resBarTplIdList) then
    self.bind.resList:clear()
    return
  end
  local tmp = {}
  self.bind.resList:clear()
  for _, resBarTplId in ipairs(resBarTplIdList) do
    table.insert(tmp, {resId = resBarTplId})
  end
  self.bind.resList:insert_array(tmp)
end

function this:onEvent_refreshRes(attr)
  for _, module in ipairs(self.modules.resList) do
    module:refreshNum()
  end
end

return this
