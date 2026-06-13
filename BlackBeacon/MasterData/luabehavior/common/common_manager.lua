local ComnMgr = Util.create_class()

function ComnMgr._init(mgr, manager_path, globalScope)
  mgr.file_id = manager_path
  globalScope.ComnMgr = mgr
  globalScope.vec3 = require("base.vec3")
  globalScope.mathx = require("base.mathx")
  return mgr:importClasses()
end

function ComnMgr.importClasses(mgr)
  local classes = {
    DebugConfig = import("common.debug_config"),
    BehaviorBase = import("common.base.behavior_base"),
    RoleBase = import("character.base.role_base"),
    ToolBase = import("common.tool"),
    RoleTool = import("common.role_tool"),
    MonsterTool = import("common.monster_tool"),
    MonsterGroup = import("character.base.base_monster_group"),
    UltMgr = import("character.base.base_ultManager"),
    LinkMgr = import("character.base.base_linkManager"),
    LinkChanceBase = import("base.role.linkSystem.linkChance.linkChance"),
    LinkChanceSmall = import("base.role.linkSystem.linkChance.chanceImp.smallChance"),
    LinkChanceBig = import("base.role.linkSystem.linkChance.chanceImp.bigChance"),
    RampMgr = import("character.base.base_rampageManager")
  }
  for name, class in pairs(classes) do
    mgr[name] = class
  end
  mgr.classes = classes
end

function ComnMgr.on_start(mgr)
  return mgr:setUpClasses()
end

function ComnMgr.setUpClasses(mgr)
  local classes = mgr.classes
  for _, class in pairs(classes) do
    if rawget(class, "setUp") then
      class:setUp()
    end
  end
end

function ComnMgr:on_frame_update(dt)
end

function ComnMgr:on_clear_manager()
  for _, class in pairs(self.classes) do
    if class.on_clear_manager then
      class:on_clear_manager()
    end
  end
end

function ComnMgr:on_destroy_mamager()
  for _, class in pairs(self.classes) do
    if class.on_destroy_mamager then
      class:on_destroy_mamager()
    end
  end
  self.classes = nil
end

return ComnMgr
