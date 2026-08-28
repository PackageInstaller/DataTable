local View = require("UIChangePosterGirl/UIChangePosterGirlView")
local DataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local RoomBackDataModel = require("UIChoseBG/UIChoseBGDataModel")
local Controller = {}
local btnScreen

local function SetActive(node, value)
  if node == nil then
    return
  end
  if node.SetActive then
    node:SetActive(value)
    return
  end
  if node.self and node.self.SetActive then
    node.self:SetActive(value)
  end
end

local function SetSprite(node, value)
  if node == nil or value == nil or value == "" then
    return
  end
  if node.SetSprite then
    node:SetSprite(value)
    return
  end
  if node.self and node.self.SetSprite then
    node.self:SetSprite(value)
  end
end

local function SetNativeSize(node)
  if node == nil then
    return
  end
  if node.SetNativeSize then
    node:SetNativeSize()
    return
  end
  if node.self and node.self.SetNativeSize then
    node.self:SetNativeSize()
  end
end

local function SetLocalPosition(node, x, y)
  if node == nil then
    return
  end
  x = tonumber(x) or 0
  y = tonumber(y) or 0
  if node.SetLocalPosition then
    node:SetLocalPosition(Vector3(x, y, 0))
    return
  end
  if node.SetAnchoredPosition then
    node:SetAnchoredPosition(Vector2(x, y))
    return
  end
  if node.self and node.self.SetLocalPosition then
    node.self:SetLocalPosition(Vector3(x, y, 0))
  end
end

local function RefreshBgPic(group, bgPicList)
  if group == nil then
    return
  end
  local hasPic = false
  bgPicList = bgPicList or {}
  for index = 1, 4 do
    local img = group["Img_" .. index]
    local info = bgPicList[index]
    local show = info ~= nil and info.path ~= nil and info.path ~= ""
    SetActive(img, show)
    if show then
      hasPic = true
      SetSprite(img, info.path)
      SetNativeSize(img)
      SetLocalPosition(img, info.pathX, info.pathY)
    end
  end
  SetActive(group, hasPic)
end

function Controller.RefreshRoomBackDisplay()
  local isAdjutant = DataModel.Scene == "Adjutant"
  if isAdjutant then
    SetSprite(View.Img_MeetingRoom, RoomBackDataModel.GetCurrentRoomBackBgPath())
    RefreshBgPic(View.Group_BgPic, RoomBackDataModel.GetCurrentRoomBackBgPicList())
  else
    RefreshBgPic(View.Group_BgPic, nil)
  end
  SetActive(View.Img_MeetingRoom, isAdjutant)
end

function Controller:Init()
  DataModel:Init()
  DataModel.CurrentTopScreen = DataModel.TopScreen.isRarityDown
  Controller:InitRightTopScreenBtn()
  local returnTabIndex = DataModel.ReturnTabIndex
  DataModel.ReturnTabIndex = nil
  Controller.ShowPanel(returnTabIndex)
  if DataModel.Scene == "Adjutant" then
    View.Img_MeetingRoom:SetSprite(RoomBackDataModel.GetCurrentRoomBackBgPath())
  end
  View.Img_MeetingRoom:SetActive(DataModel.Scene == "Adjutant")
  Controller.RefreshRoomBackDisplay()
end

function Controller.ShowPanel(tabIndex)
  Controller.ShowTab(true, true)
  Controller.SelectTab(tabIndex or 1, true)
end

function Controller.ShowTab(value, refresh)
  View.Group_more.self:SetActive(value)
  if value and refresh then
    for i = 1, 10 do
      local scroll = View.Group_CharacterSkin["ScrollView_Skin" .. i]
      if scroll then
        if i <= DataModel.realTabCount then
          scroll.self:SetActive(true)
        else
          scroll.self:SetActive(false)
        end
      else
        break
      end
    end
    View.Group_more.ScrollGrid_Btn.grid.self:SetDataCount(DataModel.showTabCount)
    View.Group_more.ScrollGrid_Btn.grid.self:RefreshAllElement()
  end
end

function Controller.SelectTab(index, force)
  if DataModel.curSelectTab == index and not force then
    return
  end
  if DataModel.curSelectTab then
    local roleId = DataModel.RoleId[DataModel.curSelectTab]
    local viewId = DataModel.GetViewId(roleId, DataModel.curSelectTab)
    if viewId == nil or viewId <= 0 then
      viewId = PlayerData:GetFactoryData(roleId).viewId
    end
    local isSkin2 = DataModel.IsSpine2(roleId, DataModel.curSelectTab)
    Controller:CharacterLoad(roleId, viewId, isSkin2, DataModel.curSelectTab)
    Controller:RefreshPosterGirlFixEffect()
  end
  DataModel.curSelectTab = index
  for i = 1, 10 do
    local viewGroup = View.Group_CharacterSkin["ScrollView_Skin" .. i]
    if viewGroup == nil then
      break
    end
    viewGroup.self.ScrollRect.enabled = false
  end
  DataModel.onlyRefreshTabSelect = true
  View.Group_more.ScrollGrid_Btn.grid.self:RefreshAllElement()
  DataModel.onlyRefreshTabSelect = nil
  DataModel:InitRightRoleList()
  View.Group_Character.Group_Scene.Btn_SceneChange.self:SetActive(true)
  View.Group_Character.Btn_BGChange.self:SetActive(DataModel.Scene == "Adjutant")
  View.Img_Right.Group_Character.self:SetActive(true)
  View.Img_Right.Group_Skin.self:SetActive(false)
  btnScreen = nil
  DataModel.RightChooseIndex = nil
  Controller:RefreshRightTopScreenBtn()
  DataModel.UnitViewCRRState = DataModel.IsRandomSkin(index)
  local Img_On = View.Img_Right.Group_Character.Btn_CRR.Img_On
  if DataModel.UnitViewCRRState then
    Img_On:SetSprite("UI/CharacterInfo/Skin/onbg")
    View.Img_Right.Group_Character.Btn_CRR.Img_Bar:SetLocalPositionX(26)
  else
    Img_On:SetSprite("UI/CharacterInfo/Skin/offbg")
    View.Img_Right.Group_Character.Btn_CRR.Img_Bar:SetLocalPositionX(-26)
  end
