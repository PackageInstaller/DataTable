local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UITrainSkinDataModel")
local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local MainController = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local Controller = {}

function Controller:InitView()
  MainDataModel.isTrainMoved = false
  TrainCameraManager:SetCameraDragEnable(4, false)
  MainController:HideTrain()
  DataModel.InitTrainSkinData()
  Controller:RefreshRandomChangeSkinBtn()
  Controller:RefreshHideStrikeBtn()
  Controller:RefreshHideTailerBtn()
  View.Group_TrainSkin.Group_QuickJump.ScrollGrid_QuickJump.grid.self:SetDataCount(#DataModel.coachData)
  View.Group_TrainSkin.Group_QuickJump.ScrollGrid_QuickJump.grid.self:MoveToTop()
  Controller:SelectCoach(1, true)
end

function Controller:ExitTrainSkin()
  if DataModel.lastShowSkinIdx > 0 then
    HomeCoachFactoryManager:RemoveTempSkin(DataModel.lastShowSkinIdx)
  end
  DataModel.lastShowSkinIdx = 0
  Controller:ReloadTrainSkin()
  TrainCameraManager:SetCameraDragEnable(4, true)
end

function Controller:ReloadTrainSkin()
  local isChangeSkin = false
  for i, uid in ipairs(PlayerData:GetHomeInfo().coach_template) do
    local serverCoachInfo = PlayerData:GetHomeInfo().coach_store[uid]
    if serverCoachInfo.skin ~= DataModel.cacheUsedSkin[i] then
      isChangeSkin = true
      break
    end
  end
  if isChangeSkin then
    local homeController = require("UIMainUI/UIMainUIController")
    homeController.InitTrain(false)
    homeController:InitCheDengLight()
    homeController:InitTrainEffect()
  end
end

function Controller:RefreshCoachElement(element, elementIndex)
  local isSelected = DataModel.curSelectCoachIdx == elementIndex
  element.Group_Carriage.Btn_Off:SetActive(not isSelected)
  element.Group_Carriage.Btn_On:SetActive(isSelected)
  if isSelected then
    element.Group_Carriage.Btn_On:SetClickParam(elementIndex)
    element.Group_Carriage.Btn_On.Txt_Num:SetText(string.format("%02d", elementIndex))
  else
    element.Group_Carriage.Btn_Off:SetClickParam(elementIndex)
    element.Group_Carriage.Btn_Off.Txt_Num:SetText(string.format("%02d", elementIndex))
  end
end

function Controller:ClickCoachElement(str)
  local idx = tonumber(str)
  Controller:SelectCoach(idx)
end

function Controller:SelectCoach(idx, force)
  if DataModel.curSelectCoachIdx == idx and not force then
    return
  end
  DataModel.curSelectCoachIdx = idx
  local info = DataModel.coachData[idx]
  View.Group_TrainSkin.Group_Preview.Img_PreviewBg.Txt_Preview:SetText(string.format(GetText(80602061), info.name))
  local coachShowTxt = string.format("%02d", idx)
  View.Group_TrainSkin.Group_Preview.Txt_Num:SetText(coachShowTxt)
  View.Group_TrainSkin.Group_SkinIcon.Txt_CarriageNum:SetText(coachShowTxt)
  View.Group_TrainSkin.Group_QuickJump.ScrollGrid_QuickJump.grid.self:RefreshAllElement()
  DataModel.curCoachData = info
  View.Group_TrainSkin.Group_SkinIcon.Img_Collected.Txt_Collected:SetText(string.format(GetText(80602062), info.unlockCount, info.totalCount))
  Controller:SelectSkinType(info.usedTypeIdx, true)
  Controller:RefreshHideSpeedEffectBtn()
end

function Controller:RefreshSkinElement(element, elementIndex)
  local info = DataModel.curCoachData.skins[DataModel.curSelectSkinTypeIdx][elementIndex]
  local skinCA = PlayerData:GetFactoryData(info.id)
  element.Group_CarriageSkin.Img_Bg.Txt_Name:SetText(skinCA.name)
  element.Group_CarriageSkin.Img_mengban.Img_Skin:SetSprite(skinCA.skinDisplay)
  element.Group_CarriageSkin.Img_UsingSkin:SetActive(info.used)
  element.Group_CarriageSkin.Img_Shadow:SetActive(not info.isUnlock)
  element.Group_CarriageSkin.Img_Select:SetActive(DataModel.curSelectSkinIdx == elementIndex)
  element.Group_CarriageSkin.Btn_Button:SetClickParam(elementIndex)
end

function Controller:SelectSkinType(idx, force)
  if DataModel.curSelectSkinTypeIdx == idx and not force then
    return
  end
  DataModel.curSelectSkinTypeIdx = idx
  for k, element in pairs(View.Group_TrainSkin.Img_Left) do
    if k ~= "self" then
      element.Img_ON:SetActive(false)
      element.Img_OFF:SetActive(true)
    end
  end
  local element = View.Group_TrainSkin.Img_Left.Btn_Color
  if idx == 2 then
    element = View.Group_TrainSkin.Img_Left.Btn_Character
  elseif idx == 3 then
    element = View.Group_TrainSkin.Img_Left.Btn_Special
  end
  element.Img_ON:SetActive(true)
  element.Img_OFF:SetActive(false)
  DataModel.tempCo = View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:SetDataCount(#DataModel.curCoachData.skins[DataModel.curSelectSkinTypeIdx])
    Controller:SelectSkin(1, true)
    View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:StopC(DataModel.tempCo)
  end))
