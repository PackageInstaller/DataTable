---@class ConfigTable
---@field public type string
---@field public value string

---@type ConfigTable[]
local ConfigTable = {
                ["InitialTicketNum"] = {
                        type = "InitialTicketNum",
                        value = "180",
                },

                ["LimitNormalTicketNum"] = {
                        type = "LimitNormalTicketNum",
                        value = "999",
                },

                ["RecoverTicketTime"] = {
                        type = "RecoverTicketTime",
                        value = "360",
                },

                ["ApBuy"] = {
                        type = "ApBuy",
                        value = "{100002,6}",
                },

                ["ApBuyCost"] = {
                        type = "ApBuyCost",
                        value = "{50,100,150,200,250,300}",
                },

                ["ApBuyRestore"] = {
                        type = "ApBuyRestore",
                        value = "120",
                },

                ["ApMaxHold"] = {
                        type = "ApMaxHold",
                        value = "999",
                },

                ["equipCurrency"] = {
                        type = "equipCurrency",
                        value = "100003",
                },

                ["equipReturn"] = {
                        type = "equipReturn",
                        value = "0.6",
                },

                ["equipExpCost"] = {
                        type = "equipExpCost",
                        value = "10",
                },

                ["warehouseTab"] = {
                        type = "warehouseTab",
                        value = "{{\"item\",5},{\"weapon\",1},{\"equip\",2},{\"debris\",3},{\"materials\",4}}",
                },

                ["constructionRate"] = {
                        type = "constructionRate",
                        value = "1800",
                },

                ["homework3"] = {
                        type = "homework3",
                        value = "{{1,2,0},{2,0,1},{0,1,2}}",
                },

                ["workTime"] = {
                        type = "workTime",
                        value = "{8,17}",
                },

                ["SkillUseNumber"] = {
                        type = "SkillUseNumber",
                        value = "3",
                },

                ["weaponCurrency"] = {
                        type = "weaponCurrency",
                        value = "100003",
                },

                ["weaponReturn"] = {
                        type = "weaponReturn",
                        value = "0.6",
                },

                ["weaponExpCost"] = {
                        type = "weaponExpCost",
                        value = "10",
                },

                ["DailyResetTime"] = {
                        type = "DailyResetTime",
                        value = "5",
                },

                ["WeaponLevelupCoefficient"] = {
                        type = "WeaponLevelupCoefficient",
                        value = "{{0.5,0.5,0.5,0.7,0.7,1.4},{0.5,0.5,0.5,0.7,0.7,1.4},{0.5,0.5,0.5,0.7,0.7,0.7,0.8,0.8,1.6},{0.5,0.5,0.5,0.7,0.7,0.7,0.8,0.8,0.8,1,1,2},{0.5,0.5,0.5,0.7,0.7,0.7,0.8,0.8,0.8,1,1,2}}",
                },

                ["WeaponEntryLock"] = {
                        type = "WeaponEntryLock",
                        value = "{{110004,1}}",
                },

                ["WeaponSynthesisRareLimit"] = {
                        type = "WeaponSynthesisRareLimit",
                        value = "4",
                },

                ["InitialCharacter"] = {
                        type = "InitialCharacter",
                        value = "{10004,10006}",
                },

                ["InitialResource"] = {
                        type = "InitialResource",
                        value = "{30001}",
                },

                ["InitialLevelMaxWeapon"] = {
                        type = "InitialLevelMaxWeapon",
                        value = "{}",
                },

                ["InitialPlayerExp"] = {
                        type = "InitialPlayerExp",
                        value = "0",
                },

                ["defaultSecretary"] = {
                        type = "defaultSecretary",
                        value = "{SkinId=1000601,PosX=-34,PosY=-654,Size=1}",
                },

                ["HeadportraitStart"] = {
                        type = "HeadportraitStart",
                        value = "{1000001}",
                },

                ["constructionWeightBasic"] = {
                        type = "constructionWeightBasic",
                        value = "50",
                },

                ["constructionWeightDecrease"] = {
                        type = "constructionWeightDecrease",
                        value = "100",
                },

                ["constructionWeightRise"] = {
                        type = "constructionWeightRise",
                        value = "100",
                },

                ["homeCharacterShowBase"] = {
                        type = "homeCharacterShowBase",
                        value = "0",
                },

                ["homeCharacterPreTime"] = {
                        type = "homeCharacterPreTime",
                        value = "{5,30}",
                },

                ["homeCharacterStayTime"] = {
                        type = "homeCharacterStayTime",
                        value = "{1200,1800}",
                },

                ["homeWallkSpeed"] = {
                        type = "homeWallkSpeed",
                        value = "0.5",
                },

                ["homeRunSpeed"] = {
                        type = "homeRunSpeed",
                        value = "1.2",
                },

                ["homeIntoSpeed"] = {
                        type = "homeIntoSpeed",
                        value = "1.4",
                },

                ["actionWeightDecrease"] = {
                        type = "actionWeightDecrease",
                        value = "100",
                },

                ["actionWeightRise"] = {
                        type = "actionWeightRise",
                        value = "100",
                },

                ["weaponProduction"] = {
                        type = "weaponProduction",
                        value = "99",
                },

                ["blueprintBasic"] = {
                        type = "blueprintBasic",
                        value = "{}",
                },

                ["setFightSpeed"] = {
                        type = "setFightSpeed",
                        value = "{0.9,1.2,1.4}",
                },

                ["equipNumMax"] = {
                        type = "equipNumMax",
                        value = "999",
                },

                ["weaponNumMax"] = {
                        type = "weaponNumMax",
                        value = "999",
                },

                ["workLowerLimit"] = {
                        type = "workLowerLimit",
                        value = "5",
                },

                ["AffectionItem"] = {
                        type = "AffectionItem",
                        value = "110001",
                },

                ["commissionMax"] = {
                        type = "commissionMax",
                        value = "5",
                },

                ["HomeEventDaily"] = {
                        type = "HomeEventDaily",
                        value = "15",
                },

                ["FormationCount"] = {
                        type = "FormationCount",
                        value = "5",
                },

                ["FormationHeroCount"] = {
                        type = "FormationHeroCount",
                        value = "6",
                },

                ["EpRecoverBasic"] = {
                        type = "EpRecoverBasic",
                        value = "1",
                },

                ["DispatchEpColor"] = {
                        type = "DispatchEpColor",
                        value = "{50,20}",
                },

                ["DispatchMagnification"] = {
                        type = "DispatchMagnification",
                        value = "1.2",
                },

                ["PveExerciseStoreyPass"] = {
                        type = "PveExerciseStoreyPass",
                        value = "1",
                },

                ["PveExtraReward"] = {
                        type = "PveExtraReward",
                        value = "{{1,2,2},{2,1,1},{3,1,1},{4,1,1}}",
                },

                ["cameraRange"] = {
                        type = "cameraRange",
                        value = "{{0.3,0.3,0.3,0.4},{0.45,0.45,0.4,0.4},{0.2,0.2,0.15,0.25},{0.2,0.2,0.15,0.25}}",
                },

                ["TaskItem"] = {
                        type = "TaskItem",
                        value = "{110005,110006,110007,110017}",
                },

                ["FirstGacha"] = {
                        type = "FirstGacha",
                        value = "{{2,10001,1}}",
                },

                ["AffectionLevelGiftMax"] = {
                        type = "AffectionLevelGiftMax",
                        value = "10",
                },

                ["HomeMaxCharacter"] = {
                        type = "HomeMaxCharacter",
                        value = "20",
                },

                ["ElevatorOpenLast"] = {
                        type = "ElevatorOpenLast",
                        value = "{5,5}",
                },

                ["ElevatorInterval"] = {
                        type = "ElevatorInterval",
                        value = "{4,7}",
                },

                ["DoorOpenLast"] = {
                        type = "DoorOpenLast",
                        value = "{3,3}",
                },

                ["DoorInterval"] = {
                        type = "DoorInterval",
                        value = "{1,2}",
                },

                ["HomeResourceRetrieve"] = {
                        type = "HomeResourceRetrieve",
                        value = "{{2,{110010,60,80,400},{110009,60,80,200},{110008,100,100,100}}}",
                },

                ["HomeAttributeResetTime"] = {
                        type = "HomeAttributeResetTime",
                        value = "15",
                },

                ["HomeAttributeMaxValue"] = {
                        type = "HomeAttributeMaxValue",
                        value = "{{1,1200},{2,1200},{3,1200},{4,1200},{5,1200},{6,1200}}",
                },

                ["HomeTouchBan"] = {
                        type = "HomeTouchBan",
                        value = "{sit,drink,eat}",
                },

                ["MailMax"] = {
                        type = "MailMax",
                        value = "300",
                },

                ["GenRoleFragBasicTimes"] = {
                        type = "GenRoleFragBasicTimes",
                        value = "1",
                },

                ["GenRoleFragBasicNum"] = {
                        type = "GenRoleFragBasicNum",
                        value = "1",
                },

                ["HomeFightTimes"] = {
                        type = "HomeFightTimes",
                        value = "{{21600,32400,100},{39600,50400,100},{61200,75600,100}}",
                },

                ["HomeFightSkillArea"] = {
                        type = "HomeFightSkillArea",
                        value = "0.5",
                },

                ["FriendMaxCount"] = {
                        type = "FriendMaxCount",
                        value = "50",
                },

                ["FriendPointMax"] = {
                        type = "FriendPointMax",
                        value = "30",
                },

                ["SendFriendAddpointCount"] = {
                        type = "SendFriendAddpointCount",
                        value = "{1,100014,10}",
                },

                ["SuggestFriendMax"] = {
                        type = "SuggestFriendMax",
                        value = "3",
                },

                ["SuggestFriendCon"] = {
                        type = "SuggestFriendCon",
                        value = "{200,5}",
                },

                ["PopSignOpen"] = {
                        type = "PopSignOpen",
                        value = "1001",
                },

                ["BattleCameraSet"] = {
                        type = "BattleCameraSet",
                        value = "{-16,-24,0.1}",
                },

                ["BattleCameraType"] = {
                        type = "BattleCameraType",
                        value = "{{35,20},{35,-70},{65,0}}",
                },

                ["HomeCameraSet"] = {
                        type = "HomeCameraSet",
                        value = "{-20,-45,0.1}",
                },

                ["HomeCameraType"] = {
                        type = "HomeCameraType",
                        value = "{{38,135},{20,135}}",
                },

                ["PveBossBattleUpdateCycle"] = {
                        type = "PveBossBattleUpdateCycle",
                        value = "21",
                },

                ["FishingCfg"] = {
                        type = "FishingCfg",
                        value = "{1, 5, 6, 5}",
                },

                ["AffectionAddFrag"] = {
                        type = "AffectionAddFrag",
                        value = "{{1,1},{3,1}}",
                },

                ["MouthCardMergeNum"] = {
                        type = "MouthCardMergeNum",
                        value = "5",
                },

                ["CameraMoveBounds"] = {
                        type = "CameraMoveBounds",
                        value = "{xMin=-65,xMax=25,yMin = -45,yMax = 50}",
                },

                ["SevenDayTaskCharacter"] = {
                        type = "SevenDayTaskCharacter",
                        value = "{1002801}",
                },

                ["HomeFightCD"] = {
                        type = "HomeFightCD",
                        value = "300",
                },

                ["DailyPpLimit"] = {
                        type = "DailyPpLimit",
                        value = "100",
                },

                ["PpGetNum"] = {
                        type = "PpGetNum",
                        value = "{{1,10},{2,20},{3,20},{4,20}}",
                },

                ["LanguageType"] = {
                        type = "LanguageType",
                        value = "{1,2}",
                },

                ["LanguageMain"] = {
                        type = "LanguageMain",
                        value = "1",
                },

                ["ShareReward"] = {
                        type = "ShareReward",
                        value = "{{1,100002,100}}",
                },

                ["InteractiveDialogueCfg"] = {
                        type = "InteractiveDialogueCfg",
                        value = "{intervalTime = {30.1, 60.1}, showTime = {3.1, 4.1}, checkRadius = 2}",
                },

}
return ConfigTable