local View = require("UICubeRogueMain/UICubeRogueMainView")
local DataModel = require("UICubeRogueMain/UICubeRogueMainDataModel")
local Controller = require("UICubeRogueMain/UICubeRoguewMainController")
local OutSideData = require("UICubeSkill/UICubeSkillDataModel")
local ViewFunction = {
  CubeRogueMain_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    if Controller.optionPanelState and (Controller.optionPanelState >= 5 or Controller.optionPanelState < 4) then
      return
    end
    if View.Group_EventOptions.self.gameObject.activeSelf then
      if Controller.optionPanelState >= 5 then
        Controller.CloseOptionsPanel()
      else
        Controller.OnOtherPanelClose(Controller.Enum_Continue.OpenOptionPanel)
        View.Group_EventOptions:SetActive(false)
      end
      return
    end
    UIManager:Open("UI/CubeRogue/Quit/CubeRogueQuit")
  end,
  CubeRogueMain_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  CubeRogueMain_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CubeRogueMain_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    UIManager:Open("UI/CubeRogue/Help/Roguehelp")
  end,
  CubeRogueMain_Group_Action_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Btn_Auto_Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    DataModel:RotateToFaceUp(DataModel.roleCtrl.face)
  end,
  CubeRogueMain_Group_Pressure_Btn__Click = function(btn, str)
    UIManager:Open("UI/CubeRogue/Descent/DescentPop")
  end,
  CubeRogueMain_Group_Formation_Btn__Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    Controller:OpenSquadPanel()
  end,
  CubeRogueMain_Group_EventDetails_Btn_Fight_Click = function(btn, str)
    Controller.playerMoving = false
    Controller.ConfirmToCube()
  end,
  CubeRogueMain_Group_Coin_Btn_GoldCoin_Click = function(btn, str)
    if Controller.CanDealRotStuff() then
      CommonTips.OpenCubeRogueItemDetails({
        id = DataModel.allConfig.coinId
      })
    end
  end,
  CubeRogueMain_Group_ConfirmRot_Group_Confirm_Btn__Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    DataModel.hasConfirmRot = true
    Controller.ConfirmRot()
  end,
  CubeRogueMain_Group_ConfirmRot_Group_Cancel_Btn__Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    DataModel.isRotating = true
    DataModel.hasConfirmRot = true
    DataModel.rotElapsed = 0
    local temp = DataModel.rotTargetRotation
    DataModel.rotTargetRotation = DataModel.rotStartRotation
    DataModel.rotStartRotation = temp
    local sound = SoundManager:CreateSound(DataModel.allConfig.turnSound)
    if sound then
      sound:Play()
    end
    Controller.ShowConfirmRevert(false)
  end,
  CubeRogueMain_Group_Team_Btn__Click = function(btn, str)
    if Controller.CanDealRotStuff() then
      UIManager:Open("UI/CubeRogue/CubeWarehouse/CubeWarehouse", Json.encode({index = 3}))
    end
  end,
  CubeRogueMain_Group_Difficulty_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_PackSake_Btn__Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    Controller:OpenPackPanel()
  end,
  CubeRogueMain_Group_TeamTips_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventDetails_Btn_Close_Click = function(btn, str)
    Controller.CancelSelectCube()
  end,
  CubeRogueMain_Group_EventOptions_Btn__Click = function(btn, str)
    if Controller.optionPanelState == 1 then
      Controller.ShowOptionsPanel(false)
    elseif Controller.optionPanelState == 5 then
      Controller.OptionOver(false)
    elseif Controller.optionPanelState == 6 then
      Controller.CloseOptionsPanel()
    end
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_Group_Item_Group_Normal_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_Group_Item_Group_Affirm_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Btn_Continue_Click = function(btn, str)
    Controller.ContinueBtnClick()
  end,
  CubeRogueMain_Group_RestArea_StaticGrid_List_SetGrid = function(element, elementIndex)
    local data = DataModel.restPanelCfg.restEventList[elementIndex]
    if data == nil then
      return
    end
    element.Group_Able.Img_Di:SetSprite(data.diPng)
    element.Group_Able.Img_Icon:SetSprite(data.iconPng)
    element.Group_Able.Img_Btn:SetSprite(data.btnPng)
    element.Group_Lock.Img_Di:SetSprite(data.diPng)
    element.Group_Lock.Img_Icon:SetSprite(data.iconPng)
    element.Group_Lock.Img_Des:SetSprite(data.btnPng)
    local isUnlock = true
    local unlockTip = ""
    if data.prepositionId and data.prepositionId ~= "" and data.prepositionId > 0 then
      isUnlock = OutSideData.GetSkillLockState({
        id = data.prepositionId
      }) == OutSideData.lockState.Unlocked
      local preCondition = GetCA(data.prepositionId)
      unlockTip = string.format(GetText(80610270), preCondition.name)
    end
    if isUnlock and data.id == 89800016 then
      isUnlock = DataModel.GetDescentAttr("BanRevive").value == 0
      if not isUnlock then
        unlockTip = GetText(80610962)
      end
    end
    element.Group_Able:SetActive(isUnlock)
    element.Group_Lock:SetActive(not isUnlock)
    element.Btn_:SetClickParam(isUnlock and data.id or unlockTip)
  end,
  CubeRogueMain_Group_RestArea_StaticGrid_List_Group_Item_Btn__Click = function(btn, str)
    local eventID = tonumber(str)
    if eventID == nil then
      CommonTips.OpenTips(str, true)
      return
    end
    local cfg = GetCA(eventID, "RogueEventFactory")
    UIManager:Open(cfg.uiPath, Json.encode({eventId = eventID}))
  end,
  CubeRogueMain_Group_RestArea_Group_Item_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_RestArea_Group_Next_Btn__Click = function(btn, str)
    local deck = PlayerData.TempCache.CubeRogueData.roles
    local roleNum = 0
    for k, v in pairs(deck) do
      if v and (v.hp == nil or 0 < v.hp) then
        roleNum = roleNum + 1
      end
    end
    if roleNum < 5 then
      CommonTips.OpenTips(80610638)
      return
    end
    DataModel.restPanelCfg = nil
    Controller.ClearData()
    Net:SendProto("cube.end_rest", function(json)
      View.Group_RestArea:SetActive(false)
      PlayerData.TempCache.CubeRogueData = json.cube
      PlayerData.TempCache.CubeRogueData.reward = json.reward
      Controller.OnPanelOpen()
    end)
  end,
  CubeRogueMain_Btn_CreateModel_Click = function(btn, str)
    local cfg = PlayerData:GetFactoryData(View.InputField_CreateModel:GetText(), "CubeRogueFactory")
    if cfg == nil then
      return
    end
    local RubikCube = require("UICubeRogueMain/RubikCube")
    local cube = RubikCube.new(Vector3(10, 0, 0), 2, 0.4, cfg.cubeSize, cfg.id)
    cube:Generate()
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_Group_Item_Group_Limit_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List2_SetGrid = function(element, elementIndex)
    Controller.SetOptionView(element, elementIndex)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List2_Group_Item_Group_Normal_Btn__Click = function(btn, str)
    Controller.OptionSelectClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List2_Group_Item_Group_Affirm_Btn__Click = function(btn, str)
    Controller.OptionConfirmClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List2_Group_Item_Group_Limit_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List3_SetGrid = function(element, elementIndex)
    Controller.SetOptionView(element, elementIndex)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List3_Group_Item_Group_Normal_Btn__Click = function(btn, str)
    Controller.OptionSelectClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List3_Group_Item_Group_Affirm_Btn__Click = function(btn, str)
    Controller.OptionConfirmClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List3_Group_Item_Group_Limit_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List4_SetGrid = function(element, elementIndex)
    Controller.SetOptionView(element, elementIndex)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List4_Group_Item_Group_Normal_Btn__Click = function(btn, str)
    Controller.OptionSelectClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List4_Group_Item_Group_Affirm_Btn__Click = function(btn, str)
    Controller.OptionConfirmClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List4_Group_Item_Group_Limit_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_ActionInformation_Group_Move_Btn__Click = function(btn, str)
    if not DataModel.hasConfirmRot then
      return
    end
    if not Controller.CanDealRotStuff() then
      return
    end
    if DataModel.curMoveNum >= DataModel.GetMaxStepNum() then
      return
    end
    Controller.playerMoving = not Controller.playerMoving
    Controller.playerRotating = false
    Controller.RefreshPlayerStep(true)
    DataModel.ShowCanMoveOutline(Controller.playerMoving)
    DataModel.ShowPlayerRotDir(Controller.playerRotating)
    Controller.SetCameraToMove(Controller.playerMoving)
    if Controller.playerMoving then
      DataModel:RotateToFaceUp(DataModel.roleCtrl.face)
    end
  end,
  CubeRogueMain_Group_ActionInformation_Group_Spin_Btn__Click = function(btn, str)
    if not DataModel.hasConfirmRot then
      return
    end
    if not Controller.CanDealRotStuff() then
      return
    end
    if DataModel.curRotNum >= DataModel.GetMaxRotNum() then
      return
    end
    Controller.playerRotating = not Controller.playerRotating
    Controller.playerMoving = false
    Controller.RefreshPlayerStep(true)
    DataModel.ShowCanMoveOutline(Controller.playerMoving)
    DataModel.ShowPlayerRotDir(Controller.playerRotating)
    Controller.SetCameraToMove(Controller.playerMoving)
    if Controller.playerRotating then
      DataModel:RotateToFaceUp(DataModel.roleCtrl.face)
    end
  end,
  CubeRogueMain_Group_Information_Group_Planes_Group_Switch_Btn__Click = function(btn, str)
    UIManager:Open("UI/CubeRogue/EnemyTalent/Group_EnemyTalent", Json.encode({isInBattle = false}))
  end,
  CubeRogueMain_Group_Special_Btn_GoldCoin_Click = function(btn, str)
    if not Controller.CanDealRotStuff() then
      return
    end
    CommonTips.OpenCubeRogueItemDetails({
      id = DataModel.allConfig.specialItemId
    })
  end,
  CubeRogueMain_Group_UseItem_StaticGrid_List_SetGrid = function(element, elementIndex)
    if elementIndex > DataModel.GetMaxItemNum_Slot() then
      element:SetActive(false)
      return
    elseif elementIndex > DataModel.GetMaxItemNum() then
      element.Group_Lock:SetActive(true)
      element.Group_Empty:SetActive(false)
      element.Group_Item:SetActive(false)
      return
    end
    element.Group_Lock:SetActive(false)
    local itemId = PlayerData.TempCache.CubeRogueData.inside_item[elementIndex]
    element.Group_Empty:SetActive(not itemId)
    element.Group_Item:SetActive(itemId)
    element.Btn_:SetActive(itemId)
    if itemId then
      local itemCA = PlayerData:GetFactoryData(itemId, "ItemFactory")
      element.Group_Item.Img_Icon:SetSprite(itemCA.iconPath)
      element.Btn_:SetClickParam(elementIndex)
    end
  end,
  CubeRogueMain_Group_UseItem_StaticGrid_List_Group_Item_Btn__Click = function(btn, str)
    if DataModel.needStartRound or not Controller.CanDealRotStuff() then
      return
    end
    local index = tonumber(str)
    if index == nil or index > DataModel.GetMaxItemNum() then
      return
    end
    local itemId = PlayerData.TempCache.CubeRogueData.inside_item[index]
    UIManager:Open("UI/CubeRogue/ItemUse/ItemUse", Json.encode({itemId = itemId, index = index}))
  end,
  CubeRogueMain_Group_UseItem_Group_Item_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List1_SetGrid = function(element, elementIndex)
    Controller.SetOptionView(element, elementIndex)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List1_Group_Item_Group_Normal_Btn__Click = function(btn, str)
    Controller.OptionSelectClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List1_Group_Item_Group_Affirm_Btn__Click = function(btn, str)
    Controller.OptionConfirmClick(str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Options_StaticGrid_List1_Group_Item_Group_Limit_Btn__Click = function(btn, str)
  end,
  CubeRogueMain_Group_EventOptions_Group_Backpack_Btn__Click = function(btn, str)
    UIManager:Open("UI/CubeRogue/CubeWarehouse/CubeWarehouse")
  end,
  CubeRogueMain_Group_Weapon_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local data = DataModel.panelEquipList[elementIndex]
    local cfg = PlayerData:GetFactoryData(data.id, "RogueEquipmentFactory")
    element.Img_Icon:SetSprite(cfg.iconPath)
    element.Btn_:SetClickParam(data.id)
    element.Group_Destroy:SetActive(data.isDead)
  end,
  CubeRogueMain_Group_Weapon_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    UIManager:Open("UI/CubeRogue/TacticsSelection/BuffInfo", Json.encode({id = str, isEquip = true}))
  end
}
return ViewFunction
