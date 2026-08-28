local DataModel = {
  RoleId = {},
  CurrentUnitId = nil,
  CurrentUnitCA = nil,
  SkinUnitViewId = nil,
  ReceptionistData = nil,
  EffectState = nil,
  SkinBgState = nil,
  Live2DState = nil,
  ScaleState = nil,
  UnitViewCRRState = nil,
  ChooseUnitViewId = nil,
  SkinUnitViewIsSpine = nil,
  RightChooseIndex = nil,
  isLock = true,
  Scene = nil,
  isSpine2 = nil,
  isVideo = nil,
  PosX = nil,
  PosY = nil,
  SkinPreviewChooseIndex = nil,
  CurrentRoleData = nil,
  PosterGirlChangeSpine = nil,
  NeedSerializeOnGetwayJump = nil
}
DataModel.TypeList = {
  EffectState = "EffectState",
  SkinBgState = "SkinBgState",
  Live2DState = "Live2DState",
  ScaleStateNum = "ScaleStateNum",
  PositionXState = "PositionXState",
  PositionYState = "PositionYState",
  UnitViewIdState = "UnitViewIdState",
  UnitViewCRRState = "UnitViewCRRState",
  UnitViewIdIsSpineState = "UnitViewIdIsSpineState",
  PosterGirlSpineIndexState = "PosterGirlSpineIndexState"
}
DataModel.TopScreen = {
  isRarityUp = 1,
  isRarityDown = 2,
  isTimeUp = 3,
  isTimeDown = 4
}
DataModel.CurrentTopScreen = nil
DataModel.InfoInitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1,
  offsetX = 0,
  offsetY = 1
}

function DataModel.MarkSerializeOnGetwayJump()
  DataModel.NeedSerializeOnGetwayJump = true
end

function DataModel.ConsumeSerializeOnGetwayJump()
  local needSerialize = DataModel.NeedSerializeOnGetwayJump
  DataModel.NeedSerializeOnGetwayJump = nil
  return needSerialize
end

function DataModel.SetRoleId(isEvent, directData)
  local netData = PlayerData.ServerData.user_info
  if isEvent then
    if netData.guardId ~= "" then
      return {
        [1] = netData.guardId
      }
    else
      local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
      local tempId
      if netData.gender == 0 then
        tempId = defaultConfig.playerSpineList[1].id
      else
        tempId = defaultConfig.playerSpineList[2].id
      end
      return {
        [1] = tempId
      }
    end
  elseif PlayerData.TempCache.MainUIShowState == require("UIMainUI/UIMainUIDataModel").UIShowEnum.Adjutant then
    DataModel.Scene = "Adjutant"
    if not directData then
      for k, v in ipairs(netData.adjutant_id) do
        if v == "" then
          break
        end
        if DataModel.IsRandomSkin(k) then
          local roleId = DataModel:GetCRRRoleId()
          netData.adjutant_id[k] = tostring(roleId)
        end
      end
    end
    return netData.adjutant_id
  else
    DataModel.Scene = "Main"
    if not directData then
      for k, v in ipairs(netData.receptionist_id) do
        if v == "" then
          break
        end
        if DataModel.IsRandomSkin(k) then
          local roleId = DataModel:GetCRRRoleId()
          netData.receptionist_id[k] = tostring(roleId)
        end
      end
    end
    return netData.receptionist_id
  end
end

function DataModel.IsRandomSkin(index, sceneName)
  return PlayerData:GetPlayerPrefs("int", DataModel.TypeList.UnitViewCRRState .. (sceneName or DataModel.Scene) .. index) == 1
end

function DataModel.SetIsRandomSkin(index, value, sceneName)
  PlayerData:SetPlayerPrefs("int", DataModel.TypeList.UnitViewCRRState .. (sceneName or DataModel.Scene) .. index, value)
end

