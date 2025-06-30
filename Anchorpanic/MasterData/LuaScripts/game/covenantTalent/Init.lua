covenantTalent = {}

covenantTalent.CovenantTalentBagScrollerItem =  require("game/covenantTalent/view/item/CovenantTalentBagScrollerItem")
covenantTalent.CovenantTalentGeneItem = require("game/covenantTalent/view/item/CovenantTalentGeneItem")
covenantTalent.CovenantTalentPanel = "game/covenantTalent/view/CovenantTalentPanel"
covenantTalent.CovenantTalentBagPanel = "game/covenantTalent/view/CovenantTalentBagPanel"
covenantTalent.CovenantTalentResetView = "game/covenantTalent/view/CovenantTalentResetView"

covenantTalent.CovenantTalentGeneVo = require("game/covenantTalent/manager/vo/CovenantTalentGeneVo")
covenantTalent.CovenantTalentBaseVo = require("game/covenantTalent/manager/vo/CovenantTalentBaseVo")
covenantTalent.OrderConfigVo = require("game/covenantTalent/manager/vo/OrderConfigVo")
props.OrderVo = require("game/covenantTalent/manager/vo/OrderVo")

covenantTalent.CovenantTalentManager = require("game/covenantTalent/manager/CovenantTalentManager").new()

local _ctc = require("game/covenantTalent/controller/CovenantTalentController").new(covenantTalent.CovenantTalentManager)

local _module = { _ctc }

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
