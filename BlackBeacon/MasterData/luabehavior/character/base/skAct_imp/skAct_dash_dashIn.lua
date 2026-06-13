local dashBase = import("character.base.skAct_imp.skAct_dash")
local dashInBase = Util.create_child_mt(dashBase)
dashInBase._dashInBase = dashInBase
dashInBase.dashInBase = dashInBase
dashInBase.search_config = {
  secAngle = 45,
  secRadius = 10,
  maxDis = nil,
  directional = {
    dist = {weight = 6, idealDis = 3},
    viscous = {weight = 2}
  }
}

function dashInBase.setClass(customDashInBase, actBases)
  local ret = customDashInBase or dashInBase
  local newParent = actBases.dash
  if newParent ~= dashBase and ret == dashInBase then
    ret = {}
  end
  if ret ~= dashInBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.dashInBase = ret.dashInBase or ret
    ret.search_config = UtilTable.fill_table(dashInBase.search_config, ret.search_config)
    UtilTable.fill_table(dashInBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function dashInBase.new(customDashInBase, role, _cfg)
  local dashIn = setmetatable({}, customDashInBase)
  dashIn.base = customDashInBase
  dashIn.type = Const.SKILL_ACTION_TYPE.DASH_IN
  customDashInBase:_init(dashIn, role, _cfg)
  return dashIn
end

function dashInBase._init(customDashInBase, dashIn, role, _cfg)
  dashIn.dashInBase = dashInBase
  customDashInBase.dashBase:_init(dashIn, role, _cfg)
  local cfg = _cfg or {}
  local dist_weight_config = cfg.SearchDistWeight and cfg.SearchDistWeight[1]
  local dist_idealDis_config = cfg.SearchDistWeight and cfg.SearchDistWeight[3]
  local vis_weight_config = cfg.SearchViscousWeight and cfg.SearchViscousWeight[1]
  local search = dashIn.search
  local searchBase = dashInBase.search_config
  search.secRadius = cfg.secRadius or searchBase.secRadius
  search.secAngle = cfg.secAngle or searchBase.secAngle
  search.directional.dist.weight = search.directional.dist.weight or dist_weight_config
  search.directional.dist.idealDis = search.directional.dist.idealDis or dist_idealDis_config
  search.directional.viscous.weight = search.directional.viscous.weight or vis_weight_config
  search:update()
end

function dashInBase.isCommon()
end

function dashInBase.isDashIn()
  return true
end

function dashInBase.isReady(dashIn)
  if not dashIn.dashBase.isReady(dashIn) then
    return false
  end
  local inputDir = get_joystick_target_pos(dashIn.role.npc)
  return math.abs(inputDir.x) > 0.01 or math.abs(inputDir.z) > 0.01
end

function dashInBase.tarPos(dashIn)
  local tarPos = dashIn._tarPos
  local role = dashIn.role
  role:searchTarget(dashIn.search)
  tarPos:SetB(get_joystick_target_pos(dashIn.role.npc))
  return tarPos
end

return dashInBase
