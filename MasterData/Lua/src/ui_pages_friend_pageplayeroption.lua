local this = class("pagePlayerOption", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {curPlayerUid = nil}
end

function this.bind()
  return {
    localPosition_position = Unity.Vector3.zero,
    scrollList_btnGroup = {
      moduleName = "modulePages/cellButtonCommon"
    }
  }
end

function this.methods()
  return {
    onClick_back = function(self)
      L_UI:close(self.pageName)
    end,
    scrollList_btnGroup = {
      onClick = function(self, bind)
        L_UI:close("pagePlayerOption")
        bind.func(self.data.curPlayerUid)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.data.curPlayerUid = options.playerUid
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  self:initPage(options)
end

function this:close(options)
  this.super.close(self, options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
end

function this:initPage(options)
  self:initDropdowns(options.dropdowns)
  local targetPos = self.bindComponents.Board.transform:InverseTransformPoint(options.position)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.list_option)
  local height = self.bindComponents.list_option.sizeDelta.y
  local width = self.bindComponents.list_option.sizeDelta.x
  local halfScreenHeight = self.bindComponents.Board.transform.rect.height / 2
  if targetPos.y - height < -halfScreenHeight then
    targetPos.y = -halfScreenHeight + height
  end
  local halfScreenWidth = self.bindComponents.Board.transform.rect.width / 2
  if halfScreenWidth < targetPos.x + width then
    targetPos.x = halfScreenWidth - width
  end
  self.bind.localPosition_position = targetPos
end

function this:onEvent_refreshIdList()
  if not L_FriendStore:getIsFriend(self.data.curPlayerUid) then
    L_UI:close("pagePlayerOption")
  end
end

function this:initDropdowns(dropdowns)
  local tmp = {}
  for _, v in pairs(dropdowns) do
    table.insert(tmp, {
      func = L_DropdownsManager.param[v].func,
      txt_name = L_WordsTpl:getValue(L_DropdownsManager.param[v].name)
    })
  end
  self.bind.scrollList_btnGroup:clear()
  self.bind.scrollList_btnGroup:insert_array(tmp)
end

return this
