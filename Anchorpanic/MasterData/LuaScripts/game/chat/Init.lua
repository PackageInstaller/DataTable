chat = {}
require('game/chat/manager/ChatConst')

chat.ChatHeadGrid = require('game/chat/view/item/ChatHeadGrid')
chat.EmojiItem = require('game/chat/view/item/EmojiItem')
chat.ChatItem = require('game/chat/view/item/ChatItem')
chat.EmojiPanel = require('game/chat/view/EmojiPanel')
chat.ChatMscView = require('game/chat/view/ChatMscView')
chat.ChatBasePanel = require('game/chat/view/ChatBasePanel')
chat.ChatSettingPanel = require('game/chat/view/ChatSettingPanel')


chat.ChatPanel = require('game/chat/view/ChatPanel')
chat.ChatItem = require('game/chat/view/item/ChatItem')
chat.ChatSettingBubbleItem = require('game/chat/view/item/ChatSettingBubbleItem')


chat.ChatManager = require("game/chat/manager/ChatManager").new()
chat.ChatVo = require("game/chat/manager/vo/ChatVo")
chat.ChatConfigVo = require("game/chat/manager/vo/ChatConfigVo")
chat.EmojiRo = require('rodata/EmojiDataRo')

chat.ChatController = require('game/chat/controller/ChatController').new(chat.ChatManager)
local module = {chat.ChatController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
