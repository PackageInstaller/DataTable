HotfixBase = class("HotfixBase")
local util

function HotfixBase:ctor()
  self.hotfixList = {}
end

function HotfixBase:Register()
end

function HotfixBase:RegisterHotfix(cs_type, cs_func, fix_func, retain_old)
  retain_old = retain_old or false
  if retain_old then
    util = util or require("XLua.Common.xlua_util")
    util.hotfix_ex(cs_type, cs_func, fix_func)
  else
    xlua.hotfix(cs_type, cs_func, fix_func)
  end
  local hotfix = {}
  hotfix.cs_type = cs_type
  hotfix.cs_func = cs_func
  table.insert(self.hotfixList, hotfix)
end

function HotfixBase:UnRegister()
  for _, v in ipairs(self.hotfixList) do
    xlua.hotfix(v.cs_type, v.cs_func, nil)
  end
  self.hotfixList = {}
end
