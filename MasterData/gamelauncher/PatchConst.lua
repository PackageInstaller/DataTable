local PatchConst = {}
PatchConst.__SvnVersion = 248623
PatchConst.__PatchVersion = 136
PatchConst.__PatchShowVersion = "V2.6.0.0_D248609_A248623_C248623"

function PatchConst.GetSvnVersion()
  return PatchConst.__SvnVersion
end

function PatchConst.GetPatchVersion()
  return PatchConst.__PatchVersion
end

function PatchConst.GetShowVersion()
  return PatchConst.__PatchShowVersion
end

return PatchConst
