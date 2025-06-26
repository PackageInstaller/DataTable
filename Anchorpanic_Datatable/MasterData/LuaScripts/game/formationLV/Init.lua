formationLV = {}

-- require("game/covenant/manager/CovenantLevelConst")

formationLV.FormationLVManager = require("game/formationLV/manager/FormationLVManager").new()
formationLV.FormationLVPanel = require("game/formationLV/view/FormationLVPanel")
formationLV.FormationLVItem = require("game/formationLV/view/FormationLVItem")
formationLV.FormationLVUnlockSuccessPanel = require("game/formationLV/view/FormationLVUnlockSuccessPanel")
formationLV.FormationLVVo = require("game/formationLV/manager/vo/FormationLVVo")

formationLV.FormationLVController = require("game/formationLV/controller/FormationLVController").new(covenant.FormationLVManager)

local _module = { formationLV.FormationLVController }

return _module
 
--[[ 替换语言包自动生成，请勿修改！
]]
