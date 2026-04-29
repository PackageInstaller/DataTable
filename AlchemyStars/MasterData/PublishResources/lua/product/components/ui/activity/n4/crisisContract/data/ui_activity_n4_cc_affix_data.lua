_class("UIActivityN4CCAffixData", Object)
UIActivityN4CCAffixData = UIActivityN4CCAffixData

function UIActivityN4CCAffixData:Constructor(config)
  self._missionAffixId = config.ID
  local id = config.AffixID
  local cfgs = Cfg.cfg_affix({ID = id})
  if cfgs == nil or #cfgs <= 0 then
    return
  end
  local cfg = cfgs[1]
  self._id = id
  local paramsCfg = cfg.EntryParam
  local params = {}
  if paramsCfg and paramsCfg[1] then
    local p = paramsCfg[1]
    for k, v in ipairs(p) do
      if type(v) == "string" then
        params[#params + 1] = StringTable.Get(v)
      elseif type(v) == "number" then
        params[#params + 1] = v
      end
    end
  end
  self._des = StringTable.Get(cfg.Desc, table.unpack(params))
  self._des = string.gsub(self._des, "#FFFFFF", "#fcd606")
end

function UIActivityN4CCAffixData:GetMissionAffixId()
  return self._missionAffixId
end

function UIActivityN4CCAffixData:GetId()
  return self._id
end

function UIActivityN4CCAffixData:GetDes()
  return self._des
end
