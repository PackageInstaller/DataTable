local View = require("UIEndlessBattle/UIEndlessBattleView")
local DataModel = require("UIEndlessBattle/UIEndlessBattleDataModel")
local Controller = require("UIEndlessBattle/UIEndlessBattleController")
local ViewFunction = {
  EndlessBattle_Group_TeamGroup_Group_Team_StaticGrid_Role_SetGrid = function(element, elementIndex)
  end,
  EndlessBattle_Group_TeamGroup_Group_Team_StaticGrid_Role_Group_Role_Btn_Click_Click = function(btn, str)
  end,
  EndlessBattle_Group_TeamGroup_Group_Team_Btn_Auto_Click = function(btn, str)
  end,
  EndlessBattle_Group_TeamGroup_Group_Team_Btn_Edit_Click = function(btn, str)
  end,
  EndlessBattle_Group_TeamGroup_Group_Team_Group_Role_Btn_Click_Click = function(btn, str)
  end,
  EndlessBattle_Group_TeamGroup_StaticGrid_Team_SetGrid = function(element, elementIndex)
    Controller:OnSetLevelGrid(element, elementIndex)
  end,
  EndlessBattle_Group_TeamGroup_StaticGrid_Team_Group_Team_StaticGrid_Role_SetGrid = function(element, elementIndex)
    Controller:OnSetLevelRoleGrid(element, elementIndex)
  end,
  EndlessBattle_Group_TeamGroup_StaticGrid_Team_Group_Team_StaticGrid_Role_Group_Role_Btn_Click_Click = function(btn, str)
    if str == nil or str == "" then
      return
    end
    local teamIndex = DataModel.curTeamIndex
    local curRoleTeam = DataModel.roleCheckMap[str]
    if teamIndex == nil then
      teamIndex = curRoleTeam.team
    end
    if DataModel.isTeamSelectShow then
      local tRoleList = DataModel.levelRoleList[teamIndex]
      local order
      for i = 1, #tRoleList do
        if tRoleList[i] == -1 then
          order = i
          break
        end
      end
      if curRoleTeam.team == teamIndex or order ~= nil then
        Controller:OnClickRoleBtn(str)
      end
      return
    end
    local hasForbidUR = false
    local forbidIndex = 1
    local urequip = Controller:GetUrEquipData(teamIndex)
    if urequip[tostring(str)] then
      for i = 1, 3 do
        if urequip[tostring(str)][i] and tonumber(urequip[tostring(str)][i].id) ~= nil and urequip[tostring(str)][i].isUse == false then
          hasForbidUR = true
          forbidIndex = i
          break
        end
      end
    end
    if hasForbidUR then
      DataModel.RoleData = PlayerData:GetRoleById(str)
      DataModel.DupesIndex = teamIndex
      View.Group_DupesEquip.Group_Main.Group_Slots.self:SetActive(true)
      Controller:RefreshDupesEquip(forbidIndex)
      View.self:SelectPlayAnim(View.Group_DupesEquip.self, "Group_DupesEquip_Show", function()
      end)
    else
      local data = {
        currentRoleId = str,
        fromView = EnumDefine.CommonFilterType.SquadView
      }
      Controller:SaveCurLevelRoleList()
      Net:SendProto("hero.info", function(json)
        if json.roles then
          PlayerData.ServerData.roles[str] = json.roles[str]
          UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
        end
      end, tonumber(str))
    end
  end,
  EndlessBattle_Group_TeamGroup_StaticGrid_Team_Group_Team_Btn_Auto_Click = function(btn, str)
    Controller:OnClickBtnAuto(str)
  end,
  EndlessBattle_Group_TeamGroup_StaticGrid_Team_Group_Team_Btn_Edit_Click = function(btn, str)
    Controller:OnClickEditTeam(str)
  end,
  EndlessBattle_Group_TeamGroup_StaticGrid_Team_Group_Team_Group_Role_Btn_Click_Click = function(btn, str)
  end,
  EndlessBattle_Group_Select_Group_Check_Btn_Role_Click = function(btn, str)
    Controller:SetSelectMode(1)
  end,
  EndlessBattle_Group_Select_Group_Check_Btn_Team_Click = function(btn, str)
    Controller:SetSelectMode(2)
  end,
  EndlessBattle_Group_Select_Group_RoleList_ScrollGrid_RoleList_SetGrid = function(element, elementIndex)
    Controller:OnSetRoleGrid(element, elementIndex)
  end,
  EndlessBattle_Group_Select_Group_RoleList_ScrollGrid_RoleList_Group_Item_Btn_Click_Click = function(btn, str)
    Controller:OnClickRoleBtn(str)
  end,
  EndlessBattle_Group_Select_Group_RoleList_Btn_Level_Click = function(btn, str)
    Controller:SetRoleSortType(1)
  end,
  EndlessBattle_Group_Select_Group_RoleList_Btn_Rarity_Click = function(btn, str)
    Controller:SetRoleSortType(2)
  end,
  EndlessBattle_Group_Select_Group_RoleList_Btn_Time_Click = function(btn, str)
    Controller:SetRoleSortType(3)
  end,
  EndlessBattle_Group_Select_Group_RoleList_Btn_Screen_Click = function(btn, str)
    Controller:OpenRoleFilter()
  end,
  EndlessBattle_Group_Select_Group_TeamList_ScrollGrid_TeamList_SetGrid = function(element, elementIndex)
    Controller:OnSetTeamGrid(element, elementIndex)
  end,
  EndlessBattle_Group_Select_Group_TeamList_ScrollGrid_TeamList_Group_Team_StaticGrid_Role_SetGrid = function(element, elementIndex)
    Controller:OnSetTeamRoleGrid(element, elementIndex)
  end,
  EndlessBattle_Group_Select_Group_TeamList_ScrollGrid_TeamList_Group_Team_Btn_Click_Click = function(btn, str)
    Controller:OnClickTeamBtn(str)
  end,
  EndlessBattle_Group_Select_Group_Team_StaticGrid_Role_SetGrid = function(element, elementIndex)
  end,
  EndlessBattle_Group_Select_Group_Team_Btn_Click_Click = function(btn, str)
  end,
  EndlessBattle_Group_Select_Group_Item_Btn_Click_Click = function(btn, str)
  end,
  EndlessBattle_Group_Select_Btn_Back_Click = function(btn, str)
    Controller:CloseTeamSelect()
  end,
  EndlessBattle_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:OnSetRewardGrid(element, elementIndex)
  end,
  EndlessBattle_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:OnClickReward(str)
  end,
  EndlessBattle_Btn_Start_Click = function(btn, str)
    Controller:TryBattle()
  end,
  EndlessBattle_Btn_Revive_Click = function(btn, str)
    Controller:OpenReviveGroup()
  end,
  EndlessBattle_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller:OnClickReturn()
  end,
  EndlessBattle_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    Controller:OnClickHome()
  end,
  EndlessBattle_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  EndlessBattle_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  EndlessBattle_Group_Revive_Btn_BG_Click = function(btn, str)
    Controller:CloseReviveGroup()
  end,
  EndlessBattle_Group_Revive_Btn_Confirm_Click = function(btn, str)
    Controller:OnClickReviveConfirm()
  end,
  EndlessBattle_Group_Revive_Btn_Cancel_Click = function(btn, str)
    Controller:CloseReviveGroup()
  end,
  EndlessBattle_Group_BossInfo_Group_Name_Btn_Detail_Click = function(btn, str)
    UIManager:Open("UI/Book/Enemy_Illustration/Enemy_SkillDetail", Json.encode({
      levelId = tonumber(str)
    }))
  end,
  EndlessBattle_Screen_Chapter_Btn_BG_Click = function(btn, str)
    Controller:ExitRoleFilter(false)
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_All_Click = function(btn, str)
    Controller:OnClickBtnAll("Group_Career")
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C01_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C02_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C03_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C04_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C05_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C06_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C07_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C08_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Career_Btn_C09_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_All_Click = function(btn, str)
    Controller:OnClickBtnAll("Group_Group")
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G01_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G02_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G03_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G04_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G05_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G06_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G07_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G08_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Group_Btn_G09_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Rarity_Btn_All_Click = function(btn, str)
    Controller:OnClickBtnAll("Group_Rarity")
  end,
  EndlessBattle_Screen_Chapter_Group_Rarity_Btn_R01_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Rarity_Btn_R02_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Rarity_Btn_R03_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Group_Rarity_Btn_R04_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  EndlessBattle_Screen_Chapter_Btn_OK_Click = function(btn, str)
    Controller:ExitRoleFilter(true)
  end,
  EndlessBattle_Screen_Chapter_Btn_Cancel_Click = function(btn, str)
    Controller:ExitRoleFilter(false)
  end,
  EndlessBattle_Group_PowerRole_Group_Item_Btn_Role_Click = function(btn, str)
  end,
  EndlessBattle_Group_PowerRole_StaticGrid_RoleList_SetGrid = function(element, elementIndex)
    local powerRoleList = DataModel.powerRoleList
    local roleData = powerRoleList[elementIndex]
    local roleCA = PlayerData:GetFactoryData(roleData.id)
    local viewCA = PlayerData:GetFactoryData(roleCA.viewId)
    element.Img_Mask.Img_Head:SetSprite(viewCA.face)
    local haveRole = PlayerData.ServerData.roles[tostring(roleData.id)] ~= nil
    element.Img_Un:SetActive(not haveRole)
    element.Btn_Role:SetClickParam(elementIndex)
  end,
  EndlessBattle_Group_PowerRole_StaticGrid_RoleList_Group_Item_Btn_Role_Click = function(btn, str)
    local index = tonumber(str)
    local powerRoleList = DataModel.powerRoleList
    local roleData = powerRoleList[index]
    local roleId = roleData.id
    local haveRole = PlayerData.ServerData.roles[tostring(roleId)] ~= nil
    Controller:SaveCurLevelRoleList()
    if haveRole then
      local data = {
        currentRoleId = roleId,
        fromView = EnumDefine.CommonFilterType.SquadView
      }
      Net:SendProto("hero.info", function(json)
        if json.roles then
          PlayerData.ServerData.roles[roleId] = json.roles[roleId]
          UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
        end
      end, tonumber(roleId))
    else
      CommonTips.OpenUnitDetail({id = roleId})
    end
  end,
  EndlessBattle_Group_PowerRole_Btn_Help_Click = function(btn, str)
    local isOpen = DataModel.isHelpOpen == true
    View.Group_PowerRole.Group_Help:SetActive(not isOpen)
    DataModel.isHelpOpen = not isOpen
  end,
  EndlessBattle_Group_DupesEquip_Btn_Blose_Click = function(btn, str)
    View.self:SelectPlayAnim(View.Group_DupesEquip.self, "Group_DupesEquip_Hide", function()
      CommonTips:CloseDupesEquip(View)
    end)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Equipt_Btn_Change_Click = function(btn, str)
    local roleId = DataModel.RoleData.id
    local data = {
      currentRoleId = roleId,
      fromView = EnumDefine.CommonFilterType.SquadView
    }
    Net:SendProto("hero.info", function(json)
      if json.roles then
        Controller:SaveCurLevelRoleList()
        PlayerData.ServerData.roles[roleId] = json.roles[roleId]
        UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
      end
    end, tonumber(roleId))
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_01_Btn_Slots_Click = function(btn, str)
    Controller:OnClickSlot(1)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_02_Btn_Slots_Click = function(btn, str)
    Controller:OnClickSlot(2)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_03_Btn_Slots_Click = function(btn, str)
    Controller:OnClickSlot(3)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_001_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_002_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_003_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_004_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  EndlessBattle_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_005_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end
}
return ViewFunction
