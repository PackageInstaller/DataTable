local searchBase = Util.create_class()

function searchBase.new(base, cfg, name)
  local search = setmetatable({}, base)
  search.name = name
  cfg = cfg or {}
  search.needCull = cfg.NeedCull
  search.secRadius = cfg.SecRadius or cfg.IndicatorSecRadius or 5
  search.secAngle = cfg.SecAngle or cfg.IndicatorSecAngle or 60
  search.maxDis = cfg.MaxDistance or cfg.IndicatorMaxDist or 10
  local distConfig = cfg.SearchDistWeight or {}
  local angleConfig = cfg.SearchAngleWeight or {}
  local densityConfig = cfg.SearchDensityWeight or {}
  local viscousConfig = cfg.SearchViscousWeight or {}
  local hpConfig = cfg.SearchHpWeight or {}
  do
    local dirConfig = {
      dist = {
        weight = distConfig[1],
        ratio = distConfig[2],
        idealDis = distConfig[3]
      },
      angle = {
        weight = angleConfig[1],
        ratio = angleConfig[2]
      },
      density = {
        weight = densityConfig[1],
        ratio = densityConfig[2],
        maxAngle = densityConfig[3],
        maxDis = densityConfig[4]
      },
      viscous = {
        weight = viscousConfig[1]
      },
      hp = {
        weight = hpConfig[1]
      }
    }
    search.directional = dirConfig
  end
  do
    local noInputConfig = {
      dist = {
        weight = distConfig[4],
        ratio = distConfig[5],
        idealDis = distConfig[6]
      },
      angle = {
        weight = angleConfig[3],
        ratio = angleConfig[4]
      },
      density = {
        weight = densityConfig[5],
        ratio = densityConfig[6],
        maxAngle = densityConfig[7],
        maxDis = densityConfig[8]
      },
      viscous = {
        weight = viscousConfig[2]
      },
      hp = {
        weight = hpConfig[2]
      }
    }
    search.noInput = noInputConfig
  end
  if not cfg.IconName then
  else
    local indiConfig = {
      dist = {
        weight = distConfig[7],
        ratio = distConfig[8],
        idealDis = distConfig[9]
      },
      angle = {
        weight = angleConfig[5],
        ratio = angleConfig[6]
      },
      density = {
        weight = densityConfig[9],
        ratio = densityConfig[10],
        maxAngle = densityConfig[11],
        maxDis = densityConfig[12]
      },
      viscous = {
        weight = viscousConfig[3]
      },
      hp = {
        weight = hpConfig[3]
      }
    }
    search.indi = indiConfig
  end
  search:update()
  return search
end

function searchBase.create(base, cfg)
  if not cfg.directional then
    cfg.directional = {
      dist = {},
      angle = {},
      density = {},
      viscous = {},
      hp = {}
    }
  else
    local dirConfig = cfg.directional
    if not dirConfig.dist then
      dirConfig.dist = {}
    end
    if not dirConfig.angle then
      dirConfig.angle = {}
    end
    if not dirConfig.density then
      dirConfig.density = {}
    end
    if not dirConfig.viscous then
      dirConfig.viscous = {}
    end
    if not dirConfig.hp then
      dirConfig.hp = {}
    end
  end
  if not cfg.noInput then
    cfg.noInput = {
      dist = {},
      angle = {},
      density = {},
      viscous = {},
      hp = {}
    }
  else
    local noInput = cfg.noInput
    if not noInput.dist then
      noInput.dist = {}
    end
    if not noInput.angle then
      noInput.angle = {}
    end
    if not noInput.density then
      noInput.density = {}
    end
    if not noInput.viscous then
      noInput.viscous = {}
    end
    if not noInput.hp then
      noInput.hp = {}
    end
  end
  setmetatable(cfg, base)
  cfg:update()
  return cfg
end

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

function searchBase.update(search)
  do
    local dirConfig = search.directional
    dirConfig.dist.enable = dirConfig.dist.weight and dirConfig.dist.ratio and dirConfig.dist.idealDis and (0 ~= dirConfig.dist.weight or 0 ~= dirConfig.dist.ratio)
    dirConfig.angle.enable = dirConfig.angle.weight and dirConfig.angle.ratio and (0 ~= dirConfig.angle.weight or 0 ~= dirConfig.angle.weight)
    dirConfig.density.enable = dirConfig.density.weight and dirConfig.density.ratio and dirConfig.density.maxAngle and dirConfig.density.maxDis and (0 ~= dirConfig.density.weight or 0 ~= dirConfig.density.ratio)
    dirConfig.density.halfAngle = dirConfig.density.maxAngle and dirConfig.density.maxAngle / 2
    dirConfig.viscous.enable = dirConfig.viscous.weight and 0 ~= dirConfig.viscous.weight
    dirConfig.hp.enable = dirConfig.hp.weight and 0 ~= dirConfig.hp.weight
  end
  do
    local noInputConfig = search.noInput
    noInputConfig.dist.enable = noInputConfig.dist.weight and noInputConfig.dist.ratio and noInputConfig.dist.idealDis and (0 ~= noInputConfig.dist.weight or 0 ~= noInputConfig.dist.ratio)
    noInputConfig.angle.enable = noInputConfig.angle.weight and noInputConfig.angle.ratio and (0 ~= noInputConfig.angle.weight or 0 ~= noInputConfig.angle.weight)
    noInputConfig.density.enable = noInputConfig.density.weight and noInputConfig.density.ratio and noInputConfig.density.maxAngle and noInputConfig.density.maxDis and (0 ~= noInputConfig.density.weight or 0 ~= noInputConfig.density.ratio)
    noInputConfig.density.halfAngle = noInputConfig.density.maxAngle and noInputConfig.density.maxAngle / 2
    noInputConfig.viscous.enable = noInputConfig.viscous.weight and 0 ~= noInputConfig.viscous.weight
    noInputConfig.hp.enable = noInputConfig.hp.weight and 0 ~= noInputConfig.hp.weight
  end
  do
    local indiConfig = search.indi
    if not indiConfig then
      return
    end
    indiConfig.dist.enable = indiConfig.dist.weight and indiConfig.dist.ratio and indiConfig.dist.idealDis and (0 ~= indiConfig.dist.weight or 0 ~= indiConfig.dist.ratio)
    indiConfig.angle.enable = indiConfig.angle.weight and indiConfig.angle.ratio and (0 ~= indiConfig.angle.weight or 0 ~= indiConfig.angle.weight)
    indiConfig.density.enable = indiConfig.density.weight and indiConfig.density.ratio and indiConfig.density.maxAngle and indiConfig.density.maxDis and (0 ~= indiConfig.density.weight or 0 ~= indiConfig.density.ratio)
    indiConfig.density.halfAngle = indiConfig.density.maxAngle and indiConfig.density.maxAngle / 2
    indiConfig.viscous.enable = indiConfig.viscous.weight and 0 ~= indiConfig.viscous.weight
    indiConfig.hp.enable = indiConfig.hp.weight and 0 ~= indiConfig.hp.weight
  end
end

do return searchBase end
do
  local param = {}
  param.dist = {
    enable = nil,
    weight = nil,
    ratio = nil,
    idealDis = nil
  }
  param.angle = {
    enable = nil,
    weight = nil,
    ratio = nil
  }
  param.density = {
    enable = nil,
    weight = nil,
    ratio = nil,
    maxAngle = nil,
    halfAngle = nil,
    idealDis = nil
  }
  param.viscous = {enable = nil, weight = nil}
  param.hp = {enable = nil, weight = nil}
  
  function param.custom(role, npc)
  end
end
