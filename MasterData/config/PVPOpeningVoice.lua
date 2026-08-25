local System = require("System.System")
local readonly = System.readonly
local PVPOpeningVoice = readonly({
  [100050] = {
    ID = 100050,
    CnID = "语音@知者普通开场",
    BaseSortID = 1,
    AwakerID = 15595,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100050_AwakerVoiceContent|我将以推演辨明前路。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99852] = {
    ID = 99852,
    CnID = "语音@知者关系对话1",
    BaseSortID = 2,
    AwakerID = 15595,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99852_AwakerVoiceContent|和朵尔老师对战，就像回到了调查员特训课堂上一样。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15570,
    ReletedVoiceID = 100223,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100080] = {
    ID = 100080,
    CnID = "语音@知者关系对话2",
    BaseSortID = 3,
    AwakerID = 15595,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100080_AwakerVoiceContent|守护搭档的意志，我不会输给你。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15568,
    ReletedVoiceID = 100039,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99906] = {
    ID = 99906,
    CnID = "语音@知者关系对话3",
    BaseSortID = 4,
    AwakerID = 15595,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99906_AwakerVoiceContent|你那套诱骗他人的方法，对我不起作用。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15596,
    ReletedVoiceID = 100120,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100056] = {
    ID = 100056,
    CnID = "语音@知者关系对话4",
    BaseSortID = 5,
    AwakerID = 15595,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100056_AwakerVoiceContent|詹金同学，看这个样子，想必唤醒体战斗技巧课的作业你都没有做吧？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15593,
    ReletedVoiceID = 99744,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100088] = {
    ID = 100088,
    CnID = "语音@知者关系对话5",
    BaseSortID = 6,
    AwakerID = 15595,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100088_AwakerVoiceContent|不劳您费心，我自会保护守密人直到最后一秒。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77913,
    ReletedVoiceID = 99856,
    FollowUpVoice = 0,
    Sort = 6
  },
  [100210] = {
    ID = 100210,
    CnID = "语音@知者思考",
    BaseSortID = 7,
    AwakerID = 15595,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100210_AwakerVoiceContent|要考虑所有细节……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [100090] = {
    ID = 100090,
    CnID = "语音@知者催促",
    BaseSortID = 8,
    AwakerID = 15595,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100090_AwakerVoiceContent|想不出应对的办法了吗？",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99805] = {
    ID = 99805,
    CnID = "语音@知者必杀",
    BaseSortID = 9,
    AwakerID = 15595,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99805_AwakerVoiceContent|这是计划的最后一步！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100192] = {
    ID = 100192,
    CnID = "语音@知者错误",
    BaseSortID = 10,
    AwakerID = 15595,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100192_AwakerVoiceContent|方案需要重新修订……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100028] = {
    ID = 100028,
    CnID = "语音@知者死亡",
    BaseSortID = 11,
    AwakerID = 15595,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100028_AwakerVoiceContent|策略失败，下次要调整方案了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99799] = {
    ID = 99799,
    CnID = "语音@本源知者普通开场",
    BaseSortID = 12,
    AwakerID = 15568,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99799_AwakerVoiceContent|只要你呼唤我，我一直都在。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100039] = {
    ID = 100039,
    CnID = "语音@本源知者关系对话1",
    BaseSortID = 13,
    AwakerID = 15568,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100039_AwakerVoiceContent|我无意竞争，但如果你执意想证明什么，请吧，另一个我。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15595,
    ReletedVoiceID = 100080,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99994] = {
    ID = 99994,
    CnID = "语音@本源知者关系对话2",
    BaseSortID = 14,
    AwakerID = 15568,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99994_AwakerVoiceContent|和萝坦切磋吗，真是……令人怀念的感觉。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15569,
    ReletedVoiceID = 100132,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99789] = {
    ID = 99789,
    CnID = "语音@本源知者关系对话3",
    BaseSortID = 15,
    AwakerID = 15568,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99789_AwakerVoiceContent|在我的意识消失之前，我会守护守密人到最后一刻。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54116,
    ReletedVoiceID = 99845,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100196] = {
    ID = 100196,
    CnID = "语音@本源知者关系对话4",
    BaseSortID = 16,
    AwakerID = 15568,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100196_AwakerVoiceContent|没想到朵尔老师会变成这样，命运真是无常……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15602,
    ReletedVoiceID = 99934,
    FollowUpVoice = 1,
    Sort = 5
  },
  [99865] = {
    ID = 99865,
    CnID = "语音@本源知者思考",
    BaseSortID = 17,
    AwakerID = 15568,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99865_AwakerVoiceContent|这样么，我会想出万全的办法……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99988] = {
    ID = 99988,
    CnID = "语音@本源知者催促",
    BaseSortID = 18,
    AwakerID = 15568,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99988_AwakerVoiceContent|速战速决！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99888] = {
    ID = 99888,
    CnID = "语音@本源知者必杀",
    BaseSortID = 19,
    AwakerID = 15568,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99888_AwakerVoiceContent|这一剑，通往胜利的未来！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99812] = {
    ID = 99812,
    CnID = "语音@本源知者错误",
    BaseSortID = 20,
    AwakerID = 15568,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99812_AwakerVoiceContent|怎么会……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100051] = {
    ID = 100051,
    CnID = "语音@本源知者死亡",
    BaseSortID = 21,
    AwakerID = 15568,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100051_AwakerVoiceContent|没能，守护你……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99782] = {
    ID = 99782,
    CnID = "语音@缸中之脑普通开场",
    BaseSortID = 22,
    AwakerID = 15570,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99782_AwakerVoiceContent|这次战斗最好值得我的出勤。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100223] = {
    ID = 100223,
    CnID = "语音@缸中之脑关系对话1",
    BaseSortID = 23,
    AwakerID = 15570,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100223_AwakerVoiceContent|那就让我检查一下你的训练情况吧，优等生。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15595,
    ReletedVoiceID = 99852,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100114] = {
    ID = 100114,
    CnID = "语音@缸中之脑关系对话2",
    BaseSortID = 24,
    AwakerID = 15570,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100114_AwakerVoiceContent|与智之质体的战斗，能否获悉未知的奥秘，我很期待。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54116,
    ReletedVoiceID = 100154,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100081] = {
    ID = 100081,
    CnID = "语音@缸中之脑关系对话3",
    BaseSortID = 25,
    AwakerID = 15570,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100081_AwakerVoiceContent|看到你我才明白自己的傲慢，对知识过于贪婪，无异于玩火自焚。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15602,
    ReletedVoiceID = 99825,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99840] = {
    ID = 99840,
    CnID = "语音@缸中之脑关系对话4",
    BaseSortID = 26,
    AwakerID = 15570,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99840_AwakerVoiceContent|这样强度的战斗反馈，似乎可以用来升级艾瑞卡的战斗系统。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15603,
    ReletedVoiceID = 99838,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100093] = {
    ID = 100093,
    CnID = "语音@缸中之脑思考",
    BaseSortID = 27,
    AwakerID = 15570,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100093_AwakerVoiceContent|有意思的状况……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100077] = {
    ID = 100077,
    CnID = "语音@缸中之脑催促",
    BaseSortID = 28,
    AwakerID = 15570,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100077_AwakerVoiceContent|浪费天才的时间是一种犯罪。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99834] = {
    ID = 99834,
    CnID = "语音@缸中之脑必杀",
    BaseSortID = 29,
    AwakerID = 15570,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99834_AwakerVoiceContent|就这样结束吧。",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100220] = {
    ID = 100220,
    CnID = "语音@缸中之脑错误",
    BaseSortID = 30,
    AwakerID = 15570,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100220_AwakerVoiceContent|判断失误了吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100062] = {
    ID = 100062,
    CnID = "语音@缸中之脑死亡",
    BaseSortID = 31,
    AwakerID = 15570,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100062_AwakerVoiceContent|出人意料的展开，值得研究……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100086] = {
    ID = 100086,
    CnID = "语音@本源缸中之脑普通开场",
    BaseSortID = 32,
    AwakerID = 15602,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100086_AwakerVoiceContent|放心，我会带来最高效的死亡。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99934] = {
    ID = 99934,
    CnID = "语音@本源缸中之脑关系对话1",
    BaseSortID = 33,
    AwakerID = 15602,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99934_AwakerVoiceContent|我们的优等生倒是一成不变的无趣呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15568,
    ReletedVoiceID = 100196,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99825] = {
    ID = 99825,
    CnID = "语音@本源缸中之脑关系对话2",
    BaseSortID = 34,
    AwakerID = 15602,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99825_AwakerVoiceContent|我现在倒是开始理解血链·希洛那家伙的心情了，看到如此天真的自己，真是有些可笑。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15570,
    ReletedVoiceID = 100081,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100172] = {
    ID = 100172,
    CnID = "语音@本源缸中之脑关系对话3",
    BaseSortID = 35,
    AwakerID = 15602,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100172_AwakerVoiceContent|我对你那毁灭一切的态度十分欣赏，不过你的效率实在低下，不如加入我的计划如何？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15567,
    ReletedVoiceID = 99945,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99948] = {
    ID = 99948,
    CnID = "语音@本源缸中之脑关系对话4",
    BaseSortID = 36,
    AwakerID = 15602,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99948_AwakerVoiceContent|连你这样畏畏缩缩的家伙，也有能拼命的时候嘛。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15579,
    ReletedVoiceID = 99749,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100010] = {
    ID = 100010,
    CnID = "语音@本源缸中之脑思考",
    BaseSortID = 37,
    AwakerID = 15602,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100010_AwakerVoiceContent|这次该如何催化毁灭呢？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99896] = {
    ID = 99896,
    CnID = "语音@本源缸中之脑催促",
    BaseSortID = 38,
    AwakerID = 15602,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99896_AwakerVoiceContent|无知者的反抗，令人厌烦。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100053] = {
    ID = 100053,
    CnID = "语音@本源缸中之脑必杀",
    BaseSortID = 39,
    AwakerID = 15602,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100053_AwakerVoiceContent|挣扎就到此为止吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100071] = {
    ID = 100071,
    CnID = "语音@本源缸中之脑错误",
    BaseSortID = 40,
    AwakerID = 15602,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100071_AwakerVoiceContent|竟然与实验预期不符？",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100075] = {
    ID = 100075,
    CnID = "语音@本源缸中之脑死亡",
    BaseSortID = 41,
    AwakerID = 15602,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100075_AwakerVoiceContent|哼，侥幸的运气罢了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100221] = {
    ID = 100221,
    CnID = "语音@美德骑士普通开场",
    BaseSortID = 42,
    AwakerID = 15585,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100221_AwakerVoiceContent|以骑士之名，恳请指教！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99928] = {
    ID = 99928,
    CnID = "语音@美德骑士关系对话1",
    BaseSortID = 43,
    AwakerID = 15585,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99928_AwakerVoiceContent|明白，艾尔瓦教官！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15588,
    ReletedVoiceID = 99763,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99916] = {
    ID = 99916,
    CnID = "语音@美德骑士关系对话2",
    BaseSortID = 44,
    AwakerID = 15585,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99916_AwakerVoiceContent|我……主君说过，可以忽略潘狄娅女士的发言，得罪了！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15560,
    ReletedVoiceID = 100040,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99910] = {
    ID = 99910,
    CnID = "语音@美德骑士关系对话3",
    BaseSortID = 45,
    AwakerID = 15585,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99910_AwakerVoiceContent|没事的艾继丝，这是正常的训练，请放心战斗吧！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15591,
    ReletedVoiceID = 99854,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99955] = {
    ID = 99955,
    CnID = "语音@美德骑士关系对话4",
    BaseSortID = 46,
    AwakerID = 15585,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99955_AwakerVoiceContent|谢……谢谢24小姐！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15601,
    ReletedVoiceID = 100145,
    FollowUpVoice = 0,
    Sort = 5
  },
  [120244] = {
    ID = 120244,
    CnID = "语音@美德骑士关系对话5",
    BaseSortID = 47,
    AwakerID = 15585,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120244_AwakerVoiceContent|你想要在钥冢中挖掘尸体作为模特？我会阻止你的！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77926,
    ReletedVoiceID = 120270,
    FollowUpVoice = 1,
    Sort = 6
  },
  [150091] = {
    ID = 150091,
    CnID = "语音@美德骑士关系对话6",
    BaseSortID = 48,
    AwakerID = 15585,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150091_AwakerVoiceContent|抱歉……只有放弃守护同伴这件事，绝对不行。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77921,
    ReletedVoiceID = 150095,
    FollowUpVoice = 1,
    Sort = 7
  },
  [100105] = {
    ID = 100105,
    CnID = "语音@美德骑士思考",
    BaseSortID = 49,
    AwakerID = 15585,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100105_AwakerVoiceContent|嗯……快想一想，成熟的骑士会怎么做……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [99989] = {
    ID = 99989,
    CnID = "语音@美德骑士催促",
    BaseSortID = 50,
    AwakerID = 15585,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99989_AwakerVoiceContent|没关系，我会等待您的出手！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99801] = {
    ID = 99801,
    CnID = "语音@美德骑士必杀",
    BaseSortID = 51,
    AwakerID = 15585,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99801_AwakerVoiceContent|请注意，我将使出全力！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99908] = {
    ID = 99908,
    CnID = "语音@美德骑士错误",
    BaseSortID = 52,
    AwakerID = 15585,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99908_AwakerVoiceContent|这招式不管用吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [99810] = {
    ID = 99810,
    CnID = "语音@美德骑士死亡",
    BaseSortID = 53,
    AwakerID = 15585,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99810_AwakerVoiceContent|真是令人敬佩的对手……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [99781] = {
    ID = 99781,
    CnID = "语音@鲸跃普通开场",
    BaseSortID = 54,
    AwakerID = 15569,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99781_AwakerVoiceContent|又到了我最喜欢的时候，要不要多打两场？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100132] = {
    ID = 100132,
    CnID = "语音@鲸跃关系对话1",
    BaseSortID = 55,
    AwakerID = 15569,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100132_AwakerVoiceContent|咦？剑术变得很不一样的拉蒙娜，有意思，来过两招！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15568,
    ReletedVoiceID = 99994,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100158] = {
    ID = 100158,
    CnID = "语音@鲸跃关系对话2",
    BaseSortID = 56,
    AwakerID = 15569,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100158_AwakerVoiceContent|又见面了，战士，让我试试你的长进！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15587,
    ReletedVoiceID = 100180,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100031] = {
    ID = 100031,
    CnID = "语音@鲸跃关系对话3",
    BaseSortID = 57,
    AwakerID = 15569,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100031_AwakerVoiceContent|不够不够不够！不是说巨人的力量吗？给我全都使出来啊！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15564,
    ReletedVoiceID = 99991,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99924] = {
    ID = 99924,
    CnID = "语音@鲸跃关系对话4",
    BaseSortID = 58,
    AwakerID = 15569,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99924_AwakerVoiceContent|难得碰到一个痛快的对手！再来！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15598,
    ReletedVoiceID = 100123,
    FollowUpVoice = 1,
    Sort = 5
  },
  [131816] = {
    ID = 131816,
    CnID = "语音@鲸跃关系对话5",
    BaseSortID = 59,
    AwakerID = 15569,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131816_AwakerVoiceContent|想打架？来吧，打个痛快！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130901,
    ReletedVoiceID = 131818,
    FollowUpVoice = 1,
    Sort = 6
  },
  [147590] = {
    ID = 147590,
    CnID = "语音@鲸跃关系对话6",
    BaseSortID = 60,
    AwakerID = 15569,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_147590_AwakerVoiceContent|战斗就只是战斗。纯粹战士之间的对决，我已期待了太久。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 145363,
    ReletedVoiceID = 147591,
    FollowUpVoice = 1,
    Sort = 7
  },
  [100150] = {
    ID = 100150,
    CnID = "语音@鲸跃思考",
    BaseSortID = 61,
    AwakerID = 15569,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100150_AwakerVoiceContent|我只是在想，一会儿该用什么姿势把你打飞！",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [100023] = {
    ID = 100023,
    CnID = "语音@鲸跃催促",
    BaseSortID = 62,
    AwakerID = 15569,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100023_AwakerVoiceContent|怎么，这就怕了吗？",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [100155] = {
    ID = 100155,
    CnID = "语音@鲸跃必杀",
    BaseSortID = 63,
    AwakerID = 15569,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100155_AwakerVoiceContent|准备认输吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99891] = {
    ID = 99891,
    CnID = "语音@鲸跃错误",
    BaseSortID = 64,
    AwakerID = 15569,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99891_AwakerVoiceContent|啧，失手了吗。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [100067] = {
    ID = 100067,
    CnID = "语音@鲸跃死亡",
    BaseSortID = 65,
    AwakerID = 15569,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100067_AwakerVoiceContent|痛快……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [99754] = {
    ID = 99754,
    CnID = "语音@24普通开场",
    BaseSortID = 66,
    AwakerID = 15601,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99754_AwakerVoiceContent|我们……会一起努力的！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100145] = {
    ID = 100145,
    CnID = "语音@24关系对话1",
    BaseSortID = 67,
    AwakerID = 15601,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100145_AwakerVoiceContent|奥吉尔明明比詹金还要小上一些，真是沉稳又可靠呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15585,
    ReletedVoiceID = 99955,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100095] = {
    ID = 100095,
    CnID = "语音@24关系对话2",
    BaseSortID = 68,
    AwakerID = 15601,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100095_AwakerVoiceContent|哎呀，詹金，你的衣服什么时候又磨破了，快拿来让我补一补。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15593,
    ReletedVoiceID = 99878,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100217] = {
    ID = 100217,
    CnID = "语音@24关系对话3",
    BaseSortID = 69,
    AwakerID = 15601,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100217_AwakerVoiceContent|宁菲亚小姐的疗养院中，也有很多像我这样的人吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15580,
    ReletedVoiceID = 100064,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100111] = {
    ID = 100111,
    CnID = "语音@24关系对话4",
    BaseSortID = 70,
    AwakerID = 15601,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100111_AwakerVoiceContent|没关系的艾继丝，你和詹金一样，叫我姐姐就好。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15591,
    ReletedVoiceID = 100007,
    FollowUpVoice = 0,
    Sort = 5
  },
  [99909] = {
    ID = 99909,
    CnID = "语音@24思考",
    BaseSortID = 71,
    AwakerID = 15601,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99909_AwakerVoiceContent|嗯……好像有些复杂，没关系，和其他的我一起商量吧。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100195] = {
    ID = 100195,
    CnID = "语音@24催促",
    BaseSortID = 72,
    AwakerID = 15601,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100195_AwakerVoiceContent|我的出场时间有限，不要挑战我的耐心啊。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99794] = {
    ID = 99794,
    CnID = "语音@24必杀",
    BaseSortID = 73,
    AwakerID = 15601,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99794_AwakerVoiceContent|一起——给我一起消失吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99917] = {
    ID = 99917,
    CnID = "语音@24错误",
    BaseSortID = 74,
    AwakerID = 15601,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99917_AwakerVoiceContent|呃……这样不对……不……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99984] = {
    ID = 99984,
    CnID = "语音@24死亡",
    BaseSortID = 75,
    AwakerID = 15601,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99984_AwakerVoiceContent|噫，这是什么感觉，我要死了吗？詹金……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100162] = {
    ID = 100162,
    CnID = "语音@鹦鹉螺普通开场",
    BaseSortID = 76,
    AwakerID = 15565,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100162_AwakerVoiceContent|诶？这是哪里？是新的冒险吗？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99951] = {
    ID = 99951,
    CnID = "语音@鹦鹉螺关系对话1",
    BaseSortID = 77,
    AwakerID = 15565,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99951_AwakerVoiceContent|好神奇的机械结构，真想拆开研究一下啊。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15603,
    ReletedVoiceID = 99882,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99747] = {
    ID = 99747,
    CnID = "语音@鹦鹉螺关系对话2",
    BaseSortID = 78,
    AwakerID = 15565,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99747_AwakerVoiceContent|我记得你，好久不见！你的伤腿是不是又该保养了？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15588,
    ReletedVoiceID = 100012,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99816] = {
    ID = 99816,
    CnID = "语音@鹦鹉螺关系对话3",
    BaseSortID = 79,
    AwakerID = 15565,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99816_AwakerVoiceContent|永不迷失的引航神女啊，要是当年有这样的存在……那时候我在干什么来着？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15566,
    ReletedVoiceID = 99873,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99798] = {
    ID = 99798,
    CnID = "语音@鹦鹉螺关系对话4",
    BaseSortID = 80,
    AwakerID = 15565,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99798_AwakerVoiceContent|是在夸我吗？谢谢啦，不过我不记得我有修过船啊……我修过吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77922,
    ReletedVoiceID = 100118,
    FollowUpVoice = 0,
    Sort = 5
  },
  [131814] = {
    ID = 131814,
    CnID = "语音@鹦鹉螺关系对话5",
    BaseSortID = 81,
    AwakerID = 15565,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131814_AwakerVoiceContent|虽然我还是想不起来，但是，我也喜欢莫丝！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130901,
    ReletedVoiceID = 131809,
    FollowUpVoice = 0,
    Sort = 6
  },
  [100127] = {
    ID = 100127,
    CnID = "语音@鹦鹉螺思考",
    BaseSortID = 82,
    AwakerID = 15565,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100127_AwakerVoiceContent|这个我好像没见过……别急，我会弄明白的。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99980] = {
    ID = 99980,
    CnID = "语音@鹦鹉螺催促",
    BaseSortID = 83,
    AwakerID = 15565,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99980_AwakerVoiceContent|快点快点，我要忍不住发动引擎啦！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100140] = {
    ID = 100140,
    CnID = "语音@鹦鹉螺必杀",
    BaseSortID = 84,
    AwakerID = 15565,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100140_AwakerVoiceContent|鹦鹉螺号，全速前进！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99821] = {
    ID = 99821,
    CnID = "语音@鹦鹉螺错误",
    BaseSortID = 85,
    AwakerID = 15565,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99821_AwakerVoiceContent|哎哎，发动机怎么熄火了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99913] = {
    ID = 99913,
    CnID = "语音@鹦鹉螺死亡",
    BaseSortID = 86,
    AwakerID = 15565,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99913_AwakerVoiceContent|冒险终止，让我先休整一下吧……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100179] = {
    ID = 100179,
    CnID = "语音@睡莲普通开场",
    BaseSortID = 87,
    AwakerID = 15580,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100179_AwakerVoiceContent|以此孱弱之躯，静候您的差遣。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100064] = {
    ID = 100064,
    CnID = "语音@睡莲关系对话1",
    BaseSortID = 88,
    AwakerID = 15580,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100064_AwakerVoiceContent|比起那些病人，梅森小姐已经算非常健康的了。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15601,
    ReletedVoiceID = 100217,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99755] = {
    ID = 99755,
    CnID = "语音@睡莲关系对话2",
    BaseSortID = 89,
    AwakerID = 15580,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99755_AwakerVoiceContent|我拜读了奥尔拉小姐的诗集，里面每一首诗我都很喜欢呢，有机会的话可以邀约您一起读诗吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15583,
    ReletedVoiceID = 100203,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99938] = {
    ID = 99938,
    CnID = "语音@睡莲关系对话3",
    BaseSortID = 90,
    AwakerID = 15580,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99938_AwakerVoiceContent|我每天都在认真打理疗养院，等她回来的时候，一切都会是最好的样子……你放心。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15581,
    ReletedVoiceID = 100212,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99817] = {
    ID = 99817,
    CnID = "语音@睡莲关系对话4",
    BaseSortID = 91,
    AwakerID = 15580,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99817_AwakerVoiceContent|一想到还有人也如此向往着深海，我就感到由衷的喜悦。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15592,
    ReletedVoiceID = 99949,
    FollowUpVoice = 1,
    Sort = 5
  },
  [99998] = {
    ID = 99998,
    CnID = "语音@睡莲思考",
    BaseSortID = 92,
    AwakerID = 15580,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99998_AwakerVoiceContent|既然是您的期望，我会尽力而为。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100097] = {
    ID = 100097,
    CnID = "语音@睡莲催促",
    BaseSortID = 93,
    AwakerID = 15580,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100097_AwakerVoiceContent|漫长的等待，总是如此令人心焦。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100089] = {
    ID = 100089,
    CnID = "语音@睡莲必杀",
    BaseSortID = 94,
    AwakerID = 15580,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100089_AwakerVoiceContent|来吧，沉入大海的怀抱吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99947] = {
    ID = 99947,
    CnID = "语音@睡莲错误",
    BaseSortID = 95,
    AwakerID = 15580,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99947_AwakerVoiceContent|终究还是没能避免这份不幸吗？",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99944] = {
    ID = 99944,
    CnID = "语音@睡莲死亡",
    BaseSortID = 96,
    AwakerID = 15580,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99944_AwakerVoiceContent|回归……沉眠……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100066] = {
    ID = 100066,
    CnID = "语音@淤泥之花普通开场",
    BaseSortID = 97,
    AwakerID = 15581,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100066_AwakerVoiceContent|是这样做吗？莉莉明白了。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100091] = {
    ID = 100091,
    CnID = "语音@淤泥之花关系对话1",
    BaseSortID = 98,
    AwakerID = 15581,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100091_AwakerVoiceContent|脓疱，喜欢艾继丝。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15591,
    ReletedVoiceID = 100135,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99964] = {
    ID = 99964,
    CnID = "语音@淤泥之花关系对话2",
    BaseSortID = 99,
    AwakerID = 15581,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99964_AwakerVoiceContent|熟悉的气味，很好闻，莉莉很安心。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15587,
    ReletedVoiceID = 100043,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99788] = {
    ID = 99788,
    CnID = "语音@淤泥之花关系对话3",
    BaseSortID = 100,
    AwakerID = 15581,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99788_AwakerVoiceContent|脓疱，不是水母……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15573,
    ReletedVoiceID = 99894,
    FollowUpVoice = 0,
    Sort = 4
  },
  [100212] = {
    ID = 100212,
    CnID = "语音@淤泥之花关系对话4",
    BaseSortID = 101,
    AwakerID = 15581,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100212_AwakerVoiceContent|莉莉，相信你。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15580,
    ReletedVoiceID = 99938,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100182] = {
    ID = 100182,
    CnID = "语音@淤泥之花思考",
    BaseSortID = 102,
    AwakerID = 15581,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100182_AwakerVoiceContent|莉莉，听主人的话。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100218] = {
    ID = 100218,
    CnID = "语音@淤泥之花催促",
    BaseSortID = 103,
    AwakerID = 15581,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100218_AwakerVoiceContent|脓疱，越来越激动了。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99804] = {
    ID = 99804,
    CnID = "语音@淤泥之花必杀",
    BaseSortID = 104,
    AwakerID = 15581,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99804_AwakerVoiceContent|莉莉，会保护主人！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100209] = {
    ID = 100209,
    CnID = "语音@淤泥之花错误",
    BaseSortID = 105,
    AwakerID = 15581,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100209_AwakerVoiceContent|这样，不对吗？",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99770] = {
    ID = 99770,
    CnID = "语音@淤泥之花死亡",
    BaseSortID = 106,
    AwakerID = 15581,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99770_AwakerVoiceContent|莉莉……没力气了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [127017] = {
    ID = 127017,
    CnID = "语音@淤泥之花关系对话5",
    BaseSortID = 107,
    AwakerID = 15581,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_127017_AwakerVoiceContent|莉莉，喜欢母亲。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 125346,
    ReletedVoiceID = 127006,
    FollowUpVoice = 1,
    Sort = 11
  },
  [99844] = {
    ID = 99844,
    CnID = "语音@凸月侍女普通开场",
    BaseSortID = 108,
    AwakerID = 15571,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99844_AwakerVoiceContent|您的万能女仆，随时恭候您的吩咐！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100189] = {
    ID = 100189,
    CnID = "语音@凸月侍女关系对话1",
    BaseSortID = 109,
    AwakerID = 15571,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100189_AwakerVoiceContent|哦我尊敬的夫人，您最忠心的、勤劳的万能女仆向您致以最崇高的敬意！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15584,
    ReletedVoiceID = 99742,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99877] = {
    ID = 99877,
    CnID = "语音@凸月侍女关系对话2",
    BaseSortID = 110,
    AwakerID = 15571,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99877_AwakerVoiceContent|噫——可是，珈伦明明觉得很好吃啊……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15576,
    ReletedVoiceID = 100003,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99824] = {
    ID = 99824,
    CnID = "语音@凸月侍女关系对话3",
    BaseSortID = 111,
    AwakerID = 15571,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99824_AwakerVoiceContent|珈伦可不是能够随意指使的对象！要给钱的嘛，小姐。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15600,
    ReletedVoiceID = 100001,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99842] = {
    ID = 99842,
    CnID = "语音@凸月侍女关系对话4",
    BaseSortID = 112,
    AwakerID = 15571,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99842_AwakerVoiceContent|哈哈……珈伦、珈伦不需要太完美就好了！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 95786,
    ReletedVoiceID = 99773,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100214] = {
    ID = 100214,
    CnID = "语音@凸月侍女思考",
    BaseSortID = 113,
    AwakerID = 15571,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100214_AwakerVoiceContent|如此高深的问题，让珈伦好好想想，想想……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100191] = {
    ID = 100191,
    CnID = "语音@凸月侍女催促",
    BaseSortID = 114,
    AwakerID = 15571,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100191_AwakerVoiceContent|抓紧呀，珈伦还要赶回去收衣服呢！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99973] = {
    ID = 99973,
    CnID = "语音@凸月侍女必杀",
    BaseSortID = 115,
    AwakerID = 15571,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99973_AwakerVoiceContent|请品尝吧！珈伦的特制大餐！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100074] = {
    ID = 100074,
    CnID = "语音@凸月侍女错误",
    BaseSortID = 116,
    AwakerID = 15571,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100074_AwakerVoiceContent|啊，忘记放盐了吗？",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99995] = {
    ID = 99995,
    CnID = "语音@凸月侍女死亡",
    BaseSortID = 117,
    AwakerID = 15571,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99995_AwakerVoiceContent|哎呀……搞砸了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100057] = {
    ID = 100057,
    CnID = "语音@空想利刃普通开场",
    BaseSortID = 118,
    AwakerID = 15588,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100057_AwakerVoiceContent|艾尔瓦准备完成，随时出战。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99763] = {
    ID = 99763,
    CnID = "语音@空想利刃关系对话1",
    BaseSortID = 119,
    AwakerID = 15588,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99763_AwakerVoiceContent|奥吉尔，找准时机，不要谦让，想想特训课上的内容！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15585,
    ReletedVoiceID = 99928,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100073] = {
    ID = 100073,
    CnID = "语音@空想利刃关系对话2",
    BaseSortID = 120,
    AwakerID = 15588,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100073_AwakerVoiceContent|竟然把一个战士变成了这样的存在，这是对军人的亵渎。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15598,
    ReletedVoiceID = 99999,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100012] = {
    ID = 100012,
    CnID = "语音@空想利刃关系对话3",
    BaseSortID = 121,
    AwakerID = 15588,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100012_AwakerVoiceContent|感谢你的关心，但我们前天不是刚刚检修过？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15565,
    ReletedVoiceID = 99747,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99959] = {
    ID = 99959,
    CnID = "语音@空想利刃关系对话4",
    BaseSortID = 122,
    AwakerID = 15588,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99959_AwakerVoiceContent|虽然不明白这个请求的意义，不过我很乐意帮你的忙。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15579,
    ReletedVoiceID = 100055,
    FollowUpVoice = 0,
    Sort = 5
  },
  [99828] = {
    ID = 99828,
    CnID = "语音@空想利刃思考",
    BaseSortID = 123,
    AwakerID = 15588,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99828_AwakerVoiceContent|针对战况，要随时调整战术布局。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100035] = {
    ID = 100035,
    CnID = "语音@空想利刃催促",
    BaseSortID = 124,
    AwakerID = 15588,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100035_AwakerVoiceContent|抓紧时机，战场不等人。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100113] = {
    ID = 100113,
    CnID = "语音@空想利刃必杀",
    BaseSortID = 125,
    AwakerID = 15588,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100113_AwakerVoiceContent|一击制敌！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100019] = {
    ID = 100019,
    CnID = "语音@空想利刃错误",
    BaseSortID = 126,
    AwakerID = 15588,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100019_AwakerVoiceContent|看来这次的战术未能奏效。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100197] = {
    ID = 100197,
    CnID = "语音@空想利刃死亡",
    BaseSortID = 127,
    AwakerID = 15588,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100197_AwakerVoiceContent|失败，是战争的常事……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99785] = {
    ID = 99785,
    CnID = "语音@幸运侦探普通开场",
    BaseSortID = 128,
    AwakerID = 15604,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99785_AwakerVoiceContent|名侦探的出场费，可是很贵的哦。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99771] = {
    ID = 99771,
    CnID = "语音@幸运侦探关系对话1",
    BaseSortID = 129,
    AwakerID = 15604,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99771_AwakerVoiceContent|这位尊贵的夫人，以您的财富，想必不介意和我小小地赌一场吧？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15584,
    ReletedVoiceID = 100103,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100215] = {
    ID = 100215,
    CnID = "语音@幸运侦探关系对话2",
    BaseSortID = 130,
    AwakerID = 15604,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100215_AwakerVoiceContent|虽然对自己的运气很自信，不过如果能许愿的话，当然希望好运越多越好啦。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15566,
    ReletedVoiceID = 99753,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99761] = {
    ID = 99761,
    CnID = "语音@幸运侦探关系对话3",
    BaseSortID = 131,
    AwakerID = 15604,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99761_AwakerVoiceContent|哎，其实这样的人生，有时候也会略感无聊啦……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15594,
    ReletedVoiceID = 100188,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99835] = {
    ID = 99835,
    CnID = "语音@幸运侦探关系对话4",
    BaseSortID = 132,
    AwakerID = 15604,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99835_AwakerVoiceContent|您就是想买，我也不卖呀！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15590,
    ReletedVoiceID = 99808,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100027] = {
    ID = 100027,
    CnID = "语音@幸运侦探思考",
    BaseSortID = 133,
    AwakerID = 15604,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100027_AwakerVoiceContent|蛛丝马迹，就藏在细节之中。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100130] = {
    ID = 100130,
    CnID = "语音@幸运侦探催促",
    BaseSortID = 134,
    AwakerID = 15604,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100130_AwakerVoiceContent|快点快点，好手感稍纵即逝呀！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99905] = {
    ID = 99905,
    CnID = "语音@幸运侦探必杀",
    BaseSortID = 135,
    AwakerID = 15604,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99905_AwakerVoiceContent|就是现在，筹码全押！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100198] = {
    ID = 100198,
    CnID = "语音@幸运侦探错误",
    BaseSortID = 136,
    AwakerID = 15604,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100198_AwakerVoiceContent|唉呀唉呀！有种不好的预感！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100100] = {
    ID = 100100,
    CnID = "语音@幸运侦探死亡",
    BaseSortID = 137,
    AwakerID = 15604,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100100_AwakerVoiceContent|运气……用完了吗……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99745] = {
    ID = 99745,
    CnID = "语音@甜蜜恶鬼普通开场",
    BaseSortID = 138,
    AwakerID = 15560,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99745_AwakerVoiceContent|哎呀，又有新的调教机会了吗？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100193] = {
    ID = 100193,
    CnID = "语音@甜蜜恶鬼关系对话1",
    BaseSortID = 139,
    AwakerID = 15560,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100193_AwakerVoiceContent|噫，实在是太冷酷、太残暴了，一点都不甜蜜！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15586,
    ReletedVoiceID = 99796,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100040] = {
    ID = 100040,
    CnID = "语音@甜蜜恶鬼关系对话2",
    BaseSortID = 140,
    AwakerID = 15560,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100040_AwakerVoiceContent|哎呀，真是凌厉，作为骑士不应该让一让女士吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15585,
    ReletedVoiceID = 99916,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99830] = {
    ID = 99830,
    CnID = "语音@甜蜜恶鬼关系对话3",
    BaseSortID = 141,
    AwakerID = 15560,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99830_AwakerVoiceContent|走开！走开！我最讨厌你这样纠缠不休的家伙了！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15597,
    ReletedVoiceID = 100166,
    FollowUpVoice = 0,
    Sort = 4
  },
  [100094] = {
    ID = 100094,
    CnID = "语音@甜蜜恶鬼关系对话4",
    BaseSortID = 142,
    AwakerID = 15560,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100094_AwakerVoiceContent|机械人也会感到疼痛吗？也会臣服于我的皮鞭之下吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15603,
    ReletedVoiceID = 99853,
    FollowUpVoice = 1,
    Sort = 5
  },
  [143463] = {
    ID = 143463,
    CnID = "语音@甜蜜恶鬼关系对话5",
    BaseSortID = 143,
    AwakerID = 15560,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143463_AwakerVoiceContent|有什么新花样，教教人家嘛~",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 141302,
    ReletedVoiceID = 143455,
    FollowUpVoice = 1,
    Sort = 6
  },
  [100085] = {
    ID = 100085,
    CnID = "语音@甜蜜恶鬼思考",
    BaseSortID = 144,
    AwakerID = 15560,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100085_AwakerVoiceContent|让我想想，下一步该怎么调教好呢？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [100038] = {
    ID = 100038,
    CnID = "语音@甜蜜恶鬼催促",
    BaseSortID = 145,
    AwakerID = 15560,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100038_AwakerVoiceContent|不要让人家等那么久嘛，被放置的感觉真是很寂寞呢。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99861] = {
    ID = 99861,
    CnID = "语音@甜蜜恶鬼必杀",
    BaseSortID = 146,
    AwakerID = 15560,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99861_AwakerVoiceContent|迎接最欢愉的疼痛！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99833] = {
    ID = 99833,
    CnID = "语音@甜蜜恶鬼错误",
    BaseSortID = 147,
    AwakerID = 15560,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99833_AwakerVoiceContent|人家的鞭子被缠住了啦。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100092] = {
    ID = 100092,
    CnID = "语音@甜蜜恶鬼死亡",
    BaseSortID = 148,
    AwakerID = 15560,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100092_AwakerVoiceContent|真是……粗鲁的人……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99929] = {
    ID = 99929,
    CnID = "语音@哈姆林普通开场",
    BaseSortID = 149,
    AwakerID = 54117,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99929_AwakerVoiceContent|哈姆林，为您献上我的演奏。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99848] = {
    ID = 99848,
    CnID = "语音@哈姆林关系对话1",
    BaseSortID = 150,
    AwakerID = 54117,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99848_AwakerVoiceContent|你的歌喉有着任何乐器都无法比拟的音色，十分完美。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15574,
    ReletedVoiceID = 99859,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100107] = {
    ID = 100107,
    CnID = "语音@哈姆林关系对话2",
    BaseSortID = 151,
    AwakerID = 54117,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100107_AwakerVoiceContent|乐意效劳，阁下的舞姿也足以与我的演奏相配。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15562,
    ReletedVoiceID = 100037,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99886] = {
    ID = 99886,
    CnID = "语音@哈姆林关系对话3",
    BaseSortID = 152,
    AwakerID = 54117,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99886_AwakerVoiceContent|克莱门汀小姐表面看着无害，实际上与于丽埃特之流是同一类人。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77925,
    ReletedVoiceID = 99963,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99765] = {
    ID = 99765,
    CnID = "语音@哈姆林关系对话4",
    BaseSortID = 153,
    AwakerID = 54117,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99765_AwakerVoiceContent|艺术是相通的，我亦能从奥尔拉小姐的诗文中联想到优美的乐章。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15583,
    ReletedVoiceID = 100004,
    FollowUpVoice = 0,
    Sort = 5
  },
  [99847] = {
    ID = 99847,
    CnID = "语音@哈姆林思考",
    BaseSortID = 154,
    AwakerID = 54117,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99847_AwakerVoiceContent|完美的演奏需要最精密的编排。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99962] = {
    ID = 99962,
    CnID = "语音@哈姆林催促",
    BaseSortID = 155,
    AwakerID = 54117,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99962_AwakerVoiceContent|快些合入乐曲，不要耽误了演出的节奏。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100169] = {
    ID = 100169,
    CnID = "语音@哈姆林必杀",
    BaseSortID = 156,
    AwakerID = 54117,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100169_AwakerVoiceContent|聆听这乐曲的高潮！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99811] = {
    ID = 99811,
    CnID = "语音@哈姆林错误",
    BaseSortID = 157,
    AwakerID = 54117,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99811_AwakerVoiceContent|慢了，小号进慢了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99786] = {
    ID = 99786,
    CnID = "语音@哈姆林死亡",
    BaseSortID = 158,
    AwakerID = 54117,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99786_AwakerVoiceContent|音符……乱了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100187] = {
    ID = 100187,
    CnID = "语音@塔薇普通开场",
    BaseSortID = 159,
    AwakerID = 54116,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100187_AwakerVoiceContent|我已回应你的呼唤。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99845] = {
    ID = 99845,
    CnID = "语音@塔薇关系对话1",
    BaseSortID = 160,
    AwakerID = 54116,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99845_AwakerVoiceContent|很抱歉，即使是我也无法逆转这一过程。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15568,
    ReletedVoiceID = 99789,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100154] = {
    ID = 100154,
    CnID = "语音@塔薇关系对话2",
    BaseSortID = 161,
    AwakerID = 54116,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100154_AwakerVoiceContent|门后的知识永远为智慧的人敞开。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15570,
    ReletedVoiceID = 100114,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100213] = {
    ID = 100213,
    CnID = "语音@塔薇关系对话3",
    BaseSortID = 162,
    AwakerID = 54116,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100213_AwakerVoiceContent|果然无论见过多少次，都无法认同繁育的理念。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15596,
    ReletedVoiceID = 100025,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100033] = {
    ID = 100033,
    CnID = "语音@塔薇关系对话4",
    BaseSortID = 163,
    AwakerID = 54116,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100033_AwakerVoiceContent|仅仅拥有奉献的精神，也并不能扭转命运的结局，那是无用功。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15599,
    ReletedVoiceID = 100171,
    FollowUpVoice = 1,
    Sort = 5
  },
  [140524] = {
    ID = 140524,
    CnID = "语音@塔薇关系对话5",
    BaseSortID = 164,
    AwakerID = 54116,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140524_AwakerVoiceContent|关于这个问题，我想，只有你自己才能解答。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130226,
    ReletedVoiceID = 140520,
    FollowUpVoice = 0,
    Sort = 6
  },
  [146426] = {
    ID = 146426,
    CnID = "语音@塔薇关系对话6",
    BaseSortID = 165,
    AwakerID = 54116,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146426_AwakerVoiceContent|混沌的巨兽，你的怒火还未平息么？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 145363,
    ReletedVoiceID = 146428,
    FollowUpVoice = 1,
    Sort = 7
  },
  [99981] = {
    ID = 99981,
    CnID = "语音@塔薇思考",
    BaseSortID = 166,
    AwakerID = 54116,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99981_AwakerVoiceContent|如何选择，将决定命运的走向。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [99791] = {
    ID = 99791,
    CnID = "语音@塔薇催促",
    BaseSortID = 167,
    AwakerID = 54116,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99791_AwakerVoiceContent|犹豫与纠结，都无法改变最终的结局。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99926] = {
    ID = 99926,
    CnID = "语音@塔薇必杀",
    BaseSortID = 168,
    AwakerID = 54116,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99926_AwakerVoiceContent|请见证，这真实之景——",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99766] = {
    ID = 99766,
    CnID = "语音@塔薇错误",
    BaseSortID = 169,
    AwakerID = 54116,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99766_AwakerVoiceContent|走向了错误的结局……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [100048] = {
    ID = 100048,
    CnID = "语音@塔薇死亡",
    BaseSortID = 170,
    AwakerID = 54116,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100048_AwakerVoiceContent|早已预见的结局……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [100059] = {
    ID = 100059,
    CnID = "语音@凯蒂古拉普通开场",
    BaseSortID = 171,
    AwakerID = 77913,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100059_AwakerVoiceContent|狩猎开始，尽情燃烧吧。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99893] = {
    ID = 99893,
    CnID = "语音@凯蒂古拉关系对话1",
    BaseSortID = 172,
    AwakerID = 77913,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99893_AwakerVoiceContent|这次你会有多少子嗣燃烧殆尽呢？放心，我会尽量控制住，给你留一些孤苗。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15596,
    ReletedVoiceID = 100133,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99856] = {
    ID = 99856,
    CnID = "语音@凯蒂古拉关系对话2",
    BaseSortID = 173,
    AwakerID = 77913,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99856_AwakerVoiceContent|小家伙的搭档？来让我看看你是否有这个资格吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15595,
    ReletedVoiceID = 100088,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99960] = {
    ID = 99960,
    CnID = "语音@凯蒂古拉关系对话3",
    BaseSortID = 174,
    AwakerID = 77913,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99960_AwakerVoiceContent|抓到你了，阴暗肮脏的虫子。那么……死吧！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77927,
    Sort = 4
  },
  [100106] = {
    ID = 100106,
    CnID = "语音@凯蒂古拉关系对话4",
    BaseSortID = 175,
    AwakerID = 77913,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100106_AwakerVoiceContent|我本来以为我会跟你相处不来，没想到「水」「火」居然意外的相容。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15563,
    ReletedVoiceID = 99996,
    FollowUpVoice = 1,
    Sort = 5
  },
  [124000] = {
    ID = 124000,
    CnID = "语音@凯蒂古拉关系对话5",
    BaseSortID = 176,
    AwakerID = 77913,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_124000_AwakerVoiceContent|异世界的猎人，还是猎物？来一决高下吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 94450,
    ReletedVoiceID = 123997,
    FollowUpVoice = 1,
    Sort = 6
  },
  [143466] = {
    ID = 143466,
    CnID = "语音@凯蒂古拉关系对话6",
    BaseSortID = 177,
    AwakerID = 77913,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143466_AwakerVoiceContent|哟吼，听说我们有同一个追猎目标。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 141302,
    ReletedVoiceID = 143456,
    FollowUpVoice = 1,
    Sort = 7
  },
  [99931] = {
    ID = 99931,
    CnID = "语音@凯蒂古拉思考",
    BaseSortID = 178,
    AwakerID = 77913,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99931_AwakerVoiceContent|成功的作战离不开周密的计划。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [99912] = {
    ID = 99912,
    CnID = "语音@凯蒂古拉催促",
    BaseSortID = 179,
    AwakerID = 77913,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99912_AwakerVoiceContent|过度的谨慎反而会延误战机，大胆去做吧。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99768] = {
    ID = 99768,
    CnID = "语音@凯蒂古拉必杀",
    BaseSortID = 180,
    AwakerID = 77913,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99768_AwakerVoiceContent|聆听吧！世界融化的哀嚎！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99985] = {
    ID = 99985,
    CnID = "语音@凯蒂古拉错误",
    BaseSortID = 181,
    AwakerID = 77913,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99985_AwakerVoiceContent|计划出现偏差了，思考如何补救吧。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [100068] = {
    ID = 100068,
    CnID = "语音@凯蒂古拉死亡",
    BaseSortID = 182,
    AwakerID = 77913,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100068_AwakerVoiceContent|火焰……熄灭了么……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [100099] = {
    ID = 100099,
    CnID = "语音@海月普通开场",
    BaseSortID = 183,
    AwakerID = 15573,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100099_AwakerVoiceContent|伙伴伙伴，好多的伙伴！一起来玩吧！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99875] = {
    ID = 99875,
    CnID = "语音@海月关系对话1",
    BaseSortID = 184,
    AwakerID = 15573,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99875_AwakerVoiceContent|繁衍？什么是繁衍，奥瑞塔喜欢繁衍很多很多的伙伴！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15596,
    ReletedVoiceID = 99901,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99894] = {
    ID = 99894,
    CnID = "语音@海月关系对话2",
    BaseSortID = 185,
    AwakerID = 15573,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99894_AwakerVoiceContent|哇，你也有好多好多和奥瑞塔一样的伙伴，大家一起去大海里玩吧！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15581,
    ReletedVoiceID = 99788,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100000] = {
    ID = 100000,
    CnID = "语音@海月关系对话3",
    BaseSortID = 186,
    AwakerID = 15573,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100000_AwakerVoiceContent|你说的故国，也叫亚什么特斯吗？那里也有很多伙伴吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15575,
    ReletedVoiceID = 99818,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99930] = {
    ID = 99930,
    CnID = "语音@海月关系对话4",
    BaseSortID = 187,
    AwakerID = 15573,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99930_AwakerVoiceContent|哇，你的伙伴好像比奥瑞塔还要多！好厉害！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15600,
    ReletedVoiceID = 100022,
    FollowUpVoice = 1,
    Sort = 5
  },
  [140522] = {
    ID = 140522,
    CnID = "语音@海月关系对话5",
    BaseSortID = 188,
    AwakerID = 15573,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140522_AwakerVoiceContent|繁衍？不是很简单吗，看，奥瑞塔有好多好多伙伴哦~",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130226,
    ReletedVoiceID = 140521,
    FollowUpVoice = 1,
    Sort = 6
  },
  [150094] = {
    ID = 150094,
    CnID = "语音@海月关系对话6",
    BaseSortID = 189,
    AwakerID = 15573,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150094_AwakerVoiceContent|我是我是！唔，但奥瑞塔只有一块点心了，一块都不能留吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77921,
    ReletedVoiceID = 150096,
    FollowUpVoice = 0,
    Sort = 7
  },
  [100159] = {
    ID = 100159,
    CnID = "语音@海月思考",
    BaseSortID = 190,
    AwakerID = 15573,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100159_AwakerVoiceContent|哎……嗯……伙伴们一起来想想吧！",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [100124] = {
    ID = 100124,
    CnID = "语音@海月催促",
    BaseSortID = 191,
    AwakerID = 15573,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100124_AwakerVoiceContent|快点快点，快来和奥瑞塔一起玩！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99872] = {
    ID = 99872,
    CnID = "语音@海月必杀",
    BaseSortID = 192,
    AwakerID = 15573,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99872_AwakerVoiceContent|伙伴们一起上！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99779] = {
    ID = 99779,
    CnID = "语音@海月错误",
    BaseSortID = 193,
    AwakerID = 15573,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99779_AwakerVoiceContent|哎呀，有伙伴脱水了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [99966] = {
    ID = 99966,
    CnID = "语音@海月死亡",
    BaseSortID = 194,
    AwakerID = 15573,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99966_AwakerVoiceContent|有点……玩累了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [99942] = {
    ID = 99942,
    CnID = "语音@沉睡之主普通开场",
    BaseSortID = 195,
    AwakerID = 15563,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99942_AwakerVoiceContent|无聊的战斗，也用得上余出场吗。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100168] = {
    ID = 100168,
    CnID = "语音@沉睡之主关系对话1",
    BaseSortID = 196,
    AwakerID = 15563,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100168_AwakerVoiceContent|余已经说了很多次了，无谓的祷告只是叨扰梦境的聒噪罢了……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15582,
    ReletedVoiceID = 99793,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99895] = {
    ID = 99895,
    CnID = "语音@沉睡之主关系对话2",
    BaseSortID = 197,
    AwakerID = 15563,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99895_AwakerVoiceContent|信仰么，能始终坚定相信着神，或许也是一种幸福。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15599,
    ReletedVoiceID = 99932,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99965] = {
    ID = 99965,
    CnID = "语音@沉睡之主关系对话3",
    BaseSortID = 198,
    AwakerID = 15563,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99965_AwakerVoiceContent|想要窥探余的梦境吗？你应知晓，对未知过于贪婪的人总会招致狂妄的反噬。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77925,
    ReletedVoiceID = 99890,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99823] = {
    ID = 99823,
    CnID = "语音@沉睡之主关系对话4",
    BaseSortID = 199,
    AwakerID = 15563,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99823_AwakerVoiceContent|没想到，利莫里亚还有留存在外的子民……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15575,
    ReletedVoiceID = 99868,
    FollowUpVoice = 1,
    Sort = 5
  },
  [99996] = {
    ID = 99996,
    CnID = "语音@沉睡之主关系对话5",
    BaseSortID = 200,
    AwakerID = 15563,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99996_AwakerVoiceContent|无聊……既然不喜，就不要来打扰余休息……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77913,
    ReletedVoiceID = 100106,
    FollowUpVoice = 0,
    Sort = 6
  },
  [120256] = {
    ID = 120256,
    CnID = "语音@沉睡之主关系对话6",
    BaseSortID = 201,
    AwakerID = 15563,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120256_AwakerVoiceContent|你想要清除罪恶吗……真是执迷不悟，余不会做如此徒劳无功之事。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77917,
    ReletedVoiceID = 120283,
    FollowUpVoice = 0,
    Sort = 7
  },
  [99748] = {
    ID = 99748,
    CnID = "语音@沉睡之主思考",
    BaseSortID = 202,
    AwakerID = 15563,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99748_AwakerVoiceContent|略感耗神……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [99826] = {
    ID = 99826,
    CnID = "语音@沉睡之主催促",
    BaseSortID = 203,
    AwakerID = 15563,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99826_AwakerVoiceContent|莫要耽误余的休息。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99978] = {
    ID = 99978,
    CnID = "语音@沉睡之主必杀",
    BaseSortID = 204,
    AwakerID = 15563,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99978_AwakerVoiceContent|群星庇佑！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99846] = {
    ID = 99846,
    CnID = "语音@沉睡之主错误",
    BaseSortID = 205,
    AwakerID = 15563,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99846_AwakerVoiceContent|啧，晃神了……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [99975] = {
    ID = 99975,
    CnID = "语音@沉睡之主死亡",
    BaseSortID = 206,
    AwakerID = 15563,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99975_AwakerVoiceContent|扰余清梦……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [99993] = {
    ID = 99993,
    CnID = "语音@深海淑女普通开场",
    BaseSortID = 207,
    AwakerID = 15576,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99993_AwakerVoiceContent|本小姐登场，还不快快奉上小蛋糕！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100003] = {
    ID = 100003,
    CnID = "语音@深海淑女关系对话1",
    BaseSortID = 208,
    AwakerID = 15576,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100003_AwakerVoiceContent|你再敢把你那黑乎乎、臭烘烘的蛋糕拿到我面前来，我就把你的脑袋打开花！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15571,
    ReletedVoiceID = 99877,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99943] = {
    ID = 99943,
    CnID = "语音@深海淑女关系对话2",
    BaseSortID = 209,
    AwakerID = 15576,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99943_AwakerVoiceContent|真没礼貌！把你那看小蛋糕一样的眼神从本小姐身上挪开！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 95786,
    ReletedVoiceID = 100065,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99780] = {
    ID = 99780,
    CnID = "语音@深海淑女关系对话3",
    BaseSortID = 210,
    AwakerID = 15576,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99780_AwakerVoiceContent|烦死了，少管我！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15564,
    ReletedVoiceID = 100101,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99919] = {
    ID = 99919,
    CnID = "语音@深海淑女关系对话4",
    BaseSortID = 211,
    AwakerID = 15576,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99919_AwakerVoiceContent|等一切结束之后，才来展现所谓“母亲”的关爱吗？不好意思，我已经不需要了！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15582,
    ReletedVoiceID = 99760,
    FollowUpVoice = 0,
    Sort = 5
  },
  [120285] = {
    ID = 120285,
    CnID = "语音@深海淑女关系对话5",
    BaseSortID = 212,
    AwakerID = 15576,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120285_AwakerVoiceContent|自愿失去自由，成为顺从的囚徒……我是绝对不会成为你的！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15589,
    ReletedVoiceID = 120263,
    FollowUpVoice = 0,
    Sort = 6
  },
  [100131] = {
    ID = 100131,
    CnID = "语音@深海淑女思考",
    BaseSortID = 213,
    AwakerID = 15576,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100131_AwakerVoiceContent|真是麻烦……本小姐才没有认输啊！",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99971] = {
    ID = 99971,
    CnID = "语音@深海淑女催促",
    BaseSortID = 214,
    AwakerID = 15576,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99971_AwakerVoiceContent|怎么样，战胜不了本小姐吗？这不是理所当然的嘛。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100083] = {
    ID = 100083,
    CnID = "语音@深海淑女必杀",
    BaseSortID = 215,
    AwakerID = 15576,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100083_AwakerVoiceContent|哈！尝尝本小姐的厉害！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100006] = {
    ID = 100006,
    CnID = "语音@深海淑女错误",
    BaseSortID = 216,
    AwakerID = 15576,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100006_AwakerVoiceContent|咦？蛋糕都打翻了啊！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99956] = {
    ID = 99956,
    CnID = "语音@深海淑女死亡",
    BaseSortID = 217,
    AwakerID = 15576,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99956_AwakerVoiceContent|本小姐记住了，你给我等着……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99879] = {
    ID = 99879,
    CnID = "语音@复仇巨刃普通开场",
    BaseSortID = 218,
    AwakerID = 15564,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99879_AwakerVoiceContent|准备面对巨人的力量吧！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99991] = {
    ID = 99991,
    CnID = "语音@复仇巨刃关系对话1",
    BaseSortID = 219,
    AwakerID = 15564,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99991_AwakerVoiceContent|啧，怎么又是这个疯子……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15569,
    ReletedVoiceID = 100031,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100101] = {
    ID = 100101,
    CnID = "语音@复仇巨刃关系对话2",
    BaseSortID = 220,
    AwakerID = 15564,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100101_AwakerVoiceContent|只吃那些黏糊糊的甜食太没营养了，怎么长出健壮的肌肉来？要多吃肉！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15576,
    ReletedVoiceID = 99780,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100164] = {
    ID = 100164,
    CnID = "语音@复仇巨刃关系对话3",
    BaseSortID = 221,
    AwakerID = 15564,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100164_AwakerVoiceContent|只要主祭大人开口，我立刻为您少用八成力气。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15582,
    ReletedVoiceID = 100137,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100072] = {
    ID = 100072,
    CnID = "语音@复仇巨刃关系对话4",
    BaseSortID = 222,
    AwakerID = 15564,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100072_AwakerVoiceContent|当然不能，小子，很遗憾，力量这东西有时候就是天生决定的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15594,
    ReletedVoiceID = 99990,
    FollowUpVoice = 0,
    Sort = 5
  },
  [120269] = {
    ID = 120269,
    CnID = "语音@复仇巨刃关系对话5",
    BaseSortID = 223,
    AwakerID = 15564,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120269_AwakerVoiceContent|愚蠢的小姑娘，绝对的力量从来应该牢牢掌握在自己手中。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15589,
    ReletedVoiceID = 120267,
    FollowUpVoice = 1,
    Sort = 6
  },
  [131820] = {
    ID = 131820,
    CnID = "语音@复仇巨刃关系对话6",
    BaseSortID = 224,
    AwakerID = 15564,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131820_AwakerVoiceContent|呵，又来了……蠢货……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130901,
    ReletedVoiceID = 131810,
    FollowUpVoice = 0,
    Sort = 7
  },
  [100200] = {
    ID = 100200,
    CnID = "语音@复仇巨刃思考",
    BaseSortID = 225,
    AwakerID = 15564,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100200_AwakerVoiceContent|全部打倒就好了吧？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [100163] = {
    ID = 100163,
    CnID = "语音@复仇巨刃催促",
    BaseSortID = 226,
    AwakerID = 15564,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100163_AwakerVoiceContent|不要挑战我的耐性。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99827] = {
    ID = 99827,
    CnID = "语音@复仇巨刃必杀",
    BaseSortID = 227,
    AwakerID = 15564,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99827_AwakerVoiceContent|这就是能够征服世界的力量！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99759] = {
    ID = 99759,
    CnID = "语音@复仇巨刃错误",
    BaseSortID = 228,
    AwakerID = 15564,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99759_AwakerVoiceContent|啧，打歪了吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [99758] = {
    ID = 99758,
    CnID = "语音@复仇巨刃死亡",
    BaseSortID = 229,
    AwakerID = 15564,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99758_AwakerVoiceContent|失败，只会是暂时的……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [99849] = {
    ID = 99849,
    CnID = "语音@海之使徒普通开场",
    BaseSortID = 230,
    AwakerID = 15582,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99849_AwakerVoiceContent|我所做的一切只为宣扬祂的荣光。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99760] = {
    ID = 99760,
    CnID = "语音@海之使徒关系对话1",
    BaseSortID = 231,
    AwakerID = 15582,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99760_AwakerVoiceContent|我所做的一切不求你的原谅，如今只希望能稍作补偿……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15576,
    ReletedVoiceID = 99919,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100137] = {
    ID = 100137,
    CnID = "语音@海之使徒关系对话2",
    BaseSortID = 232,
    AwakerID = 15582,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100137_AwakerVoiceContent|少油嘴滑舌，做好你的事，非利士人。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15564,
    ReletedVoiceID = 100164,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99793] = {
    ID = 99793,
    CnID = "语音@海之使徒关系对话3",
    BaseSortID = 233,
    AwakerID = 15582,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99793_AwakerVoiceContent|怎敢与您兵刃相向？对吾主不敬的，都该……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15563,
    ReletedVoiceID = 100168,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99800] = {
    ID = 99800,
    CnID = "语音@海之使徒关系对话4",
    BaseSortID = 234,
    AwakerID = 15582,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99800_AwakerVoiceContent|只要心怀对吾主的虔诚，王就会引领我们前往安宁的未来。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15575,
    ReletedVoiceID = 100087,
    FollowUpVoice = 1,
    Sort = 5
  },
  [120272] = {
    ID = 120272,
    CnID = "语音@海之使徒关系对话5",
    BaseSortID = 235,
    AwakerID = 15582,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120272_AwakerVoiceContent|利莫里亚的荣光正在呼唤你我，神母。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15589,
    ReletedVoiceID = 120245,
    FollowUpVoice = 1,
    Sort = 6
  },
  [99839] = {
    ID = 99839,
    CnID = "语音@海之使徒思考",
    BaseSortID = 236,
    AwakerID = 15582,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99839_AwakerVoiceContent|要将吾主的威仪散播四方……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99864] = {
    ID = 99864,
    CnID = "语音@海之使徒催促",
    BaseSortID = 237,
    AwakerID = 15582,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99864_AwakerVoiceContent|不可怠慢。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99837] = {
    ID = 99837,
    CnID = "语音@海之使徒必杀",
    BaseSortID = 238,
    AwakerID = 15582,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99837_AwakerVoiceContent|我将替吾主代行惩戒！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100128] = {
    ID = 100128,
    CnID = "语音@海之使徒错误",
    BaseSortID = 239,
    AwakerID = 15582,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100128_AwakerVoiceContent|为什么，我的祈祷没有错，没有错！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99972] = {
    ID = 99972,
    CnID = "语音@海之使徒死亡",
    BaseSortID = 240,
    AwakerID = 15582,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99972_AwakerVoiceContent|此微薄之身，还是太渺小了吗……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99946] = {
    ID = 99946,
    CnID = "语音@原初信徒普通开场",
    BaseSortID = 241,
    AwakerID = 15575,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99946_AwakerVoiceContent|我的光芒会照亮通往故国的道路。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99818] = {
    ID = 99818,
    CnID = "语音@原初信徒关系对话1",
    BaseSortID = 242,
    AwakerID = 15575,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99818_AwakerVoiceContent|呵呵，是的，故国之中必定遍布你的伙伴，请满怀期待地前来吧……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15573,
    ReletedVoiceID = 100000,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99868] = {
    ID = 99868,
    CnID = "语音@原初信徒关系对话2",
    BaseSortID = 243,
    AwakerID = 15575,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99868_AwakerVoiceContent|伟大的吾主！在您身边，我又看到了故国的光辉……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15563,
    ReletedVoiceID = 99823,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100087] = {
    ID = 100087,
    CnID = "语音@原初信徒关系对话3",
    BaseSortID = 244,
    AwakerID = 15575,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100087_AwakerVoiceContent|谨遵您的教诲，主祭大人。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15582,
    ReletedVoiceID = 99800,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99751] = {
    ID = 99751,
    CnID = "语音@原初信徒关系对话4",
    BaseSortID = 245,
    AwakerID = 15575,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99751_AwakerVoiceContent|哦当然，或许您愿意与我一起出海采风吗？艺术家小姐。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15592,
    ReletedVoiceID = 100181,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100121] = {
    ID = 100121,
    CnID = "语音@原初信徒思考",
    BaseSortID = 246,
    AwakerID = 15575,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100121_AwakerVoiceContent|故国的门扉究竟在何方……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99925] = {
    ID = 99925,
    CnID = "语音@原初信徒催促",
    BaseSortID = 247,
    AwakerID = 15575,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99925_AwakerVoiceContent|快些，快些回应故国的召唤吧！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99885] = {
    ID = 99885,
    CnID = "语音@原初信徒必杀",
    BaseSortID = 248,
    AwakerID = 15575,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99885_AwakerVoiceContent|感受故国的伟岸！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100013] = {
    ID = 100013,
    CnID = "语音@原初信徒错误",
    BaseSortID = 249,
    AwakerID = 15575,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100013_AwakerVoiceContent|不，没有回应，故国抛弃了我……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100119] = {
    ID = 100119,
    CnID = "语音@原初信徒死亡",
    BaseSortID = 250,
    AwakerID = 15575,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100119_AwakerVoiceContent|归……乡……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100030] = {
    ID = 100030,
    CnID = "语音@雕砌者普通开场",
    BaseSortID = 251,
    AwakerID = 15592,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100030_AwakerVoiceContent|哎呀哎呀，都是很好的雕刻素材呢……",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99949] = {
    ID = 99949,
    CnID = "语音@雕砌者关系对话1",
    BaseSortID = 252,
    AwakerID = 15592,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99949_AwakerVoiceContent|当然，您是一位颇有品味的女士。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15580,
    ReletedVoiceID = 99817,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99952] = {
    ID = 99952,
    CnID = "语音@雕砌者关系对话2",
    BaseSortID = 253,
    AwakerID = 15592,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99952_AwakerVoiceContent|如此美丽、纤细而脆弱的身姿，与卡拉拉大理石的色泽多么相配……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15562,
    ReletedVoiceID = 99802,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100181] = {
    ID = 100181,
    CnID = "语音@雕砌者关系对话3",
    BaseSortID = 254,
    AwakerID = 15592,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100181_AwakerVoiceContent|您的面容如此瑰丽而奇异，能否让我将这样的美凝固于永恒的塑像之中呢？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15575,
    ReletedVoiceID = 99751,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100153] = {
    ID = 100153,
    CnID = "语音@雕砌者关系对话4",
    BaseSortID = 255,
    AwakerID = 15592,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100153_AwakerVoiceContent|直面闪电的领航者，多么令人感动的雕塑主题。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77922,
    ReletedVoiceID = 99876,
    FollowUpVoice = 1,
    Sort = 5
  },
  [120276] = {
    ID = 120276,
    CnID = "语音@雕砌者关系对话5",
    BaseSortID = 256,
    AwakerID = 15592,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120276_AwakerVoiceContent|正合我意，皮克曼先生。相信您的画作不会让我失望。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77926,
    ReletedVoiceID = 120247,
    FollowUpVoice = 0,
    Sort = 6
  },
  [99774] = {
    ID = 99774,
    CnID = "语音@雕砌者思考",
    BaseSortID = 257,
    AwakerID = 15592,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99774_AwakerVoiceContent|灵感出现，亦需要细细打磨……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99863] = {
    ID = 99863,
    CnID = "语音@雕砌者催促",
    BaseSortID = 258,
    AwakerID = 15592,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99863_AwakerVoiceContent|浪费灵感的每一分钟，都是对艺术的不尊重。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100020] = {
    ID = 100020,
    CnID = "语音@雕砌者必杀",
    BaseSortID = 259,
    AwakerID = 15592,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100020_AwakerVoiceContent|欣赏吧，这至美之物！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100144] = {
    ID = 100144,
    CnID = "语音@雕砌者错误",
    BaseSortID = 260,
    AwakerID = 15592,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100144_AwakerVoiceContent|平庸的失败之作，没有存在的必要。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99762] = {
    ID = 99762,
    CnID = "语音@雕砌者死亡",
    BaseSortID = 261,
    AwakerID = 15592,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99762_AwakerVoiceContent|献身于美……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100078] = {
    ID = 100078,
    CnID = "语音@沉渊者普通开场",
    BaseSortID = 262,
    AwakerID = 15594,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100078_AwakerVoiceContent|我会保护你的，以我的血脉起誓。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100188] = {
    ID = 100188,
    CnID = "语音@沉渊者关系对话1",
    BaseSortID = 263,
    AwakerID = 15594,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100188_AwakerVoiceContent|好运么……真是个令人嫉妒的天赋。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15604,
    ReletedVoiceID = 99761,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100029] = {
    ID = 100029,
    CnID = "语音@沉渊者关系对话2",
    BaseSortID = 264,
    AwakerID = 15594,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100029_AwakerVoiceContent|真的什么愿望都能实现吗？算了，这样的捷径想想也不符合成为强者的规律。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15566,
    ReletedVoiceID = 100117,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99990] = {
    ID = 99990,
    CnID = "语音@沉渊者关系对话3",
    BaseSortID = 265,
    AwakerID = 15594,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99990_AwakerVoiceContent|只要勤加锻炼，就能像戈利亚大人一样越来越强吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15564,
    ReletedVoiceID = 100072,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99790] = {
    ID = 99790,
    CnID = "语音@沉渊者关系对话4",
    BaseSortID = 266,
    AwakerID = 15594,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99790_AwakerVoiceContent|全心全意……看来我还是杂念太多了。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15587,
    ReletedVoiceID = 100138,
    FollowUpVoice = 0,
    Sort = 5
  },
  [120258] = {
    ID = 120258,
    CnID = "语音@沉渊者关系对话5",
    BaseSortID = 267,
    AwakerID = 15594,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120258_AwakerVoiceContent|肮脏……还是因为我的血脉不够纯净吗……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77917,
    ReletedVoiceID = 120284,
    FollowUpVoice = 0,
    Sort = 6
  },
  [99831] = {
    ID = 99831,
    CnID = "语音@沉渊者思考",
    BaseSortID = 268,
    AwakerID = 15594,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99831_AwakerVoiceContent|这样的难题也是历练的一种……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [100147] = {
    ID = 100147,
    CnID = "语音@沉渊者催促",
    BaseSortID = 269,
    AwakerID = 15594,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100147_AwakerVoiceContent|尽管出手吧，反正最终的胜利会由我带来！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99819] = {
    ID = 99819,
    CnID = "语音@沉渊者必杀",
    BaseSortID = 270,
    AwakerID = 15594,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99819_AwakerVoiceContent|我会让小瞧我的人付出代价！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100129] = {
    ID = 100129,
    CnID = "语音@沉渊者错误",
    BaseSortID = 271,
    AwakerID = 15594,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100129_AwakerVoiceContent|可恶，为什么，血脉还是没有变化……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99832] = {
    ID = 99832,
    CnID = "语音@沉渊者死亡",
    BaseSortID = 272,
    AwakerID = 15594,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99832_AwakerVoiceContent|潮水的声音……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99741] = {
    ID = 99741,
    CnID = "语音@守梦人普通开场",
    BaseSortID = 273,
    AwakerID = 15566,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99741_AwakerVoiceContent|启航吧，我已为你祈祷。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99873] = {
    ID = 99873,
    CnID = "语音@守梦人关系对话1",
    BaseSortID = 274,
    AwakerID = 15566,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99873_AwakerVoiceContent|需要出海的时候，就向我许愿吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15565,
    ReletedVoiceID = 99816,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99753] = {
    ID = 99753,
    CnID = "语音@守梦人关系对话2",
    BaseSortID = 275,
    AwakerID = 15566,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99753_AwakerVoiceContent|好模糊的愿望，不过，我会尽力为你祈祷的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15604,
    ReletedVoiceID = 100215,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100190] = {
    ID = 100190,
    CnID = "语音@守梦人关系对话3",
    BaseSortID = 276,
    AwakerID = 15566,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100190_AwakerVoiceContent|你也是远航的人吗？那么，我也会为你祈祷的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77922,
    ReletedVoiceID = 100058,
    FollowUpVoice = 0,
    Sort = 4
  },
  [100117] = {
    ID = 100117,
    CnID = "语音@守梦人关系对话4",
    BaseSortID = 277,
    AwakerID = 15566,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100117_AwakerVoiceContent|所以……你还没有说你的愿望是什么？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15594,
    ReletedVoiceID = 100029,
    FollowUpVoice = 0,
    Sort = 5
  },
  [146427] = {
    ID = 146427,
    CnID = "语音@守梦人关系对话5",
    BaseSortID = 278,
    AwakerID = 15566,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146427_AwakerVoiceContent|无尽的杀戮，究竟有何意义……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 145363,
    ReletedVoiceID = 146417,
    FollowUpVoice = 0,
    Sort = 6
  },
  [100174] = {
    ID = 100174,
    CnID = "语音@守梦人思考",
    BaseSortID = 279,
    AwakerID = 15566,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100174_AwakerVoiceContent|如果这是你的愿望，我会尽力。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99986] = {
    ID = 99986,
    CnID = "语音@守梦人催促",
    BaseSortID = 280,
    AwakerID = 15566,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99986_AwakerVoiceContent|要尽快实现啊……",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100201] = {
    ID = 100201,
    CnID = "语音@守梦人必杀",
    BaseSortID = 281,
    AwakerID = 15566,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100201_AwakerVoiceContent|扬起风帆！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99922] = {
    ID = 99922,
    CnID = "语音@守梦人错误",
    BaseSortID = 282,
    AwakerID = 15566,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99922_AwakerVoiceContent|不是这样的愿望？我，理解错了吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100173] = {
    ID = 100173,
    CnID = "语音@守梦人死亡",
    BaseSortID = 283,
    AwakerID = 15566,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100173_AwakerVoiceContent|船……还是沉没了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99904] = {
    ID = 99904,
    CnID = "语音@克珀珊特普通开场",
    BaseSortID = 284,
    AwakerID = 77922,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99904_AwakerVoiceContent|我将以炬火照亮前路！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100058] = {
    ID = 100058,
    CnID = "语音@克珀珊特关系对话1",
    BaseSortID = 285,
    AwakerID = 77922,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100058_AwakerVoiceContent|护佑归航，真是伟大而美好的愿望啊……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15566,
    ReletedVoiceID = 100190,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100183] = {
    ID = 100183,
    CnID = "语音@克珀珊特关系对话2",
    BaseSortID = 286,
    AwakerID = 77922,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100183_AwakerVoiceContent|感谢你的赞美，但不必为我的命运惋惜，我以此为荣，多愁善感的小姐。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15583,
    ReletedVoiceID = 100008,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100118] = {
    ID = 100118,
    CnID = "语音@克珀珊特关系对话3",
    BaseSortID = 287,
    AwakerID = 77922,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100118_AwakerVoiceContent|一位优秀的修理工，在远航之中比船长还要重要。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15565,
    ReletedVoiceID = 99798,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99876] = {
    ID = 99876,
    CnID = "语音@克珀珊特关系对话4",
    BaseSortID = 288,
    AwakerID = 77922,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99876_AwakerVoiceContent|谢谢，这是要在哪个公园建一座城市雕像吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15592,
    ReletedVoiceID = 100153,
    FollowUpVoice = 0,
    Sort = 5
  },
  [99858] = {
    ID = 99858,
    CnID = "语音@克珀珊特思考",
    BaseSortID = 289,
    AwakerID = 77922,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99858_AwakerVoiceContent|接下来，船舵应该左打10度还是15度呢……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100216] = {
    ID = 100216,
    CnID = "语音@克珀珊特催促",
    BaseSortID = 290,
    AwakerID = 77922,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100216_AwakerVoiceContent|该扬起风帆了。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99752] = {
    ID = 99752,
    CnID = "语音@克珀珊特必杀",
    BaseSortID = 291,
    AwakerID = 77922,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99752_AwakerVoiceContent|我的船队永远不会沉没！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99871] = {
    ID = 99871,
    CnID = "语音@克珀珊特错误",
    BaseSortID = 292,
    AwakerID = 77922,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99871_AwakerVoiceContent|船头的方向偏了……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100175] = {
    ID = 100175,
    CnID = "语音@克珀珊特死亡",
    BaseSortID = 293,
    AwakerID = 77922,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100175_AwakerVoiceContent|青蓝的闪光，熄灭了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [120265] = {
    ID = 120265,
    CnID = "语音@本源深海淑女普通开场",
    BaseSortID = 294,
    AwakerID = 15589,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120265_AwakerVoiceContent|让我看看你究竟有何等紧要之事，竟敢惊扰神母的休憩？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [120263] = {
    ID = 120263,
    CnID = "语音@本源深海淑女关系对话1",
    BaseSortID = 295,
    AwakerID = 15589,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120263_AwakerVoiceContent|软弱、天真……一想到过去的我的愚蠢模样，就觉得可笑。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15576,
    ReletedVoiceID = 120285,
    FollowUpVoice = 1,
    Sort = 2
  },
  [120245] = {
    ID = 120245,
    CnID = "语音@本源深海淑女关系对话2",
    BaseSortID = 296,
    AwakerID = 15589,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120245_AwakerVoiceContent|既然知道，还不赶紧把胜利拱手呈上？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15582,
    ReletedVoiceID = 120272,
    FollowUpVoice = 0,
    Sort = 3
  },
  [120267] = {
    ID = 120267,
    CnID = "语音@本源深海淑女关系对话3",
    BaseSortID = 297,
    AwakerID = 15589,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120267_AwakerVoiceContent|屈居于弥利亚姆之下的庸才，为何敢冒犯神母的权威？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15564,
    ReletedVoiceID = 120269,
    FollowUpVoice = 0,
    Sort = 4
  },
  [120282] = {
    ID = 120282,
    CnID = "语音@本源深海淑女关系对话4",
    BaseSortID = 298,
    AwakerID = 15589,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120282_AwakerVoiceContent|你要为我献上神明诞生的至高绘卷吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77926,
    ReletedVoiceID = 120299,
    FollowUpVoice = 1,
    Sort = 5
  },
  [120274] = {
    ID = 120274,
    CnID = "语音@本源深海淑女关系对话5",
    BaseSortID = 299,
    AwakerID = 15589,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120274_AwakerVoiceContent|我也曾如你一般冥顽不灵……为何不肯接纳侍奉神明的伟大命运？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77923,
    ReletedVoiceID = 120252,
    FollowUpVoice = 1,
    Sort = 6
  },
  [120264] = {
    ID = 120264,
    CnID = "语音@本源深海淑女思考",
    BaseSortID = 300,
    AwakerID = 15589,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120264_AwakerVoiceContent|祂的孕育……究竟是在何时？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [120250] = {
    ID = 120250,
    CnID = "语音@本源深海淑女催促",
    BaseSortID = 301,
    AwakerID = 15589,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120250_AwakerVoiceContent|一群蝼蚁。速战速决，本神母要回去安歇了。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [120281] = {
    ID = 120281,
    CnID = "语音@本源深海淑女必杀",
    BaseSortID = 302,
    AwakerID = 15589,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120281_AwakerVoiceContent|哼，不敬之人。",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [120273] = {
    ID = 120273,
    CnID = "语音@本源深海淑女错误",
    BaseSortID = 303,
    AwakerID = 15589,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120273_AwakerVoiceContent|不，我的命运不该如此，一定有哪里出错了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [120266] = {
    ID = 120266,
    CnID = "语音@本源深海淑女死亡",
    BaseSortID = 304,
    AwakerID = 15589,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120266_AwakerVoiceContent|难道……这就是我的宿命？",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100084] = {
    ID = 100084,
    CnID = "语音@石之眼普通开场",
    BaseSortID = 305,
    AwakerID = 15591,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100084_AwakerVoiceContent|艾……艾继丝会努力的！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99915] = {
    ID = 99915,
    CnID = "语音@石之眼关系对话1",
    BaseSortID = 306,
    AwakerID = 15591,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99915_AwakerVoiceContent|呀，你，你小点声呀！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15593,
    ReletedVoiceID = 100157,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100135] = {
    ID = 100135,
    CnID = "语音@石之眼关系对话2",
    BaseSortID = 307,
    AwakerID = 15591,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100135_AwakerVoiceContent|哎？谢谢，我，我也喜欢它们……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15581,
    ReletedVoiceID = 100091,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99854] = {
    ID = 99854,
    CnID = "语音@石之眼关系对话3",
    BaseSortID = 308,
    AwakerID = 15591,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99854_AwakerVoiceContent|那个，可不可以……不和奥吉尔打架？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15585,
    ReletedVoiceID = 99910,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100007] = {
    ID = 100007,
    CnID = "语音@石之眼关系对话4",
    BaseSortID = 309,
    AwakerID = 15591,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100007_AwakerVoiceContent|梅森姐……小姐。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15601,
    ReletedVoiceID = 100111,
    FollowUpVoice = 1,
    Sort = 5
  },
  [99920] = {
    ID = 99920,
    CnID = "语音@石之眼思考",
    BaseSortID = 310,
    AwakerID = 15591,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99920_AwakerVoiceContent|这个……莎拉小姐没有教过……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99997] = {
    ID = 99997,
    CnID = "语音@石之眼催促",
    BaseSortID = 311,
    AwakerID = 15591,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99997_AwakerVoiceContent|请继续吧！艾继丝能坚持住！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99795] = {
    ID = 99795,
    CnID = "语音@石之眼必杀",
    BaseSortID = 312,
    AwakerID = 15591,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99795_AwakerVoiceContent|都停在那里！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100026] = {
    ID = 100026,
    CnID = "语音@石之眼错误",
    BaseSortID = 313,
    AwakerID = 15591,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100026_AwakerVoiceContent|啊，艾继丝又给大家添麻烦了吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100148] = {
    ID = 100148,
    CnID = "语音@石之眼死亡",
    BaseSortID = 314,
    AwakerID = 15591,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100148_AwakerVoiceContent|对不起……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [127014] = {
    ID = 127014,
    CnID = "语音@石之眼关系对话5",
    BaseSortID = 315,
    AwakerID = 15591,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_127014_AwakerVoiceContent|我、我很乖的，请……请不要讨厌艾继丝……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 125346,
    ReletedVoiceID = 127016,
    FollowUpVoice = 0,
    Sort = 11
  },
  [99887] = {
    ID = 99887,
    CnID = "语音@丰穰之息普通开场",
    BaseSortID = 316,
    AwakerID = 15596,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99887_AwakerVoiceContent|哎呀，你又在邀请我了吗？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100120] = {
    ID = 100120,
    CnID = "语音@丰穰之息关系对话1",
    BaseSortID = 317,
    AwakerID = 15596,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100120_AwakerVoiceContent|呵呵，像这样倔强的孩子也别有可爱之处呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15595,
    ReletedVoiceID = 99906,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100025] = {
    ID = 100025,
    CnID = "语音@丰穰之息关系对话2",
    BaseSortID = 318,
    AwakerID = 15596,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100025_AwakerVoiceContent|我每次看到你那无欲无求的脸，也都感到十分无趣呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54116,
    ReletedVoiceID = 100213,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100017] = {
    ID = 100017,
    CnID = "语音@丰穰之息关系对话3",
    BaseSortID = 319,
    AwakerID = 15596,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100017_AwakerVoiceContent|居然有神明要求信徒抛却所有欲望，真是无趣的信仰啊。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15599,
    ReletedVoiceID = 100152,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99901] = {
    ID = 99901,
    CnID = "语音@丰穰之息关系对话4",
    BaseSortID = 320,
    AwakerID = 15596,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99901_AwakerVoiceContent|这样的存在也算是繁衍的一种，真是可爱呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15573,
    ReletedVoiceID = 99875,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100133] = {
    ID = 100133,
    CnID = "语音@丰穰之息关系对话5",
    BaseSortID = 321,
    AwakerID = 15596,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100133_AwakerVoiceContent|呵呵，那就要看你打算熄灭多少家人了。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77913,
    ReletedVoiceID = 99893,
    FollowUpVoice = 0,
    Sort = 6
  },
  [140519] = {
    ID = 140519,
    CnID = "语音@丰穰之息关系对话6",
    BaseSortID = 322,
    AwakerID = 15596,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140519_AwakerVoiceContent|哎呀，和姐姐我同源的力量，是个可爱的孩子呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130226,
    ReletedVoiceID = 140525,
    FollowUpVoice = 1,
    Sort = 7
  },
  [99979] = {
    ID = 99979,
    CnID = "语音@丰穰之息思考",
    BaseSortID = 323,
    AwakerID = 15596,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99979_AwakerVoiceContent|真是令人纠结的选择，虽然我很想全都要呢……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [99806] = {
    ID = 99806,
    CnID = "语音@丰穰之息催促",
    BaseSortID = 324,
    AwakerID = 15596,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99806_AwakerVoiceContent|快些靠近我吧，我已经等不及了~",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [100069] = {
    ID = 100069,
    CnID = "语音@丰穰之息必杀",
    BaseSortID = 325,
    AwakerID = 15596,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100069_AwakerVoiceContent|饮下母树甘美的汁液吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99967] = {
    ID = 99967,
    CnID = "语音@丰穰之息错误",
    BaseSortID = 326,
    AwakerID = 15596,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99967_AwakerVoiceContent|哎呀，好像有些玩过头了……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [99777] = {
    ID = 99777,
    CnID = "语音@丰穰之息死亡",
    BaseSortID = 327,
    AwakerID = 15596,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99777_AwakerVoiceContent|尚未……播种……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [99976] = {
    ID = 99976,
    CnID = "语音@仁爱主祭普通开场",
    BaseSortID = 328,
    AwakerID = 15599,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99976_AwakerVoiceContent|我将听从你的指引，苍白的使者。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100171] = {
    ID = 100171,
    CnID = "语音@仁爱主祭关系对话1",
    BaseSortID = 329,
    AwakerID = 15599,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100171_AwakerVoiceContent|若蒙父垂怜的侍奉者注定要走上荆棘之路，那就至少让我为众生流血到最后一刻吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54116,
    ReletedVoiceID = 100033,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100152] = {
    ID = 100152,
    CnID = "语音@仁爱主祭关系对话2",
    BaseSortID = 330,
    AwakerID = 15599,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100152_AwakerVoiceContent|我并非没有欲望，女士，我渴求着抹去尘世所有的苦痛，我期盼着众生皆能分得圣杯中满是福祉的甘露。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15596,
    ReletedVoiceID = 100017,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99932] = {
    ID = 99932,
    CnID = "语音@仁爱主祭关系对话3",
    BaseSortID = 331,
    AwakerID = 15599,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99932_AwakerVoiceContent|那被我们称之为信的，本身就是一种力量，一种从内生发的、能够让人幸福的力量，阁下。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15563,
    ReletedVoiceID = 99895,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99757] = {
    ID = 99757,
    CnID = "语音@仁爱主祭关系对话4",
    BaseSortID = 332,
    AwakerID = 15599,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99757_AwakerVoiceContent|听说您为死去的亡者赐予了归宿与意义，这也不失为对生命的一种救赎。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 95786,
    ReletedVoiceID = 100009,
    FollowUpVoice = 0,
    Sort = 5
  },
  [124007] = {
    ID = 124007,
    CnID = "语音@仁爱主祭关系对话5",
    BaseSortID = 333,
    AwakerID = 15599,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_124007_AwakerVoiceContent|雾起之时，你的灵魂被欲望与暴行所蒙蔽。唯有持守忍耐到底者，方得救赎。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 94450,
    ReletedVoiceID = 124006,
    FollowUpVoice = 1,
    Sort = 6
  },
  [135225] = {
    ID = 135225,
    CnID = "语音@仁爱主祭关系对话6",
    BaseSortID = 334,
    AwakerID = 15599,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_135225_AwakerVoiceContent|若我经受的痛苦能为世人带来救赎，那么一切都值得付出。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77918,
    ReletedVoiceID = 135217,
    FollowUpVoice = 0,
    Sort = 7
  },
  [99902] = {
    ID = 99902,
    CnID = "语音@仁爱主祭思考",
    BaseSortID = 335,
    AwakerID = 15599,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99902_AwakerVoiceContent|一切救赎的旨意早已记于父的圣言之中……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 8
  },
  [100102] = {
    ID = 100102,
    CnID = "语音@仁爱主祭催促",
    BaseSortID = 336,
    AwakerID = 15599,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100102_AwakerVoiceContent|不必忧心，仁慈的父终会消解苦难。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 9
  },
  [99921] = {
    ID = 99921,
    CnID = "语音@仁爱主祭必杀",
    BaseSortID = 337,
    AwakerID = 15599,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99921_AwakerVoiceContent|聆听父神的教诲吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 10
  },
  [99923] = {
    ID = 99923,
    CnID = "语音@仁爱主祭错误",
    BaseSortID = 338,
    AwakerID = 15599,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99923_AwakerVoiceContent|这或许是不必要的争斗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 11
  },
  [100042] = {
    ID = 100042,
    CnID = "语音@仁爱主祭死亡",
    BaseSortID = 339,
    AwakerID = 15599,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100042_AwakerVoiceContent|父神在呼唤我……",
    TriggerConditions = {"AwakerDied"},
    Sort = 12
  },
  [100108] = {
    ID = 100108,
    CnID = "语音@红夫人普通开场",
    BaseSortID = 340,
    AwakerID = 15584,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100108_AwakerVoiceContent|为了你，我可是盛装出席而来。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99742] = {
    ID = 99742,
    CnID = "语音@红夫人关系对话1",
    BaseSortID = 341,
    AwakerID = 15584,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99742_AwakerVoiceContent|能让珈伦这样勤快地干活，想必她收了你不少小费吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15571,
    ReletedVoiceID = 100189,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100103] = {
    ID = 100103,
    CnID = "语音@红夫人关系对话2",
    BaseSortID = 342,
    AwakerID = 15584,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100103_AwakerVoiceContent|话虽如此，不过我不太喜欢油嘴滑舌的人呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15604,
    ReletedVoiceID = 99771,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99829] = {
    ID = 99829,
    CnID = "语音@红夫人关系对话3",
    BaseSortID = 343,
    AwakerID = 15584,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99829_AwakerVoiceContent|真应该让伦蒂尼恩的贵族们来您的店里看看，像这样有多少财富也买不了的宝物，才是货真价实的奢侈品啊。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15590,
    ReletedVoiceID = 100015,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99813] = {
    ID = 99813,
    CnID = "语音@红夫人关系对话4",
    BaseSortID = 344,
    AwakerID = 15584,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99813_AwakerVoiceContent|恕我直言，您对权力的态度有些过于粗暴了，若只靠暴力与恐惧筑起宝座，那宝座也总有一天会因恐惧滋生的愤怒而坍塌。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15586,
    ReletedVoiceID = 100222,
    FollowUpVoice = 1,
    Sort = 5
  },
  [120271] = {
    ID = 120271,
    CnID = "语音@红夫人关系对话5",
    BaseSortID = 345,
    AwakerID = 15584,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120271_AwakerVoiceContent|想要办一场画展？可惜我和伦蒂尼恩的贵族们并不认为你有这样的才华。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77926,
    ReletedVoiceID = 120260,
    FollowUpVoice = 1,
    Sort = 6
  },
  [100044] = {
    ID = 100044,
    CnID = "语音@红夫人思考",
    BaseSortID = 346,
    AwakerID = 15584,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100044_AwakerVoiceContent|让各方宾客全部满意，才是沙龙主人的能力所在。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [100202] = {
    ID = 100202,
    CnID = "语音@红夫人催促",
    BaseSortID = 347,
    AwakerID = 15584,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100202_AwakerVoiceContent|请继续宴会吧，还是说，我有哪里招待不周吗？",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100054] = {
    ID = 100054,
    CnID = "语音@红夫人必杀",
    BaseSortID = 348,
    AwakerID = 15584,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100054_AwakerVoiceContent|亲吻这红色的裙摆！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99836] = {
    ID = 99836,
    CnID = "语音@红夫人错误",
    BaseSortID = 349,
    AwakerID = 15584,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99836_AwakerVoiceContent|衣服不小心弄脏了，这可不够优雅。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99898] = {
    ID = 99898,
    CnID = "语音@红夫人死亡",
    BaseSortID = 350,
    AwakerID = 15584,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99898_AwakerVoiceContent|如此不留情面，我可是好好记住了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99807] = {
    ID = 99807,
    CnID = "语音@破链者普通开场",
    BaseSortID = 351,
    AwakerID = 15587,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99807_AwakerVoiceContent|战士的剑，现在供你驱使。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100180] = {
    ID = 100180,
    CnID = "语音@破链者关系对话1",
    BaseSortID = 352,
    AwakerID = 15587,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100180_AwakerVoiceContent|来。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15569,
    ReletedVoiceID = 100158,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100032] = {
    ID = 100032,
    CnID = "语音@破链者关系对话2",
    BaseSortID = 353,
    AwakerID = 15587,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100032_AwakerVoiceContent|那就来试试！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15567,
    ReletedVoiceID = 99935,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100138] = {
    ID = 100138,
    CnID = "语音@破链者关系对话3",
    BaseSortID = 354,
    AwakerID = 15587,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100138_AwakerVoiceContent|如何变强？一颗全心全意战斗的心。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15594,
    ReletedVoiceID = 99790,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100143] = {
    ID = 100143,
    CnID = "语音@破链者关系对话4",
    BaseSortID = 355,
    AwakerID = 15587,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100143_AwakerVoiceContent|你，为什么会甘愿成为供人驱使的奴隶？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15598,
    ReletedVoiceID = 99982,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100043] = {
    ID = 100043,
    CnID = "语音@破链者关系对话5",
    BaseSortID = 356,
    AwakerID = 15587,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100043_AwakerVoiceContent|毕竟我们是同源的双子……“姐妹”么，呵。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15581,
    ReletedVoiceID = 99964,
    FollowUpVoice = 0,
    Sort = 6
  },
  [100204] = {
    ID = 100204,
    CnID = "语音@破链者思考",
    BaseSortID = 357,
    AwakerID = 15587,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100204_AwakerVoiceContent|我的剑应斩向何处，才能暂消胸中焚烧的火焰……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99974] = {
    ID = 99974,
    CnID = "语音@破链者催促",
    BaseSortID = 358,
    AwakerID = 15587,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99974_AwakerVoiceContent|复仇之剑，不应犹豫。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100178] = {
    ID = 100178,
    CnID = "语音@破链者必杀",
    BaseSortID = 359,
    AwakerID = 15587,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100178_AwakerVoiceContent|品尝我的怒火吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99977] = {
    ID = 99977,
    CnID = "语音@破链者错误",
    BaseSortID = 360,
    AwakerID = 15587,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99977_AwakerVoiceContent|打偏了……我的力量还不够吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99907] = {
    ID = 99907,
    CnID = "语音@破链者死亡",
    BaseSortID = 361,
    AwakerID = 15587,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99907_AwakerVoiceContent|复仇之火不会熄灭……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100142] = {
    ID = 100142,
    CnID = "语音@本源破链者普通开场",
    BaseSortID = 362,
    AwakerID = 15567,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100142_AwakerVoiceContent|我来了，准备看到一地废墟吧。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99945] = {
    ID = 99945,
    CnID = "语音@本源破链者关系对话1",
    BaseSortID = 363,
    AwakerID = 15567,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99945_AwakerVoiceContent|妄图控制我的人只有一个下场，你做好准备了吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15602,
    ReletedVoiceID = 100081,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99935] = {
    ID = 99935,
    CnID = "语音@本源破链者关系对话2",
    BaseSortID = 364,
    AwakerID = 15567,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99935_AwakerVoiceContent|天真、软弱、无能，你，赢不了我！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15587,
    ReletedVoiceID = 100032,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100047] = {
    ID = 100047,
    CnID = "语音@本源破链者关系对话3",
    BaseSortID = 365,
    AwakerID = 15567,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100047_AwakerVoiceContent|怎么会有这样纠缠不休又砸不烂的东西？真是恶心……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15597,
    ReletedVoiceID = 100184,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100151] = {
    ID = 100151,
    CnID = "语音@本源破链者关系对话4",
    BaseSortID = 366,
    AwakerID = 15567,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100151_AwakerVoiceContent|我讨厌你的嘴脸，你那副温柔的样子和当初我的养母一样虚伪。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77925,
    ReletedVoiceID = 100045,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100207] = {
    ID = 100207,
    CnID = "语音@本源破链者思考",
    BaseSortID = 367,
    AwakerID = 15567,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100207_AwakerVoiceContent|要扭断脖子，还是捅穿心脏呢……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99822] = {
    ID = 99822,
    CnID = "语音@本源破链者催促",
    BaseSortID = 368,
    AwakerID = 15567,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99822_AwakerVoiceContent|我已经迫不及待将你的鲜血涂在我的链条上了……",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99792] = {
    ID = 99792,
    CnID = "语音@本源破链者必杀",
    BaseSortID = 369,
    AwakerID = 15567,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99792_AwakerVoiceContent|求饶也没用，在见到我的一刻，你就该想到死亡的结局！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100109] = {
    ID = 100109,
    CnID = "语音@本源破链者错误",
    BaseSortID = 370,
    AwakerID = 15567,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100109_AwakerVoiceContent|这次没有砸扁你的脑袋，下次可不会了……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99841] = {
    ID = 99841,
    CnID = "语音@本源破链者死亡",
    BaseSortID = 371,
    AwakerID = 15567,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99841_AwakerVoiceContent|绝不原谅……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100046] = {
    ID = 100046,
    CnID = "语音@猩红普通开场",
    BaseSortID = 372,
    AwakerID = 15598,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100046_AwakerVoiceContent|只要不断给我血，我就能一直为你打下去。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100123] = {
    ID = 100123,
    CnID = "语音@猩红关系对话1",
    BaseSortID = 373,
    AwakerID = 15598,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100123_AwakerVoiceContent|哈哈哈哈，杀——",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15569,
    ReletedVoiceID = 99924,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99999] = {
    ID = 99999,
    CnID = "语音@猩红关系对话2",
    BaseSortID = 374,
    AwakerID = 15598,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99999_AwakerVoiceContent|无所谓，他们早就死光了。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15588,
    ReletedVoiceID = 100073,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99982] = {
    ID = 99982,
    CnID = "语音@猩红关系对话3",
    BaseSortID = 375,
    AwakerID = 15598,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99982_AwakerVoiceContent|喝谁的血都一样，况且……我可以随时扭断他们的脖子？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15587,
    ReletedVoiceID = 100143,
    FollowUpVoice = 0,
    Sort = 4
  },
  [100211] = {
    ID = 100211,
    CnID = "语音@猩红关系对话4",
    BaseSortID = 376,
    AwakerID = 15598,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100211_AwakerVoiceContent|我什么都不想要，离我远点！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15597,
    ReletedVoiceID = 100115,
    FollowUpVoice = 0,
    Sort = 5
  },
  [146420] = {
    ID = 146420,
    CnID = "语音@猩红关系对话5",
    BaseSortID = 377,
    AwakerID = 15598,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146420_AwakerVoiceContent|我闻到了！血的气味，如此强烈……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 145363,
    ReletedVoiceID = 146421,
    FollowUpVoice = 1,
    Sort = 6
  },
  [99968] = {
    ID = 99968,
    CnID = "语音@猩红思考",
    BaseSortID = 378,
    AwakerID = 15598,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99968_AwakerVoiceContent|直接撕掉他的头怎么样？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99884] = {
    ID = 99884,
    CnID = "语音@猩红催促",
    BaseSortID = 379,
    AwakerID = 15598,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99884_AwakerVoiceContent|鲜血的味道，我已经等不及了！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100122] = {
    ID = 100122,
    CnID = "语音@猩红必杀",
    BaseSortID = 380,
    AwakerID = 15598,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100122_AwakerVoiceContent|哈哈哈哈哈，杀，杀！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100063] = {
    ID = 100063,
    CnID = "语音@猩红错误",
    BaseSortID = 381,
    AwakerID = 15598,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100063_AwakerVoiceContent|没有血？怎么会有人没有血……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100018] = {
    ID = 100018,
    CnID = "语音@猩红死亡",
    BaseSortID = 382,
    AwakerID = 15598,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100018_AwakerVoiceContent|战士，就该在战场站立到最后一刻……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100156] = {
    ID = 100156,
    CnID = "语音@渴血患者普通开场",
    BaseSortID = 383,
    AwakerID = 15597,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100156_AwakerVoiceContent|不要怜惜，请尽情地伤害我吧！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100115] = {
    ID = 100115,
    CnID = "语音@渴血患者关系对话1",
    BaseSortID = 384,
    AwakerID = 15597,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100115_AwakerVoiceContent|啊啊，尤乌哈希大人，这次您还想要我的牙齿吗，或者手指、耳朵……都可以的！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15598,
    ReletedVoiceID = 100211,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100184] = {
    ID = 100184,
    CnID = "语音@渴血患者关系对话2",
    BaseSortID = 385,
    AwakerID = 15597,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100184_AwakerVoiceContent|太棒了，这种级别的痛苦真是太棒了！感谢你的馈赠，好心人！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15567,
    ReletedVoiceID = 100047,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100136] = {
    ID = 100136,
    CnID = "语音@渴血患者关系对话3",
    BaseSortID = 386,
    AwakerID = 15597,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100136_AwakerVoiceContent|迷宫之主大人，我愿意做您的奴隶！那么您能够每天奖励我两个小时……不，三个小时的鞭打吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15600,
    ReletedVoiceID = 100160,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100052] = {
    ID = 100052,
    CnID = "语音@渴血患者关系对话4",
    BaseSortID = 387,
    AwakerID = 15597,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100052_AwakerVoiceContent|如果向机械人偶下达指令的话，可以获得鞭打的疼痛吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15603,
    ReletedVoiceID = 99867,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100166] = {
    ID = 100166,
    CnID = "语音@渴血患者关系对话5",
    BaseSortID = 388,
    AwakerID = 15597,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100166_AwakerVoiceContent|啊，是潘狄娅大人！大人是来赐予我甜蜜的痛苦的吗？！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15560,
    ReletedVoiceID = 99830,
    FollowUpVoice = 1,
    Sort = 6
  },
  [99756] = {
    ID = 99756,
    CnID = "语音@渴血患者思考",
    BaseSortID = 389,
    AwakerID = 15597,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99756_AwakerVoiceContent|怎样做才能获得更多的疼痛呢……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99918] = {
    ID = 99918,
    CnID = "语音@渴血患者催促",
    BaseSortID = 390,
    AwakerID = 15597,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99918_AwakerVoiceContent|血或者疼痛，您总要给我一个呀……",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99889] = {
    ID = 99889,
    CnID = "语音@渴血患者必杀",
    BaseSortID = 391,
    AwakerID = 15597,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99889_AwakerVoiceContent|这样甘美的享受，我会慷慨分享的！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99860] = {
    ID = 99860,
    CnID = "语音@渴血患者错误",
    BaseSortID = 392,
    AwakerID = 15597,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99860_AwakerVoiceContent|呀，太轻了，完全没有感觉啊。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [99954] = {
    ID = 99954,
    CnID = "语音@渴血患者死亡",
    BaseSortID = 393,
    AwakerID = 15597,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99954_AwakerVoiceContent|我愿意领受失败的惩罚……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100161] = {
    ID = 100161,
    CnID = "语音@星之芽普通开场",
    BaseSortID = 394,
    AwakerID = 15577,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100161_AwakerVoiceContent|我不能离你们太近……",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99970] = {
    ID = 99970,
    CnID = "语音@星之芽关系对话1",
    BaseSortID = 395,
    AwakerID = 15577,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99970_AwakerVoiceContent|啊啊汀克特！不要突然喊出这种令人羞耻的话啊……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15574,
    ReletedVoiceID = 100082,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99797] = {
    ID = 99797,
    CnID = "语音@星之芽关系对话2",
    BaseSortID = 396,
    AwakerID = 15577,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99797_AwakerVoiceContent|可是，太靠近的话，你的能量会被吸走……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15579,
    ReletedVoiceID = 100126,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99851] = {
    ID = 99851,
    CnID = "语音@星之芽关系对话3",
    BaseSortID = 397,
    AwakerID = 15577,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99851_AwakerVoiceContent|虽然听不懂你在说什么，但让人感觉很不舒服呢……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 95786,
    ReletedVoiceID = 100177,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99897] = {
    ID = 99897,
    CnID = "语音@星之芽关系对话4",
    BaseSortID = 398,
    AwakerID = 15577,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99897_AwakerVoiceContent|多么修长的四肢，舒展的身体……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15562,
    ReletedVoiceID = 99850,
    FollowUpVoice = 1,
    Sort = 5
  },
  [120254] = {
    ID = 120254,
    CnID = "语音@星之芽关系对话5",
    BaseSortID = 399,
    AwakerID = 15577,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120254_AwakerVoiceContent|请、请不要再靠近我了，你会受伤的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77923,
    ReletedVoiceID = 120249,
    FollowUpVoice = 1,
    Sort = 6
  },
  [100186] = {
    ID = 100186,
    CnID = "语音@星之芽思考",
    BaseSortID = 400,
    AwakerID = 15577,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100186_AwakerVoiceContent|我会保护你的，即使身处壳中。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99814] = {
    ID = 99814,
    CnID = "语音@星之芽催促",
    BaseSortID = 401,
    AwakerID = 15577,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99814_AwakerVoiceContent|我快要无法控制吸取的冲动了……",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99820] = {
    ID = 99820,
    CnID = "语音@星之芽必杀",
    BaseSortID = 402,
    AwakerID = 15577,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99820_AwakerVoiceContent|注视我独一无二的色彩吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100104] = {
    ID = 100104,
    CnID = "语音@星之芽错误",
    BaseSortID = 403,
    AwakerID = 15577,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100104_AwakerVoiceContent|不小心又吸收了能量……我再离远一点！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100024] = {
    ID = 100024,
    CnID = "语音@星之芽死亡",
    BaseSortID = 404,
    AwakerID = 15577,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100024_AwakerVoiceContent|下次，让我走出摇篮吧……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99969] = {
    ID = 99969,
    CnID = "语音@迷宫蛛普通开场",
    BaseSortID = 405,
    AwakerID = 15600,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99969_AwakerVoiceContent|伟大的迷宫之神降临了，颤抖吧奴隶们！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100001] = {
    ID = 100001,
    CnID = "语音@迷宫蛛关系对话1",
    BaseSortID = 406,
    AwakerID = 15600,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100001_AwakerVoiceContent|你是专业的奴隶吧，去，给我把迷宫都打扫一遍！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15571,
    ReletedVoiceID = 99824,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100022] = {
    ID = 100022,
    CnID = "语音@迷宫蛛关系对话2",
    BaseSortID = 407,
    AwakerID = 15600,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100022_AwakerVoiceContent|哼，子嗣可不是什么伙伴，那都是匍匐于伟大迷宫之主脚下的奴隶！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15573,
    ReletedVoiceID = 99930,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100160] = {
    ID = 100160,
    CnID = "语音@迷宫蛛关系对话3",
    BaseSortID = 408,
    AwakerID = 15600,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100160_AwakerVoiceContent|那当然……什么？三个小时？这也太累了吧！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15597,
    ReletedVoiceID = 100136,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99933] = {
    ID = 99933,
    CnID = "语音@迷宫蛛关系对话4",
    BaseSortID = 409,
    AwakerID = 15600,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99933_AwakerVoiceContent|喂，教教我，怎样才能获得那么多的奴隶？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15586,
    ReletedVoiceID = 100036,
    FollowUpVoice = 1,
    Sort = 5
  },
  [150097] = {
    ID = 150097,
    CnID = "语音@迷宫蛛关系对话5",
    BaseSortID = 410,
    AwakerID = 15600,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150097_AwakerVoiceContent|喂！那个让人不爽的眼神是什么意思！你给我%……*#¥*！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77921,
    ReletedVoiceID = 150099,
    FollowUpVoice = 0,
    Sort = 6
  },
  [100165] = {
    ID = 100165,
    CnID = "语音@迷宫蛛思考",
    BaseSortID = 411,
    AwakerID = 15600,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100165_AwakerVoiceContent|别吵，这种简单的事……干脆让所有角斗士一起上好了！",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99950] = {
    ID = 99950,
    CnID = "语音@迷宫蛛催促",
    BaseSortID = 412,
    AwakerID = 15600,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99950_AwakerVoiceContent|喂，快打啊，角斗的过程怎么能停下！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [100005] = {
    ID = 100005,
    CnID = "语音@迷宫蛛必杀",
    BaseSortID = 413,
    AwakerID = 15600,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100005_AwakerVoiceContent|准备迎接苍白之主的审判吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99862] = {
    ID = 99862,
    CnID = "语音@迷宫蛛错误",
    BaseSortID = 414,
    AwakerID = 15600,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99862_AwakerVoiceContent|咦？又搞错了？这么麻烦的规矩到底是谁定下的！我不玩了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100070] = {
    ID = 100070,
    CnID = "语音@迷宫蛛死亡",
    BaseSortID = 415,
    AwakerID = 15600,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100070_AwakerVoiceContent|可恶，把你们都拿去喂子嗣……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99764] = {
    ID = 99764,
    CnID = "语音@杜勒赛因普通开场",
    BaseSortID = 416,
    AwakerID = 95786,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99764_AwakerVoiceContent|死者之友、死亡之神，向您致敬。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99773] = {
    ID = 99773,
    CnID = "语音@杜勒赛因关系对话1",
    BaseSortID = 417,
    AwakerID = 95786,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99773_AwakerVoiceContent|完美的仆人，只差最后一步……成为死灵。这位小姐，有兴趣加入我们的盛筵吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15571,
    ReletedVoiceID = 99842,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100065] = {
    ID = 100065,
    CnID = "语音@杜勒赛因关系对话2",
    BaseSortID = 418,
    AwakerID = 95786,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100065_AwakerVoiceContent|这位小姐，我不禁要夸赞你身上那奇异而芬芳的，来自海洋的香味……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15576,
    ReletedVoiceID = 99943,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100009] = {
    ID = 100009,
    CnID = "语音@杜勒赛因关系对话3",
    BaseSortID = 419,
    AwakerID = 95786,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100009_AwakerVoiceContent|嗯……赞美生命的信仰，一如既往的没有什么新意又无聊啊。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15599,
    ReletedVoiceID = 99757,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100177] = {
    ID = 100177,
    CnID = "语音@杜勒赛因关系对话4",
    BaseSortID = 420,
    AwakerID = 95786,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100177_AwakerVoiceContent|吸收了如此多的生命力量，却仍然如此娇小的身躯究竟会是什么味道呢？请务必让我在您的终局之后品尝一番。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15577,
    ReletedVoiceID = 99851,
    FollowUpVoice = 1,
    Sort = 5
  },
  [120262] = {
    ID = 120262,
    CnID = "语音@杜勒赛因关系对话5",
    BaseSortID = 421,
    AwakerID = 95786,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120262_AwakerVoiceContent|我欣赏你的才华，可惜亵渎尸体有违我的艺术，我会给你一个认错的机会。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77926,
    ReletedVoiceID = 120253,
    FollowUpVoice = 1,
    Sort = 6
  },
  [100146] = {
    ID = 100146,
    CnID = "语音@杜勒赛因思考",
    BaseSortID = 422,
    AwakerID = 95786,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100146_AwakerVoiceContent|耐心些，复杂的处理方式能让食材焕发出充满层次的味道。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99787] = {
    ID = 99787,
    CnID = "语音@杜勒赛因催促",
    BaseSortID = 423,
    AwakerID = 95786,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99787_AwakerVoiceContent|再等下去，美食可就要凉了呀。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99784] = {
    ID = 99784,
    CnID = "语音@杜勒赛因必杀",
    BaseSortID = 424,
    AwakerID = 95786,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99784_AwakerVoiceContent|我将为你带来一场芬芳的盛宴——",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [99843] = {
    ID = 99843,
    CnID = "语音@杜勒赛因错误",
    BaseSortID = 425,
    AwakerID = 95786,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99843_AwakerVoiceContent|唉呀，火候不到家呀。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100034] = {
    ID = 100034,
    CnID = "语音@杜勒赛因死亡",
    BaseSortID = 426,
    AwakerID = 95786,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100034_AwakerVoiceContent|归于安宁……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [120261] = {
    ID = 120261,
    CnID = "语音@皮克曼普通开场",
    BaseSortID = 427,
    AwakerID = 77926,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120261_AwakerVoiceContent|来吧！见证我的艺术！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [120253] = {
    ID = 120253,
    CnID = "语音@皮克曼关系对话1",
    BaseSortID = 428,
    AwakerID = 77926,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120253_AwakerVoiceContent|可恶，就算你是杜勒赛因也不可以侮辱我的画作！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 95786,
    ReletedVoiceID = 120262,
    FollowUpVoice = 0,
    Sort = 2
  },
  [120247] = {
    ID = 120247,
    CnID = "语音@皮克曼关系对话2",
    BaseSortID = 429,
    AwakerID = 77926,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120247_AwakerVoiceContent|珊，让我们来一场艺术的切磋吧！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15592,
    ReletedVoiceID = 120276,
    FollowUpVoice = 1,
    Sort = 3
  },
  [120270] = {
    ID = 120270,
    CnID = "语音@皮克曼关系对话3",
    BaseSortID = 430,
    AwakerID = 77926,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120270_AwakerVoiceContent|啊啊啊啊怎么连你也要干扰我的创作？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15585,
    ReletedVoiceID = 120244,
    FollowUpVoice = 0,
    Sort = 4
  },
  [120260] = {
    ID = 120260,
    CnID = "语音@皮克曼关系对话4",
    BaseSortID = 431,
    AwakerID = 77926,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120260_AwakerVoiceContent|索蕾尔夫人，我会向你们证明什么才是真正的艺术！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15584,
    ReletedVoiceID = 120271,
    FollowUpVoice = 0,
    Sort = 5
  },
  [120299] = {
    ID = 120299,
    CnID = "语音@皮克曼关系对话5",
    BaseSortID = 432,
    AwakerID = 77926,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120299_AwakerVoiceContent|不，不……灵感之神已经为这幅画作赐名《囚笼中的圣母》！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15589,
    ReletedVoiceID = 120282,
    FollowUpVoice = 0,
    Sort = 6
  },
  [120246] = {
    ID = 120246,
    CnID = "语音@皮克曼思考",
    BaseSortID = 433,
    AwakerID = 77926,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120246_AwakerVoiceContent|应该如何构图呢？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [120255] = {
    ID = 120255,
    CnID = "语音@皮克曼催促",
    BaseSortID = 434,
    AwakerID = 77926,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120255_AwakerVoiceContent|灵感枯竭了……不行，我需要新的模特！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [120277] = {
    ID = 120277,
    CnID = "语音@皮克曼必杀",
    BaseSortID = 435,
    AwakerID = 77926,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120277_AwakerVoiceContent|成为我的模特吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [120251] = {
    ID = 120251,
    CnID = "语音@皮克曼错误",
    BaseSortID = 436,
    AwakerID = 77926,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120251_AwakerVoiceContent|差一点！只差一点我就能创造出完美的作品了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [120257] = {
    ID = 120257,
    CnID = "语音@皮克曼死亡",
    BaseSortID = 437,
    AwakerID = 77926,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120257_AwakerVoiceContent|我的画作……还没有完成……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [99874] = {
    ID = 99874,
    CnID = "语音@猎颅魔女普通开场",
    BaseSortID = 438,
    AwakerID = 15590,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99874_AwakerVoiceContent|新委托的报酬，想必您已经准备好了？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99869] = {
    ID = 99869,
    CnID = "语音@猎颅魔女关系对话1",
    BaseSortID = 439,
    AwakerID = 15590,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99869_AwakerVoiceContent|希望你稍微听话一些呢，我对驯化怪物这件事可没有她那样耐心。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15572,
    ReletedVoiceID = 99937,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100015] = {
    ID = 100015,
    CnID = "语音@猎颅魔女关系对话2",
    BaseSortID = 440,
    AwakerID = 15590,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100015_AwakerVoiceContent|过奖了，小店只是公平交易而已，要是来了太多只看不买的客人，我也是会头疼的呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15584,
    ReletedVoiceID = 99829,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99808] = {
    ID = 99808,
    CnID = "语音@猎颅魔女关系对话3",
    BaseSortID = 441,
    AwakerID = 15590,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99808_AwakerVoiceContent|如果好运也能作为商品，想必会很受欢迎吧……别担心，我不是那种会交易人灵魂的魔鬼。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15604,
    ReletedVoiceID = 99835,
    FollowUpVoice = 1,
    Sort = 4
  },
  [99815] = {
    ID = 99815,
    CnID = "语音@猎颅魔女关系对话4",
    BaseSortID = 442,
    AwakerID = 15590,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99815_AwakerVoiceContent|不听话的小老鼠，可是要被五花大绑起来挠痒痒的哦。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15593,
    ReletedVoiceID = 99772,
    Sort = 5
  },
  [146418] = {
    ID = 146418,
    CnID = "语音@猎颅魔女关系对话5",
    BaseSortID = 443,
    AwakerID = 15590,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146418_AwakerVoiceContent|找错了猎物的猎手，是会为自己的冒失付出代价的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 145363,
    ReletedVoiceID = 146415,
    FollowUpVoice = 0,
    Sort = 6
  },
  [99941] = {
    ID = 99941,
    CnID = "语音@猎颅魔女思考",
    BaseSortID = 444,
    AwakerID = 15590,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99941_AwakerVoiceContent|嗯……这有些难度，但当然是我可以为您解决的。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 7
  },
  [99778] = {
    ID = 99778,
    CnID = "语音@猎颅魔女催促",
    BaseSortID = 445,
    AwakerID = 15590,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99778_AwakerVoiceContent|过多的等待时间，也要计算在委托的费用中哦。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 8
  },
  [99892] = {
    ID = 99892,
    CnID = "语音@猎颅魔女必杀",
    BaseSortID = 446,
    AwakerID = 15590,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99892_AwakerVoiceContent|这是无尽头颅的海洋！",
    TriggerConditions = {"SkillReady"},
    Sort = 9
  },
  [100060] = {
    ID = 100060,
    CnID = "语音@猎颅魔女错误",
    BaseSortID = 447,
    AwakerID = 15590,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100060_AwakerVoiceContent|真是抱歉，失误的部分就不收取费用了。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 10
  },
  [100219] = {
    ID = 100219,
    CnID = "语音@猎颅魔女死亡",
    BaseSortID = 448,
    AwakerID = 15590,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100219_AwakerVoiceContent|我也有力所不能及的时刻呀……",
    TriggerConditions = {"AwakerDied"},
    Sort = 11
  },
  [100134] = {
    ID = 100134,
    CnID = "语音@奇术师普通开场",
    BaseSortID = 449,
    AwakerID = 15572,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100134_AwakerVoiceContent|嘭——魔术大师登场！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99937] = {
    ID = 99937,
    CnID = "语音@奇术师关系对话1",
    BaseSortID = 450,
    AwakerID = 15572,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99937_AwakerVoiceContent|好的店长，明白了店长！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15590,
    ReletedVoiceID = 99869,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100185] = {
    ID = 100185,
    CnID = "语音@奇术师关系对话2",
    BaseSortID = 451,
    AwakerID = 15572,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100185_AwakerVoiceContent|哎？魔术只是让大家笑一笑的东西啦，卡茜亚可办不到那么厉害的事。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15579,
    ReletedVoiceID = 100011,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100176] = {
    ID = 100176,
    CnID = "语音@奇术师关系对话3",
    BaseSortID = 452,
    AwakerID = 15572,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100176_AwakerVoiceContent|咦，这里我应该生气吗？即使你这样说，我也什么都感觉不到呀。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77925,
    ReletedVoiceID = 99866,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99881] = {
    ID = 99881,
    CnID = "语音@奇术师关系对话4",
    BaseSortID = 453,
    AwakerID = 15572,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99881_AwakerVoiceContent|哇，能教会卡茜亚恐惧？我要试我要试！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15586,
    ReletedVoiceID = 100016,
    FollowUpVoice = 0,
    Sort = 5
  },
  [99992] = {
    ID = 99992,
    CnID = "语音@奇术师思考",
    BaseSortID = 454,
    AwakerID = 15572,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99992_AwakerVoiceContent|猜一猜，哪一顶帽子里面有小球？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99803] = {
    ID = 99803,
    CnID = "语音@奇术师催促",
    BaseSortID = 455,
    AwakerID = 15572,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99803_AwakerVoiceContent|快猜呀，魔术没了观众互动不就失去意义了嘛！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99983] = {
    ID = 99983,
    CnID = "语音@奇术师必杀",
    BaseSortID = 456,
    AwakerID = 15572,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99983_AwakerVoiceContent|让我来揭开演出的幕布！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99767] = {
    ID = 99767,
    CnID = "语音@奇术师错误",
    BaseSortID = 457,
    AwakerID = 15572,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99767_AwakerVoiceContent|哎呀，好险好险，差点穿帮了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100199] = {
    ID = 100199,
    CnID = "语音@奇术师死亡",
    BaseSortID = 458,
    AwakerID = 15572,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100199_AwakerVoiceContent|我的演出……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99743] = {
    ID = 99743,
    CnID = "语音@嘀嗒人普通开场",
    BaseSortID = 459,
    AwakerID = 15603,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99743_AwakerVoiceContent|自动人偶艾瑞卡，很高兴为你效劳。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99838] = {
    ID = 99838,
    CnID = "语音@嘀嗒人关系对话1",
    BaseSortID = 460,
    AwakerID = 15603,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99838_AwakerVoiceContent|收到指令，正在记录战斗数据。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15570,
    ReletedVoiceID = 99840,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99882] = {
    ID = 99882,
    CnID = "语音@嘀嗒人关系对话2",
    BaseSortID = 461,
    AwakerID = 15603,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99882_AwakerVoiceContent|驳回请求，检修权限未通过。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15565,
    ReletedVoiceID = 99951,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99853] = {
    ID = 99853,
    CnID = "语音@嘀嗒人关系对话3",
    BaseSortID = 462,
    AwakerID = 15603,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99853_AwakerVoiceContent|回答您的问题：不会，本机体已装配先进的防御系统，并可以与攻击系统无缝切换。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15560,
    ReletedVoiceID = 100094,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99867] = {
    ID = 99867,
    CnID = "语音@嘀嗒人关系对话4",
    BaseSortID = 463,
    AwakerID = 15603,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99867_AwakerVoiceContent|当然，我会打死死死死——抱歉，系统错误，您刚才提交的申请不在艾瑞卡的服务范围内。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15597,
    ReletedVoiceID = 100052,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100110] = {
    ID = 100110,
    CnID = "语音@嘀嗒人思考",
    BaseSortID = 464,
    AwakerID = 15603,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100110_AwakerVoiceContent|正在检索战斗系统方案。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99870] = {
    ID = 99870,
    CnID = "语音@嘀嗒人催促",
    BaseSortID = 465,
    AwakerID = 15603,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99870_AwakerVoiceContent|请下达战斗指令。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99940] = {
    ID = 99940,
    CnID = "语音@嘀嗒人必杀",
    BaseSortID = 466,
    AwakerID = 15603,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99940_AwakerVoiceContent|杀伤性爆破武器准备启动——",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99775] = {
    ID = 99775,
    CnID = "语音@嘀嗒人错误",
    BaseSortID = 467,
    AwakerID = 15603,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99775_AwakerVoiceContent|系统故障，请尝试重新启动。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99769] = {
    ID = 99769,
    CnID = "语音@嘀嗒人死亡",
    BaseSortID = 468,
    AwakerID = 15603,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99769_AwakerVoiceContent|机体功能损毁，请前往弥萨格资源管理室递交维修申请。",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100112] = {
    ID = 100112,
    CnID = "语音@青炎舞者普通开场",
    BaseSortID = 469,
    AwakerID = 15562,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100112_AwakerVoiceContent|你需要的，是这青绿色的火焰吗？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100037] = {
    ID = 100037,
    CnID = "语音@青炎舞者关系对话1",
    BaseSortID = 470,
    AwakerID = 15562,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100037_AwakerVoiceContent|好优雅的乐声，如果在跳舞时能有这样的伴奏……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54117,
    ReletedVoiceID = 100107,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99802] = {
    ID = 99802,
    CnID = "语音@青炎舞者关系对话2",
    BaseSortID = 471,
    AwakerID = 15562,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99802_AwakerVoiceContent|承蒙夸赞，您是想……邀请我作雕塑的模特吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15592,
    ReletedVoiceID = 99952,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99987] = {
    ID = 99987,
    CnID = "语音@青炎舞者关系对话3",
    BaseSortID = 472,
    AwakerID = 15562,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99987_AwakerVoiceContent|不用这样想，在舞台之上，音乐与舞蹈都是平等的，也可以说这是你在为我伴唱呢？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15574,
    ReletedVoiceID = 99939,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99850] = {
    ID = 99850,
    CnID = "语音@青炎舞者关系对话4",
    BaseSortID = 473,
    AwakerID = 15562,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99850_AwakerVoiceContent|你的身体也很美，如果你想学习舞蹈，我可以教你，你也可以做到的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15577,
    ReletedVoiceID = 99897,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100194] = {
    ID = 100194,
    CnID = "语音@青炎舞者思考",
    BaseSortID = 474,
    AwakerID = 15562,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100194_AwakerVoiceContent|下一个八拍要编入怎样的舞步呢……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99883] = {
    ID = 99883,
    CnID = "语音@青炎舞者催促",
    BaseSortID = 475,
    AwakerID = 15562,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99883_AwakerVoiceContent|跟上节奏，手臂抬起来！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99953] = {
    ID = 99953,
    CnID = "语音@青炎舞者必杀",
    BaseSortID = 476,
    AwakerID = 15562,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99953_AwakerVoiceContent|在绿炎的拥抱中一同燃烧吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100205] = {
    ID = 100205,
    CnID = "语音@青炎舞者错误",
    BaseSortID = 477,
    AwakerID = 15562,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100205_AwakerVoiceContent|不，不对，这里要多转一圈。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100139] = {
    ID = 100139,
    CnID = "语音@青炎舞者死亡",
    BaseSortID = 478,
    AwakerID = 15562,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100139_AwakerVoiceContent|化为……灰烬……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100014] = {
    ID = 100014,
    CnID = "语音@歌者普通开场",
    BaseSortID = 479,
    AwakerID = 15574,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100014_AwakerVoiceContent|希望这副歌喉能为您带来愉悦的时光。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99859] = {
    ID = 99859,
    CnID = "语音@歌者关系对话1",
    BaseSortID = 480,
    AwakerID = 15574,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99859_AwakerVoiceContent|能得到您的赞美，我很荣幸，期待我们日后有合作的机会。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54117,
    ReletedVoiceID = 99848,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99957] = {
    ID = 99957,
    CnID = "语音@歌者关系对话2",
    BaseSortID = 481,
    AwakerID = 15574,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99957_AwakerVoiceContent|读了您的诗句后，我一直想将它们编成歌曲来咏唱，不知道奥尔拉小姐是否愿意？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15583,
    ReletedVoiceID = 99936,
    FollowUpVoice = 1,
    Sort = 3
  },
  [99939] = {
    ID = 99939,
    CnID = "语音@歌者关系对话3",
    BaseSortID = 482,
    AwakerID = 15574,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99939_AwakerVoiceContent|虽然我非常想邀请你为我的演唱伴舞，但会不会有些屈就你的舞姿？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15562,
    ReletedVoiceID = 99987,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100082] = {
    ID = 100082,
    CnID = "语音@歌者关系对话4",
    BaseSortID = 483,
    AwakerID = 15574,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100082_AwakerVoiceContent|尽情释放吧，姐姐，让他们看看你的色彩！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15577,
    ReletedVoiceID = 99970,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100098] = {
    ID = 100098,
    CnID = "语音@歌者思考",
    BaseSortID = 484,
    AwakerID = 15574,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100098_AwakerVoiceContent|您喜欢高亢的曲子，还是更宁静些的？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99900] = {
    ID = 99900,
    CnID = "语音@歌者催促",
    BaseSortID = 485,
    AwakerID = 15574,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99900_AwakerVoiceContent|请全心全意，聆听我的声音。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99809] = {
    ID = 99809,
    CnID = "语音@歌者必杀",
    BaseSortID = 486,
    AwakerID = 15574,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99809_AwakerVoiceContent|我将为您高歌！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99776] = {
    ID = 99776,
    CnID = "语音@歌者错误",
    BaseSortID = 487,
    AwakerID = 15574,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99776_AwakerVoiceContent|不小心唱错了歌词，实在太不应该了。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99903] = {
    ID = 99903,
    CnID = "语音@歌者死亡",
    BaseSortID = 488,
    AwakerID = 15574,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99903_AwakerVoiceContent|星星……坠落……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99961] = {
    ID = 99961,
    CnID = "语音@荆棘女王普通开场",
    BaseSortID = 489,
    AwakerID = 15586,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99961_AwakerVoiceContent|低下你的头，然后跪下。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99796] = {
    ID = 99796,
    CnID = "语音@荆棘女王关系对话1",
    BaseSortID = 490,
    AwakerID = 15586,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99796_AwakerVoiceContent|那样不入流的鞭打，是在给人挠痒痒吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15560,
    ReletedVoiceID = 100193,
    FollowUpVoice = 1,
    Sort = 2
  },
  [100222] = {
    ID = 100222,
    CnID = "语音@荆棘女王关系对话2",
    BaseSortID = 491,
    AwakerID = 15586,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100222_AwakerVoiceContent|那又如何？羔羊之间有怎样的法则，我不在乎，也不必遵守。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15584,
    ReletedVoiceID = 99813,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100036] = {
    ID = 100036,
    CnID = "语音@荆棘女王关系对话3",
    BaseSortID = 492,
    AwakerID = 15586,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100036_AwakerVoiceContent|很简单，你只需要将他们踩在脚下每天抽打，必要的时候做成肉泥，所有人都会臣服于你的。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15600,
    ReletedVoiceID = 99933,
    FollowUpVoice = 0,
    Sort = 4
  },
  [100016] = {
    ID = 100016,
    CnID = "语音@荆棘女王关系对话4",
    BaseSortID = 493,
    AwakerID = 15586,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100016_AwakerVoiceContent|不懂的惧怕的奴隶吗？很好，很有调教的趣味。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15572,
    ReletedVoiceID = 99881,
    FollowUpVoice = 1,
    Sort = 5
  },
  [99746] = {
    ID = 99746,
    CnID = "语音@荆棘女王思考",
    BaseSortID = 494,
    AwakerID = 15586,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99746_AwakerVoiceContent|你的双手还算好看，砍了实在可惜。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100002] = {
    ID = 100002,
    CnID = "语音@荆棘女王催促",
    BaseSortID = 495,
    AwakerID = 15586,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100002_AwakerVoiceContent|如果再让我等，就把你的四肢全部砍下，做成肉泥。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100149] = {
    ID = 100149,
    CnID = "语音@荆棘女王必杀",
    BaseSortID = 496,
    AwakerID = 15586,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100149_AwakerVoiceContent|哭着求饶吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100141] = {
    ID = 100141,
    CnID = "语音@荆棘女王错误",
    BaseSortID = 497,
    AwakerID = 15586,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100141_AwakerVoiceContent|一次犯错只需惩罚，两次犯错便是愚蠢，我讨厌愚蠢的仆从。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100206] = {
    ID = 100206,
    CnID = "语音@荆棘女王死亡",
    BaseSortID = 498,
    AwakerID = 15586,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100206_AwakerVoiceContent|冒犯者，该承受千刀万剐之刑……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [100076] = {
    ID = 100076,
    CnID = "语音@窜行者普通开场",
    BaseSortID = 499,
    AwakerID = 15593,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100076_AwakerVoiceContent|神偷侠盗——布朗与詹金在此！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100157] = {
    ID = 100157,
    CnID = "语音@窜行者关系对话1",
    BaseSortID = 500,
    AwakerID = 15593,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100157_AwakerVoiceContent|抬起头来，艾继丝！让大家看看你的厉害！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15591,
    ReletedVoiceID = 99915,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99744] = {
    ID = 99744,
    CnID = "语音@窜行者关系对话2",
    BaseSortID = 501,
    AwakerID = 15593,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99744_AwakerVoiceContent|……谁说的，你有什么证据？我可不承认！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15595,
    ReletedVoiceID = 100056,
    FollowUpVoice = 0,
    Sort = 3
  },
  [99878] = {
    ID = 99878,
    CnID = "语音@窜行者关系对话3",
    BaseSortID = 502,
    AwakerID = 15593,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99878_AwakerVoiceContent|没事的姐姐，这有什么，现在东区街头都这么穿！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15601,
    ReletedVoiceID = 100095,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99772] = {
    ID = 99772,
    CnID = "语音@窜行者关系对话4",
    BaseSortID = 503,
    AwakerID = 15593,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99772_AwakerVoiceContent|听说那个女巫的仓库里有数不清的稀罕宝贝，要是能让布朗进去溜达一圈……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15590,
    ReletedVoiceID = 99815,
    Sort = 5
  },
  [99880] = {
    ID = 99880,
    CnID = "语音@窜行者思考",
    BaseSortID = 504,
    AwakerID = 15593,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99880_AwakerVoiceContent|再结实的锁头，也能从内部轻巧打开……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99958] = {
    ID = 99958,
    CnID = "语音@窜行者催促",
    BaseSortID = 505,
    AwakerID = 15593,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99958_AwakerVoiceContent|快动手啊，偷东西让人发现就完了！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100021] = {
    ID = 100021,
    CnID = "语音@窜行者必杀",
    BaseSortID = 506,
    AwakerID = 15593,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100021_AwakerVoiceContent|看看东区之王的厉害！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99739] = {
    ID = 99739,
    CnID = "语音@窜行者错误",
    BaseSortID = 507,
    AwakerID = 15593,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99739_AwakerVoiceContent|潜行的时候好像踩到了一根树枝……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100041] = {
    ID = 100041,
    CnID = "语音@窜行者死亡",
    BaseSortID = 508,
    AwakerID = 15593,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100041_AwakerVoiceContent|布朗快走……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [127013] = {
    ID = 127013,
    CnID = "语音@窜行者关系对话5",
    BaseSortID = 509,
    AwakerID = 15593,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_127013_AwakerVoiceContent|哈啊！你就是那个什么国来的人？漂亮的扇子……快将宝贝交出来！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 125346,
    ReletedVoiceID = 127009,
    FollowUpVoice = 1,
    Sort = 11
  },
  [100116] = {
    ID = 100116,
    CnID = "语音@无名诗篇普通开场",
    BaseSortID = 510,
    AwakerID = 15583,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100116_AwakerVoiceContent|您想听一听我新作的诗吗？",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [100004] = {
    ID = 100004,
    CnID = "语音@无名诗篇关系对话1",
    BaseSortID = 511,
    AwakerID = 15583,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100004_AwakerVoiceContent|每次听到哈姆林先生的演奏，我都能涌出许许多多的灵感，或许音乐正是在灵魂维度的共振吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54117,
    ReletedVoiceID = 99765,
    FollowUpVoice = 1,
    Sort = 2
  },
  [99936] = {
    ID = 99936,
    CnID = "语音@无名诗篇关系对话2",
    BaseSortID = 512,
    AwakerID = 15583,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99936_AwakerVoiceContent|啊，请尽情地唱吧，我……我很荣幸。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15574,
    ReletedVoiceID = 99957,
    FollowUpVoice = 0,
    Sort = 3
  },
  [100008] = {
    ID = 100008,
    CnID = "语音@无名诗篇关系对话3",
    BaseSortID = 513,
    AwakerID = 15583,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100008_AwakerVoiceContent|直面闪电的引航者，多么勇敢，第一次听到你的故事时我甚至为此流下眼泪。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77922,
    ReletedVoiceID = 100183,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100203] = {
    ID = 100203,
    CnID = "语音@无名诗篇关系对话4",
    BaseSortID = 514,
    AwakerID = 15583,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100203_AwakerVoiceContent|当然可以！原来宁菲亚小姐也喜欢诗，不介意的话，我有很多珍藏的旧诗集可以一起分享。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15580,
    ReletedVoiceID = 99755,
    FollowUpVoice = 0,
    Sort = 5
  },
  [100049] = {
    ID = 100049,
    CnID = "语音@无名诗篇思考",
    BaseSortID = 515,
    AwakerID = 15583,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100049_AwakerVoiceContent|花与春天，是怎么都写不够的东西……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [100096] = {
    ID = 100096,
    CnID = "语音@无名诗篇催促",
    BaseSortID = 516,
    AwakerID = 15583,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100096_AwakerVoiceContent|好的诗句的确要仔细斟酌。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99927] = {
    ID = 99927,
    CnID = "语音@无名诗篇必杀",
    BaseSortID = 517,
    AwakerID = 15583,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99927_AwakerVoiceContent|请听听这首这夜莺对玫瑰的情诗吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [100125] = {
    ID = 100125,
    CnID = "语音@无名诗篇错误",
    BaseSortID = 518,
    AwakerID = 15583,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100125_AwakerVoiceContent|这里的用词需要修改一下……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100061] = {
    ID = 100061,
    CnID = "语音@无名诗篇死亡",
    BaseSortID = 519,
    AwakerID = 15583,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100061_AwakerVoiceContent|玫瑰……枯萎了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99855] = {
    ID = 99855,
    CnID = "语音@迁移者普通开场",
    BaseSortID = 520,
    AwakerID = 15579,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99855_AwakerVoiceContent|一定要我来吗，不能换一个人吗……",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99749] = {
    ID = 99749,
    CnID = "语音@迁移者关系对话1",
    BaseSortID = 521,
    AwakerID = 15579,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99749_AwakerVoiceContent|你你你不会回去罚我刷烧杯吧？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15602,
    ReletedVoiceID = 99948,
    FollowUpVoice = 0,
    Sort = 2
  },
  [100055] = {
    ID = 100055,
    CnID = "语音@迁移者关系对话2",
    BaseSortID = 522,
    AwakerID = 15579,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100055_AwakerVoiceContent|如果我为你研究一款自动化义肢的话，能不能请你晚上帮我看守我的光源装置……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15588,
    ReletedVoiceID = 99959,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100126] = {
    ID = 100126,
    CnID = "语音@迁移者关系对话3",
    BaseSortID = 523,
    AwakerID = 15579,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100126_AwakerVoiceContent|可以借用一下你的壳吗？我想研究一种仿生结构，这样我的定位仪也可以像摇篮一样舒适了。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15577,
    ReletedVoiceID = 99797,
    FollowUpVoice = 1,
    Sort = 4
  },
  [100011] = {
    ID = 100011,
    CnID = "语音@迁移者关系对话4",
    BaseSortID = 524,
    AwakerID = 15579,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100011_AwakerVoiceContent|维度转移的力量，可以转移精神吗？可以让我逃离那些黑色的恐怖的……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15572,
    ReletedVoiceID = 100185,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100079] = {
    ID = 100079,
    CnID = "语音@迁移者思考",
    BaseSortID = 525,
    AwakerID = 15579,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100079_AwakerVoiceContent|不要想，不要看，不要想，不要看……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99750] = {
    ID = 99750,
    CnID = "语音@迁移者催促",
    BaseSortID = 526,
    AwakerID = 15579,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99750_AwakerVoiceContent|呃呃，好想逃，快要坚持不住了……",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [99740] = {
    ID = 99740,
    CnID = "语音@迁移者必杀",
    BaseSortID = 527,
    AwakerID = 15579,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99740_AwakerVoiceContent|迁移的能量，省着点用啊！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99914] = {
    ID = 99914,
    CnID = "语音@迁移者错误",
    BaseSortID = 528,
    AwakerID = 15579,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99914_AwakerVoiceContent|啊啊啊黑色的，我看见了，要被追上了！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [99783] = {
    ID = 99783,
    CnID = "语音@迁移者死亡",
    BaseSortID = 529,
    AwakerID = 15579,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99783_AwakerVoiceContent|逃不掉，为什么逃不掉……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [99911] = {
    ID = 99911,
    CnID = "语音@克莱门汀普通开场",
    BaseSortID = 530,
    AwakerID = 77925,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99911_AwakerVoiceContent|嘘，不要说话，静静跟随我的灵摆吧。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [99963] = {
    ID = 99963,
    CnID = "语音@克莱门汀关系对话1",
    BaseSortID = 531,
    AwakerID = 77925,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99963_AwakerVoiceContent|哈姆林先生在演奏之外，原来也对剖析他人这么感兴趣？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54117,
    ReletedVoiceID = 99886,
    FollowUpVoice = 0,
    Sort = 2
  },
  [99890] = {
    ID = 99890,
    CnID = "语音@克莱门汀关系对话2",
    BaseSortID = 532,
    AwakerID = 77925,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99890_AwakerVoiceContent|这样疲惫的孩子，好像很需要一场心理治疗呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15563,
    ReletedVoiceID = 99965,
    FollowUpVoice = 1,
    Sort = 3
  },
  [100045] = {
    ID = 100045,
    CnID = "语音@克莱门汀关系对话3",
    BaseSortID = 533,
    AwakerID = 77925,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_100045_AwakerVoiceContent|看来你经历过很严重的创伤呢，或许都讲出来你会好受一些？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15567,
    ReletedVoiceID = 100151,
    FollowUpVoice = 0,
    Sort = 4
  },
  [99866] = {
    ID = 99866,
    CnID = "语音@克莱门汀关系对话4",
    BaseSortID = 534,
    AwakerID = 77925,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_99866_AwakerVoiceContent|完全没有情绪的存在……真像个怪物呢。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15572,
    ReletedVoiceID = 100176,
    FollowUpVoice = 1,
    Sort = 5
  },
  [100167] = {
    ID = 100167,
    CnID = "语音@克莱门汀思考",
    BaseSortID = 535,
    AwakerID = 77925,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100167_AwakerVoiceContent|嗯……这样的病症很罕见呢，请务必与我多聊一聊。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 6
  },
  [99899] = {
    ID = 99899,
    CnID = "语音@克莱门汀催促",
    BaseSortID = 536,
    AwakerID = 77925,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99899_AwakerVoiceContent|不多倾诉一下的话，心灵的创伤是无法愈合的哦。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 7
  },
  [100170] = {
    ID = 100170,
    CnID = "语音@克莱门汀必杀",
    BaseSortID = 537,
    AwakerID = 77925,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100170_AwakerVoiceContent|跟随我、听从我，温顺地迈入那个终局吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 8
  },
  [99857] = {
    ID = 99857,
    CnID = "语音@克莱门汀错误",
    BaseSortID = 538,
    AwakerID = 77925,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_99857_AwakerVoiceContent|脱离了催眠吗？没关系，我们还有很多其他治疗方案……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 9
  },
  [100208] = {
    ID = 100208,
    CnID = "语音@克莱门汀死亡",
    BaseSortID = 539,
    AwakerID = 77925,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_100208_AwakerVoiceContent|被拒绝了呢，没关系，下一次……",
    TriggerConditions = {"AwakerDied"},
    Sort = 10
  },
  [116789] = {
    ID = 116789,
    CnID = "语音@卡斯托尔普通开场",
    BaseSortID = 540,
    AwakerID = 77923,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_116789_AwakerVoiceContent|我与飓风都已准备好。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [116786] = {
    ID = 116786,
    CnID = "语音@卡斯托尔思考",
    BaseSortID = 541,
    AwakerID = 77923,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_116786_AwakerVoiceContent|要先行出击吗，还是全力防御……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [116788] = {
    ID = 116788,
    CnID = "语音@卡斯托尔催促",
    BaseSortID = 542,
    AwakerID = 77923,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_116788_AwakerVoiceContent|你的犹豫将成为失败的前兆。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [116791] = {
    ID = 116791,
    CnID = "语音@卡斯托尔必杀",
    BaseSortID = 543,
    AwakerID = 77923,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_116791_AwakerVoiceContent|面对飓风吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [116790] = {
    ID = 116790,
    CnID = "语音@卡斯托尔错误",
    BaseSortID = 544,
    AwakerID = 77923,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_116790_AwakerVoiceContent|没能阻拦到吗……",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [116787] = {
    ID = 116787,
    CnID = "语音@卡斯托尔死亡",
    BaseSortID = 545,
    AwakerID = 77923,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_116787_AwakerVoiceContent|羽翼……凋零了……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [120268] = {
    ID = 120268,
    CnID = "语音@卡斯托尔关系对话1",
    BaseSortID = 546,
    AwakerID = 77923,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120268_AwakerVoiceContent|如果可以，我不想和你战斗，哪怕是切磋。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77917,
    ReletedVoiceID = 120248,
    FollowUpVoice = 1,
    Sort = 7
  },
  [120252] = {
    ID = 120252,
    CnID = "语音@卡斯托尔关系对话2",
    BaseSortID = 547,
    AwakerID = 77923,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120252_AwakerVoiceContent|我不明白什么是伟大，我只知道自由的权力无人可以剥夺。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15589,
    ReletedVoiceID = 120274,
    FollowUpVoice = 0,
    Sort = 8
  },
  [120249] = {
    ID = 120249,
    CnID = "语音@卡斯托尔关系对话3",
    BaseSortID = 548,
    AwakerID = 77923,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120249_AwakerVoiceContent|抱歉……我们都曾被锁链束缚，如果你想飞上天空，就大声呼唤我吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15577,
    ReletedVoiceID = 120254,
    FollowUpVoice = 0,
    Sort = 9
  },
  [120280] = {
    ID = 120280,
    CnID = "语音@波吕克斯普通开场",
    BaseSortID = 549,
    AwakerID = 77917,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120280_AwakerVoiceContent|我将净化你心中的罪孽。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [120287] = {
    ID = 120287,
    CnID = "语音@波吕克斯思考",
    BaseSortID = 550,
    AwakerID = 77917,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120287_AwakerVoiceContent|纯洁的圣心将引导你走向净化之路。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [120286] = {
    ID = 120286,
    CnID = "语音@波吕克斯催促",
    BaseSortID = 551,
    AwakerID = 77917,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120286_AwakerVoiceContent|在犹豫什么？你的信仰动摇了吗？",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [120259] = {
    ID = 120259,
    CnID = "语音@波吕克斯必杀",
    BaseSortID = 552,
    AwakerID = 77917,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120259_AwakerVoiceContent|我嗅到了不洁的气息，不敬的罪人！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [120279] = {
    ID = 120279,
    CnID = "语音@波吕克斯错误",
    BaseSortID = 553,
    AwakerID = 77917,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120279_AwakerVoiceContent|给你一次忏悔的机会……向我证明你的虔诚吧。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [120275] = {
    ID = 120275,
    CnID = "语音@波吕克斯死亡",
    BaseSortID = 554,
    AwakerID = 77917,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_120275_AwakerVoiceContent|直面罪恶……这是我应得的惩罚……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [120248] = {
    ID = 120248,
    CnID = "语音@波吕克斯关系对话1",
    BaseSortID = 555,
    AwakerID = 77917,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120248_AwakerVoiceContent|不要再婆婆妈妈了，卡斯托尔，放马过来吧，你以为我会输给你吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77923,
    ReletedVoiceID = 120268,
    FollowUpVoice = 0,
    Sort = 7
  },
  [120284] = {
    ID = 120284,
    CnID = "语音@波吕克斯关系对话2",
    BaseSortID = 556,
    AwakerID = 77917,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120284_AwakerVoiceContent|无法变强？莫非是因为你的灵魂过于肮脏？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15594,
    ReletedVoiceID = 120258,
    FollowUpVoice = 1,
    Sort = 8
  },
  [120283] = {
    ID = 120283,
    CnID = "语音@波吕克斯关系对话3",
    BaseSortID = 557,
    AwakerID = 77917,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_120283_AwakerVoiceContent|既然你是神明，为何要对世间的罪恶坐视不理？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15563,
    ReletedVoiceID = 120256,
    FollowUpVoice = 1,
    Sort = 9
  },
  [135220] = {
    ID = 135220,
    CnID = "语音@波吕克斯关系对话4",
    BaseSortID = 558,
    AwakerID = 77917,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_135220_AwakerVoiceContent|操纵命运的神明，我已看清了你的罪孽！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77918,
    ReletedVoiceID = 135224,
    FollowUpVoice = 0,
    Sort = 10
  },
  [123999] = {
    ID = 123999,
    CnID = "语音@茉夏普通开场",
    BaseSortID = 559,
    AwakerID = 94450,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_123999_AwakerVoiceContent|哼☆哼，终于有机会发泄一下了！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [123998] = {
    ID = 123998,
    CnID = "语音@茉夏思考",
    BaseSortID = 560,
    AwakerID = 94450,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_123998_AwakerVoiceContent|嗯嗯，让我听听他们的悲鸣！",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [124005] = {
    ID = 124005,
    CnID = "语音@茉夏催促",
    BaseSortID = 561,
    AwakerID = 94450,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_124005_AwakerVoiceContent|别磨磨唧唧的，快点做决定！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [124001] = {
    ID = 124001,
    CnID = "语音@茉夏必杀",
    BaseSortID = 562,
    AwakerID = 94450,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_124001_AwakerVoiceContent|这就是！闪耀☆龙卷风的威力！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [124008] = {
    ID = 124008,
    CnID = "语音@茉夏错误",
    BaseSortID = 563,
    AwakerID = 94450,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_124008_AwakerVoiceContent|好无聊啊，异世界应该还有更有趣的娱乐活动吧？",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [124002] = {
    ID = 124002,
    CnID = "语音@茉夏死亡",
    BaseSortID = 564,
    AwakerID = 94450,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_124002_AwakerVoiceContent|原来，阵亡是这种感觉啊……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [124006] = {
    ID = 124006,
    CnID = "语音@茉夏关系对话1",
    BaseSortID = 565,
    AwakerID = 94450,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_124006_AwakerVoiceContent|真是无趣！我早已被世俗的枷锁禁锢太久，是时候寻回那个真实的自己了！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15599,
    ReletedVoiceID = 124007,
    FollowUpVoice = 0,
    Sort = 7
  },
  [123997] = {
    ID = 123997,
    CnID = "语音@茉夏关系对话2",
    BaseSortID = 566,
    AwakerID = 94450,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_123997_AwakerVoiceContent|哈哈哈哈，终于有点意思了，可别小看我的战斗力！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77913,
    ReletedVoiceID = 124000,
    FollowUpVoice = 0,
    Sort = 8
  },
  [124004] = {
    ID = 124004,
    CnID = "语音@茉夏关系对话3",
    BaseSortID = 567,
    AwakerID = 94450,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_124004_AwakerVoiceContent|你想要选择正确的命运？为什么要做这种无聊的事情？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77918,
    ReletedVoiceID = 123996,
    FollowUpVoice = 1,
    Sort = 9
  },
  [124009] = {
    ID = 124009,
    CnID = "语音@茉夏关系对话4",
    BaseSortID = 568,
    AwakerID = 94450,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_124009_AwakerVoiceContent|来见识见识吧！这可是男女老少都爱看的！闪耀☆龙卷风！！！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 125346,
    ReletedVoiceID = 125384,
    FollowUpVoice = 0,
    Sort = 10
  },
  [140526] = {
    ID = 140526,
    CnID = "语音@茉夏关系对话5",
    BaseSortID = 569,
    AwakerID = 94450,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140526_AwakerVoiceContent|叽里咕噜说什么呢，吃我一记，闪耀☆龙卷风！！！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130226,
    ReletedVoiceID = 140523,
    FollowUpVoice = 0,
    Sort = 11
  },
  [127010] = {
    ID = 127010,
    CnID = "语音@徐普通开场",
    BaseSortID = 570,
    AwakerID = 125346,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_127010_AwakerVoiceContent|嘻嘻，让妾身看看，这里有什么乐子瞧？",
    TriggerConditions = {
      "PlayerEnter"
    },
    FollowUpVoice = 0,
    Sort = 1
  },
  [127011] = {
    ID = 127011,
    CnID = "语音@徐思考",
    BaseSortID = 571,
    AwakerID = 125346,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_127011_AwakerVoiceContent|唔，妾身倒要看看，您藏了什么底牌。",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [127007] = {
    ID = 127007,
    CnID = "语音@徐催促",
    BaseSortID = 572,
    AwakerID = 125346,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_127007_AwakerVoiceContent|如此殚精竭虑，真让妾身好生心疼。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [127008] = {
    ID = 127008,
    CnID = "语音@徐必杀",
    BaseSortID = 573,
    AwakerID = 125346,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_127008_AwakerVoiceContent|不可僭越！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [127012] = {
    ID = 127012,
    CnID = "语音@徐错误",
    BaseSortID = 574,
    AwakerID = 125346,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_127012_AwakerVoiceContent|呼~无趣，妾身要换一个蛐蛐笼了。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [127015] = {
    ID = 127015,
    CnID = "语音@徐死亡",
    BaseSortID = 575,
    AwakerID = 125346,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_127015_AwakerVoiceContent|嗯？这倒是未曾有过的兴致……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [125384] = {
    ID = 125384,
    CnID = "语音@徐关系对话1",
    BaseSortID = 576,
    AwakerID = 125346,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_125384_AwakerVoiceContent|……太有精神的孩子会让妾身有些头疼，呼，快点结束吧。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 94450,
    ReletedVoiceID = 124009,
    FollowUpVoice = 0,
    Sort = 7
  },
  [127009] = {
    ID = 127009,
    CnID = "语音@徐关系对话2",
    BaseSortID = 577,
    AwakerID = 125346,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_127009_AwakerVoiceContent|哎呀，嘴甜一些，表情再可怜一点，妾身会考虑送一把给你哦？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15593,
    ReletedVoiceID = 127013,
    FollowUpVoice = 0,
    Sort = 8
  },
  [127006] = {
    ID = 127006,
    CnID = "语音@徐关系对话3",
    BaseSortID = 578,
    AwakerID = 125346,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_127006_AwakerVoiceContent|啊，妾身可暂时没有再当母亲的兴趣呢。不过……想听妾身讲个睡前故事吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15581,
    ReletedVoiceID = 127017,
    FollowUpVoice = 1,
    Sort = 9
  },
  [127016] = {
    ID = 127016,
    CnID = "语音@徐关系对话4",
    BaseSortID = 579,
    AwakerID = 125346,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_127016_AwakerVoiceContent|这般唯唯诺诺的小可怜，倒是让妾身感到几分熟悉。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15591,
    ReletedVoiceID = 127014,
    FollowUpVoice = 1,
    Sort = 10
  },
  [143458] = {
    ID = 143458,
    CnID = "语音@徐关系对话5",
    BaseSortID = 580,
    AwakerID = 125346,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143458_AwakerVoiceContent|嗯~要不要给您一个抓住妾身的机会呢，嘻嘻。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 141302,
    ReletedVoiceID = 143457,
    FollowUpVoice = 1,
    Sort = 11
  },
  [131811] = {
    ID = 131811,
    CnID = "语音@莫丝普通开场",
    BaseSortID = 581,
    AwakerID = 130901,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_131811_AwakerVoiceContent|哇吼！莫丝来了！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [131819] = {
    ID = 131819,
    CnID = "语音@莫丝思考",
    BaseSortID = 582,
    AwakerID = 130901,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_131819_AwakerVoiceContent|莫丝！打架！打架！",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [131815] = {
    ID = 131815,
    CnID = "语音@莫丝催促",
    BaseSortID = 583,
    AwakerID = 130901,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_131815_AwakerVoiceContent|快点！快点！",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [131812] = {
    ID = 131812,
    CnID = "语音@莫丝必杀",
    BaseSortID = 584,
    AwakerID = 130901,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_131812_AwakerVoiceContent|转圈转圈！进入漩涡吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [131813] = {
    ID = 131813,
    CnID = "语音@莫丝错误",
    BaseSortID = 585,
    AwakerID = 130901,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_131813_AwakerVoiceContent|不对！不对！",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [131817] = {
    ID = 131817,
    CnID = "语音@莫丝死亡",
    BaseSortID = 586,
    AwakerID = 130901,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_131817_AwakerVoiceContent|好痛……莫丝，害怕……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [131809] = {
    ID = 131809,
    CnID = "语音@莫丝关系对话1",
    BaseSortID = 587,
    AwakerID = 130901,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131809_AwakerVoiceContent|鹦鹉螺，诺缔拉！喜欢！朋友！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15565,
    ReletedVoiceID = 131814,
    FollowUpVoice = 1,
    Sort = 7
  },
  [131810] = {
    ID = 131810,
    CnID = "语音@莫丝关系对话2",
    BaseSortID = 588,
    AwakerID = 130901,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131810_AwakerVoiceContent|戈利亚！打架！玩！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15564,
    ReletedVoiceID = 131820,
    FollowUpVoice = 1,
    Sort = 8
  },
  [131818] = {
    ID = 131818,
    CnID = "语音@莫丝关系对话3",
    BaseSortID = 589,
    AwakerID = 130901,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131818_AwakerVoiceContent|鲸鱼鲸鱼！大浪来啦！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15569,
    ReletedVoiceID = 131816,
    FollowUpVoice = 0,
    Sort = 9
  },
  [131808] = {
    ID = 131808,
    CnID = "语音@莫丝关系对话4",
    BaseSortID = 590,
    AwakerID = 130901,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_131808_AwakerVoiceContent|蛛网，可怕！莫丝，躲起来……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77918,
    ReletedVoiceID = 135222,
    FollowUpVoice = 1,
    Sort = 10
  },
  [143462] = {
    ID = 143462,
    CnID = "语音@莫丝关系对话5",
    BaseSortID = 591,
    AwakerID = 130901,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143462_AwakerVoiceContent|亲切！熟悉！陪莫丝玩！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 141302,
    ReletedVoiceID = 143461,
    FollowUpVoice = 1,
    Sort = 11
  },
  [135223] = {
    ID = 135223,
    CnID = "语音@阿拉克涅普通开场",
    BaseSortID = 592,
    AwakerID = 77918,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_135223_AwakerVoiceContent|这般命运的演绎……我将为你指引正确的走向。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [135218] = {
    ID = 135218,
    CnID = "语音@阿拉克涅思考",
    BaseSortID = 593,
    AwakerID = 77918,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_135218_AwakerVoiceContent|丝线，连结成网……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [135215] = {
    ID = 135215,
    CnID = "语音@阿拉克涅催促",
    BaseSortID = 594,
    AwakerID = 77918,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_135215_AwakerVoiceContent|命运的帷幕已然拉开，是时候登场了。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [135219] = {
    ID = 135219,
    CnID = "语音@阿拉克涅必杀",
    BaseSortID = 595,
    AwakerID = 77918,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_135219_AwakerVoiceContent|剪断了吧，剪断了吧，脆弱的丝缕！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [135216] = {
    ID = 135216,
    CnID = "语音@阿拉克涅错误",
    BaseSortID = 596,
    AwakerID = 77918,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_135216_AwakerVoiceContent|命运的谬误，必须剔除的走向。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [135221] = {
    ID = 135221,
    CnID = "语音@阿拉克涅死亡",
    BaseSortID = 597,
    AwakerID = 77918,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_135221_AwakerVoiceContent|……这就是命运注定的结局。",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [123996] = {
    ID = 123996,
    CnID = "语音@阿拉克涅关系对话1",
    BaseSortID = 598,
    AwakerID = 77918,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_123996_AwakerVoiceContent|你的双眼尚被迷雾所蔽，自然不会知晓责任的重量。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 94450,
    ReletedVoiceID = 124004,
    FollowUpVoice = 0,
    Sort = 7
  },
  [135224] = {
    ID = 135224,
    CnID = "语音@阿拉克涅关系对话2",
    BaseSortID = 599,
    AwakerID = 77918,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_135224_AwakerVoiceContent|被命运之网束缚的鸟儿，将以怎样的姿态重新飞翔？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77917,
    ReletedVoiceID = 135220,
    FollowUpVoice = 1,
    Sort = 8
  },
  [135222] = {
    ID = 135222,
    CnID = "语音@阿拉克涅关系对话3",
    BaseSortID = 600,
    AwakerID = 77918,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_135222_AwakerVoiceContent|被命运囚禁的笨拙伶人……你与我，又有什么本质的区别？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130901,
    ReletedVoiceID = 131808,
    FollowUpVoice = 0,
    Sort = 9
  },
  [135217] = {
    ID = 135217,
    CnID = "语音@阿拉克涅关系对话4",
    BaseSortID = 601,
    AwakerID = 77918,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_135217_AwakerVoiceContent|主动拥抱命运的苦难……你选择了人迹罕至的走向。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15599,
    ReletedVoiceID = 135225,
    FollowUpVoice = 1,
    Sort = 10
  },
  [139844] = {
    ID = 139844,
    CnID = "语音@沙耶普通开场",
    BaseSortID = 602,
    AwakerID = 130226,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_139844_AwakerVoiceContent|哦……你想和沙耶打一架啊……",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [139842] = {
    ID = 139842,
    CnID = "语音@沙耶思考",
    BaseSortID = 603,
    AwakerID = 130226,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_139842_AwakerVoiceContent|问题出在哪里，要好好想想……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [139849] = {
    ID = 139849,
    CnID = "语音@沙耶催促",
    BaseSortID = 604,
    AwakerID = 130226,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_139849_AwakerVoiceContent|这就叫做「优柔寡断」吧？",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [139845] = {
    ID = 139845,
    CnID = "语音@沙耶必杀",
    BaseSortID = 605,
    AwakerID = 130226,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_139845_AwakerVoiceContent|世界啊，遍布蒲公英吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [139846] = {
    ID = 139846,
    CnID = "语音@沙耶错误",
    BaseSortID = 606,
    AwakerID = 130226,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_139846_AwakerVoiceContent|要不要试着调整一下身体结构？不会痛的。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [139848] = {
    ID = 139848,
    CnID = "语音@沙耶死亡",
    BaseSortID = 607,
    AwakerID = 130226,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_139848_AwakerVoiceContent|玻璃鞋……碎掉了。",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [140525] = {
    ID = 140525,
    CnID = "语音@沙耶关系对话1",
    BaseSortID = 608,
    AwakerID = 130226,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140525_AwakerVoiceContent|不知道为什么……感觉很亲切。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15596,
    ReletedVoiceID = 140519,
    FollowUpVoice = 0,
    Sort = 7
  },
  [140523] = {
    ID = 140523,
    CnID = "语音@沙耶关系对话2",
    BaseSortID = 609,
    AwakerID = 130226,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140523_AwakerVoiceContent|我真受不了粗鲁的人。不过也没办法……",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 94450,
    ReletedVoiceID = 140526,
    FollowUpVoice = 1,
    Sort = 8
  },
  [140521] = {
    ID = 140521,
    CnID = "语音@沙耶关系对话3",
    BaseSortID = 610,
    AwakerID = 130226,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140521_AwakerVoiceContent|真好啊，这么热闹。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15573,
    ReletedVoiceID = 140522,
    FollowUpVoice = 0,
    Sort = 9
  },
  [140520] = {
    ID = 140520,
    CnID = "语音@沙耶关系对话4",
    BaseSortID = 611,
    AwakerID = 130226,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_140520_AwakerVoiceContent|答案，真的存在吗？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54116,
    ReletedVoiceID = 140524,
    FollowUpVoice = 1,
    Sort = 10
  },
  [143464] = {
    ID = 143464,
    CnID = "语音@庞托斯普通开场",
    BaseSortID = 612,
    AwakerID = 141302,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_143464_AwakerVoiceContent|强大的猎物，才有猎杀的价值。",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [143465] = {
    ID = 143465,
    CnID = "语音@庞托斯思考",
    BaseSortID = 613,
    AwakerID = 141302,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_143465_AwakerVoiceContent|没错，就是这样，欣赏他们的挣扎……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [143459] = {
    ID = 143459,
    CnID = "语音@庞托斯催促",
    BaseSortID = 614,
    AwakerID = 141302,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_143459_AwakerVoiceContent|动作快些，我准备了盛大的庆功宴。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [143460] = {
    ID = 143460,
    CnID = "语音@庞托斯必杀",
    BaseSortID = 615,
    AwakerID = 141302,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_143460_AwakerVoiceContent|向深渊屈服！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [143454] = {
    ID = 143454,
    CnID = "语音@庞托斯错误",
    BaseSortID = 616,
    AwakerID = 141302,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_143454_AwakerVoiceContent|这不该发生。",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [143467] = {
    ID = 143467,
    CnID = "语音@庞托斯死亡",
    BaseSortID = 617,
    AwakerID = 141302,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_143467_AwakerVoiceContent|深渊……是无法被毁灭的。",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [143456] = {
    ID = 143456,
    CnID = "语音@庞托斯关系对话1",
    BaseSortID = 618,
    AwakerID = 141302,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143456_AwakerVoiceContent|当然，而且——对于邪教徒，我很乐意提供一些有创意的刑讯方式。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77913,
    ReletedVoiceID = 143466,
    FollowUpVoice = 0,
    Sort = 7
  },
  [143457] = {
    ID = 143457,
    CnID = "语音@庞托斯关系对话2",
    BaseSortID = 619,
    AwakerID = 141302,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143457_AwakerVoiceContent|请放心，我一定会让你们体会到什么叫生不如死。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 125346,
    ReletedVoiceID = 143458,
    FollowUpVoice = 0,
    Sort = 8
  },
  [143455] = {
    ID = 143455,
    CnID = "语音@庞托斯关系对话3",
    BaseSortID = 620,
    AwakerID = 141302,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143455_AwakerVoiceContent|……我想我们对于折磨的用途有不同理解。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15560,
    ReletedVoiceID = 143463,
    FollowUpVoice = 0,
    Sort = 9
  },
  [143461] = {
    ID = 143461,
    CnID = "语音@庞托斯关系对话4",
    BaseSortID = 621,
    AwakerID = 141302,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_143461_AwakerVoiceContent|呃，海洋有时确实也会催生出这种，过于纯真的孩子。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 130901,
    ReletedVoiceID = 143462,
    FollowUpVoice = 0,
    Sort = 10
  },
  [150090] = {
    ID = 150090,
    CnID = "语音@庞托斯关系对话5",
    BaseSortID = 622,
    AwakerID = 141302,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150090_AwakerVoiceContent|可惜，我认为厄波扬斯暂时不需要，也不缺乏信仰。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 77921,
    ReletedVoiceID = 150098,
    FollowUpVoice = 1,
    Sort = 11
  },
  [146422] = {
    ID = 146422,
    CnID = "语音@蚀灭·萝坦普通开场",
    BaseSortID = 623,
    AwakerID = 145363,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_146422_AwakerVoiceContent|拔出你们的剑吧。这一刻，我已经等了很久了！",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [146423] = {
    ID = 146423,
    CnID = "语音@蚀灭·萝坦思考",
    BaseSortID = 624,
    AwakerID = 145363,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_146423_AwakerVoiceContent|下一剑，应当斩向何处……",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [146424] = {
    ID = 146424,
    CnID = "语音@蚀灭·萝坦催促",
    BaseSortID = 625,
    AwakerID = 145363,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_146424_AwakerVoiceContent|犹豫的剑可无法刺穿敌人的心脏。",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [146416] = {
    ID = 146416,
    CnID = "语音@蚀灭·萝坦必杀",
    BaseSortID = 626,
    AwakerID = 145363,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_146416_AwakerVoiceContent|鲸天，于此陨落！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [146419] = {
    ID = 146419,
    CnID = "语音@蚀灭·萝坦错误",
    BaseSortID = 627,
    AwakerID = 145363,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_146419_AwakerVoiceContent|哦？这一剑竟然落空了？",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [146425] = {
    ID = 146425,
    CnID = "语音@蚀灭·萝坦死亡",
    BaseSortID = 628,
    AwakerID = 145363,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_146425_AwakerVoiceContent|这就是……剑破裂的声音……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [146428] = {
    ID = 146428,
    CnID = "语音@蚀灭·萝坦关系对话1",
    BaseSortID = 629,
    AwakerID = 145363,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146428_AwakerVoiceContent|你将如何应对我的剑呢，白纱的神明？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 54116,
    ReletedVoiceID = 146426,
    FollowUpVoice = 0,
    Sort = 7
  },
  [146421] = {
    ID = 146421,
    CnID = "语音@蚀灭·萝坦关系对话2",
    BaseSortID = 630,
    AwakerID = 145363,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146421_AwakerVoiceContent|多么旺盛的战意。你一定会是个让我满意的对手！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15598,
    ReletedVoiceID = 146420,
    FollowUpVoice = 0,
    Sort = 8
  },
  [146417] = {
    ID = 146417,
    CnID = "语音@蚀灭·萝坦关系对话3",
    BaseSortID = 631,
    AwakerID = 145363,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146417_AwakerVoiceContent|和平，善良，守护……这些弱小的词，令人作呕。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15566,
    ReletedVoiceID = 146427,
    FollowUpVoice = 1,
    Sort = 9
  },
  [146415] = {
    ID = 146415,
    CnID = "语音@蚀灭·萝坦关系对话4",
    BaseSortID = 632,
    AwakerID = 145363,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_146415_AwakerVoiceContent|我很想知道，一位能够穿梭无尽维度的对手，究竟有着怎样的力量。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15590,
    ReletedVoiceID = 146418,
    FollowUpVoice = 1,
    Sort = 10
  },
  [147591] = {
    ID = 147591,
    CnID = "语音@蚀灭·萝坦关系对话5",
    BaseSortID = 633,
    AwakerID = 145363,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_147591_AwakerVoiceContent|看看你要守护的那些东西吧。什么是纯粹的力量，你从未真正明白过。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15569,
    ReletedVoiceID = 147590,
    FollowUpVoice = 0,
    Sort = 11
  },
  [150089] = {
    ID = 150089,
    CnID = "语音@卡拉布普通开场",
    BaseSortID = 634,
    AwakerID = 77921,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_150089_AwakerVoiceContent|仙女降临☆快快跪拜~",
    TriggerConditions = {
      "PlayerEnter"
    },
    Sort = 1
  },
  [150102] = {
    ID = 150102,
    CnID = "语音@卡拉布思考",
    BaseSortID = 635,
    AwakerID = 77921,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_150102_AwakerVoiceContent|谁是那块容易下口的小点心呢……？",
    TriggerConditions = {
      "OperationStop"
    },
    Sort = 2
  },
  [150100] = {
    ID = 150100,
    CnID = "语音@卡拉布催促",
    BaseSortID = 636,
    AwakerID = 77921,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_150100_AwakerVoiceContent|不用想那么多，有仙女法术护体，尽管向前冲~",
    TriggerConditions = {
      "CountingStart"
    },
    Sort = 3
  },
  [150093] = {
    ID = 150093,
    CnID = "语音@卡拉布必杀",
    BaseSortID = 637,
    AwakerID = 77921,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_150093_AwakerVoiceContent|让无瑕的雪，将你们埋葬吧！",
    TriggerConditions = {"SkillReady"},
    Sort = 4
  },
  [150092] = {
    ID = 150092,
    CnID = "语音@卡拉布错误",
    BaseSortID = 638,
    AwakerID = 77921,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_150092_AwakerVoiceContent|锵锵，有笨蛋~",
    TriggerConditions = {
      "OperationImpossible"
    },
    Sort = 5
  },
  [150101] = {
    ID = 150101,
    CnID = "语音@卡拉布死亡",
    BaseSortID = 639,
    AwakerID = 77921,
    IllustrateType = 0,
    AwakerVoiceContent = "PVPOpeningVoice_150101_AwakerVoiceContent|啰嗦！明明只要保护好本仙女就能赢……",
    TriggerConditions = {"AwakerDied"},
    Sort = 6
  },
  [150096] = {
    ID = 150096,
    CnID = "语音@卡拉布关系对话1",
    BaseSortID = 640,
    AwakerID = 77921,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150096_AwakerVoiceContent|你是不是最听仙女教母话的乖小孩呀？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15573,
    ReletedVoiceID = 150094,
    FollowUpVoice = 1,
    Sort = 7
  },
  [150095] = {
    ID = 150095,
    CnID = "语音@卡拉布关系对话2",
    BaseSortID = 641,
    AwakerID = 77921,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150095_AwakerVoiceContent|啧，死脑筋。",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15585,
    ReletedVoiceID = 150091,
    FollowUpVoice = 0,
    Sort = 8
  },
  [150099] = {
    ID = 150099,
    CnID = "语音@卡拉布关系对话3",
    BaseSortID = 642,
    AwakerID = 77921,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150099_AwakerVoiceContent|有钱人家的傻女儿，可惜破产了。唔，该骗点什么呢？",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 15600,
    ReletedVoiceID = 150097,
    FollowUpVoice = 1,
    Sort = 9
  },
  [150098] = {
    ID = 150098,
    CnID = "语音@卡拉布关系对话4",
    BaseSortID = 643,
    AwakerID = 77921,
    IllustrateType = 1,
    AwakerVoiceContent = "PVPOpeningVoice_150098_AwakerVoiceContent|……这种滴水不漏心机深沉的老男人真讨厌！",
    TriggerConditions = {
      "ReletedAwakerInEnemies"
    },
    ReletedAwaker = 141302,
    ReletedVoiceID = 150090,
    FollowUpVoice = 0,
    Sort = 10
  }
})
return PVPOpeningVoice
