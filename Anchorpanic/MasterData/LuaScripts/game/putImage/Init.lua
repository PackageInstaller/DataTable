putImage = {}

--vo
putImage.PutImageDupConfigVo = require("game/putImage/manager/vo/PutImageDupConfigVo")
putImage.PutImageAreaConfigVo = require("game/putImage/manager/vo/PutImageAreaConfigVo")

----UI
putImage.PutImageStageMainUI = "game/putImage/view/PutImageStageMainUI"
putImage.PutImageSceneUI = "game/putImage/view/PutImageSceneUI"
putImage.PutImageDupPanel = "game/putImage/view/PutImageDupPanel"

putImage.PutImageGridItem = require("game/putImage/view/item/PutImageGridItem")

--管理器
putImage.PutImageConst = require("game/putImage/manager/PutImageConst")
putImage.PutImageManager = require("game/putImage/manager/PutImageManager").new()
putImage.PutImageController = require("game/putImage/controller/PutImageController").new(putImage.PutImageManager)

local module = {putImage.PutImageController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