end

function Controller.AddTab()
  local costCfg = PlayerData:GetFactoryData(99900014)
  local index = -1
  for k, v in ipairs(DataModel.RoleId) do
    if v and v ~= "" then
      index = k + 1
    elseif v == "" then
      break
    end
  end
  if index < 0 or index > costCfg.mainShowNum then
    return
  end
  local netData = PlayerData.ServerData.user_info
  local protoName = "main.set_receptionist"
  local bType = "receptionist"
  local needBuy = true
  needBuy = index > costCfg.mainShowBaseNum and index > #netData.receptionist_ts
  if DataModel.Scene == "Adjutant" then
    protoName = "main.set_adjutant"
    needBuy = index > costCfg.mainShowBaseNum and index > #netData.adjutant_id
    bType = "adjutant"
  end
  local defaultConfig = PlayerData:GetFactoryData(99900007)
  local defaultId = defaultConfig.receptionistId
  
  local function callBack(isBuy)
    Net:SendProto(protoName, function(json)
      PlayerData:GetRoleById(defaultId).trust_exp = json.trust_exp
      PlayerData:GetRoleById(defaultId).trust_lv = json.trust_lv
      if DataModel.Scene == "Adjutant" then
        netData.adjutant_id[index] = tostring(defaultId)
        netData.adjutant_ts[index] = json.server_now
        if isBuy then
          table.insert(netData.receptionist_id, "")
          table.insert(netData.receptionist_ts, json.server_now)
        end
      else
        netData.receptionist_id[index] = tostring(defaultId)
        netData.receptionist_ts[index] = json.server_now
        if isBuy then
          table.insert(netData.adjutant_id, "")
          table.insert(netData.adjutant_ts, json.server_now)
        end
      end
      DataModel.RoleId = DataModel.SetRoleId(false, true)
      local oldTabIndex = DataModel.curSelectTab
      DataModel:Init()
      Controller.ShowPanel(oldTabIndex)
    end, defaultId, index - 1)
  end
  
  if needBuy then
    local unlockIndex = index - costCfg.mainShowBaseNum
    if costCfg.showItemList == nil or #costCfg.showItemList == 0 then
      logError("\232\167\163\233\148\129\231\156\139\230\157\191\229\168\152\230\167\189\228\189\141\229\138\159\232\131\189\231\188\186\229\176\145\233\133\141\231\189\174!")
      return
    end
    local _id = costCfg.showItemList[unlockIndex] and costCfg.showItemList[unlockIndex].id or costCfg.showItemList[#costCfg.showItemList].id
    UIManager:Open("UI/CharacterInfo/ChangePosterGirl/UnlockedChoose", Json.encode({
      bType = bType,
      index = unlockIndex,
      costId = _id
    }), function()
      callBack(true)
    end)
  else
    callBack()
  end
end

function Controller.DeleteTab(index)
  local bType = "receptionist"
  if DataModel.Scene == "Adjutant" then
    bType = "adjutant"
  end
  Net:SendProto("main.delete_board", function(json)
    local roleId = DataModel.RoleId[index]
    PlayerData:GetRoleById(roleId).trust_exp = json.trust_exp
    PlayerData:GetRoleById(roleId).trust_lv = json.trust_lv
    local netData = PlayerData.ServerData.user_info
    if index < DataModel.realTabCount then
      for i = index + 1, DataModel.realTabCount do
        roleId = DataModel.RoleId[i]
        local isSpine2 = DataModel.IsSpine2(roleId, i)
        DataModel.SetIsSpine2(isSpine2, roleId, i - 1)
        DataModel.SetIsSpine2(0, roleId, i)
        local viewId = DataModel.GetViewId(roleId, i)
        DataModel.SetViewId(viewId, roleId, i - 1)
        DataModel.SetViewId(0, roleId, i)
        local isLive2D = DataModel.IsLive2D(viewId, isSpine2, i) and 1 or 0
        DataModel.SetIsLive2D(isLive2D, viewId, isSpine2, i - 1)
        DataModel.SetIsLive2D(0, viewId, isSpine2, i)
        local posIndex = DataModel.GetPosIndex(viewId, i)
        DataModel.SetPosIndex(posIndex, viewId, i - 1)
        DataModel.SetPosIndex(0, viewId, i)
        local bgState = DataModel.GetBgState(viewId, i) and 1 or 0
        DataModel.SetBgState(bgState, viewId, i - 1)
        DataModel.SetBgState(0, viewId, i)
        local scale = DataModel.GetScale(viewId, i)
        DataModel.SetScale(scale, viewId, i - 1)
        DataModel.SetScale(1, viewId, i)
        local posX = DataModel.GetPosX(viewId, i)
        DataModel.SetPosX(posX, viewId, i - 1)
        DataModel.SetPosX(0, viewId, i)
        local posY = DataModel.GetPosY(viewId, i)
        DataModel.SetPosY(posY, viewId, i - 1)
        DataModel.SetPosY(0, viewId, i)
        local effectState = DataModel.GetEffectState(viewId, i) and 1 or 0
        DataModel.SetEffectState(effectState, viewId, i - 1)
        DataModel.SetEffectState(0, viewId, i)
      end
    end
    if DataModel.Scene == "Adjutant" then
      table.remove(netData.adjutant_id, index)
      table.insert(netData.adjutant_id, "")
      table.remove(netData.adjutant_ts, index)
      table.insert(netData.adjutant_ts, 0)
    else
      table.remove(netData.receptionist_id, index)
      table.insert(netData.receptionist_id, "")
      table.remove(netData.receptionist_ts, index)
      table.insert(netData.receptionist_ts, 0)
    end
    DataModel.RoleId = DataModel.SetRoleId(false, true)
    local oldTabIndex = DataModel.curSelectTab
    if oldTabIndex >= index then
      oldTabIndex = oldTabIndex - 1
    end
    DataModel:Init()
    Controller.ShowPanel(oldTabIndex)
  end, bType, index - 1)
end

function Controller:InitRightTopScreenBtn()
  View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Group_Txt.Img_Down:SetActive(true)
  View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Group_Txt.Img_UP:SetActive(false)
  View.Img_Right.Group_Character.Group_Screen.Btn_Time.Group_Txt.Img_Down:SetActive(true)
  View.Img_Right.Group_Character.Group_Screen.Btn_Time.Group_Txt.Img_UP:SetActive(false)
end

function Controller:RefreshRoleList()
  View.Img_Right.Group_Character.ScrollGrid_MemberList.grid.self:SetDataCount(table.count(DataModel.RoleList))
  View.Img_Right.Group_Character.ScrollGrid_MemberList.grid.self:RefreshAllElement()
  View.Img_Right.Group_Character.ScrollGrid_MemberList.grid.self:MoveToPos(DataModel.RightChooseIndex or 1)
  Controller:ChooseRightRole(DataModel.RightChooseIndex or 1)
end

function Controller:RefreshRightTopScreenBtn()
  if btnScreen == DataModel.CurrentTopScreen then
    return
  end
  local index, id
  if DataModel.RightChooseIndex then
    index = DataModel.RightChooseIndex
    id = DataModel.RoleList[index].roleId
    DataModel.RoleList[index].isSelect = false
  end
  if DataModel.CurrentTopScreen == DataModel.TopScreen.isRarityDown then
    table.sort(DataModel.RoleList, function(a, b)
      if a.isTop == b.isTop then
        if a.qualityInt == b.qualityInt then
          return a.roleId > b.roleId
        end
        return a.qualityInt > b.qualityInt
      end
      return a.isTop > b.isTop
    end)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Img_On:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Group_Txt.Img_Down:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Group_Txt.Img_UP:SetActive(false)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Img_On:SetActive(false)
  end
  if DataModel.CurrentTopScreen == DataModel.TopScreen.isRarityUp then
    table.sort(DataModel.RoleList, function(a, b)
      if a.isTop == b.isTop then
        if a.qualityInt == b.qualityInt then
          return a.roleId > b.roleId
        end
        return a.qualityInt < b.qualityInt
      end
      return a.isTop > b.isTop
    end)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Img_On:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Group_Txt.Img_Down:SetActive(false)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Group_Txt.Img_UP:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Img_On:SetActive(false)
  end
  if DataModel.CurrentTopScreen == DataModel.TopScreen.isTimeDown then
    table.sort(DataModel.RoleList, function(a, b)
      if a.isTop == b.isTop then
        if a.obtain_time == b.obtain_time then
          return a.roleId > b.roleId
        end
        return a.obtain_time > b.obtain_time
      end
      return a.isTop > b.isTop
    end)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Img_On:SetActive(false)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Img_On:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Group_Txt.Img_Down:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Group_Txt.Img_UP:SetActive(false)
  end
  if DataModel.CurrentTopScreen == DataModel.TopScreen.isTimeUp then
    table.sort(DataModel.RoleList, function(a, b)
      if a.isTop == b.isTop then
        if a.obtain_time == b.obtain_time then
          return a.roleId > b.roleId
        end
        return a.obtain_time < b.obtain_time
      end
      return a.isTop > b.isTop
    end)
    View.Img_Right.Group_Character.Group_Screen.Btn_Rarity.Img_On:SetActive(false)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Img_On:SetActive(true)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Group_Txt.Img_Down:SetActive(false)
    View.Img_Right.Group_Character.Group_Screen.Btn_Time.Group_Txt.Img_UP:SetActive(true)
  end
  if id then
    for k, v in pairs(DataModel.RoleList) do
      if v.roleId == id then
        v.isSelect = true
        DataModel.RightChooseIndex = k
      end
    end
  end
  Controller:RefreshRoleList()
end

function Controller:RefreshRightTopScreen(type)
  if type == 1 then
    if DataModel.CurrentTopScreen ~= DataModel.TopScreen.isTimeDown and DataModel.CurrentTopScreen ~= DataModel.TopScreen.isTimeUp then
      if DataModel.CurrentTopScreen == DataModel.TopScreen.isRarityDown then
        DataModel.CurrentTopScreen = DataModel.TopScreen.isRarityUp
      else
        DataModel.CurrentTopScreen = DataModel.TopScreen.isRarityDown
      end
    else
      DataModel.CurrentTopScreen = DataModel.TopScreen.isRarityDown
    end
  end
  if type == 2 then
    if DataModel.CurrentTopScreen ~= DataModel.TopScreen.isRarityDown and DataModel.CurrentTopScreen ~= DataModel.TopScreen.isRarityUp then
      if DataModel.CurrentTopScreen == DataModel.TopScreen.isTimeDown then
        DataModel.CurrentTopScreen = DataModel.TopScreen.isTimeUp
      else
        DataModel.CurrentTopScreen = DataModel.TopScreen.isTimeDown
      end
    else
      DataModel.CurrentTopScreen = DataModel.TopScreen.isTimeDown
    end
  end
  Controller:RefreshRightTopScreenBtn()
end

function Controller:ShowUIAni()
  View.Group_Change.self:SetActive(not DataModel.isLock)
  View.Img_Right.self:SetActive(DataModel.isLock)
  View.Group_Character.self:SetActive(DataModel.isLock)
  View.Group_SkinStage.self:SetActive(DataModel.isLock)
  View.Group_CharacterState.self:SetActive(DataModel.isLock)
end

function Controller:InitChangeBtn()
  DataModel.isLock = true
  Controller:ShowUIAni()
  View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].self.ScrollRect.enabled = not DataModel.isLock
  local Img_On_Effect = View.Group_SkinStage.Img_Effect.Btn_Switch.Img_On
  if DataModel.EffectState then
    Img_On_Effect:SetSprite("UI/CharacterInfo/Skin/onbg")
    View.Group_SkinStage.Img_Effect.Btn_Switch.Img_Bar:SetLocalPositionX(26)
  else
    Img_On_Effect:SetSprite("UI/CharacterInfo/Skin/offbg")
    View.Group_SkinStage.Img_Effect.Btn_Switch.Img_Bar:SetLocalPositionX(-26)
  end
  local Img_On_Bg = View.Group_SkinStage.Img_BG.Btn_Switch.Img_On
  if DataModel.SkinBgState then
    Img_On_Bg:SetSprite("UI/CharacterInfo/Skin/onbg")
    View.Group_SkinStage.Img_BG.Btn_Switch.Img_Bar:SetLocalPositionX(26)
  else
    Img_On_Bg:SetSprite("UI/CharacterInfo/Skin/offbg")
    View.Group_SkinStage.Img_BG.Btn_Switch.Img_Bar:SetLocalPositionX(-26)
  end
  local Img_On = View.Group_CharacterState.Btn_Live2D.Img_On
  if DataModel.Live2DState then
    Img_On:SetSprite("UI/CharacterInfo/Skin/onbg")
    View.Group_CharacterState.Btn_Live2D.Img_Bar:SetLocalPositionX(26)
  else
    Img_On:SetSprite("UI/CharacterInfo/Skin/offbg")
    View.Group_CharacterState.Btn_Live2D.Img_Bar:SetLocalPositionX(-26)
  end
