if not EDITOR then
  return
end
CheckCgPosEditor = {
  CurController = nil,
  CurCgUIName = nil,
  callbackList = {},
  refreshFuncDic = {}
}

function CheckCgPosEditorReady()
  local gameLogic = GameGlobal.GameLogic()
  if gameLogic and gameLogic.inited and GameGlobal.UIStateManager():GetController("UIMainLobbyController") then
    GameGlobal.GetUIModule(SignInModule)._openList = {}
    CheckCgPosEditor.CurCgUIName = "UIMainLobbyController"
    CheckCgPosEditor.CurController = GameGlobal.UIStateManager():GetController("UIMainLobbyController")
    CheckCgPosEditor.refreshFuncDic.UIMainLobbyController = CgPosEditorRefreshUIMainLobbyController
    CheckCgPosEditor.refreshFuncDic.UIPetDetailItem = CgPosEditorRefreshUIPetDetailItem
    CheckCgPosEditor.refreshFuncDic.UIUpLevelInterfaceController = CgPosEditorRefreshUIUpLevelInterfaceController
    CheckCgPosEditor.refreshFuncDic.UIGradeInterfaceController = CgPosEditorRefreshUIGradeInterfaceController
    CheckCgPosEditor.refreshFuncDic.UIGradeInterfaceController_color = CgPosEditorRefreshUIGradeInterfaceController_color
    CheckCgPosEditor.refreshFuncDic.UIBreakController = CgPosEditorRefreshUIBreakController
    CheckCgPosEditor.refreshFuncDic.UIHelpPetInfoController = CgPosEditorRefreshUIHelpPetInfoController
    CheckCgPosEditor.refreshFuncDic.UIBattleResultComplete = CgPosEditorRefreshUIBattleResultComplete
    CheckCgPosEditor.refreshFuncDic.UIAircraftEnterBuildController = CgPosEditorRefreshUIAircraftEnterBuildController
    CheckCgPosEditor.refreshFuncDic.UIGradeSkillPanelController = CgPosEditorRefreshUIGradeSkillPanelController
    CheckCgPosEditor.refreshFuncDic.UIPetObtain = CgPosEditorRefreshUIPetObtain
    CheckCgPosEditor.refreshFuncDic.UIPetObtain_mid = CgPosEditorRefreshUIPetObtain_mid
    CheckCgPosEditor.refreshFuncDic.UIWidgetPetInfo = CgPosEditorRefreshUIWidgetPetInfo
    CheckCgPosEditor.refreshFuncDic.UISpineContainer = CgPosEditorRefreshUISpineContainer
    CheckCgPosEditor.refreshFuncDic.UIChooseAssistantController = CgPosEditorRefreshUIChooseAssistantController
    CheckCgPosEditor.refreshFuncDic.UIPetIntimacyMainController = CgPosEditorRefreshUIPetIntimacyMainController
    CheckCgPosEditor.refreshFuncDic.UIStoryBanner = CgPosEditorRefreshUIStoryBanner
    CheckCgPosEditor.refreshFuncDic.UIPetSkinsMainController = CgPosEditorRefreshUIPetSkinsMainController
    CheckCgPosEditor.refreshFuncDic.UIPetSkinsMainController_mid = CgPosEditorRefreshUIPetSkinsMainController_mid
    CheckCgPosEditor.refreshFuncDic.UIPlayerInfoController = CgPosEditorRefreshUIPlayerInfoController
    return GameGlobal.UIStateManager():IsTopUI("UIMainLobbyController")
  end
  return false
end

function CgPosEditorGetPetID(uiname)
  if uiname == "UIMainLobbyController" then
    local con = GameGlobal.UIStateManager():GetController(uiname)
    return con._main_lobby_bg._defaultPetID
  end
end

function CgPosEditorGetSkinID(uiname)
  if uiname == "UIMainLobbyController" then
    local con = GameGlobal.UIStateManager():GetController(uiname)
    con = con._main_lobby_bg
    local petID = con._defaultPetID
    local grade = con._assistantGrade
    local skinID = con._assistantSkinID
    local asid = con.asid
    if skinID and 0 < skinID then
      return skinID
    end
    if grade == 0 then
      return Cfg.cfg_pet[petID].SkinId
    else
      return Cfg.cfg_pet_grade({PetID = petID, Grade = grade})[1].SkinId
    end
  end
