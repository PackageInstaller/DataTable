local this = class("photoTemplateData")
local ins = 0

function this:ctor()
  ins = ins + 1
  self.id = ins
  self.type = L_Const.photoTemplateDataType.none
  self.url = nil
  self.name = L_WordsTpl:getValue("residual_code_phototemplatedata_01")
  self.settingParamDict = {}
end

function this:toString()
  local list = {}
  for paramStr, resStr in pairs(self.settingParamDict) do
    table.insert(list, resStr)
  end
  return table.concat(list, "$")
end

function this:toProtoSendData()
  return {
    id = self.id,
    name = self.name,
    url = self.url,
    arg = self:toString()
  }
end

return this
