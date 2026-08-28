local DataModel = {
  headBookId = 80900004,
  allHeadInfoList = {},
  roleHeadInfoList = {},
  activityHeadInfoList = {},
  specialHeadInfoList = {},
  headType = {
    all = 1,
    role = 2,
    activity = 3,
    special = 4
  },
  curSortType = 0,
  curHeadType = 0,
  curHeadList = {},
  keyHeadInfoList = {},
  headHadList = {}
}

function DataModel.InitHeadInfo()
  DataModel.allHeadInfoList = {}
  DataModel.keyHeadInfoList = {}
  DataModel.roleHeadInfoList = {}
  DataModel.activityHeadInfoList = {}
  DataModel.specialHeadInfoList = {}
  DataModel.InitHadList()
  local ca = PlayerData:GetFactoryData(DataModel.headBookId, "BookFactory")
  if not ca then
    return
  end
  local profilePhotoList = ca.profilePhotoList or {}
  for i = 1, #profilePhotoList do
    local headCa = PlayerData:GetFactoryData(profilePhotoList[i].id, "ProfilePhotoFactory")
    if headCa then
      local isGenRight = true
      if headCa.isDriver then
        local isMale = true
        local serverData = PlayerData.ServerData
        if serverData ~= nil and serverData.user_info ~= nil and serverData.user_info.gender == 0 then
          isMale = false
        end
        if headCa.isDriverMale and isMale or headCa.isDriverMale == false and isMale == false then
          isGenRight = true
        else
          isGenRight = false
        end
      end
      if isGenRight then
        table.insert(DataModel.allHeadInfoList, headCa)
        if headCa.isRole then
          table.insert(DataModel.roleHeadInfoList, headCa)
        end
        if headCa.isActivity then
          table.insert(DataModel.activityHeadInfoList, headCa)
        end
        if headCa.isSpecial then
          table.insert(DataModel.specialHeadInfoList, headCa)
        end
      end
    end
  end
end

function DataModel.GetHeadListByType()
  if DataModel.allHeadInfoList == nil or #DataModel.allHeadInfoList == 0 then
    DataModel.InitHeadInfo()
  end
  if DataModel.allHeadInfoList == nil or #DataModel.allHeadInfoList == 0 then
    return {}
  end
  local key = tostring(DataModel.curHeadType) .. "_" .. tostring(DataModel.curSortType)
  if DataModel.keyHeadInfoList[key] then
    return DataModel.keyHeadInfoList[key]
  end
  local headList = {}
  if DataModel.curHeadType == DataModel.headType.all then
    headList = DataModel.allHeadInfoList
  elseif DataModel.curHeadType == DataModel.headType.role then
    headList = DataModel.roleHeadInfoList
  elseif DataModel.curHeadType == DataModel.headType.activity then
    headList = DataModel.activityHeadInfoList
  elseif DataModel.curHeadType == DataModel.headType.special then
    headList = DataModel.specialHeadInfoList
  end
  if DataModel.curSortType == 0 then
    table.sort(headList, function(a, b)
      if a.sort > b.sort then
        return true
      end
      if a.sort < b.sort then
        return false
      end
      return a.id < b.id
    end)
  else
    table.sort(headList, function(a, b)
      local aHad = DataModel.GetAvatarHeadIsGet(a.id)
      local bHad = DataModel.GetAvatarHeadIsGet(b.id)
      if aHad == true and bHad == false then
        return true
      end
      if aHad == false and bHad == true then
        return false
      end
      if a.sort > b.sort then
        return true
      end
      if a.sort < b.sort then
        return false
      end
      return a.id < b.id
    end)
  end
  DataModel.keyHeadInfoList[key] = Clone(headList)
  return headList
end

function DataModel.InitHadList()
  DataModel.headHadList = {}
  local userInfo = PlayerData:GetUserInfo()
  if userInfo == nil then
    return
  end
  local avatar_list = userInfo.avatar_list
  if not avatar_list then
    return
  end
  for k, v in pairs(avatar_list) do
    DataModel.headHadList[tostring(v)] = 1
  end
end

function DataModel.GetAvatarHeadIsGet(headId)
  if not DataModel.headHadList then
    return false
  end
  return DataModel.headHadList[tostring(headId)] == 1
end

function DataModel.GetCurSortHeadProgress()
  if not DataModel.curHeadList then
    return 0, 0
  end
  local hasCount = 0
  local allCount = #DataModel.curHeadList
  for i = 1, #DataModel.curHeadList do
    local isGet = DataModel.GetAvatarHeadIsGet(DataModel.curHeadList[i].id)
    if isGet then
      hasCount = hasCount + 1
    end
  end
  return hasCount, allCount
end

function DataModel.GetFirstOpenSelectIndex()
  if not DataModel.curHeadList then
    return 1
  end
  local userInfo = PlayerData:GetUserInfo()
  if not userInfo or not userInfo.avatar then
    return 1
  end
  for i = 1, #DataModel.curHeadList do
    if tonumber(userInfo.avatar) == DataModel.curHeadList[i].id then
      return i
    end
  end
  return 1
end

return DataModel