end

local function ShowStaticImage()
  local tabIndex = tabIndex or DataModel.curSelectTab
  local receptionistData = DataModel.ReceptionistData
  local isSkin2 = DataModel.SkinUnitViewIsSpine
  local Group_CharacterSkin = View.Group_CharacterSkin["ScrollView_Skin" .. tabIndex].Viewport.Content
  Group_CharacterSkin.Group_Spine.self:SetActive(false)
  Group_CharacterSkin.Group_Video:SetActive(false)
  if isSkin2 == 1 then
    View.Group_PaidMask.self:SetActive(true)
    Group_CharacterSkin.Group_Character2.self:SetActive(true)
    Group_CharacterSkin.Group_Character.self:SetActive(false)
    Group_CharacterSkin.Group_Character2.Img_Character2:SetSprite(receptionistData.State2Res)
    Group_CharacterSkin.Group_Character2.Img_Character2:SetNativeSize()
    local img2X = receptionistData.offsetX2
    local img2Y = receptionistData.offsetY2
    if receptionistData.moveBoolen then
      img2X = -370 + receptionistData.offsetX + receptionistData.offsetX2
      img2Y = receptionistData.offsetY + receptionistData.offsetY2
    end
    Group_CharacterSkin.Group_Character2.Img_Character2:SetLocalPosition(Vector3(img2X, img2Y, 0))
  else
    View.Group_PaidMask.self:SetActive(receptionistData.isVideo or receptionistData.moveBoolen)
    Group_CharacterSkin.Group_Character.self:SetActive(true)
    Group_CharacterSkin.Group_Character2.self:SetActive(false)
    local resPath
    local gender = PlayerData:GetUserInfo().gender or 1
    if gender == 1 then
      if not DataModel.SkinBgState and receptionistData.singleUrl ~= "" then
        resPath = receptionistData.singleUrl
      else
        resPath = receptionistData.resUrl
      end
    elseif not DataModel.SkinBgState and receptionistData.singleFemale ~= "" then
      resPath = receptionistData.singleFemale
    elseif receptionistData.pngFemale ~= "" then
      resPath = receptionistData.pngFemale
    else
      resPath = receptionistData.resUrl
    end
    Group_CharacterSkin.Group_Character.Img_Character:SetSprite(resPath)
    local resX = receptionistData.offsetX
    local resY = receptionistData.offsetY
    local resScale = receptionistData.offsetScale
    if receptionistData.moveBoolen then
      resX = resX + receptionistData.offsetX2
      resY = resY + receptionistData.offsetY2
    end
    Group_CharacterSkin.Group_Character.Img_Character:SetLocalScale(Vector3(resScale, resScale, resScale))
    Group_CharacterSkin.Group_Character.Img_Character:SetLocalPosition(Vector3(-370 + resX, resY, 0))
    Group_CharacterSkin.Group_Character.Img_Character:SetNativeSize()
    local scaleNum = DataModel.GetScale(DataModel.SkinUnitViewId, tabIndex)
    scaleNum = scaleNum == 0 and 1 or scaleNum
    View.Group_Change.Slider_Scale:SetSliderValue(scaleNum)
    Group_CharacterSkin.transform.localScale = Vector3(scaleNum, scaleNum, scaleNum)
    DataModel.ScaleState = scaleNum
    local posX = DataModel.GetPosX(DataModel.SkinUnitViewId, tabIndex)
    local posY = DataModel.GetPosY(DataModel.SkinUnitViewId, tabIndex)
    Group_CharacterSkin.transform.localPosition = Vector3(posX, posY, 0)
    DataModel.PosX = posX
    DataModel.PosY = posY
  end
  DataModel.InfoInitPos.isRecord = false
  local transform = Group_CharacterSkin.transform
  DataModel.InfoInitPos.y = transform.localPosition.y
  DataModel.InfoInitPos.scale = transform.localScale.x
  DataModel.InfoInitPos.offsetX = receptionistData.offsetX
  DataModel.InfoInitPos.offsetY = receptionistData.offsetY
  DataModel.Spine2ImgPosX = receptionistData.offsetX2
  if receptionistData.moveBoolen then
    DataModel.Spine2ImgPosX = -370 + receptionistData.offsetX + receptionistData.offsetX2
  end
