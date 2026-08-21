mole = {}

require("game/mole/manager/MoleConst")


mole.MoleStarDataVo = require("game/mole/manager/vo/MoleStarDataVo")
mole.MoleDupDataVo = require("game/mole/manager/vo/MoleDupDataVo")
mole.MoleStarRwardConfigVo = require("game/mole/manager/vo/MoleStarRwardConfigVo")
mole.MoleEventListVo = require("game/mole/manager/vo/MoleEventListVo")
mole.MoleGameDataVo = require("game/mole/manager/vo/MoleGameDataVo")
mole.MoleItemDataVo = require("game/mole/manager/vo/MoleItemDataVo")

mole.MoleGamePanel = require("game/mole/view/MoleGamePanel")


mole.MoleStarAwardItem = require("game/mole/view/item/MoleStarAwardItem")

mole.MoleTipsView = require("game/mole/view/MoleTipsView")

mole.MoleStartView = require("game/mole/view/MoleStartView")
mole.MoleStageMainUI = require("game/mole/view/MoleStageMainUI")
mole.MoleStarAwardView = require("game/mole/view/MoleStarAwardView")
mole.MoleDupPanel = require("game/mole/view/MoleDupPanel")
mole.MoleSettlePanel = require("game/mole/view/MoleSettlePanel")

mole.MoleManager = require("game/mole/manager/MoleManager").new()
mole.MoleController = require("game/mole/controller/MoleController").new(mole.MoleManager)
local module = {mole.MoleController}
return module