local CommunityCfgUtils = {}

function CommunityCfgUtils.GetCommunityNameList()
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "Community"
end

function CommunityCfgUtils.GetCommunityConstantKey(communityName)
  return "CommunityUrl_" .. communityName
end

local CommunityUrlDict = {}

function CommunityCfgUtils.GetCommunityUrl(targetCommunityName, targetPublishArea)
  local targetCfgKey = CommunityCfgUtils.GetCommunityConstantKey(targetCommunityName)
  local targetCommunityCfg = DT.GetOriginalConstant(targetCfgKey)
  if not targetCommunityCfg then
    return nil
  end
  if not table.next(CommunityUrlDict) then
    for _, communityName in pairs(CommunityDefine.CommunityName) do
      local cfgKey = CommunityCfgUtils.GetCommunityConstantKey(communityName)
      local communityCfg = DT.GetOriginalConstant(cfgKey) or {}
      for i = 1, #communityCfg, 2 do
        local publishArea = communityCfg[i]
        local url = communityCfg[i + 1]
        if not CommunityUrlDict[communityName] then
          CommunityUrlDict[communityName] = {}
        end
        CommunityUrlDict[communityName][publishArea] = url
      end
    end
  end
  if not CommunityUrlDict[targetCommunityName] then
    return nil
  end
  targetPublishArea = targetPublishArea or CommunityDefine.PublishArea.default
  if not CommunityUrlDict[targetCommunityName][targetPublishArea] then
    targetPublishArea = CommunityDefine.PublishArea.default
  end
  return CommunityUrlDict[targetCommunityName][targetPublishArea]
end

return CommunityCfgUtils