end

function CgPosEditorRefreshUICg(uiname, checkcg, skinID, offset, scale, l2d)
  if uiname ~= nil then
    if CgPosEditorGetRealUIName(uiname) == CheckCgPosEditor.CurController.name then
      CheckCgPosEditor.CurCgUIName = uiname
      CgPosEditorRefreshCgSkin(checkcg, skinID, offset, scale)
    else
      if CheckCgPosEditor.CurController.name ~= "UIMainLobbyController" then
        if CheckCgPosEditor.CurDynamicCGHandle then
          CheckCgPosEditor.CurDynamicCGHandle:Release()
          CheckCgPosEditor.CurDynamicCGHandle = nil
        end
        CheckCgPosEditor.CurController:CloseDialog()
      end
      CgPosEditorShowUI(uiname, checkcg, skinID, offset, scale)
    end
  elseif checkcg ~= nil or skinID ~= nil then
    CgPosEditorRefreshCgSkin(checkcg, skinID, offset, scale, l2d)
  else
    CgPosEditorRefreshOffsetScale(offset, scale)
  end
end

function CgPosEditorRefreshCgSkin(checkcg, skinID, offset, scale, l2d)
  if CheckCgPosEditor.CurDynamicCGHandle then
    CheckCgPosEditor.CurDynamicCGHandle:Release()
    CheckCgPosEditor.CurDynamicCGHandle = nil
  end
  CheckCgPosEditor.refreshFuncDic[CheckCgPosEditor.CurCgUIName](checkcg, skinID, offset, scale, l2d)
end

function CgPosEditorRefreshOffsetScale(offset, scale)
  CheckCgPosEditor.refreshFuncDic[CheckCgPosEditor.CurCgUIName](nil, nil, offset, scale)
end

function CgPosEditorGetRealUIName(uiname)
  local realUIName = uiname
  if uiname == "UIPetDetailItem" then
    realUIName = "UISpiritDetailGroupController"
  elseif uiname == "UIGradeInterfaceController_color" then
    realUIName = "UIGradeInterfaceController"
  elseif uiname == "UIPetObtain_mid" then
    realUIName = "UIPetObtain"
  elseif uiname == "UIWidgetPetInfo" then
    realUIName = "UIBattle"
  elseif uiname == "UISpineContainer" then
    realUIName = "UIShopPetDetailController"
  elseif uiname == "UIPetSkinsMainController_mid" then
    realUIName = "UIPetSkinsMainController"
  end
  return realUIName
end

