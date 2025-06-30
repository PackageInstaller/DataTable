braceletsCommunicate = {}
-- require('game/chat/manager/ChatConst')

-- chat.ChatHeadGrid = require('game/chat/view/item/ChatHeadGrid')
-- chat.EmojiItem = require('game/chat/view/item/EmojiItem')
-- chat.ChatItem = require('game/chat/view/item/ChatItem')
-- chat.EmojiPanel = require('game/chat/view/EmojiPanel')
-- chat.ChatMscView = require('game/chat/view/ChatMscView')
-- chat.ChatBasePanel = require('game/chat/view/ChatBasePanel')

braceletsCommunicate.BraceletsCommunicatePanel = require('game/braceletsCommunicate/view/BraceletsCommunicatePanel')
braceletsCommunicate.BraceletsCommunicateItem = require('game/braceletsCommunicate/view/item/BraceletsCommunicateItem')
braceletsCommunicate.BraceletsCommunicateTargetItem = require('game/braceletsCommunicate/view/item/BraceletsCommunicateTargetItem')
-- chat.ChatItem = require('game/chat/view/item/ChatItem')

braceletsCommunicate.BraceletsCommunicateManager = require("game/braceletsCommunicate/manager/BraceletsCommunicateManager").new()
braceletsCommunicate.BraceletsCommunicateConfigVo = require("game/braceletsCommunicate/manager/vo/BraceletsCommunicateConfigVo")
braceletsCommunicate.BraceletsCommunicateMsgVo = require("game/braceletsCommunicate/manager/vo/BraceletsCommunicateMsgVo")
braceletsCommunicate.BraceletsCommunicateSegmentConfigVo = require("game/braceletsCommunicate/manager/vo/BraceletsCommunicateSegmentConfigVo")

braceletsCommunicate.BraceletsCommunicateController = require('game/braceletsCommunicate/controller/BraceletsCommunicateController').new(braceletsCommunicate.BraceletsCommunicateManager)
local module = {braceletsCommunicate.BraceletsCommunicateController}
return module