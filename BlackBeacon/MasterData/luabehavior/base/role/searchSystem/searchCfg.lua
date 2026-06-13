local weightCfgBase = import("base.role.searchSystem.searchWeightCfg")
local targetRecordBase = import("base.role.searchSystem.targetRecord")
local nilTable = Const.NIL_TABLE
local INPUT_TYPE = Const.ROLE_SEARCH_INPUT_TYPE
local WEIGHT_TYPE = Const.ROLE_SEARCH_WEIGHT_TYPE
local tempInputs = {
  [INPUT_TYPE.DIRECTIONAL] = {},
  [INPUT_TYPE.NO_INPUT] = {},
  [INPUT_TYPE.INDI] = {}
}
local tempWeights = {}
local INPUT2IDX = {
  [INPUT_TYPE.DIRECTIONAL] = 1,
  [INPUT_TYPE.NO_INPUT] = 2,
  [INPUT_TYPE.INDI] = 3
}
local searchBase = Util.create_class()

function searchBase.new(base, cfg, name)
  local search = setmetatable({}, base)
  search.name = name
  cfg = cfg or nilTable
  search.needCull = cfg.NeedCull
  search.secRadius = cfg.SecRadius or cfg.IndicatorSecRadius or 5
  search.secAngle = cfg.SecAngle or cfg.IndicatorSecAngle or 60
  search.maxDis = cfg.MaxDistance or cfg.IndicatorMaxDist or 10
  local tempInputs, tempWeights = tempInputs, tempWeights
  tempWeights.dist = cfg.SearchDistWeight or nilTable
  tempWeights.angle = cfg.SearchAngleWeight or nilTable
  tempWeights.density = cfg.SearchDensityWeight or nilTable
  tempWeights.viscous = cfg.SearchViscousWeight or nilTable
  tempWeights.hp = cfg.SearchHpWeight or nilTable
  tempWeights.dedup = cfg.SearchDedupWeight or nilTable
  tempWeights.occlus = cfg.SearchOcclusWeight or nilTable
  local weightCfg
  local CUSTOM = WEIGHT_TYPE.CUSTOM
  for inputType, idx in pairs(INPUT2IDX) do
    weightCfg = tempInputs[inputType]
    for _, weightType in pairs(WEIGHT_TYPE) do
      if weightType ~= CUSTOM then
        weightCfg[weightType] = tempWeights[weightType][idx]
      end
    end
  end
  search.directional = weightCfgBase:new(tempInputs.directional)
  search.noInput = weightCfgBase:new(tempInputs.noInput)
  if cfg.IconName then
    search.indi = weightCfgBase:new(tempInputs.indi)
  end
  return search
end

function searchBase.update(cfg, inputType)
  if inputType and cfg[inputType] then
    return cfg[inputType]:update()
  else
    local param
    for _, type in pairs(INPUT_TYPE) do
      param = cfg[type]
      if param then
        param:update()
      end
    end
  end
end

searchBase.EMPTY = searchBase:new()

function searchBase.create(base, tbl)
  tbl = tbl or {}
  local weightCfgBase = weightCfgBase
  tbl.directional = weightCfgBase:create(tbl.directional)
  tbl.noInput = weightCfgBase:create(tbl.noInput)
  if tbl.indi then
    tbl.indi = weightCfgBase:create(tbl.indi)
  end
  UtilTable.fill_table(base.EMPTY, tbl, true)
  setmetatable(tbl, base)
  return tbl
end

function searchBase.getDefaultCfg(base)
  return base:create({
    name = "basicSearchCfg",
    maxDis = 10,
    secRadius = 5,
    secAngle = 60,
    directional = {
      dist = {
        enable = true,
        weight = 8,
        ratio = -2,
        idealDis = 0
      },
      angle = {
        enable = true,
        weight = 5,
        ratio = -0.05
      },
      viscous = {enable = true, weight = 3}
    },
    noInput = {
      dist = {
        enable = true,
        weight = 10,
        ratio = -2,
        idealDis = 0
      },
      viscous = {enable = true, weight = 2}
    }
  })
end

function searchBase.getTarRecord(cfg)
  local tarRecord = cfg.tarRecord
  if tarRecord then
    return tarRecord
  end
  tarRecord = targetRecordBase:new()
  cfg.tarRecord = tarRecord
  return tarRecord
end

function searchBase.clearTarRecord(cfg)
  local tarRecord = cfg.tarRecord
  return tarRecord and tarRecord:clear()
end

function searchBase.setCustom(cfg, custom)
  local weightCfg
  for _, inputType in pairs(Const.ROLE_SEARCH_INPUT_TYPE) do
    weightCfg = cfg[inputType]
    if weightCfg then
      weightCfg.custom = custom
    end
  end
end

do return searchBase end

function searchBase.copy(ori, name)
  local result = setmetatable({}, searchBase)
  result.name = name or ori.name
  result.needCull = ori.needCull
  result.maxDis = ori.maxDis
  result.secRadius = ori.secRadius
  result.secAngle = ori.secAngle
  local directional = {}
  local dir_ori = ori.directional
  for weightName, weightParams in pairs(dir_ori) do
    local params = {}
    for key, value in pairs(weightParams) do
      params[key] = value
    end
    directional[weightName] = params
  end
  result.directional = directional
  local noInput = {}
  local noInput_ori = ori.directional
  for weightName, weightParams in pairs(noInput_ori) do
    local params = {}
    for key, value in pairs(weightParams) do
      params[key] = value
    end
    noInput[weightName] = params
  end
  result.noInput = noInput
  local indi_ori = ori.directional
  if indi_ori then
    local indi = {}
    for weightName, weightParams in pairs(indi_ori) do
      local params = {}
      for key, value in pairs(weightParams) do
        params[key] = value
      end
      indi[weightName] = params
    end
    result.indi = indi
  end
end
