marriage = {}

marriage.MarriageUseView = require("game/marriage/view/MarriageUseView")
marriage.MarriageReNameView = require("game/marriage/view/MarriageReNameView")
marriage.MarriageInfoView = require("game/marriage/view/MarriageInfoView")
marriage.MarriageSucceedView = require("game/marriage/view/MarriageSucceedView")
marriage.MarriageManager = require("game/marriage/manager/MarriageManager").new()
marriage.MarriageController = require("game/marriage/controller/MarriageController").new(marriage.MarriageManager)

local module = {marriage.MarriageController}
return module