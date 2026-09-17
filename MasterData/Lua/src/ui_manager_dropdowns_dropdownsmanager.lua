local this = class("dropdownsManager")
this.option = {
  viewInfo = "viewInfo",
  visitHome = "visitHome",
  addRemarks = "addRemarks",
  refuseChat = "refuseChat",
  unmaskChat = "unmaskChat",
  removeFriend = "removeFriend",
  insertToBlackList = "insertToBlackList",
  report = "report",
  addFriend = "addFriend",
  removeFromBlackList = "removeFromBlackList",
  modifyName = "modifyName",
  editSign = "editSign",
  copyUid = "copyUid",
  deleteConversation = "deleteConversation"
}
this.param = {
  [this.option.viewInfo] = {
    name = "notice_homeProduction_09",
    func = function(playerUid)
      L_FriendManager:viewPlayerCard(playerUid)
    end
  },
  [this.option.visitHome] = {
    name = "notice_homeProduction_10",
    func = function(playerUid)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_homeProduction_11"))
    end
  },
  [this.option.addRemarks] = {
    name = "ui_friendFunction_01",
    func = function(playerUid)
      L_FriendManager:modifyFriendMark(playerUid)
    end
  },
  [this.option.refuseChat] = {
    name = "ui_friendFunction_02",
    func = function(playerUid)
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("ui_friendFunction_03"),
        confirmCallback = function()
          L_FriendStore:req_blockPlayerChat(playerUid)
        end
      })
    end
  },
  [this.option.unmaskChat] = {
    name = "ui_friendFunction_04",
    func = function(playerUid)
      L_FriendStore:req_unblockPlayerChat(playerUid)
    end
  },
  [this.option.removeFriend] = {
    name = "ui_friendFunction_05",
    func = function(playerUid)
      local data = {
        txtContent = L_WordsTpl:getValue("ui_friendFunction_06"),
        confirmCallback = function()
          L_FriendManager:operationPlayer(L_Const.friendOpType.friend, L_Const.friendOp.delete, playerUid, function()
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageBlackList"))
          end)
        end
      }
      L_GameUtil.showCommonTip(data)
    end
  },
  [this.option.insertToBlackList] = {
    name = "ui_friendFunction_07",
    func = function(playerUid)
      if table.count(L_FriendStore:getBlackList()) >= L_GameTpl:getGameConstTpl():getBlackListLimit() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friendFunction_08"))
        return
      end
      local data = {
        txtContent = L_WordsTpl:getValue("ui_friendFunction_09"),
        confirmCallback = function()
          L_FriendManager:operationPlayer(L_Const.friendOpType.blackList, L_Const.friendOp.add, playerUid, function()
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friendFunction_10"))
          end)
        end
      }
      L_GameUtil.showCommonTip(data)
    end
  },
  [this.option.addFriend] = {
    name = "ui_friendFunction_11",
    func = function(playerUid)
      L_FriendManager:addFriend(playerUid)
    end
  },
  [this.option.removeFromBlackList] = {
    name = "ui_friendFunction_12",
    func = function(playerUid)
      L_FriendManager:operationPlayer(L_Const.friendOpType.blackList, L_Const.friendOp.delete, playerUid, function()
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friendFunction_13"))
      end)
    end
  },
  [this.option.modifyName] = {
    name = "ui_playercard_changesignature",
    func = function(playerUid)
      L_PlayerManager:modifyName()
    end
  },
  [this.option.editSign] = {
    name = "ui_playercard_changename",
    func = function(playerUid)
      L_PlayerManager:modifySign()
    end
  },
  [this.option.copyUid] = {
    name = "ui_friendFunction_14",
    func = function(playerUid)
      L_PlayerManager:copyUid(playerUid)
    end
  },
  [this.option.deleteConversation] = {
    name = "ui_friendFunction_15",
    func = function(playerUid)
      L_ChatStore:req_deleteChatConversation(playerUid, function()
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friendFunction_16"))
      end)
    end
  },
  [this.option.report] = {
    name = "ui_friendFunction_17",
    func = function(playerUid)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_friendFunction_18"))
    end
  }
}

function this:showPlayerDropdowns(position, dropdowns, playerUid)
  local data = {
    position = position,
    dropdowns = dropdowns,
    playerUid = playerUid
  }
  L_UI:open("pagePlayerOption", data)
end

return this
