bigHostel = {}

-----------------场景相关
bigHostel.BigHostelScene = require("game/bigHostel/scene/BigHostelScene")

bigHostel.BigHostelBaseModel = require("game/bigHostel/manager/model/BigHostelBaseModel")
bigHostel.BigHosteleffect = require("game/bigHostel/manager/BigHosteleffect")

-----------------配置相关
bigHostel.BigHostelModelConfigVo = require("game/bigHostel/manager/configVo/BigHostelModelConfigVo")

-----------------UI相关
bigHostel.BigHostelSceneUI = "game/bigHostel/view/BigHostelSceneUI"
bigHostel.BigHostelBlackView = "game/bigHostel/view/BigHostelBlackView"

-----------------管理器相关
bigHostel.BigHostelConst = require("game/bigHostel/manager/BigHostelConst")
bigHostel.BigHostelManager = require("game/bigHostel/manager/BigHostelManager").new()
bigHostel.BigHostelController = require("game/bigHostel/controller/BigHostelController").new(bigHostel.BigHostelManager)
bigHostel.BigHostelSceneController = require("game/bigHostel/controller/BigHostelSceneController").new()

local module = {bigHostel.BigHostelController, bigHostel.BigHostelSceneController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
