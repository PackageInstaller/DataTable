_class("FSMFactory", Singleton)

function FSMFactory:Constructor()
end

function FSMFactory:SetConfig(config)
  self._configMng = config
end

function FSMFactory:CreateFSM(genInfo)
  local cfgID = genInfo.ConfigID
  local config = self._configMng[cfgID]
  if not config then
    Log.fatal("CreateLogic Cant Find Config : id = " .. cfgID)
    return nil
  end
  local logic = CustomLogic:New()
  local context = {}
  context.GenInfo = genInfo
  context.Logic = logic
  context.ConfigMng = self._configMng
  logic:InitializeNode(config, context)
  return logic
end

function FSMFactory:DestroyFSM(logic)
  logic:Destroy()
end
