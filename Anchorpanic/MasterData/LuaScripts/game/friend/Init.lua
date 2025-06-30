friend = {}
friend.FriendConst = require('game/friend/manager/FriendConst')
friend.FriendVo = require('game/friend/manager/vo/FriendVo')
friend.PrivateChatVo = require('game/friend/manager/vo/PrivateChatVo')
friend.FriendManager = require('game/friend/manager/FriendManager').new()

friend.FriendItem = require('game/friend/view/item/FriendItem')
friend.FriendBlackItem = require('game/friend/view/item/FriendBlackItem')
friend.FriendQueryItem = require('game/friend/view/item/FriendQueryItem')
friend.FriendApplyItem = require('game/friend/view/item/FriendApplyItem')
friend.FriendRecommendItem = require('game/friend/view/item/FriendRecommendItem')
friend.PrivateChatListItem = require('game/friend/view/item/PrivateChatListItem')
friend.PrivateChatTalkItem = require('game/friend/view/item/PrivateChatTalkItem')
friend.PrivateEmojiItem = require('game/friend/view/item/PrivateEmojiItem')

friend.FriendBlackView = 'game/friend/view/FriendBlackView'
friend.FriendApplyView = 'game/friend/view/FriendApplyView'
friend.FriendPanel = 'game/friend/view/FriendPanel'
friend.FriendRecommendView = 'game/friend/view/FriendRecommendView'
friend.PrivateChatPanel = 'game/friend/view/PrivateChatPanel'
friend.PrivateEmojiPanel = 'game/friend/view/PrivateEmojiPanel'

local _c = require('game/friend/controller/FriendController').new(friend.FriendManager)
local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
