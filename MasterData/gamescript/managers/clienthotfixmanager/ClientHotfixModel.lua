local CodeVersion = require("GameLauncher.CodeVersion")

local function createClientHotfixModelState()
  local state = {}
  state.currentHotfixId = Vue.ref(tonumber(CodeVersion))
  state.clientVersion = CodeVersion
  return state
end

local function createClientHotfixModelViews()
  local views = {}
  
  function views:getFunction()
  end
  
  return views
end

local function createClientHotfixModelActions()
  local actions = {}
  
  function actions:setHotfixId(version)
    if version > self.currentHotfixId then
      Logger.Info("达到新的Hotfix高度 %s -> %s", self.currentHotfixId, version)
      self.currentHotfixId = version
    else
      Logger.Info("忽略老的Hotfix高度 %s -> %s", self.currentHotfixId, version)
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local ClientHotfixModel = Vue.model("ClientHotfixModel", createClientHotfixModelState):views(createClientHotfixModelViews):actions(createClientHotfixModelActions):setup(onSetup)
return ClientHotfixModel
