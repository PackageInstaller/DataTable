favorable = {}

favorable.HeroFavorableVo = require("game/favorable/manager/vo/HeroFavorableVo")
favorable.FavorableVo = require("game/favorable/manager/vo/FavorableVo")
favorable.FavorableGiveVo = require("game/favorable/manager/vo/FavorableGiveVo")

favorable.FavorableCaseVo = require("game/favorable/manager/vo/FavorableCaseVo")
favorable.FavorableInteractVo = require("game/favorable/manager/vo/FavorableInteractVo")
favorable.FavorableVoiceVo = require("game/favorable/manager/vo/FavorableVoiceVo")

--- 好感
favorable.FavorablePanel = require("game/favorable/view/FavorablePanel")
--- 好感赠礼
favorable.FavorableGiveView = require("game/favorable/view/tab/FavorableGiveView")
-- 秘闻
favorable.FavorableCaseView = require("game/favorable/view/tab/FavorableCaseView")
favorable.FavorableActionView = require("game/favorable/view/tab/FavorableActionView")
favorable.FavorableVoiceView = require("game/favorable/view/tab/FavorableVoiceView")

--- 好感升级界面
favorable.FavorableLevelUpPanel = require("game/favorable/view/FavorableLevelUpPanel")

-- 礼物子元素
favorable.FavorableGiveItem = require("game/favorable/view/item/FavorableGiveItem")
-- 等级解锁子元素
favorable.FavorableMoreItem = require("game/favorable/view/item/FavorableMoreItem")

favorable.FavorableStoryItem = require("game/favorable/view/item/FavorableStoryItem") 
favorable.FavorableStoryView = require("game/favorable/view/tab/FavorableStoryView")



favorable.FavorableCaseItem = require("game/favorable/view/item/FavorableCaseItem")
favorable.FavorableActionItem = require("game/favorable/view/item/FavorableActionItem")
favorable.FavorableVoiceItem = require("game/favorable/view/item/FavorableVoiceItem")

favorable.FavorableConst = require("game/favorable/manager/FavorableConst")
favorable.FavorableManager = require("game/favorable/manager/FavorableManager").new()
favorable.FavorableController = require("game/favorable/controller/FavorableController").new(favorable.FavorableManager)

local module = { favorable.FavorableController }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
