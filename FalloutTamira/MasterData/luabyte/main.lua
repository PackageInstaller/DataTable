

local function InitProtobuf()
  -- body
  

  -- require("Proto.Proto")
  -- require("Proto.ProtoEnum")
  -- local pb = require 'pb'
  -- local protoc = require 'protoc'
end

function InitByteDance()
  -- local macro = CS.GameX.GameHelper.GetUnityMacro()
  -- if macro == "UNITY_EDITOR" then 
  --     return
  -- end
  -- local packageName = CS.GameX.GameHelper.GetPackageName()
  -- if not string.contains(packageName,"bytedance") then 
  --     return
  -- end
  -- --注册之前，先初始化
  -- local unityPlayerAcicityCls = CS.UnityEngine.AndroidJavaClass("com.unity3d.player.UnityPlayer")
  -- local currentActivityGenric = xlua.get_generic_method(CS.UnityEngine.AndroidJavaClass,"GetStatic")
  -- local currentActivityFiled = currentActivityGenric(CS.UnityEngine.AndroidJavaObject)
  -- local currentActivity = currentActivityFiled(unityPlayerAcicityCls,"currentActivity")

  -- local xnplusApplicationCls = CS.UnityEngine.AndroidJavaClass("XNPPlus.XNPApplication")
  -- local xnplusApplicationGenric = xlua.get_generic_method(CS.UnityEngine.AndroidJavaClass,"GetStatic")
  -- local xnplusApplicationFiled = xnplusApplicationGenric(CS.UnityEngine.AndroidJavaObject)
  -- local xnplusApplication = xnplusApplicationFiled(xnplusApplicationCls,"instalce")

  -- local ByteDanceAnalysisCls = CS.UnityEngine.AndroidJavaClass("com.bytedance.analysis.ByteDanceAnalysis")
  -- print("初始化巨量")
  -- ByteDanceAnalysisCls:CallStatic("init",xnplusApplication,currentActivity)
  -- print("注册巨量")
end

function StartUpComplete()
  print("lua version :" .._G._VERSION )
  require "Common.GameDefine"
  require "Common.GameGlobal"
  local csUiConfig = IUIContextMgr.uiConfig
  local itemConfigs = csUiConfig.itemConfigs
  local itemConfigLength = itemConfigs.Length 
  for i = 0 , itemConfigLength - 1 do 
    local c = itemConfigs[i]
    local contextClassName = c.contextClassName
    if c.isLua and IsNull(contextClassName) == false and contextClassName ~= "" then
      local uiName = c.name
      local cls = require( contextClassName) 
      local c = cls.New(uiName)
      UIContextMgr:GetInstance():RegistContext( uiName , c )
    end
    UIContextMgr:GetInstance():SetUIConfig(c.name,c)
  end
  -- for uiName,config in pairs(UIConfig) do
  --     if config.Context  then
  --         local cls = require( config.Context) 
  --         local c = cls.New(uiName)
  --         UIContextMgr:GetInstance():RegistContext( uiName , c )
  --     end
  -- end
  UpdateManager:GetInstance():Startup()
	TimerManager:GetInstance():Startup()
  InitProtobuf()
  InitByteDance()
end

local key = ""
function PrintTable(table , level)
  level = level or 1
  local indent = ""
  for i = 1, level do
    indent = indent.."  "
  end

  if key ~= "" then
    print(indent..key.." ".."=".." ".."{")
  else
    print(indent .. "{")
  end

  key = ""
  for k,v in pairs(table) do
     if type(v) == "table" then
        key = k
        PrintTable(v, level + 1)
     else
        local content = string.format("%s%s = %s", indent .. "  ",tostring(k), tostring(v))
      print(content)  
      end
  end
  print(indent .. "}")

end


