local this = class("errorCodeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  local tpl = self.data[id]
  if not tpl then
    printf("errorCodeTpl:getTplById id:%s not found", id)
  end
  return tpl
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl, para, tplId)
  if tpl then
    local name = L_Config:provider(tpl.name, para)
    if string.isEmpty(name) then
      name = L_WordsTpl:getValue("ui_errorCodeTpl", {
        [0] = tpl.id
      })
    end
    return name
  end
  if tplId ~= nil then
    if tplId ~= 0 and tplId ~= -9999 then
      return L_WordsTpl:getValue("notice_noNameErrorCode") .. "先让策划配上名字. ErrCodeID" .. tplId
    end
  else
    return L_WordsTpl:getValue("notice_noNameErrorCode") .. "先让策划配上名字"
  end
end

function this:getNameByErrCode(id)
  local tpl = self:getTplById(id)
  return self:getName(tpl, nil, id)
end

function this:getType(tpl)
  return tpl and tpl.type or 1
end

return this
