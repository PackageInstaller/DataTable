_class("UILogHelper", Object)
UILogHelper = UILogHelper

function UILogHelper.Exception_CheckClassFromBase(desc, className, baseName)
  local errStr = ""
  local type = Classes[className]
  if not type then
    errStr = className .. " 类型不存在"
  elseif not string.isnullorempty(baseName) and type._className ~= baseName and not type:IsChildOf(baseName) then
    errStr = className .. "不是 " .. baseName .. " 的子类"
  end
  if not string.isnullorempty(errStr) then
    Log.exception("UILogHelper.Exception_CheckClassFromBase() ", desc, " ", errStr)
    return false
  end
  return true
end

function UILogHelper.ParamsFormatString(params)
  local str = ""
  for k, v in pairs(params) do
    str = str .. string.format("[%s]=%s ", k, v)
  end
  return str
end