end

function Controller:ClickSkinElement(str)
  local idx = tonumber(str)
  Controller:SelectSkin(idx)
end

function Controller:SelectSkin(idx, force)
  if DataModel.curSelectSkinIdx == idx and not force then
    local coachInfo = DataModel.coachData[DataModel.curSelectCoachIdx]
    local skinTable = DataModel.curCoachData.skins[DataModel.curSelectSkinTypeIdx]
    local skinInfo = skinTable[DataModel.curSelectSkinIdx]
    if not skinInfo.isUnlock then
      local t = {}
      t.coachId = coachInfo.id
      t.coachUid = coachInfo.uid
      t.skinId = skinInfo.id
      t.noShowBtn = true
      UIManager:Open("UI/Trainfactory/BuyCoachSkin", Json.encode(t))
    end
    return
  end
  DataModel.curSelectSkinIdx = idx
  local coachInfo = DataModel.coachData[DataModel.curSelectCoachIdx]
  local skinInfo = coachInfo.skins[DataModel.curSelectSkinTypeIdx][idx]
  View.Group_TrainSkin.Btn_Unlock:SetActive(not skinInfo.isUnlock)
  View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
  if DataModel.lastShowSkinIdx > 0 then
    HomeCoachFactoryManager:RemoveTempSkin(DataModel.lastShowSkinIdx)
  end
  local skinId = skinInfo.id
  local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[DataModel.curCoachData.uid]
  local usingSkinID = tonumber(serverSkinInfo.skin)
  local usingSkinCA = GetCA(skinId)
  local defaultCfg = PlayerData:GetFactoryData(99900044)
  local isSpecialSkin
  for k, v in pairs(defaultCfg.skinList) do
    if usingSkinCA.skinTag == v.tag then
      isSpecialSkin = v.tag
      break
    end
  end
  local modelSkinId = skinId
  if DataModel.curSelectCoachIdx == #DataModel.coachData and isSpecialSkin then
    modelSkinId = PlayerData.GetSpecialTrainTailSkin(isSpecialSkin, modelSkinId)
  end
  DataModel.lastShowSkinIdx = modelSkinId
  local coachSkin = HomeCoachFactoryManager:GenerateTempSkin(modelSkinId)
  local camera = TrainCameraManager:GetCamera(4)
  if camera == nil or camera:IsNull() then
    coachSkin:SetPosition(Vector3(10000, 0, 0))
  end
  View.Group_TrainSkin.Group_Btn.Img_bg3:SetActive(usingSkinID == skinId and usingSkinCA.showEffect)
  local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[DataModel.curCoachData.uid]
  local usingSkinID = tonumber(serverSkinInfo.skin)
  local usingSkinCA = GetCA(skinId, "HomeCoachFactory")
  View.Group_TrainSkin.Group_Btn.Img_bg3:SetActive(usingSkinID == skinId and usingSkinCA.showEffect)
  local curUsingIsSpecial = PlayerData.CurTrainSkinIsSpecial()
  View.Group_TrainSkin.Btn_Use:SetActive(skinInfo.isUnlock and not skinInfo.used and not isSpecialSkin and not curUsingIsSpecial)
  View.Group_TrainSkin.Btn_Alluse:SetActive(DataModel.CheckShowAllUse(skinInfo))
  local skinCA = PlayerData:GetFactoryData(skinInfo.id)
  if 0 < #skinCA.normalEntryList then
    View.Group_TrainSkin.Img_Shadow:SetActive(true)
    View.Group_TrainSkin.Group_SpecialTitle.self:SetActive(true)
    View.Group_TrainSkin.Group_SpecialTitle.Img_SpecialTitle.Txt_Text.Txt_English:SetActive(not CommonTips.IsResEN())
    for i = 1, 6 do
      local element = View.Group_TrainSkin.Group_SpecialTitle["Group_SpecialEntry" .. i]
      local info = skinCA.normalEntryList[i]
      if info then
        element:SetActive(true)
        local ca = PlayerData:GetFactoryData(info.id, "TrainWeaponSkillFactory")
        local valueA
        if ca.aTypeInt == 1 then
          valueA = ca.aNumMinP
          if ca.aDevelopment then
            valueA = ca.aNumMinP * ca.aCommonNumP
          else
            valueA = valueA * ca.aCommonNumP
          end
        else
          valueA = ca.aNumMin
          if ca.aDevelopment then
            valueA = ca.aNumMin * ca.aCommonNum
          else
            valueA = valueA * ca.aCommonNum
          end
          valueA = ClearFollowZero(valueA)
        end
        local tagCa = PlayerData:GetFactoryData(ca.entryTag)
        local icon = tagCa.icon
        element.Img_Icon:SetSprite(icon)
        local text = "<color=#D2B075>" .. ca.name .. "</color>\227\128\128" .. string.format(ca.text, valueA)
        element.Txt_Entry:SetText(text)
        local txtHeight = element.Txt_Entry:GetHeight()
        element.Txt_Entry:SetHeight(txtHeight)
        element:SetHeight(txtHeight)
      else
        element:SetActive(false)
      end
    end
    View.Group_TrainSkin.Group_SpecialTitle.self:SetActive(false)
    View.Group_TrainSkin.Group_SpecialTitle.self:SetActive(true)
  else
    View.Group_TrainSkin.Img_Shadow:SetActive(false)
    View.Group_TrainSkin.Group_SpecialTitle:SetActive(false)
  end
