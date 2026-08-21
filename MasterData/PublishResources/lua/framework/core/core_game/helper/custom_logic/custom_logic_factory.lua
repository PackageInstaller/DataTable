_class("CustomLogicGenInfo", Object)
CustomLogicGenInfo = CustomLogicGenInfo

function CustomLogicGenInfo:Constructor()
  self.CustomLogicConfigID = -1
  self.CustomLogicConfigTable = nil
end

_staticClass("CustomLogicFactory")
CustomLogicFactory.CreateIndexTable = {}

function CustomLogicFactory.Static_CreateLogic(genInfo)
  local cfgID = genInfo.CustomLogicConfigID
  local config = genInfo.CustomLogicConfigTable[cfgID]
  if not config then
    Log.fatal("CreateLogic Cant Find Config : id = " .. cfgID)
    return nil
  end
  local logic = Classes[config.Type]:New()
  logic.InstanceID = CustomLogicFactory.Static_GenerateInstanceID(config.Type)
  local context = CustomNodeContext:New(genInfo, logic, genInfo.CustomLogicConfigTable)
  logic:InitializeNode(config, context)
  logic.CustomLogicID = cfgID
  logic.CustomLogicType = config.Type
  return logic
end

function CustomLogicFactory.Static_DestroyLogic(logic)
  logic:Destroy()
end

function CustomLogicFactory.Static_GenerateInstanceID(custom_logic_type)
  local type_create_index = CustomLogicFactory.CreateIndexTable[custom_logic_type]
  if type_create_index then
    type_create_index = type_create_index + 1
  else
    type_create_index = 1
  end
  CustomLogicFactory.CreateIndexTable[custom_logic_type] = type_create_index
  return type_create_index
end
