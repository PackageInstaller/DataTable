local System = require("System.System")
local readonly = System.readonly
local MonsterIntent = readonly({
  Intent_Attack = {
    Key = "Intent_Attack",
    Intension = {"Attack"},
    Name = "MonsterIntent_怪物意图攻击_Name|打击",
    DmgRange = {"0", "10"},
    IntentPath = "Icon/Intention/Intent_001.png",
    IconPath = "Icon/Intention/Intent_001.png",
    TipId = "MonsterIntent_怪物意图攻击_TipId|将对我方造成{s1}点伤害。"
  },
  Intent_HeavyAttack = {
    Key = "Intent_HeavyAttack",
    Intension = {"Attack"},
    Name = "MonsterIntent_怪物意图重攻击_Name|打击",
    DmgRange = {"11", "20"},
    IntentPath = "Icon/Intention/Intent_002.png",
    IconPath = "Icon/Intention/Intent_002.png",
    TipId = "MonsterIntent_怪物意图重攻击_TipId|将对我方造成{s1}点伤害。"
  },
  Intent_HeavyAttackDCB02 = {
    Key = "Intent_HeavyAttackDCB02",
    Intension = {"Attack"},
    Name = "MonsterIntent_怪物意图人面犬重攻击_Name|打击",
    DmgRange = {"11", "20"},
    IntentPath = "Icon/Intention/Intent_002.png",
    IconPath = "Icon/Intention/Intent_002.png",
    TipId = "MonsterIntent_怪物意图人面犬重攻击_TipId|将对我方造成{s1}点伤害。"
  },
  Intent_Debuff = {
    Key = "Intent_Debuff",
    Intension = {"Debuff"},
    Name = "MonsterIntent_怪物意图削弱_Name|削弱",
    IntentPath = "Icon/Intention/Intent_003.png",
    IconPath = "Icon/Intention/Intent_003.png",
    TipId = "MonsterIntent_怪物意图削弱_TipId|将对我方施加负面效果。"
  },
  Intent_StrongDebuff = {
    Key = "Intent_StrongDebuff",
    Intension = {"Debuff"},
    Name = "MonsterIntent_怪物意图强力削弱_Name|削弱",
    IntentPath = "Icon/Intention/Intent_004.png",
    IconPath = "Icon/Intention/Intent_004.png",
    TipId = "MonsterIntent_怪物意图强力削弱_TipId|将对我方施加强力负面效果。"
  },
  Intent_Buff = {
    Key = "Intent_Buff",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图强化_Name|强化",
    IntentPath = "Icon/Intention/Intent_005.png",
    IconPath = "Icon/Intention/Intent_005.png",
    TipId = "MonsterIntent_怪物意图强化_TipId|将进行强化。"
  },
  Intent_StrongBuff = {
    Key = "Intent_StrongBuff",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图强力强化_Name|强化",
    IntentPath = "Icon/Intention/Intent_006.png",
    IconPath = "Icon/Intention/Intent_006.png",
    TipId = "MonsterIntent_怪物意图强力强化_TipId|将进行强化。"
  },
  Intent_Defence = {
    Key = "Intent_Defence",
    Intension = {"Defence"},
    Name = "MonsterIntent_怪物意图防御_Name|防御",
    IntentPath = "Icon/Intention/Intent_007.png",
    IconPath = "Icon/Intention/Intent_007.png",
    TipId = "MonsterIntent_怪物意图防御_TipId|将施加护盾。"
  },
  Intent_AttackDefence = {
    Key = "Intent_AttackDefence",
    Intension = {"Attack", "Defence"},
    Name = "MonsterIntent_怪物意图攻击和防御_Name|打击&防御",
    IntentPath = "Icon/Intention/Intent_008.png",
    IconPath = "Icon/Intention/Intent_008.png",
    TipId = "MonsterIntent_怪物意图攻击和防御_TipId|将对我方造成{s1}点伤害，并施加护盾。"
  },
  Intent_AttackDebuff = {
    Key = "Intent_AttackDebuff",
    Intension = {"Attack", "Debuff"},
    Name = "MonsterIntent_怪物意图攻击和削弱_Name|打击&削弱",
    IntentPath = "Icon/Intention/Intent_009.png",
    IconPath = "Icon/Intention/Intent_009.png",
    TipId = "MonsterIntent_怪物意图攻击和削弱_TipId|将对我方造成{s1}点伤害，并对我方施加负面效果。"
  },
  Intent_AttackDebuffD09Skill2 = {
    Key = "Intent_AttackDebuffD09Skill2",
    Intension = {"Attack", "Debuff"},
    Name = "MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name|打击&削弱",
    IntentPath = "Icon/Intention/Intent_009.png",
    IconPath = "Icon/Intention/Intent_009.png",
    TipId = "MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId|将对我方造成{s1}点伤害，并对我方施加负面效果。"
  },
  Intent_AttackBuff = {
    Key = "Intent_AttackBuff",
    Intension = {"Attack", "Buff"},
    Name = "MonsterIntent_怪物意图攻击和强化_Name|打击&强化",
    IntentPath = "Icon/Intention/Intent_010.png",
    IconPath = "Icon/Intention/Intent_010.png",
    TipId = "MonsterIntent_怪物意图攻击和强化_TipId|将对我方造成{s1}点伤害，并进行强化。"
  },
  Intent_DefenceBuff = {
    Key = "Intent_DefenceBuff",
    Intension = {"Defence", "Buff"},
    Name = "MonsterIntent_怪物意图防御和强化_Name|防御&强化",
    IntentPath = "Icon/Intention/Intent_011.png",
    IconPath = "Icon/Intention/Intent_011.png",
    TipId = "MonsterIntent_怪物意图防御和强化_TipId|将施加护盾，并进行强化。"
  },
  Intent_DefenceDebuff = {
    Key = "Intent_DefenceDebuff",
    Intension = {"Defence", "Debuff"},
    Name = "MonsterIntent_怪物意图防御和削弱_Name|防御&削弱",
    IntentPath = "Icon/Intention/Intent_012.png",
    IconPath = "Icon/Intention/Intent_012.png",
    TipId = "MonsterIntent_怪物意图防御和削弱_TipId|将施加护盾，并对我方施加负面效果。"
  },
  Intent_Dizzy = {
    Key = "Intent_Dizzy",
    Intension = {"Dizzy"},
    Name = "MonsterIntent_怪物意图眩晕_Name|眩晕",
    IntentPath = "Icon/Intention/Intent_013.png",
    IconPath = "Icon/Intention/Intent_013.png",
    TipId = "MonsterIntent_怪物意图眩晕_TipId|处于眩晕状态，无法行动。"
  },
  Intent_Unknown = {
    Key = "Intent_Unknown",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明_TipId|下一回合的行动无法探知。"
  },
  Intent_Burst = {
    Key = "Intent_Burst",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图狂气_Name|狂气爆发",
    IntentPath = "Icon/Intention/Intent_015.png",
    IconPath = "Icon/Intention/Intent_015.png",
    TipId = "MonsterIntent_怪物意图狂气_TipId|下一回合即将释放狂气爆发"
  },
  Intent_Burst2 = {
    Key = "Intent_Burst2",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图狂气非攻击_Name|狂气爆发",
    IntentPath = "Icon/Intention/Intent_015.png",
    IconPath = "Icon/Intention/Intent_015.png",
    TipId = "MonsterIntent_怪物意图狂气非攻击_TipId|下一回合即将释放狂气爆发"
  },
  Intent_Unknown1 = {
    Key = "Intent_Unknown1",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明呢喃1_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明呢喃1_TipId|下一回合的行动无法探知。"
  },
  Intent_Unknown2 = {
    Key = "Intent_Unknown2",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明呢喃2_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明呢喃2_TipId|下一回合的行动无法探知。"
  },
  Intent_Unknown3 = {
    Key = "Intent_Unknown3",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明呢喃3_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明呢喃3_TipId|下一回合的行动无法探知。"
  },
  Intent_Unknown4 = {
    Key = "Intent_Unknown4",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明呢喃4_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明呢喃4_TipId|下一回合的行动无法探知。"
  },
  Intent_Unknown5 = {
    Key = "Intent_Unknown5",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明呢喃5_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明呢喃5_TipId|下一回合的行动无法探知。"
  },
  Intent_Unknown6 = {
    Key = "Intent_Unknown6",
    Intension = {"Unknown"},
    Name = "MonsterIntent_怪物意图不明呢喃6_Name|不明",
    IntentPath = "Icon/Intention/Intent_014.png",
    IconPath = "Icon/Intention/Intent_014.png",
    TipId = "MonsterIntent_怪物意图不明呢喃6_TipId|下一回合的行动无法探知。"
  },
  Intent_DCB022Buff = {
    Key = "Intent_DCB022Buff",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图强化DCB02_2_Name|强化",
    IntentPath = "Icon/Intention/Intent_005.png",
    IconPath = "Icon/Intention/Intent_005.png",
    TipId = "MonsterIntent_怪物意图强化DCB02_2_TipId|将进行强化。"
  },
  Intent_DCB024Buff = {
    Key = "Intent_DCB024Buff",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图强化DCB02_4_Name|强化",
    IntentPath = "Icon/Intention/Intent_005.png",
    IconPath = "Icon/Intention/Intent_005.png",
    TipId = "MonsterIntent_怪物意图强化DCB02_4_TipId|将进行强化。"
  },
  Intent_Burst3 = {
    Key = "Intent_Burst3",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图超级狂气_Name|狂气爆发",
    IntentPath = "Icon/Intention/Intent_015.png",
    IconPath = "Icon/Intention/Intent_015.png",
    TipId = "MonsterIntent_怪物意图超级狂气_TipId|下一回合即将释放狂气爆发"
  },
  Intent_Burst4 = {
    Key = "Intent_Burst4",
    Intension = {"Buff"},
    Name = "MonsterIntent_怪物意图释放终结_Name|狂气爆发",
    IntentPath = "Icon/Intention/Intent_015.png",
    IconPath = "Icon/Intention/Intent_015.png",
    TipId = "MonsterIntent_怪物意图释放终结_TipId|下一回合即将终结玩家。"
  }
})
return MonsterIntent