function CgPosEditorShowUI(uiname, checkcg, skinID, offset, scale)
  local realUIName = CgPosEditorGetRealUIName(uiname)
  CheckCgPosEditor.callbackList[realUIName] = GameHelper:GetInstance():CreateCallback(function()
    CheckCgPosEditor.CurCgUIName = uiname
    CheckCgPosEditor.CurController = GameGlobal.UIStateManager():GetController(realUIName)
    CgPosEditorRefreshCgSkin(checkcg, skinID, offset, scale)
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIOpen, CheckCgPosEditor.callbackList[realUIName])
    CheckCgPosEditor.callbackList[realUIName] = nil
  end)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIOpen, CheckCgPosEditor.callbackList[realUIName])
  if realUIName == "UIMainLobbyController" then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  elseif realUIName == "UISpiritDetailGroupController" then
    CgPosEditorSetModulePetData(skinID)
    GameGlobal.UIStateManager():ShowDialog(realUIName, Cfg.cfg_pet_skin[skinID].PetId)
    
    function UISpiritDetailGroupController.CheckRedPoint()
    end
    
    function UISpiritDetailGroupController.CheckSkinRedPoint()
    end
  elseif realUIName == "UIUpLevelInterfaceController" then
    CgPosEditorSetModulePetData(skinID)
    GameGlobal.UIStateManager():ShowDialog(realUIName, Cfg.cfg_pet_skin[skinID].PetId)
  elseif realUIName == "UIGradeInterfaceController" then
    GameGlobal.GetUIModule(PetModule).GetSortedPets = function()
      local petInfo = pet_data:New()
      petInfo.pet_pstid = 1
      petInfo.template_id = Cfg.cfg_pet_skin[skinID].PetId
      petInfo.level = 1
      petInfo.grade = 1
      petInfo.awakening = 1
      petInfo.affinity_level = 1
      petInfo.current_skin = 0
      local pet = Pet:New(petInfo)
      return {pet}
    end
    GameGlobal.UIStateManager():ShowDialog(realUIName, Cfg.cfg_pet_skin[skinID].PetId)
  elseif realUIName == "UIBreakController" then
    CgPosEditorSetModulePetData(skinID)
    GameGlobal.UIStateManager():ShowDialog(realUIName, Cfg.cfg_pet_skin[skinID].PetId)
  elseif realUIName == "UIHelpPetInfoController" then
    local pet = {}
    pet.m_nTemplateID = Cfg.cfg_pet_skin[skinID].PetId
    pet.m_nLevel = 1
    pet.m_nGrade = Cfg.cfg_pet_skin[skinID].UnlockType[1] == 2 and Cfg.cfg_pet_skin[skinID].UnlockType[2] or 1
    pet.m_nAwake = 1
    pet.m_nEquipLevel = 0
    pet.m_nSkinID = 0
    pet.m_nAwakeLock = 1
    
    function UIFightSkillItem.CheckRefineSkillReplace()
      return false
    end
    
    GameGlobal.UIStateManager():ShowDialog(realUIName, pet)
  elseif realUIName == "UIBattleResultComplete" then
    local playerInfo = {}
    playerInfo.pet_list = {}
    local pet = MatchPetInfo:New()
    pet.template_id = Cfg.cfg_pet_skin[skinID].PetId
    pet.level = 1
    pet.grade = Cfg.cfg_pet_skin[skinID].UnlockType[1] == 2 and Cfg.cfg_pet_skin[skinID].UnlockType[2] or 1
    pet.awakening = 1
    pet.affinity_level = 1
    pet.current_skin = 0
    local pet2 = MatchPetInfo:New()
    pet2.template_id = 1500331
    pet2.level = 1
    pet2.grade = 1
    pet2.awakening = 1
    pet2.affinity_level = 1
    pet2.current_skin = 0
    local pet3 = MatchPetInfo:New()
    pet3.template_id = 1600021
    pet3.level = 1
    pet3.grade = 1
    pet3.awakening = 1
    pet3.affinity_level = 1
    pet3.current_skin = 0
    local pet4 = MatchPetInfo:New()
    pet4.template_id = 1600251
    pet4.level = 1
    pet4.grade = 1
    pet4.awakening = 1
    pet4.affinity_level = 1
    pet4.current_skin = 0
    local pet5 = MatchPetInfo:New()
    pet5.template_id = 1600641
    pet5.level = 1
    pet5.grade = 3
    pet5.awakening = 1
    pet5.affinity_level = 1
    pet5.current_skin = 0
    playerInfo.pet_list[1] = pet
    playerInfo.pet_list[2] = pet2
    playerInfo.pet_list[3] = pet3
    playerInfo.pet_list[4] = pet4
    playerInfo.pet_list[5] = pet5
    local matchEnterData = MatchEnterData:New(1, {}, {playerInfo})
    GameGlobal.GetModule(MatchModule).m_match_enter_data = matchEnterData
    
    function MatchEnterData.GetMissionCreateInfo()
      return nil
    end
    
    local matchRes = UI_MatchResult:New()
    matchRes.m_nMatchType = MatchType.MT_Mission
    matchRes.m_activity_rewards = {}
    GameGlobal.GetModule(GameMatchModule)._match_result = matchRes
    GameGlobal.UIStateManager():ShowDialog(realUIName, true, playerInfo.pet_list)
  elseif realUIName == "UIAircraftEnterBuildController" then
    CgPosEditorSetModuleSortPetData(skinID)
    local roomData = AircraftRoomBase:New()
    roomData._spaceid = 1
    roomData._roomid = 7101001
    GameGlobal.UIStateManager():ShowDialog(realUIName, roomData, 1)
  elseif realUIName == "UIGradeSkillPanelController" then
    CgPosEditorSetModulePet(skinID)
    GameGlobal.UIStateManager():ShowDialog(realUIName, 1)
  elseif realUIName == "UIPetObtain" then
    local ra = RoleAsset:New()
    ra.assetid = Cfg.cfg_pet_skin[skinID].PetId
    GameGlobal.UIStateManager():ShowDialog(realUIName, {ra}, nil, true)
  elseif realUIName == "UIBattle" then
    local matchpetlist = {}
    local playerInfo = {}
    playerInfo.pet_list = {}
    local pet = MatchPetInfo:New()
    pet.template_id = Cfg.cfg_pet_skin[skinID].PetId
    pet.level = 1
    pet.grade = Cfg.cfg_pet_skin[skinID].UnlockType[1] == 2 and Cfg.cfg_pet_skin[skinID].UnlockType[2] or 1
    pet.awakening = 1
    pet.affinity_level = 1
    pet.current_skin = 0
    pet.pet_pstid = 1
    for i = 1, 5 do
      playerInfo.pet_list[i] = pet
      matchpetlist[#matchpetlist + 1] = MatchPet:New(pet)
    end
    local matchEnterData = MatchEnterData:New(1, {}, {playerInfo})
    matchEnterData._wordBuffIds = {}
    
    function matchEnterData.GetLocalMatchPets()
      return matchpetlist
    end
    
    GameGlobal.GetModule(MatchModule).m_match_enter_data = matchEnterData
    
    function ConfigServiceHelper.GetChangeTeamLeaderCount()
      return 1
    end
    
    function ConfigServiceHelper.GetLevelConfigData()
      local lcd = {}
      
      function lcd.GetLevelID()
        return 1
      end
      
      function lcd.GetLevelRoundCount()
        return 1
      end
      
      return lcd
    end
    
    function UIBattleProgressInfo.RefreshWaveInfo()
    end
    
    function BattleStatHelper.GetCurRoundDoActiveSkillTimes()
      return 1
    end
    
    function BattleStatHelper.GetLevelOutOfRoundType()
      return 1
    end
    
    function BattleStatHelper.GetLevelOutOfRoundType()
      return 0
    end
    
    function ConfigServiceHelper.GetSkillConfigData()
      local scd = {}
      
      function scd.GetSkillTriggerParam()
        return 1
      end
      
      function scd.GetSkillTriggerType()
      end
      
      return scd
    end
    
    function InnerGameHelperRender.UISetUIPetAccumulateNum()
    end
    
    function MatchEnterData.GetMissionCreateInfo()
      return nil
    end
    
    function InnerGameHelperRender.GetLocalMatchPets()
      return matchEnterData:GetLocalMatchPets()
    end
    
    GameGlobal.UIStateManager():ShowDialog(realUIName)
  elseif realUIName == "UIShopPetDetailController" then
    GameGlobal.UIStateManager():ShowDialog(realUIName, Cfg.cfg_pet_skin[skinID].PetId)
  elseif realUIName == "UIPetIntimacyMainController" then
    GameGlobal.UIStateManager():ShowDialog(realUIName, Cfg.cfg_pet_skin[skinID].PetId, PetIntimacyWindowType.FilesPanel)
  elseif realUIName == "UIStoryBanner" then
    GameGlobal.UIStateManager():ShowDialog(realUIName, 1, StoryBannerShowType.HalfPortrait)
  elseif realUIName == "UIPetSkinsMainController" then
    GameGlobal.UIStateManager():ShowDialog(realUIName, PetSkinUiOpenType.PSUOT_SHOW_LIST, Cfg.cfg_pet_skin[skinID].PetId)
  else
    GameGlobal.UIStateManager():ShowDialog(realUIName)
  end
end

function CgPosEditorSetModulePet(skinID)
  local petData = pet_data:New()
  petData.pet_pstid = 1
  petData.template_id = Cfg.cfg_pet_skin[skinID].PetId
  petData.level = 1
  petData.grade = 0
  petData.awakening = 1
  petData.affinity_level = 1
  petData.current_skin = 0
  GameGlobal.GetModule(PetModule):AddPet(petData)
  GameGlobal.GetUIModule(PetModule).GetDiffWithGrade = function()
    local body = UIFightSkillChangeData:New("type", PetSkillChangeState.Improved, {""}, {
      Cfg.cfg_pet_skin[skinID].StaticBody
    })
    return body, {}
  end
end

function CgPosEditorSetModulePetData(skinID)
  GameGlobal.GetUIModule(PetModule).GetSortedPets = function()
    local petInfo = pet_data:New()
    petInfo.pet_pstid = 1
    petInfo.template_id = Cfg.cfg_pet_skin[skinID].PetId
    petInfo.level = 1
    petInfo.grade = Cfg.cfg_pet_skin[skinID].UnlockType[1] == 2 and Cfg.cfg_pet_skin[skinID].UnlockType[2] or 1
    petInfo.awakening = 1
    petInfo.affinity_level = 1
    petInfo.current_skin = 0
    local pet = Pet:New(petInfo)
    return {pet}
  end
end

function CgPosEditorSetModuleSortPetData(skinID)
  GameGlobal.GetModule(PetModule)._SortPets = function()
    local petInfo = pet_data:New()
    petInfo.pet_pstid = 1
    petInfo.template_id = Cfg.cfg_pet_skin[skinID].PetId
    petInfo.level = 1
    petInfo.grade = Cfg.cfg_pet_skin[skinID].UnlockType[1] == 2 and Cfg.cfg_pet_skin[skinID].UnlockType[2] or 1
    petInfo.awakening = 1
    petInfo.affinity_level = 1
    petInfo.current_skin = 0
    local pet = Pet:New(petInfo)
    return {pet}
  end
end

function CgPosEditorRefreshUIMainLobbyController(checkcg, skinID, offset, scale, l2d)
  local widget = CheckCgPosEditor.CurController._main_lobby_bg
  local spineSke = widget._spine.CurrentSkeleton
  spineSke = spineSke or widget._spine.CurrentMultiSkeleton
  if checkcg ~= nil then
    widget._cgGo:SetActive(checkcg)
    widget._spineGo:SetActive(not checkcg)
  end
  if skinID ~= nil then
    if checkcg then
      if Cfg.cfg_pet_skin[skinID] and Cfg.cfg_pet_skin[skinID].StaticBody then
        widget._cg:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
      else
        widget._cg:LoadImage(Cfg.cfg_only_assistant[skinID].CG)
      end
    elseif Cfg.cfg_pet_skin[skinID] and Cfg.cfg_pet_skin[skinID].Spine then
      if l2d then
        widget._spine:DestroyCurrentSpine()
        CheckCgPosEditor.CurDynamicCGHandle = DynamicCG.SyncLoad(Cfg.cfg_pet_skin[skinID].Spine, widget._spine)
      elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
        local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
        widget._spine:LoadSpine(spineRes)
      else
        widget._spine:LoadSpine(Cfg.cfg_pet_skin[skinID].Spine)
      end
    else
      widget._spine:LoadSpine(Cfg.cfg_only_assistant[skinID].Spine)
      local spineSke = widget._spine.CurrentSkeleton
      spineSke = spineSke or widget._spine.CurrentMultiSkeleton
      if spineSke then
        spineSke:Initialize(true)
        spineSke.AnimationState:SetAnimation(0, Cfg.cfg_only_assistant[skinID].SpineAnim, true)
      end
    end
  end
  if widget._cgGo.activeSelf then
    widget._cgGo.transform.anchoredPosition = offset
    widget._cgGo.transform.localScale = Vector3(scale, scale, scale)
  else
    widget._spineGo.transform.anchoredPosition = offset
    widget._spineGo.transform.localScale = Vector3(scale, scale, scale)
  end
end

function CgPosEditorRefreshUIPetDetailItem(checkcg, skinID, offset, scale, l2d)
  if checkcg ~= nil then
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo:SetActive(checkcg)
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._spineGo:SetActive(not checkcg)
  end
  if skinID ~= nil then
    if checkcg then
      CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadCgSync(Cfg.cfg_pet_skin[skinID].StaticBody, true)
    elseif l2d then
      CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadSpineSync(Cfg.cfg_pet_skin[skinID].Spine, true)
    elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
      local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
      CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadSpineSync(spineRes, true)
    else
      CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadSpineSync(Cfg.cfg_pet_skin[skinID].Spine, true)
    end
  end
  if CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.activeSelf then
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.localScale = Vector3(scale, scale, scale)
  else
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._spineGo.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._spineGo.transform.localScale = Vector3(scale, scale, scale)
  end
end

function CgPosEditorRefreshUIUpLevelInterfaceController(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadCgSync(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIGradeInterfaceController(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadCgSync(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIGradeInterfaceController_color(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._bgCgCenter:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._bgCgCenter.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._bgCgCenter.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIBreakController(checkcg, skinID, offset, scale)
  GameGlobal.TaskManager():StartTask(function(TT)
    if not CheckCgPosEditor.CurController._itemTable then
      YIELD(TT)
      YIELD(TT)
      YIELD(TT)
    end
    if skinID ~= nil then
      CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadCgSync(Cfg.cfg_pet_skin[skinID].StaticBody)
    end
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.localScale = Vector3(scale, scale, scale)
  end)
end

function CgPosEditorRefreshUIHelpPetInfoController(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController.cgNormal:Load(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController.cgRect.anchoredPosition = offset
  CheckCgPosEditor.CurController.cgRect.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIBattleResultComplete(checkcg, skinID, offset, scale)
  CheckCgPosEditor.CurController._dialogLeftGO:SetActive(false)
  CheckCgPosEditor.CurController._dialogRightGO:SetActive(false)
  if skinID ~= nil then
    local cg = Cfg.cfg_pet_skin[skinID].SimpleCG
    cg = cg or Cfg.cfg_pet_skin[skinID].StaticBody
    CheckCgPosEditor.CurController._imgRoleList[1]:LoadImage(cg)
    CheckCgPosEditor.CurController._imgShadowList[1]:LoadImage(cg)
  end
  CheckCgPosEditor.CurController._imgRoleList[1].gameObject.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._imgShadowList[1].gameObject.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._imgRoleList[1].gameObject.transform.localScale = Vector3(scale, scale, scale)
  CheckCgPosEditor.CurController._imgShadowList[1].gameObject.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIAircraftEnterBuildController(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._imgPetBig:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._imgPetBig.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._imgPetBig.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIGradeSkillPanelController(checkcg, skinID, offset, scale)
  CheckCgPosEditor.CurController._cgImgGo:SetActive(true)
  CheckCgPosEditor.CurController._cgTipGo:SetActive(true)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._cgImg:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._cgImgGo.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._cgImgGo.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIPetObtain(checkcg, skinID, offset, scale, l2d)
  if checkcg ~= nil then
    CheckCgPosEditor.CurController._cgRoot:SetActive(checkcg)
    CheckCgPosEditor.CurController._spine.gameObject:SetActive(not checkcg)
  end
  if skinID ~= nil then
    if checkcg then
      CheckCgPosEditor.CurController._cgNormal:Load(Cfg.cfg_pet_skin[skinID].StaticBody)
    elseif l2d then
      CheckCgPosEditor.CurController._spine:DestroyCurrentSpine()
      CheckCgPosEditor.CurDynamicCGHandle = DynamicCG.SyncLoad(Cfg.cfg_pet_skin[skinID].Spine, CheckCgPosEditor.CurController._spine)
    elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
      local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
      CheckCgPosEditor.CurController._spine:LoadSpine(spineRes)
    else
      CheckCgPosEditor.CurController._spine:LoadSpine(Cfg.cfg_pet_skin[skinID].Spine)
    end
  end
  if CheckCgPosEditor.CurController._cgRoot.activeSelf then
    CheckCgPosEditor.CurController._cgRect.anchoredPosition = offset
    CheckCgPosEditor.CurController._cgRect.localScale = Vector3(scale, scale, scale)
  else
    CheckCgPosEditor.CurController._spine.gameObject.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._spine.gameObject.transform.localScale = Vector3(scale, scale, scale)
  end
end

function CgPosEditorRefreshUIPetObtain_mid(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._cg_mid:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._cg_mid.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._cg_mid.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIWidgetPetInfo(checkcg, skinID, offset, scale)
  CheckCgPosEditor.CurController:_ShowHideUIBattle(true)
  if skinID ~= nil then
    local tempData = pet_data:New()
    tempData.template_id = Cfg.cfg_pet_skin[skinID].PetId
    tempData.current_skin = skinID
    local pet = Pet:New(tempData)
    CheckCgPosEditor.CurController._petInfoPool = CheckCgPosEditor.CurController:GetUIComponent("UISelectObjectPath", "PetInfoPool")
    CheckCgPosEditor.CurController._petInfoUI = CheckCgPosEditor.CurController._petInfoPool:SpawnObject("UIWidgetPetInfo")
    CheckCgPosEditor.CurController._petInfoPoolGameObject = CheckCgPosEditor.CurController:GetGameObject("PetInfoPool")
    CheckCgPosEditor.CurController._petInfoPoolGameObject:SetActive(true)
    CheckCgPosEditor.CurController._petInfoUI:Init(pet)
    CheckCgPosEditor.CurController._petInfoUI:GetGameObject():SetActive(true)
    CheckCgPosEditor.CurController._petInfoUI._roleStaticBody:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._petInfoUI._cg.anchoredPosition = offset
  CheckCgPosEditor.CurController._petInfoUI._cg.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUISpineContainer(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController.spineContainer._img:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController.spineContainer._img.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController.spineContainer._img.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIChooseAssistantController(checkcg, skinID, offset, scale, l2d)
  if checkcg ~= nil then
    CheckCgPosEditor.CurController._cgGo:SetActive(checkcg)
    CheckCgPosEditor.CurController._CgObj:SetActive(checkcg)
    CheckCgPosEditor.CurController._spineObj.gameObject:SetActive(not checkcg)
  end
  if skinID ~= nil then
    if checkcg then
      if Cfg.cfg_pet_skin[skinID] and Cfg.cfg_pet_skin[skinID].StaticBody then
        CheckCgPosEditor.CurController._cg:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
      else
        CheckCgPosEditor.CurController._cg:LoadImage(Cfg.cfg_only_assistant[skinID].CG)
      end
    elseif Cfg.cfg_pet_skin[skinID] and Cfg.cfg_pet_skin[skinID].Spine then
      if l2d then
        CheckCgPosEditor.CurController._spine:DestroyCurrentSpine()
        CheckCgPosEditor.CurDynamicCGHandle = DynamicCG.SyncLoad(Cfg.cfg_pet_skin[skinID].Spine, CheckCgPosEditor.CurController._spine)
      elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
        local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
        CheckCgPosEditor.CurController._spine:LoadSpine(spineRes)
      else
        CheckCgPosEditor.CurController._spine:LoadSpine(Cfg.cfg_pet_skin[skinID].Spine)
      end
    else
      CheckCgPosEditor.CurController._spine:LoadSpine(Cfg.cfg_only_assistant[skinID].Spine)
      local spineSke = CheckCgPosEditor.CurController._spine.CurrentSkeleton
      spineSke = spineSke or CheckCgPosEditor.CurController._spine.CurrentMultiSkeleton
      if spineSke then
        spineSke:Initialize(true)
        spineSke.AnimationState:SetAnimation(0, Cfg.cfg_only_assistant[skinID].SpineAnim, true)
      end
    end
  end
  if CheckCgPosEditor.CurController._cgGo.activeSelf then
    CheckCgPosEditor.CurController._cg.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._cg.transform.localScale = Vector3(scale, scale, scale)
  else
    CheckCgPosEditor.CurController._spine.gameObject.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._spine.gameObject.transform.localScale = Vector3(scale, scale, scale)
  end
end

function CgPosEditorRefreshUIPetIntimacyMainController(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]:LoadCgSync(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._itemTable[CheckCgPosEditor.CurController._currIndex]._cgGo.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIStoryBanner(checkcg, skinID, offset, scale, l2d)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    YIELD(TT)
    if skinID ~= nil then
      if l2d then
        CheckCgPosEditor.CurController._spineLoader:DestroyCurrentSpine()
        CheckCgPosEditor.CurDynamicCGHandle = DynamicCG.SyncLoad(Cfg.cfg_pet_skin[skinID].Spine, CheckCgPosEditor.CurController._spineLoader)
      elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
        local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
        CheckCgPosEditor.CurController._spineLoader:LoadSpine(spineRes)
      else
        CheckCgPosEditor.CurController._spineLoader:LoadSpine(Cfg.cfg_pet_skin[skinID].Spine)
      end
    end
    CheckCgPosEditor.CurController._spineLoaderGO.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._spineLoaderGO.transform.localScale = Vector3(scale, scale, scale)
  end)
end

function CgPosEditorRefreshUIPetSkinsMainController(checkcg, skinID, offset, scale, l2d)
  if checkcg ~= nil then
    CheckCgPosEditor.CurController._cgRoot:SetActive(checkcg)
    CheckCgPosEditor.CurController._spineRoot:SetActive(not checkcg)
  end
  if CheckCgPosEditor.CurController._dcgHandle then
    CheckCgPosEditor.CurController._dcgHandle:DestroyCurrentCG()
  end
  if skinID ~= nil then
    if checkcg then
      CheckCgPosEditor.CurController._cgNormal:Load(Cfg.cfg_pet_skin[skinID].StaticBody)
    else
      local spineLoader = CheckCgPosEditor.CurController._spineRoot:GetComponent("SpineLoader")
      if l2d then
        spineLoader:DestroyCurrentSpine()
        CheckCgPosEditor.CurDynamicCGHandle = DynamicCG.SyncLoad(Cfg.cfg_pet_skin[skinID].Spine, spineLoader)
      elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
        local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
        spineLoader:LoadSpine(spineRes)
      else
        spineLoader:DestroyCurrentSpine()
        spineLoader:LoadSpine(Cfg.cfg_pet_skin[skinID].Spine)
      end
    end
  end
  if CheckCgPosEditor.CurController._cgRoot.activeSelf then
    CheckCgPosEditor.CurController._cgRect.anchoredPosition = offset
    CheckCgPosEditor.CurController._cgRect.localScale = Vector3(scale, scale, scale)
  else
    CheckCgPosEditor.CurController._spineRoot.transform.anchoredPosition = offset
    CheckCgPosEditor.CurController._spineRoot.transform.localScale = Vector3(scale, scale, scale)
  end
end

function CgPosEditorRefreshUIPetSkinsMainController_mid(checkcg, skinID, offset, scale)
  if skinID ~= nil then
    CheckCgPosEditor.CurController._cg_mid:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
  end
  CheckCgPosEditor.CurController._cg_mid.transform.anchoredPosition = offset
  CheckCgPosEditor.CurController._cg_mid.transform.localScale = Vector3(scale, scale, scale)
end

function CgPosEditorRefreshUIPlayerInfoController(checkcg, skinID, offset, scale, l2d)
  local widget = CheckCgPosEditor.CurController._main_lobby_bg
  local spineSke = widget._spine.CurrentSkeleton
  spineSke = spineSke or widget._spine.CurrentMultiSkeleton
  if checkcg ~= nil then
    widget._cgGo:SetActive(checkcg)
    widget._spineGo:SetActive(not checkcg)
  end
  if skinID ~= nil then
    if checkcg then
      if Cfg.cfg_pet_skin[skinID] and Cfg.cfg_pet_skin[skinID].StaticBody then
        widget._cg:LoadImage(Cfg.cfg_pet_skin[skinID].StaticBody)
      else
        widget._cg:LoadImage(Cfg.cfg_only_assistant[skinID].CG)
      end
    elseif Cfg.cfg_pet_skin[skinID] and Cfg.cfg_pet_skin[skinID].Spine then
      if l2d then
        widget._spine:DestroyCurrentSpine()
        CheckCgPosEditor.CurDynamicCGHandle = DynamicCG.SyncLoad(Cfg.cfg_pet_skin[skinID].Spine, widget._spine)
      elseif string.startwith(Cfg.cfg_pet_skin[skinID].Spine, "l2d_") then
        local spineRes = DynamicCG.ReplaceL2D(Cfg.cfg_pet_skin[skinID].Spine, true)
        widget._spine:LoadSpine(spineRes)
      else
        widget._spine:LoadSpine(Cfg.cfg_pet_skin[skinID].Spine)
      end
    else
      widget._spine:LoadSpine(Cfg.cfg_only_assistant[skinID].Spine)
      local spineSke = widget._spine.CurrentSkeleton
      spineSke = spineSke or widget._spine.CurrentMultiSkeleton
      if spineSke then
        spineSke:Initialize(true)
        spineSke.AnimationState:SetAnimation(0, Cfg.cfg_only_assistant[skinID].SpineAnim, true)
      end
    end
  end
  if widget._cgGo.activeSelf then
    widget._cgGo.transform.anchoredPosition = offset
    widget._cgGo.transform.localScale = Vector3(scale, scale, scale)
  else
    widget._spineGo.transform.anchoredPosition = offset
    widget._spineGo.transform.localScale = Vector3(scale, scale, scale)
  end
end
