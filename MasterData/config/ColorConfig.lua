local System = require("System.System")
local readonly = System.readonly
local ColorConfig = readonly({
  UXDefault = {
    ColorID = "UXDefault",
    Light = "#000000",
    Dark = "#fbfbfb"
  },
  UXTitle1 = {
    ColorID = "UXTitle1",
    Light = "#7f7e78",
    Dark = "#7f7e78"
  },
  UXTitle2 = {
    ColorID = "UXTitle2",
    Light = "#c0ba97",
    Dark = "#c0ba97"
  },
  UXTitle3 = {
    ColorID = "UXTitle3",
    Light = "#fff8d2",
    Dark = "#fff8d2"
  },
  UXTextTitle = {
    ColorID = "UXTextTitle",
    Light = "#000000",
    Dark = "#fbfbfa"
  },
  UXText1 = {
    ColorID = "UXText1",
    Light = "#000000",
    Dark = "#fbfbfa"
  },
  UXTextTips = {
    ColorID = "UXTextTips",
    Light = "#525e5d",
    Dark = "#acbfca"
  },
  UXTextFrame = {
    ColorID = "UXTextFrame",
    Light = "#000000",
    Dark = "#454541"
  },
  UXTextNum = {
    ColorID = "UXTextNum",
    Light = "#2c8b9f",
    Dark = "#5eeffc"
  },
  UXUnunlocked = {
    ColorID = "UXUnunlocked",
    Light = "#ffffff",
    Dark = "#ff5a5a",
    Normal = "#ffffff"
  },
  UXEmphasize = {
    ColorID = "UXEmphasize",
    Light = "#2b8BA0",
    Dark = "#5EF2FF"
  },
  UXWarning = {
    ColorID = "UXWarning",
    Light = "#b74f44",
    Dark = "#ff5a5a"
  },
  UXSpecial = {
    ColorID = "UXSpecial",
    Light = "#896311",
    Dark = "#BAB28B"
  },
  UXCard = {
    ColorID = "UXCard",
    Light = "#ADBAC1",
    Dark = "#3f3b2f"
  },
  UXScore = {
    ColorID = "UXScore",
    Light = "#93d1a0",
    Dark = "#ff5a5a",
    Normal = "#acbfca"
  },
  UXUseup = {
    ColorID = "UXUseup",
    Light = "#75ecff",
    Dark = "#afafaf"
  },
  UXDouble = {
    ColorID = "UXDouble",
    Light = "#ffffff",
    Dark = "#555556"
  },
  UXAshing = {
    ColorID = "UXAshing",
    Light = "#6e6c6c",
    Dark = "#a3a6ab"
  },
  A = {
    ColorID = "A",
    Light = "#000000",
    Dark = "#ffffff"
  },
  B = {
    ColorID = "B",
    Light = "#000000",
    Dark = "#d8d5b9"
  },
  C = {
    ColorID = "C",
    Light = "#555a5c",
    Dark = "#909395"
  },
  D = {
    ColorID = "D",
    Light = "#127d81",
    Dark = "#189a9f"
  },
  E = {
    ColorID = "E",
    Light = "#e25312",
    Dark = "#e25312"
  },
  OldColor1 = {
    ColorID = "OldColor1",
    Light = "#882C14",
    Dark = "#882C14"
  },
  OldColor2 = {
    ColorID = "OldColor2",
    Light = "#00690B",
    Dark = "#00690B"
  },
  OldColor3 = {
    ColorID = "OldColor3",
    Light = "#ef8936",
    Dark = "#ef8936"
  },
  OldColor4 = {
    ColorID = "OldColor4",
    Light = "#00FF00",
    Dark = "#00FF00"
  },
  OldColor5 = {
    ColorID = "OldColor5",
    Light = "#6AC3CB",
    Dark = "#6AC3CB"
  },
  OldColor6 = {
    ColorID = "OldColor6",
    Light = "#a4f3ff",
    Dark = "#a4f3ff"
  },
  OldColor7 = {
    ColorID = "OldColor7",
    Light = "#696966",
    Dark = "#696966"
  },
  OldColor8 = {
    ColorID = "OldColor8",
    Light = "#81511c",
    Dark = "#81511c"
  },
  TalentGreen = {
    ColorID = "TalentGreen",
    Light = "#09F331",
    Dark = "#09F331"
  },
  TalentBlue = {
    ColorID = "TalentBlue",
    Light = "#6079F1",
    Dark = "#6079F1"
  },
  TalentRed = {
    ColorID = "TalentRed",
    Light = "#FA3A50",
    Dark = "#FA3A50"
  },
  TalentNumGrey = {
    ColorID = "TalentNumGrey",
    Light = "#555a5C",
    Dark = "#555a5C"
  },
  TalentNumWhite = {
    ColorID = "TalentNumWhite",
    Light = "#FFFFFF",
    Dark = "#FFFFFF"
  },
  TalentNumGreen = {
    ColorID = "TalentNumGreen",
    Light = "#189A9F",
    Dark = "#189A9F"
  },
  TalentNumBlue = {
    ColorID = "TalentNumBlue",
    Light = "#5EF2FF",
    Dark = "#5EF2FF"
  },
  TalentMaxLv = {
    ColorID = "TalentMaxLv",
    Light = "#DBDB1B",
    Dark = "#DBDB1B"
  },
  TalentCanLv = {
    ColorID = "TalentCanLv",
    Light = "#2BA707",
    Dark = "#2BA707"
  },
  TalentCannotLv = {
    ColorID = "TalentCannotLv",
    Light = "#505050",
    Dark = "#505050"
  },
  OptionHighlight = {
    ColorID = "OptionHighlight",
    Light = "#30e7e9",
    Dark = "#30e7e9"
  },
  TrinketSuitOn = {
    ColorID = "TrinketSuitOn",
    Light = "#5ef2ff",
    Dark = "#41E1BD"
  },
  TrinketSuitOff = {
    ColorID = "TrinketSuitOff",
    Light = "#828282",
    Dark = "#828282"
  },
  CardNameColor = {
    ColorID = "CardNameColor",
    Light = "#464240",
    Dark = "#baa979"
  },
  CardDescColor = {
    ColorID = "CardDescColor",
    Light = "#000000",
    Dark = "#86847d"
  },
  WhiteQuality = {
    ColorID = "WhiteQuality",
    Light = "#FFFFFF",
    Dark = "#FFFFFF"
  },
  GreenQuality = {
    ColorID = "GreenQuality",
    Light = "#09F331",
    Dark = "#09F331"
  },
  BlueQuality = {
    ColorID = "BlueQuality",
    Light = "#5EF2FF",
    Dark = "#5EF2FF"
  },
  OrangeQuality = {
    ColorID = "OrangeQuality",
    Light = "#e4b756",
    Dark = "#e4b756"
  },
  WedQuality = {
    ColorID = "WedQuality",
    Light = "#FF7272",
    Dark = "#FF7272"
  },
  Yellow = {
    ColorID = "Yellow",
    Light = "#f5df94",
    Dark = "#f5df94"
  },
  RedQuality = {
    ColorID = "RedQuality",
    Light = "#FF7272",
    Dark = "#FF7272"
  },
  AttrGreen = {
    ColorID = "AttrGreen",
    Light = "#5EF2FF",
    Dark = "#5EF2FF"
  },
  Blue = {
    ColorID = "Blue",
    Light = "#75ecff",
    Dark = "#75ecff"
  },
  Purple = {
    ColorID = "Purple",
    Light = "#EE82EE",
    Dark = "#4B0082"
  },
  Gray = {
    ColorID = "Gray",
    Light = "#9A9A9A",
    Dark = "#9A9A9A"
  },
  CardKeyWord = {
    ColorID = "CardKeyWord",
    Light = "#D95200",
    Dark = "#D95200"
  },
  SchoolQuialty = {
    ColorID = "SchoolQuialty",
    Light = "#5EF2FF",
    Dark = "#5EF2FF"
  },
  AwakerSkill = {
    ColorID = "AwakerSkill",
    Light = "#04ab04",
    Dark = "#04ab04"
  },
  WhiteRelic = {
    ColorID = "WhiteRelic",
    Light = "#b8b8b8",
    Dark = "#b8b8b8"
  },
  OrangeRelic = {
    ColorID = "OrangeRelic",
    Light = "#9C8A69",
    Dark = "#9C8A69"
  },
  RedRelic = {
    ColorID = "RedRelic",
    Light = "#855E5E",
    Dark = "#855E5E"
  },
  PotencyChoose = {
    ColorID = "PotencyChoose",
    Light = "#74ebfe",
    Dark = "#74ebfe"
  },
  PotencyActive = {
    ColorID = "PotencyActive",
    Light = "#ffffff",
    Dark = "#ffffff"
  },
  PotencyNotActive = {
    ColorID = "PotencyNotActive",
    Light = "#97a0a1",
    Dark = "#97a0a1"
  },
  Red = {
    ColorID = "Red",
    Light = "#FF5A5A",
    Dark = "#FF5A5A"
  },
  ResonanceGray = {
    ColorID = "ResonanceGray",
    Light = "#a9a9a9",
    Dark = "#a9a9a9"
  },
  Mail_Text_Introduce_Nor = {
    ColorID = "Mail_Text_Introduce_Nor",
    Light = "#2b3136",
    Dark = "#7e8386"
  },
  Mail_Text_Detail_Nor = {
    ColorID = "Mail_Text_Detail_Nor",
    Light = "#2b3136",
    Dark = "#7e8386"
  },
  WeaponEffect_Num = {
    ColorID = "WeaponEffect_Num",
    Light = "#2b8ba0",
    Dark = "#5ef2ff"
  },
  Research = {
    ColorID = "Research",
    Light = "#ffffff",
    Dark = "#8c8c8c",
    Normal = "#ffffff"
  },
  SummonOrange = {
    ColorID = "SummonOrange",
    Light = "#f0d67b",
    Dark = "#f0d67b"
  },
  SummonBlue = {
    ColorID = "SummonBlue",
    Light = "#6faeef",
    Dark = "#6faeef"
  },
  SummonRed = {
    ColorID = "SummonRed",
    Light = "#e05e5e",
    Dark = "#e05e5e"
  },
  SummonPurple = {
    ColorID = "SummonPurple",
    Light = "#b27fff",
    Dark = "#b27fff"
  },
  UIChallenge = {
    ColorID = "UIChallenge",
    Light = "#5EEFFC",
    Dark = "#f35c5c",
    Normal = "#5EEFFC"
  },
  DrawCards = {
    ColorID = "DrawCards",
    Light = "#ACACAC",
    Dark = "#FFFFFF",
    Normal = "#FFFFFF"
  },
  Claimed = {
    ColorID = "Claimed",
    Light = "#8d9196",
    Dark = "#8d9196"
  },
  Receive = {
    ColorID = "Receive",
    Light = "#ffd776",
    Dark = "#ffd776"
  },
  UXUnunlocked2 = {
    ColorID = "UXUnunlocked2",
    Light = "#4a7358",
    Dark = "#B74F44",
    Normal = "#000000"
  },
  UITimeShop = {
    ColorID = "UITimeShop",
    Light = "#3f4746",
    Dark = "#aab9c0"
  },
  UXUnunlocked3 = {
    ColorID = "UXUnunlocked3",
    Light = "#ffffff",
    Dark = "#acbfca",
    NormalLow = "#6e6c6c"
  },
  UXUnunlocked4 = {
    ColorID = "UXUnunlocked4",
    Light = "#ffffff",
    Dark = "#000000",
    NormalLow = "#6e6c6c"
  },
  Claimed2 = {
    ColorID = "Claimed2",
    Light = "#a3a6ab",
    Dark = "#b9d6dd"
  },
  MonthCard = {
    ColorID = "MonthCard",
    Light = "#56f9ff",
    Dark = "#56f9ff"
  },
  TutorialHighlight = {
    ColorID = "TutorialHighlight",
    Light = "#5EF2FF",
    Dark = "#5EF2FF"
  },
  TextBtnState = {
    ColorID = "TextBtnState",
    Light = "#ffffff",
    Dark = "#9b9b9b"
  },
  TextRed = {
    ColorID = "TextRed",
    Light = "#767676",
    Dark = "#f72e18"
  },
  TextScreen = {
    ColorID = "TextScreen",
    Light = "#ffffff",
    Dark = "#B1B0A0",
    Normal = "#B1B0A0"
  },
  UXSkillLevelNum = {
    ColorID = "UXSkillLevelNum",
    Light = "#5ef2ff",
    Dark = "#ffffff",
    Normal = "#ffffff"
  },
  UXDispatch = {
    ColorID = "UXDispatch",
    Light = "#8cc698",
    Dark = "#7e8386",
    Normal = "#7e8386"
  },
  UXTotalGrade = {
    ColorID = "UXTotalGrade",
    Light = "#95CEA0",
    Dark = "#ACBFCA",
    Normal = "#ACBFCA"
  },
  UX_Dispatch_Title = {
    ColorID = "UX_Dispatch_Title",
    Light = "#7e8386",
    Dark = "#000000",
    Normal = "#000000"
  },
  redword = {
    ColorID = "redword",
    Light = "#bb646d",
    Dark = "#bb646d"
  },
  blueword = {
    ColorID = "blueword",
    Light = "#76aac8",
    Dark = "#76aac8"
  },
  orangeword = {
    ColorID = "orangeword",
    Light = "#c48662",
    Dark = "#c48662"
  },
  yellowword = {
    ColorID = "yellowword",
    Light = "#b6ad65",
    Dark = "#b6ad65"
  },
  greenword = {
    ColorID = "greenword",
    Light = "#71aa86",
    Dark = "#71aa86"
  },
  purpleword = {
    ColorID = "purpleword",
    Light = "#af6bb0",
    Dark = "#af6bb0"
  },
  whiteword = {
    ColorID = "whiteword",
    Light = "#ffffff",
    Dark = "#ffffff"
  },
  silveryword = {
    ColorID = "silveryword",
    Light = "#6baa83",
    Dark = "#6baa83"
  },
  Color24CardNow = {
    ColorID = "Color24CardNow",
    Light = "#ebeae1",
    Dark = "#ebeae1"
  },
  Color24CardLost = {
    ColorID = "Color24CardLost",
    Light = "#676e73",
    Dark = "#676e73"
  },
  NetworkDelayGreen = {
    ColorID = "NetworkDelayGreen",
    Light = "#71aa86",
    Dark = "#71aa86"
  },
  NetworkDelayYellow = {
    ColorID = "NetworkDelayYellow",
    Light = "#a27c4e",
    Dark = "#a27c4e"
  },
  NetworkDelayRed = {
    ColorID = "NetworkDelayRed",
    Light = "#a2564e",
    Dark = "#a2564e"
  },
  TextState = {
    ColorID = "TextState",
    Light = "#b5b5b5",
    Dark = "#5c5c5c"
  },
  SkillGrade = {
    ColorID = "SkillGrade",
    Light = "#1D9BA0",
    Dark = "#000000",
    Normal = "#000000"
  },
  Max = {
    ColorID = "Max",
    Light = "#EDE3B7",
    Dark = "#E7CA0B"
  },
  TabCareer = {
    ColorID = "TabCareer",
    Light = "#FFFFFF",
    Dark = "#77797a",
    Normal = "#FFFFFF"
  },
  Black = {
    ColorID = "Black",
    Light = "#171717",
    Dark = "#171717"
  },
  PotencyName = {
    ColorID = "PotencyName",
    Light = "#FFFFFF",
    Dark = "#909395",
    Normal = "#FFFFFF",
    NormalLow = "#FFFFFF"
  },
  LightGray = {
    ColorID = "LightGray",
    Light = "#ACBFCA",
    Dark = "#ACBFCA"
  },
  TextPlan = {
    ColorID = "TextPlan",
    Light = "#71c295",
    Dark = "#d86a74",
    Normal = "#d0e8ee"
  },
  UITextToggle = {
    ColorID = "UITextToggle",
    Light = "#E1E1E1",
    Dark = "#929DA0",
    Normal = "#929DA0"
  },
  UITextToggle2 = {
    ColorID = "UITextToggle2",
    Light = "#E1E1E1",
    Dark = "#92A5B0",
    Normal = "#92A5B0"
  },
  UXEmphasize_1 = {
    ColorID = "UXEmphasize_1",
    Light = "#2B8BA0",
    Dark = "#2B8BA0"
  },
  Dope = {
    ColorID = "Dope",
    Light = "#ff5a5a",
    Dark = "#ffffff"
  },
  Selected = {
    ColorID = "Selected",
    Light = "#ff6262",
    Dark = "#e1e1e1",
    Normal = "#e1e1e1"
  },
  Remainder = {
    ColorID = "Remainder",
    Light = "#755206",
    Dark = "#00687f",
    Normal = "#00687f"
  },
  Difficulty = {
    ColorID = "Difficulty",
    Light = "#ffffff",
    Dark = "#6e6c6c",
    Normal = "#acbfca",
    NormalLow = "#6e6c6c"
  },
  Chaper = {
    ColorID = "Chaper",
    Light = "#37253f",
    Dark = "#000000",
    Normal = "#000000"
  },
  UITextGrey = {
    ColorID = "UITextGrey",
    Light = "#E1E1E1",
    Dark = "#7e8386"
  },
  UITextActivate = {
    ColorID = "UITextActivate",
    Light = "#93d1a0",
    Dark = "#d1d0c3"
  },
  UITextActivate2 = {
    ColorID = "UITextActivate2",
    Light = "#e1e1e1",
    Dark = "#9e9e9e"
  },
  UITextActivate3 = {
    ColorID = "UITextActivate3",
    Light = "#acbfca",
    Dark = "#9e9e9e"
  },
  UITextChapter1 = {
    ColorID = "UITextChapter1",
    Light = "#ffffff",
    Dark = "#5c5c5c",
    Normal = "#000000"
  },
  FeatureUnlockTitle = {
    ColorID = "FeatureUnlockTitle",
    Light = "#ffffff",
    Dark = "#ffffff",
    Normal = "#ffffff"
  },
  FeatureUnlockDesc = {
    ColorID = "FeatureUnlockDesc",
    Light = "#a8bac5",
    Dark = "#a8bac5",
    Normal = "#a8bac5"
  },
  UXDisorder = {
    ColorID = "UXDisorder",
    Light = "#e1e1e1",
    Dark = "#a3a6ab"
  },
  GrayState = {
    ColorID = "GrayState",
    Light = "#a3a6ab",
    Dark = "#a3a6ab"
  },
  Dungeons01 = {
    ColorID = "Dungeons01",
    Light = "#e1e1e1",
    Dark = "#acbfca"
  },
  Dungeons02 = {
    ColorID = "Dungeons02",
    Light = "#767676",
    Dark = "#f72e18"
  },
  Dungeons03 = {
    ColorID = "Dungeons03",
    Light = "#1f2428",
    Dark = "#7e8386"
  },
  Dungeons04 = {
    ColorID = "Dungeons04",
    Light = "#2b3136",
    Dark = "#7e8386"
  },
  KeyTitle = {
    ColorID = "KeyTitle",
    Light = "#ffffff",
    Dark = "#797979"
  },
  KeyDescription = {
    ColorID = "KeyDescription",
    Light = "#ffffff",
    Dark = "#929292"
  },
  UI_Event_Reward_TabTitle = {
    ColorID = "UI_Event_Reward_TabTitle",
    Light = "#FFFFFF",
    Dark = "#ACBFCA",
    Normal = "#ACBFCA"
  },
  UI_Event_Reward_TabProgress = {
    ColorID = "UI_Event_Reward_TabProgress",
    Light = "#FFFFFF",
    Dark = "#ACBFCA",
    Normal = "#ACBFCA"
  },
  UXConsume = {
    ColorID = "UXConsume",
    Light = "#FFFFFF",
    Dark = "#FF5B5B"
  },
  UXLake_City = {
    ColorID = "UXLake_City",
    Light = "#FFFFFF",
    Dark = "#a3a6ab"
  },
  TrinketSuitAttrAdd = {
    ColorID = "TrinketSuitAttrAdd",
    Light = "#93D1A0",
    Dark = "#93D1A0"
  },
  TrinketSuitAttrSub = {
    ColorID = "TrinketSuitAttrSub",
    Light = "#BB646D",
    Dark = "#BB646D"
  },
  TrinketPlanSuitActived = {
    ColorID = "TrinketPlanSuitActived",
    Light = "#ACBFCA",
    Dark = "#ACBFCA"
  },
  TrinketPlanSuitTitleActived = {
    ColorID = "TrinketPlanSuitTitleActived",
    Light = "#E1E1E1",
    Dark = "#E1E1E1"
  },
  UXLake_City_1 = {
    ColorID = "UXLake_City_1",
    Light = "#FFFFFF",
    Dark = "#a3a6ab"
  },
  UXTalent = {
    ColorID = "UXTalent",
    Light = "#FFFFFF",
    Dark = "#7B7B7C"
  },
  UXTalentLv = {
    ColorID = "UXTalentLv",
    Light = "#525E5D",
    Dark = "#2B8BA0"
  },
  UXTalentCurrency = {
    ColorID = "UXTalentCurrency",
    Light = "#525E5D",
    Dark = "#B74F44",
    Normal = "#525E5D"
  },
  UXExpression = {
    ColorID = "UXExpression",
    Light = "#ffffff",
    Dark = "#777777",
    Normal = "#ffffff"
  },
  UXWorld = {
    ColorID = "UXWorld",
    Light = "#FFF8D2",
    Dark = "#a3a6ab"
  },
  TaskFinish = {
    ColorID = "TaskFinish",
    Light = "#93D1A0",
    Dark = "#93D1A0"
  },
  DayTime = {
    ColorID = "DayTime",
    Light = "#2b3136",
    Dark = "#2b3136"
  },
  Gray1 = {
    ColorID = "Gray1",
    Light = "#a3a6ab",
    Dark = "#a3a6ab"
  },
  UXAvgNovelText = {
    ColorID = "UXAvgNovelText",
    Light = "#FFFFFF",
    Dark = "#CFCFCF"
  },
  UIDeepen = {
    ColorID = "UIDeepen",
    Light = "#000000",
    Dark = "#A2A2A2"
  },
  UIOverrunSkill = {
    ColorID = "UIOverrunSkill",
    Light = "#FFBF00",
    Dark = "#BDC7D1"
  },
  UISoreEventlItem = {
    ColorID = "UISoreEventlItem",
    Light = "#EBE7CD",
    Dark = "#7E8386"
  },
  D06yixiangxi = {
    ColorID = "D06yixiangxi",
    Light = "#FDC677",
    Dark = "#FDC677"
  },
  D06yixiangnu = {
    ColorID = "D06yixiangnu",
    Light = "#E0987F",
    Dark = "#E0987F"
  },
  D06yixiangai = {
    ColorID = "D06yixiangai",
    Light = "#7193BC",
    Dark = "#7193BC"
  },
  D06yixiangju = {
    ColorID = "D06yixiangju",
    Light = "#A071BC",
    Dark = "#A071BC"
  },
  UIDungeousChooseDifficulty = {
    ColorID = "UIDungeousChooseDifficulty",
    Light = "#FFFFFF",
    Dark = "#B5B5B5"
  },
  UIAppearanceBtnTxt = {
    ColorID = "UIAppearanceBtnTxt",
    Light = "#FFFFFF",
    Dark = "#ACBFCA",
    Normal = "#ACBFCA"
  },
  AvgCommunicateConfuseColor = {
    ColorID = "AvgCommunicateConfuseColor",
    Light = "#2F3030",
    Dark = "#FFFFFF"
  },
  OstLockConfuseTextColor = {
    ColorID = "OstLockConfuseTextColor",
    Light = "#545454",
    Dark = "#545454"
  },
  UIPvpRotationTextTime = {
    ColorID = "UIPvpRotationTextTime",
    Light = "#4bc6d1",
    Dark = "#bb646d"
  },
  UIPvpRotationSliderTime = {
    ColorID = "UIPvpRotationSliderTime",
    Light = "#4DC7D2",
    Dark = "#d8616d"
  }
})
return ColorConfig
