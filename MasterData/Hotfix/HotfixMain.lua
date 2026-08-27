local isOpenHotfix = CS.GlobalRegister.IsOpenHotfix()
require("Hotfix.HotfixBase")
HotfixMain = {
  hotmod = {}
}
local modules = {}

local function Start()
  if not isOpenHotfix then
    return
  end
  print("HotfixMain start...")
  for _, v in ipairs(modules) do
    local hotfix_class = reimport(v)
    local hotfix_inst = hotfix_class.New()
    hotfix_inst:Register()
    table.insert(HotfixMain.hotmod, hotfix_inst)
  end
end

local function Stop()
  if not isOpenHotfix then
    return
  end
  print("HotfixMain stop...")
  for _, v in ipairs(HotfixMain.hotmod) do
    if v ~= nil then
      v:UnRegister()
    end
  end
  HotfixMain.hotmod = {}
end

HotfixMain.modules = modules
HotfixMain.Start = Start
HotfixMain.Stop = Stop
return HotfixMain
