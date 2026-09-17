local this = class("sceneMap")

function this:ctor(id)
  self.id = id
  self.creatorId = nil
  self.notifyId = nil
  self.playerId = nil
  self.objDic = {}
  self.cfgTpl = nil
  self.runObjDic = {}
  self.runPetObjDic = {}
end

return this