end

function Controller:CharacterLoad(roleId, viewId, isSkin2, tabIndex)
  tabIndex = tabIndex or DataModel.curSelectTab
  local scroll = View.Group_CharacterSkin["ScrollView_Skin" .. tabIndex]
  local Group_CharacterSkin = scroll.Viewport.Content
  Group_CharacterSkin.transform.localScale = Vector3.one
  Group_CharacterSkin.transform.localPosition = Vector3.zero
  local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  DataModel.ReceptionistData = receptionistData
  DataModel.isVideo = receptionistData.videoSpine
  DataModel.isSpine2 = isSkin2 == 1
  local canChangePos = #receptionistData.extraSpineList > 0 and not DataModel.isSpine2
  DataModel.SkinUnitViewId = viewId
  DataModel.SkinUnitViewIsSpine = isSkin2
  DataModel.Live2DState = DataModel.IsLive2D(viewId, isSkin2, tabIndex)
  DataModel.EffectState = DataModel.GetEffectState(viewId, tabIndex)
  DataModel.SkinBgState = DataModel.GetBgState(viewId, tabIndex)
  DataModel.hasBg = receptionistData.SpineBackground ~= "" and isSkin2 == 0
  DataModel.CurrentUnitId = roleId
  DataModel.CurrentUnitCA = PlayerData:GetFactoryData(roleId)
  local spineIndex = DataModel.GetPosIndex(viewId, tabIndex)
  if 0 < spineIndex and spineIndex <= #receptionistData.extraSpineList then
    DataModel.ReceptionistData = PlayerData:GetFactoryData(receptionistData.extraSpineList[spineIndex].id)
    receptionistData = DataModel.ReceptionistData
  end
  local hasLive2D = true
  if DataModel.isVideo then
    hasLive2D = receptionistData.videoPath ~= ""
  elseif DataModel.isSpine2 then
    hasLive2D = receptionistData.spine2Url ~= ""
  else
    hasLive2D = receptionistData.spineUrl ~= ""
  end
  DataModel.hasLive2D = hasLive2D
  View.Group_CharacterState.Btn_Live2D:SetActive(hasLive2D)
  local canDrag = not DataModel.isSpine2 and not DataModel.isVideo and not receptionistData.moveBoolen or (DataModel.isVideo or DataModel.isSpine2) and receptionistData.moveBoolen
  View.Group_Character.Btn_ChangePosition:SetActive(canDrag)
  View.Group_Character.Btn_ChangePose.self:SetActive(canChangePos)
  Group_CharacterSkin.Group_Spine.Img_SpineBG:SetActive(false)
  if DataModel.isVideo then
    if DataModel.Live2DState and hasLive2D then
      View.Group_PaidMask.self:SetActive(true)
      Group_CharacterSkin.Group_Video:SetActive(true)
      Group_CharacterSkin.Group_Spine:SetActive(false)
      Group_CharacterSkin.Group_Character:SetActive(false)
      Group_CharacterSkin.Group_Character2:SetActive(false)
      View.Group_Character.Btn_ChangePose:SetActive(false)
      Group_CharacterSkin.transform.localScale = Vector3.one
      Group_CharacterSkin.transform.localPosition = Vector3(0, 0, 0)
      local resPath = receptionistData.videoPath
      if receptionistData.videoFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        resPath = receptionistData.videoFemale
      end
      Group_CharacterSkin.Group_Video.Video_Chara:Play(resPath, true, false, false)
      Group_CharacterSkin.Group_Video.Video_Chara:SetAnchoredPosition(Vector2(receptionistData.videoX, receptionistData.videoY))
      Group_CharacterSkin.Group_Video.Video_Chara:SetLocalScale(Vector3.one * receptionistData.videoScale)
    else
      ShowStaticImage()
    end
  elseif DataModel.isSpine2 then
    if DataModel.Live2DState and hasLive2D then
      Group_CharacterSkin.Group_Video:SetActive(false)
      Group_CharacterSkin.Group_Spine:SetActive(true)
      Group_CharacterSkin.Group_Character:SetActive(false)
      Group_CharacterSkin.Group_Character2:SetActive(false)
      View.Group_PaidMask.self:SetActive(true)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Fade:SetActive(true)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData("")
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(false)
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(true)
      local spineUrl = receptionistData.spine2Url
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab(spineUrl)
      local spine2X = receptionistData.spine2X
      local spine2Y = receptionistData.spine2Y
      if receptionistData.moveBoolen then
        spine2X = -370 + receptionistData.spineX + receptionistData.spine2X
        spine2Y = -1200 + receptionistData.spineY + receptionistData.spine2Y
      end
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character.transform.localPosition = Vector3(spine2X, spine2Y, 0)
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
      if receptionistData.state2Overturn == true then
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
      end
      DataModel.Spine2PosX = spine2X
    else
      ShowStaticImage()
    end
  elseif DataModel.Live2DState and hasLive2D then
    Group_CharacterSkin.Group_Video:SetActive(false)
    Group_CharacterSkin.Group_Spine:SetActive(true)
    Group_CharacterSkin.Group_Character:SetActive(false)
    Group_CharacterSkin.Group_Character2:SetActive(false)
    View.Group_PaidMask.self:SetActive(receptionistData.moveBoolen)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Fade:SetActive(true)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(true)
    Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab("")
    Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
    local spineUrl = receptionistData.spineUrl
    local spineX = receptionistData.spineX
    local spineY = receptionistData.spineY
    local spineScale = receptionistData.spineScale
    if receptionistData.moveBoolen then
      spineX = spineX + receptionistData.spine2X
      spineY = spineY + receptionistData.spine2Y
    end
    if receptionistData.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
      spineUrl = receptionistData.spineFemale
    end
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData(spineUrl)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetLocalScale(Vector3(100 * spineScale, 100 * spineScale, 1))
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character.transform.localPosition = Vector3(-370 + spineX, -1200 + spineY, 0)
    local scaleNum = DataModel.GetScale(viewId)
    scaleNum = scaleNum == 0 and 1 or scaleNum
    View.Group_Change.Slider_Scale:SetSliderValue(scaleNum)
    Group_CharacterSkin.transform.localScale = Vector3(scaleNum, scaleNum, scaleNum)
    DataModel.ScaleState = scaleNum
    local posX = DataModel.GetPosX(viewId)
    local posY = DataModel.GetPosY(viewId)
    Group_CharacterSkin.transform.localPosition = Vector3(posX, posY, 0)
    DataModel.PosX = posX
    DataModel.PosY = posY
    if DataModel.hasBg then
      local Img_SpineBG = Group_CharacterSkin.Group_Spine.Img_SpineBG
      Img_SpineBG:SetSprite(receptionistData.SpineBackground)
      local bgX = receptionistData.SpineBGX
      local bgY = receptionistData.SpineBGY
      local x = Group_CharacterSkin.Group_Spine.SpineAnimation_Character.transform.localPosition.x - bgX
      Img_SpineBG.transform.localPosition = Vector3(x, bgY, 0)
      local scale = 0 >= receptionistData.SpineBGScale and 1 or receptionistData.SpineBGScale
      Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
      Img_SpineBG:SetActive(DataModel.SkinBgState)
    end
  else
    ShowStaticImage()
  end
  View.Group_SkinStage.Img_Effect.self:SetActive((receptionistData.frontFixEffectUrl ~= "" or receptionistData.bottomFixEffectUrl ~= "") and isSkin2 == 0 and DataModel.Live2DState)
  View.Group_SkinStage.Img_BG.self:SetActive(DataModel.hasBg)
  View.Group_Character.Group_Name.Txt_NameCN:SetText(DataModel.CurrentUnitCA.name)
  View.Group_Character.Group_Name.Txt_NameENG:SetText(DataModel.CurrentUnitCA.EnglishName)
  View.Group_Character.Group_Name.Txt_NameENG:SetActive(not CommonTips.IsResEN())
  View.Group_Character.Group_Scene.Txt_SenceName:SetText(DataModel.Scene == "Main" and GetText(80600212) or GetText(80600211))