end

function Controller:UseSkin()
  local skinTable = DataModel.curCoachData.skins[DataModel.curSelectSkinTypeIdx]
  local skinId = skinTable[DataModel.curSelectSkinIdx].id
  local serverParam = DataModel.curCoachData.uid .. ":" .. skinId
  Net:SendProto("home.update_skin", function(json)
    local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[DataModel.curCoachData.uid]
    serverSkinInfo.skin = tostring(skinId)
    local skinInfo = skinTable[DataModel.curSelectSkinIdx]
    local usedSkinTable = DataModel.curCoachData.skins[DataModel.curCoachData.usedTypeIdx]
    usedSkinTable[1].used = false
    DataModel.SortSkinTable(usedSkinTable)
    DataModel.curCoachData.usedTypeIdx = DataModel.curSelectSkinTypeIdx
    skinInfo.used = true
    DataModel.SortSkinTable(skinTable)
    DataModel.curSelectSkinIdx = 1
    View.Group_TrainSkin.Btn_Use:SetActive(false)
    View.Group_TrainSkin.Btn_Alluse:SetActive(DataModel.CheckShowAllUse(skinInfo))
    View.Group_TrainSkin.Btn_Unlock:SetActive(false)
    View.Group_TrainSkin.Group_SkinIcon.Img_Collected.Txt_Collected:SetText(string.format(GetText(80602062), DataModel.curCoachData.unlockCount, #DataModel.curCoachData.skins))
    View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
    CommonTips.OpenTips(80602063)
    TrainWeaponTag.CalTrainWeaponAllAttributes()
    Controller:RefreshHideSpeedEffectBtn()
  end, serverParam)
end

function Controller:UnlockSkin()
  local coachInfo = DataModel.coachData[DataModel.curSelectCoachIdx]
  local skinTable = DataModel.curCoachData.skins[DataModel.curSelectSkinTypeIdx]
  local skinInfo = skinTable[DataModel.curSelectSkinIdx]
  
  local function callback()
    local t = {}
    t.coachId = coachInfo.id
    t.coachUid = coachInfo.uid
    t.skinId = skinInfo.id
    UIManager:Open("UI/Trainfactory/BuyCoachSkin", Json.encode(t), function()
      skinInfo.isUnlock = true
      DataModel.curCoachData.unlockCount = DataModel.curCoachData.unlockCount + 1
      local skinCA = PlayerData:GetFactoryData(skinInfo.id)
      CommonTips.OnPrompt(string.format(GetText(80602064), skinCA.name), nil, nil, function()
        Controller:UseSkin()
      end, function()
        DataModel.SortSkinTable(skinTable)
        for i, v in ipairs(skinTable) do
          if v.id == skinInfo.id then
            DataModel.curSelectSkinIdx = i
            break
          end
        end
        View.Group_TrainSkin.Btn_Use:SetActive(true)
        View.Group_TrainSkin.Btn_Unlock:SetActive(false)
        View.Group_TrainSkin.Group_SkinIcon.Img_Collected.Txt_Collected:SetText(string.format(GetText(80602062), DataModel.curCoachData.unlockCount, #DataModel.curCoachData.skins))
        View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
      end)
    end)
  end
  
  local config = PlayerData:GetFactoryData(99900053, "ConfigFactory")
  if config.studyUI then
    callback()
    return
  end
  if skinInfo.study and skinInfo.study > 0 then
    local studyDataModel = require("UIHomeCarriageeditor/UIStudyDataModel")
    studyDataModel.SetAutoSelect(skinInfo.study)
    MainController:SelectTag(MainDataModel.TagType.Study)
    return
  end
  callback()
end

function Controller:AllUseSkin()
  local curSkinTable = DataModel.curCoachData.skins[DataModel.curSelectSkinTypeIdx]
  local skinInfo = curSkinTable[DataModel.curSelectSkinIdx]
  local skinId = skinInfo.id
  local skinCA = PlayerData:GetFactoryData(skinId)
  local tagSkinIds = DataModel.skinTagSkinIds[skinCA.skinTag]
  local cacheSameSkin = {}
  for i, v in ipairs(tagSkinIds) do
    cacheSameSkin[v] = 1
  end
  local cacheCoachUseSkin = {}
  for i, v in ipairs(DataModel.coachData) do
    if i ~= DataModel.curSelectCoachIdx then
      local skinTable = v.skins[DataModel.curSelectSkinTypeIdx]
      for i1, tempSkinInfo in ipairs(skinTable) do
        if cacheSameSkin[tempSkinInfo.id] then
          if tempSkinInfo.isUnlock and not tempSkinInfo.used then
            cacheCoachUseSkin[v.uid] = tostring(tempSkinInfo.id)
          end
          break
        end
      end
    end
  end
  local serverParam = ""
  if not skinInfo.used then
    serverParam = DataModel.curCoachData.uid .. ":" .. skinId
  end
  for k, v in pairs(cacheCoachUseSkin) do
    if serverParam == "" then
      serverParam = k .. ":" .. v
    else
      serverParam = serverParam .. "," .. k .. ":" .. v
    end
  end
  local skinTag
  local defaultCfg = PlayerData:GetFactoryData(99900044)
  for k, v in pairs(defaultCfg.skinList) do
    if skinCA.skinTag == v.tag then
      skinTag = tostring(v.tag)
      break
    end
  end
  if skinTag and #PlayerData:GetHomeInfo().coach_template > #tagSkinIds then
    CommonTips.OpenTips(80611462)
    return
  end
  
  local function cb()
    Net:SendProto("home.update_skin", function(json)
      local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[DataModel.curCoachData.uid]
      serverSkinInfo.skin = tostring(skinId)
      if not skinInfo.used then
        local usedSkinTable = DataModel.curCoachData.skins[DataModel.curCoachData.usedTypeIdx]
        usedSkinTable[1].used = false
        DataModel.SortSkinTable(usedSkinTable)
        DataModel.curCoachData.usedTypeIdx = DataModel.curSelectSkinTypeIdx
        skinInfo.used = true
        DataModel.SortSkinTable(curSkinTable)
      end
      for k, v in pairs(cacheCoachUseSkin) do
        local tempSeverSkinInfo = PlayerData:GetHomeInfo().coach_store[k]
        tempSeverSkinInfo.skin = v
      end
      for i, v in ipairs(DataModel.coachData) do
        if cacheCoachUseSkin[v.uid] then
          local usedSkinTable = v.skins[v.usedTypeIdx]
          usedSkinTable[1].used = false
          DataModel.SortSkinTable(usedSkinTable)
          local skinTable = v.skins[DataModel.curSelectSkinTypeIdx]
          for i1, tempSkinInfo in ipairs(skinTable) do
            if tempSkinInfo.id == tonumber(cacheCoachUseSkin[v.uid]) then
              tempSkinInfo.used = true
              v.usedTypeIdx = DataModel.curSelectSkinTypeIdx
              DataModel.SortSkinTable(skinTable)
              break
            end
          end
        end
      end
      DataModel.curSelectSkinIdx = 1
      View.Group_TrainSkin.Btn_Use:SetActive(false)
      View.Group_TrainSkin.Btn_Alluse:SetActive(false)
      View.Group_TrainSkin.Btn_Unlock:SetActive(false)
      View.Group_TrainSkin.NewScrollGrid_CarriageSkin.grid.self:RefreshAllElement()
      CommonTips.OpenTips(80602063)
      if skinTag then
        PlayerData:SetPlayerPrefs("int", "OutStationRandomChangeSkin", 0)
        View.Group_TrainSkin.Group_Btn.Img_bg1.Btn_Button.Img_OFF:SetActive(true)
        View.Group_TrainSkin.Group_Btn.Img_bg1.Btn_Button.Img_ON:SetActive(false)
      end
      TrainWeaponTag.CalTrainWeaponAllAttributes()
      Controller:RefreshHideSpeedEffectBtn()
      View.Group_TrainSkin.Group_Btn.Img_bg1:SetActive(not skinTag)
      View.Group_TrainSkin.Group_Btn.Img_bg2:SetActive(not skinTag)
    end, serverParam, skinTag)
  end
  
  if skinTag then
    CommonTips.OnPrompt(80611460, nil, nil, function()
      cb()
    end)
  else
    cb()
  end
end

function Controller:RefreshRandomChangeSkinBtn()
  local specialTag = PlayerData.CurTrainSkinIsSpecial()
  View.Group_TrainSkin.Group_Btn.Img_bg1:SetActive(not specialTag)
  if specialTag then
    return
  end
  local isHide = PlayerData:GetPlayerPrefs("int", "OutStationRandomChangeSkin") == 1
  View.Group_TrainSkin.Group_Btn.Img_bg1.Btn_Button.Img_OFF:SetActive(not isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg1.Btn_Button.Img_ON:SetActive(isHide)
end

function Controller:ClickRandomChangeSkinBtn()
  local isHide = PlayerData:GetPlayerPrefs("int", "OutStationRandomChangeSkin") == 1
  local newState = 1
  if isHide then
    newState = 0
  end
  PlayerData:SetPlayerPrefs("int", "OutStationRandomChangeSkin", newState)
  View.Group_TrainSkin.Group_Btn.Img_bg1.Btn_Button.Img_OFF:SetActive(isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg1.Btn_Button.Img_ON:SetActive(not isHide)
end

function Controller:RefreshHideStrikeBtn()
  local specialTag = PlayerData.CurTrainSkinIsSpecial()
  View.Group_TrainSkin.Group_Btn.Img_bg2:SetActive(not specialTag)
  if specialTag then
    return
  end
  local isHide = PlayerData:GetPlayerPrefs("int", "HideCoachWeaponStrike") == 1
  View.Group_TrainSkin.Group_Btn.Img_bg2.Btn_Button.Img_OFF:SetActive(not isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg2.Btn_Button.Img_ON:SetActive(isHide)
end

function Controller:ClickHideStrikeBtn()
  local isHide = PlayerData:GetPlayerPrefs("int", "HideCoachWeaponStrike") == 1
  local newState = 1
  if isHide then
    newState = 0
  end
  PlayerData:SetPlayerPrefs("int", "HideCoachWeaponStrike", newState)
  View.Group_TrainSkin.Group_Btn.Img_bg2.Btn_Button.Img_OFF:SetActive(isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg2.Btn_Button.Img_ON:SetActive(not isHide)
  PlayerData.RefreshStriker(nil, true)
end

function Controller:RefreshHideSpeedEffectBtn()
  local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[DataModel.curCoachData.uid]
  local skinID = tonumber(serverSkinInfo.skin)
  local skinCA = GetCA(skinID, "HomeCoachFactory")
  local canShowBtn = skinCA.showEffect
  View.Group_TrainSkin.Group_Btn.Img_bg3:SetActive(canShowBtn)
  if canShowBtn then
    local isHide = PlayerData:GetPlayerPrefs("int", "HideSpeedEffect") == 1
    View.Group_TrainSkin.Group_Btn.Img_bg3.Btn_Button.Img_OFF:SetActive(not isHide)
    View.Group_TrainSkin.Group_Btn.Img_bg3.Btn_Button.Img_ON:SetActive(isHide)
  end
end

function Controller:ClickHideSpeedEffectBtn()
  local isHide = PlayerData:GetPlayerPrefs("int", "HideSpeedEffect") == 1
  local newState = 1
  if isHide then
    newState = 0
  end
  PlayerData:SetPlayerPrefs("int", "HideSpeedEffect", newState)
  View.Group_TrainSkin.Group_Btn.Img_bg3.Btn_Button.Img_OFF:SetActive(isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg3.Btn_Button.Img_ON:SetActive(not isHide)
end

function Controller:RefreshHideTailerBtn()
  local isHide = PlayerData:GetPlayerPrefs("int", "HideTailer") == 1
  View.Group_TrainSkin.Group_Btn.Img_bg4.Btn_Button.Img_OFF:SetActive(not isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg4.Btn_Button.Img_ON:SetActive(isHide)
end

function Controller:ClickHideTailerBtn()
  local isHide = PlayerData:GetPlayerPrefs("int", "HideTailer") == 1
  local newState = 1
  if isHide then
    newState = 0
  end
  PlayerData:SetPlayerPrefs("int", "HideTailer", newState)
  View.Group_TrainSkin.Group_Btn.Img_bg4.Btn_Button.Img_OFF:SetActive(isHide)
  View.Group_TrainSkin.Group_Btn.Img_bg4.Btn_Button.Img_ON:SetActive(not isHide)
end

return Controller
