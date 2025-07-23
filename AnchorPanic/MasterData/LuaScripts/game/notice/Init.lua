notice = {}
--manager
notice.NoticeManager = require("game/notice/manager/NoticeManager").new()
--view
notice.NoticeView = require('game/notice/view/NoticeView')
--vo
notice.NoticeVo = require('game/notice/manager/vo/NoticeVo')
notice.NoticeParamVo = require('game/notice/manager/vo/NoticeParamVo')
-- const
require('game/notice/manager/NoticeConst')
-- utils
notice.LinkHelp = require('game/notice/manager/util/LinkHelp')
notice.HrefUtil = require('game/notice/manager/util/HrefUtil').new()
--controller
local _c = require('game/notice/controller/NoticeController').new(notice.NoticeManager)

local module = {_c}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
