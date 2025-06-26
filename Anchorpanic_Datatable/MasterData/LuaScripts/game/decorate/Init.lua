decorate = {}

require('game/decorate/manager/DecorateConst')
decorate.DecorateManager = require('game/decorate/manager/DecorateManager').new()
decorate.DecorateController = require('game/decorate/controller/DecorateController').new(decorate.DecorateManager)

decorate.AvatarDataRo = require('rodata/AvatarDataRo')
decorate.TitleDataRo = require('rodata/DesignationDataRo')
decorate.AvatarFrameDataRo = require('game/decorate/manager/vo/AvatarFrameDataRo')
decorate.DecorateHeadVo = require('game/decorate/manager/vo/DecorateHeadVo')
decorate.DecorateHeadFrameVo = require('game/decorate/manager/vo/DecorateHeadFrameVo')
decorate.DecorateTitleVo = require('game/decorate/manager/vo/DecorateTitleVo')
decorate.ChatBubbleVo = require('game/decorate/manager/vo/ChatBubbleVo')

decorate.DecoratePanel = require('game/decorate/view/DecoratePanel')
decorate.DecorateBaseView = require('game/decorate/view/tabView/DecorateBaseView')
decorate.DecorateHeadView = require('game/decorate/view/tabView/DecorateHeadView')
decorate.DecorateHeadFrameView = require('game/decorate/view/tabView/DecorateHeadFrameView')
decorate.DecorateTitleView = require('game/decorate/view/tabView/DecorateTitleView')

decorate.DecorateBaseItem = require('game/decorate/view/item/DecorateBaseItem')
decorate.DecorateHeadItem = require('game/decorate/view/item/DecorateHeadItem')
decorate.DecorateHeadFrameItem = require('game/decorate/view/item/DecorateHeadFrameItem')
decorate.DecorateTitleItem = require('game/decorate/view/item/DecorateTitleItem')

local module = {decorate.DecorateController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