end

function Controller:ChooseRightRole(str)
  local index = tonumber(str)
  if index == DataModel.RightChooseIndex then
    return
  end
  local row = DataModel.RoleList[index]
  if DataModel.RightChooseIndex then
    local old_element = View.Img_Right.Group_Character.ScrollGrid_MemberList.grid.self:GetElementByIndex(DataModel.RightChooseIndex - 1)
    DataModel.RoleList[DataModel.RightChooseIndex].isSelect = false
    if old_element then
      old_element.Img_Selected.self:SetActive(false)
    end
  end
  DataModel.RightChooseIndex = index
  local element = View.Img_Right.Group_Character.ScrollGrid_MemberList.grid.self:GetElementByIndex(DataModel.RightChooseIndex - 1)
  if element then
    element.Img_Selected.self:SetActive(true)
  end
  row.isSelect = true
  Controller:CharacterLoad(row.roleId, row.unitViewId, row.isSpine2)
  Controller:RefreshPosterGirlFixEffect()
  Controller:InitChangeBtn()
end

function Controller:ClickLive2D()
  local Img_On = View.Group_CharacterState.Btn_Live2D.Img_On
  local state_n = 1
  if DataModel.Live2DState == true then
    state_n = 0
  end
  DataModel.SetIsLive2D(state_n, DataModel.SkinUnitViewId, DataModel.SkinUnitViewIsSpine)
  if DataModel.Live2DState == true then
    DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterState.Btn_Live2D.Img_Bar.transform, 26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterState.Btn_Live2D.Img_Bar.transform, -26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
  end
  Controller:CharacterLoad(DataModel.CurrentUnitId, DataModel.SkinUnitViewId, DataModel.SkinUnitViewIsSpine)
  Controller:RefreshPosterGirlFixEffect()
