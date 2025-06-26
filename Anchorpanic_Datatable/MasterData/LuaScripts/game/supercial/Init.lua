supercial = {}

supercial.SupercialVo = require("game/supercial/manager/vo/SupercialVo")

supercial.SupercialPanel = require("game/supercial/view/SupercialPanel")

supercial.SupercialManager = require("game/supercial/manager/SupercialManager").new()
supercial.SupercialController = require("game/supercial/controller/SupercialController").new(supercial.SupercialManager)

local module = {supercial.SupercialController}
return module