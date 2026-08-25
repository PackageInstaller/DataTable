local System = require("System.System")
local readonly = System.readonly
local TagConfig = readonly({
  [84298] = {
    ID = 84298,
    CnID = "特性@虫族",
    BaseSortID = 1,
    TagName = "TagConfig_84298_TagName|虫族",
    TagDesc = "TagConfig_84298_TagDesc|是虫，是巢群意识的化身。",
    CounterAwaker = {77925},
    StateList = {80432}
  },
  [90645] = {
    ID = 90645,
    CnID = "特性@人类",
    BaseSortID = 2,
    TagName = "TagConfig_90645_TagName|人型",
    TagDesc = "TagConfig_90645_TagDesc|仍然保留着明显的人型，可能曾是街角某个你熟悉的面孔。",
    CounterAwaker = {15577, 125346},
    StateList = {90656}
  },
  [84299] = {
    ID = 84299,
    CnID = "特性@植物",
    BaseSortID = 3,
    TagName = "TagConfig_84299_TagName|植物",
    TagDesc = "TagConfig_84299_TagDesc|是植物，却已不甘为世界提供养分。",
    StateList = {90648}
  },
  [84291] = {
    ID = 84291,
    CnID = "特性@野兽",
    BaseSortID = 4,
    TagName = "TagConfig_84291_TagName|野兽",
    TagDesc = "TagConfig_84291_TagDesc|陷入疯狂的生灵，无情地破坏一切。",
    CounterAwaker = {15572},
    StateList = {90658}
  },
  [84293] = {
    ID = 84293,
    CnID = "特性@异变体",
    BaseSortID = 5,
    TagName = "TagConfig_84293_TagName|异变体",
    TagDesc = "TagConfig_84293_TagDesc|由融蚀而生的神秘生物，无人知晓那漆黑黏液下的构造。",
    CounterAwaker = {77918},
    StateList = {89575}
  },
  [94556] = {
    ID = 94556,
    CnID = "特性@亡灵",
    BaseSortID = 6,
    TagName = "TagConfig_94556_TagName|亡灵",
    TagDesc = "TagConfig_94556_TagDesc|躯体死亡后，灵魂寄居于别处而形成的生物。吞噬尸体与灵魂的物种也具备相似特征。",
    CounterAwaker = {95786},
    StateList = {94558}
  },
  [84297] = {
    ID = 84297,
    CnID = "特性@唤醒体",
    BaseSortID = 7,
    TagName = "TagConfig_84297_TagName|唤醒体",
    TagDesc = "TagConfig_84297_TagDesc|由银芯唤醒的强大个体，遇到请务必当心。",
    StateList = {90652}
  },
  [84283] = {
    ID = 84283,
    CnID = "特性@未知生物",
    BaseSortID = 8,
    TagName = "TagConfig_84283_TagName|未知生物",
    TagDesc = "TagConfig_84283_TagDesc|人类未曾见过的神秘生物，已知的科学无法为他们归类。",
    StateList = {89574}
  },
  [90640] = {
    ID = 90640,
    CnID = "特性@一档小怪",
    BaseSortID = 9,
    TagName = "TagConfig_90640_TagName|空壳",
    TagDesc = "TagConfig_90640_TagDesc|虽然本身孱弱，但聚集在一起仍然令人恐惧。",
    StateList = {90655}
  },
  [90641] = {
    ID = 90641,
    CnID = "特性@精英",
    BaseSortID = 10,
    TagName = "TagConfig_90641_TagName|眷族",
    TagDesc = "TagConfig_90641_TagDesc|敌人中的精锐，单体就令人难以应对。",
    StateList = {90657}
  },
  [90642] = {
    ID = 90642,
    CnID = "特性@二档小怪",
    BaseSortID = 11,
    TagName = "TagConfig_90642_TagName|眷族",
    TagDesc = "TagConfig_90642_TagDesc|敌人中的精锐，单体就令人难以应对。",
    StateList = {90651}
  },
  [84277] = {
    ID = 84277,
    CnID = "特性@首领",
    BaseSortID = 12,
    TagName = "TagConfig_84277_TagName|主宰",
    TagDesc = "TagConfig_84277_TagDesc|极其强大的敌人，独自便能形成怪异现象。",
    StateList = {90654}
  },
  [84294] = {
    ID = 84294,
    CnID = "特性@不可名状之物",
    BaseSortID = 13,
    TagName = "TagConfig_84294_TagName|原初投影",
    TagDesc = "TagConfig_84294_TagDesc|遇到它们后应当尽快远离，这是最后的忠告。",
    StateList = {90647}
  },
  [84284] = {
    ID = 84284,
    CnID = "特性@雪原",
    BaseSortID = 14,
    TagName = "TagConfig_84284_TagName|雪原",
    TagDesc = "TagConfig_84284_TagDesc|它们源于冰天雪地之中。",
    CounterAwaker = {15587},
    StateList = {90659}
  },
  [90643] = {
    ID = 90643,
    CnID = "特性@深海",
    BaseSortID = 15,
    TagName = "TagConfig_90643_TagName|深海",
    TagDesc = "TagConfig_90643_TagDesc|它们自深海而来。",
    CounterAwaker = {77922},
    StateList = {83816}
  },
  [90644] = {
    ID = 90644,
    CnID = "特性@超维",
    BaseSortID = 16,
    TagName = "TagConfig_90644_TagName|超维",
    TagDesc = "TagConfig_90644_TagDesc|它们带着维度穿行的痕迹。",
    CounterAwaker = {15581},
    StateList = {90653}
  },
  [84303] = {
    ID = 84303,
    CnID = "特性@血肉",
    BaseSortID = 17,
    TagName = "TagConfig_84303_TagName|血肉",
    TagDesc = "TagConfig_84303_TagDesc|它们由畸生的血肉构成。",
    CounterAwaker = {15588, 130226},
    StateList = {90650}
  },
  [84279] = {
    ID = 84279,
    CnID = "特性@审查会",
    BaseSortID = 18,
    TagName = "TagConfig_84279_TagName|审查会",
    TagDesc = "TagConfig_84279_TagDesc|最好不要被这些黑白的猎手抓到，他们排除危险的方式绝不容情。",
    StateList = {90649}
  },
  [90646] = {
    ID = 90646,
    CnID = "特性@提灯",
    BaseSortID = 19,
    TagName = "TagConfig_90646_TagName|提灯教会",
    TagDesc = "TagConfig_90646_TagDesc|一群疯狂的虔信者，将那些黑色的视作光明。",
    CounterAwaker = {77923, 77917},
    StateList = {90064}
  },
  [84280] = {
    ID = 84280,
    CnID = "特性@雕塑家协会",
    BaseSortID = 20,
    TagName = "TagConfig_84280_TagName|雕塑家协会",
    TagDesc = "TagConfig_84280_TagDesc|激进的融合实验者，残忍的科学怪人们齐聚一堂。",
    CounterAwaker = {15601},
    StateList = {80445}
  },
  [84302] = {
    ID = 84302,
    CnID = "特性@生命教廷",
    BaseSortID = 21,
    TagName = "TagConfig_84302_TagName|生命教廷",
    TagDesc = "TagConfig_84302_TagDesc|泛劳拉西亚大陆最广泛的信仰、仁慈的代表，大部分时刻反对伤害的行为。"
  },
  [84289] = {
    ID = 84289,
    CnID = "特性@门",
    BaseSortID = 22,
    TagName = "TagConfig_84289_TagName|门",
    TagDesc = "TagConfig_84289_TagDesc|这些人的命运与这所大学紧紧相连。"
  },
  [84292] = {
    ID = 84292,
    CnID = "特性@群星之间",
    BaseSortID = 23,
    TagName = "TagConfig_84292_TagName|群星之间",
    TagDesc = "TagConfig_84292_TagDesc|这颗星球并非他们的故土，他们来自宇宙之中。"
  },
  [84285] = {
    ID = 84285,
    CnID = "特性@异乡人",
    BaseSortID = 24,
    TagName = "TagConfig_84285_TagName|异乡人",
    TagDesc = "TagConfig_84285_TagDesc|漂泊的灵魂早已失去了原本的家乡。"
  },
  [84301] = {
    ID = 84301,
    CnID = "特性@混种",
    BaseSortID = 25,
    TagName = "TagConfig_84301_TagName|混种",
    TagDesc = "TagConfig_84301_TagDesc|他们的身体已然扭曲，但愿他们的灵魂仍然顽强。"
  },
  [84290] = {
    ID = 84290,
    CnID = "特性@莫测之物",
    BaseSortID = 26,
    TagName = "TagConfig_84290_TagName|莫测之物",
    TagDesc = "TagConfig_84290_TagDesc|不要探究他们身后的阴影，小心那会使你疯狂。"
  },
  [84288] = {
    ID = 84288,
    CnID = "特性@愚痴者",
    BaseSortID = 27,
    TagName = "TagConfig_84288_TagName|愚痴者",
    TagDesc = "TagConfig_84288_TagDesc|愚者永葆希望与勇气。"
  },
  [84295] = {
    ID = 84295,
    CnID = "特性@超越万古",
    BaseSortID = 28,
    TagName = "TagConfig_84295_TagName|超越万古",
    TagDesc = "TagConfig_84295_TagDesc|他们不死不灭，他们亘古长存。"
  },
  [84286] = {
    ID = 84286,
    CnID = "特性@黑暗住民",
    BaseSortID = 29,
    TagName = "TagConfig_84286_TagName|黑暗住民",
    TagDesc = "TagConfig_84286_TagDesc|在这个黑暗的世界中，他们亦留下了自己的故事。"
  },
  [94557] = {
    ID = 94557,
    CnID = "特性@高稳态",
    BaseSortID = 30,
    TagName = "TagConfig_94557_TagName|高稳态",
    TagDesc = "TagConfig_94557_TagDesc|诺斯指数较高的唤醒体，精神更加稳定，不易受到外界干扰。"
  },
  [94555] = {
    ID = 94555,
    CnID = "特性@低稳态",
    BaseSortID = 31,
    TagName = "TagConfig_94555_TagName|低稳态",
    TagDesc = "TagConfig_94555_TagDesc|诺斯指数较低的唤醒体，更容易陷入癫狂，握紧银钥匙，小心失控。"
  },
  [97323] = {
    ID = 97323,
    CnID = "特性@利莫里亚",
    BaseSortID = 32,
    TagName = "TagConfig_97323_TagName|利莫里亚",
    TagDesc = "TagConfig_97323_TagDesc|湮灭之国的海洋与星辰与他们的命运紧紧相连，无论忠诚或背叛。",
    StateList = {97324}
  },
  [143654] = {
    ID = 143654,
    CnID = "特性@欢愉眷属",
    BaseSortID = 33,
    TagName = "TagConfig_143654_TagName|欢愉眷属",
    TagDesc = "TagConfig_143654_TagDesc|加入欢愉眷属的优势：无论做出多么荒诞的举动，都不会被批判突兀。如果理解不了，那就是你还不够欢愉！",
    CounterAwaker = {141302},
    StateList = {143655}
  }
})
return TagConfig