end

function Controller:RefreshPosterGirlFixEffect()
  local Group_CharacterSkin = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].Viewport.Content
  if View.Group_SkinStage.Img_Effect.self.IsActive == false then
    Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
    Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
    return
  end
  local Img_On = View.Group_SkinStage.Img_Effect.Btn_Switch.Img_On
  if DataModel.EffectState then
    if DataModel.ReceptionistData.frontFixEffectUrl ~= "" then
      Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterFrontIdleEffect:SetData(DataModel.ReceptionistData.frontFixEffectUrl, "effect_idle")
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterFrontIdleEffect:SetActive(true)
      end))
    else
      Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
    end
    if DataModel.ReceptionistData.bottomFixEffectUrl ~= "" then
      Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterBottomIdleEffect:SetData(DataModel.ReceptionistData.bottomFixEffectUrl, "effect_idle")
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterBottomIdleEffect:SetActive(true)
      end))
    else
      Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
    end
    DOTweenTools.DOLocalMoveXCallback(View.Group_SkinStage.Img_Effect.Btn_Switch.Img_Bar.transform, 26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
    DataModel.SetEffectState(0, DataModel.SkinUnitViewId)
  else
    Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
    Group_CharacterSkin.Group_Spine.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
    DOTweenTools.DOLocalMoveXCallback(View.Group_SkinStage.Img_Effect.Btn_Switch.Img_Bar.transform, -26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
    DataModel.SetEffectState(1, DataModel.SkinUnitViewId)
  end
end

function Controller:RefreshPosterGirlBg()
  local Img_On = View.Group_SkinStage.Img_BG.Btn_Switch.Img_On
  local viewContent = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].Viewport.Content
  local Img_SpineBG = viewContent.Group_Spine.Img_SpineBG
  if DataModel.SkinBgState then
    DataModel.SetBgState(0, DataModel.SkinUnitViewId)
    DOTweenTools.DOLocalMoveXCallback(View.Group_SkinStage.Img_BG.Btn_Switch.Img_Bar.transform, 26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
  else
    DataModel.SetBgState(1, DataModel.SkinUnitViewId)
    DOTweenTools.DOLocalMoveXCallback(View.Group_SkinStage.Img_BG.Btn_Switch.Img_Bar.transform, -26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
  end
  if not DataModel.Live2DState then
    Controller:CharacterLoad(DataModel.CurrentUnitId, DataModel.SkinUnitViewId, DataModel.SkinUnitViewIsSpine)
  elseif DataModel.SkinBgState then
    Img_SpineBG:SetActive(true)
  else
    Img_SpineBG:SetActive(false)
  end
end

local MainUIDataModel = require("UIMainUI/UIMainUIDataModel")
local MainController = require("UIMainUI/UIMainUIController")

function Controller:ChangeScene()
  if DataModel.Scene == "Main" then
    DataModel.Scene = "Adjutant"
    PlayerData.TempCache.MainUIShowState = MainUIDataModel.UIShowEnum.Adjutant
    DataModel.RoleId = DataModel.SetRoleId(false, true)
    MainController:ShowAdjutant()
    MainController:ShowOutSide(false)
  else
    DataModel.Scene = "Main"
    PlayerData.TempCache.MainUIShowState = MainUIDataModel.UIShowEnum.OutSide
    DataModel.RoleId = DataModel.SetRoleId(false, true)
    MainController:ShowAdjutant()
    MainController:ShowOutSide()
  end
  Controller:Init()
end

function Controller:UpdateScaleSlider()
  if DataModel.isLock == false then
    if Input.GetMouseButtonDown(0) then
      if View.Group_Change.Slider_Scale.IsActive then
        DataModel.SetHideTime()
      elseif not View.Group_Change.Slider_Scale.IsActive then
        View.Group_Change.Slider_Scale:SetActive(true)
        DataModel.SetHideTime()
      end
    end
    if DataModel.HideSliderTime and os.time() > DataModel.HideSliderTime then
      DataModel.HideSliderTime = nil
    end
  end
end

function Controller:MoveSpine2Live2D(type)
  local viewGroup = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab]
  viewGroup.self.ScrollRect.enabled = false
  local posX
  local live2D = DataModel.IsLive2D(DataModel.SkinUnitViewId, DataModel.SkinUnitViewIsSpine)
  if type == 1 then
    posX = 0
  elseif not live2D then
    posX = DataModel.Spine2ImgPosX
  else
    posX = DataModel.Spine2PosX
  end
  if not live2D then
    DOTweenTools.DOLocalMoveXCallback(viewGroup.Viewport.Content.Group_Character2.Img_Character2.transform, posX, 0.25, function()
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(viewGroup.Viewport.Content.Group_Spine.SpineSecondMode_Character.transform, posX, 0.25, function()
    end)
  end
end

function Controller:ResetPosition()
  local viewContent = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab].Viewport.Content
  viewContent.Group_Spine.transform.localScale = Vector3(1, 1, 1)
  viewContent.Group_Character.transform.localScale = Vector3(1, 1, 1)
  viewContent.self:SetLocalPosition(Vector3(0, 0, 0))
  View.Group_Change.Slider_Scale:SetSliderValue(1)
end

function Controller:ComparePosition(isHome)
  local posX = DataModel.GetPosX(DataModel.SkinUnitViewId)
  local posY = DataModel.GetPosY(DataModel.SkinUnitViewId)
  local scaleNum = DataModel.GetScale(DataModel.SkinUnitViewId)
  local viewGroup = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab]
  local now_PosX = viewGroup.Viewport.Content.transform.localPosition.x
  local now_PosY = viewGroup.Viewport.Content.transform.localPosition.y
  scaleNum = scaleNum == 0 and 1 or scaleNum
  
  local function callBack()
    DataModel.isLock = true
    View.Group_Change.self:SetActive(not DataModel.isLock)
    Controller:ShowUIAni()
    DataModel:SetHideTime()
    View.Group_Change.Slider_Scale:SetActive(false)
    viewGroup.self.ScrollRect.enabled = false
    viewGroup.self.transform:SetSiblingIndex(DataModel.curSelectTab - 1)
    Controller.ShowTab(true)
  end
  
  if now_PosX ~= posX or now_PosY ~= posY or DataModel.ScaleState ~= scaleNum then
    CommonTips.OnPrompt(80607609, nil, nil, function()
      if isHome then
        UIManager:GoHome()
        return
      end
      callBack()
      local index = DataModel.RightChooseIndex
      DataModel.RightChooseIndex = nil
      Controller:ChooseRightRole(index)
    end)
    return
  end
  callBack()
end

function Controller:SavePosition()
  local viewGroup = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab]
  DataModel.PosX = viewGroup.Viewport.Content.transform.localPosition.x
  DataModel.PosY = viewGroup.Viewport.Content.transform.localPosition.y
  DataModel.SetScale(DataModel.ScaleState, DataModel.SkinUnitViewId)
  DataModel.SetPosX(DataModel.PosX, DataModel.SkinUnitViewId)
  DataModel.SetPosY(DataModel.PosY, DataModel.SkinUnitViewId)
  DataModel.isLock = true
  View.Group_Change.self:SetActive(not DataModel.isLock)
  Controller:ShowUIAni()
  DataModel:SetHideTime()
  View.Group_Change.Slider_Scale:SetActive(false)
  viewGroup.self.ScrollRect.enabled = false
  viewGroup.self.transform:SetSiblingIndex(DataModel.curSelectTab - 1)
  Controller.ShowTab(true)
