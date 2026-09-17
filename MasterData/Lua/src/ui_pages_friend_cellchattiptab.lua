local this = class("cellChatTipTab", G_UIModuleBase)
local tabName = {
  [L_Const.blackPlayerTab.blackList] = L_WordsTpl:getValue("ui_friend_4"),
  [L_Const.blackPlayerTab.blockChatList] = L_WordsTpl:getValue("meun_friend_4")
}

function this.bind()
  return {
    txt_name1 = "",
    txt_name2 = "",
    item_id = -1
  }
end

function this.methods()
  return {}
end

function this:refresh()
  self.bind.item_id = self.bind.id
  self.bind.txt_name1 = tabName[self.bind.id]
  self.bind.txt_name2 = tabName[self.bind.id]
end

return this
