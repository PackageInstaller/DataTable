if UnityEngine.Application.isPlaying and IsUnityEditor() then
  HotReload = {}
  
  function HotReload.reloadUIController(filePath)
    local file = io.open(filePath, "r")
    Log.debug("Reload lua ", filePath)
    if file then
      local content = file:read("a")
      file:close()
      local classNameList = ArrayList:New()
      for className in string.gmatch(content, "_class%(%s*\"([^%s]+)\"") do
        classNameList:PushBack(className)
      end
      local isUIController = false
      for id = 1, classNameList:Size() do
        if IsSubClassOf(classNameList:GetAt(id), "UIController") then
          isUIController = true
          break
        end
      end
      local isUIWidget = false
      for id = 1, classNameList:Size() do
        if IsSubClassOf(classNameList:GetAt(id), "UICustomWidget") then
          isUIWidget = true
          break
        end
      end
      if not isUIController and not isUIWidget then
        return
      end
      for id = 1, classNameList:Size() do
        _removeClass(classNameList:GetAt(id))
      end
      local fileName = HotReload.getLuaName(filePath)
      package.loaded[fileName] = nil
      require(fileName)
    end
  end
  
  function HotReload.reloadConfig(filePath)
    local cfgName = HotReload.getLuaName(filePath)
    CfgClear(cfgName)
    if cfgName == "cfg_lod" then
      package.loaded[cfgName] = nil
      require(cfgName)
    end
  end
  
  function HotReload.reloadCoreGameLua(filePath)
    local file = io.open(filePath, "r")
    Log.debug("Reload lua ", filePath)
    if file then
      local content = file:read("a")
      file:close()
      local classNameList = ArrayList:New()
      for className in string.gmatch(content, "_class%(%s*\"([^%s]+)\"") do
        classNameList:PushBack(className)
      end
      for id = 1, classNameList:Size() do
        _removeClass(classNameList:GetAt(id))
      end
      local fileName = HotReload.getLuaName(filePath)
      package.loaded[fileName] = nil
      require(fileName)
    end
  end
  
  function HotReload.getLuaName(filePath)
    local _, _, fileName = string.find(filePath, "/([^/]+)%.lua$")
    return fileName
  end
end
