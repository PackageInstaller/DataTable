local System = require("System.System")
local readonly = System.readonly
local Lead = readonly({
  [1] = {
    ID = 1,
    CnID = "主角@男",
    BaseSortID = 1,
    Gender = "Gender_Boy",
    DefaultName = "Lead_1_DefaultName|西维斯特",
    PaintingRes = "UIResources/UIBigImages/UI_Large/UI_Guide_Image_Lihui.png",
    MainCharacterAvatarRes = "Portraits/Minihead/Portrait_Minihead_SpChar_PlayerM_NF.png",
    AVGAvatarRes = "Portraits/Minihead/Portrait_Minihead_SpChar_PlayerM_NF.png",
    MapAvatarRes = "MUnit/MUnit_02/Role/MUnit_Role_003/Texture/MScene_003_Role.png",
    heorshe = "Lead_1_heorshe|他",
    brotherorsister1 = "Lead_1_brotherorsister1|哥哥",
    brotherorsister2 = "Lead_1_brotherorsister2|弟弟",
    sirormadam = "Lead_1_sirormadam|先生",
    lordorlady = "Lead_1_lordorlady|少爷",
    hisorher = "Lead_1_hisorher|他的",
    himorher = "Lead_1_himorher|他",
    PlayerLevelTaskAvatarRes = "UIResources/AtlasSource/UI_Task_Image/UI_Task_Image_Man.png",
    PlayerAvatar = 23899,
    Emoji = {46749, 46739}
  },
  [2] = {
    ID = 2,
    CnID = "主角@女",
    BaseSortID = 2,
    Gender = "Gender_Girl",
    DefaultName = "Lead_2_DefaultName|莉奥诺拉",
    PaintingRes = "UIResources/UIBigImages/UI_Large/UI_Guide_Image_Lihui_Girl.png",
    MainCharacterAvatarRes = "Portraits/Minihead/Portrait_Minihead_SpChar_PlayerF_NF.png",
    AVGAvatarRes = "Portraits/Minihead/Portrait_Minihead_SpChar_PlayerF_NF.png",
    MapAvatarRes = "MUnit/MUnit_02/Role/MUnit_Role_001/Texture/MScene_001_Role.png",
    heorshe = "Lead_2_heorshe|她",
    brotherorsister1 = "Lead_2_brotherorsister1|姐姐",
    brotherorsister2 = "Lead_2_brotherorsister2|妹妹",
    sirormadam = "Lead_2_sirormadam|小姐",
    lordorlady = "Lead_2_lordorlady|小姐",
    hisorher = "Lead_2_hisorher|她的",
    himorher = "Lead_2_himorher|她",
    PlayerLevelTaskAvatarRes = "UIResources/AtlasSource/UI_Task_Image/UI_Task_Image_Girl.png",
    PlayerAvatar = 23900,
    Emoji = {46750, 46740}
  }
})
return Lead
