local DataModel = require("UICharacterList/UICharacterListDataModel")
local View = require("UICharacterList/UICharacterListView")
local Controller = {}

function Controller.SetPainting()
  local lastRoleId = PlayerData:GetUserInfo().receptionist_id[1]
  if lastRoleId == tonumber(DataModel.selectRoleId) then
    View.self:PlayAnim("Out")
    UIManager:GoBack()
    View.self:Confirm()
    return
  end
  Net:SendProto("main.set_receptionist", function(json)
    View.self:PlayAnim("Out")
    PlayerData:GetRoleById(lastRoleId).trust_exp = json.trust_exp
    PlayerData:GetRoleById(lastRoleId).trust_lv = json.trust_lv
    PlayerData:GetUserInfo().receptionist_ts[1] = json.server_now
    PlayerData:GetUserInfo().receptionist_id[1] = tostring(DataModel.selectRoleId)
    UIManager:GoBack()
    View.self:Confirm()
  end, DataModel.selectRoleId, 0)
end

return Controller
