updateRes = {}

updateRes.UpdateResBaseView = LuaUtil:reRequire("game/updateRes/view/UpdateResBaseView")
updateRes.UpdateResLoadingView = LuaUtil:reRequire("game/updateRes/view/UpdateResLoadingView")
updateRes.UpdateResAlertView = LuaUtil:reRequire("game/updateRes/view/UpdateResAlertView")

LuaUtil:reRequire("game/updateRes/manager/UpdateResConst")
updateRes.UpdateResManager = LuaUtil:reRequire("game/updateRes/manager/UpdateResManager").new()
updateRes.UpdateResController = LuaUtil:reRequire("game/updateRes/controller/UpdateResController").new()

local module = {}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