function DataModel.IsSpine2(roleId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("int", index .. DataModel.TypeList.UnitViewIdIsSpineState .. (sceneName or DataModel.Scene) .. roleId)
end

function DataModel.SetIsSpine2(value, roleId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("int", index .. DataModel.TypeList.UnitViewIdIsSpineState .. (sceneName or DataModel.Scene) .. roleId, value)
end

function DataModel.GetViewId(roleId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("int", index .. DataModel.TypeList.UnitViewIdState .. (sceneName or DataModel.Scene) .. roleId)
end

function DataModel.SetViewId(value, roleId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("int", index .. DataModel.TypeList.UnitViewIdState .. (sceneName or DataModel.Scene) .. roleId, value)
end

function DataModel.IsLive2D(viewId, isSkin2, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("int", index .. DataModel.TypeList.Live2DState .. (sceneName or DataModel.Scene) .. viewId .. isSkin2) == 0
end

function DataModel.SetIsLive2D(value, viewId, isSkin2, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("int", index .. DataModel.TypeList.Live2DState .. (sceneName or DataModel.Scene) .. viewId .. isSkin2, value)
end

function DataModel.GetPosIndex(viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("int", index .. DataModel.TypeList.PosterGirlSpineIndexState .. (sceneName or DataModel.Scene) .. viewId)
end

function DataModel.SetPosIndex(value, viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("int", index .. DataModel.TypeList.PosterGirlSpineIndexState .. (sceneName or DataModel.Scene) .. viewId, value)
end

function DataModel.GetBgState(viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("int", index .. DataModel.TypeList.SkinBgState .. (sceneName or DataModel.Scene) .. viewId) == 0
end

function DataModel.SetBgState(value, viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("int", index .. DataModel.TypeList.SkinBgState .. (sceneName or DataModel.Scene) .. viewId, value)
end

function DataModel.GetScale(viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("float", index .. DataModel.TypeList.ScaleStateNum .. (sceneName or DataModel.Scene) .. viewId)
end

function DataModel.SetScale(value, viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("float", index .. DataModel.TypeList.ScaleStateNum .. (sceneName or DataModel.Scene) .. viewId, value)
end

function DataModel.GetPosX(viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("float", index .. DataModel.TypeList.PositionXState .. (sceneName or DataModel.Scene) .. viewId)
end

function DataModel.SetPosX(value, viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("float", index .. DataModel.TypeList.PositionXState .. (sceneName or DataModel.Scene) .. viewId, value)
end

function DataModel.GetPosY(viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("float", index .. DataModel.TypeList.PositionYState .. (sceneName or DataModel.Scene) .. viewId)
end

function DataModel.SetPosY(value, viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("float", index .. DataModel.TypeList.PositionYState .. (sceneName or DataModel.Scene) .. viewId, value)
end

function DataModel.GetEffectState(viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  return PlayerData:GetPlayerPrefs("float", index .. DataModel.TypeList.EffectState .. (sceneName or DataModel.Scene) .. viewId) == 0
end

function DataModel.SetEffectState(value, viewId, index, sceneName)
  index = index or DataModel.curSelectTab or 1
  PlayerData:SetPlayerPrefs("float", index .. DataModel.TypeList.EffectState .. (sceneName or DataModel.Scene) .. viewId, value)
end

function DataModel:SetHideTime()
  DataModel.HideSliderTime = os.time() + 1.5
end

function DataModel:Init()
  DataModel.curSelectTab = nil
  DataModel.InitTab()
end

function DataModel.InitTab()
  local defaultCfg = PlayerData:GetFactoryData(99900014)
  DataModel.maxTabCount = defaultCfg.mainShowNum
  for k, v in ipairs(DataModel.RoleId) do
    if v and v ~= "" then
      DataModel.showTabCount = k
    elseif v == "" then
      break
    end
  end
  DataModel.realTabCount = DataModel.showTabCount
  if DataModel.showTabCount < DataModel.maxTabCount then
    DataModel.showTabCount = DataModel.showTabCount + 1
  end
end

function DataModel:InitRightRoleList()
  DataModel.RoleList = {}
  local serverRoleList = PlayerData:GetRoles()
  for k, v in pairs(serverRoleList) do
    local row = {}
    row.roleId = v.id
    local ca = PlayerData:GetFactoryData(v.id)
    row.name = ca.name
    local localViewId = DataModel.GetViewId(v.id)
    row.unitViewId = localViewId == 0 and ca.viewId or localViewId
    row.isSpine2 = DataModel.IsSpine2(v.id)
    local isSpine2 = row.isSpine2 == 1
    local unitViewCA = PlayerData:GetFactoryData(row.unitViewId)
    row.face = isSpine2 == true and unitViewCA.State2Face or unitViewCA.face
    row.isSelect = tonumber(row.roleId) == tonumber(DataModel.RoleId[DataModel.curSelectTab])
    row.isTop = 0
    row.obtain_time = v.obtain_time
    row.qualityInt = ca.qualityInt
    if row.isSelect then
      row.isTop = 1
      table.insert(DataModel.RoleList, 1, row)
    else
      table.insert(DataModel.RoleList, row)
    end
  end
  local noHeroSkin = PlayerData.ServerData.skin_no_hero
  if noHeroSkin then
    for unitId, v in pairs(noHeroSkin) do
      local row = {}
      row.roleId = unitId
      local ca = PlayerData:GetFactoryData(unitId, "UnitFactory")
      row.name = ca.name
      local localViewId = DataModel.GetViewId(unitId)
      row.unitViewId = localViewId == 0 and ca.viewId or localViewId
      row.isSpine2 = 0
      local unitViewCA = PlayerData:GetFactoryData(row.unitViewId, "UnitViewFactory")
      local needShow = false
      if 1 < DataModel.curSelectTab then
        for m, n in pairs(v) do
          local tempSkin = PlayerData:GetFactoryData(n)
          if not tempSkin.videoSpine and not tempSkin.moveBoolen then
            needShow = true
            break
          end
        end
      else
        needShow = true
      end
      row.face = unitViewCA.face
      row.isSelect = tonumber(row.roleId) == tonumber(DataModel.RoleId[DataModel.curSelectTab])
      row.isTop = 0
      row.obtain_time = TimeUtil:GetServerTimeStamp()
      row.qualityInt = ca.qualityInt
      if needShow then
        if row.isSelect then
          row.isTop = 1
          table.insert(DataModel.RoleList, 1, row)
        else
          table.insert(DataModel.RoleList, row)
        end
      end
    end
  end
end

function DataModel:BlockFromRes(viewCA)
  local key = "block" .. GameSetting.fromRes
  return viewCA[key]
end

function DataModel:InitSkinView()
  DataModel.SkinList = {}
  DataModel.CurrentRoleData = PlayerData:GetRoleById(DataModel.CurrentUnitId)
  local ca_skin = {}
  if table.count(DataModel.CurrentRoleData) > 0 then
    for i, v in ipairs(DataModel.CurrentUnitCA.skinList) do
      local skinCA = PlayerData:GetFactoryData(v.unitViewId, "UnitViewFactory")
      local isBlock = DataModel:BlockFromRes(skinCA)
      local battlePassCA
      if skinCA.skinBattlePass and 0 < skinCA.skinBattlePass then
        battlePassCA = PlayerData:GetFactoryData(skinCA.skinBattlePass, "BattlePassFactory")
      end
      if (not battlePassCA or TimeUtil:GetServerTimeStamp() >= TimeUtil:TimeStamp(battlePassCA.PassStartTime)) and not isBlock then
        if DataModel.curSelectTab == 1 or not skinCA.videoSpine and not skinCA.moveBoolen then
          table.insert(ca_skin, v)
        end
        if skinCA.isSpine2 == 1 and DataModel.curSelectTab == 1 then
          table.insert(ca_skin, {
            unitViewId = v.unitViewId,
            isSpine2 = 1
          })
        end
      end
    end
  else
    local noHeroSkin = PlayerData.ServerData.skin_no_hero
    local skinList = noHeroSkin[tostring(DataModel.CurrentUnitId)]
    for i, unitViewId in pairs(skinList) do
      local skinCA = PlayerData:GetFactoryData(unitViewId, "UnitViewFactory")
      local isBlock = DataModel:BlockFromRes(skinCA)
      local battlePassCA
      if skinCA.skinBattlePass and 0 < skinCA.skinBattlePass then
        battlePassCA = PlayerData:GetFactoryData(skinCA.skinBattlePass, "BattlePassFactory")
      end
      if (not battlePassCA or TimeUtil:GetServerTimeStamp() >= TimeUtil:TimeStamp(battlePassCA.PassStartTime)) and not isBlock and (DataModel.curSelectTab == 1 or not skinCA.videoSpine and not skinCA.moveBoolen) then
        table.insert(ca_skin, {unitViewId = unitViewId, isSpine2 = 0})
      end
    end
  end
  DataModel.SkinPreviewChooseIndex = 1
  local count = 1
  for i = 1, table.count(ca_skin) do
    local data = ca_skin[i]
    local row = {}
    row.unitViewId = data.unitViewId
    row.isHave = false
    local ca = PlayerData:GetFactoryData(row.unitViewId, "UnitViewFactory")
    row.roleId = ca.character
    row.isSelect = false
    row.isWear = false
    row.roleListResUrl = ca.roleListResUrl
    row.SkinName = ca.SkinName
    row.SkinDesc = ca.SkinDesc
    row.State2RoleListRes = ca.State2RoleListRes
    row.State2Name = ca.State2Name
    row.State2Desc = ca.State2Desc
    row.isSpine2 = data.isSpine2 or 0
    if tonumber(data.unitViewId) == tonumber(DataModel.SkinUnitViewId) and row.isSpine2 == DataModel.SkinUnitViewIsSpine then
      if tonumber(DataModel.CurrentUnitId) == tonumber(DataModel.RoleId[DataModel.curSelectTab]) then
        row.isWear = true
        row.isSelect = true
      end
      DataModel.SkinPreviewChooseIndex = count
    end
    if table.count(DataModel.CurrentRoleData) > 0 then
      if DataModel.CurrentRoleData.skin_list[tostring(data.unitViewId)] then
        row.isHave = true
      end
      if row.isHave and row.isSpine2 == 1 then
        local server = PlayerData:GetRoleById(row.roleId)
        local portrailData = PlayerData:GetFactoryData(row.unitViewId)
        if server.resonance_lv == 5 and portrailData.State2Res ~= nil and portrailData.State2Res ~= "" then
          row.isCanSpine2 = true
        end
      end
    else
      row.isHave = true
      row.isCanSpine2 = false
    end
    DataModel.SkinList[count] = row
    count = count + 1
  end
end

function DataModel:SetElement(element, elementIndex)
  local row = DataModel.RoleList[elementIndex]
  element.Btn_ProfilePhoto:SetClickParam(elementIndex)
  element.Img_Face:SetSprite(row.face)
  element.Txt_Name:SetText(row.name)
  element.Img_Selected.self:SetActive(row.isSelect)
end

function DataModel:SetRoleListData(element, row)
  if row then
    local unitViewCA = PlayerData:GetFactoryData(row.unitViewId)
    row.isSpine2 = DataModel.IsSpine2(row.roleId)
    row.face = row.isSpine2 == 1 and unitViewCA.State2Face or unitViewCA.face
    if element then
      DataModel:SetElement(element, DataModel.RightChooseIndex)
    end
  end
end

function DataModel:SetSkinPreviewElement(element, elementIndex)
  local row = DataModel.SkinList[tonumber(elementIndex)]
  local Btn_SkinBg = element.Btn_SkinBg
  Btn_SkinBg:SetClickParam(elementIndex)
  Btn_SkinBg.Img_LockMask:SetActive(not row.isHave)
  element.Img_Selected:SetActive(row.isSelect)
  Btn_SkinBg.Img_SkinFrame:SetSprite(row.roleListResUrl)
  local SkinName = row.SkinName
  local SkinDesc = row.SkinDesc
  if row.isSpine2 == 1 then
    SkinName = row.State2Name
    SkinDesc = row.State2Desc
    Btn_SkinBg.Img_SkinFrame:SetSprite(row.State2RoleListRes)
    Btn_SkinBg.Img_LockMask:SetActive(not row.isCanSpine2)
  end
  row.SkinName = SkinName
  row.SkinDesc = SkinDesc
  Btn_SkinBg.Img_SkinFrame.Img_SkinNameBg.Txt_Name:SetText(SkinName)
  Btn_SkinBg.Img_SkinFrame.Img_InUsingBg:SetActive(row.isWear)
end

function DataModel:GetCRRRoleId()
  local roleList = {}
  for unitId, v in pairs(PlayerData:GetRoles()) do
    table.insert(roleList, unitId)
  end
  local noHeroSkin = PlayerData.ServerData.skin_no_hero
  if noHeroSkin then
    for unitId, v in pairs(PlayerData.ServerData.skin_no_hero) do
      table.insert(roleList, unitId)
    end
  end
  local index = math.random(1, table.count(roleList))
  return roleList[index]
end

function DataModel:GetCRRViewId(roleId, canSpine2)
  local viewId, isSpine2
  local SkinList = {}
  local CurrentUnitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
  local CurrentRoleData = PlayerData:GetRoleById(roleId)
  local ca_skin = {}
  if table.count(CurrentRoleData) > 0 then
    for i, v in ipairs(CurrentUnitCA.skinList) do
      local skinCA = PlayerData:GetFactoryData(v.unitViewId, "UnitViewFactory")
      local isBlock = DataModel:BlockFromRes(skinCA)
      local battlePassCA
      if skinCA.skinBattlePass and 0 < skinCA.skinBattlePass then
        battlePassCA = PlayerData:GetFactoryData(skinCA.skinBattlePass, "BattlePassFactory")
      end
      if (not battlePassCA or TimeUtil:GetServerTimeStamp() >= TimeUtil:TimeStamp(battlePassCA.PassStartTime)) and not isBlock then
        if canSpine2 or not canSpine2 and not skinCA.videoSpine and not skinCA.moveBoolen then
          table.insert(ca_skin, v)
        end
        if skinCA.isSpine2 == 1 and canSpine2 then
          table.insert(ca_skin, {
            unitViewId = v.unitViewId,
            isSpine2 = 1
          })
        end
      end
    end
  else
    local noHeroSkin = PlayerData.ServerData.skin_no_hero
    local skinList = noHeroSkin[tostring(roleId)]
    for i, unitViewId in pairs(skinList) do
      local skinCA = PlayerData:GetFactoryData(unitViewId, "UnitViewFactory")
      local isBlock = DataModel:BlockFromRes(skinCA)
      local battlePassCA
      if skinCA.skinBattlePass and 0 < skinCA.skinBattlePass then
        battlePassCA = PlayerData:GetFactoryData(skinCA.skinBattlePass, "BattlePassFactory")
      end
      if (not battlePassCA or TimeUtil:GetServerTimeStamp() >= TimeUtil:TimeStamp(battlePassCA.PassStartTime)) and not isBlock and (canSpine2 or not canSpine2 and not skinCA.videoSpine and not skinCA.moveBoolen) then
        table.insert(ca_skin, {unitViewId = unitViewId, isSpine2 = 0})
      end
    end
  end
  local count = 1
  for i = 1, table.count(ca_skin) do
    local data = ca_skin[i]
    local isHave
    if table.count(CurrentRoleData) > 0 then
      isHave = CurrentRoleData.skin_list[tostring(data.unitViewId)]
    else
      isHave = true
    end
    if isHave then
      SkinList[count] = {
        unitViewId = data.unitViewId,
        isSpine2 = data.isSpine2 or 0
      }
      count = count + 1
    end
  end
  local index = math.random(1, table.count(SkinList))
  local temp_date = SkinList[index]
  viewId = temp_date.unitViewId
  isSpine2 = temp_date.isSpine2
  return viewId, isSpine2
end

function DataModel:GetExtraSpineList(index)
  local spineIndex = index
  local list = {}
  list.resX = DataModel.ReceptionistData.offsetX
  list.resY = DataModel.ReceptionistData.offsetY
  list.resScale = DataModel.ReceptionistData.offsetScale
  list.spineX = DataModel.ReceptionistData.spineX
  list.spineY = DataModel.ReceptionistData.spineY
  list.spineScale = DataModel.ReceptionistData.spineScale
  if spineIndex ~= 0 then
    local extraInfo = DataModel.ReceptionistData.extraSpineList[spineIndex]
    if extraInfo then
      local extraUnitViewCA = PlayerData:GetFactoryData(extraInfo.id, "UnitViewFactory")
      list.resX = extraUnitViewCA.offsetX
      list.resY = extraUnitViewCA.offsetY
      list.resScale = extraUnitViewCA.offsetScale
      list.spineX = extraUnitViewCA.spineX
      list.spineY = extraUnitViewCA.spineY
      list.spineScale = extraUnitViewCA.spineScale
    end
  end
  return list
end

return DataModel
