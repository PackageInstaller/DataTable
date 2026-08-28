local View = require("UITeam_Abyss/UITeam_AbyssView")
local DataModel = require("UITeam_Abyss/UITeam_AbyssDataModel")
local Controller = require("UITeam_Abyss/UITeam_AbyssController")
local ViewFunction = {
  Team_Abyss_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller:OnClickReturn()
  end,
  Team_Abyss_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    Controller:OnClickHome()
  end,
  Team_Abyss_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Team_Abyss_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Team_Abyss_Group_Select_Group_Check_Btn_Role_Click = function(btn, str)
    Controller:SetSelectMode(1)
  end,
  Team_Abyss_Group_Select_Group_Check_Btn_Team_Click = function(btn, str)
    Controller:SetSelectMode(2)
  end,
  Team_Abyss_Group_Select_Group_RoleList_ScrollGrid_RoleList_SetGrid = function(element, elementIndex)
    Controller:OnSetRoleGrid(element, elementIndex)
  end,
  Team_Abyss_Group_Select_Group_RoleList_Btn_Level_Click = function(btn, str)
    Controller:SetRoleSortType(1)
  end,
  Team_Abyss_Group_Select_Group_RoleList_Btn_Rarity_Click = function(btn, str)
    Controller:SetRoleSortType(2)
  end,
  Team_Abyss_Group_Select_Group_RoleList_Btn_Time_Click = function(btn, str)
    Controller:SetRoleSortType(3)
  end,
  Team_Abyss_Group_Select_Group_RoleList_Btn_Screen_Click = function(btn, str)
    Controller:OpenRoleFilter()
  end,
  Team_Abyss_Group_Select_Group_TeamList_ScrollGrid_TeamList_SetGrid = function(element, elementIndex)
    Controller:OnSetTeamGrid(element, elementIndex)
  end,
  Team_Abyss_Group_Select_Group_TeamList_ScrollGrid_TeamList_Group_Team_StaticGrid_Role_SetGrid = function(element, elementIndex)
    Controller:OnSetTeamRoleGrid(element, elementIndex)
  end,
  Team_Abyss_Group_Select_Group_Team_StaticGrid_Role_SetGrid = function(element, elementIndex)
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_SetGrid = function(element, elementIndex)
    Controller:OnSetLevelGrid(element, elementIndex)
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_Group_Level_Btn_Detail_Click = function(btn, str)
    UIManager:Open("UI/Book/Enemy_Illustration/Enemy_SkillDetail", Json.encode({
      levelId = tonumber(str)
    }))
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_Group_Level_StaticGrid_RoleList_SetGrid = function(element, elementIndex)
    Controller:OnSetLevelRoleGrid(element, elementIndex)
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_Group_Level_Btn_Select_Click = function(btn, str)
    Controller:OnClickSelectLevel(str)
  end,
  Team_Abyss_Group_Level_Group_Level_Btn_Detail_Click = function(btn, str)
  end,
  Team_Abyss_Group_Level_Group_Level_StaticGrid_RoleList_SetGrid = function(element, elementIndex)
  end,
  Team_Abyss_Group_Level_Group_Level_Btn_Select_Click = function(btn, str)
  end,
  Team_Abyss_Group_Level_Btn_Check_Click = function(btn, str)
    Controller:ExchangeTeams()
  end,
  Team_Abyss_Group_Level_Btn_Clear_Click = function(btn, str)
    Controller:OnClickLevelBtn()
  end,
  Team_Abyss_Btn_Battle_Click = function(btn, str)
    Controller:TryBattle()
  end,
  Team_Abyss_Group_Select_Group_RoleList_ScrollGrid_RoleList_Group_Item_Btn_Click_Click = function(btn, str)
    Controller:OnClickRoleBtn(str)
  end,
  Team_Abyss_Group_Select_Group_Item_Btn_Click_Click = function(btn, str)
  end,
  Team_Abyss_Group_Select_Group_TeamList_ScrollGrid_TeamList_Group_Team_Btn_Click_Click = function(btn, str)
    Controller:OnClickTeamBtn(str)
  end,
  Team_Abyss_Group_Select_Group_Team_Btn_Click_Click = function(btn, str)
  end,
  Team_Abyss_Screen_Chapter_Btn_BG_Click = function(btn, str)
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_All_Click = function(btn, str)
    Controller:OnClickBtnAll("Group_Career")
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C01_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C02_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C03_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C04_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C05_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C06_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C07_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C08_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Career_Btn_C09_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Career", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_All_Click = function(btn, str)
    Controller:OnClickBtnAll("Group_Group")
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G01_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G02_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G03_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G04_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G05_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G06_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G07_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G08_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Group_Btn_G09_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Group", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Rarity_Btn_All_Click = function(btn, str)
    Controller:OnClickBtnAll("Group_Rarity")
  end,
  Team_Abyss_Screen_Chapter_Group_Rarity_Btn_R01_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Rarity_Btn_R02_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Rarity_Btn_R03_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Group_Rarity_Btn_R04_Click = function(btn, str)
    Controller:AddFilterMap(btn, "Group_Rarity", tonumber(str))
  end,
  Team_Abyss_Screen_Chapter_Btn_OK_Click = function(btn, str)
    Controller:ExitRoleFilter(true)
  end,
  Team_Abyss_Screen_Chapter_Btn_Cancel_Click = function(btn, str)
    Controller:ExitRoleFilter(false)
  end,
  Team_Abyss_Group_Select_Btn_Back_Click = function(btn, str)
    View.self:PlayAnimOnce("Animation_SelectClose", function()
      Controller:SelectLevel(-1)
    end)
  end,
  Team_Abyss_Group_Level_Group_Role_Btn_Click_Click = function(btn, str)
  end,
  Team_Abyss_Group_Level_Group_Role_Btn_Click_LongPress = function(btn, str)
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_Group_Level_Btn_Auto_Click = function(btn, str)
    Controller:OnClickBtnAuto(str)
  end,
  Team_Abyss_Group_Level_Group_Level_Btn_Auto_Click = function(btn, str)
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_Group_Level_StaticGrid_RoleList_Group_Role_Btn_Click_Click = function(btn, str)
    Controller:OnClickLevelRole(str)
  end,
  Team_Abyss_Group_Level_StaticGrid_Level_Group_Level_StaticGrid_RoleList_Group_Role_Btn_Click_LongPress = function(btn, str)
    local params = string.split(str, ":")
    Controller:BeginDrag(tonumber(params[1]), tonumber(params[2]))
  end,
  Team_Abyss_Group_Level_Group_Level_StaticGrid_RoleList_Group_Role_Btn_Click_Click = function(btn, str)
  end,
  Team_Abyss_Group_Level_Group_Level_StaticGrid_RoleList_Group_Role_Btn_Click_LongPress = function(btn, str)
  end,
  Team_Abyss_Group_DupesEquip_Btn_Blose_Click = function(btn, str)
    View.self:SelectPlayAnim(View.Group_DupesEquip.self, "Group_DupesEquip_Hide", function()
      CommonTips:CloseDupesEquip(View)
    end)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Equipt_Btn_Change_Click = function(btn, str)
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
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_01_Btn_Slots_Click = function(btn, str)
    Controller:OnClickSlot(1)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_02_Btn_Slots_Click = function(btn, str)
    Controller:OnClickSlot(2)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_03_Btn_Slots_Click = function(btn, str)
    Controller:OnClickSlot(3)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_001_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_002_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_003_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_004_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end,
  Team_Abyss_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_005_Btn_Enable_001_Click = function(btn, str)
    Controller:ClickUrEquipRole(str)
  end
}
return ViewFunction
