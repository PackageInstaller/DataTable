_class("SMazePropBase", Object)
SMazePropBase = SMazePropBase

function SMazePropBase:Constructor(id, count)
  self._id = id
  self._count = count
  local cfg = Cfg.cfg_component_season_maze_once({OnceID = id})[1]
  self._type = cfg.Type
  self._cfgID = cfg.ID
end

function SMazePropBase:ID()
  return self._id
end

function SMazePropBase:Count()
  return self._count
end

function SMazePropBase:Type()
  return self._type
end

function SMazePropBase:CfgID()
  return self._cfgID
end

function SMazePropBase:Use(TT)
  return false
end
