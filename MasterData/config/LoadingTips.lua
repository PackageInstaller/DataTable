local System = require("System.System")
local readonly = System.readonly
local LoadingTips = readonly({
  [17468] = {
    ID = 17468,
    CnID = "加载界面提示@1",
    BaseSortID = 1,
    LoadingTips = "LoadingTips_17468_LoadingTips|融蚀裂隙一经生成，无法缩小，无法终止。\n寻常手段无法对融蚀裂隙产生影响，但银钥匙可以在一定程度上压制甚至“关闭”裂隙。",
    LoadingTips_TW = "融蝕裂隙一經生成，無法縮小，無法終止。\n尋常手段無法對融蝕裂隙產生影響，但銀鑰匙可以在一定程度上壓制甚至“關閉”裂隙。",
    LoadingTips_EN = "Once a Corrosive Fissure is generated, it cannot shrink or be terminated.\\nConventional means have no effect on Corrosive Fissures, but the Silver Key can suppress or even \"close\" the fissure to a certain extent."
  },
  [17470] = {
    ID = 17470,
    CnID = "加载界面提示@2",
    BaseSortID = 2,
    LoadingTips = "LoadingTips_17470_LoadingTips|融蚀侵蚀会发生在包括人类、动物、植物等有机生物体上，也会出现在矿物、金属等无机物上。\n目前尚未发现能够免疫融蚀现象的物质。",
    LoadingTips_TW = "融蝕侵蝕會發生在包括人類、動物、植物等有機生物體上，也會出現在礦物、金屬等無機物上。\n目前尚未發現能夠免疫融蝕現象的物質。",
    LoadingTips_EN = [[
Corrosive Erosion can occur on organic bodies such as humans, animals, plants, and also on inorganic substances like minerals and metals.
No material has been found that is immune to the Corrosive phenomenon.]]
  },
  [17469] = {
    ID = 17469,
    CnID = "加载界面提示@3",
    BaseSortID = 3,
    LoadingTips = "LoadingTips_17469_LoadingTips|大部分受融蚀侵蚀个体，思维亦会受到干扰，会出现偏执、强迫症、亢奋等精神异常，且伴随记忆力减退。",
    LoadingTips_TW = "大部分受融蝕侵蝕個體，思維亦會受到干擾，會出現偏執、強迫症、亢奮等精神異常，且伴隨記憶力減退。",
    LoadingTips_EN = "Most individuals affected by Corrosive Erosion will experience disturbed thoughts, exhibiting symptoms like paranoia, compulsive behavior, excitement, and memory loss."
  },
  [17472] = {
    ID = 17472,
    CnID = "加载界面提示@4",
    BaseSortID = 4,
    LoadingTips = "LoadingTips_17472_LoadingTips|依照异变的不同，可将融蚀体大致分为不同类型。其中最常见的为协作型融蚀体，干涉型融蚀体及复合型融蚀体。",
    LoadingTips_TW = "依照異變的不同，可將融蝕體大致分為不同類型。其中最常見的為協作型融蝕體，干涉型融蝕體及復合型融蝕體。",
    LoadingTips_EN = "Based on different mutations, Corrosive bodies can be roughly categorized into different types. The most common types are Cooperative Corrosive Body, Interference Corrosive Body, and Composite Corrosive Body."
  },
  [17471] = {
    ID = 17471,
    CnID = "加载界面提示@5",
    BaseSortID = 5,
    LoadingTips = "LoadingTips_17471_LoadingTips|绝大多数人类无法通过肉眼观测融蚀现象。",
    LoadingTips_TW = "絕大多數人類無法通過肉眼觀測融蝕現象。",
    LoadingTips_EN = "Most humans cannot observe the Corrosive phenomenon with the naked eye."
  },
  [17474] = {
    ID = 17474,
    CnID = "加载界面提示@6",
    BaseSortID = 6,
    LoadingTips = "LoadingTips_17474_LoadingTips|融蚀是物质出现的一种特殊消解、溶解的现象，具有区域性特征。",
    LoadingTips_TW = "融蝕是物質出現的一種特殊消解、溶解的現象，具有區域性特徵。",
    LoadingTips_EN = "Corrosion is a special disintegration and dissolution phenomenon of matter, characterized by regional features."
  },
  [17473] = {
    ID = 17473,
    CnID = "加载界面提示@7",
    BaseSortID = 7,
    LoadingTips = "LoadingTips_17473_LoadingTips|融蚀现象出现在物质上时的表现，体现为单个或数个类倒三角形状的小型开洞。\n这些开洞的尺寸约在3mm～1cm之间，随着融蚀的进展，融蚀痕会逐渐扩大。",
    LoadingTips_TW = "融蝕現象出現在物質上時的表現，體現為單個或數個類倒三角形狀的小型開洞。\n這些開洞的尺寸約在3mm～1cm之間，隨著融蝕的進展，融蝕痕會逐漸擴大。",
    LoadingTips_EN = [[
When the Corrosion phenomenon appears on a material, it manifests as one or several small inverted triangular holes.
These holes range in size from about 3mm to 1cm, and as the Corrosion progresses, the Corrosive marks will gradually expand.]]
  },
  [17476] = {
    ID = 17476,
    CnID = "加载界面提示@8",
    BaseSortID = 8,
    LoadingTips = "LoadingTips_17476_LoadingTips|融蚀浆具有憎水性，不透水也难溶于水，黏度中等且具有一定延展性。\n数百年前，莽撞的人类曾试图将它当作工业和艺术的原料。",
    LoadingTips_TW = "融蝕漿具有憎水性，不透水也難溶于水，黏度中等且具有一定延展性。\n數百年前，莽撞的人類曾試圖將它當作工業和藝術的原料。",
    LoadingTips_EN = [[
Corrosive Paste is hydrophobic, impermeable, and poorly soluble in water, with moderate viscosity and some ductility.
Hundreds of years ago, reckless humans once tried to use it as an industrial and artistic material.]]
  },
  [17475] = {
    ID = 17475,
    CnID = "加载界面提示@9",
    BaseSortID = 9,
    LoadingTips = "LoadingTips_17475_LoadingTips|融蚀现象发展到一定阶段后，有一定概率从融蚀痕中生出赘生物。\n它们可能是额外的肢体、触手，也可能是齿轮、金属……",
    LoadingTips_TW = "融蝕現象發展到一定階段後，有一定概率從融蝕痕中生出贅生物。\n它們可能是額外的肢體、觸手，也可能是齒輪、金屬……",
    LoadingTips_EN = [[
At a certain stage of development, the Corrosive phenomenon has a probability to generate growths from Corrosive marks.
These could be additional limbs, tentacles, gears, metal, etc.]]
  },
  [17480] = {
    ID = 17480,
    CnID = "加载界面提示@10",
    BaseSortID = 10,
    LoadingTips = "LoadingTips_17480_LoadingTips|直径超过5米，且仍有扩大可能性的巨大融蚀痕，被称为融蚀裂隙。\n裂隙的核心被称为「灾厄」。",
    LoadingTips_TW = "直徑超過5米，且仍有擴大可能性的巨大融蝕痕，可被算作融蝕裂隙。\n裂隙的核心被稱為「災厄」。",
    LoadingTips_EN = "A Corrosive mark with a diameter exceeding 5 meters, with the potential to continue expanding, is called a Corrosive Fissure.\nThe core of the fissure is called 「Disaster」."
  },
  [17494] = {
    ID = 17494,
    CnID = "加载界面提示@11",
    BaseSortID = 11,
    LoadingTips = "LoadingTips_17494_LoadingTips|每个个体在消解时，能析出的银芯的量不同。\n精神力越强的个体，在被融蚀消解后能析出的银芯越多，反之则越少。",
    LoadingTips_TW = "每個個體在消解時，能析出的銀芯的量不同。\n越強的精神，在被融蝕消解後能析出的銀芯越多，反之則越少。",
    LoadingTips_EN = [[
The amount of Silver Core that can be extracted during dissolution varies between individuals.
The stronger the individual's mental power, the more Silver Core can be extracted after being Corroded; conversely, the less.]]
  },
  [17489] = {
    ID = 17489,
    CnID = "加载界面提示@12",
    BaseSortID = 12,
    LoadingTips = "LoadingTips_17489_LoadingTips|银芯一般以两种形态存在在现实世界中：银芯源液，及斜方六面体银芯。",
    LoadingTips_TW = "銀芯一般以兩種形態存在在現實世界中：銀芯源液，及斜方六面體銀芯。",
    LoadingTips_EN = "Silver Cores generally exist in two forms in the real world: Silver Core Source Liquid and Rhombohedral Silver Core."
  },
  [17495] = {
    ID = 17495,
    CnID = "加载界面提示@13",
    BaseSortID = 13,
    LoadingTips = "LoadingTips_17495_LoadingTips|银芯科技中具有代表性的物品有：融蚀观察设备，弥萨格大学通讯器，银钥匙等。\n其中最特殊也是最珍贵的是银钥匙。",
    LoadingTips_TW = "銀芯科技中具有代表性的物品有：融蝕觀察設備，彌薩格大學通訊器，銀鑰匙等。\n其中最特殊也是最珍貴的是銀鑰匙。",
    LoadingTips_EN = [[
Representative items of Silver Core technology include: Corrosion Observation Equipment, Misagga University Communicator, Silver Key, etc.
The most special and most precious among them is the Silver Key.]]
  },
  [17491] = {
    ID = 17491,
    CnID = "加载界面提示@14",
    BaseSortID = 14,
    LoadingTips = "LoadingTips_17491_LoadingTips|一把银钥匙的诞生需要经过一系列复杂的工序，最后会刻上唯一的编号。\n银钥匙严禁交易、严禁转赠，无主时将由弥萨格回收。",
    LoadingTips_TW = "一把銀鑰匙的誕生需要經過一系列複雜的工序，最後會刻上唯一的編號。\n銀鑰匙嚴禁交易、嚴禁轉贈，無主時將由彌薩格回收。",
    LoadingTips_EN = [[
The birth of a Silver Key requires a series of complex procedures, and each one is engraved with a unique serial number.
Silver Keys are strictly prohibited from being traded or gifted and will be reclaimed by Misagga when ownerless.]]
  },
  [17500] = {
    ID = 17500,
    CnID = "加载界面提示@15",
    BaseSortID = 15,
    LoadingTips = "LoadingTips_17500_LoadingTips|持有银钥匙的调查员、守密人可以顺利通过校外迷雾，与已链接的唤醒体一同进入校园。",
    LoadingTips_TW = "持有銀鑰匙的調查員、守密人可以順利通過校外迷霧，與已連結的喚醒體一同進入校園。",
    LoadingTips_EN = "Investigators or Secret Keepers holding a Silver Key can smoothly pass through the external fog and enter the campus with the linked Awakening Body."
  },
  [17493] = {
    ID = 17493,
    CnID = "加载界面提示@16",
    BaseSortID = 16,
    LoadingTips = "LoadingTips_17493_LoadingTips|依照《密斯底亚协定》中的相关条款，弥萨格大学会向密斯底亚协定审查会提供银芯科技的相关支持，以便共同抵御融蚀，应对危机。",
    LoadingTips_TW = "依照《密斯底亞協定》中的相關條款，彌薩格大學會向密斯底亞協定審查會提供銀芯科技的相關支持，以便共同抵禦融蝕，應對危機。",
    LoadingTips_EN = "According to the relevant terms in the 「Misdia Agreement」, Misagga University will provide support related to Silver Core technology to the Misdia Agreement Review Board, to jointly resist Corrosion and deal with crises."
  },
  [17492] = {
    ID = 17492,
    CnID = "加载界面提示@17",
    BaseSortID = 17,
    LoadingTips = "LoadingTips_17492_LoadingTips|禁忌的典籍锁在图书馆书架最高处，只有具备权限的人才能查阅。",
    LoadingTips_TW = "禁忌的典籍鎖在圖書館書架最高處，只有具備許可權的人才能查閱。",
    LoadingTips_EN = "Forbidden tomes are locked on the highest shelves of the library, and only those with proper permissions can access them."
  },
  [17505] = {
    ID = 17505,
    CnID = "加载界面提示@18",
    BaseSortID = 18,
    LoadingTips = "LoadingTips_17505_LoadingTips|通常而言，一名调查员同时只能链接一位唤醒体。但也不排除有特殊案例。",
    LoadingTips_TW = "通常而言，一名調查員同時只能連結一位喚醒體。但也不排除有特殊案例。",
    LoadingTips_EN = "Generally speaking, an investigator can only link to one Awakening Body at a time, though there are exceptional cases."
  },
  [17504] = {
    ID = 17504,
    CnID = "加载界面提示@19",
    BaseSortID = 19,
    LoadingTips = "LoadingTips_17504_LoadingTips|那些相较于一般调查员拥有更多能力、能够链接更多唤醒体的特殊人才，会被授予守密人称号。\n迄今为止，能以守密人之名行走于世间的寥寥无几。",
    LoadingTips_TW = "那些相較於一般調查員擁有更多能力、能夠連結更多喚醒體的特殊人才，會被授予守密人稱號。\n迄今為止，能以守密人之名行走於世間的寥寥無幾。",
    LoadingTips_EN = [[
Special talents who possess more abilities than the average investigator and can link more Awakening Bodies will be granted the title of Secret Keeper.
So far, only a few can walk the world under the name of Secret Keeper.]]
  },
  [17481] = {
    ID = 17481,
    CnID = "加载界面提示@20",
    BaseSortID = 20,
    LoadingTips = "LoadingTips_17481_LoadingTips|应急灵知体能直接作用于唤醒体的精神，激发唤醒体的潜力，瞬时恢复唤醒体的状态。唯一的缺点就是其高昂的造价。",
    LoadingTips_TW = "應急靈知體能直接作用於喚醒體的精神，激發喚醒體的潛力，暫態恢復喚醒體的狀態。唯一的缺點就是其高昂的造價。",
    LoadingTips_EN = "Emergency Spirit Entities can act directly on the spirit of the Awakening Body, activating its potential to instantly restore its state. The only drawback is its high cost."
  },
  [17482] = {
    ID = 17482,
    CnID = "加载界面提示@21",
    BaseSortID = 21,
    LoadingTips = "LoadingTips_17482_LoadingTips|外勤任务瞬息万变，具有很强的不可控性。\n针对这种情况，弥萨格大学为外勤人员提供了一些紧急装置，以最大可能保障他们的安全。",
    LoadingTips_TW = "外勤任務瞬息萬變，具有很強的不可控性。\n針對這種情況，彌薩格大學為外勤人員提供了一些緊急裝置，以最大可能保障他們的安全。",
    LoadingTips_EN = [[
Field tasks are ever-changing and highly unpredictable.
To address this, Misagga University provides some emergency devices for field personnel to maximize their safety.]]
  },
  [17483] = {
    ID = 17483,
    CnID = "加载界面提示@22",
    BaseSortID = 22,
    LoadingTips = "LoadingTips_17483_LoadingTips|调查员、守密人调查的一般都不是普通的现实事件，而是涉及融蚀、融蚀体等与精神维度有着极大联系的特殊事件。",
    LoadingTips_TW = "調查員、守密人調查的一般都不是普通的現實事件，而是涉及融蝕、融蝕體等與精神維度有著極大聯繫的特殊事件。",
    LoadingTips_EN = "Investigators and Secret Keepers do not generally investigate ordinary real-world events but rather special cases involving Corrosion and Corrosive Bodies closely linked to the spiritual dimension."
  },
  [17484] = {
    ID = 17484,
    CnID = "加载界面提示@23",
    BaseSortID = 23,
    LoadingTips = "LoadingTips_17484_LoadingTips|在有融蚀现象的区域，精神维度的投影更加清晰，密境也更容易被观测到，但也更多变和危险。",
    LoadingTips_TW = "在有融蝕現象的區域，精神維度的投影更加清晰，密境也更容易被觀測到，但也更多變和危險。",
    LoadingTips_EN = "In areas with Corrosion phenomenon, projections of the spiritual dimension are clearer, and Secret Realms are easier to observe but are also more variable and dangerous."
  },
  [17466] = {
    ID = 17466,
    CnID = "加载界面提示@24",
    BaseSortID = 24,
    LoadingTips = "LoadingTips_17466_LoadingTips|密境中，情感、思绪、思维、执念等都可能具有可观测的投影。这些投影一般是虚幻的物品，是精神维度对现实维度个体的感官的欺骗。",
    LoadingTips_TW = "密境中，情感、思緒、思維、執念等都可能具有可觀測的投影。這些投影一般是虛幻的物品，是精神維度對現實維度個體的感官的欺騙。",
    LoadingTips_EN = "In the Secret Realm, emotions, thoughts, obsessions, etc., may have observable projections. These projections are generally illusory items, a deception of the spiritual dimension on the sensory perceptions of individuals in the real dimension."
  },
  [17467] = {
    ID = 17467,
    CnID = "加载界面提示@25",
    BaseSortID = 25,
    LoadingTips = "LoadingTips_17467_LoadingTips|灵知转印器是一种内置在调查员、守密人手提箱中的特殊仪器，可以将意识精神转印成仅通过融蚀观察设备查看的高维卡牌：指令卡。",
    LoadingTips_TW = "靈知轉印器是一種內置在調查員、守密人手提箱中的特殊儀器，可以將意識精神轉印成僅通過融蝕觀察設備查看的高維卡牌：指令卡。",
    LoadingTips_EN = "The Spirit Transfer Device is a special instrument built into the briefcase of investigators and Secret Keepers, which can transfer conscious spirits into high-dimensional cards visible only through Corrosion Observation Equipment: Command Cards."
  },
  [17487] = {
    ID = 17487,
    CnID = "加载界面提示@26",
    BaseSortID = 26,
    LoadingTips = "LoadingTips_17487_LoadingTips|密斯底亚审查会（简称CMT）是由各国政府共同建立，却又独立于政府存在的，由普通人类构成的隐秘组织。\n它是融蚀现象的第一发现者、第一响应者，\n也是普通人类对抗融蚀的第一战线。",
    LoadingTips_TW = "密斯底亞審查會（簡稱CMT）是由各國政府共同建立，卻又獨立於政府存在的，由普通人類構成的隱秘組織。\n它是融蝕現象的第一發現者、第一回應者，\n也是普通人類對抗融蝕的第一戰線。",
    LoadingTips_EN = [[
The Misdia Review Board (abbreviated as CMT) is a secret organization formed by governments of various countries yet independent of them, composed of regular humans.
It is the first discoverer, first responder to the Corrosion phenomenon,
and the first line of defense for ordinary humans against Corrosion.]]
  },
  [17477] = {
    ID = 17477,
    CnID = "加载界面提示@27",
    BaseSortID = 27,
    LoadingTips = "LoadingTips_17477_LoadingTips|「欢迎来到谷仓——这里拥有最多的档案柜，和最少的葬礼。」\nCMT档案和记录局因其谐音性质，又被审查会的人戏称为「谷仓」。",
    LoadingTips_TW = "「歡迎來到穀倉——這裡擁有最多的檔案櫃，和最少的葬禮。」\nCMT檔案和記錄局因其諧音性質，又被審查會的人戲稱為「穀倉」。",
    LoadingTips_EN = "「Welcome to the Barn - home of the most file cabinets and the fewest funerals.」\nThe CMT Archive and Records Bureau is also nicknamed 「The Barn」 because of this homophonic association."
  },
  [17478] = {
    ID = 17478,
    CnID = "加载界面提示@28",
    BaseSortID = 28,
    LoadingTips = "LoadingTips_17478_LoadingTips|雕塑家协会的成员有时会自称「皮格马利翁」，他们的组织标志亦是一把刻刀。",
    LoadingTips_TW = "雕塑家協會的成員有時會自稱「皮格馬利翁」，他們的組織標誌亦是一把刻刀。",
    LoadingTips_EN = "Members of the Sculptors' Association sometimes call themselves 「Pygmalions」, and the emblem of their organization is a chisel."
  },
  [17479] = {
    ID = 17479,
    CnID = "加载界面提示@29",
    BaseSortID = 29,
    LoadingTips = "LoadingTips_17479_LoadingTips|融蚀不为世俗所认知，但在某些隐秘的结社中，人们坚信融蚀并非灾难，而是神明的赐福。",
    LoadingTips_TW = "融蝕不為世俗所認知，但在某些隱秘的結社中，人們堅信融蝕並非災難，而是神明的賜福。",
    LoadingTips_EN = "Corrosion is unknown to the secular world, but in some secret societies, people believe that Corrosion is not a disaster but a blessing from the gods."
  },
  [17503] = {
    ID = 17503,
    CnID = "加载界面提示@30",
    BaseSortID = 30,
    LoadingTips = "LoadingTips_17503_LoadingTips|「誓以剑刃刺穿黑暗。」\n密斯底亚协定审查会成员的常用祝语，蕴含了审查会成员与融蚀抗争的坚定决心。",
    LoadingTips_TW = "「誓以劍刃刺穿黑暗。」\n密斯底亞協定審查會成員的常用祝語，蘊含了審查會成員與融蝕抗爭的堅定決心。",
    LoadingTips_EN = "「Swear to pierce the darkness with the blade.」\nThis is a common blessing among members of the Misdia Agreement Review Board, embodying their firm resolve in the struggle against Corrosion."
  },
  [17502] = {
    ID = 17502,
    CnID = "加载界面提示@31",
    BaseSortID = 31,
    LoadingTips = "LoadingTips_17502_LoadingTips|「愿银钥指引前路。」\n弥萨格大学成员们的常用祝语，蕴含了弥萨格人一往无前的信念。",
    LoadingTips_TW = "「願銀鑰指引前路。」\n彌薩格大學成員們的常用祝語，蘊含了彌薩格人一往無前的信念。",
    LoadingTips_EN = "「May the Silver Key guide the way.」\nThis is a common blessing among members of Misagga University, embodying the unwavering belief of the Misagga."
  },
  [17501] = {
    ID = 17501,
    CnID = "加载界面提示@32",
    BaseSortID = 32,
    LoadingTips = "LoadingTips_17501_LoadingTips|315年前，一场浩大的灾难席卷全球。\n人们以灾难发生的这一年为元年，开启了一个新的纪年——洪积。",
    LoadingTips_TW = "315年前，一場浩大的災難席捲全球。\n人們以災難發生的這一年為元年，開啟了一個新的紀年——洪積。",
    LoadingTips_EN = "315 years ago, a great disaster swept the globe.\nPeople used the year of the disaster as the first year, starting a new era called 「Diluvium」."
  },
  [17499] = {
    ID = 17499,
    CnID = "加载界面提示@34",
    BaseSortID = 33,
    LoadingTips = "LoadingTips_17499_LoadingTips|弥萨格大学前身，弥萨格学院，于洪积90年10月16日，由华德·菲利普斯及另两位创始人一同建立。",
    LoadingTips_TW = "彌薩格大學前身，彌薩格學院，于洪積90年10月16日，由華德·菲力浦斯及另兩位創始人一同建立。",
    LoadingTips_EN = "Misagga Academy, the predecessor of Misagga University, was founded on October 16, in the 90th year of the Diluvium Era, by Ward Phillips and two other founders."
  },
  [17498] = {
    ID = 17498,
    CnID = "加载界面提示@35",
    BaseSortID = 34,
    LoadingTips = "LoadingTips_17498_LoadingTips|弥萨格大学，建立于洪积187年10月16日，是一所致力于研究融蚀、对抗融蚀的高等学府。",
    LoadingTips_TW = "彌薩格大學，建立于洪積187年10月16日，是一所致力於研究融蝕、對抗融蝕的高等學府。",
    LoadingTips_EN = "Misagga University, established on October 16, in the 187th year of the Diluvium Era, is a higher institution dedicated to researching and combating Corrosion."
  },
  [17497] = {
    ID = 17497,
    CnID = "加载界面提示@36",
    BaseSortID = 35,
    LoadingTips = "LoadingTips_17497_LoadingTips|唤醒体由银芯强行从精神维度抓取精神碎片并固定而来，而精神碎片受到精神维度的影响。因此，所有唤醒体被唤醒后都天然处于癫狂状态，直到有调查员、守密人与其建立链接。",
    LoadingTips_TW = "喚醒體是由銀芯強行從精神維度抓取精神碎片並固定而來，而精神碎片受到精神維度的影響。因此，所有喚醒體被喚醒後都天然處於癲狂狀態，直到有調查員、守密人與其建立連結。",
    LoadingTips_EN = "The Awakening Body is forcibly grabbed from the spiritual dimension and fixed by the Silver Core. Due to the influence of the spiritual dimension, all Awakening Bodies naturally remain in a state of madness until an investigator or Secret Keeper establishes a link with them."
  },
  [17496] = {
    ID = 17496,
    CnID = "加载界面提示@37",
    BaseSortID = 36,
    LoadingTips = "LoadingTips_17496_LoadingTips|唤醒仪式中，调查员、守密人会使用银钥匙增强银芯与精神维度的联系。\n利用这一联系，调查员、守密人能抓取游荡在精神维度中的精神碎片，并将其固定在银芯之中。",
    LoadingTips_TW = "喚醒儀式中，調查員、守密人會使用銀鑰匙增強銀芯與精神維度的聯繫。\n利用這一聯繫，調查員、守密人能抓取遊蕩在精神維度中的精神碎片，並將其固定在銀芯之中。",
    LoadingTips_EN = [[
During the Awakening Ritual, investigators or Secret Keepers will use the Silver Key to enhance the connection between the Silver Core and the spiritual dimension.
Using this connection, investigators or Secret Keepers can grasp wandering spirit fragments in the spiritual dimension and fix them within the Silver Core.]]
  },
  [17508] = {
    ID = 17508,
    CnID = "加载界面提示@38",
    BaseSortID = 37,
    LoadingTips = "LoadingTips_17508_LoadingTips|严格意义上来说，唤醒体也是银芯科技的一种。",
    LoadingTips_TW = "嚴格意義上來說，喚醒體也是銀芯科技的一種。",
    LoadingTips_EN = "Strictly speaking, the Awakening Body is also a type of Silver Core technology."
  },
  [17507] = {
    ID = 17507,
    CnID = "加载界面提示@39",
    BaseSortID = 38,
    LoadingTips = "LoadingTips_17507_LoadingTips|所有唤醒体的唤醒都需要符合《密斯底亚协定》的相关规定，唤醒后也需要进行登记。",
    LoadingTips_TW = "所有喚醒體的喚醒都需要符合《密斯底亞協定》的相關規定，喚醒後也需要進行登記。",
    LoadingTips_EN = "All awakenings of Awakening Bodies must comply with the relevant provisions of the 「Misdia Agreement」, and must be registered after awakening."
  },
  [17490] = {
    ID = 17490,
    CnID = "加载界面提示@40",
    BaseSortID = 39,
    LoadingTips = "LoadingTips_17490_LoadingTips|诺斯指数是测量精神碎片在银芯中的稳定性的数值。\n数值越高的唤醒体，失控的可能性越低，失控后可能造成的伤亡也越少。",
    LoadingTips_TW = "諾斯指數是測量精神碎片在銀芯中的穩定性的數值。\n數值越高的喚醒體，失控的可能性越低，失控後可能造成的傷亡也越少。",
    LoadingTips_EN = [[
The Norse Index measures the stability of spirit fragments within the Silver Core.
The higher the value, the lower the likelihood of the Awakening Body losing control and the fewer casualties it might cause if it does.]]
  },
  [17488] = {
    ID = 17488,
    CnID = "加载界面提示@41",
    BaseSortID = 40,
    LoadingTips = "LoadingTips_17488_LoadingTips|同一界域中的不同唤醒体能够更好地配合彼此，不同界域之间可能存在一定的排斥。\n仅有混沌界域不存在此现象。",
    LoadingTips_TW = "同一界域中的不同喚醒體能夠更好地配合彼此，不同界域之間可能存在一定的排斥。\n僅有混沌界域不存在此現象。",
    LoadingTips_EN = [[
Different Awakening Bodies within the same domain can better cooperate with each other, while there may be repulsion between different domains.
Only the Chaos Domain does not exhibit this phenomenon.]]
  },
  [17485] = {
    ID = 17485,
    CnID = "加载界面提示@42",
    BaseSortID = 41,
    LoadingTips = "LoadingTips_17485_LoadingTips|依照不同的特质，唤醒体大致被分为深海、血肉、超维及混沌四个界域。",
    LoadingTips_TW = "依照不同的特質，喚醒體大致被分為深海、血肉、超維及混沌四個界域。",
    LoadingTips_EN = "Based on different characteristics, Awakening Bodies are roughly categorized into the Deep Sea, Flesh, Hyperdimensional, and Chaos domains."
  },
  [17486] = {
    ID = 17486,
    CnID = "加载界面提示@43",
    BaseSortID = 42,
    LoadingTips = "LoadingTips_17486_LoadingTips|钥冢仪式后，调查员和守密人需与所搭档的唤醒体进行一次有教师监督的外勤任务，以确保具备日后独立执行外勤任务的能力。",
    LoadingTips_TW = "鑰塚儀式後，調查員和守密人需與所搭檔的喚醒體進行一次有教師監督的外勤任務，以確保具備日後獨立執行外勤任務的能力。",
    LoadingTips_EN = "After the Key Tomb Ceremony, investigators and Secret Keepers along with their partnered Awakening Bodies need to undertake a field task supervised by a teacher to ensure they are capable of independently handling future field tasks."
  },
  [17506] = {
    ID = 17506,
    CnID = "加载界面提示@44",
    BaseSortID = 43,
    LoadingTips = "LoadingTips_17506_LoadingTips|没有外勤任务时，调查员、守密人与其搭档唤醒体会在弥萨格大学内休养生息。\n他们都需要上课、参加考试，以及完成冗长的课余作业。",
    LoadingTips_TW = "沒有外勤任務時，調查員、守密人與其搭檔喚醒體會在彌薩格大學內休養生息。\n他們都需要上課、參加考試，以及完成冗長的課餘作業。",
    LoadingTips_EN = [[
When not on a field task, investigators and Secret Keepers along with their partnered Awakening Bodies will rest and recuperate within Misagga University.
They need to attend classes, take exams, and complete lengthy assignments.]]
  },
  [17465] = {
    ID = 17465,
    CnID = "加载界面提示@45",
    BaseSortID = 44,
    LoadingTips = "LoadingTips_17465_LoadingTips|同调率，即调查员、守密人与自己搭档的唤醒体的精神同调程度。\n同调率越高，调查员、守密人与唤醒体的了解越深，关系越密切，信任越牢固。",
    LoadingTips_TW = "同調率，即調查員、守密人與自己搭檔的喚醒體的精神同調程度。\n同調率越高，調查員、守密人與喚醒體的瞭解越深，關係越密切，信任越牢固。",
    LoadingTips_EN = [[
Sync Rate refers to the degree of mental synchronization between an investigator or Secret Keeper and their partnered Awakening Body.
The higher the sync rate, the deeper the understanding, the closer the relationship, and the stronger the trust between the investigator, Secret Keeper, and the Awakening Body.]]
  },
  [36765] = {
    ID = 36765,
    CnID = "加载界面提示@46",
    BaseSortID = 45,
    LoadingTips = "LoadingTips_36765_LoadingTips|融蚀浆是一种从融蚀痕中溢出的黑色黏液。\n和融蚀现象本身一样，不借助特殊器械，普通人无法直接对其进行观测。",
    LoadingTips_EN = [[
Corrosive Paste is a black viscous liquid that oozes from Corrosive marks.
Like the Corrosive phenomenon itself, ordinary people cannot observe it directly without special equipment.]]
  },
  [36766] = {
    ID = 36766,
    CnID = "加载界面提示@47",
    BaseSortID = 46,
    LoadingTips = "LoadingTips_36766_LoadingTips|某些融蚀体死后会化作的黑色粉末，被称为融蚀粉尘。",
    LoadingTips_EN = "Some Corrosive Bodies turn into black powder after death, known as Corrosive Dust."
  },
  [36772] = {
    ID = 36772,
    CnID = "加载界面提示@48",
    BaseSortID = 47,
    LoadingTips = "LoadingTips_36772_LoadingTips|根据融蚀裂隙的大小，大致可以将融蚀裂隙分为6类：C,B,A,S,SS,SSS。",
    LoadingTips_EN = "Based on the size of the Corrosive Fissure, they can be categorized into six types: C, B, A, S, SS, SSS."
  },
  [36756] = {
    ID = 36756,
    CnID = "加载界面提示@49",
    BaseSortID = 48,
    LoadingTips = "LoadingTips_36756_LoadingTips|依照裂隙的类型不同，一个裂隙可能具有一个或多个被称为「灾厄」的核心。",
    LoadingTips_EN = "Depending on the type of fissure, a fissure may have one or more cores called 「Disasters」."
  },
  [36778] = {
    ID = 36778,
    CnID = "加载界面提示@50",
    BaseSortID = 49,
    LoadingTips = "LoadingTips_36778_LoadingTips|融蚀裂隙的存在不需要依托具有实体的物件，天空、海洋等都是融蚀裂隙可能出现的场所。",
    LoadingTips_EN = "Corrosive Fissures do not need to depend on tangible objects to exist; places like the sky and ocean can also house Corrosive Fissures."
  },
  [36777] = {
    ID = 36777,
    CnID = "加载界面提示@51",
    BaseSortID = 50,
    LoadingTips = "LoadingTips_36777_LoadingTips|弥萨格大学是绝对中立的第三方，校内大小事宜皆由校长及各管理层人员共同商议决定，不受任何组织约束。",
    LoadingTips_EN = "Misagga University is a strictly neutral third party, and all matters within the school are jointly decided by the principal and management, not bound by any organization."
  },
  [36780] = {
    ID = 36780,
    CnID = "加载界面提示@52",
    BaseSortID = 51,
    LoadingTips = "LoadingTips_36780_LoadingTips|密斯底亚协定审查会是个非常庞大的组织。\n除了雷欧王国，它在亚格罗共和国、康斯坦联邦乃至勒姆瓦希帝国都设有分部。",
    LoadingTips_EN = [[
The Misdia Agreement Review Board is a very large organization.
Aside from the Leo Kingdom, it has branches in the Agro Republic, Constantin Federation, and even the Lemwae Empire.]]
  },
  [36779] = {
    ID = 36779,
    CnID = "加载界面提示@53",
    BaseSortID = 52,
    LoadingTips = "LoadingTips_36779_LoadingTips|提灯教会，一个隐秘而邪恶的宗教组织。似乎与雕塑家协会和蹈海者有很深的联系。",
    LoadingTips_EN = "The Lantern Church, a secret and evil religious organization. It seems to have strong ties with the Sculptors' Association and the Sea Walkers."
  },
  [36774] = {
    ID = 36774,
    CnID = "加载界面提示@54",
    BaseSortID = 53,
    LoadingTips = "LoadingTips_36774_LoadingTips|蹈海者，一个以弥利亚姆为首的古老宗教组织。\n他们苦心经营，只为复活他们唯一的神王。",
    LoadingTips_EN = [[
The Sea Walkers, an ancient religious organization led by Miriam.
They have painstakingly operated for a long time just to resurrect their one and only deity.]]
  },
  [36773] = {
    ID = 36773,
    CnID = "加载界面提示@55",
    BaseSortID = 54,
    LoadingTips = "LoadingTips_36773_LoadingTips|雕塑家协会，一个沉迷于罪恶的人体实验的极端组织。由弥萨格的叛徒罗伯特·罗森塔尔一手创办。",
    LoadingTips_EN = "The Sculptors' Association, an extreme organization obsessed with evil human experiments. It was founded by Misagga's traitor, Robert Rosenthal."
  },
  [36776] = {
    ID = 36776,
    CnID = "加载界面提示@56",
    BaseSortID = 55,
    LoadingTips = "LoadingTips_36776_LoadingTips|密境（Domain）是介于精神维度和现实维度之间的特殊维度，是人类能够肉身进入的最接近精神维度的空间。",
    LoadingTips_EN = "The Secret Realm (Domain) is a special dimension between the spiritual and physical dimensions, and the closest space humans can physically enter to the spiritual dimension."
  },
  [36775] = {
    ID = 36775,
    CnID = "加载界面提示@57",
    BaseSortID = 56,
    LoadingTips = "LoadingTips_36775_LoadingTips|不同区域的密境在调查时能收集到的事物也不同，即使是看似相同的事物，也可能具有非常不同的本质。",
    LoadingTips_EN = "Different regions of the Secret Realm can yield different items during investigation, and even seemingly identical items may have fundamentally different natures."
  },
  [36769] = {
    ID = 36769,
    CnID = "加载界面提示@58",
    BaseSortID = 57,
    LoadingTips = "LoadingTips_36769_LoadingTips|密境中，情感、思绪、思维、执念等都可能具有可观测的投影。\n这些投影一般不可触碰，或者一触即散，是精神维度对现实维度个体的感官的欺骗。",
    LoadingTips_EN = [[
In the Secret Realm, emotions, thoughts, obsessions, etc., may have observable projections.
These projections are generally intangible or disperse upon touch, misleading the sensory perceptions of individuals from the physical dimension.]]
  },
  [36771] = {
    ID = 36771,
    CnID = "加载界面提示@59",
    BaseSortID = 58,
    LoadingTips = "LoadingTips_36771_LoadingTips|一些特殊的投影能被灵知转印器捕捉，并附着在指令卡上，使唤醒体获得增益。这些投影被称为刻印（Orison）。",
    LoadingTips_EN = "Some special projections can be captured by the Spirit Transfer Device and attached to Command Cards, providing benefits to the Awakening Body. These projections are known as Orisons."
  },
  [36761] = {
    ID = 36761,
    CnID = "加载界面提示@60",
    BaseSortID = 59,
    LoadingTips = "LoadingTips_36761_LoadingTips|借助仪器和银芯的帮助暂时独立出来的，不受其他精神影响，也不受现实维度影响的特殊空间，被称为人工密境（Artificial Domain）。",
    LoadingTips_EN = "Artificial Domains are special spaces temporarily isolated from other spiritual influences and the physical dimension through instruments and Silver Cores."
  },
  [36762] = {
    ID = 36762,
    CnID = "加载界面提示@61",
    BaseSortID = 60,
    LoadingTips = "LoadingTips_36762_LoadingTips|通过电梯，可以抵达弥萨格地下空间。\n除了伦蒂尼恩最大的L-01号裂隙“黑池”外，这里还有各类限制区域，需要一定安全等级才能进入。",
    LoadingTips_EN = "Using an elevator, you can reach the underground space of Misagga.\nApart from the largest Rift in Londinium, the L-01 「Black Pool」, there are various restricted areas requiring certain safety levels to enter."
  },
  [36763] = {
    ID = 36763,
    CnID = "加载界面提示@62",
    BaseSortID = 61,
    LoadingTips = "LoadingTips_36763_LoadingTips|由于银钥匙与精神维度之间存在一定关联，在靠近精神异常的个体时，银钥匙可能会产生特殊反应。",
    LoadingTips_EN = "Due to the association between Silver Keys and the spiritual dimension, Silver Keys may react in special ways when near individuals with spiritual abnormalities."
  },
  [36764] = {
    ID = 36764,
    CnID = "加载界面提示@63",
    BaseSortID = 62,
    LoadingTips = "LoadingTips_36764_LoadingTips|密契，即使用特殊方法记录到含有银芯的材料上的神秘符文。\n不同密契能够提供的助力不同，同一系列的密契可以带来更多的助力。",
    LoadingTips_EN = [[
Micia, mysterious runes recorded on materials containing Silver Cores using special methods.
Different Micias provide different assistance, and a series of Micias can offer more help.]]
  },
  [36757] = {
    ID = 36757,
    CnID = "加载界面提示@64",
    BaseSortID = 63,
    LoadingTips = "LoadingTips_36757_LoadingTips|弥萨格在《调查员精神构成与其潜力》的理论基础上发展、完善并定制了一系列筛选流程，以尽可能多地在不惊动普罗大众的前提下发掘潜在调查员。",
    LoadingTips_EN = "Building on the theory of 「Investigator Mental Composition and Potential」, Misagga has developed and perfected a series of screening processes to uncover potential investigators without alarming the general public."
  },
  [36758] = {
    ID = 36758,
    CnID = "加载界面提示@65",
    BaseSortID = 64,
    LoadingTips = "LoadingTips_36758_LoadingTips|每个人的精神不同，每个守密人的特殊能力也不尽相同。\n目前已知的能力有：共享记忆、共享情感、感知情绪等。",
    LoadingTips_EN = [[
Each person's spirit is different, and each Guardian's special abilities vary.
Currently known abilities include shared memory, shared emotions, sensing moods, etc.]]
  },
  [36759] = {
    ID = 36759,
    CnID = "加载界面提示@66",
    BaseSortID = 65,
    LoadingTips = "LoadingTips_36759_LoadingTips|315年前，一场大洪水席卷了世界。秩序崩溃，城市倾塌，海底的高山骤然隆起，形成新的陆地。",
    LoadingTips_EN = "315 years ago, a great flood swept the world. Order collapsed, cities fell, and underwater mountains suddenly rose to form new land."
  },
  [36760] = {
    ID = 36760,
    CnID = "加载界面提示@67",
    BaseSortID = 66,
    LoadingTips = "LoadingTips_36760_LoadingTips|雷欧坊，雷欧王国的通用货币。市面上还流通着以缅、片什为主的辅币。1雷欧坊等于10缅，1缅等于10片什。",
    LoadingTips_EN = "Leofan, the common currency of the Leo Kingdom. Supporting currencies include the Menn and the Sheth. 1 Leofan equals 10 Menn, and 1 Menn equals 10 Sheth."
  },
  [36767] = {
    ID = 36767,
    CnID = "加载界面提示@68",
    BaseSortID = 67,
    LoadingTips = "LoadingTips_36767_LoadingTips|雷欧王国位于亚特兰大洋东侧，与康斯坦联邦、常青联盟接壤。\n王国面积不大，但国力强盛，是洪积后最早完成重建的国家之一。",
    LoadingTips_EN = [[
The Leo Kingdom is located on the eastern side of the Atlantic Ocean, bordering the Constanta Federation and the Evergreen League.
The kingdom is not large in area but very powerful and was one of the earliest countries to complete reconstruction after the Deluge.]]
  },
  [36768] = {
    ID = 36768,
    CnID = "加载界面提示@69",
    BaseSortID = 68,
    LoadingTips = "LoadingTips_36768_LoadingTips|亚格罗共和国位于亚特兰大洋西侧，四面环海，腹地辽阔。\n亚格罗共和国工业与金融业十分发达，其金融中心城市弗莱彻更是无数人向往的繁华之地。",
    LoadingTips_EN = [[
The Agro Republic is located on the western side of the Atlantic Ocean, surrounded by the sea and vast inland.
Agro Republic has highly developed industries and finance, with its financial hub Fletchers being a place many aspire to.]]
  },
  [36770] = {
    ID = 36770,
    CnID = "加载界面提示@70",
    BaseSortID = 69,
    LoadingTips = "LoadingTips_36770_LoadingTips|康斯坦联邦位于东劳拉西亚大陆，是一个由数个小国组合而成的联邦。在联邦中，艺术是所有人一致的追求。",
    LoadingTips_EN = "The Constanta Federation is located on the eastern Laurasia continent, a federation of several small countries. In the federation, art is everyone's unanimous pursuit."
  }
})
return LoadingTips
