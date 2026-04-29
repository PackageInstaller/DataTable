_class("SeasonMazeAsset", Object)
SeasonMazeAsset = SeasonMazeAsset

function SeasonMazeAsset:Constructor(type, name, count, icon, desc, param)
  self._type = type
  self._name = name
  self._count = count
  self._desc = desc
  self._icon = icon
  self._subParam = param
end

function SeasonMazeAsset:Type()
  return self._type
end

function SeasonMazeAsset:SubParam()
  return self._subParam
end

function SeasonMazeAsset:Name()
  return StringTable.Get(self._name)
end

function SeasonMazeAsset:Icon()
  return self._icon
end

function SeasonMazeAsset:Count()
  return self._count
end

function SeasonMazeAsset:Desc()
  return StringTable.Get(self._desc)
end

function SeasonMazeAsset:Equal(other)
  return self:Type() == other.Type() and self:SubParam() == other.SubParam()
end
