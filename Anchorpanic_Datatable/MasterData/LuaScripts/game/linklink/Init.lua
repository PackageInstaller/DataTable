linklink = {}

-----------------配置相关
linklink.LinklinkDupConfigVo = require("game/linklink/manager/configVo/LinklinkDupConfigVo")
linklink.LinklinkAreaConfigVo = require("game/linklink/manager/configVo/LinklinkAreaConfigVo")
linklink.LinklinkStarRwardConfigVo = require("game/linklink/manager/configVo/LinklinkStarRwardConfigVo")

-----------------UI相关
linklink.LinklinkSceneUI = "game/linklink/view/LinklinkSceneUI"
linklink.LinklinkStageMainUI = "game/linklink/view/LinklinkStageMainUI"
linklink.LinklinkDupPanel = "game/linklink/view/LinklinkDupPanel"
linklink.LinklinkSettlementPanel = "game/linklink/view/LinklinkSettlementPanel"
linklink.LinklinkStarAwardView = "game/linklink/view/LinklinkStarAwardView"

linklink.LinklinkStarAwardItem = require("game/linklink/view/item/LinklinkStarAwardItem")
linklink.LinklinkCardItem = require("game/linklink/view/item/LinklinkCardItem")

-----------------管理器相关
linklink.LinklinkManager = require("game/linklink/manager/LinklinkManager").new()
linklink.LinklinkController = require("game/linklink/controller/LinklinkController").new(linklink.LinklinkManager)
linklink.LinklinkSceneController = require("game/linklink/controller/LinklinkSceneController").new()

local module = {linklink.LinklinkController, linklink.LinklinkSceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
