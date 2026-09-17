local this = class("cellHeadPicItem", G_UIModuleBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()

function this.bind()
  return {
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    },
    isActive_cur = false,
    isActive_lock = false,
    isActive_reddot = nil,
    isActive_select = false,
    go_L2DSign = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.isActive_select == true then
        return
      end
      self:emit("onClick", self.bind.id)
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.PlayerHeadItem, self.bind.id)
      L_ReddotManager._dirtyList[L_ReddotManager.DotDef.PlayerHead_head] = true
      L_ReddotManager._dirtyList[L_ReddotManager.DotDef.PlayerHead_frame] = true
    end
  }
end

function this:open()
  local key = string.format(L_ReddotManager.DotDef.PlayerHeadItem, self.bind.id)
  L_ReddotManager:registerReddot(self.bindComponents.reddot, key)
  local state = L_ReddotManager:getRedDotState(L_ReddotManager.DotDef.PlayerHeadItem, self.bind.id)
  self.bindComponents.reddot.gameObject:SetActive(state ~= nil)
end

function this:close()
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  self.tpl = self.bind.tpl
  local cellHeadPic = self.modules.cellHeadPic
  local baseInfo = L_PlayerStore:getPlayerBaseInfo()
  if self.tpl.type == L_Const.playerDressType.head then
    local _, frameId = L_PlayerDisplayStore:getDefaultFrame()
    cellHeadPic:setStaticPreviewByDressIds(self.tpl.id, frameId, baseInfo)
  elseif self.tpl.type == L_Const.playerDressType.headFrame then
    local headId = L_PlayerDisplayStore:getDefaultHead()
    local frameId = _playerDressTpl:getId(self.tpl)
    cellHeadPic:setStaticPreviewByDressIds(headId, frameId, baseInfo, true)
  end
  local has = L_PlayerDisplayStore:hasItem(self.bind.id)
  if has then
    self.bindComponents.darkenSafeHelper:ResetColors()
  else
    self.bindComponents.darkenSafeHelper:SetGray()
  end
  self.bind.isActive_lock = not has
  self.bind.isActive_cur = L_PlayerDisplayStore:isCurDress(self.bind.id)
  self:refreshL2DSign()
end

function this:refreshSelect(id)
  self.bind.isActive_select = id == self.bind.id
  self:refreshL2DSign()
end

function this:refreshCur()
  self.bind.isActive_cur = L_PlayerDisplayStore:isCurDress(self.bind.id)
end

function this:refreshL2DSign()
  self.bind.go_L2DSign = self.tpl ~= nil and _playerDressTpl.hasDynamicPreview and _playerDressTpl:hasDynamicPreview(self.tpl)
end

return this
