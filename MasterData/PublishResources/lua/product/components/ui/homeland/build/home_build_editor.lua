_class("HomeBuildEditor", Object)
HomeBuildEditor = HomeBuildEditor

function HomeBuildEditor:Constructor(input)
  self._mdfs = {}
  self._curMdf = nil
end

function HomeBuildEditor:Enter()
end

function HomeBuildEditor:Exit()
end

function HomeBuildEditor:Update(dt)
end

function HomeBuildEditor:Dispose()
  self._mdfs = nil
  self._curMdf = nil
end