end

function Controller:GoBackRoleList()
  Controller.ShowTab(true)
  View.Img_Right.Group_Skin.self:SetActive(false)
  View.Img_Right.Group_Character.self:SetActive(true)
  View.Group_Character.Group_Scene.Btn_SceneChange.self:SetActive(true)
  View.Group_Character.Btn_BGChange.self:SetActive(DataModel.Scene == "Adjutant")
  local row = DataModel.RoleList[DataModel.RightChooseIndex]
  DataModel:SetRoleListData(View.Img_Right.Group_Character.ScrollGrid_MemberList.grid.self:GetElementByIndex(DataModel.RightChooseIndex - 1), row)
  local index = DataModel.RightChooseIndex or 1
  DataModel.RightChooseIndex = nil
  Controller:ChooseRightRole(index)
end

function Controller:ChooseRole()
  View.Img_Right.Group_Skin.self:SetActive(true)
  View.Img_Right.Group_Character.self:SetActive(false)
  View.Group_Character.Group_Scene.Btn_SceneChange.self:SetActive(false)
  View.Group_Character.Btn_BGChange.self:SetActive(false)
  DataModel:InitSkinView()
  if table.count(DataModel.SkinList) > 3 then
    View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:SetStartCorner("Left")
  else
    View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:SetStartCorner("Center")
  end
  View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:SetDataCount(table.count(DataModel.SkinList))
  View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:RefreshAllElement()
  View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:MoveToPos(DataModel.SkinPreviewChooseIndex)
  Controller:ClickLeftSkin(DataModel.SkinPreviewChooseIndex, true)
end

