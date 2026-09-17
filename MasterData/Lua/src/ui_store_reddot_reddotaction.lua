local this = {}
local C_RedDotStore = CS.Lens.Gameplay.UI.RedDotStore

function this:req_CSRedPointSetReq(id, sub_id, flag)
  C_RedDotStore.GetStore():ReqCSRedPointSetReq(id, sub_id, flag)
end

return this
