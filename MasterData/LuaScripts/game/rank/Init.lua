rank = {}

rank.RankMainPanel = 'game/rank/view/RankMainPanel'

rank.RankBaseView = 'game/rank/view/RankBaseView'
rank.RankRogueLikeView = 'game/rank/view/RankRogueLikeView'

rank.RankBaseItem = require('game/rank/view/item/RankBaseItem')
rank.RankRewardItem = require('game/rank/view/item/RankRewardItem')
rank.RankTabItem = 'game/rank/view/item/RankTabItem'
rank.RankTabChildItem = 'game/rank/view/item/RankTabChildItem'
rank.RankRogueLikeItem = require('game/rank/view/item/RankRogueLikeItem')

rank.RankBaseVo = require('game/rank/manager/vo/RankBaseVo')
rank.RankInfoVo = require('game/rank/manager/vo/RankInfoVo')
rank.RankRewardVo = require('game/rank/manager/vo/RankRewardVo')
rank.RankConst = require('game/rank/manager/RankConst')
rank.RankShowVo = require('game/rank/manager/vo/RankShowVo')
rank.RankManager = require('game/rank/manager/RankManager').new()

local _c = require('game/rank/controller/RankController').new(rank.RankManager)

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