function Controller:ClickLeftSkin(index, isFirst)
  if DataModel.SkinPreviewChooseIndex == nil or index == nil or DataModel.SkinPreviewChooseIndex == index and isFirst == nil then
    return
  end
  local row = DataModel.SkinList[tonumber(index)]
  local Btn_Confirm = View.Img_Right.Group_Skin.Btn_Confirm
  Btn_Confirm.Img_Able.self:SetActive(false)
  Btn_Confirm.Img_Unable.self:SetActive(false)
  Btn_Confirm.Img_Able.Group_Change.self:SetActive(false)
  Btn_Confirm.Img_Able.Group_Using.self:SetActive(false)
  Btn_Confirm.Img_Unable.Group_Lack.self:SetActive(false)
  Btn_Confirm.Img_Unable.Group_Stage.self:SetActive(false)
  row.btn_Index = 0
  row.isSelect = true
  if row.isHave == true then
    Btn_Confirm.Img_Able.self:SetActive(true)
    if row.isWear == true then
      Btn_Confirm.Img_Able.Group_Using.self:SetActive(true)
    elseif row.isSpine2 == 1 then
      if row.isCanSpine2 then
        Btn_Confirm.Img_Able.Group_Change.self:SetActive(true)
        row.btn_Index = 1
      else
        Btn_Confirm.Img_Unable.self:SetActive(true)
        Btn_Confirm.Img_Unable.Group_Stage.self:SetActive(true)
      end
    else
      Btn_Confirm.Img_Able.Group_Change.self:SetActive(true)
      row.btn_Index = 1
    end
  else
    Btn_Confirm.Img_Unable.self:SetActive(true)
    Btn_Confirm.Img_Unable.Group_Lack.self:SetActive(true)
  end
  local element = View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:GetElementByIndex(index - 1)
  element.Img_Selected:SetActive(true)
  local old = {}
  if DataModel.SkinPreviewChooseIndex and isFirst == nil then
    old = DataModel.SkinList[tonumber(DataModel.SkinPreviewChooseIndex)]
    old.isSelect = false
    local old_element = View.Img_Right.Group_Skin.ScrollGrid_SkinList.grid.self:GetElementByIndex(DataModel.SkinPreviewChooseIndex - 1)
    if old_element then
      old_element.Img_Selected:SetActive(false)
    end
  end
  DataModel.SkinPreviewChooseIndex = index
  if not isFirst and (row.isSpine2 ~= old.isSpine2 or row.unitViewId ~= old.unitViewId) then
    Controller:CharacterLoad(row.roleId, row.unitViewId, row.isSpine2)
    Controller:InitChangeBtn()
    Controller:RefreshPosterGirlFixEffect()
  end
end

function Controller:ClickCRR()
  local Img_On = View.Img_Right.Group_Character.Btn_CRR.Img_On
  local state_n = 0
  if DataModel.UnitViewCRRState == true then
    state_n = 1
  end
  DataModel.SetIsRandomSkin(DataModel.curSelectTab, state_n)
  if DataModel.UnitViewCRRState == true then
    DOTweenTools.DOLocalMoveXCallback(View.Img_Right.Group_Character.Btn_CRR.Img_Bar.transform, 26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(View.Img_Right.Group_Character.Btn_CRR.Img_Bar.transform, -26, 0.25, function()
      Img_On:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
  end
end

function Controller.SetPainting()
  local row = DataModel.SkinList[DataModel.SkinPreviewChooseIndex]
  if not (not row.isWear and row.isHave) or row.isSpine2 == 1 and not row.isCanSpine2 then
    return
  end
  local roleId = DataModel.CurrentUnitId
  
  local function successCb()
    if row.btn_Index == 1 then
      DataModel.RoleId[DataModel.curSelectTab] = DataModel.CurrentUnitId
      DataModel.SkinUnitViewId = row.unitViewId
      DataModel.SkinUnitViewIsSpine = row.isSpine2
      local row_Role = DataModel.RoleList[DataModel.RightChooseIndex]
      row_Role.unitViewId = row.unitViewId
      DataModel.SetViewId(row.unitViewId, row_Role.roleId)
      DataModel.SetIsSpine2(row.isSpine2, row_Role.roleId)
    end
  end
  
  if DataModel.Scene == "Main" then
    Net:SendProto("main.set_receptionist", function(json)
      PlayerData:GetRoleById(roleId).trust_exp = json.trust_exp
      PlayerData:GetRoleById(roleId).trust_lv = json.trust_lv
      PlayerData:GetUserInfo().receptionist_ts[DataModel.curSelectTab] = json.server_now
      PlayerData:GetUserInfo().receptionist_id[DataModel.curSelectTab] = tostring(roleId)
      successCb()
      Controller:GoBackRoleList()
    end, roleId, DataModel.curSelectTab - 1)
  else
    Net:SendProto("main.set_adjutant", function(json)
      PlayerData:GetRoleById(roleId).trust_exp = json.trust_exp
      PlayerData:GetRoleById(roleId).trust_lv = json.trust_lv
      PlayerData:GetUserInfo().adjutant_ts[DataModel.curSelectTab] = json.server_now
      PlayerData:GetUserInfo().adjutant_id[DataModel.curSelectTab] = tostring(roleId)
      successCb()
      Controller:GoBackRoleList()
    end, roleId, DataModel.curSelectTab - 1)
  end
end

function Controller:ChangePose()
  if DataModel.PosterGirlChangeSpine then
    return
  end
  local spineIndex = DataModel.GetPosIndex(DataModel.SkinUnitViewId)
  spineIndex = spineIndex + 1
  local receptionistData = PlayerData:GetFactoryData(DataModel.SkinUnitViewId)
  if spineIndex > table.count(receptionistData.extraSpineList) then
    spineIndex = 0
  end
  DataModel.SetPosIndex(spineIndex, DataModel.SkinUnitViewId)
  DataModel.PosterGirlChangeSpine = true
  View.self:SetEnableAnimator(false)
  local viewGroup = View.Group_CharacterSkin["ScrollView_Skin" .. DataModel.curSelectTab]
  if DataModel.Live2DState then
    DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_Spine.SpineAnimation_Character, Color(1, 1, 1, 0), 0.3, function()
      Controller:CharacterLoad(DataModel.CurrentUnitId, DataModel.SkinUnitViewId, DataModel.SkinUnitViewIsSpine)
      DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_Spine.SpineAnimation_Character, Color(1, 1, 1, 1), 0.3, function()
        DataModel.PosterGirlChangeSpine = false
        View.self:SetEnableAnimator(true)
      end)
    end)
  else
    DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_Character.Img_Character, Color(1, 1, 1, 0), 0.3, function()
      Controller:CharacterLoad(DataModel.CurrentUnitId, DataModel.SkinUnitViewId, DataModel.SkinUnitViewIsSpine)
      DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_Character.Img_Character, Color(1, 1, 1, 1), 0.3, function()
        DataModel.PosterGirlChangeSpine = false
        View.self:SetEnableAnimator(true)
      end)
    end)
  end
end

return Controller
