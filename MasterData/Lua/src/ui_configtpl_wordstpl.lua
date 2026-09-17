local this = class("wordsTpl")
local table = G_Tables.TDWordsTable

function this:init(config)
end

function this:getTplById(id, paras)
  local val = table.GetData(id)
  return L_Config:provider(val.words, paras)
end

function this:getValue(key, paras)
  local val = table.GetData(key)
  if not (L_CommonUtil.isValid(val) and L_CommonUtil.isValid(val.words)) or val.words.langKey == 0 then
    return key
  end
  return L_Config:provider(val.words, paras)
end

function this:getValueParam(key, ...)
  local val = table.GetData(key)
  local paras = {}
  local index = 0
  for _, v in pairs({
    ...
  }) do
    paras[index] = v
    index = index + 1
  end
  return L_Config:provider(val.words, paras)
end

function this:getRawValue(key)
  return table.GetData(key)
end

function this:getAllData()
  return nil
end

return this
