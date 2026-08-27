local base = require("Game.Common.Data.BaseActivityInteractData")
local Act23SteinsGateInteractData = class("Act23SteinsGateInteractData", base)

function Act23SteinsGateInteractData:FinishTalk(interactId, callback)
  NetworkManager:GetNetwork(NetworkTypeID.Interact):CS_ACTIVITY_Interact(self.actId, interactId, function(args)
    self:FinishTalkCallback(args, interactId, callback)
  end)
end

function Act23SteinsGateInteractData:FinishTalkCallback(args, interactId, callback)
  base.FinishTalkCallback(self, args, interactId, callback)
end

function Act23SteinsGateInteractData:GetNowCfgByHeroIdOrObjId(heroId, objId)
  local isHero = 0 < heroId
  local cantTalkCfg, cantTalk = nil, false
  if isHero then
    cantTalkCfg, cantTalk = self:GetNowCfgByHeroId(heroId)
  else
    cantTalkCfg, cantTalk = self:GetNowCfgByObjId(objId)
  end
  return cantTalkCfg, cantTalk
end

function Act23SteinsGateInteractData:GetNowCfgByObjId(objId)
  self._preFinishDic = {}
  local cantTalkCfg
  local cantTalkId = 9999
  local cantTalk = false
  for i, v in pairs(self._storyCfg) do
    if v.obj_id == objId then
      local canTalk = self:_CalInteractState(i, true)
      if canTalk then
        return v, false
      elseif i < cantTalkId and not self:GetThisTalkStateById(i) then
        cantTalkCfg = v
        cantTalk = true
        cantTalkId = i
      end
    end
  end
  return cantTalkCfg, cantTalk
end

return Act23SteinsGateInteractData
