local System = require("System.System")
local readonly = System.readonly
local TipsType = readonly({
  ["40001"] = {
    ID = "40001",
    Type = 7,
    Title = "TipsType_40001_Title|生命",
    Desc = "TipsType_40001_Desc|当生命降至0时，调查会强制结束。"
  },
  ["40002"] = {
    ID = "40002",
    Type = 7,
    Title = "TipsType_40002_Title|压力",
    Desc = "TipsType_40002_Desc|地图移动、调查事件将会产生精神压力，压力累积会使守密人受到症状。\n每移动一格，压力提升10点。压力每满100点获得1个症状。\n当压力达到500后，每移动一格，扣除10%生命。"
  },
  ["40005"] = {
    ID = "40005",
    Type = 7,
    Title = "TipsType_40005_Title|等级",
    Desc = "TipsType_40005_Desc|守密人可以通过调查、幕间演习等挑战提升自身等级。更多的玩法会随着守密人的等级提升而逐步解锁。"
  },
  ["40004"] = {
    ID = "40004",
    Type = 7,
    Title = "TipsType_40004_Title|超维空间",
    Desc = "TipsType_40004_Desc|每回合打出的第 1 张指令卡的临时复制会进入超维空间。\n当超维空间达到上限时，获得 1 个额外的超维回合并保留护盾。\n界域精通效果：回合开始时有概率将 1 张「灵感」加入手中。"
  },
  ["40003"] = {
    ID = "40003",
    Type = 7,
    Title = "TipsType_40003_Title|派遣等级",
    Desc = "TipsType_40003_Desc|派遣等级越高，任务难度越高，派遣获得的奖励也相应提升。"
  },
  ["40006"] = {
    ID = "40006",
    Type = 7,
    Title = "TipsType_40006_Title|算力",
    Desc = "TipsType_40006_Desc|打出指令卡需要消耗算力。回合结束时不会保留剩余算力，回合开始时使算力恢复至上限。"
  },
  ["40007"] = {
    ID = "40007",
    Type = 7,
    Title = "TipsType_40007_Title|隐藏物资",
    Desc = "TipsType_40007_Desc|银钥匙感知到一缕特殊能量，地图中或许隐藏着珍贵的物资……"
  },
  ["40008"] = {
    ID = "40008",
    Type = 7,
    Title = "TipsType_40008_Title|应急灵知体",
    Desc = "TipsType_40008_Desc|战斗中遇到致命危机时可以发动，每次发动消耗1枚，使守密人生命和唤醒体狂气回复至上限，每天9点自动获得1枚。"
  },
  ["40009"] = {
    ID = "40009",
    Type = 7,
    Title = "TipsType_40009_Title|算力",
    Desc = "TipsType_40009_Desc|打出指令卡需要消耗算力。回合结束时不会保留剩余算力，回合开始时算力上限 +1 并使算力恢复至上限。当前是第 {s1} 回合。"
  },
  ["30001"] = {
    ID = "30001",
    Type = 3,
    Desc = "TipsType_30001_Desc|侧边提示无图标"
  },
  ["30002"] = {
    ID = "30002",
    Type = 3,
    Desc = "TipsType_30002_Desc|{s1}",
    Icon = "UIResources/AtlasSource/1_Interface/Public/UI_Public_Tick_0.png"
  },
  ["30003"] = {
    ID = "30003",
    Type = 3,
    Desc = "TipsType_30003_Desc|{s1}解锁"
  },
  ["30004"] = {
    ID = "30004",
    Type = 3,
    Desc = "TipsType_30004_Desc|{s1}进阶模式解锁"
  },
  ["30005"] = {
    ID = "30005",
    Type = 3,
    Desc = "TipsType_30005_Desc|{s1}（困难）解锁"
  },
  ["20001"] = {
    ID = "20001",
    Type = 2,
    Title = "TipsType_20001_Title|标题",
    Desc = "TipsType_20001_Desc|带勾选二次确认",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_20001_LeftBtnDesc|确定",
    DonotRemind = 1
  },
  ["20002"] = {
    ID = "20002",
    Type = 2,
    Title = "TipsType_20002_Title|标题",
    Desc = "TipsType_20002_Desc|不带勾选二次确认",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20002_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20002_RightBtnDesc|确定"
  },
  ["20003"] = {
    ID = "20003",
    Type = 2,
    Title = "TipsType_20003_Title|断线提示",
    Desc = "TipsType_20003_Desc|您的账号已在其他设备登录。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20003_RightBtnDesc|确认"
  },
  ["20004"] = {
    ID = "20004",
    Type = 2,
    Title = "TipsType_20004_Title|断线提示",
    Desc = "TipsType_20004_Desc|与服务器连接断开，请重新登录。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20004_RightBtnDesc|确认"
  },
  ["20005"] = {
    ID = "20005",
    Type = 2,
    Title = "TipsType_20005_Title|同步失败",
    Desc = "TipsType_20005_Desc|同步失败，是否再次尝试？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20005_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20005_RightBtnDesc|确认"
  },
  ["20006"] = {
    ID = "20006",
    Type = 2,
    Title = "TipsType_20006_Title|同步失败",
    Desc = "TipsType_20006_Desc|失去同步，稍后将返回登录界面。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20006_RightBtnDesc|确认"
  },
  ["20007"] = {
    ID = "20007",
    Type = 2,
    Title = "TipsType_20007_Title|同步失败",
    Desc = "TipsType_20007_Desc|失去同步，稍后将返回登录界面。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20007_RightBtnDesc|确认"
  },
  ["20008"] = {
    ID = "20008",
    Type = 2,
    Title = "TipsType_20008_Title|结束勘探",
    Desc = "TipsType_20008_Desc|本次调查消耗体力 <Positive:{s1}>，是否确认结束？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20008_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20008_RightBtnDesc|确认"
  },
  ["20009"] = {
    ID = "20009",
    Type = 2,
    Title = "TipsType_20009_Title|确认刷新",
    Desc = "TipsType_20009_Desc|刷新将会更新刻印和造物，唤醒体觉醒和出售指令卡的次数不会重置，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20009_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20009_RightBtnDesc|确认"
  },
  ["20010"] = {
    ID = "20010",
    Type = 2,
    Desc = "TipsType_20010_Desc|此界域唤醒体数量不足，是否继续创建队伍？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20010_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20010_RightBtnDesc|确认"
  },
  ["20011"] = {
    ID = "20011",
    Type = 2,
    Desc = "TipsType_20011_Desc|未选择任何唤醒体，编队不予保留。",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_20011_LeftBtnDesc|确认离开",
    RightBtn = 1,
    RightBtnDesc = "TipsType_20011_RightBtnDesc|继续编队"
  },
  ["20012"] = {
    ID = "20012",
    Type = 2,
    Desc = "TipsType_20012_Desc|未选择唤醒体",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20012_RightBtnDesc|确认"
  },
  ["20013"] = {
    ID = "20013",
    Type = 2,
    Desc = "TipsType_20013_Desc|队伍尚有空缺，是否确认启程？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20013_LeftBtnDesc|返回",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20013_RightBtnDesc|启程"
  },
  ["20014"] = {
    ID = "20014",
    Type = 2,
    Desc = "TipsType_20014_Desc|队伍数量已达上限。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20014_RightBtnDesc|确认"
  },
  ["20015"] = {
    ID = "20015",
    Type = 2,
    Desc = "TipsType_20015_Desc|是否删除此队伍？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20015_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20015_RightBtnDesc|确认"
  },
  ["20016"] = {
    ID = "20016",
    Type = 2,
    Desc = "TipsType_20016_Desc|{s1}通关后解锁",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20016_RightBtnDesc|确认"
  },
  ["20017"] = {
    ID = "20017",
    Type = 2,
    Desc = "TipsType_20017_Desc|此处可查看地图信息和已经打过的怪物信息，当前版本暂未开发",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20017_RightBtnDesc|确认"
  },
  ["20018"] = {
    ID = "20018",
    Type = 2,
    Title = "TipsType_20018_Title|快速勘探",
    Desc = "TipsType_20018_Desc|暂未达到关卡解锁条件",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20018_RightBtnDesc|确认"
  },
  ["20019"] = {
    ID = "20019",
    Type = 2,
    Desc = "TipsType_20019_Desc|「银芯」不足，是否前往商城购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20019_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20019_RightBtnDesc|前往"
  },
  ["20020"] = {
    ID = "20020",
    Type = 2,
    Desc = "TipsType_20020_Desc|进阶{s1}通关后解锁此进阶难度",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20020_RightBtnDesc|确认"
  },
  ["20021"] = {
    ID = "20021",
    Type = 2,
    Desc = "TipsType_20021_Desc|{s1}普通模式通关后解锁进阶训练",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20021_RightBtnDesc|确认"
  },
  ["20022"] = {
    ID = "20022",
    Type = 2,
    Title = "TipsType_20022_Title|银芯不足",
    Desc = "TipsType_20022_Desc|「银芯」不足，是否前往购买",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20022_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20022_RightBtnDesc|确认"
  },
  ["20023"] = {
    ID = "20023",
    Type = 2,
    Desc = "TipsType_20023_Desc|本次升级溢出{s1}点经验（不返还），且角色达到等级上限后无法继续获得经验，是否继续？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20023_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20023_RightBtnDesc|确认"
  },
  ["20024"] = {
    ID = "20024",
    Type = 2,
    Desc = "TipsType_20024_Desc|队伍未满编，无法进入副本。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20024_RightBtnDesc|确认"
  },
  ["20026"] = {
    ID = "20026",
    Type = 2,
    Desc = "TipsType_20026_Desc|是否确认充能？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20026_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20026_RightBtnDesc|确认"
  },
  ["20027"] = {
    ID = "20027",
    Type = 2,
    Desc = "TipsType_20027_Desc|是否确认恢复生命？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20027_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20027_RightBtnDesc|确认"
  },
  ["20028"] = {
    ID = "20028",
    Type = 2,
    Desc = "TipsType_20028_Desc|关闭此界面将放弃拾取【{s1}】，是否放弃？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20028_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20028_RightBtnDesc|确认"
  },
  ["20029"] = {
    ID = "20029",
    Type = 2,
    Desc = "TipsType_20029_Desc|关闭此界面将跳过本次事件（造物不会被移除），是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20029_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20029_RightBtnDesc|确认"
  },
  ["20030"] = {
    ID = "20030",
    Type = 2,
    Desc = "TipsType_20030_Desc|已勾选造物将不会携带，是否放弃继承？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20030_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20030_RightBtnDesc|确认"
  },
  ["20031"] = {
    ID = "20031",
    Type = 2,
    Desc = "TipsType_20031_Desc|是否确认退出战斗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20031_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20031_RightBtnDesc|确认"
  },
  ["20032"] = {
    ID = "20032",
    Type = 2,
    Title = "TipsType_20032_Title|暂未解锁",
    Desc = "TipsType_20032_Desc|当前关卡暂未解锁，是否前往通关调查关卡解锁？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20032_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20032_RightBtnDesc|确认"
  },
  ["20033"] = {
    ID = "20033",
    Type = 2,
    Desc = "TipsType_20033_Desc|当前挑战次数不足，是否消耗「银芯」× 500 重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20033_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20033_RightBtnDesc|确认"
  },
  ["20034"] = {
    ID = "20034",
    Type = 2,
    Desc = "TipsType_20034_Desc|当前挑战冷却中，是否消耗「银芯」× 50 重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20034_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20034_RightBtnDesc|确认"
  },
  ["20035"] = {
    ID = "20035",
    Type = 2,
    Title = "TipsType_20035_Title|战力不足",
    Desc = "TipsType_20035_Desc|推荐等级为{s1}，当前队伍平均等级为{s2}，调查将遇到阻碍，是否继续进行？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20035_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20035_RightBtnDesc|确认"
  },
  ["20036"] = {
    ID = "20036",
    Type = 2,
    Title = "TipsType_20036_Title|挑战确认",
    Desc = "TipsType_20036_Desc|当前扫荡次数设定为{s1}，但挑战副本仅会消耗{s2}体力获得1次奖励，是否确认挑战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20036_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20036_RightBtnDesc|确认"
  },
  ["20037"] = {
    ID = "20037",
    Type = 2,
    Title = "TipsType_20037_Title|强化确认",
    Desc = "TipsType_20037_Desc|强化素材中包含高级素材，是否确定强化？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20037_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20037_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20038"] = {
    ID = "20038",
    Type = 2,
    Desc = "TipsType_20038_Desc|这件装备正处于锁定状态，是否解除锁定？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20038_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20038_RightBtnDesc|确认"
  },
  ["20039"] = {
    ID = "20039",
    Type = 2,
    Title = "TipsType_20039_Title|退出调查",
    Desc = "TipsType_20039_Desc|确认后本次调查将会失败，无法获得后续调查奖励，是否确认结束调查？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20039_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20039_RightBtnDesc|确认"
  },
  ["20040"] = {
    ID = "20040",
    Type = 2,
    Title = "TipsType_20040_Title|退出调查",
    Desc = "TipsType_20040_Desc|<WeaponEffect_Num:主动退出调查将消耗「灵啡肽」× {s1}。>确认后本次调查将会失败，无法获得后续调查奖励，是否确认结束调查？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20040_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20040_RightBtnDesc|确认"
  },
  ["20041"] = {
    ID = "20041",
    Type = 2,
    Title = "TipsType_20041_Title|加速确认",
    Desc = "TipsType_20041_Desc|是否消耗{s1}个时间压缩许可加速？",
    BottomDesc = "TipsType_20041_BottomDesc|当前拥有时间压缩许可：{s1}",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20041_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20041_RightBtnDesc|确认"
  },
  ["20042"] = {
    ID = "20042",
    Type = 2,
    Desc = "TipsType_20042_Desc|RPG战斗调整中，当前直接结算胜利",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20042_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20042_RightBtnDesc|确认"
  },
  ["20043"] = {
    ID = "20043",
    Type = 2,
    Title = "TipsType_20043_Title|任务刷新",
    Desc = "TipsType_20043_Desc|是否花费 {s1} 银芯，刷新当前任务？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20043_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20043_RightBtnDesc|确认"
  },
  ["20044"] = {
    ID = "20044",
    Type = 2,
    Title = "TipsType_20044_Title|研究确认",
    Desc = "TipsType_20044_Desc|是否进行{s1}的研究？\n研究效果: {s2}",
    BottomDesc = "TipsType_20044_BottomDesc|消耗：{s1}研究许可",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20044_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20044_RightBtnDesc|确认"
  },
  ["20045"] = {
    ID = "20045",
    Type = 2,
    Title = "TipsType_20045_Title|研究取消",
    Desc = "TipsType_20045_Desc|是否取消{s1}的研究？(将返还全额研究许可)",
    BottomDesc = "TipsType_20045_BottomDesc|取消研究不保留已研究进度",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20045_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20045_RightBtnDesc|确认"
  },
  ["20046"] = {
    ID = "20046",
    Type = 2,
    Title = "TipsType_20046_Title|加速确认",
    Desc = "TipsType_20046_Desc|是否消耗 {s1} 「银芯」加速？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20046_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20046_RightBtnDesc|确认"
  },
  ["20047"] = {
    ID = "20047",
    Type = 2,
    Title = "TipsType_20047_Title|购买确认",
    Desc = "TipsType_20047_Desc|缺少 {s1} 个<Blue:「{s2}」>，是否消耗<Blue:「银芯」×{s3} >购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20047_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20047_RightBtnDesc|确认"
  },
  ["20048"] = {
    ID = "20048",
    Type = 2,
    Title = "TipsType_20048_Title|购买确认",
    Desc = "TipsType_20048_Desc|缺少 {s1} 个<Blue:「{s2}」>，是否消耗<Blue:「银芯」×{s3} >购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20048_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20048_RightBtnDesc|确认"
  },
  ["20049"] = {
    ID = "20049",
    Type = 2,
    Title = "TipsType_20049_Title|更换提示",
    Desc = "TipsType_20049_Desc|<Blue:「{s1}」> 已被 <Blue:「{s2}」> 所装备，是否确认更换？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20049_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20049_RightBtnDesc|确认"
  },
  ["20050"] = {
    ID = "20050",
    Type = 2,
    Title = "TipsType_20050_Title|叠位提示",
    Desc = "TipsType_20050_Desc|消耗命轮已经过叠位，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20050_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20050_RightBtnDesc|确认"
  },
  ["20051"] = {
    ID = "20051",
    Type = 2,
    Title = "TipsType_20051_Title|叠位提示",
    Desc = "TipsType_20051_Desc|当前叠位将超过命轮的叠位等级上限，叠位后将根据溢出等级返还相应数量的命轮，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20051_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20051_RightBtnDesc|确认"
  },
  ["20052"] = {
    ID = "20052",
    Type = 2,
    Title = "TipsType_20052_Title|战力不足",
    Desc = "TipsType_20052_Desc|推荐等级为{s1}，当前队伍平均等级为{s2}，调查将遇到较大阻碍，是否继续进行？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20052_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20052_RightBtnDesc|确认"
  },
  ["20053"] = {
    ID = "20053",
    Type = 2,
    Title = "TipsType_20053_Title|战力不足",
    Desc = "TipsType_20053_Desc|推荐等级为{s1}，当前队伍平均等级为{s2}，调查将遇到极大阻碍，是否继续进行？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20053_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20053_RightBtnDesc|确认"
  },
  ["20054"] = {
    ID = "20054",
    Type = 2,
    Title = "TipsType_20054_Title|挑战确认",
    Desc = "TipsType_20054_Desc|当前挑战奖励已全部领取，继续挑战将不会获得奖励，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20054_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20054_RightBtnDesc|确认"
  },
  ["20055"] = {
    ID = "20055",
    Type = 2,
    Title = "TipsType_20055_Title|重置确认",
    Desc = "TipsType_20055_Desc|重置后，当前关卡进度将会重置为0颗星，唤醒体出战记录同步清除，是否确认重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20055_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20055_RightBtnDesc|确认"
  },
  ["20056"] = {
    ID = "20056",
    Type = 2,
    Title = "TipsType_20056_Title|挑战确认",
    Desc = "TipsType_20056_Desc|挑战成功后，当前编队的四名唤醒体将无法出战{s1}的其他关卡，是否确认挑战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20056_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20056_RightBtnDesc|确认"
  },
  ["20057"] = {
    ID = "20057",
    Type = 2,
    Title = "TipsType_20057_Title|编队确认",
    Desc = "TipsType_20057_Desc|队伍构成违背学院手册的推荐指示，是否仍要继续挑战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20057_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20057_RightBtnDesc|确认"
  },
  ["20058"] = {
    ID = "20058",
    Type = 2,
    Title = "TipsType_20058_Title|重置确认",
    Desc = "TipsType_20058_Desc|当前关卡已挑战成功，若希望重新挑战需先重置当前关卡进度为0颗星，唤醒体出战记录同步清除，是否确认重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20058_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20058_RightBtnDesc|确认"
  },
  ["20059"] = {
    ID = "20059",
    Type = 1,
    Title = "TipsType_20059_Title|编队保存",
    Desc = "TipsType_20059_Desc|当前队伍唤醒体数量未满四个，无法进入战斗"
  },
  ["20060"] = {
    ID = "20060",
    Type = 2,
    Title = "TipsType_20060_Title|确认选择",
    Desc = "TipsType_20060_Desc|是否选择本次唤醒结果（将获得本次唤醒的所有唤醒体和命轮）？",
    BottomDesc = "TipsType_20060_BottomDesc|确认后将无法重新唤醒",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20060_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20060_RightBtnDesc|确认"
  },
  ["20061"] = {
    ID = "20061",
    Type = 2,
    Title = "TipsType_20061_Title|重新唤醒",
    Desc = "TipsType_20061_Desc|是否消费  {s1} 「银芯」重新唤醒？\n重新唤醒将不保留本次抽卡结果",
    BottomDesc = "TipsType_20061_BottomDesc|当前银芯：{s1}",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20061_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20061_RightBtnDesc|确认"
  },
  ["20062"] = {
    ID = "20062",
    Type = 2,
    Title = "TipsType_20062_Title|删除已读",
    Desc = "TipsType_20062_Desc|确定要删除所有的已读信函吗？\n附件未领取的信函并不会删除",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20062_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20062_RightBtnDesc|确认"
  },
  ["20063"] = {
    ID = "20063",
    Type = 2,
    Title = "TipsType_20063_Title|删除当前信件",
    Desc = "TipsType_20063_Desc|确认删除？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20063_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20063_RightBtnDesc|确认"
  },
  ["20064"] = {
    ID = "20064",
    Type = 2,
    Title = "TipsType_20064_Title|删除珍藏信件",
    Desc = "TipsType_20064_Desc|珍藏箱中的信函被删除后，将无法恢复，\n是否删除此信函？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20064_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20064_RightBtnDesc|确认"
  },
  ["20065"] = {
    ID = "20065",
    Type = 2,
    Title = "TipsType_20065_Title|合成确认",
    Desc = "TipsType_20065_Desc|确认消耗 <Blue:{s1}> ，合成 <Blue:{s2}> 吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20065_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20065_RightBtnDesc|确认"
  },
  ["20066"] = {
    ID = "20066",
    Type = 2,
    Title = "TipsType_20066_Title|分解确认",
    Desc = "TipsType_20066_Desc|确认分解<Blue:{s1}，获得{s2}>吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20066_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20066_RightBtnDesc|确认"
  },
  ["20067"] = {
    ID = "20067",
    Type = 2,
    Title = "TipsType_20067_Title|重印确认",
    Desc = "TipsType_20067_Desc|确认消耗 <Blue:{s1}> 个SSR品阶密契，重印 <Blue:{s2}> 个 <Blue:{s3}> ？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20067_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20067_RightBtnDesc|确认"
  },
  ["20068"] = {
    ID = "20068",
    Type = 2,
    Title = "TipsType_20068_Title|调查失败",
    Desc = "TipsType_20068_Desc|所有唤醒体彻底失去战斗能力\n\n唯一的守密人啊\n接下来你该如何选择？",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_20068_LeftBtnDesc|重新战斗",
    RightBtn = 1,
    RightBtnDesc = "TipsType_20068_RightBtnDesc|暂时撤退"
  },
  ["20069"] = {
    ID = "20069",
    Type = 2,
    Title = "TipsType_20069_Title|确定选择",
    Desc = "TipsType_20069_Desc|当前选中唤醒体狂气已满，是否确定仍然选择该唤醒体",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20069_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20069_RightBtnDesc|确认"
  },
  ["20070"] = {
    ID = "20070",
    Type = 2,
    Title = "TipsType_20070_Title|增幅确认",
    Desc = "TipsType_20070_Desc|是否确认使用{s1}？\n等级与技能已提升的唤醒体将不会返还升级物资",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20070_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20070_RightBtnDesc|确认"
  },
  ["20071"] = {
    ID = "20071",
    Type = 2,
    Title = "TipsType_20071_Title|增幅确认",
    Desc = "TipsType_20071_Desc|受守密人调查等级限制，唤醒体等级将提升至{s1}级，缺少的升级物资不会返还，是否确认提升？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20071_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20071_RightBtnDesc|确认"
  },
  ["20072"] = {
    ID = "20072",
    Type = 2,
    Title = "TipsType_20072_Title|跳过剧情",
    Desc = "TipsType_20072_Desc|确认跳过本小节全部剧情吗？\n注：之后您可重新进入本关卡观看剧情。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20072_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20072_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20073"] = {
    ID = "20073",
    Type = 2,
    Title = "TipsType_20073_Title|分解确认",
    Desc = "TipsType_20073_Desc|确认分解{s1}，获得{s2}吗？\n（当前密契已强化，分解不返还强化物资）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20073_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20073_RightBtnDesc|确认"
  },
  ["20074"] = {
    ID = "20074",
    Type = 2,
    Title = "TipsType_20074_Title|分解确认",
    Desc = "TipsType_20074_Desc|确认分解{s1}，获得{s2}吗？\n（当前命轮稀有度较高）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20074_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20074_RightBtnDesc|确认"
  },
  ["20075"] = {
    ID = "20075",
    Type = 2,
    Title = "TipsType_20075_Title|研究确认",
    Desc = "TipsType_20075_Desc|是否启动{s1}研究？\n生产效率: {s2}蔷薇金券/每6小时\n      ——>{s3}蔷薇金券/每6小时",
    BottomDesc = "TipsType_20075_BottomDesc|消耗：{s1}研究许可",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20075_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20075_RightBtnDesc|确认"
  },
  ["20076"] = {
    ID = "20076",
    Type = 2,
    Title = "TipsType_20076_Title|研究确认",
    Desc = "TipsType_20076_Desc|是否启动{s1}的研究？\n生产效率: {s2}灵知制剂/每6小时\n      ——>{s3}灵知制剂/每6小时",
    BottomDesc = "TipsType_20076_BottomDesc|消耗：{s1}研究许可",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20076_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20076_RightBtnDesc|确认"
  },
  ["20077"] = {
    ID = "20077",
    Type = 2,
    Title = "TipsType_20077_Title|研究确认",
    Desc = "TipsType_20077_Desc|是否启动{s1}的研究？\n生产效率: {s2}密契回痕/每6小时\n      ——>{s3}密契回痕/每6小时",
    BottomDesc = "TipsType_20077_BottomDesc|消耗：{s1}研究许可",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20077_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20077_RightBtnDesc|确认"
  },
  ["20078"] = {
    ID = "20078",
    Type = 2,
    Title = "TipsType_20078_Title|跳过剧情",
    Desc = "TipsType_20078_Desc|确认跳过本段全部剧情？\n注：之后您可重新进入本关卡观看剧情。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20078_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20078_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20079"] = {
    ID = "20079",
    Type = 2,
    Title = "TipsType_20079_Title|复活确认",
    Desc = "TipsType_20079_Desc|银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}/{s2}）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20079_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20079_RightBtnDesc|确认"
  },
  ["20080"] = {
    ID = "20080",
    Type = 2,
    Title = "TipsType_20080_Title|复活确认",
    Desc = "TipsType_20080_Desc|银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}/{s2}）",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20080_RightBtnDesc|确认"
  },
  ["20081"] = {
    ID = "20081",
    Type = 2,
    Title = "TipsType_20081_Title|登录错误提示",
    Desc = "TipsType_20081_Desc|游戏初始化失败。{s1}",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20081_RightBtnDesc|确认"
  },
  ["20082"] = {
    ID = "20082",
    Type = 2,
    Title = "TipsType_20082_Title|提升等级",
    Desc = "TipsType_20082_Desc|是否消耗<Blue:「银芯」× {s1} >购买<Blue: {s2} >级?",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20082_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20082_RightBtnDesc|确认"
  },
  ["20083"] = {
    ID = "20083",
    Type = 2,
    Title = "TipsType_20083_Title|消耗确认",
    Desc = "TipsType_20083_Desc|消耗的命轮{s1}，是否确认强化？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20083_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20083_RightBtnDesc|确认"
  },
  ["20084"] = {
    ID = "20084",
    Type = 2,
    Title = "TipsType_20084_Title|调查确认",
    Desc = "TipsType_20084_Desc|队伍平均等级低于关卡推荐等级，出场唤醒体的属性将受到削弱，是否依然选择调查？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20084_LeftBtnDesc|前往提升",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20084_RightBtnDesc|确认"
  },
  ["20085"] = {
    ID = "20085",
    Type = 2,
    Title = "TipsType_20085_Title|退出游戏",
    Desc = "TipsType_20085_Desc|确认退出游戏",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20085_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20085_RightBtnDesc|确认"
  },
  ["20086"] = {
    ID = "20086",
    Type = 2,
    Title = "TipsType_20086_Title|断线提示",
    Desc = "TipsType_20086_Desc|服务器维护中",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20086_RightBtnDesc|确认"
  },
  ["20087"] = {
    ID = "20087",
    Type = 2,
    Title = "TipsType_20087_Title|开启确认",
    Desc = "TipsType_20087_Desc|是否确认消耗<TipsHighlightText:{s1} × {s2}>，开启<TipsHighlightText:{s3}>？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20087_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20087_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20088"] = {
    ID = "20088",
    Type = 2,
    Title = "TipsType_20088_Title|灵啡肽溢出",
    Desc = "TipsType_20088_Desc|领取后「灵啡肽」将溢出，超出{s1}的部分无法获得。\n是否继续领取？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20088_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20088_RightBtnDesc|确认"
  },
  ["20089"] = {
    ID = "20089",
    Type = 2,
    Title = "TipsType_20089_Title|刷新库存",
    Desc = "TipsType_20089_Desc|消耗「蔷薇金券」×<Blue: {s1} >刷新库存 \n 剩余刷新次数：<Blue:{s2}> \n 刷新次数越多，所需「蔷薇金券」数量越多",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20089_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20089_RightBtnDesc|确认"
  },
  ["20097"] = {
    ID = "20097",
    Type = 2,
    Title = "TipsType_20097_Title|确认选择",
    Desc = "TipsType_20097_Desc|该唤醒体启灵已满\n选择后将仅获得「灵魂回溯碎片」×1",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20097_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20097_RightBtnDesc|继续"
  },
  ["20098"] = {
    ID = "20098",
    Type = 2,
    Title = "TipsType_20098_Title|结算方式选择",
    Desc = "TipsType_20098_Desc|该商品可使用<Blue:{s1}>张密银交易凭证购买",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20098_LeftBtnDesc|现金支付",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20098_RightBtnDesc|凭证支付"
  },
  ["20105"] = {
    ID = "20105",
    Type = 8,
    Title = "TipsType_20105_Title|调查确认",
    Desc = "TipsType_20105_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20105_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20105_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117097}
  },
  ["20106"] = {
    ID = "20106",
    Type = 2,
    Title = "TipsType_20106_Title|购买确认",
    Desc = "TipsType_20106_Desc|是否消耗<Blue:「源液」×  {s1} >购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20106_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20106_RightBtnDesc|购买"
  },
  ["20107"] = {
    ID = "20107",
    Type = 2,
    Title = "TipsType_20107_Title|选择确认",
    Desc = "TipsType_20107_Desc|确定要选择 <Blue:{s1}> 吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20107_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20107_RightBtnDesc|确认"
  },
  ["20108"] = {
    ID = "20108",
    Type = 2,
    Title = "TipsType_20108_Title|消耗确认",
    Desc = "TipsType_20108_Desc|本次叠位将消耗稀有物品「循环母版」\n是否继续？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20108_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20108_RightBtnDesc|确认"
  },
  ["20109"] = {
    ID = "20109",
    Type = 2,
    Title = "TipsType_20109_Title|重新战斗",
    Desc = "TipsType_20109_Desc|确定要重新开始本次战斗吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20109_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20109_RightBtnDesc|确认"
  },
  ["20111"] = {
    ID = "20111",
    Type = 8,
    Title = "TipsType_20111_Title|调查确认",
    Desc = "TipsType_20111_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20111_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20111_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117118}
  },
  ["20112"] = {
    ID = "20112",
    Type = 8,
    Title = "TipsType_20112_Title|调查确认",
    Desc = "TipsType_20112_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20112_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20112_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117115, 117120}
  },
  ["10001"] = {
    ID = "10001",
    Type = 1,
    Desc = "TipsType_10001_Desc|操作成功"
  },
  ["10002"] = {
    ID = "10002",
    Type = 1,
    Desc = "TipsType_10002_Desc|配置表错误"
  },
  ["10003"] = {
    ID = "10003",
    Type = 1,
    Desc = "TipsType_10003_Desc|客户端传入数据错误"
  },
  ["10004"] = {
    ID = "10004",
    Type = 1,
    Desc = "TipsType_10004_Desc|服务器未启动"
  },
  ["10005"] = {
    ID = "10005",
    Type = 1,
    Desc = "TipsType_10005_Desc|角色数据错误"
  },
  ["10006"] = {
    ID = "10006",
    Type = 1,
    Desc = "TipsType_10006_Desc|没有找到唤醒体数据"
  },
  ["10007"] = {
    ID = "10007",
    Type = 1,
    Desc = "TipsType_10007_Desc|唤醒体已达最高等级"
  },
  ["10008"] = {
    ID = "10008",
    Type = 1,
    Desc = "TipsType_10008_Desc|没有足够的课题分"
  },
  ["10009"] = {
    ID = "10009",
    Type = 1,
    Desc = "TipsType_10009_Desc|唤醒体未达最高等级，无法启灵"
  },
  ["10010"] = {
    ID = "10010",
    Type = 1,
    Desc = "TipsType_10010_Desc|已完成启灵"
  },
  ["10011"] = {
    ID = "10011",
    Type = 1,
    Desc = "TipsType_10011_Desc|当前未创建角色"
  },
  ["10012"] = {
    ID = "10012",
    Type = 1,
    Desc = "TipsType_10012_Desc|当前已有角色"
  },
  ["10013"] = {
    ID = "10013",
    Type = 1,
    Desc = "TipsType_10013_Desc|角色名重复"
  },
  ["10014"] = {
    ID = "10014",
    Type = 1,
    Desc = "TipsType_10014_Desc|密境区域错误"
  },
  ["10015"] = {
    ID = "10015",
    Type = 1,
    Desc = "TipsType_10015_Desc|无法定位密境区域"
  },
  ["10016"] = {
    ID = "10016",
    Type = 1,
    Desc = "TipsType_10016_Desc|当前体力过低"
  },
  ["10017"] = {
    ID = "10017",
    Type = 1,
    Desc = "TipsType_10017_Desc|{s1}到{s2}可解锁"
  },
  ["10018"] = {
    ID = "10018",
    Type = 1,
    Desc = "TipsType_10018_Desc|抵达此密境第二层1次后，可进行快速调查"
  },
  ["10019"] = {
    ID = "10019",
    Type = 1,
    Desc = "TipsType_10019_Desc|事件已完成"
  },
  ["10020"] = {
    ID = "10020",
    Type = 1,
    Desc = "TipsType_10020_Desc|事件配置表中类型填写错误"
  },
  ["10021"] = {
    ID = "10021",
    Type = 1,
    Desc = "TipsType_10021_Desc|事件不存在"
  },
  ["10022"] = {
    ID = "10022",
    Type = 1,
    Desc = "TipsType_10022_Desc|黑印不足无法购买"
  },
  ["10023"] = {
    ID = "10023",
    Type = 1,
    Desc = "TipsType_10023_Desc|此卡无法强化"
  },
  ["10024"] = {
    ID = "10024",
    Type = 1,
    Desc = "TipsType_10024_Desc|此卡已达强化上限"
  },
  ["10025"] = {
    ID = "10025",
    Type = 1,
    Desc = "TipsType_10025_Desc|行商不售卖此商品"
  },
  ["10026"] = {
    ID = "10026",
    Type = 1,
    Desc = "TipsType_10026_Desc|无此奖励"
  },
  ["10027"] = {
    ID = "10027",
    Type = 1,
    Desc = "TipsType_10027_Desc|奖励已领取"
  },
  ["10028"] = {
    ID = "10028",
    Type = 1,
    Desc = "TipsType_10028_Desc|事件数据错误"
  },
  ["10029"] = {
    ID = "10029",
    Type = 1,
    Desc = "TipsType_10029_Desc|商品已购买"
  },
  ["10030"] = {
    ID = "10030",
    Type = 1,
    Desc = "TipsType_10030_Desc|当前能量不足以启动传送门，启动传送门需要{s1}点能量。"
  },
  ["10031"] = {
    ID = "10031",
    Type = 1,
    Desc = "TipsType_10031_Desc|未找到剧情对话事件"
  },
  ["10032"] = {
    ID = "10032",
    Type = 1,
    Desc = "TipsType_10032_Desc|事件选择指令卡数量不足"
  },
  ["10033"] = {
    ID = "10033",
    Type = 1,
    Desc = "TipsType_10033_Desc|事件选择指令卡数量过多"
  },
  ["10034"] = {
    ID = "10034",
    Type = 1,
    Desc = "TipsType_10034_Desc|事件选择指令卡不存在"
  },
  ["10035"] = {
    ID = "10035",
    Type = 1,
    Desc = "TipsType_10035_Desc|随机事件池中无数据"
  },
  ["10036"] = {
    ID = "10036",
    Type = 1,
    Desc = "TipsType_10036_Desc|行商不售卖此商品"
  },
  ["10037"] = {
    ID = "10037",
    Type = 1,
    Desc = "TipsType_10037_Desc|事件选择造物数量不足"
  },
  ["10038"] = {
    ID = "10038",
    Type = 1,
    Desc = "TipsType_10038_Desc|事件选择造物数量过多"
  },
  ["10039"] = {
    ID = "10039",
    Type = 1,
    Desc = "TipsType_10039_Desc|事件选择造物不存在"
  },
  ["10040"] = {
    ID = "10040",
    Type = 1,
    Desc = "TipsType_10040_Desc|未找到此事件节点"
  },
  ["10041"] = {
    ID = "10041",
    Type = 1,
    Desc = "TipsType_10041_Desc|行商刷新次数已用尽"
  },
  ["10042"] = {
    ID = "10042",
    Type = 1,
    Desc = "TipsType_10042_Desc|战斗掉落指令卡刷新次数已用尽"
  },
  ["10043"] = {
    ID = "10043",
    Type = 1,
    Desc = "TipsType_10043_Desc|战斗掉落造物刷新次数已用尽"
  },
  ["10044"] = {
    ID = "10044",
    Type = 1,
    Desc = "TipsType_10044_Desc|联络点功能被锁"
  },
  ["10045"] = {
    ID = "10045",
    Type = 1,
    Desc = "TipsType_10045_Desc|事件区域不匹配！当前区域：{s1}，事件配置区域：{s2}"
  },
  ["10046"] = {
    ID = "10046",
    Type = 1,
    Desc = "TipsType_10046_Desc|事件商店删除卡牌次数已用完"
  },
  ["10047"] = {
    ID = "10047",
    Type = 1,
    Desc = "TipsType_10047_Desc|未找到课题单元数据"
  },
  ["10048"] = {
    ID = "10048",
    Type = 1,
    Desc = "TipsType_10048_Desc|单元已提交，无需再次提交"
  },
  ["10049"] = {
    ID = "10049",
    Type = 1,
    Desc = "TipsType_10049_Desc|单元下的课题尚未全部完成，无法提交"
  },
  ["10050"] = {
    ID = "10050",
    Type = 1,
    Desc = "TipsType_10050_Desc|未找到课题模块"
  },
  ["10051"] = {
    ID = "10051",
    Type = 1,
    Desc = "TipsType_10051_Desc|关卡没有课题数据"
  },
  ["10052"] = {
    ID = "10052",
    Type = 1,
    Desc = "TipsType_10052_Desc|没有此密境对应的课题"
  },
  ["10053"] = {
    ID = "10053",
    Type = 1,
    Desc = "TipsType_10053_Desc|学分不足，无法领取奖励"
  },
  ["10054"] = {
    ID = "10054",
    Type = 1,
    Desc = "TipsType_10054_Desc|学分奖励尚未达到领取条件"
  },
  ["10055"] = {
    ID = "10055",
    Type = 1,
    Desc = "TipsType_10055_Desc|课题分尚未找到任务"
  },
  ["10056"] = {
    ID = "10056",
    Type = 1,
    Desc = "TipsType_10056_Desc|课题分任务已完成"
  },
  ["10057"] = {
    ID = "10057",
    Type = 1,
    Desc = "TipsType_10057_Desc|课题分任务中的子任务未完成"
  },
  ["10058"] = {
    ID = "10058",
    Type = 1,
    Desc = "TipsType_10058_Desc|NPC已被触发"
  },
  ["10059"] = {
    ID = "10059",
    Type = 1,
    Desc = "TipsType_10059_Desc|NPC数据错误"
  },
  ["10060"] = {
    ID = "10060",
    Type = 1,
    Desc = "TipsType_10060_Desc|NPC不存在"
  },
  ["10061"] = {
    ID = "10061",
    Type = 1,
    Desc = "TipsType_10061_Desc|密境中未发现"
  },
  ["10062"] = {
    ID = "10062",
    Type = 1,
    Desc = "TipsType_10062_Desc|未发现共鸣数据"
  },
  ["10063"] = {
    ID = "10063",
    Type = 1,
    Desc = "TipsType_10063_Desc|共鸣已达最大等级"
  },
  ["10064"] = {
    ID = "10064",
    Type = 1,
    Desc = "TipsType_10064_Desc|未发现共鸣等级相关数据"
  },
  ["10065"] = {
    ID = "10065",
    Type = 1,
    Desc = "TipsType_10065_Desc|无重置次数"
  },
  ["10066"] = {
    ID = "10066",
    Type = 1,
    Desc = "TipsType_10066_Desc|未达到激活共鸣条件"
  },
  ["10067"] = {
    ID = "10067",
    Type = 1,
    Desc = "TipsType_10067_Desc|共鸣粒子不足"
  },
  ["10068"] = {
    ID = "10068",
    Type = 1,
    Desc = "TipsType_10068_Desc|启灵已完成，无法再次启灵"
  },
  ["10069"] = {
    ID = "10069",
    Type = 1,
    Desc = "TipsType_10069_Desc|启灵所需素材不足"
  },
  ["10070"] = {
    ID = "10070",
    Type = 1,
    Desc = "TipsType_10070_Desc|唤醒体升级所需素材不足"
  },
  ["10071"] = {
    ID = "10071",
    Type = 1,
    Desc = "TipsType_10071_Desc|唤醒体升级所需金券不足"
  },
  ["10072"] = {
    ID = "10072",
    Type = 1,
    Desc = "TipsType_10072_Desc|唤醒体升级所需金券不足"
  },
  ["10073"] = {
    ID = "10073",
    Type = 1,
    Desc = "TipsType_10073_Desc|无唤醒体技能"
  },
  ["10074"] = {
    ID = "10074",
    Type = 1,
    Desc = "TipsType_10074_Desc|尚未解锁唤醒体技能"
  },
  ["10075"] = {
    ID = "10075",
    Type = 1,
    Desc = "TipsType_10075_Desc|唤醒所需的「银芯」不足"
  },
  ["10076"] = {
    ID = "10076",
    Type = 1,
    Desc = "TipsType_10076_Desc|物品不足"
  },
  ["10077"] = {
    ID = "10077",
    Type = 1,
    Desc = "TipsType_10077_Desc|今日购买次数已达上限"
  },
  ["10078"] = {
    ID = "10078",
    Type = 1,
    Desc = "TipsType_10078_Desc|物品不可使用"
  },
  ["10079"] = {
    ID = "10079",
    Type = 1,
    Desc = "TipsType_10079_Desc|物品使用数量错误"
  },
  ["10080"] = {
    ID = "10080",
    Type = 1,
    Desc = "TipsType_10080_Desc|技能已达到最大等级"
  },
  ["10081"] = {
    ID = "10081",
    Type = 1,
    Desc = "TipsType_10081_Desc|素材不足，无法升级。"
  },
  ["10082"] = {
    ID = "10082",
    Type = 1,
    Desc = "TipsType_10082_Desc|货币不足，无法升级。"
  },
  ["10083"] = {
    ID = "10083",
    Type = 1,
    Desc = "TipsType_10083_Desc|唤醒体连接率已到达最高等级"
  },
  ["10084"] = {
    ID = "10084",
    Type = 1,
    Desc = "TipsType_10084_Desc|该唤醒体同源精神不足"
  },
  ["10085"] = {
    ID = "10085",
    Type = 1,
    Desc = "TipsType_10085_Desc|升级路线没有配置角色id"
  },
  ["10086"] = {
    ID = "10086",
    Type = 1,
    Desc = "TipsType_10086_Desc|找不到指定专属卡信息"
  },
  ["10087"] = {
    ID = "10087",
    Type = 1,
    Desc = "TipsType_10087_Desc|指定专属卡未解锁"
  },
  ["10088"] = {
    ID = "10088",
    Type = 1,
    Desc = "TipsType_10088_Desc|找不到该专属卡uuid"
  },
  ["10089"] = {
    ID = "10089",
    Type = 1,
    Desc = "TipsType_10089_Desc|章节奖励未达到积分"
  },
  ["10090"] = {
    ID = "10090",
    Type = 1,
    Desc = "TipsType_10090_Desc|章节奖励已领取"
  },
  ["10091"] = {
    ID = "10091",
    Type = 1,
    Desc = "TipsType_10091_Desc|选择的剧情线尚未解锁"
  },
  ["10092"] = {
    ID = "10092",
    Type = 1,
    Desc = "TipsType_10092_Desc|选择的副本尚未解锁"
  },
  ["10093"] = {
    ID = "10093",
    Type = 1,
    Desc = "TipsType_10093_Desc|副本区域尚未解锁"
  },
  ["10094"] = {
    ID = "10094",
    Type = 1,
    Desc = "TipsType_10094_Desc|剧情线扫荡尚未解锁"
  },
  ["10095"] = {
    ID = "10095",
    Type = 1,
    Desc = "TipsType_10095_Desc|未找到副本挑战的剧情线"
  },
  ["10096"] = {
    ID = "10096",
    Type = 1,
    Desc = "TipsType_10096_Desc|未找到副本挑战的剧情线任务"
  },
  ["10097"] = {
    ID = "10097",
    Type = 1,
    Desc = "TipsType_10097_Desc|挑战任务已完成,无法再次领取奖励"
  },
  ["10098"] = {
    ID = "10098",
    Type = 1,
    Desc = "TipsType_10098_Desc|挑战任务尚未完成,无法领取奖励"
  },
  ["10099"] = {
    ID = "10099",
    Type = 1,
    Desc = "TipsType_10099_Desc|建筑不存在"
  },
  ["10100"] = {
    ID = "10100",
    Type = 1,
    Desc = "TipsType_10100_Desc|建筑已到达最大等级"
  },
  ["10101"] = {
    ID = "10101",
    Type = 1,
    Desc = "TipsType_10101_Desc|升级/建设建筑条件不足"
  },
  ["10102"] = {
    ID = "10102",
    Type = 1,
    Desc = "TipsType_10102_Desc|建筑已存在不能再次建设"
  },
  ["10103"] = {
    ID = "10103",
    Type = 1,
    Desc = "TipsType_10103_Desc|升级/建设所需要的的道具不足"
  },
  ["10104"] = {
    ID = "10104",
    Type = 1,
    Desc = "TipsType_10104_Desc|位置已存在唤醒体,无法入驻"
  },
  ["10105"] = {
    ID = "10105",
    Type = 1,
    Desc = "TipsType_10105_Desc|合成道具所需的其他道具不足"
  },
  ["10106"] = {
    ID = "10106",
    Type = 1,
    Desc = "TipsType_10106_Desc|合成道具需要的货币不足"
  },
  ["10107"] = {
    ID = "10107",
    Type = 1,
    Desc = "TipsType_10107_Desc|合成道具未解锁"
  },
  ["10108"] = {
    ID = "10108",
    Type = 1,
    Desc = "TipsType_10108_Desc|连接服务器失败，请检查网络后重试"
  },
  ["10109"] = {
    ID = "10109",
    Type = 1,
    Desc = "TipsType_10109_Desc|营地已选择了功能无法再次选择"
  },
  ["10110"] = {
    ID = "10110",
    Type = 1,
    Desc = "TipsType_10110_Desc|营地功能已没有使用次数"
  },
  ["10111"] = {
    ID = "10111",
    Type = 1,
    Desc = "TipsType_10111_Desc|专属卡没有升级无法切换"
  },
  ["10112"] = {
    ID = "10112",
    Type = 1,
    Desc = "TipsType_10112_Desc|专属卡没有变化无法切换"
  },
  ["10113"] = {
    ID = "10113",
    Type = 1,
    Desc = "TipsType_10113_Desc|专属卡切换失败"
  },
  ["10114"] = {
    ID = "10114",
    Type = 1,
    Desc = "TipsType_10114_Desc|获得唤醒体{s1}"
  },
  ["10115"] = {
    ID = "10115",
    Type = 1,
    Desc = "TipsType_10115_Desc|重复获得{s1}，已转为了{s2}{s3}"
  },
  ["10116"] = {
    ID = "10116",
    Type = 1,
    Desc = "TipsType_10116_Desc|{s1}信物超过上限，已转为了{s2}{s3}"
  },
  ["10117"] = {
    ID = "10117",
    Type = 1,
    Desc = "TipsType_10117_Desc|Log上传成功"
  },
  ["10118"] = {
    ID = "10118",
    Type = 1,
    Desc = "TipsType_10118_Desc|指令不匹配，当前在等待指令 {s1}，输入了 {s2}"
  },
  ["10119"] = {
    ID = "10119",
    Type = 1,
    Desc = "TipsType_10119_Desc|失去卡牌:{s1}; uid:{s2}"
  },
  ["10120"] = {
    ID = "10120",
    Type = 1,
    Desc = "TipsType_10120_Desc|不可释放"
  },
  ["10121"] = {
    ID = "10121",
    Type = 1,
    Desc = "TipsType_10121_Desc|无此技能"
  },
  ["10122"] = {
    ID = "10122",
    Type = 1,
    Desc = "TipsType_10122_Desc|技能尚在缓冲"
  },
  ["10123"] = {
    ID = "10123",
    Type = 1,
    Desc = "TipsType_10123_Desc|技能次数耗尽"
  },
  ["10124"] = {
    ID = "10124",
    Type = 1,
    Desc = "TipsType_10124_Desc|检查建筑Tid {s1} 相关建筑升级次序是否循环"
  },
  ["10125"] = {
    ID = "10125",
    Type = 1,
    Desc = "TipsType_10125_Desc|检查建筑Tid {s1} 是否没有相关配置"
  },
  ["10126"] = {
    ID = "10126",
    Type = 1,
    Desc = "TipsType_10126_Desc|建筑Tid {s1} 实际等级应该是 {s2},配置的为 {s3}"
  },
  ["10127"] = {
    ID = "10127",
    Type = 1,
    Desc = "TipsType_10127_Desc|找不到建筑类型配置"
  },
  ["10128"] = {
    ID = "10128",
    Type = 1,
    Desc = "TipsType_10128_Desc|找不到建筑配置，或者没有建筑类型"
  },
  ["10129"] = {
    ID = "10129",
    Type = 1,
    Desc = "TipsType_10129_Desc|此剧情线课题分任务暂未开放"
  },
  ["10130"] = {
    ID = "10130",
    Type = 1,
    Desc = "TipsType_10130_Desc|移除成功"
  },
  ["10131"] = {
    ID = "10131",
    Type = 1,
    Desc = "TipsType_10131_Desc|成功增加「灵啡肽」× {s1}"
  },
  ["10132"] = {
    ID = "10132",
    Type = 1,
    Desc = "TipsType_10132_Desc|修复完成"
  },
  ["10133"] = {
    ID = "10133",
    Type = 1,
    Desc = "TipsType_10133_Desc|GM 添加道具根据道具名【\"..arg1..\"】没有找到对应的道具"
  },
  ["10134"] = {
    ID = "10134",
    Type = 1,
    Desc = "TipsType_10134_Desc|事件【\"..arg1..\"】不存在"
  },
  ["10135"] = {
    ID = "10135",
    Type = 1,
    Desc = "TipsType_10135_Desc|当前：按{s1}"
  },
  ["10136"] = {
    ID = "10136",
    Type = 1,
    Desc = "TipsType_10136_Desc|技能升级成功"
  },
  ["10137"] = {
    ID = "10137",
    Type = 1,
    Desc = "TipsType_10137_Desc|生成成功"
  },
  ["10138"] = {
    ID = "10138",
    Type = 1,
    Desc = "TipsType_10138_Desc|修改服务器时间成功"
  },
  ["10139"] = {
    ID = "10139",
    Type = 1,
    Desc = "TipsType_10139_Desc|修改服务器时间失败"
  },
  ["10140"] = {
    ID = "10140",
    Type = 1,
    Desc = "TipsType_10140_Desc|建筑总数：17\n此临时版本仅开放部分建筑"
  },
  ["10141"] = {
    ID = "10141",
    Type = 1,
    Desc = "TipsType_10141_Desc|未达到建筑解锁条件"
  },
  ["10142"] = {
    ID = "10142",
    Type = 1,
    Desc = "TipsType_10142_Desc|建筑:{s1}配置的界面不存在 {s2}"
  },
  ["10143"] = {
    ID = "10143",
    Type = 1,
    Desc = "TipsType_10143_Desc|该合成公式暂未解锁"
  },
  ["10144"] = {
    ID = "10144",
    Type = 1,
    Desc = "TipsType_10144_Desc|素材不足"
  },
  ["10145"] = {
    ID = "10145",
    Type = 1,
    Desc = "TipsType_10145_Desc|合成成功"
  },
  ["10146"] = {
    ID = "10146",
    Type = 1,
    Desc = "TipsType_10146_Desc|升级成功"
  },
  ["10147"] = {
    ID = "10147",
    Type = 1,
    Desc = "TipsType_10147_Desc|怪物栏为空，不能进入战斗"
  },
  ["10148"] = {
    ID = "10148",
    Type = 1,
    Desc = "TipsType_10148_Desc|「灵啡肽」回复"
  },
  ["10149"] = {
    ID = "10149",
    Type = 1,
    Desc = "TipsType_10149_Desc|填写的角色ID重复，不能进入战斗"
  },
  ["10150"] = {
    ID = "10150",
    Type = 1,
    Desc = "TipsType_10150_Desc|填写的ID{s1}不存在，不能进入战斗"
  },
  ["10151"] = {
    ID = "10151",
    Type = 1,
    Desc = "TipsType_10151_Desc|怪物没有对应的动作"
  },
  ["10152"] = {
    ID = "10152",
    Type = 1,
    Desc = "TipsType_10152_Desc|暂未开放"
  },
  ["10153"] = {
    ID = "10153",
    Type = 1,
    Desc = "TipsType_10153_Desc|当前卡堆中无卡牌"
  },
  ["10154"] = {
    ID = "10154",
    Type = 1,
    Desc = "TipsType_10154_Desc|其他卡牌生效中，不能出牌"
  },
  ["10155"] = {
    ID = "10155",
    Type = 1,
    Desc = "TipsType_10155_Desc|不在手卡中，无法打出"
  },
  ["10156"] = {
    ID = "10156",
    Type = 1,
    Desc = "TipsType_10156_Desc|此卡不可打出"
  },
  ["10157"] = {
    ID = "10157",
    Type = 1,
    Desc = "TipsType_10157_Desc|此卡未配置技能"
  },
  ["10158"] = {
    ID = "10158",
    Type = 1,
    Desc = "TipsType_10158_Desc|此卡不可打出"
  },
  ["10159"] = {
    ID = "10159",
    Type = 1,
    Desc = "TipsType_10159_Desc|算力不足"
  },
  ["10160"] = {
    ID = "10160",
    Type = 1,
    Desc = "TipsType_10160_Desc|场上没有对应唤醒体"
  },
  ["10161"] = {
    ID = "10161",
    Type = 1,
    Desc = "TipsType_10161_Desc|剩余次数不足"
  },
  ["10162"] = {
    ID = "10162",
    Type = 1,
    Desc = "TipsType_10162_Desc|使用探索技能"
  },
  ["10163"] = {
    ID = "10163",
    Type = 1,
    Desc = "TipsType_10163_Desc|已选择%d张指令卡"
  },
  ["10164"] = {
    ID = "10164",
    Type = 1,
    Desc = "TipsType_10164_Desc|已达数量上限"
  },
  ["10165"] = {
    ID = "10165",
    Type = 1,
    Desc = "TipsType_10165_Desc|尚未选中"
  },
  ["10166"] = {
    ID = "10166",
    Type = 1,
    Desc = "TipsType_10166_Desc|此卡不可消耗算力打出"
  },
  ["10167"] = {
    ID = "10167",
    Type = 1,
    Desc = "TipsType_10167_Desc|消耗总和超过"
  },
  ["10168"] = {
    ID = "10168",
    Type = 1,
    Desc = "TipsType_10168_Desc|已选择{s1}张卡牌"
  },
  ["10169"] = {
    ID = "10169",
    Type = 1,
    Desc = "TipsType_10169_Desc|触腕数量已达上限"
  },
  ["10170"] = {
    ID = "10170",
    Type = 1,
    Desc = "TipsType_10170_Desc|移除成功"
  },
  ["10171"] = {
    ID = "10171",
    Type = 1,
    Desc = "TipsType_10171_Desc|强化成功"
  },
  ["10172"] = {
    ID = "10172",
    Type = 1,
    Desc = "TipsType_10172_Desc|变化成功"
  },
  ["10173"] = {
    ID = "10173",
    Type = 1,
    Desc = "TipsType_10173_Desc|已复制到剪切板"
  },
  ["10174"] = {
    ID = "10174",
    Type = 1,
    Desc = "TipsType_10174_Desc|已成功获得指令卡"
  },
  ["10175"] = {
    ID = "10175",
    Type = 1,
    Desc = "TipsType_10175_Desc|移除次数已用尽"
  },
  ["10176"] = {
    ID = "10176",
    Type = 1,
    Desc = "TipsType_10176_Desc|强化次数已用尽"
  },
  ["10177"] = {
    ID = "10177",
    Type = 1,
    Desc = "TipsType_10177_Desc|变化次数已用尽"
  },
  ["10178"] = {
    ID = "10178",
    Type = 1,
    Desc = "TipsType_10178_Desc|复制次数已用尽"
  },
  ["10179"] = {
    ID = "10179",
    Type = 1,
    Desc = "TipsType_10179_Desc|选择指令卡张数到达上限"
  },
  ["10180"] = {
    ID = "10180",
    Type = 1,
    Desc = "TipsType_10180_Desc|尚未选择指令卡"
  },
  ["10181"] = {
    ID = "10181",
    Type = 1,
    Desc = "TipsType_10181_Desc|商城暂未开启，敬请期待。"
  },
  ["10182"] = {
    ID = "10182",
    Type = 1,
    Desc = "TipsType_10182_Desc|敬请期待"
  },
  ["10183"] = {
    ID = "10183",
    Type = 1,
    Desc = "TipsType_10183_Desc|课题目标所在区域过远，无法定位"
  },
  ["10184"] = {
    ID = "10184",
    Type = 1,
    Desc = "TipsType_10184_Desc|错过目标所在区域，无法完成"
  },
  ["10185"] = {
    ID = "10185",
    Type = 1,
    Desc = "TipsType_10185_Desc|暂未解锁此课题"
  },
  ["10186"] = {
    ID = "10186",
    Type = 1,
    Desc = "TipsType_10186_Desc|探索密境解锁更多调查"
  },
  ["10187"] = {
    ID = "10187",
    Type = 1,
    Desc = "TipsType_10187_Desc|完成前置任务解锁更多调查"
  },
  ["10188"] = {
    ID = "10188",
    Type = 1,
    Desc = "TipsType_10188_Desc|提交成功，课题分+{s1}"
  },
  ["10189"] = {
    ID = "10189",
    Type = 1,
    Desc = "TipsType_10189_Desc|没有可以提交的课题"
  },
  ["10190"] = {
    ID = "10190",
    Type = 1,
    Desc = "TipsType_10190_Desc|暂未开启，请留意副本开启时间。"
  },
  ["10191"] = {
    ID = "10191",
    Type = 1,
    Desc = "TipsType_10191_Desc|暂未达到关卡解锁条件"
  },
  ["10192"] = {
    ID = "10192",
    Type = 1,
    Desc = "TipsType_10192_Desc|{s1}不能为空"
  },
  ["10193"] = {
    ID = "10193",
    Type = 1,
    Desc = "TipsType_10193_Desc|{s1}和{s2}不能为空"
  },
  ["10194"] = {
    ID = "10194",
    Type = 1,
    Desc = "TipsType_10194_Desc|刷新次数已用尽，无法刷新。"
  },
  ["10195"] = {
    ID = "10195",
    Type = 1,
    Desc = "TipsType_10195_Desc|获取途径尚未解锁"
  },
  ["10196"] = {
    ID = "10196",
    Type = 1,
    Desc = "TipsType_10196_Desc|获取途径不在开放时间内"
  },
  ["10197"] = {
    ID = "10197",
    Type = 1,
    Desc = "TipsType_10197_Desc|请选择需变化的造物"
  },
  ["10198"] = {
    ID = "10198",
    Type = 1,
    Desc = "TipsType_10198_Desc|移除成功"
  },
  ["10199"] = {
    ID = "10199",
    Type = 1,
    Desc = "TipsType_10199_Desc|移除次数已用尽"
  },
  ["10200"] = {
    ID = "10200",
    Type = 1,
    Desc = "TipsType_10200_Desc|变化次数已用尽"
  },
  ["10201"] = {
    ID = "10201",
    Type = 1,
    Desc = "TipsType_10201_Desc|请选择需移除的造物"
  },
  ["10202"] = {
    ID = "10202",
    Type = 1,
    Desc = "TipsType_10202_Desc|数量已达上限"
  },
  ["10203"] = {
    ID = "10203",
    Type = 1,
    Desc = "TipsType_10203_Desc|请至少选择{s1}个造物"
  },
  ["10204"] = {
    ID = "10204",
    Type = 1,
    Desc = "TipsType_10204_Desc|当前剩余切换次数为0，无法进行切换"
  },
  ["10205"] = {
    ID = "10205",
    Type = 1,
    Desc = "TipsType_10205_Desc|所有专属卡均已升至等级上限"
  },
  ["10206"] = {
    ID = "10206",
    Type = 1,
    Desc = "TipsType_10206_Desc|当前排斥度为0，无法继续降低"
  },
  ["10207"] = {
    ID = "10207",
    Type = 1,
    Desc = "TipsType_10207_Desc|暂未开放"
  },
  ["10208"] = {
    ID = "10208",
    Type = 1,
    Desc = "TipsType_10208_Desc|锢灵之锚不足，无法进行强化"
  },
  ["10209"] = {
    ID = "10209",
    Type = 1,
    Desc = "TipsType_10209_Desc|需{s1}达到{s2}级方可施行启灵"
  },
  ["10210"] = {
    ID = "10210",
    Type = 1,
    Desc = "TipsType_10210_Desc|「{s1}」不足"
  },
  ["10211"] = {
    ID = "10211",
    Type = 1,
    Desc = "TipsType_10211_Desc|暂未拥有「{s1}」"
  },
  ["10212"] = {
    ID = "10212",
    Type = 1,
    Desc = "TipsType_10212_Desc|已达等级上限"
  },
  ["10213"] = {
    ID = "10213",
    Type = 1,
    Desc = "TipsType_10213_Desc|请先选择素材"
  },
  ["10214"] = {
    ID = "10214",
    Type = 1,
    Desc = "TipsType_10214_Desc|「{s1}」不足"
  },
  ["10215"] = {
    ID = "10215",
    Type = 1,
    Desc = "TipsType_10215_Desc|升级成功"
  },
  ["10216"] = {
    ID = "10216",
    Type = 1,
    Desc = "TipsType_10216_Desc|灵知制剂已增加"
  },
  ["10217"] = {
    ID = "10217",
    Type = 1,
    Desc = "TipsType_10217_Desc|已达启灵上限"
  },
  ["10218"] = {
    ID = "10218",
    Type = 1,
    Desc = "TipsType_10218_Desc|升级失败"
  },
  ["10219"] = {
    ID = "10219",
    Type = 1,
    Desc = "TipsType_10219_Desc|道具不足，无法升级"
  },
  ["10220"] = {
    ID = "10220",
    Type = 1,
    Desc = "TipsType_10220_Desc|Lv. MAX"
  },
  ["10221"] = {
    ID = "10221",
    Type = 1,
    Desc = "TipsType_10221_Desc|技能升级成功"
  },
  ["10222"] = {
    ID = "10222",
    Type = 1,
    Desc = "TipsType_10222_Desc|黑印不足，无法购买"
  },
  ["10223"] = {
    ID = "10223",
    Type = 1,
    Desc = "TipsType_10223_Desc|售罄"
  },
  ["10224"] = {
    ID = "10224",
    Type = 1,
    Desc = "TipsType_10224_Desc|黑印不足，无法移除指令卡"
  },
  ["10225"] = {
    ID = "10225",
    Type = 1,
    Desc = "TipsType_10225_Desc|移除{s1}张指令卡"
  },
  ["10226"] = {
    ID = "10226",
    Type = 1,
    Desc = "TipsType_10226_Desc|此方向暂未开放，无法进行强化"
  },
  ["10227"] = {
    ID = "10227",
    Type = 1,
    Desc = "TipsType_10227_Desc|此方向已强化至上限等级"
  },
  ["10228"] = {
    ID = "10228",
    Type = 1,
    Desc = "TipsType_10228_Desc|请先选择专属卡希望强化的方向"
  },
  ["10229"] = {
    ID = "10229",
    Type = 1,
    Desc = "TipsType_10229_Desc|锢灵之锚不足，无法进行强化"
  },
  ["10230"] = {
    ID = "10230",
    Type = 1,
    Desc = "TipsType_10230_Desc|暂未拥有该界域唤醒体，无法选择。"
  },
  ["10231"] = {
    ID = "10231",
    Type = 1,
    Desc = "TipsType_10231_Desc|创建一个队伍"
  },
  ["10232"] = {
    ID = "10232",
    Type = 1,
    Desc = "TipsType_10232_Desc|队伍名称不能超过{s1}汉字"
  },
  ["10233"] = {
    ID = "10233",
    Type = 1,
    Desc = "TipsType_10233_Desc|队伍名称不能为空"
  },
  ["10234"] = {
    ID = "10234",
    Type = 1,
    Desc = "TipsType_10234_Desc|兑换成功。"
  },
  ["10235"] = {
    ID = "10235",
    Type = 1,
    Desc = "TipsType_10235_Desc|没有更多「银芯」了。"
  },
  ["10236"] = {
    ID = "10236",
    Type = 1,
    Desc = "TipsType_10236_Desc|不能再减少了。"
  },
  ["10237"] = {
    ID = "10237",
    Type = 1,
    Desc = "TipsType_10237_Desc|{s1}暂未开启，敬请期待。"
  },
  ["10238"] = {
    ID = "10238",
    Type = 1,
    Desc = "TipsType_10238_Desc|召唤暂未开启，敬请期待。"
  },
  ["10239"] = {
    ID = "10239",
    Type = 1,
    Desc = "TipsType_10239_Desc|校园小地图功能暂未开启"
  },
  ["10240"] = {
    ID = "10240",
    Type = 1,
    Desc = "TipsType_10240_Desc|课题等级{s1}时解锁"
  },
  ["10241"] = {
    ID = "10241",
    Type = 1,
    Desc = "TipsType_10241_Desc|没有符合条件的卡牌"
  },
  ["10242"] = {
    ID = "10242",
    Type = 1,
    Desc = "TipsType_10242_Desc|所有界域卡已升级"
  },
  ["10243"] = {
    ID = "10243",
    Type = 1,
    Desc = "TipsType_10243_Desc|没有可升级的指令卡"
  },
  ["10244"] = {
    ID = "10244",
    Type = 1,
    Desc = "TipsType_10244_Desc|发现新的传送点！可前往{s1}。"
  },
  ["10245"] = {
    ID = "10245",
    Type = 1,
    Desc = "TipsType_10245_Desc|已经获得过此造物，无法重复获得"
  },
  ["10246"] = {
    ID = "10246",
    Type = 1,
    Desc = "TipsType_10246_Desc|恢复成功"
  },
  ["10247"] = {
    ID = "10247",
    Type = 1,
    Desc = "TipsType_10247_Desc|移除成功"
  },
  ["10248"] = {
    ID = "10248",
    Type = 1,
    Desc = "TipsType_10248_Desc|打开背包界面"
  },
  ["10249"] = {
    ID = "10249",
    Type = 1,
    Desc = "TipsType_10249_Desc|检测到您上次异常下线，现已将「灵啡肽」及应得物资返还，可打开背包查看"
  },
  ["10250"] = {
    ID = "10250",
    Type = 1,
    Desc = "TipsType_10250_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10251"] = {
    ID = "10251",
    Type = 1,
    Desc = "TipsType_10251_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10252"] = {
    ID = "10252",
    Type = 1,
    Desc = "TipsType_10252_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10253"] = {
    ID = "10253",
    Type = 1,
    Desc = "TipsType_10253_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10254"] = {
    ID = "10254",
    Type = 1,
    Desc = "TipsType_10254_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10255"] = {
    ID = "10255",
    Type = 1,
    Desc = "TipsType_10255_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10256"] = {
    ID = "10256",
    Type = 1,
    Desc = "TipsType_10256_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10257"] = {
    ID = "10257",
    Type = 1,
    Desc = "TipsType_10257_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10258"] = {
    ID = "10258",
    Type = 1,
    Desc = "TipsType_10258_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10259"] = {
    ID = "10259",
    Type = 1,
    Desc = "TipsType_10259_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10260"] = {
    ID = "10260",
    Type = 1,
    Desc = "TipsType_10260_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10261"] = {
    ID = "10261",
    Type = 1,
    Desc = "TipsType_10261_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10262"] = {
    ID = "10262",
    Type = 1,
    Desc = "TipsType_10262_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10263"] = {
    ID = "10263",
    Type = 1,
    Desc = "TipsType_10263_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10264"] = {
    ID = "10264",
    Type = 1,
    Desc = "TipsType_10264_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10265"] = {
    ID = "10265",
    Type = 1,
    Desc = "TipsType_10265_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10266"] = {
    ID = "10266",
    Type = 1,
    Desc = "TipsType_10266_Desc|AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  ["10267"] = {
    ID = "10267",
    Type = 1,
    Desc = "TipsType_10267_Desc|不满足使用条件"
  },
  ["10268"] = {
    ID = "10268",
    Type = 1,
    Desc = "TipsType_10268_Desc|调查等级2级解锁快速调查"
  },
  ["10269"] = {
    ID = "10269",
    Type = 1,
    Desc = "TipsType_10269_Desc|连接中断"
  },
  ["10270"] = {
    ID = "10270",
    Type = 1,
    Desc = "TipsType_10270_Desc|服务器连接中断，稍后将返回登录页面。"
  },
  ["10271"] = {
    ID = "10271",
    Type = 1,
    Desc = "TipsType_10271_Desc|确认"
  },
  ["10272"] = {
    ID = "10272",
    Type = 1,
    Desc = "TipsType_10272_Desc|服务器尚未开放，请稍后再试。"
  },
  ["10273"] = {
    ID = "10273",
    Type = 1,
    Desc = "TipsType_10273_Desc|操作成功"
  },
  ["10274"] = {
    ID = "10274",
    Type = 1,
    Desc = "TipsType_10274_Desc|未找到对应密境"
  },
  ["10275"] = {
    ID = "10275",
    Type = 1,
    Desc = "TipsType_10275_Desc|密境事件已完成"
  },
  ["10276"] = {
    ID = "10276",
    Type = 1,
    Desc = "TipsType_10276_Desc|密境事件配置类型填写错误"
  },
  ["10277"] = {
    ID = "10277",
    Type = 1,
    Desc = "TipsType_10277_Desc|密境事件不存在"
  },
  ["10278"] = {
    ID = "10278",
    Type = 1,
    Desc = "TipsType_10278_Desc|黑印不足，无法购买"
  },
  ["10279"] = {
    ID = "10279",
    Type = 1,
    Desc = "TipsType_10279_Desc|此卡无法强化"
  },
  ["10280"] = {
    ID = "10280",
    Type = 1,
    Desc = "TipsType_10280_Desc|此卡已达强化上限"
  },
  ["10281"] = {
    ID = "10281",
    Type = 1,
    Desc = "TipsType_10281_Desc|行商不出售此商品"
  },
  ["10282"] = {
    ID = "10282",
    Type = 1,
    Desc = "TipsType_10282_Desc|无此奖励"
  },
  ["10283"] = {
    ID = "10283",
    Type = 1,
    Desc = "TipsType_10283_Desc|奖励已领取"
  },
  ["10284"] = {
    ID = "10284",
    Type = 1,
    Desc = "TipsType_10284_Desc|配置表错误"
  },
  ["10285"] = {
    ID = "10285",
    Type = 1,
    Desc = "TipsType_10285_Desc|事件数据错误"
  },
  ["10286"] = {
    ID = "10286",
    Type = 1,
    Desc = "TipsType_10286_Desc|商品已购买"
  },
  ["10287"] = {
    ID = "10287",
    Type = 1,
    Desc = "TipsType_10287_Desc|未找到课题单元数据"
  },
  ["10288"] = {
    ID = "10288",
    Type = 1,
    Desc = "TipsType_10288_Desc|单元已提交，无需再次提交"
  },
  ["10289"] = {
    ID = "10289",
    Type = 1,
    Desc = "TipsType_10289_Desc|单元下的课题尚未全部完成，无法提交"
  },
  ["10290"] = {
    ID = "10290",
    Type = 1,
    Desc = "TipsType_10290_Desc|课题无模块"
  },
  ["10291"] = {
    ID = "10291",
    Type = 1,
    Desc = "TipsType_10291_Desc|关卡无课题数据"
  },
  ["10292"] = {
    ID = "10292",
    Type = 1,
    Desc = "TipsType_10292_Desc|客户端传入数据错误"
  },
  ["10293"] = {
    ID = "10293",
    Type = 1,
    Desc = "TipsType_10293_Desc|服务未启动"
  },
  ["10294"] = {
    ID = "10294",
    Type = 1,
    Desc = "TipsType_10294_Desc|角色数据错误"
  },
  ["10295"] = {
    ID = "10295",
    Type = 1,
    Desc = "TipsType_10295_Desc|没有角色，需创建"
  },
  ["10296"] = {
    ID = "10296",
    Type = 1,
    Desc = "TipsType_10296_Desc|已有角色，不需要再次创建"
  },
  ["10297"] = {
    ID = "10297",
    Type = 1,
    Desc = "TipsType_10297_Desc|角色名重复"
  },
  ["10298"] = {
    ID = "10298",
    Type = 1,
    Desc = "TipsType_10298_Desc|密境错误"
  },
  ["10299"] = {
    ID = "10299",
    Type = 1,
    Desc = "TipsType_10299_Desc|该剧情线尚未解锁，无法进入。"
  },
  ["10300"] = {
    ID = "10300",
    Type = 1,
    Desc = "TipsType_10300_Desc|在此处可以查看地形效果以及怪物信息"
  },
  ["10301"] = {
    ID = "10301",
    Type = 1,
    Desc = "TipsType_10301_Desc|{s1}达到{s2}解锁{s3}"
  },
  ["10302"] = {
    ID = "10302",
    Type = 1,
    Desc = "TipsType_10302_Desc|{s1}达到{s2}解锁{s3}"
  },
  ["10303"] = {
    ID = "10303",
    Type = 1,
    Desc = "TipsType_10303_Desc|未达到建筑解锁条件"
  },
  ["10304"] = {
    ID = "10304",
    Type = 1,
    Desc = "TipsType_10304_Desc|未达到建筑升级条件"
  },
  ["10305"] = {
    ID = "10305",
    Type = 1,
    Desc = "TipsType_10305_Desc|建筑升级素材不足"
  },
  ["10306"] = {
    ID = "10306",
    Type = 1,
    Desc = "TipsType_10306_Desc|有可领取的任务奖励"
  },
  ["10307"] = {
    ID = "10307",
    Type = 1,
    Desc = "TipsType_10307_Desc|（生命将降低<Negative:10%%>）"
  },
  ["10308"] = {
    ID = "10308",
    Type = 1,
    Desc = "TipsType_10308_Desc|每回合结束时，获得等同于当前加护层数的<BuffTipBlock:护盾>值。每次受到伤害，加护减少<BuffTip:1>层"
  },
  ["10309"] = {
    ID = "10309",
    Type = 1,
    Desc = "TipsType_10309_Desc|多重加护"
  },
  ["10310"] = {
    ID = "10310",
    Type = 1,
    Desc = "TipsType_10310_Desc|体力低于警戒值，调查风险提高"
  },
  ["10311"] = {
    ID = "10311",
    Type = 1,
    Desc = "TipsType_10311_Desc|体力低于警戒值，调查风险极高，是否选择强行进入？"
  },
  ["10312"] = {
    ID = "10312",
    Type = 1,
    Desc = "TipsType_10312_Desc|当前体力过低，无法进入密境。"
  },
  ["10313"] = {
    ID = "10313",
    Type = 1,
    Desc = "TipsType_10313_Desc|请选择同等级专属卡进行切换"
  },
  ["10314"] = {
    ID = "10314",
    Type = 1,
    Desc = "TipsType_10314_Desc|唤醒体启灵2级后解锁该方向"
  },
  ["10315"] = {
    ID = "10315",
    Type = 1,
    Desc = "TipsType_10315_Desc|唤醒体启灵3级后解锁该方向"
  },
  ["10316"] = {
    ID = "10316",
    Type = 1,
    Desc = "TipsType_10316_Desc|当前"
  },
  ["10317"] = {
    ID = "10317",
    Type = 1,
    Desc = "TipsType_10317_Desc|所有唤醒体均未解锁技能，无法充能"
  },
  ["10318"] = {
    ID = "10318",
    Type = 1,
    Desc = "TipsType_10318_Desc|所有唤醒体技能的能量已满"
  },
  ["10319"] = {
    ID = "10319",
    Type = 1,
    Desc = "TipsType_10319_Desc|已使用"
  },
  ["10320"] = {
    ID = "10320",
    Type = 1,
    Desc = "TipsType_10320_Desc|黑印不足"
  },
  ["10321"] = {
    ID = "10321",
    Type = 1,
    Desc = "TipsType_10321_Desc|黑印不足"
  },
  ["10322"] = {
    ID = "10322",
    Type = 1,
    Desc = "TipsType_10322_Desc|黑印不足"
  },
  ["10323"] = {
    ID = "10323",
    Type = 1,
    Desc = "TipsType_10323_Desc|无法重复获得已有造物"
  },
  ["10324"] = {
    ID = "10324",
    Type = 1,
    Desc = "TipsType_10324_Desc|刷新次数不足"
  },
  ["10325"] = {
    ID = "10325",
    Type = 1,
    Desc = "TipsType_10325_Desc|将对我方造成{s1}点伤害。"
  },
  ["10326"] = {
    ID = "10326",
    Type = 1,
    Desc = "TipsType_10326_Desc|攻击"
  },
  ["10327"] = {
    ID = "10327",
    Type = 1,
    Desc = "TipsType_10327_Desc|在这里会显示关卡的小地图预览，玩家可以提前进行策略部署"
  },
  ["10328"] = {
    ID = "10328",
    Type = 1,
    Desc = "TipsType_10328_Desc|你花了10分钟完成日常副本中的一个关卡，在这里得到了独特的玩法体验并且通过关卡设计强化了流派认知"
  },
  ["10329"] = {
    ID = "10329",
    Type = 1,
    Desc = "TipsType_10329_Desc|当前生命上限已低于最大生命上限的50%，请注意安全"
  },
  ["10330"] = {
    ID = "10330",
    Type = 1,
    Desc = "TipsType_10330_Desc|维系唤醒体存在的能量。受到伤害会减少生命，生命归零即代表调查失败。"
  },
  ["10331"] = {
    ID = "10331",
    Type = 1,
    Desc = "TipsType_10331_Desc|唤醒体攻击强度的体现。力量越强，使用指令卡时对敌方造成的伤害越高。"
  },
  ["10332"] = {
    ID = "10332",
    Type = 1,
    Desc = "TipsType_10332_Desc|唤醒体防御能力的体现。戒备越高，使用指令卡时获得的护盾越多。"
  },
  ["10333"] = {
    ID = "10333",
    Type = 1,
    Desc = "TipsType_10333_Desc|点击任意处继续"
  },
  ["10334"] = {
    ID = "10334",
    Type = 1,
    Desc = "TipsType_10334_Desc|尚未完成任务调查项目"
  },
  ["10335"] = {
    ID = "10335",
    Type = 1,
    Desc = "TipsType_10335_Desc|调查评价"
  },
  ["10336"] = {
    ID = "10336",
    Type = 1,
    Desc = "TipsType_10336_Desc|赋予1张专属卡以启示之灵"
  },
  ["10337"] = {
    ID = "10337",
    Type = 1,
    Desc = "TipsType_10337_Desc|选择专属卡的强化方向"
  },
  ["10338"] = {
    ID = "10338",
    Type = 1,
    Desc = "TipsType_10338_Desc|主城小地图暂未开启，敬请期待。"
  },
  ["10339"] = {
    ID = "10339",
    Type = 1,
    Desc = "TipsType_10339_Desc|{s1}{s2}值"
  },
  ["10340"] = {
    ID = "10340",
    Type = 1,
    Desc = "TipsType_10340_Desc|{s1}基础卡组等级提升"
  },
  ["10341"] = {
    ID = "10341",
    Type = 1,
    Desc = "TipsType_10341_Desc|<Positive:好感度：>"
  },
  ["10342"] = {
    ID = "10342",
    Type = 1,
    Desc = "TipsType_10342_Desc|与唤醒体之间的情感联结的体现。好感度加深，可更加深入了解唤醒体。"
  },
  ["10343"] = {
    ID = "10343",
    Type = 1,
    Desc = "TipsType_10343_Desc|<Positive:当前等级：>{s1}"
  },
  ["10344"] = {
    ID = "10344",
    Type = 1,
    Desc = "TipsType_10344_Desc|<Positive:基础卡组：>"
  },
  ["10345"] = {
    ID = "10345",
    Type = 1,
    Desc = "TipsType_10345_Desc|该界域进入副本时拥有的初始卡组。"
  },
  ["10346"] = {
    ID = "10346",
    Type = 1,
    Desc = "TipsType_10346_Desc|<Positive:卡组最高等级：>{s1}级"
  },
  ["10347"] = {
    ID = "10347",
    Type = 1,
    Desc = "TipsType_10347_Desc|<Positive:卡组等级：>"
  },
  ["10348"] = {
    ID = "10348",
    Type = 1,
    Desc = "TipsType_10348_Desc|该界域指定数量唤醒体达到指定好感度等级时，可升级基础卡组。"
  },
  ["10349"] = {
    ID = "10349",
    Type = 1,
    Desc = "TipsType_10349_Desc|<Positive:升级内容：>"
  },
  ["10350"] = {
    ID = "10350",
    Type = 1,
    Desc = "TipsType_10350_Desc|每次升级将提升一种指令卡的基础值。"
  },
  ["10351"] = {
    ID = "10351",
    Type = 1,
    Desc = "TipsType_10351_Desc|{s1}好感度提升"
  },
  ["10352"] = {
    ID = "10352",
    Type = 1,
    Desc = "TipsType_10352_Desc|密境沉寂中"
  },
  ["10353"] = {
    ID = "10353",
    Type = 1,
    Desc = "TipsType_10353_Desc|密境排斥入侵者"
  },
  ["10354"] = {
    ID = "10354",
    Type = 1,
    Desc = "TipsType_10354_Desc|密境排斥度增加"
  },
  ["10355"] = {
    ID = "10355",
    Type = 1,
    Desc = "TipsType_10355_Desc|排斥度达到{s1}，密境正在注视你"
  },
  ["10356"] = {
    ID = "10356",
    Type = 1,
    Desc = "TipsType_10356_Desc|启灵1"
  },
  ["10357"] = {
    ID = "10357",
    Type = 1,
    Desc = "TipsType_10357_Desc|领会该技能"
  },
  ["10358"] = {
    ID = "10358",
    Type = 1,
    Desc = "TipsType_10358_Desc|能够同时存在的触腕数量最大值。"
  },
  ["10359"] = {
    ID = "10359",
    Type = 1,
    Desc = "TipsType_10359_Desc|触腕攻击强度的体现。触腕力量越强，激发触腕时对敌方造成的伤害越高。"
  },
  ["10360"] = {
    ID = "10360",
    Type = 1,
    Desc = "TipsType_10360_Desc|尚未选择指令卡"
  },
  ["10361"] = {
    ID = "10361",
    Type = 1,
    Desc = "TipsType_10361_Desc|变化成功"
  },
  ["10362"] = {
    ID = "10362",
    Type = 1,
    Desc = "TipsType_10362_Desc|尚未选择指令卡"
  },
  ["10363"] = {
    ID = "10363",
    Type = 1,
    Desc = "TipsType_10363_Desc|复制成功"
  },
  ["10364"] = {
    ID = "10364",
    Type = 1,
    Desc = "TipsType_10364_Desc|已选择{s1}张指令卡"
  },
  ["10365"] = {
    ID = "10365",
    Type = 1,
    Desc = "TipsType_10365_Desc|尚未选择指令卡"
  },
  ["10366"] = {
    ID = "10366",
    Type = 1,
    Desc = "TipsType_10366_Desc|尚未选择指令卡"
  },
  ["10367"] = {
    ID = "10367",
    Type = 1,
    Desc = "TipsType_10367_Desc|升级成功"
  },
  ["10368"] = {
    ID = "10368",
    Type = 1,
    Desc = "TipsType_10368_Desc|造物背包界面开发中，敬请期待"
  },
  ["10369"] = {
    ID = "10369",
    Type = 1,
    Desc = "TipsType_10369_Desc|请选择需变化的造物"
  },
  ["10370"] = {
    ID = "10370",
    Type = 1,
    Desc = "TipsType_10370_Desc|版本更新，请重新下载安装包"
  },
  ["10371"] = {
    ID = "10371",
    Type = 1,
    Desc = "TipsType_10371_Desc|进阶效应"
  },
  ["10372"] = {
    ID = "10372",
    Type = 1,
    Desc = "TipsType_10372_Desc|密境信息"
  },
  ["10373"] = {
    ID = "10373",
    Type = 1,
    Desc = "TipsType_10373_Desc|每使用1张伤害卡，触腕会对随机敌人造成{s1}点伤害。"
  },
  ["10374"] = {
    ID = "10374",
    Type = 1,
    Desc = "TipsType_10374_Desc|当前无待完成课题"
  },
  ["10375"] = {
    ID = "10375",
    Type = 1,
    Desc = "TipsType_10375_Desc|当前无已归档课题"
  },
  ["10376"] = {
    ID = "10376",
    Type = 1,
    Desc = "TipsType_10376_Desc|本次调查未完成课题"
  },
  ["10377"] = {
    ID = "10377",
    Type = 1,
    Desc = "TipsType_10377_Desc|无法回退"
  },
  ["10378"] = {
    ID = "10378",
    Type = 1,
    Desc = "TipsType_10378_Desc|(以下课题已自动归档)"
  },
  ["10379"] = {
    ID = "10379",
    Type = 1,
    Desc = "TipsType_10379_Desc|目标课题已完成"
  },
  ["10380"] = {
    ID = "10380",
    Type = 1,
    Desc = "TipsType_10380_Desc|您没有此道具"
  },
  ["10381"] = {
    ID = "10381",
    Type = 1,
    Desc = "TipsType_10381_Desc|错误的索引值"
  },
  ["10382"] = {
    ID = "10382",
    Type = 1,
    Desc = "TipsType_10382_Desc|未解锁"
  },
  ["10383"] = {
    ID = "10383",
    Type = 1,
    Desc = "TipsType_10383_Desc|专属卡升级，没有次数"
  },
  ["10384"] = {
    ID = "10384",
    Type = 1,
    Desc = "TipsType_10384_Desc|已解锁1个造物保留格！"
  },
  ["10385"] = {
    ID = "10385",
    Type = 1,
    Desc = "TipsType_10385_Desc|连接率提升"
  },
  ["10386"] = {
    ID = "10386",
    Type = 1,
    Desc = "TipsType_10386_Desc|没有槽位信息"
  },
  ["10387"] = {
    ID = "10387",
    Type = 1,
    Desc = "TipsType_10387_Desc|货币不足"
  },
  ["10388"] = {
    ID = "10388",
    Type = 1,
    Desc = "TipsType_10388_Desc|已到达最大等级"
  },
  ["10389"] = {
    ID = "10389",
    Type = 1,
    Desc = "TipsType_10389_Desc|开发中敬请期待"
  },
  ["10390"] = {
    ID = "10390",
    Type = 1,
    Desc = "TipsType_10390_Desc|已没有手动升级槽位次数"
  },
  ["10391"] = {
    ID = "10391",
    Type = 1,
    Desc = "TipsType_10391_Desc|在商店或营地解除封印后可使用"
  },
  ["10392"] = {
    ID = "10392",
    Type = 1,
    Desc = "TipsType_10392_Desc|本场战斗扣除{s1}体力"
  },
  ["10393"] = {
    ID = "10393",
    Type = 1,
    Desc = "TipsType_10393_Desc|唤醒体能量已满，无法继续提升"
  },
  ["10394"] = {
    ID = "10394",
    Type = 1,
    Desc = "TipsType_10394_Desc|已将所有唤醒体的能量提升完毕"
  },
  ["10395"] = {
    ID = "10395",
    Type = 1,
    Desc = "TipsType_10395_Desc|需要使用「眼」解锁"
  },
  ["10396"] = {
    ID = "10396",
    Type = 1,
    Desc = "TipsType_10396_Desc|已成功刻印"
  },
  ["10397"] = {
    ID = "10397",
    Type = 1,
    Desc = "TipsType_10397_Desc|已上阵{s1}唤醒体，队伍将携带{s2}界域特性。"
  },
  ["10398"] = {
    ID = "10398",
    Type = 1,
    Desc = "TipsType_10398_Desc|队伍将变为中立，不携带任何界域特性。"
  },
  ["10399"] = {
    ID = "10399",
    Type = 1,
    Desc = "TipsType_10399_Desc|小循环系统验证在第四章关卡开启"
  },
  ["10400"] = {
    ID = "10400",
    Type = 1,
    Desc = "TipsType_10400_Desc|最多继承{s1}个造物，请先减少选中造物数量。"
  },
  ["10401"] = {
    ID = "10401",
    Type = 1,
    Desc = "TipsType_10401_Desc|未勾选造物无法继承"
  },
  ["10405"] = {
    ID = "10405",
    Type = 1,
    Desc = "TipsType_10405_Desc|获得{s1}"
  },
  ["10406"] = {
    ID = "10406",
    Type = 1,
    Desc = "TipsType_10406_Desc|上阵唤醒体已达到上限"
  },
  ["10407"] = {
    ID = "10407",
    Type = 1,
    Desc = "TipsType_10407_Desc|该黄金塔无法挑战-"
  },
  ["10408"] = {
    ID = "10408",
    Type = 1,
    Desc = "TipsType_10408_Desc|该黄金塔未解锁-请完成指定的调查副本"
  },
  ["10409"] = {
    ID = "10409",
    Type = 1,
    Desc = "TipsType_10409_Desc|请选择上场的唤醒体"
  },
  ["10410"] = {
    ID = "10410",
    Type = 1,
    Desc = "TipsType_10410_Desc|唤醒体正在努力完成派遣任务，晚点再来领取吧"
  },
  ["10411"] = {
    ID = "10411",
    Type = 1,
    Desc = "TipsType_10411_Desc|已领取{s1}蔷薇金券"
  },
  ["10412"] = {
    ID = "10412",
    Type = 1,
    Desc = "TipsType_10412_Desc|时间报酬需要随时间累积"
  },
  ["10413"] = {
    ID = "10413",
    Type = 1,
    Desc = "TipsType_10413_Desc|「银芯」不足"
  },
  ["10414"] = {
    ID = "10414",
    Type = 1,
    Desc = "TipsType_10414_Desc|没有挑战次数"
  },
  ["10415"] = {
    ID = "10415",
    Type = 1,
    Desc = "TipsType_10415_Desc|挑战冷却中"
  },
  ["10416"] = {
    ID = "10416",
    Type = 1,
    Desc = "TipsType_10416_Desc|没有挑战对手"
  },
  ["10417"] = {
    ID = "10417",
    Type = 1,
    Desc = "TipsType_10417_Desc|请选择上阵的唤醒体"
  },
  ["10418"] = {
    ID = "10418",
    Type = 1,
    Desc = "TipsType_10418_Desc|灵知制剂不足，无法继续提升等级"
  },
  ["10419"] = {
    ID = "10419",
    Type = 1,
    Desc = "TipsType_10419_Desc|当前等级已达上限"
  },
  ["10420"] = {
    ID = "10420",
    Type = 1,
    Desc = "TipsType_10420_Desc|唤醒体暂未解锁"
  },
  ["10421"] = {
    ID = "10421",
    Type = 1,
    Desc = "TipsType_10421_Desc|解除收藏成功"
  },
  ["10422"] = {
    ID = "10422",
    Type = 1,
    Desc = "TipsType_10422_Desc|剧情线挑战购买次数不足"
  },
  ["10423"] = {
    ID = "10423",
    Type = 1,
    Desc = "TipsType_10423_Desc|剧情线星级不足，无法扫荡"
  },
  ["10424"] = {
    ID = "10424",
    Type = 1,
    Desc = "TipsType_10424_Desc|调查副本队伍界域搭配错误"
  },
  ["10425"] = {
    ID = "10425",
    Type = 1,
    Desc = "TipsType_10425_Desc|「银芯」不足"
  },
  ["10426"] = {
    ID = "10426",
    Type = 1,
    Desc = "TipsType_10426_Desc|今日凭证购买次数已达上限"
  },
  ["10427"] = {
    ID = "10427",
    Type = 1,
    Desc = "TipsType_10427_Desc|三星通关秘境后解锁"
  },
  ["10428"] = {
    ID = "10428",
    Type = 1,
    Desc = "TipsType_10428_Desc|成功获取{s1}张凭证"
  },
  ["10429"] = {
    ID = "10429",
    Type = 1,
    Desc = "TipsType_10429_Desc|成功获得{s1}次挑战次数"
  },
  ["10430"] = {
    ID = "10430",
    Type = 1,
    Desc = "TipsType_10430_Desc|通关 调查4-6 解锁"
  },
  ["10431"] = {
    ID = "10431",
    Type = 1,
    Desc = "TipsType_10431_Desc|凭证不足"
  },
  ["10432"] = {
    ID = "10432",
    Type = 1,
    Desc = "TipsType_10432_Desc|凭证购买次数不足"
  },
  ["10433"] = {
    ID = "10433",
    Type = 1,
    Desc = "TipsType_10433_Desc|启灵等级已达上限"
  },
  ["10434"] = {
    ID = "10434",
    Type = 1,
    Desc = "TipsType_10434_Desc|「{s1}」不足"
  },
  ["10435"] = {
    ID = "10435",
    Type = 1,
    Desc = "TipsType_10435_Desc|没有此商品出售"
  },
  ["10436"] = {
    ID = "10436",
    Type = 1,
    Desc = "TipsType_10436_Desc|没有此类型商店"
  },
  ["10437"] = {
    ID = "10437",
    Type = 1,
    Desc = "TipsType_10437_Desc|出售的商品已没有库存"
  },
  ["10438"] = {
    ID = "10438",
    Type = 1,
    Desc = "TipsType_10438_Desc|没有商店数据"
  },
  ["10439"] = {
    ID = "10439",
    Type = 1,
    Desc = "TipsType_10439_Desc|没有刷新次数"
  },
  ["10440"] = {
    ID = "10440",
    Type = 1,
    Desc = "TipsType_10440_Desc|今日「灵啡肽」购买次数已达上限"
  },
  ["10441"] = {
    ID = "10441",
    Type = 1,
    Desc = "TipsType_10441_Desc|唤醒体残片不足"
  },
  ["10442"] = {
    ID = "10442",
    Type = 1,
    Desc = "TipsType_10442_Desc|启灵点已激活"
  },
  ["10443"] = {
    ID = "10443",
    Type = 1,
    Desc = "TipsType_10443_Desc|前置启灵点未激活"
  },
  ["10444"] = {
    ID = "10444",
    Type = 1,
    Desc = "TipsType_10444_Desc|成功购买「灵啡肽」× {s1}"
  },
  ["10445"] = {
    ID = "10445",
    Type = 1,
    Desc = "TipsType_10445_Desc|「灵啡肽」已达上限"
  },
  ["10446"] = {
    ID = "10446",
    Type = 1,
    Desc = "TipsType_10446_Desc|完成 调查1-12 解锁"
  },
  ["10447"] = {
    ID = "10447",
    Type = 1,
    Desc = "TipsType_10447_Desc|完成 序章 解锁"
  },
  ["10448"] = {
    ID = "10448",
    Type = 1,
    Desc = "TipsType_10448_Desc|完成 序章 解锁"
  },
  ["10449"] = {
    ID = "10449",
    Type = 1,
    Desc = "TipsType_10449_Desc|完成 调查2-4 解锁"
  },
  ["10450"] = {
    ID = "10450",
    Type = 1,
    Desc = "TipsType_10450_Desc|该技能等级已达到上限"
  },
  ["10451"] = {
    ID = "10451",
    Type = 1,
    Desc = "TipsType_10451_Desc|唤醒体升格等阶不足"
  },
  ["10452"] = {
    ID = "10452",
    Type = 1,
    Desc = "TipsType_10452_Desc|技能升级素材不足"
  },
  ["10453"] = {
    ID = "10453",
    Type = 1,
    Desc = "TipsType_10453_Desc|完成 调查3-15 解锁"
  },
  ["10454"] = {
    ID = "10454",
    Type = 1,
    Desc = "TipsType_10454_Desc|完成 调查3-7 解锁"
  },
  ["10455"] = {
    ID = "10455",
    Type = 1,
    Desc = "TipsType_10455_Desc|技能升级未到达设置的条件"
  },
  ["10456"] = {
    ID = "10456",
    Type = 1,
    Desc = "TipsType_10456_Desc|测试版本每个充值项仅允许进行1次充值操作"
  },
  ["10457"] = {
    ID = "10457",
    Type = 1,
    Desc = "TipsType_10457_Desc|此唤醒体本源降临冷却中，下回合再释放吧"
  },
  ["10458"] = {
    ID = "10458",
    Type = 1,
    Desc = "TipsType_10458_Desc|充值配置表中没有此配置"
  },
  ["10459"] = {
    ID = "10459",
    Type = 1,
    Desc = "TipsType_10459_Desc|已免费充值过无法再次充值"
  },
  ["10460"] = {
    ID = "10460",
    Type = 1,
    Desc = "TipsType_10460_Desc|共鸣已激活无需再次激活"
  },
  ["10461"] = {
    ID = "10461",
    Type = 1,
    Desc = "TipsType_10461_Desc|道具{s1}的价格已发生变更，请注意确认"
  },
  ["10462"] = {
    ID = "10462",
    Type = 1,
    Desc = "TipsType_10462_Desc|「蔷薇金券」不足"
  },
  ["10463"] = {
    ID = "10463",
    Type = 1,
    Desc = "TipsType_10463_Desc|「演习徽章」不足"
  },
  ["10464"] = {
    ID = "10464",
    Type = 1,
    Desc = "TipsType_10464_Desc|通关 调查3-4 解锁"
  },
  ["10465"] = {
    ID = "10465",
    Type = 1,
    Desc = "TipsType_10465_Desc|通关 调查2-16 解锁"
  },
  ["10466"] = {
    ID = "10466",
    Type = 1,
    Desc = "TipsType_10466_Desc|通关 调查3-16 解锁"
  },
  ["10467"] = {
    ID = "10467",
    Type = 1,
    Desc = "TipsType_10467_Desc|通关 调查4-12 解锁"
  },
  ["10468"] = {
    ID = "10468",
    Type = 1,
    Desc = "TipsType_10468_Desc|通关 调查5-12 解锁"
  },
  ["10469"] = {
    ID = "10469",
    Type = 1,
    Desc = "TipsType_10469_Desc|通关 调查6-12 解锁"
  },
  ["10470"] = {
    ID = "10470",
    Type = 1,
    Desc = "TipsType_10470_Desc|通关 调查1-7 解锁"
  },
  ["10471"] = {
    ID = "10471",
    Type = 1,
    Desc = "TipsType_10471_Desc|装备成功"
  },
  ["10472"] = {
    ID = "10472",
    Type = 1,
    Desc = "TipsType_10472_Desc|卸下成功"
  },
  ["10473"] = {
    ID = "10473",
    Type = 1,
    Desc = "TipsType_10473_Desc|已达到最大等级"
  },
  ["10474"] = {
    ID = "10474",
    Type = 1,
    Desc = "TipsType_10474_Desc|「蔷薇金券」不足"
  },
  ["10475"] = {
    ID = "10475",
    Type = 1,
    Desc = "TipsType_10475_Desc|请选择材料"
  },
  ["10476"] = {
    ID = "10476",
    Type = 1,
    Desc = "TipsType_10476_Desc|正被上锁保护中，请先解除锁定状态"
  },
  ["10477"] = {
    ID = "10477",
    Type = 1,
    Desc = "TipsType_10477_Desc|关卡未开放"
  },
  ["10478"] = {
    ID = "10478",
    Type = 1,
    Desc = "TipsType_10478_Desc|战斗外未开放"
  },
  ["10479"] = {
    ID = "10479",
    Type = 1,
    Desc = "TipsType_10479_Desc|弃牌堆为空"
  },
  ["10480"] = {
    ID = "10480",
    Type = 1,
    Desc = "TipsType_10480_Desc|RPG战斗调整中，当前直接结算胜利"
  },
  ["10482"] = {
    ID = "10482",
    Type = 1,
    Desc = "TipsType_10482_Desc|命轮已锁定"
  },
  ["10483"] = {
    ID = "10483",
    Type = 1,
    Desc = "TipsType_10483_Desc|命轮未找到"
  },
  ["10484"] = {
    ID = "10484",
    Type = 1,
    Desc = "TipsType_10484_Desc|命轮已达最大等阶"
  },
  ["10485"] = {
    ID = "10485",
    Type = 1,
    Desc = "TipsType_10485_Desc|命轮已被装备"
  },
  ["10486"] = {
    ID = "10486",
    Type = 1,
    Desc = "TipsType_10486_Desc|命轮不匹配"
  },
  ["10487"] = {
    ID = "10487",
    Type = 1,
    Desc = "TipsType_10487_Desc|命轮未锁定"
  },
  ["10488"] = {
    ID = "10488",
    Type = 1,
    Desc = "TipsType_10488_Desc|正处于「编队」「助战」「密契方案」中的密契，不可分解。"
  },
  ["10489"] = {
    ID = "10489",
    Type = 1,
    Desc = "TipsType_10489_Desc|正处于「编队」「助战」中的命轮，不可分解。"
  },
  ["10490"] = {
    ID = "10490",
    Type = 1,
    Desc = "TipsType_10490_Desc|狂气值不足，无法释放狂气爆发"
  },
  ["10491"] = {
    ID = "10491",
    Type = 1,
    Desc = "TipsType_10491_Desc|请先领取前一个礼包。"
  },
  ["10492"] = {
    ID = "10492",
    Type = 1,
    Desc = "TipsType_10492_Desc|当前密契已锁定，解锁以作为物资消耗"
  },
  ["10493"] = {
    ID = "10493",
    Type = 1,
    Desc = "TipsType_10493_Desc|当前命轮已锁定，解锁以作为物资消耗"
  },
  ["10494"] = {
    ID = "10494",
    Type = 1,
    Desc = "TipsType_10494_Desc|通关 调查1-7 解锁"
  },
  ["10495"] = {
    ID = "10495",
    Type = 1,
    Desc = "TipsType_10495_Desc|通关 调查1-13 解锁"
  },
  ["10496"] = {
    ID = "10496",
    Type = 1,
    Desc = "TipsType_10496_Desc|当前密契等级已达上限"
  },
  ["10497"] = {
    ID = "10497",
    Type = 1,
    Desc = "TipsType_10497_Desc|商店已重置"
  },
  ["10498"] = {
    ID = "10498",
    Type = 1,
    Desc = "TipsType_10498_Desc|更换成功"
  },
  ["10499"] = {
    ID = "10499",
    Type = 1,
    Desc = "TipsType_10499_Desc|收藏成功"
  },
  ["10500"] = {
    ID = "10500",
    Type = 1,
    Desc = "TipsType_10500_Desc|叠位成功"
  },
  ["10501"] = {
    ID = "10501",
    Type = 1,
    Desc = "TipsType_10501_Desc|当前挑战尚未解锁"
  },
  ["10502"] = {
    ID = "10502",
    Type = 1,
    Desc = "TipsType_10502_Desc|当前唤醒体已在{s1}的其他关卡中进行了挑战，无法再次出战"
  },
  ["10503"] = {
    ID = "10503",
    Type = 1,
    Desc = "TipsType_10503_Desc|上阵唤醒体不足4个，无法挑战"
  },
  ["10504"] = {
    ID = "10504",
    Type = 1,
    Desc = "TipsType_10504_Desc|通关 调查3-7 解锁"
  },
  ["10505"] = {
    ID = "10505",
    Type = 1,
    Desc = "TipsType_10505_Desc|第1层达到三星解锁"
  },
  ["10506"] = {
    ID = "10506",
    Type = 1,
    Desc = "TipsType_10506_Desc|第2层达到三星解锁"
  },
  ["10507"] = {
    ID = "10507",
    Type = 1,
    Desc = "TipsType_10507_Desc|第3层达到三星解锁"
  },
  ["10508"] = {
    ID = "10508",
    Type = 1,
    Desc = "TipsType_10508_Desc|第4层达到三星解锁"
  },
  ["10509"] = {
    ID = "10509",
    Type = 1,
    Desc = "TipsType_10509_Desc|第5层达到三星解锁"
  },
  ["10510"] = {
    ID = "10510",
    Type = 1,
    Desc = "TipsType_10510_Desc|第6层达到三星解锁"
  },
  ["10511"] = {
    ID = "10511",
    Type = 1,
    Desc = "TipsType_10511_Desc|第7层达到三星解锁"
  },
  ["10512"] = {
    ID = "10512",
    Type = 1,
    Desc = "TipsType_10512_Desc|第8层达到三星解锁"
  },
  ["10513"] = {
    ID = "10513",
    Type = 1,
    Desc = "TipsType_10513_Desc|请选择希望强化的密契"
  },
  ["10514"] = {
    ID = "10514",
    Type = 1,
    Desc = "TipsType_10514_Desc|已领取"
  },
  ["10515"] = {
    ID = "10515",
    Type = 1,
    Desc = "TipsType_10515_Desc|通关 调查2-14 解锁"
  },
  ["10516"] = {
    ID = "10516",
    Type = 1,
    Desc = "TipsType_10516_Desc|通关 调查4-7 解锁"
  },
  ["10517"] = {
    ID = "10517",
    Type = 1,
    Desc = "TipsType_10517_Desc|通关 调查4-7 解锁"
  },
  ["10518"] = {
    ID = "10518",
    Type = 1,
    Desc = "TipsType_10518_Desc|编队已保存"
  },
  ["10519"] = {
    ID = "10519",
    Type = 1,
    Desc = "TipsType_10519_Desc|请触摸发光区域进行移动"
  },
  ["10520"] = {
    ID = "10520",
    Type = 1,
    Desc = "TipsType_10520_Desc|队伍名中不可包含中文、英文、数字以外的字符"
  },
  ["10521"] = {
    ID = "10521",
    Type = 1,
    Desc = "TipsType_10521_Desc|队伍名长度不可大于8个字符"
  },
  ["10522"] = {
    ID = "10522",
    Type = 1,
    Desc = "TipsType_10522_Desc|队伍中唤醒体数量不足{s1}个，无法进行调查"
  },
  ["10523"] = {
    ID = "10523",
    Type = 1,
    Desc = "TipsType_10523_Desc|唤醒体已参与过该层无光之境其它密境的战斗"
  },
  ["10524"] = {
    ID = "10524",
    Type = 1,
    Desc = "TipsType_10524_Desc|队伍中已有两个界域的唤醒体，无法再选中其他界域唤醒体"
  },
  ["10525"] = {
    ID = "10525",
    Type = 1,
    Desc = "TipsType_10525_Desc|请选中一个唤醒体"
  },
  ["10526"] = {
    ID = "10526",
    Type = 1,
    Desc = "TipsType_10526_Desc|无法再选中更多的唤醒体"
  },
  ["10527"] = {
    ID = "10527",
    Type = 1,
    Desc = "TipsType_10527_Desc|养成注意：幻梦深潜中，唤醒体等级和技能等级都被调为1级"
  },
  ["10528"] = {
    ID = "10528",
    Type = 1,
    Desc = "TipsType_10528_Desc|队伍名不可为空"
  },
  ["10529"] = {
    ID = "10529",
    Type = 1,
    Desc = "TipsType_10529_Desc|队伍中有唤醒体已筋疲力尽，无法再战斗"
  },
  ["10530"] = {
    ID = "10530",
    Type = 1,
    Desc = "TipsType_10530_Desc|邮箱内的附件已全部领取完成"
  },
  ["10531"] = {
    ID = "10531",
    Type = 1,
    Desc = "TipsType_10531_Desc|通关序章后解锁"
  },
  ["10532"] = {
    ID = "10532",
    Type = 1,
    Desc = "TipsType_10532_Desc|背包已满，未领取完成，需清理背包后继续领取"
  },
  ["10533"] = {
    ID = "10533",
    Type = 1,
    Desc = "TipsType_10533_Desc|背包已满，奖励将发送至邮箱"
  },
  ["10534"] = {
    ID = "10534",
    Type = 1,
    Desc = "TipsType_10534_Desc|背包已满，物资未全部领取完成，需清理背包后继续领取"
  },
  ["10535"] = {
    ID = "10535",
    Type = 1,
    Desc = "TipsType_10535_Desc|没有信函附件可领取"
  },
  ["10536"] = {
    ID = "10536",
    Type = 1,
    Desc = "TipsType_10536_Desc|请先兑换造物"
  },
  ["10537"] = {
    ID = "10537",
    Type = 1,
    Desc = "TipsType_10537_Desc|完成 调查2-4 解锁"
  },
  ["10538"] = {
    ID = "10538",
    Type = 1,
    Desc = "TipsType_10538_Desc|完成 调查1-12 解锁"
  },
  ["10539"] = {
    ID = "10539",
    Type = 1,
    Desc = "TipsType_10539_Desc|完成 调查1-12 解锁"
  },
  ["10540"] = {
    ID = "10540",
    Type = 1,
    Desc = "TipsType_10540_Desc|完成 调查1-12 解锁"
  },
  ["10541"] = {
    ID = "10541",
    Type = 1,
    Desc = "TipsType_10541_Desc|第9层达到三星解锁"
  },
  ["10542"] = {
    ID = "10542",
    Type = 1,
    Desc = "TipsType_10542_Desc|第10层达到三星解锁"
  },
  ["10543"] = {
    ID = "10543",
    Type = 1,
    Desc = "TipsType_10543_Desc|第11层达到三星解锁"
  },
  ["10544"] = {
    ID = "10544",
    Type = 1,
    Desc = "TipsType_10544_Desc|第12层达到三星解锁"
  },
  ["10545"] = {
    ID = "10545",
    Type = 1,
    Desc = "TipsType_10545_Desc|第13层达到三星解锁"
  },
  ["10546"] = {
    ID = "10546",
    Type = 1,
    Desc = "TipsType_10546_Desc|第14层达到三星解锁"
  },
  ["10547"] = {
    ID = "10547",
    Type = 1,
    Desc = "TipsType_10547_Desc|此功能即将移除"
  },
  ["10548"] = {
    ID = "10548",
    Type = 1,
    Desc = "TipsType_10548_Desc|完成 调查1-7 解锁"
  },
  ["10549"] = {
    ID = "10549",
    Type = 1,
    Desc = "TipsType_10549_Desc|造物获取已达上限，无法继续获取"
  },
  ["10550"] = {
    ID = "10550",
    Type = 1,
    Desc = "TipsType_10550_Desc|{s1}完成链接，现在可以指挥她作战了！"
  },
  ["10551"] = {
    ID = "10551",
    Type = 1,
    Desc = "TipsType_10551_Desc|{s1}的等级和技能等级已超出灵知增幅器提供的等级，无法使用"
  },
  ["10552"] = {
    ID = "10552",
    Type = 1,
    Desc = "TipsType_10552_Desc|唤醒体等级和技能等级已超出灵知增幅器提供的等级，无法使用"
  },
  ["10553"] = {
    ID = "10553",
    Type = 1,
    Desc = "TipsType_10553_Desc|敬请期待"
  },
  ["10554"] = {
    ID = "10554",
    Type = 1,
    Desc = "TipsType_10554_Desc|通过上一关卡后解锁"
  },
  ["10555"] = {
    ID = "10555",
    Type = 1,
    Desc = "TipsType_10555_Desc|脆弱通路上不可回头"
  },
  ["10556"] = {
    ID = "10556",
    Type = 1,
    Desc = "TipsType_10556_Desc|暂未开放，敬请期待"
  },
  ["10557"] = {
    ID = "10557",
    Type = 1,
    Desc = "TipsType_10557_Desc|当前已拥有该造物，无法重复获取"
  },
  ["10558"] = {
    ID = "10558",
    Type = 2,
    Title = "TipsType_10558_Title|启用粘贴功能",
    Desc = "TipsType_10558_Desc|即将获得系统剪切板中的内容并进行<Positive:【粘贴】>，\n是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10558_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10558_RightBtnDesc|确认"
  },
  ["10559"] = {
    ID = "10559",
    Type = 1,
    Desc = "TipsType_10559_Desc|升格素材不足"
  },
  ["10560"] = {
    ID = "10560",
    Type = 1,
    Desc = "TipsType_10560_Desc|当前已是初始状态"
  },
  ["10561"] = {
    ID = "10561",
    Type = 1,
    Desc = "TipsType_10561_Desc|「蔷薇金券」不足"
  },
  ["10562"] = {
    ID = "10562",
    Type = 1,
    Desc = "TipsType_10562_Desc|未升格"
  },
  ["10563"] = {
    ID = "10563",
    Type = 1,
    Desc = "TipsType_10563_Desc|共鸣重置成功"
  },
  ["10564"] = {
    ID = "10564",
    Type = 1,
    Desc = "TipsType_10564_Desc|调查等级达到 {s1}级 解锁"
  },
  ["10565"] = {
    ID = "10565",
    Type = 1,
    Desc = "TipsType_10565_Desc|被封印的狂气无法释放"
  },
  ["10566"] = {
    ID = "10566",
    Type = 1,
    Desc = "TipsType_10566_Desc|银芯通讯异常，请稍后重试({s1})"
  },
  ["1056601"] = {
    ID = "1056601",
    Type = 1,
    Desc = "TipsType_1056601_Desc|银芯通讯异常，请检查网络并重试({s1})"
  },
  ["10567"] = {
    ID = "10567",
    Type = 1,
    Desc = "TipsType_10567_Desc|获取服务器信息失败！{s1}"
  },
  ["10568"] = {
    ID = "10568",
    Type = 1,
    Desc = "TipsType_10568_Desc|请先选择服务器"
  },
  ["10569"] = {
    ID = "10569",
    Type = 1,
    Desc = "TipsType_10569_Desc|尚未解锁"
  },
  ["10570"] = {
    ID = "10570",
    Type = 1,
    Desc = "TipsType_10570_Desc|请输入账号"
  },
  ["10571"] = {
    ID = "10571",
    Type = 1,
    Desc = "TipsType_10571_Desc|共鸣激活材料不足"
  },
  ["10572"] = {
    ID = "10572",
    Type = 1,
    Desc = "TipsType_10572_Desc|前置共鸣点未升级"
  },
  ["10573"] = {
    ID = "10573",
    Type = 1,
    Desc = "TipsType_10573_Desc|已满级"
  },
  ["10574"] = {
    ID = "10574",
    Type = 1,
    Desc = "TipsType_10574_Desc|升级成功"
  },
  ["10575"] = {
    ID = "10575",
    Type = 1,
    Desc = "TipsType_10575_Desc|该唤醒体不可更换"
  },
  ["10576"] = {
    ID = "10576",
    Type = 1,
    Desc = "TipsType_10576_Desc|该位置不可上阵"
  },
  ["10577"] = {
    ID = "10577",
    Type = 1,
    Desc = "TipsType_10577_Desc|唤醒体数量不足，不可挑战"
  },
  ["10578"] = {
    ID = "10578",
    Type = 1,
    Desc = "TipsType_10578_Desc|暂未解锁下一关卡"
  },
  ["10579"] = {
    ID = "10579",
    Type = 1,
    Desc = "TipsType_10579_Desc|已经是最后一个关卡了"
  },
  ["10580"] = {
    ID = "10580",
    Type = 1,
    Desc = "TipsType_10580_Desc|已达当前经验上限，无法添加"
  },
  ["10581"] = {
    ID = "10581",
    Type = 1,
    Desc = "TipsType_10581_Desc|命轮槽已满，无法添加"
  },
  ["10582"] = {
    ID = "10582",
    Type = 1,
    Desc = "TipsType_10582_Desc|当前无可以快捷置入的素材"
  },
  ["10583"] = {
    ID = "10583",
    Type = 1,
    Desc = "TipsType_10583_Desc|请放置素材到命轮槽"
  },
  ["10584"] = {
    ID = "10584",
    Type = 1,
    Desc = "TipsType_10584_Desc|没有可装备的命轮"
  },
  ["10585"] = {
    ID = "10585",
    Type = 1,
    Desc = "TipsType_10585_Desc|完成 调查2-8 解锁"
  },
  ["10586"] = {
    ID = "10586",
    Type = 1,
    Desc = "TipsType_10586_Desc|完成 调查2-14 解锁"
  },
  ["10587"] = {
    ID = "10587",
    Type = 1,
    Desc = "TipsType_10587_Desc|完成 调查3-16 解锁"
  },
  ["10588"] = {
    ID = "10588",
    Type = 1,
    Desc = "TipsType_10588_Desc|完成 调查4-12 解锁"
  },
  ["10589"] = {
    ID = "10589",
    Type = 1,
    Desc = "TipsType_10589_Desc|完成 调查5-12 解锁"
  },
  ["10590"] = {
    ID = "10590",
    Type = 1,
    Desc = "TipsType_10590_Desc|完成 调查6-12 解锁"
  },
  ["10591"] = {
    ID = "10591",
    Type = 1,
    Desc = "TipsType_10591_Desc|完成 调查2-12 解锁"
  },
  ["10592"] = {
    ID = "10592",
    Type = 1,
    Desc = "TipsType_10592_Desc|该用户已被禁止登录，如有疑问请联系客服。"
  },
  ["10593"] = {
    ID = "10593",
    Type = 1,
    Desc = "TipsType_10593_Desc|登录会话已过期，请重新登录。"
  },
  ["10594"] = {
    ID = "10594",
    Type = 1,
    Desc = "TipsType_10594_Desc|当前「灵啡肽」不足"
  },
  ["10595"] = {
    ID = "10595",
    Type = 1,
    Title = "TipsType_10595_Title|激活天赋",
    Desc = "TipsType_10595_Desc|是否激活“{s1}”？"
  },
  ["10596"] = {
    ID = "10596",
    Type = 1,
    Desc = "TipsType_10596_Desc|还未获得该唤醒体"
  },
  ["10597"] = {
    ID = "10597",
    Type = 1,
    Desc = "TipsType_10597_Desc|没有可强化的命轮"
  },
  ["10598"] = {
    ID = "10598",
    Type = 1,
    Desc = "TipsType_10598_Desc|该账号由于违反相关条例已被禁止登录直至{s1}，如有疑问请联系客服。"
  },
  ["10599"] = {
    ID = "10599",
    Type = 1,
    Desc = "TipsType_10599_Desc|通关 调查2-15 解锁"
  },
  ["10600"] = {
    ID = "10600",
    Type = 1,
    Desc = "TipsType_10600_Desc|已达等级上限，无法继续添加"
  },
  ["10601"] = {
    ID = "10601",
    Type = 1,
    Desc = "TipsType_10601_Desc|完成调查1-7后开启守密人成长记录"
  },
  ["10602"] = {
    ID = "10602",
    Type = 1,
    Desc = "TipsType_10602_Desc|完成调查1-7后开启界域精通任务"
  },
  ["10603"] = {
    ID = "10603",
    Type = 1,
    Desc = "TipsType_10603_Desc|尚未选择素材"
  },
  ["10604"] = {
    ID = "10604",
    Type = 1,
    Desc = "TipsType_10604_Desc|长时间未操作，自动退出副本"
  },
  ["10605"] = {
    ID = "10605",
    Type = 1,
    Desc = "TipsType_10605_Desc|问卷填写完毕，感谢您的支持！"
  },
  ["10606"] = {
    ID = "10606",
    Type = 1,
    Desc = "TipsType_10606_Desc|激活所需素材不足"
  },
  ["10607"] = {
    ID = "10607",
    Type = 2,
    Title = "TipsType_10607_Title|挑战提示",
    Desc = "TipsType_10607_Desc|本周内获取奖励次数已耗尽，挑战后无法再获得奖励。是否仍要挑战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10607_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10607_RightBtnDesc|确认"
  },
  ["10608"] = {
    ID = "10608",
    Type = 1,
    Desc = "TipsType_10608_Desc|校园维护中，请静候修整完成"
  },
  ["10609"] = {
    ID = "10609",
    Type = 1,
    Desc = "TipsType_10609_Desc|成功邀请{s1}进入你的宿舍"
  },
  ["10610"] = {
    ID = "10610",
    Type = 1,
    Desc = "TipsType_10610_Desc|{s1}已经在你的宿舍中了"
  },
  ["10611"] = {
    ID = "10611",
    Type = 2,
    Title = "TipsType_10611_Title|下载确认",
    Desc = "TipsType_10611_Desc|当前为非wifi网络，是否使用流量继续下载？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10611_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10611_RightBtnDesc|确认"
  },
  ["10612"] = {
    ID = "10612",
    Type = 1,
    Desc = "TipsType_10612_Desc|所有卡牌都已刻印"
  },
  ["10613"] = {
    ID = "10613",
    Type = 1,
    Desc = "TipsType_10613_Desc|网络异常，请等待"
  },
  ["10614"] = {
    ID = "10614",
    Type = 1,
    Desc = "TipsType_10614_Desc|当前挑战未解锁"
  },
  ["10615"] = {
    ID = "10615",
    Type = 1,
    Desc = "TipsType_10615_Desc|冷却中，下回合才能释放。"
  },
  ["10616"] = {
    ID = "10616",
    Type = 1,
    Desc = "TipsType_10616_Desc|处于选择中，选择完才能释放。"
  },
  ["10617"] = {
    ID = "10617",
    Type = 1,
    Desc = "TipsType_10617_Desc|当前狂气爆发不满足释放条件，无法释放。"
  },
  ["10618"] = {
    ID = "10618",
    Type = 2,
    Title = "TipsType_10618_Title|调查确认",
    Desc = "TipsType_10618_Desc|当前队伍平均等级{s1}低于推荐等级{s2}，调查可能会遇到较大的挑战，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10618_LeftBtnDesc|前往提升",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10618_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["10740"] = {
    ID = "10740",
    Type = 2,
    Title = "TipsType_10740_Title|调查确认",
    Desc = "TipsType_10740_Desc|当前调查等级{s1}低于推荐等级{s2}，调查可能会遇到较大的挑战，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10740_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10740_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["10741"] = {
    ID = "10741",
    Type = 2,
    Title = "TipsType_10741_Title|调查确认",
    Desc = "TipsType_10741_Desc|当前队伍平均等级{s1}和守密人调查等级{s2}均低于推荐等级，调查会遇到非常大的挑战，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10741_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10741_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["10742"] = {
    ID = "10742",
    Type = 2,
    Title = "TipsType_10742_Title|调查确认",
    Desc = "TipsType_10742_Desc|队伍中相同的命轮效果无法重复生效，当前<Blue:{s1}>存在命轮未生效的情况，建议守密人重新调整命轮装备后再进行调查。\n是否仍要进行调查？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10742_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10742_RightBtnDesc|确认"
  },
  ["10619"] = {
    ID = "10619",
    Type = 1,
    Desc = "TipsType_10619_Desc|调查等级 {s1}级 后方可使用"
  },
  ["10620"] = {
    ID = "10620",
    Type = 1,
    Desc = "TipsType_10620_Desc|网络状况不佳，请检查Steam连接或重启Steam后重试"
  },
  ["10799"] = {
    ID = "10799",
    Type = 2,
    Title = "TipsType_10799_Title|调查确认",
    Desc = "TipsType_10799_Desc|当前<Blue:{s1}>的密契6件套效果由于<Blue:队伍唯一>的限制未生效，建议守密人重新调整密契后再进行调查。\n是否仍要进行调查？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10799_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10799_RightBtnDesc|确认"
  },
  ["10621"] = {
    ID = "10621",
    Type = 2,
    Title = "TipsType_10621_Title|镌刻确认",
    Desc = "TipsType_10621_Desc|是否确认使用<WeaponEffect_Num:{s1}>作为你的名字？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10621_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10621_RightBtnDesc|确认"
  },
  ["10622"] = {
    ID = "10622",
    Type = 1,
    Desc = "TipsType_10622_Desc|镌刻冷却中，{s1}时{s2}分后可再次镌刻"
  },
  ["10623"] = {
    ID = "10623",
    Type = 1,
    Desc = "TipsType_10623_Desc|镌刻成功"
  },
  ["10624"] = {
    ID = "10624",
    Type = 1,
    Desc = "TipsType_10624_Desc|名字中只能包含中文、英文和数字"
  },
  ["10625"] = {
    ID = "10625",
    Type = 1,
    Desc = "TipsType_10625_Desc|此卡即将丢弃"
  },
  ["10626"] = {
    ID = "10626",
    Type = 2,
    Title = "TipsType_10626_Title|提示",
    Desc = "TipsType_10626_Desc|请在Steam中开启以下选项：\n【Steam设置-游戏中-在游戏中启用Steam界面】\n并重启游戏生效。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10626_RightBtnDesc|确认"
  },
  ["10628"] = {
    ID = "10628",
    Type = 1,
    Desc = "TipsType_10628_Desc|新的名字不可与当前重复"
  },
  ["10629"] = {
    ID = "10629",
    Type = 1,
    Desc = "TipsType_10629_Desc|请输入{s1}~{s2}个字符"
  },
  ["10630"] = {
    ID = "10630",
    Type = 1,
    Desc = "TipsType_10630_Desc|{s1}达成三星后可进行重现"
  },
  ["10631"] = {
    ID = "10631",
    Type = 2,
    Title = "TipsType_10631_Title|温馨提示",
    Desc = "TipsType_10631_Desc|由于您的账户违反相关条例已被强制下线。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10631_RightBtnDesc|确认"
  },
  ["10632"] = {
    ID = "10632",
    Type = 1,
    Desc = "TipsType_10632_Desc|完成挑战后，今日可进行重现"
  },
  ["10633"] = {
    ID = "10633",
    Type = 2,
    Title = "TipsType_10633_Title|分解确认",
    Desc = "TipsType_10633_Desc|本次分解将消耗以下物资，<Blue:分解后将无法恢复>，是否确认分解？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10633_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10633_RightBtnDesc|确认"
  },
  ["10634"] = {
    ID = "10634",
    Type = 1,
    Desc = "TipsType_10634_Desc|当前月卡剩余天数已超过{s1}天，无法累计。"
  },
  ["10635"] = {
    ID = "10635",
    Type = 2,
    Title = "TipsType_10635_Title|源液不足",
    Desc = "TipsType_10635_Desc|所需「源液」不足，是否前往源液提取？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10635_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10635_RightBtnDesc|确认"
  },
  ["10636"] = {
    ID = "10636",
    Type = 1,
    Desc = "TipsType_10636_Desc|当前无闲置命轮"
  },
  ["10637"] = {
    ID = "10637",
    Type = 1,
    Desc = "TipsType_10637_Desc|当前无闲置密契"
  },
  ["10638"] = {
    ID = "10638",
    Type = 1,
    Desc = "TipsType_10638_Desc|当前无可装备密契位置，请卸下密契后尝试"
  },
  ["10640"] = {
    ID = "10640",
    Type = 2,
    Title = "TipsType_10640_Title|提示",
    Desc = "TipsType_10640_Desc|确认卸下该唤醒体的所有密契吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10640_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10640_RightBtnDesc|确认"
  },
  ["10641"] = {
    ID = "10641",
    Type = 2,
    Title = "TipsType_10641_Title|切换语言确认",
    Desc = "TipsType_10641_Desc|切换语言后需重启客户端才能生效，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10641_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10641_RightBtnDesc|确认"
  },
  ["10642"] = {
    ID = "10642",
    Type = 1,
    Desc = "TipsType_10642_Desc|玩家等级不足"
  },
  ["10643"] = {
    ID = "10643",
    Type = 1,
    Desc = "TipsType_10643_Desc|步入遍布融蚀的区域，生命值减少{s1}点"
  },
  ["10644"] = {
    ID = "10644",
    Type = 1,
    Desc = "TipsType_10644_Desc|已选择该钥令"
  },
  ["10645"] = {
    ID = "10645",
    Type = 1,
    Desc = "TipsType_10645_Desc|未获得该钥令"
  },
  ["10646"] = {
    ID = "10646",
    Type = 1,
    Desc = "TipsType_10646_Desc|「{s1}」不足"
  },
  ["10647"] = {
    ID = "10647",
    Type = 1,
    Desc = "TipsType_10647_Desc|调查事件尚未开启，{s1}"
  },
  ["10648"] = {
    ID = "10648",
    Type = 1,
    Desc = "TipsType_10648_Desc|轮转间隙已更新"
  },
  ["10649"] = {
    ID = "10649",
    Type = 1,
    Desc = "TipsType_10649_Desc|当前可派遣数量已达上限"
  },
  ["10650"] = {
    ID = "10650",
    Type = 1,
    Desc = "TipsType_10650_Desc|当前没有已解锁SSR角色"
  },
  ["10651"] = {
    ID = "10651",
    Type = 1,
    Desc = "TipsType_10651_Desc|收集数量达到一定数量才可使用"
  },
  ["10652"] = {
    ID = "10652",
    Type = 1,
    Desc = "TipsType_10652_Desc|当前没有未获得的头像和对战表情"
  },
  ["20090"] = {
    ID = "20090",
    Type = 2,
    Title = "TipsType_20090_Title|清理提示",
    Desc = "TipsType_20090_Desc|命轮数量已达上限，需要清理命轮后才能进行唤醒，是否前往？\n\n<color=#ADC0CB>*可在「设置」中设定SR/R级命轮自动分解</color>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20090_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20090_RightBtnDesc|前往清理"
  },
  ["20091"] = {
    ID = "20091",
    Type = 2,
    Title = "TipsType_20091_Title|清理提示",
    Desc = "TipsType_20091_Desc|密契数量已达上限，需要清理密契后才能进行调查，是否前往？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20091_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20091_RightBtnDesc|前往清理"
  },
  ["20092"] = {
    ID = "20092",
    Type = 2,
    Title = "TipsType_20092_Title|卸下确认",
    Desc = "TipsType_20092_Desc|是否确认卸下当前唤醒体装备的所有命轮？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20092_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20092_RightBtnDesc|确认"
  },
  ["10701"] = {
    ID = "10701",
    Type = 1,
    Desc = "TipsType_10701_Desc|当前已装备命轮，请卸下后重试。"
  },
  ["10702"] = {
    ID = "10702",
    Type = 1,
    Desc = "TipsType_10702_Desc|装备的SSR命轮额外叠位达到 12 时，方可同时装备两个SSR命轮"
  },
  ["10703"] = {
    ID = "10703",
    Type = 1,
    Desc = "TipsType_10703_Desc|唤醒体已装备相同命轮，无法重复装备。"
  },
  ["10704"] = {
    ID = "10704",
    Type = 1,
    Desc = "TipsType_10704_Desc|密契等级已达上限"
  },
  ["10705"] = {
    ID = "10705",
    Type = 1,
    Desc = "TipsType_10705_Desc|消耗材料数量已达上限"
  },
  ["20093"] = {
    ID = "20093",
    Type = 2,
    Title = "TipsType_20093_Title|升级确认",
    Desc = "TipsType_20093_Desc|消耗密契已进行升级，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20093_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20093_RightBtnDesc|确认"
  },
  ["10706"] = {
    ID = "10706",
    Type = 1,
    Desc = "TipsType_10706_Desc|最多锁定两个副属性"
  },
  ["20094"] = {
    ID = "20094",
    Type = 2,
    Title = "TipsType_20094_Title|替换确认",
    Desc = "TipsType_20094_Desc|原副属性中存在较好的属性，替换后将不会保存，是否确认替换？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20094_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20094_RightBtnDesc|确认"
  },
  ["20095"] = {
    ID = "20095",
    Type = 2,
    Title = "TipsType_20095_Title|转录确认",
    Desc = "TipsType_20095_Desc|当前转录出的副属性中存在较好的属性，继续转录将不会保存，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20095_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20095_RightBtnDesc|确认"
  },
  ["10707"] = {
    ID = "10707",
    Type = 1,
    Desc = "TipsType_10707_Desc|转录材料不足"
  },
  ["10719"] = {
    ID = "10719",
    Type = 1,
    Desc = "TipsType_10719_Desc|「千面印章」不足，可在「置换设置」中选择材料置换"
  },
  ["10708"] = {
    ID = "10708",
    Type = 1,
    Desc = "TipsType_10708_Desc|唤醒体升格{s1}阶后开启"
  },
  ["20096"] = {
    ID = "20096",
    Type = 2,
    Title = "TipsType_20096_Title|升级确认",
    Desc = "TipsType_20096_Desc|密契升级后将会溢出等级上限，溢出后将返还转录材料，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20096_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20096_RightBtnDesc|确认"
  },
  ["10709"] = {
    ID = "10709",
    Type = 1,
    Desc = "TipsType_10709_Desc|「{s1}」不足"
  },
  ["10710"] = {
    ID = "10710",
    Type = 1,
    Desc = "TipsType_10710_Desc|已售罄"
  },
  ["10711"] = {
    ID = "10711",
    Type = 1,
    Desc = "TipsType_10711_Desc|此商品未解锁"
  },
  ["10712"] = {
    ID = "10712",
    Type = 1,
    Desc = "TipsType_10712_Desc|消耗材料已满"
  },
  ["10713"] = {
    ID = "10713",
    Type = 1,
    Desc = "TipsType_10713_Desc|命轮叠位已达上限"
  },
  ["10714"] = {
    ID = "10714",
    Type = 1,
    Desc = "TipsType_10714_Desc|不满足事件条件，无法选择"
  },
  ["10715"] = {
    ID = "10715",
    Type = 1,
    Desc = "TipsType_10715_Desc|请安装对应app后再进行分享"
  },
  ["10716"] = {
    ID = "10716",
    Type = 1,
    Desc = "TipsType_10716_Desc|无法再选中更多的命轮"
  },
  ["10717"] = {
    ID = "10717",
    Type = 1,
    Desc = "TipsType_10717_Desc|无法再选中更多的钥令"
  },
  ["10718"] = {
    ID = "10718",
    Type = 1,
    Desc = "TipsType_10718_Desc|激活成功"
  },
  ["10720"] = {
    ID = "10720",
    Type = 1,
    Desc = "TipsType_10720_Desc|已切换为1倍速"
  },
  ["10721"] = {
    ID = "10721",
    Type = 1,
    Desc = "TipsType_10721_Desc|已切换为2倍速"
  },
  ["10722"] = {
    ID = "10722",
    Type = 1,
    Desc = "TipsType_10722_Desc|校园入口拥堵中，请稍后重试"
  },
  ["10723"] = {
    ID = "10723",
    Type = 1,
    Desc = "TipsType_10723_Desc|保存成功"
  },
  ["10724"] = {
    ID = "10724",
    Type = 1,
    Desc = "TipsType_10724_Desc|保存失败，相册权限未开启或内存不足"
  },
  ["10725"] = {
    ID = "10725",
    Type = 1,
    Desc = "TipsType_10725_Desc|消耗素材不足"
  },
  ["20099"] = {
    ID = "20099",
    Type = 2,
    Title = "TipsType_20099_Title|提示",
    Desc = "TipsType_20099_Desc|是否退出游戏？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20099_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20099_RightBtnDesc|确认"
  },
  ["20100"] = {
    ID = "20100",
    Type = 2,
    Title = "TipsType_20100_Title|更新提示",
    Desc = "TipsType_20100_Desc|检测到新的游戏版本，请重新启动游戏进行资源更新",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20100_RightBtnDesc|确认"
  },
  ["20101"] = {
    ID = "20101",
    Type = 2,
    Title = "TipsType_20101_Title|剧情确认",
    Desc = "TipsType_20101_Desc|该调查已完成，重新调查是否选择跳过剧情？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20101_LeftBtnDesc|跳过剧情",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20101_RightBtnDesc|保留剧情"
  },
  ["10726"] = {
    ID = "10726",
    Type = 1,
    Desc = "TipsType_10726_Desc|请选择卡牌"
  },
  ["20102"] = {
    ID = "20102",
    Type = 2,
    Title = "TipsType_20102_Title|取消关注",
    Desc = "TipsType_20102_Desc|确定不再关注{s1}？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20102_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20102_RightBtnDesc|确认"
  },
  ["10761"] = {
    ID = "10761",
    Type = 1,
    Desc = "TipsType_10761_Desc|本源形态唤醒体无法与其普通形态同时出战"
  },
  ["10762"] = {
    ID = "10762",
    Type = 1,
    Desc = "TipsType_10762_Desc|本源形态唤醒体无法与其普通形态同时展示"
  },
  ["10745"] = {
    ID = "10745",
    Type = 1,
    Desc = "TipsType_10745_Desc|生日日期有误，无法设置"
  },
  ["10746"] = {
    ID = "10746",
    Type = 1,
    Desc = "TipsType_10746_Desc|已复制到剪切板"
  },
  ["10747"] = {
    ID = "10747",
    Type = 1,
    Desc = "TipsType_10747_Desc|点赞成功"
  },
  ["10748"] = {
    ID = "10748",
    Type = 1,
    Desc = "TipsType_10748_Desc|{s1}已是助战唤醒体"
  },
  ["10749"] = {
    ID = "10749",
    Type = 1,
    Desc = "TipsType_10749_Desc|助战唤醒体不可为空"
  },
  ["10750"] = {
    ID = "10750",
    Type = 1,
    Desc = "TipsType_10750_Desc|今日已点赞过该守密人了"
  },
  ["10751"] = {
    ID = "10751",
    Type = 1,
    Desc = "TipsType_10751_Desc|最多可以展示4名唤醒体"
  },
  ["10752"] = {
    ID = "10752",
    Type = 1,
    Desc = "TipsType_10752_Desc|界域不符合要求，无法上场"
  },
  ["10753"] = {
    ID = "10753",
    Type = 1,
    Desc = "TipsType_10753_Desc|{s1}已经上阵，不可重复选择"
  },
  ["20103"] = {
    ID = "20103",
    Type = 2,
    Title = "TipsType_20103_Title|活动福利",
    Desc = "TipsType_20103_Desc|活动期间<WeaponEffect_Num:限时免费>解锁，是否解锁？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20103_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20103_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["10727"] = {
    ID = "10727",
    Type = 1,
    Desc = "TipsType_10727_Desc|该唤醒体已被禁用"
  },
  ["10728"] = {
    ID = "10728",
    Type = 1,
    Desc = "TipsType_10728_Desc|本源形态不可派遣，请重新选择"
  },
  ["10736"] = {
    ID = "10736",
    Type = 1,
    Desc = "TipsType_10736_Desc|「灵啡肽」已充足，无需补充"
  },
  ["10737"] = {
    ID = "10737",
    Type = 1,
    Desc = "TipsType_10737_Desc|检测到新的游戏版本，请重新启动游戏更新以保证正常体验。"
  },
  ["10738"] = {
    ID = "10738",
    Type = 1,
    Desc = "TipsType_10738_Desc|当前没有待阅读的教学"
  },
  ["10739"] = {
    ID = "10739",
    Type = 1,
    Desc = "TipsType_10739_Desc|{s1}已在{s2}中进行过挑战，无法重复上场"
  },
  ["10743"] = {
    ID = "10743",
    Type = 1,
    Desc = "TipsType_10743_Desc|融灾禁区无剩余助战次数"
  },
  ["10744"] = {
    ID = "10744",
    Type = 1,
    Desc = "TipsType_10744_Desc|关注人数已达上限"
  },
  ["10754"] = {
    ID = "10754",
    Type = 1,
    Desc = "TipsType_10754_Desc|{s1}已重置"
  },
  ["10755"] = {
    ID = "10755",
    Type = 1,
    Desc = "TipsType_10755_Desc|解锁成功"
  },
  ["10756"] = {
    ID = "10756",
    Type = 1,
    Desc = "TipsType_10756_Desc|当前无叠位材料可放入"
  },
  ["10757"] = {
    ID = "10757",
    Type = 1,
    Desc = "TipsType_10757_Desc|{s1}已经在今日本次活动中进行过挑战，无法再次上场"
  },
  ["10758"] = {
    ID = "10758",
    Type = 1,
    Desc = "TipsType_10758_Desc|队伍界域不满足要求"
  },
  ["10801"] = {
    ID = "10801",
    Type = 1,
    Desc = "TipsType_10801_Desc|密契方案数量已达上限"
  },
  ["10802"] = {
    ID = "10802",
    Type = 1,
    Desc = "TipsType_10802_Desc|{s1}已在其他密契方案中使用，无法保存方案"
  },
  ["10803"] = {
    ID = "10803",
    Type = 1,
    Desc = "TipsType_10803_Desc|密契方案名不允许为空"
  },
  ["10804"] = {
    ID = "10804",
    Type = 1,
    Desc = "TipsType_10804_Desc|包含非法字符，请重新输入"
  },
  ["10805"] = {
    ID = "10805",
    Type = 1,
    Desc = "TipsType_10805_Desc|已保存"
  },
  ["10806"] = {
    ID = "10806",
    Type = 1,
    Desc = "TipsType_10806_Desc|当前密契已在{s1}中应用"
  },
  ["10807"] = {
    ID = "10807",
    Type = 1,
    Desc = "TipsType_10807_Desc|已装备"
  },
  ["10808"] = {
    ID = "10808",
    Type = 1,
    Desc = "TipsType_10808_Desc|已卸下"
  },
  ["10809"] = {
    ID = "10809",
    Type = 1,
    Desc = "TipsType_10809_Desc|当前队伍已出战"
  },
  ["10810"] = {
    ID = "10810",
    Type = 1,
    Desc = "TipsType_10810_Desc|密契方案不可为空"
  },
  ["10811"] = {
    ID = "10811",
    Type = 1,
    Desc = "TipsType_10811_Desc|当前已装备该方案"
  },
  ["10812"] = {
    ID = "10812",
    Type = 1,
    Desc = "TipsType_10812_Desc|已装备"
  },
  ["10813"] = {
    ID = "10813",
    Type = 2,
    Desc = "TipsType_10813_Desc|是否确认删除方案【{s1}】？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10813_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10813_RightBtnDesc|确认"
  },
  ["10814"] = {
    ID = "10814",
    Type = 1,
    Desc = "TipsType_10814_Desc|本次调查上阵唤醒体不符合队伍要求"
  },
  ["10815"] = {
    ID = "10815",
    Type = 1,
    Desc = "TipsType_10815_Desc|当前唤醒体为剧情特殊设计，无法查看详情"
  },
  ["10816"] = {
    ID = "10816",
    Type = 1,
    Desc = "TipsType_10816_Desc|「代理凭证」不足"
  },
  ["10817"] = {
    ID = "10817",
    Type = 1,
    Desc = "TipsType_10817_Desc|当前没有您的结算记录，请先「挑战」并在次日9:00 结算后再执行。"
  },
  ["10818"] = {
    ID = "10818",
    Type = 1,
    Desc = "TipsType_10818_Desc|今日代理已完成，不可重复代理"
  },
  ["20199"] = {
    ID = "20199",
    Type = 2,
    Title = "TipsType_20199_Title|领取确认",
    Desc = "TipsType_20199_Desc|领取后「代理凭证」将超出拥有上限，\n超出部分将不会获得。\n是否继续领取？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20199_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20199_RightBtnDesc|确认"
  },
  ["20200"] = {
    ID = "20200",
    Type = 2,
    Title = "TipsType_20200_Title|代理确认",
    Desc = "TipsType_20200_Desc|申请试训代理将消耗 <Blue:「代理凭证」× 1>\n申请后将直接完成每日试训，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20200_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20200_RightBtnDesc|确认"
  },
  ["20201"] = {
    ID = "20201",
    Type = 2,
    Title = "TipsType_20201_Title|替换确认",
    Desc = "TipsType_20201_Desc|以下密契正在装备中，是否进行替换？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20201_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20201_RightBtnDesc|确认"
  },
  ["20202"] = {
    ID = "20202",
    Type = 2,
    Title = "TipsType_20202_Title|删除确认",
    Desc = "TipsType_20202_Desc|当前方案应用于{s1}，是否确认删除方案【{s2}】？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20202_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20202_RightBtnDesc|确认"
  },
  ["20203"] = {
    ID = "20203",
    Type = 2,
    Title = "TipsType_20203_Title|装备确认",
    Desc = "TipsType_20203_Desc|队伍中相同的命轮效果无法重复生效，{s1}已在当前队伍装备，是否确认装备？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20203_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20203_RightBtnDesc|确认"
  },
  ["20204"] = {
    ID = "20204",
    Type = 2,
    Title = "TipsType_20204_Title|删除确认",
    Desc = "TipsType_20204_Desc|当前密契已在{s1}中使用，分解后将会从该方案中移除，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20204_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20204_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20205"] = {
    ID = "20205",
    Type = 2,
    Title = "TipsType_20205_Title|删除确认",
    Desc = "TipsType_20205_Desc|当前密契已在编队{s1}中使用，分解后将会卸下该密契，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20205_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20205_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20206"] = {
    ID = "20206",
    Type = 2,
    Title = "TipsType_20206_Title|删除确认",
    Desc = "TipsType_20206_Desc|当前命轮已在编队{s1}中使用，分解后将会在编队中卸下该命轮，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20206_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20206_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20207"] = {
    ID = "20207",
    Type = 2,
    Title = "TipsType_20207_Title|保存确认",
    Desc = "TipsType_20207_Desc|当前方案尚未保存，退出后将清空本次编辑，是否确认退出？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20207_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20207_RightBtnDesc|确认"
  },
  ["20110"] = {
    ID = "20110",
    Type = 2,
    Title = "TipsType_20110_Title|生日确认",
    Desc = "TipsType_20110_Desc|确认选择{s1}月{s2}日作为你的生日吗?\n确认后将无法修改。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20110_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20110_RightBtnDesc|确认"
  },
  ["20113"] = {
    ID = "20113",
    Type = 2,
    Title = "TipsType_20113_Title|一键阅读确认",
    Desc = "TipsType_20113_Desc|是否将所有已获得的教学内容标记为已阅读，并领取教学奖励？（建议新入学的守密人仔细阅读教学内容~）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20113_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20113_RightBtnDesc|确认"
  },
  ["20114"] = {
    ID = "20114",
    Type = 2,
    Title = "TipsType_20114_Title|回溯选择",
    Desc = "TipsType_20114_Desc|确认选择<WeaponEffect_Num:{s1}>开启回溯吗？\n此操作不可回退，请谨慎确认",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20114_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20114_RightBtnDesc|确认"
  },
  ["20115"] = {
    ID = "20115",
    Type = 1,
    Desc = "TipsType_20115_Desc|当前唤醒体未经过任何养成，无需进行养成回溯"
  },
  ["201151"] = {
    ID = "201151",
    Type = 1,
    Desc = "TipsType_201151_Desc|当前唤醒体没有启灵，无需进行启灵回溯"
  },
  ["20116"] = {
    ID = "20116",
    Type = 2,
    Title = "TipsType_20116_Title|开启成功",
    Desc = "TipsType_20116_Desc|<WeaponEffect_Num:{s1}>已开启回溯。\n是否立即前往进行回溯？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20116_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20116_RightBtnDesc|前往"
  },
  ["20117"] = {
    ID = "20117",
    Type = 2,
    Title = "TipsType_20117_Title|养成回溯",
    Desc = "TipsType_20117_Desc|即将重置唤醒体的升级、升格、技能、天赋和灵知深化状态，并返还相应消耗。\n确认对<WeaponEffect_Num:{s1}>进行养成回溯吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20117_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20117_RightBtnDesc|确认"
  },
  ["20118"] = {
    ID = "20118",
    Type = 2,
    Title = "TipsType_20118_Title|启灵回溯",
    Desc = "TipsType_20118_Desc|即将重置唤醒体的启灵等级，并返还启灵消耗。\n确认对<WeaponEffect_Num:{s1}>进行启灵回溯吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20118_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20118_RightBtnDesc|确认"
  },
  ["20119"] = {
    ID = "20119",
    Type = 2,
    Title = "TipsType_20119_Title|黑池归还",
    Desc = "TipsType_20119_Desc|即将重置唤醒体的升级、升格、技能、启灵、天赋和灵知深化状态，返还相应消耗，\n并将唤醒体归还至黑池。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20119_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20119_RightBtnDesc|确认"
  },
  ["20120"] = {
    ID = "20120",
    Type = 1,
    Desc = "TipsType_20120_Desc|特殊唤醒体不可进行归还"
  },
  ["20121"] = {
    ID = "20121",
    Type = 2,
    Title = "TipsType_20121_Title|叠位回溯",
    Desc = "TipsType_20121_Desc|即将重置命轮的叠位状态，并返还所有叠位消耗。\n确认对<WeaponEffect_Num:{s1}>进行叠位回溯吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20121_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20121_RightBtnDesc|确认"
  },
  ["20122"] = {
    ID = "20122",
    Type = 2,
    Title = "TipsType_20122_Title|黑池归还",
    Desc = "TipsType_20122_Desc|即将重置命轮的叠位状态，返还所有叠位消耗，并将命轮归还至黑池。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20122_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20122_RightBtnDesc|确认"
  },
  ["20123"] = {
    ID = "20123",
    Type = 2,
    Title = "TipsType_20123_Title|挑战确认",
    Desc = "TipsType_20123_Desc|完成挑战后，队伍中的唤醒体、命轮和钥令将无法在其他融灾禁区中上场，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20123_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20123_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20124"] = {
    ID = "20124",
    Type = 2,
    Title = "TipsType_20124_Title|重置确认",
    Desc = "TipsType_20124_Desc|重置后，当前调查队伍的唤醒体、命轮和钥令都可以重新上场，但通过该关卡获得的特训值也会扣除（不影响奖励状态），是否确认重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20124_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20124_RightBtnDesc|确认"
  },
  ["20125"] = {
    ID = "20125",
    Type = 1,
    Desc = "TipsType_20125_Desc|当前命轮叠位等级为0，不需要叠位回溯"
  },
  ["20126"] = {
    ID = "20126",
    Type = 1,
    Desc = "TipsType_20126_Desc|当前唤醒体正在派遣中，请召回后再进行回溯或归还"
  },
  ["20127"] = {
    ID = "20127",
    Type = 1,
    Desc = "TipsType_20127_Desc|当前命轮已锁定，归还前请先解除锁定"
  },
  ["20128"] = {
    ID = "20128",
    Type = 2,
    Title = "TipsType_20128_Title|重置确认",
    Desc = "TipsType_20128_Desc|{s1}已通关，需要进行重置才可以进行挑战，是否确认重置？\n（重置后，调查队伍中的唤醒体、命轮和钥令可重新上场，但通过该关卡获得的特训值也会扣除。）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20128_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20128_RightBtnDesc|确认"
  },
  ["20129"] = {
    ID = "20129",
    Type = 8,
    Title = "TipsType_20129_Title|调查确认",
    Desc = "TipsType_20129_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20129_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20129_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117091, 117120}
  },
  ["20130"] = {
    ID = "20130",
    Type = 8,
    Title = "TipsType_20130_Title|调查确认",
    Desc = "TipsType_20130_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20130_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20130_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117124}
  },
  ["20131"] = {
    ID = "20131",
    Type = 8,
    Title = "TipsType_20131_Title|调查确认",
    Desc = "TipsType_20131_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20131_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20131_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117096, 117120}
  },
  ["20132"] = {
    ID = "20132",
    Type = 2,
    Title = "TipsType_20132_Title|自动补足",
    Desc = "TipsType_20132_Desc|勾选后，若<TipsHighlightText:密契残本>充足，则优先消耗残本。\n若残本不足，则自动消耗 <TipsHighlightText:「{s1}」> 补足残本。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20132_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20132_RightBtnDesc|仍要勾选"
  },
  ["20133"] = {
    ID = "20133",
    Type = 2,
    Title = "TipsType_20133_Title|灵知深化",
    Desc = "TipsType_20133_Desc|是否对 <TipsHighlightText:「{s1}」> 进行灵知深化？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20133_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20133_RightBtnDesc|确认"
  },
  ["20134"] = {
    ID = "20134",
    Type = 8,
    Title = "TipsType_20134_Title|调查确认",
    Desc = "TipsType_20134_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20134_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20134_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {120993}
  },
  ["20137"] = {
    ID = "20137",
    Type = 2,
    Title = "TipsType_20137_Title|解锁确认",
    Desc = "TipsType_20137_Desc|确认消耗<Blue:「{s1}」×{s2}>解锁该曲目吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20137_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20137_RightBtnDesc|确认"
  },
  ["20138"] = {
    ID = "20138",
    Type = 2,
    Title = "TipsType_20138_Title|解锁确认",
    Desc = "TipsType_20138_Desc|活动期间内 <Blue:限时免费>解锁，是否解锁？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20138_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20138_RightBtnDesc|确认"
  },
  ["20139"] = {
    ID = "20139",
    Type = 2,
    Title = "TipsType_20139_Title|解锁确认",
    Desc = "TipsType_20139_Desc|确认消耗<Blue:「{s1}」×{s3}> ，开启<Blue:「{s2}」>吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20139_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20139_RightBtnDesc|确认"
  },
  ["20140"] = {
    ID = "20140",
    Type = 2,
    Title = "TipsType_20140_Title|领取确认",
    Desc = "TipsType_20140_Desc|<Blue:「{s1}」>当前已达持有上限，继续领取将无法获得该道具。是否领取？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20140_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20140_RightBtnDesc|确认",
    DonotRemind = 7
  },
  ["20141"] = {
    ID = "20141",
    Type = 2,
    Title = "TipsType_20141_Title|肌肉记忆",
    Desc = "TipsType_20141_Desc|是否以 30%的最大生命({s1})为代价\n跳过战斗，立即消灭敌人？\n\n当前生命:{s2}",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20141_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20141_RightBtnDesc|确认"
  },
  ["20142"] = {
    ID = "20142",
    Type = 2,
    Title = "TipsType_20142_Title|调查确认",
    Desc = "TipsType_20142_Desc|是否选择失去 <color=#BB646D> {s1} </color> 点生命，获得 {s2} 枚黑印？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20142_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20142_RightBtnDesc|确认"
  },
  ["20145"] = {
    ID = "20145",
    Type = 8,
    Title = "TipsType_20145_Title|登录奖励",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20145_LeftBtnDesc|取消"
  },
  ["20300"] = {
    ID = "20300",
    Type = 1,
    Desc = "TipsType_20300_Desc|已有 {s1} 定位唤醒体，无法在同一个队伍中使用同定位唤醒体。"
  },
  ["10821"] = {
    ID = "10821",
    Type = 1,
    Desc = "TipsType_10821_Desc|当前暂无物资，请稍后再来"
  },
  ["10822"] = {
    ID = "10822",
    Type = 1,
    Desc = "TipsType_10822_Desc|活动已结束"
  },
  ["10823"] = {
    ID = "10823",
    Type = 1,
    Desc = "TipsType_10823_Desc|特殊种子售罄后才可要求商铺进行补货"
  },
  ["10824"] = {
    ID = "10824",
    Type = 1,
    Desc = "TipsType_10824_Desc|补货次数已用完，没有更多的货物储备了"
  },
  ["10825"] = {
    ID = "10825",
    Type = 1,
    Desc = "TipsType_10825_Desc|「{s1}」不足"
  },
  ["10826"] = {
    ID = "10826",
    Type = 1,
    Desc = "TipsType_10826_Desc|特殊种子已售罄，可选择播种进行重置"
  },
  ["10827"] = {
    ID = "10827",
    Type = 1,
    Desc = "TipsType_10827_Desc|特殊种子已重置"
  },
  ["20151"] = {
    ID = "20151",
    Type = 2,
    Title = "TipsType_20151_Title|重置确认",
    Desc = "TipsType_20151_Desc|重置后，「特殊物品」的剩余数量将重置至上限，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20151_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20151_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20152"] = {
    ID = "20152",
    Type = 2,
    Title = "TipsType_20152_Title|激活确认",
    Desc = "TipsType_20152_Desc|「{s1}」不足，是否使用「蔷薇金券」× {s2}补齐？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20152_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20152_RightBtnDesc|确认"
  },
  ["10828"] = {
    ID = "10828",
    Type = 1,
    Desc = "TipsType_10828_Desc|物品已全部交换完，请选择重置"
  },
  ["10829"] = {
    ID = "10829",
    Type = 1,
    Desc = "TipsType_10829_Desc|重置成功"
  },
  ["20153"] = {
    ID = "20153",
    Type = 2,
    Title = "TipsType_20153_Title|重置确认",
    Desc = "TipsType_20153_Desc|重置后，「特殊物品」和「普通物品」的剩余数量会重置至上限。\n第{s1}次及之后，「特殊物品」将不会再重置。\n是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20153_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20153_RightBtnDesc|确认"
  },
  ["20154"] = {
    ID = "20154",
    Type = 2,
    Title = "TipsType_20154_Title|重置确认",
    Desc = "TipsType_20154_Desc|重置后，「特殊物品」和「普通物品」的剩余数量会重置至上限。\n第3次及之后，「特殊物品」将不会再重置。\n <Blue:当前仍有「普通物品」>，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20154_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20154_RightBtnDesc|确认"
  },
  ["20155"] = {
    ID = "20155",
    Type = 2,
    Title = "TipsType_20155_Title|叠位确认",
    Desc = "TipsType_20155_Desc|叠位材料中包含已上锁的命轮，是否确认消耗用于叠位？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20155_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20155_RightBtnDesc|确认"
  },
  ["10830"] = {
    ID = "10830",
    Type = 1,
    Desc = "TipsType_10830_Desc|队伍中存在无法上场的唤醒体，无法进入调查"
  },
  ["10831"] = {
    ID = "10831",
    Type = 1,
    Desc = "TipsType_10831_Desc|队伍中存在相同命轮，无法进入融灾禁区"
  },
  ["10832"] = {
    ID = "10832",
    Type = 1,
    Desc = "TipsType_10832_Desc|队伍未装备钥令，无法进入调查"
  },
  ["10833"] = {
    ID = "10833",
    Type = 1,
    Desc = "TipsType_10833_Desc|队伍中存在无法装备的命轮，无法进入调查"
  },
  ["10834"] = {
    ID = "10834",
    Type = 1,
    Desc = "TipsType_10834_Desc|不可为助战唤醒体装备命轮"
  },
  ["10835"] = {
    ID = "10835",
    Type = 1,
    Desc = "TipsType_10835_Desc|不可为助战唤醒体装备密契"
  },
  ["10836"] = {
    ID = "10836",
    Type = 1,
    Desc = "TipsType_10836_Desc|不可为剧情预设唤醒体装备命轮"
  },
  ["10837"] = {
    ID = "10837",
    Type = 1,
    Desc = "TipsType_10837_Desc|不可为剧情预设唤醒体装备密契"
  },
  ["10838"] = {
    ID = "10838",
    Type = 1,
    Desc = "TipsType_10838_Desc|表情方案中的表情数量已达上限"
  },
  ["10839"] = {
    ID = "10839",
    Type = 1,
    Desc = "TipsType_10839_Desc|表情已使用，点击表情方案中的表情可卸下"
  },
  ["10840"] = {
    ID = "10840",
    Type = 1,
    Desc = "TipsType_10840_Desc|表情发送太快啦"
  },
  ["10841"] = {
    ID = "10841",
    Type = 1,
    Desc = "TipsType_10841_Desc|表情方案不可为空"
  },
  ["10842"] = {
    ID = "10842",
    Type = 1,
    Desc = "TipsType_10842_Desc|表情方案已更新"
  },
  ["10843"] = {
    ID = "10843",
    Type = 1,
    Desc = "TipsType_10843_Desc|此条目尚未解锁"
  },
  ["10844"] = {
    ID = "10844",
    Type = 1,
    Desc = "TipsType_10844_Desc|尚未解锁"
  },
  ["10850"] = {
    ID = "10850",
    Type = 1,
    Desc = "TipsType_10850_Desc|队伍中存在无法装备的钥令，无法进入调查"
  },
  ["10901"] = {
    ID = "10901",
    Type = 1,
    Desc = "TipsType_10901_Desc|麻痹"
  },
  ["10902"] = {
    ID = "10902",
    Type = 1,
    Desc = "TipsType_10902_Desc|昏迷"
  },
  ["10903"] = {
    ID = "10903",
    Type = 1,
    Desc = "TipsType_10903_Desc|暂未拥有：{s1}"
  },
  ["10904"] = {
    ID = "10904",
    Type = 1,
    Desc = "TipsType_10904_Desc|通关本章「普通」模式后，解锁「溯梦」模式观赏剧情"
  },
  ["10905"] = {
    ID = "10905",
    Type = 1,
    Desc = "TipsType_10905_Desc|完成「调查行动」1-15·普通 后解锁 「溯梦」观赏剧情"
  },
  ["10906"] = {
    ID = "10906",
    Type = 1,
    Desc = "TipsType_10906_Desc|「现实起点」不足"
  },
  ["10907"] = {
    ID = "10907",
    Type = 1,
    Desc = "TipsType_10907_Desc|已解锁"
  },
  ["20156"] = {
    ID = "20156",
    Type = 2,
    Title = "TipsType_20156_Title|解锁确认",
    Desc = "TipsType_20156_Desc|是否确认消耗<TipsHighlightText:「现实起点」× 1>解锁？\n（欲海翻波活动期间，解锁所需的「现实起点」从{s1}个降低为{s2}个。）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20156_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20156_RightBtnDesc|确认"
  },
  ["20157"] = {
    ID = "20157",
    Type = 2,
    Title = "TipsType_20157_Title|解锁确认",
    Desc = "TipsType_20157_Desc|是否确认消耗<TipsHighlightText:「现实起点」× {s1}>解锁？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20157_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20157_RightBtnDesc|确认"
  },
  ["10908"] = {
    ID = "10908",
    Type = 2,
    Title = "TipsType_10908_Title|唤醒确认",
    Desc = "TipsType_10908_Desc|{s1}启灵等级已满，继续领取将转为<TipsHighlightText:「灵魂回溯碎片」× 2>、<TipsHighlightText:「根源沉淀」× 250>，是否确认唤醒？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10908_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10908_RightBtnDesc|确认"
  },
  ["10909"] = {
    ID = "10909",
    Type = 2,
    Title = "TipsType_10909_Title|唤醒确认",
    Desc = "TipsType_10909_Desc|{s1}已唤醒，继续领取将转为<TipsHighlightText:「残片·{s2}」× 1>和<TipsHighlightText:「根源沉淀」× 50>，是否确认唤醒？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10909_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10909_RightBtnDesc|确认"
  },
  ["10910"] = {
    ID = "10910",
    Type = 2,
    Title = "TipsType_10910_Title|唤醒确认",
    Desc = "TipsType_10910_Desc|是否确认唤醒<TipsHighlightText:{s1}>？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10910_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10910_RightBtnDesc|确认"
  },
  ["20158"] = {
    ID = "20158",
    Type = 2,
    Title = "TipsType_20158_Title|退出确认",
    Desc = "TipsType_20158_Desc|当前关卡已过期，完成挑战后将不会获得奖励，是否确认退出？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20158_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20158_RightBtnDesc|确认"
  },
  ["20159"] = {
    ID = "20159",
    Type = 1,
    Title = "TipsType_20159_Title|转换提示",
    Desc = "TipsType_20159_Desc|<TipsHighlightText:「{s1}」>超出上限<TipsHighlightText: {s2} >个，每个已转换为<Blue:「无形者的请柬」× 1>"
  },
  ["20160"] = {
    ID = "20160",
    Type = 2,
    Title = "TipsType_20160_Title|补偿提示",
    Desc = "TipsType_20160_Desc|你已解锁<TipsHighlightText:「{s1}」>\n本次活动的免费解锁福利将为你提供以下补偿。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20160_RightBtnDesc|确认"
  },
  ["10911"] = {
    ID = "10911",
    Type = 1,
    Desc = "TipsType_10911_Desc|空间不足"
  },
  ["100001"] = {
    ID = "100001",
    Type = 2,
    Title = "TipsType_100001_Title|切换分辨率确认",
    Desc = "TipsType_100001_Desc|切换分辨率后需重启客户端才能生效，是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_100001_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_100001_RightBtnDesc|确认"
  },
  ["10912"] = {
    ID = "10912",
    Type = 1,
    Desc = "TipsType_10912_Desc|超维空间尚无指令卡，不可使用"
  },
  ["10913"] = {
    ID = "10913",
    Type = 1,
    Desc = "TipsType_10913_Desc|本回合无法再次使用"
  },
  ["10914"] = {
    ID = "10914",
    Type = 2,
    Title = "TipsType_10914_Title|任选确认",
    Desc = "TipsType_10914_Desc|是否确认选择<TipsHighlightText:{s1}>？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10914_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10914_RightBtnDesc|确认"
  },
  ["300001"] = {
    ID = "300001",
    Type = 2,
    Title = "TipsType_300001_Title|唤醒确认",
    Desc = "TipsType_300001_Desc|「银辉初耀」只有一次免费唤醒的机会，确认要使用吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_300001_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_300001_RightBtnDesc|确认"
  },
  ["300002"] = {
    ID = "300002",
    Type = 2,
    Title = "TipsType_300002_Title|唤醒确认",
    Desc = "TipsType_300002_Desc|确认选择本次唤醒结果吗？确认后本次唤醒将消耗免费5连抽次数",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_300002_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_300002_RightBtnDesc|确认"
  },
  ["100002"] = {
    ID = "100002",
    Type = 2,
    Title = "TipsType_100002_Title|再来一局",
    Desc = "TipsType_100002_Desc|正在等待 {s1} 接受再来一局邀请",
    RightBtn = 2,
    RightBtnDesc = "TipsType_100002_RightBtnDesc|取消"
  },
  ["100003"] = {
    ID = "100003",
    Type = 2,
    Title = "TipsType_100003_Title|再来一局",
    Desc = "TipsType_100003_Desc|{s1} 邀请你再来一局",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_100003_LeftBtnDesc|拒绝",
    RightBtn = 2,
    RightBtnDesc = "TipsType_100003_RightBtnDesc|接受"
  },
  ["100004"] = {
    ID = "100004",
    Type = 1,
    Desc = "TipsType_100004_Desc|已经是当前宿舍背景"
  },
  ["100005"] = {
    ID = "100005",
    Type = 1,
    Desc = "TipsType_100005_Desc|相位对弈玩法未开启"
  },
  ["100006"] = {
    ID = "100006",
    Type = 1,
    Desc = "TipsType_100006_Desc|对方相位对弈玩法未开启"
  },
  ["100007"] = {
    ID = "100007",
    Type = 1,
    Desc = "TipsType_100007_Desc|互相关注才能发起友谊赛"
  },
  ["100008"] = {
    ID = "100008",
    Type = 1,
    Desc = "TipsType_100008_Desc|对方已离线"
  },
  ["100009"] = {
    ID = "100009",
    Type = 1,
    Desc = "TipsType_100009_Desc|对方正在探索中"
  },
  ["100010"] = {
    ID = "100010",
    Type = 1,
    Desc = "TipsType_100010_Desc|友谊赛等待超时"
  },
  ["100011"] = {
    ID = "100011",
    Type = 1,
    Desc = "TipsType_100011_Desc|你已取消友谊赛"
  },
  ["100012"] = {
    ID = "100012",
    Type = 2,
    Title = "TipsType_100012_Title|提示",
    Desc = "TipsType_100012_Desc|友谊赛邀请被拒绝",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_100012_LeftBtnDesc|确认"
  },
  ["100013"] = {
    ID = "100013",
    Type = 1,
    Desc = "TipsType_100013_Desc|对方已离线"
  },
  ["100014"] = {
    ID = "100014",
    Type = 1,
    Desc = "TipsType_100014_Desc|对方已进入其他玩法"
  },
  ["100015"] = {
    ID = "100015",
    Type = 1,
    Desc = "TipsType_100015_Desc|邀请过于频繁，{s1}秒后重试"
  },
  ["100016"] = {
    ID = "100016",
    Type = 2,
    Title = "TipsType_100016_Title|提示",
    Desc = "TipsType_100016_Desc|对方已取消友谊赛",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_100016_LeftBtnDesc|确认"
  },
  ["100017"] = {
    ID = "100017",
    Type = 2,
    Title = "TipsType_100017_Title|提示",
    Desc = "TipsType_100017_Desc|该玩家正在进行友谊赛",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_100017_LeftBtnDesc|确认"
  },
  ["100018"] = {
    ID = "100018",
    Type = 2,
    Title = "TipsType_100018_Title|核心课题已过期",
    Desc = "TipsType_100018_Desc|此编队包含限时使用的卡牌，需要解锁本期核心课题才可继续使用，期待与你再次并肩作战！\n是否前往解锁核心课题？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_100018_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_100018_RightBtnDesc|确认"
  },
  ["100020"] = {
    ID = "100020",
    Type = 2,
    Title = "TipsType_100020_Title|提示",
    Desc = "TipsType_100020_Desc|尚在战斗中，是否继续之前的战斗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_100020_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_100020_RightBtnDesc|确认"
  },
  ["10915"] = {
    ID = "10915",
    Type = 1,
    Desc = "TipsType_10915_Desc|解锁编队需按顺序进行，不可跳过未解锁的编队"
  },
  ["10916"] = {
    ID = "10916",
    Type = 2,
    Title = "TipsType_10916_Title|解锁确认",
    Desc = "TipsType_10916_Desc|是否消耗<Blue: {s1} × {s2}> 解锁？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10916_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10916_RightBtnDesc|确认"
  },
  ["10917"] = {
    ID = "10917",
    Type = 1,
    Desc = "TipsType_10917_Desc|成功解锁 {s1}"
  },
  ["10918"] = {
    ID = "10918",
    Type = 1,
    Desc = "TipsType_10918_Desc|成功解锁{s1}，队伍已全部解锁完毕"
  },
  ["10919"] = {
    ID = "10919",
    Type = 2,
    Title = "TipsType_10919_Title|暂未解锁",
    Desc = "TipsType_10919_Desc|完成[{s1}：{s2}]后解锁，是否前往[{s1}]?",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10919_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10919_RightBtnDesc|确认"
  },
  ["10920"] = {
    ID = "10920",
    Type = 2,
    Title = "TipsType_10920_Title|暂未解锁",
    Desc = "TipsType_10920_Desc|在限时活动「相位逆转」中积累「魔法橡果」× {s1} 即可解锁，是否前往「相位逆转」？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_10920_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_10920_RightBtnDesc|确认"
  },
  ["10921"] = {
    ID = "10921",
    Type = 1,
    Desc = "TipsType_10921_Desc|无法同时装备两个主属性相同的命轮"
  },
  ["20161"] = {
    ID = "20161",
    Type = 1,
    Title = "TipsType_20161_Title|转换提示",
    Desc = "TipsType_20161_Desc|<TipsHighlightText:「{s1}」>超出上限<TipsHighlightText: {s2} >个，每个已转换为<Blue:「蔷薇金券」× 5000>"
  },
  ["20162"] = {
    ID = "20162",
    Type = 2,
    Title = "TipsType_20162_Title|养成回溯",
    Desc = "TipsType_20162_Desc|即将重置唤醒体的升级、升格、技能、天赋和灵知深化状态，并返还相应消耗。\n确认对<WeaponEffect_Num:{s1}>进行养成回溯吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20162_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20162_RightBtnDesc|确认"
  },
  ["20163"] = {
    ID = "20163",
    Type = 2,
    Title = "TipsType_20163_Title|启灵回溯",
    Desc = "TipsType_20163_Desc|即将重置唤醒体的启灵状态，并返还相应消耗。\n确认对<WeaponEffect_Num:{s1}>进行养成回溯吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20163_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20163_RightBtnDesc|确认"
  },
  ["20164"] = {
    ID = "20164",
    Type = 2,
    Title = "TipsType_20164_Title|黑池归还",
    Desc = "TipsType_20164_Desc|即将重置唤醒体的升级、升格、技能、天赋、启灵和灵知深化状态，返还相应消耗，\n并将唤醒体归还至黑池。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20164_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20164_RightBtnDesc|确认"
  },
  ["20165"] = {
    ID = "20165",
    Type = 2,
    Title = "TipsType_20165_Title|回溯选择",
    Desc = "TipsType_20165_Desc|<WeaponEffect_Num:{s1}>属于特殊唤醒体，仅能回溯升级、升格、技能、天赋和灵知深化养成，<Red:无法回溯启灵养成>，确认选择<WeaponEffect_Num:{s1}>开启回溯吗？\n此操作不可回退，请谨慎确认",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20165_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20165_RightBtnDesc|确认"
  },
  ["20166"] = {
    ID = "20166",
    Type = 1,
    Desc = "TipsType_20166_Desc|特殊唤醒体不可进行启灵回溯"
  },
  ["20167"] = {
    ID = "20167",
    Type = 1,
    Desc = "TipsType_20167_Desc|本次回溯已使用过「养成回溯」，请下次回溯开启时进行「养成回溯」。"
  },
  ["20168"] = {
    ID = "20168",
    Type = 1,
    Desc = "TipsType_20168_Desc|本次回溯已使用过「启灵回溯」，请下次回溯开启时进行「启灵回溯」。"
  },
  ["20169"] = {
    ID = "20169",
    Type = 2,
    Title = "TipsType_20169_Title|确认选择",
    Desc = "TipsType_20169_Desc|是否确认选择唤醒体<OrangeQuality:「{s1}」>以及推荐命轮<OrangeQuality:「{s2}」>，作为本期活动的定向UP。",
    BottomDesc = "TipsType_20169_BottomDesc|<Blue:注意：一旦选定，本次活动无法再更改！>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20169_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20169_RightBtnDesc|确认"
  },
  ["20170"] = {
    ID = "20170",
    Type = 1,
    Desc = "TipsType_20170_Desc|已达到每日挑战上限，请明天再来挑战吧！"
  },
  ["20171"] = {
    ID = "20171",
    Type = 8,
    Desc = "TipsType_20171_Desc|现在可以前往「幻梦深潜」了！"
  },
  ["20173"] = {
    ID = "20173",
    Type = 8,
    Desc = "TipsType_20173_Desc|现在可以前往「相位对弈」了！"
  },
  ["20174"] = {
    ID = "20174",
    Type = 8,
    Desc = "TipsType_20174_Desc|现在可以前往「调查行动·困难」了！"
  },
  ["20175"] = {
    ID = "20175",
    Type = 8,
    Desc = "TipsType_20175_Desc|现在可以前往「超验存在」了！"
  },
  ["20176"] = {
    ID = "20176",
    Type = 8,
    Desc = "TipsType_20176_Desc|现在可以前往「融灾禁区」了！"
  },
  ["20177"] = {
    ID = "20177",
    Type = 8,
    Desc = "TipsType_20177_Desc|现在可以前往「繁衍狂欢」了！"
  },
  ["20178"] = {
    ID = "20178",
    Type = 8,
    Desc = "TipsType_20178_Desc|现在可以前往装备「第二命轮」了！"
  },
  ["20179"] = {
    ID = "20179",
    Type = 8,
    Desc = "TipsType_20179_Desc|现在可以前往「混沌集群」了！"
  },
  ["20180"] = {
    ID = "20180",
    Type = 8,
    Desc = "TipsType_20180_Desc|现在可以前往「禁忌纂录」了！"
  },
  ["20181"] = {
    ID = "20181",
    Type = 8,
    Desc = "TipsType_20181_Desc|现在可以前往「密契升级」了！"
  },
  ["20182"] = {
    ID = "20182",
    Type = 8,
    Desc = "TipsType_20182_Desc|现在可以前往「密契转录」了！"
  },
  ["20183"] = {
    ID = "20183",
    Type = 1,
    Desc = "TipsType_20183_Desc|当前活动已结束"
  },
  ["20184"] = {
    ID = "20184",
    Type = 8,
    Desc = "TipsType_20184_Desc|现在可以前往「学籍档案」了！"
  },
  ["20185"] = {
    ID = "20185",
    Type = 2,
    Title = "TipsType_20185_Title|跳过剧情",
    Desc = "TipsType_20185_Desc|确认跳过本段全部剧情？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20185_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20185_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20186"] = {
    ID = "20186",
    Type = 2,
    Desc = "TipsType_20186_Desc|将下载运行游戏的必要数据。\n是否继续？\n\n*建议在WiFi环境下进行下载。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20186_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20186_RightBtnDesc|确认"
  },
  ["20187"] = {
    ID = "20187",
    Type = 2,
    Desc = "TipsType_20187_Desc|资源下载完成",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_20187_LeftBtnDesc|确认"
  },
  ["20188"] = {
    ID = "20188",
    Type = 2,
    Desc = "TipsType_20188_Desc|存储空间不足，需要预留至少{s1}存储空间，否则运行时可能导致资源丢失，是否继续下载新？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20188_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20188_RightBtnDesc|确认"
  },
  ["20189"] = {
    ID = "20189",
    Type = 2,
    Desc = "TipsType_20189_Desc|资源下载失败，是否重试？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20189_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20189_RightBtnDesc|确认"
  },
  ["20190"] = {
    ID = "20190",
    Type = 1,
    Title = "TipsType_20190_Title|转换提示",
    Desc = "TipsType_20190_Desc|<TipsHighlightText:{s1}>超出上限<TipsHighlightText: {s2} >个，每个已转换为<Blue:{s3}>"
  },
  ["20400"] = {
    ID = "20400",
    Type = 2,
    Title = "TipsType_20400_Title|抽奖道具不足",
    Desc = "TipsType_20400_Desc|<WeaponEffect_Num:「{s1}」>不足，是否前往兑换？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20400_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20400_RightBtnDesc|确认"
  },
  ["31003"] = {
    ID = "31003",
    Type = 2,
    Title = "TipsType_31003_Title|复活确认",
    Desc = "TipsType_31003_Desc|银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}）\n<Blue:（首次复活不消耗应急灵知体）>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_31003_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_31003_RightBtnDesc|确认"
  },
  ["31004"] = {
    ID = "31004",
    Type = 2,
    Title = "TipsType_31004_Title|复活确认",
    Desc = "TipsType_31004_Desc|银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}）\n<Blue:（首次复活不消耗应急灵知体）>",
    RightBtn = 2,
    RightBtnDesc = "TipsType_31004_RightBtnDesc|确认"
  },
  ["31000"] = {
    ID = "31000",
    Type = 2,
    Title = "TipsType_31000_Title|年龄认证",
    Desc = "TipsType_31000_Desc|确定要使用此出生年月认证吗？出生年月一旦确定不可再更改！",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_31000_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_31000_RightBtnDesc|确认"
  },
  ["31001"] = {
    ID = "31001",
    Type = 1,
    Desc = "TipsType_31001_Desc|本月已充值<Blue:{s1}>元，上限限制为<Blue:{s2}>元，请下个月再充值或换更低金额的挡位充值试试吧"
  },
  ["31002"] = {
    ID = "31002",
    Type = 1,
    Desc = "TipsType_31002_Desc|请先完成年龄认证"
  },
  ["20191"] = {
    ID = "20191",
    Type = 8,
    Desc = "TipsType_20191_Desc|现在可以前往「活动」了！"
  },
  ["20301"] = {
    ID = "20301",
    Type = 8,
    Desc = "TipsType_20301_Desc|现在可以前往「常训任务」了！"
  },
  ["20193"] = {
    ID = "20193",
    Type = 8,
    Desc = "TipsType_20193_Desc|现在可以前往「派遣」了！"
  },
  ["20194"] = {
    ID = "20194",
    Type = 8,
    Desc = "TipsType_20194_Desc|现在可以前往「银芯通信」了！"
  },
  ["20195"] = {
    ID = "20195",
    Type = 8,
    Desc = "TipsType_20195_Desc|现在可以前往「学期课题」了！"
  },
  ["20196"] = {
    ID = "20196",
    Type = 8,
    Desc = "TipsType_20196_Desc|现在可以前往「无光之境」了！"
  },
  ["20197"] = {
    ID = "20197",
    Type = 1,
    Desc = "TipsType_20197_Desc|已达最大可唤醒次数，请前往领取任务奖励！"
  },
  ["20198"] = {
    ID = "20198",
    Type = 1,
    Desc = "TipsType_20198_Desc|还未完成任务，请完成任务后再来领取！"
  },
  ["20208"] = {
    ID = "20208",
    Type = 1,
    Desc = "TipsType_20208_Desc|任务奖励已领取，去看看其它任务吧！"
  },
  ["20209"] = {
    ID = "20209",
    Type = 1,
    Desc = "TipsType_20209_Desc|任务已过期"
  },
  ["20210"] = {
    ID = "20210",
    Type = 8,
    Title = "TipsType_20210_Title|调查确认",
    Desc = "TipsType_20210_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20210_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20210_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117093}
  },
  ["20211"] = {
    ID = "20211",
    Type = 1,
    Desc = "TipsType_20211_Desc|{s1}天{s2}小时后开启"
  },
  ["20212"] = {
    ID = "20212",
    Type = 1,
    Desc = "TipsType_20212_Desc|{s1}小时{s2}分后开启"
  },
  ["20213"] = {
    ID = "20213",
    Type = 2,
    Title = "TipsType_20213_Title|回溯选择",
    Desc = "TipsType_20213_Desc|<WeaponEffect_Num:{s1}>已在编队中触发超限因果，任意回溯将会导致超限因果失效，并且将会从编队中自动卸下，确认选择<WeaponEffect_Num:{s1}>开启回溯吗？\n此操作不可回退，请谨慎确认",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20213_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20213_RightBtnDesc|确认"
  },
  ["20214"] = {
    ID = "20214",
    Type = 2,
    Title = "TipsType_20214_Title|叠位回溯",
    Desc = "TipsType_20214_Desc|即将重置命轮的叠位状态，并返还所有叠位消耗。\n<WeaponEffect_Num:{s1}>已在编队中触发超限因果，回溯后将会从编队中自动卸下。\n确认对<WeaponEffect_Num:{s1}>进行叠位回溯吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20214_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20214_RightBtnDesc|确认"
  },
  ["20215"] = {
    ID = "20215",
    Type = 2,
    Title = "TipsType_20215_Title|黑池归还",
    Desc = "TipsType_20215_Desc|即将重置命轮的叠位状态，返还所有叠位消耗，并将命轮归还至黑池。\n<WeaponEffect_Num:{s1}>已在编队中触发超限因果，归还后将会从编队中自动卸下。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20215_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20215_RightBtnDesc|确认"
  },
  ["20216"] = {
    ID = "20216",
    Type = 2,
    Title = "TipsType_20216_Title|购买确认",
    Desc = "TipsType_20216_Desc|是否消耗 <Blue:「{s1}」× {s2} >购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20216_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20216_RightBtnDesc|购买"
  },
  ["20192"] = {
    ID = "20192",
    Type = 2,
    Desc = "TipsType_20192_Desc|将下载游玩序章后续内容的必要数据。\n资源大小：{s1}\n是否继续？\n\n*建议在WiFi环境下进行下载。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20192_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20192_RightBtnDesc|下载"
  },
  ["20220"] = {
    ID = "20220",
    Type = 2,
    Desc = "TipsType_20220_Desc|检测到当前没有使用WIFI，下载会消耗较多流量，是否确认下载？\n资源大小：{s1}\n是否继续？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20220_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20220_RightBtnDesc|下载"
  },
  ["20221"] = {
    ID = "20221",
    Type = 2,
    Desc = "TipsType_20221_Desc|资源下载完成",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_20221_LeftBtnDesc|确认"
  },
  ["20222"] = {
    ID = "20222",
    Type = 2,
    Desc = "TipsType_20222_Desc|存储空间不足，需要预留至少{s1}存储空间，否则运行时可能导致资源丢失，是否继续下载新？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20222_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20222_RightBtnDesc|确认"
  },
  ["20223"] = {
    ID = "20223",
    Type = 2,
    Desc = "TipsType_20223_Desc|资源下载失败，是否重试？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20223_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20223_RightBtnDesc|确认"
  },
  ["20224"] = {
    ID = "20224",
    Type = 2,
    Desc = "TipsType_20224_Desc|将下载游玩序章后续内容的必要数据。\n资源大小：{s1}\n是否继续？\n\n*建议在WiFi环境下进行下载。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20224_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20224_RightBtnDesc|下载"
  },
  ["20225"] = {
    ID = "20225",
    Type = 2,
    Title = "TipsType_20225_Title|额外挑战",
    Desc = "TipsType_20225_Desc|{s1}已通关，是否进行额外挑战？\n额外挑战可以获得 {s2} 特训值",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20225_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20225_RightBtnDesc|确认"
  },
  ["20226"] = {
    ID = "20226",
    Type = 2,
    Title = "TipsType_20226_Title|重置确认",
    Desc = "TipsType_20226_Desc|重置后，额外挑战队伍的唤醒体、钥令和命轮都可以重新上场，但该关卡额外通关获得的特训值也会扣除（不影响奖励状态），是否确认重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20226_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20226_RightBtnDesc|确认"
  },
  ["20227"] = {
    ID = "20227",
    Type = 2,
    Title = "TipsType_20227_Title|重置确认",
    Desc = "TipsType_20227_Desc|重置后，当前调查队伍的唤醒体、钥令和命轮都可以重新上场，并且额外挑战队伍将替代当前调查队伍，但该关卡额外通关获得的特训值也会扣除（不影响奖励状态），是否确认重置？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20227_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20227_RightBtnDesc|确认"
  },
  ["20228"] = {
    ID = "20228",
    Type = 1,
    Desc = "TipsType_20228_Desc|向下滑动列表查看更多公告"
  },
  ["20229"] = {
    ID = "20229",
    Type = 2,
    Title = "TipsType_20229_Title|购买确认",
    Desc = "TipsType_20229_Desc|「<Blue:{s1}>」已达到叠位等级上限\n是否继续购买？\n剩余数量：{s2}",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20229_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20229_RightBtnDesc|确认"
  },
  ["20351"] = {
    ID = "20351",
    Type = 2,
    Title = "TipsType_20351_Title|{s1}不足",
    Desc = "TipsType_20351_Desc|{s1}不足，是否使用{s2}{s3}兑换{s4}{s5}",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20351_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20351_RightBtnDesc|确认"
  },
  ["20352"] = {
    ID = "20352",
    Type = 2,
    Title = "TipsType_20352_Title|邀请确认",
    Desc = "TipsType_20352_Desc|即将与对方绑定，绑定后无法解绑，确认要继续绑定吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20352_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20352_RightBtnDesc|确认"
  },
  ["20353"] = {
    ID = "20353",
    Type = 1,
    Desc = "TipsType_20353_Desc|邀请码已复制至剪切板。"
  },
  ["20354"] = {
    ID = "20354",
    Type = 1,
    Desc = "TipsType_20354_Desc|您已是对方的邀请人。"
  },
  ["20355"] = {
    ID = "20355",
    Type = 1,
    Desc = "TipsType_20355_Desc|不能输入自己的邀请码，尝试去获取其他守密人的邀请码吧。"
  },
  ["20356"] = {
    ID = "20356",
    Type = 2,
    Title = "TipsType_20356_Title|调查确认",
    Desc = "TipsType_20356_Desc|重新游玩可再次体验序章剧情与教学！\n但重新游玩时关卡内容所有奖励均为演示，无法真正获取奖励。\n是否确认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20356_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20356_RightBtnDesc|确认"
  },
  ["20217"] = {
    ID = "20217",
    Type = 1,
    Desc = "TipsType_20217_Desc|{s1}将在{s2}后开启。"
  },
  ["20218"] = {
    ID = "20218",
    Type = 1,
    Desc = "TipsType_20218_Desc|本次调查的预选唤醒体不可下场，只可替换为对应唤醒体"
  },
  ["20219"] = {
    ID = "20219",
    Type = 1,
    Desc = "TipsType_20219_Desc|已上阵相同唤醒体，不可重复选择。"
  },
  ["20230"] = {
    ID = "20230",
    Type = 8,
    Title = "TipsType_20230_Title|调查确认",
    Desc = "TipsType_20230_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20230_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20230_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117113, 117120}
  },
  ["20231"] = {
    ID = "20231",
    Type = 8,
    Title = "TipsType_20231_Title|调查确认",
    Desc = "TipsType_20231_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20231_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20231_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117127, 117120}
  },
  ["20232"] = {
    ID = "20232",
    Type = 8,
    Title = "TipsType_20232_Title|调查确认",
    Desc = "TipsType_20232_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20232_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20232_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117109, 117120}
  },
  ["20241"] = {
    ID = "20241",
    Type = 2,
    Title = "TipsType_20241_Title|购买确认",
    Desc = "TipsType_20241_Desc|还需{s1}个「<Blue:{s2}>」即可达到叠位等级上限\n是否继续购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20241_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20241_RightBtnDesc|确认"
  },
  ["20233"] = {
    ID = "20233",
    Type = 2,
    Title = "TipsType_20233_Title|补全确认",
    Desc = "TipsType_20233_Desc|当前所需材料不足，是否消耗以下材料进行补全？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20233_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20233_RightBtnDesc|确认"
  },
  ["20234"] = {
    ID = "20234",
    Type = 1,
    Desc = "TipsType_20234_Desc|该关卡只能装备指定钥令，无法进行替换。"
  },
  ["20259"] = {
    ID = "20259",
    Type = 1,
    Desc = "TipsType_20259_Desc|已保存「千面印章」不足时的置换设置"
  },
  ["20235"] = {
    ID = "20235",
    Type = 8,
    Title = "TipsType_20235_Title|调查确认",
    Desc = "TipsType_20235_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20235_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20235_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117110, 117105}
  },
  ["20236"] = {
    ID = "20236",
    Type = 8,
    Title = "TipsType_20236_Title|调查确认",
    Desc = "TipsType_20236_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20236_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20236_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117113}
  },
  ["20237"] = {
    ID = "20237",
    Type = 8,
    Title = "TipsType_20237_Title|调查确认",
    Desc = "TipsType_20237_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20237_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20237_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117097}
  },
  ["20238"] = {
    ID = "20238",
    Type = 8,
    Title = "TipsType_20238_Title|调查确认",
    Desc = "TipsType_20238_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20238_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20238_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117118, 117120}
  },
  ["20239"] = {
    ID = "20239",
    Type = 8,
    Title = "TipsType_20239_Title|调查确认",
    Desc = "TipsType_20239_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20239_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20239_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117124, 117120}
  },
  ["20250"] = {
    ID = "20250",
    Type = 8,
    Title = "TipsType_20250_Title|调查确认",
    Desc = "TipsType_20250_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20250_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20250_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117091}
  },
  ["20251"] = {
    ID = "20251",
    Type = 8,
    Title = "TipsType_20251_Title|调查确认",
    Desc = "TipsType_20251_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20251_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20251_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117096}
  },
  ["20252"] = {
    ID = "20252",
    Type = 8,
    Title = "TipsType_20252_Title|调查确认",
    Desc = "TipsType_20252_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20252_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20252_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117102}
  },
  ["20357"] = {
    ID = "20357",
    Type = 2,
    Title = "TipsType_20357_Title|取消关注",
    Desc = "TipsType_20357_Desc|确定不再关注这 {s1} 位守密人？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20357_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20357_RightBtnDesc|确认"
  },
  ["20358"] = {
    ID = "20358",
    Type = 2,
    Title = "TipsType_20358_Title|退出确认",
    Desc = "TipsType_20358_Desc|有未确认的取消关注，离开将不保存任何操作，是否离开？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_20358_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20358_RightBtnDesc|确认",
    DonotRemind = 1
  },
  ["20240"] = {
    ID = "20240",
    Type = 2,
    Title = "TipsType_20240_Title|温馨提示",
    Desc = "TipsType_20240_Desc|修复完成，请重新启动游戏",
    RightBtn = 2,
    RightBtnDesc = "TipsType_20240_RightBtnDesc|确认"
  },
  AlreadyIsBackgroundMusicTips = {
    ID = "AlreadyIsBackgroundMusicTips",
    Type = 1,
    Desc = "TipsType_AlreadyIsBackgroundMusicTips_Desc|已经是当前背景音乐"
  },
  EnterSix_DigitPasswordTips = {
    ID = "EnterSix_DigitPasswordTips",
    Type = 1,
    Desc = "TipsType_EnterSix_DigitPasswordTips_Desc|请输入 <color=#5EF2FF>相位值</color>"
  },
  Password_CopiedTips = {
    ID = "Password_CopiedTips",
    Type = 1,
    Desc = "TipsType_Password_CopiedTips_Desc|<color=#5EF2FF>相位值</color> 已复制到剪切板"
  },
  WaitOthersEnter = {
    ID = "WaitOthersEnter",
    Type = 2,
    Title = "TipsType_WaitOthersEnter_Title|密码对战",
    Desc = "TipsType_WaitOthersEnter_Desc|正在等待其他守密人输入\n <Blue:{s1}>\n匹配密码对战",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_WaitOthersEnter_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_WaitOthersEnter_RightBtnDesc|复制 <color=#5EF2FF>相位值</color>"
  },
  OppositeSideCancelMatchTips = {
    ID = "OppositeSideCancelMatchTips",
    Type = 1,
    Desc = "TipsType_OppositeSideCancelMatchTips_Desc|对方取消了匹配"
  },
  TryAgainLaterTips = {
    ID = "TryAgainLaterTips",
    Type = 1,
    Desc = "TipsType_TryAgainLaterTips_Desc|该 <color=#5EF2FF>相位值</color> 正在被使用，请稍后再试"
  },
  WaitOppositeSideAccept = {
    ID = "WaitOppositeSideAccept",
    Type = 2,
    Title = "TipsType_WaitOppositeSideAccept_Title|密码对战",
    Desc = "TipsType_WaitOppositeSideAccept_Desc|正在等待\n{s1}\n接受 <Blue:{s2}>的邀请",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_WaitOppositeSideAccept_LeftBtnDesc|取消"
  },
  AcceptConfirm = {
    ID = "AcceptConfirm",
    Type = 2,
    Title = "TipsType_AcceptConfirm_Title|密码对战",
    Desc = "TipsType_AcceptConfirm_Desc|是否接受 <Blue:{s1}>的 <Blue:{s2}>邀请？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_AcceptConfirm_LeftBtnDesc|拒绝",
    RightBtn = 2,
    RightBtnDesc = "TipsType_AcceptConfirm_RightBtnDesc|接受"
  },
  OppositeSideRejectTips = {
    ID = "OppositeSideRejectTips",
    Type = 1,
    Desc = "TipsType_OppositeSideRejectTips_Desc|对方拒绝了<Blue:{s1}>的邀请，请重新选择模式"
  },
  KeyShortNameDownLoadTips = {
    ID = "KeyShortNameDownLoadTips",
    Type = 1,
    Desc = "TipsType_KeyShortNameDownLoadTips_Desc|正在下载文本标识资源，请过一会再尝试查看"
  },
  SubBestExperienceTips_Chapter5 = {
    ID = "SubBestExperienceTips_Chapter5",
    Type = 8,
    Title = "TipsType_SubBestExperienceTips_Chapter5_Title|调查确认",
    Desc = "TipsType_SubBestExperienceTips_Chapter5_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117100, 117120}
  },
  SubBestExperienceTips_Chapter3 = {
    ID = "SubBestExperienceTips_Chapter3",
    Type = 8,
    Title = "TipsType_SubBestExperienceTips_Chapter3_Title|调查确认",
    Desc = "TipsType_SubBestExperienceTips_Chapter3_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117097, 117120}
  },
  SubBestExperienceTips_ChapterS2 = {
    ID = "SubBestExperienceTips_ChapterS2",
    Type = 8,
    Title = "TipsType_SubBestExperienceTips_ChapterS2_Title|调查确认",
    Desc = "TipsType_SubBestExperienceTips_ChapterS2_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117106, 117120}
  },
  BestExperienceTips_Chapter3 = {
    ID = "BestExperienceTips_Chapter3",
    Type = 8,
    Title = "TipsType_BestExperienceTips_Chapter3_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_Chapter3_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_Chapter3_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_Chapter3_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117097}
  },
  BestExperienceTips_Chapter7 = {
    ID = "BestExperienceTips_Chapter7",
    Type = 8,
    Title = "TipsType_BestExperienceTips_Chapter7_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_Chapter7_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_Chapter7_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_Chapter7_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117089}
  },
  BestExperienceTips_Chapter8 = {
    ID = "BestExperienceTips_Chapter8",
    Type = 8,
    Title = "TipsType_BestExperienceTips_Chapter8_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_Chapter8_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_Chapter8_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_Chapter8_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117109}
  },
  BestExperienceTips_ChapterS2 = {
    ID = "BestExperienceTips_ChapterS2",
    Type = 8,
    Title = "TipsType_BestExperienceTips_ChapterS2_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_ChapterS2_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_ChapterS2_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117106}
  },
  BestExperienceTips_ChapterS3 = {
    ID = "BestExperienceTips_ChapterS3",
    Type = 8,
    Title = "TipsType_BestExperienceTips_ChapterS3_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_ChapterS3_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_ChapterS3_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117127}
  },
  BestExperienceTips_ChapterS4 = {
    ID = "BestExperienceTips_ChapterS4",
    Type = 8,
    Title = "TipsType_BestExperienceTips_ChapterS4_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_ChapterS4_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_ChapterS4_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {120497}
  },
  BestExperienceTips_ChapterS5 = {
    ID = "BestExperienceTips_ChapterS5",
    Type = 8,
    Title = "TipsType_BestExperienceTips_ChapterS5_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_ChapterS5_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_ChapterS5_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {126370}
  },
  BestExperienceTips_TwoAnniversarySubStage = {
    ID = "BestExperienceTips_TwoAnniversarySubStage",
    Type = 8,
    Title = "TipsType_BestExperienceTips_TwoAnniversarySubStage_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {120993}
  },
  BestExperienceTips_MainStoryS1_6 = {
    ID = "BestExperienceTips_MainStoryS1_6",
    Type = 8,
    Title = "TipsType_BestExperienceTips_MainStoryS1_6_Title|调查确认",
    Desc = "TipsType_BestExperienceTips_MainStoryS1_6_Desc|为确保最佳剧情体验，建议完成以下调查关卡。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc|退出",
    RightBtn = 2,
    RightBtnDesc = "TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc|仍要调查",
    DonotRemind = 1,
    QuickJump = {117102, 118122}
  },
  PVP_PasswordBattle_BlockTips = {
    ID = "PVP_PasswordBattle_BlockTips",
    Type = 2,
    Title = "TipsType_PVP_PasswordBattle_BlockTips_Title|是否拉黑",
    Desc = "TipsType_PVP_PasswordBattle_BlockTips_Desc|是否需要拉黑这位守密人？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc|拒绝",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc|接受"
  },
  PVP_PasswordBattle_QuitTips = {
    ID = "PVP_PasswordBattle_QuitTips",
    Type = 2,
    Title = "TipsType_PVP_PasswordBattle_QuitTips_Title|退出确认",
    Desc = "TipsType_PVP_PasswordBattle_QuitTips_Desc|是否退出密码对战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc|退出"
  },
  PVP_PasswordBattle_RejectedTips = {
    ID = "PVP_PasswordBattle_RejectedTips",
    Type = 1,
    Desc = "TipsType_PVP_PasswordBattle_RejectedTips_Desc|对方拒绝了与你对战"
  },
  PVP_PasswordBattle_OthersEnterTips = {
    ID = "PVP_PasswordBattle_OthersEnterTips",
    Type = 1,
    Desc = "TipsType_PVP_PasswordBattle_OthersEnterTips_Desc|有新的守密人进入了本场密码对战"
  },
  PVP_PasswordBattle_QueueTips = {
    ID = "PVP_PasswordBattle_QueueTips",
    Type = 1,
    Desc = "TipsType_PVP_PasswordBattle_QueueTips_Desc|正在排队中……"
  },
  PVP_PasswordBattle_GameStartedTips = {
    ID = "PVP_PasswordBattle_GameStartedTips",
    Type = 1,
    Desc = "TipsType_PVP_PasswordBattle_GameStartedTips_Desc|本场密码对战已开始"
  },
  WeekChallengeSweepTips = {
    ID = "WeekChallengeSweepTips",
    Type = 1,
    Desc = "TipsType_WeekChallengeSweepTips_Desc|本周内获取奖励次数已耗尽，无法进行重现。"
  },
  CollectAwakerTips = {
    ID = "CollectAwakerTips",
    Type = 1,
    Desc = "TipsType_CollectAwakerTips_Desc|收藏成功"
  },
  CancelCollectAwakerTips = {
    ID = "CancelCollectAwakerTips",
    Type = 1,
    Desc = "TipsType_CancelCollectAwakerTips_Desc|已取消收藏"
  },
  PvpCollectionCommentDeleteTips = {
    ID = "PvpCollectionCommentDeleteTips",
    Type = 2,
    Title = "TipsType_PvpCollectionCommentDeleteTips_Title|删除确认",
    Desc = "TipsType_PvpCollectionCommentDeleteTips_Desc|是否删除该评论？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc|确认"
  },
  PVETeamShareCodeError = {
    ID = "PVETeamShareCodeError",
    Type = 1,
    Desc = "TipsType_PVETeamShareCodeError_Desc|未能正确识别到剪切板内有 <color=#5EF2FF>调查行动</color> 编队"
  },
  PVETeamShareCodeSaveTips = {
    ID = "PVETeamShareCodeSaveTips",
    Type = 2,
    Title = "TipsType_PVETeamShareCodeSaveTips_Title|保存确认",
    Desc = "TipsType_PVETeamShareCodeSaveTips_Desc|是否确认保存该编队码对应的队伍配置？\n未持有该配置的部分将会被空置。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVETeamShareCodeSaveTips_RightBtnDesc|确认"
  },
  PVETeamShareCodeCopyTips = {
    ID = "PVETeamShareCodeCopyTips",
    Type = 1,
    Desc = "TipsType_PVETeamShareCodeCopyTips_Desc|已复制到剪切板"
  },
  PVETeamShareCodeSpecialTeamAssignTips = {
    ID = "PVETeamShareCodeSpecialTeamAssignTips",
    Type = 1,
    Desc = "TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc|该队伍包含预设唤醒体，无法复制或导入编队码"
  },
  MainResetBG = {
    ID = "MainResetBG",
    Type = 2,
    Title = "TipsType_MainResetBG_Title|恢复默认",
    Desc = "TipsType_MainResetBG_Desc|是否需要将宿舍的背景<Blue:「画面」>与<Blue:「音乐」>恢复到默认？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_MainResetBG_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_MainResetBG_RightBtnDesc|确认"
  },
  ActivitySignRewardTaskNotCompleteTips = {
    ID = "ActivitySignRewardTaskNotCompleteTips",
    Type = 1,
    Desc = "TipsType_ActivitySignRewardTaskNotCompleteTips_Desc|完成对应任务即可进行唤醒"
  },
  ReplayNullTips = {
    ID = "ReplayNullTips",
    Type = 1,
    Desc = "TipsType_ReplayNullTips_Desc|回放信息不可为空"
  },
  PVEReplayMaxRounds = {
    ID = "PVEReplayMaxRounds",
    Type = 2,
    Title = "TipsType_PVEReplayMaxRounds_Title|结束确认",
    Desc = "TipsType_PVEReplayMaxRounds_Desc|回放已达到25回合的最大限制，\n回放结束。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVEReplayMaxRounds_RightBtnDesc|确认"
  },
  PVEReplayUnableOperateTips = {
    ID = "PVEReplayUnableOperateTips",
    Type = 1,
    Desc = "TipsType_PVEReplayUnableOperateTips_Desc|战斗回放中不可进行操作"
  },
  PVEReplayRepeatClickTips = {
    ID = "PVEReplayRepeatClickTips",
    Type = 1,
    Desc = "TipsType_PVEReplayRepeatClickTips_Desc|正在加载战斗回放，请勿重复操作"
  },
  PVEReplayTimeoutTips = {
    ID = "PVEReplayTimeoutTips",
    Type = 1,
    Desc = "TipsType_PVEReplayTimeoutTips_Desc|获取战斗回放超时"
  },
  PVPTeamShareCodeError = {
    ID = "PVPTeamShareCodeError",
    Type = 1,
    Desc = "TipsType_PVPTeamShareCodeError_Desc|未能正确识别到剪切板内有 <color=#5EF2FF>相位对弈</color> 编队"
  },
  PVEReplayErrorTips = {
    ID = "PVEReplayErrorTips",
    Type = 1,
    Desc = "TipsType_PVEReplayErrorTips_Desc|获取战斗回放错误，请稍后重试"
  },
  PVEReplaySpecialTeamAssignTips = {
    ID = "PVEReplaySpecialTeamAssignTips",
    Type = 1,
    Desc = "TipsType_PVEReplaySpecialTeamAssignTips_Desc|暂不支持特殊编队的战斗回放，敬请期待"
  },
  PVEReplayNoDataTips = {
    ID = "PVEReplayNoDataTips",
    Type = 1,
    Desc = "TipsType_PVEReplayNoDataTips_Desc|暂无调查行动记录"
  },
  PassportHoistTips1 = {
    ID = "PassportHoistTips1",
    Type = 7,
    Desc = "TipsType_PassportHoistTips1_Desc|「基础活性离子」\n·解锁后，本期课题持续期间在「日常试训」的「基础活性离子」累积奖励中获得的「现实起点」、「无垢之芯」、「经验」、「银芯」提升至 3 倍。购买「核心课题」后会补发本期已领取的「基础活性离子」累积奖励的额外倍率部分。"
  },
  PassportHoistTips2 = {
    ID = "PassportHoistTips2",
    Type = 7,
    Desc = "TipsType_PassportHoistTips2_Desc|「时序逆行」\n·可在战斗中返回经历过的回合。\n·可返回至战斗的前 25 回合中的任意一个回合。\n·重新挑战后依然可以使用逆行功能回到之前的回合。"
  },
  PassportHoistTips3 = {
    ID = "PassportHoistTips3",
    Type = 7,
    Desc = "TipsType_PassportHoistTips3_Desc|「相位对弈」\n·解锁后，本期课题持续期间可使用「相位对弈」全部卡牌。"
  },
  LimitAwakerEnlightenmentOverflowTips = {
    ID = "LimitAwakerEnlightenmentOverflowTips",
    Type = 2,
    Title = "TipsType_LimitAwakerEnlightenmentOverflowTips_Title|确认选择",
    Desc = "TipsType_LimitAwakerEnlightenmentOverflowTips_Desc|该唤醒体启灵已满\n选择后将仅获得「灵魂回溯碎片」× 2",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc|继续"
  },
  CommonUseBattleHelpLimitTips = {
    ID = "CommonUseBattleHelpLimitTips",
    Type = 1,
    Desc = "TipsType_CommonUseBattleHelpLimitTips_Desc|常用助战守密人已达上限，请调整常用助战列表"
  },
  PublishEmptyCommentTips = {
    ID = "PublishEmptyCommentTips",
    Type = 1,
    Desc = "TipsType_PublishEmptyCommentTips_Desc|评论内容不可为空"
  },
  DiskSpaceNotEnough = {
    ID = "DiskSpaceNotEnough",
    Type = 2,
    Desc = "TipsType_DiskSpaceNotEnough_Desc|存储空间不足，是否继续尝试下载？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_DiskSpaceNotEnough_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_DiskSpaceNotEnough_RightBtnDesc|确认"
  },
  PVPSurrenderConfirm = {
    ID = "PVPSurrenderConfirm",
    Type = 2,
    Title = "TipsType_PVPSurrenderConfirm_Title|投降确认",
    Desc = "TipsType_PVPSurrenderConfirm_Desc|是否投降？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PVPSurrenderConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVPSurrenderConfirm_RightBtnDesc|确认"
  },
  PvpHideCommentConfirm = {
    ID = "PvpHideCommentConfirm",
    Type = 2,
    Title = "TipsType_PvpHideCommentConfirm_Title|隐藏",
    Desc = "TipsType_PvpHideCommentConfirm_Desc|是否隐藏其所有评论？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PvpHideCommentConfirm_LeftBtnDesc|否",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PvpHideCommentConfirm_RightBtnDesc|是"
  },
  DoubleExBPBuyConfirm = {
    ID = "DoubleExBPBuyConfirm",
    Type = 2,
    Title = "TipsType_DoubleExBPBuyConfirm_Title|购买确认",
    Desc = "TipsType_DoubleExBPBuyConfirm_Desc|是否消耗<Blue:「源液」× {s1} >购买？\n <color=#ACBFCA>本期为特殊课题，核心课题的价格降低</color>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_DoubleExBPBuyConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_DoubleExBPBuyConfirm_RightBtnDesc|购买"
  },
  MultiSelectBox_FixItemTips = {
    ID = "MultiSelectBox_FixItemTips",
    Type = 1,
    Desc = "TipsType_MultiSelectBox_FixItemTips_Desc|固定获得物品，不可更改"
  },
  MultiSelectBox_SelectTips = {
    ID = "MultiSelectBox_SelectTips",
    Type = 1,
    Desc = "TipsType_MultiSelectBox_SelectTips_Desc|请完成所有自选物品选择后，才可进行购买"
  },
  FollowBackConfirm = {
    ID = "FollowBackConfirm",
    Type = 2,
    Title = "TipsType_FollowBackConfirm_Title|回关确认",
    Desc = "TipsType_FollowBackConfirm_Desc|确定对当前页的 <color=#5EF2FF>{s1}</color> 名追随者进行关注？\n\n<color=#96947F>当前关注 </color>{s2}<color=#A0A0A0>/{s3}\n超出上限之后将无法关注</color>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_FollowBackConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_FollowBackConfirm_RightBtnDesc|确认"
  },
  SchoolConflictTips = {
    ID = "SchoolConflictTips",
    Type = 1,
    Desc = "TipsType_SchoolConflictTips_Desc|队伍中唤醒体存在界域冲突，请进行调整。"
  },
  RailWaySaveAndExitTips = {
    ID = "RailWaySaveAndExitTips",
    Type = 2,
    Title = "TipsType_RailWaySaveAndExitTips_Title|保存并退出",
    Desc = "TipsType_RailWaySaveAndExitTips_Desc|是否确认退出挑战?\n本次挑战进度将会被保存，下次挑战时会以当前进度继续进行。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_RailWaySaveAndExitTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_RailWaySaveAndExitTips_RightBtnDesc|确认"
  },
  RailWayHaveSaveStage = {
    ID = "RailWayHaveSaveStage",
    Type = 1,
    Desc = "TipsType_RailWayHaveSaveStage_Desc|需要结束上次保存的挑战后才可进行新的挑战"
  },
  RailWayContinueSaveStage = {
    ID = "RailWayContinueSaveStage",
    Type = 2,
    Title = "TipsType_RailWayContinueSaveStage_Title|继续挑战",
    Desc = "TipsType_RailWayContinueSaveStage_Desc|上次挑战进度为 {s1} - 第 {s2} 阶段 - 第 {s3} 场战斗，已获得「贵宾积分」× {s4}\n是否要继续挑战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_RailWayContinueSaveStage_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_RailWayContinueSaveStage_RightBtnDesc|确认"
  },
  RailWaySaveAndExitInBattleTips = {
    ID = "RailWaySaveAndExitInBattleTips",
    Type = 2,
    Title = "TipsType_RailWaySaveAndExitInBattleTips_Title|保存并退出",
    Desc = "TipsType_RailWaySaveAndExitInBattleTips_Desc|是否确认退出挑战?\n本次挑战进度将会被保存，下次挑战时会以当前进度继续进行，并重开本场战斗。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc|确认"
  },
  RailWayContinueReconnectSeasonSwitchTips = {
    ID = "RailWayContinueReconnectSeasonSwitchTips",
    Type = 2,
    Title = "TipsType_RailWayContinueReconnectSeasonSwitchTips_Title|提示",
    Desc = "TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc|尚在战斗中，是否继续之前的战斗？ \n「疾驰的欢愉专列」赛季已更新。继续挑战可完成最新赛季任务，但无法进入「贵宾名录」。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc|确认"
  },
  RailWayContinueSaveStageSeasonSwitchTips = {
    ID = "RailWayContinueSaveStageSeasonSwitchTips",
    Type = 2,
    Title = "TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title|继续挑战",
    Desc = "TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc|上次挑战进度为 {s1} - 第 {s2} 阶段 - 第 {s3} 场战斗，已获得「贵宾积分」× {s4}\n赛季已更新。继续挑战可完成最新赛季任务，但无法进入「贵宾名录」。是否要继续挑战？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc|确认"
  },
  RailWaySeasonSwitchTips = {
    ID = "RailWaySeasonSwitchTips",
    Type = 1,
    Desc = "TipsType_RailWaySeasonSwitchTips_Desc|赛季已更新。继续挑战可完成最新赛季任务，但无法进入「贵宾名录」。"
  },
  InCharging = {
    ID = "InCharging",
    Type = 2,
    Title = "TipsType_InCharging_Title|温馨提示",
    Desc = "TipsType_InCharging_Desc|订单处理中，请勿重复支付。\n若支付已完成，请耐心等待系统发放奖励。\n若支付未完成，请尝试重启游戏后重试。\n如有疑问，请联系客服。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_InCharging_RightBtnDesc|确认"
  },
  SummonType_14SelectConfirm = {
    ID = "SummonType_14SelectConfirm",
    Type = 2,
    Title = "TipsType_SummonType_14SelectConfirm_Title|确认选择",
    Desc = "TipsType_SummonType_14SelectConfirm_Desc|是否确认选择唤醒体<OrangeQuality:「{s1}」、「{s2}」、「{s3}」、「{s4}」>作为本期活动的定向UP？",
    BottomDesc = "TipsType_SummonType_14SelectConfirm_BottomDesc|<Blue:注意：一旦选定，本次活动无法再更改！>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_SummonType_14SelectConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SummonType_14SelectConfirm_RightBtnDesc|确认"
  },
  SummonType_14SelectLimitTips = {
    ID = "SummonType_14SelectLimitTips",
    Type = 1,
    Desc = "TipsType_SummonType_14SelectLimitTips_Desc|已达到选择数量上限",
    BottomDesc = "TipsType_SummonType_14SelectLimitTips_BottomDesc|<Blue:注意：一旦选定，本次活动无法再更改！>"
  },
  ["100100"] = {
    ID = "100100",
    Type = 2,
    Title = "TipsType_100100_Title|更新提示",
    Desc = "TipsType_100100_Desc|游戏当前有版本更新，若未自动更新，请尝试重启 Steam 后检查更新。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_100100_RightBtnDesc|确认"
  },
  FilterMaxAwakerCountTips = {
    ID = "FilterMaxAwakerCountTips",
    Type = 1,
    Desc = "TipsType_FilterMaxAwakerCountTips_Desc|最多选择 {s1} 名唤醒体进行筛选"
  },
  SummonFailureTips = {
    ID = "SummonFailureTips",
    Type = 1,
    Desc = "TipsType_SummonFailureTips_Desc|唤醒消耗材料信息变化，请重新唤醒"
  },
  SummonPriorityNotEnoughTips = {
    ID = "SummonPriorityNotEnoughTips",
    Type = 2,
    Title = "TipsType_SummonPriorityNotEnoughTips_Title|兑换确认",
    Desc = "TipsType_SummonPriorityNotEnoughTips_Desc|缺少 {s1} 个<Blue:「{s2}」>，是否消耗<Blue:「{s4}」×{s3} >代替？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SummonPriorityNotEnoughTips_RightBtnDesc|确认",
    DonotRemind = 1
  },
  SocialRecordHideTips = {
    ID = "SocialRecordHideTips",
    Type = 1,
    Desc = "TipsType_SocialRecordHideTips_Desc|战斗记录被隐藏"
  },
  ServerRankDataLoading = {
    ID = "ServerRankDataLoading",
    Type = 2,
    Title = "TipsType_ServerRankDataLoading_Title|服务器排行榜数据初始化中",
    Desc = "TipsType_ServerRankDataLoading_Desc|该榜单数据尚未加载完成，请稍后重新打开界面。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_ServerRankDataLoading_RightBtnDesc|确认"
  },
  DiskIsFullOrViolation = {
    ID = "DiskIsFullOrViolation",
    Type = 2,
    Desc = "TipsType_DiskIsFullOrViolation_Desc|文件写入失败，请检查设备剩余存储空间是否充足",
    RightBtn = 2,
    RightBtnDesc = "TipsType_DiskIsFullOrViolation_RightBtnDesc|确认"
  },
  AwakerNotOpenTips = {
    ID = "AwakerNotOpenTips",
    Type = 1,
    Desc = "TipsType_AwakerNotOpenTips_Desc|唤醒体暂未到开放时间，敬请期待"
  },
  PayMoneyBuyConfirmDescDetail = {
    ID = "PayMoneyBuyConfirmDescDetail",
    Type = 2,
    Title = "TipsType_PayMoneyBuyConfirmDescDetail_Title|购买确认",
    Desc = "TipsType_PayMoneyBuyConfirmDescDetail_Desc|是否消耗<Blue:「源液」× {s1} >购买？\n\n<size=30><color=#ACBFCA>消耗「源液」时，优先扣除赠送的「源液」。\n（提取：{s2}，赠送：{s3}）</color></size>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc|购买"
  },
  BattlePassAllCompleteTips = {
    ID = "BattlePassAllCompleteTips",
    Type = 1,
    Desc = "TipsType_BattlePassAllCompleteTips_Desc|当前守密纪行已全部完成。"
  },
  SteamOverlayEnabledTips = {
    ID = "SteamOverlayEnabledTips",
    Type = 2,
    Title = "TipsType_SteamOverlayEnabledTips_Title|温馨提示",
    Desc = "TipsType_SteamOverlayEnabledTips_Desc|请在 Steam「设置-游戏中」及本游戏「属性-通用」中开启「在游戏中启用 Steam 叠加界面」，完成后重新启动游戏再次尝试。",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_SteamOverlayEnabledTips_LeftBtnDesc|确认"
  },
  GnosticPotentialUpgradeConfirm = {
    ID = "GnosticPotentialUpgradeConfirm",
    Type = 2,
    Title = "TipsType_GnosticPotentialUpgradeConfirm_Title|强化确认",
    Desc = "TipsType_GnosticPotentialUpgradeConfirm_Desc|此操作将消耗大量资源，适合想将唤醒体的能力培养到极限的情况，确认强化「内在灵格」吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc|确认",
    DonotRemind = 1
  },
  SupportListLatestTips = {
    ID = "SupportListLatestTips",
    Type = 1,
    Desc = "TipsType_SupportListLatestTips_Desc|已是最新状态，快去关注更多校友获得更多助战选择吧！"
  },
  FrenziedOmenUpgradeConfirm = {
    ID = "FrenziedOmenUpgradeConfirm",
    Type = 2,
    Title = "TipsType_FrenziedOmenUpgradeConfirm_Title|强化确认",
    Desc = "TipsType_FrenziedOmenUpgradeConfirm_Desc|此操作将消耗大量资源，适合想将唤醒体的能力培养到极限的情况，确认强化「疯狂预兆」吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc|确认",
    DonotRemind = 1
  },
  PvpMatchingInterruptTips = {
    ID = "PvpMatchingInterruptTips",
    Type = 1,
    Desc = "TipsType_PvpMatchingInterruptTips_Desc|检测到网络异常，匹配中断。"
  },
  SelectedAwakensAndCardsExceedLimit = {
    ID = "SelectedAwakensAndCardsExceedLimit",
    Type = 1,
    Desc = "TipsType_SelectedAwakensAndCardsExceedLimit_Desc|超过了选定数量"
  },
  AwakerAutoInsertCoinNotEnoughTips = {
    ID = "AwakerAutoInsertCoinNotEnoughTips",
    Type = 1,
    Desc = "TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc|「蔷薇金券」不足以完整使用当前拥有的「灵知制剂」，可补充「蔷薇金券」后再尝试。"
  },
  AwakerRandomChestConfirm = {
    ID = "AwakerRandomChestConfirm",
    Type = 2,
    Title = "TipsType_AwakerRandomChestConfirm_Title|使用确认",
    Desc = "TipsType_AwakerRandomChestConfirm_Desc|确认消耗 <Blue:{s1}>，获得1个<Blue:随机>唤醒体吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_AwakerRandomChestConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_AwakerRandomChestConfirm_RightBtnDesc|确认"
  },
  WeaponRandomChestConfirm = {
    ID = "WeaponRandomChestConfirm",
    Type = 2,
    Title = "TipsType_WeaponRandomChestConfirm_Title|使用确认",
    Desc = "TipsType_WeaponRandomChestConfirm_Desc|确认消耗 <Blue:{s1}>，获得1个<Blue:随机>命轮吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_WeaponRandomChestConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_WeaponRandomChestConfirm_RightBtnDesc|确认"
  },
  BattleCreateFail = {
    ID = "BattleCreateFail",
    Type = 1,
    Desc = "TipsType_BattleCreateFail_Desc|战斗创建失败"
  },
  ShopBulkBuyConfirm = {
    ID = "ShopBulkBuyConfirm",
    Type = 2,
    Title = "TipsType_ShopBulkBuyConfirm_Title|兑换确认",
    Desc = "TipsType_ShopBulkBuyConfirm_Desc|将使用 <Blue:{s1}> 个{s2}，兑换 <Blue:{s3}> 个{s4}，确认进行兑换吗？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_ShopBulkBuyConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_ShopBulkBuyConfirm_RightBtnDesc|确认"
  },
  PVEExceedMaxRoundsTips = {
    ID = "PVEExceedMaxRoundsTips",
    Type = 2,
    Title = "TipsType_PVEExceedMaxRoundsTips_Title|调查失败",
    Desc = "TipsType_PVEExceedMaxRoundsTips_Desc|战斗回合数已达上限\n\n唯一的守密人啊\n接下来你该如何选择？",
    LeftBtn = 2,
    LeftBtnDesc = "TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc|重新战斗",
    RightBtn = 1,
    RightBtnDesc = "TipsType_PVEExceedMaxRoundsTips_RightBtnDesc|暂时撤退"
  },
  PVPExceedMaxRoundsTips_Winner = {
    ID = "PVPExceedMaxRoundsTips_Winner",
    Type = 2,
    Title = "TipsType_PVPExceedMaxRoundsTips_Winner_Title|对战结束",
    Desc = "TipsType_PVPExceedMaxRoundsTips_Winner_Desc|对局已达回合上限，后手方成功坚守至终局，判为胜利。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc|确认"
  },
  PVPExceedMaxRoundsTips_Loser = {
    ID = "PVPExceedMaxRoundsTips_Loser",
    Type = 2,
    Title = "TipsType_PVPExceedMaxRoundsTips_Loser_Title|对战结束",
    Desc = "TipsType_PVPExceedMaxRoundsTips_Loser_Desc|对局已达回合上限，先手方未能终结对局，判为失败。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc|确认"
  },
  CoinBulkBuyConfirm = {
    ID = "CoinBulkBuyConfirm",
    Type = 2,
    Title = "TipsType_CoinBulkBuyConfirm_Title|购买确认",
    Desc = "TipsType_CoinBulkBuyConfirm_Desc|是否消耗「蔷薇金券」× {s1} 进行购买？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_CoinBulkBuyConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_CoinBulkBuyConfirm_RightBtnDesc|确认"
  },
  SteamRestartTips = {
    ID = "SteamRestartTips",
    Type = 2,
    Title = "TipsType_SteamRestartTips_Title|登录异常",
    Desc = "TipsType_SteamRestartTips_Desc|Steam 授权异常，请重启 Steam 客户端后重试",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SteamRestartTips_RightBtnDesc|确认"
  },
  AbyssChallengeResetTips = {
    ID = "AbyssChallengeResetTips",
    Type = 2,
    Title = "TipsType_AbyssChallengeResetTips_Title|提示",
    Desc = "TipsType_AbyssChallengeResetTips_Desc|融灾禁区已重置，正在进行中的挑战将立即结束。",
    RightBtn = 2,
    RightBtnDesc = "TipsType_AbyssChallengeResetTips_RightBtnDesc|确认"
  },
  TrinketBindTips = {
    ID = "TrinketBindTips",
    Type = 2,
    Title = "TipsType_TrinketBindTips_Title|结合确认",
    Desc = "TipsType_TrinketBindTips_Desc|确认结合以下密契？已被其他唤醒体装备或在编队/方案/助战中存在的密契将被自动卸下。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketBindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketBindTips_RightBtnDesc|确认"
  },
  TrinketUnbindTips = {
    ID = "TrinketUnbindTips",
    Type = 2,
    Title = "TipsType_TrinketUnbindTips_Title|析离确认",
    Desc = "TipsType_TrinketUnbindTips_Desc|确认析离该密契？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketUnbindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketUnbindTips_RightBtnDesc|确认"
  },
  TrinketChangeBindTips = {
    ID = "TrinketChangeBindTips",
    Type = 2,
    Title = "TipsType_TrinketChangeBindTips_Title|修改结合确认",
    Desc = "TipsType_TrinketChangeBindTips_Desc|确认修改结合？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketChangeBindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketChangeBindTips_RightBtnDesc|确认"
  },
  TrinketBatchUnbindTips = {
    ID = "TrinketBatchUnbindTips",
    Type = 2,
    Title = "TipsType_TrinketBatchUnbindTips_Title|析离确认",
    Desc = "TipsType_TrinketBatchUnbindTips_Desc|是否析离所有密契？",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketBatchUnbindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketBatchUnbindTips_RightBtnDesc|确认"
  },
  TrinketHighLevelUnbindTips = {
    ID = "TrinketHighLevelUnbindTips",
    Type = 2,
    Title = "TipsType_TrinketHighLevelUnbindTips_Title|析离确认",
    Desc = "TipsType_TrinketHighLevelUnbindTips_Desc|确认析离该密契？\n\n<color=#9BA3A2><size=30>所选素材中含有 +12 密契部件。</size></color>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketHighLevelUnbindTips_RightBtnDesc|确认"
  },
  TrinketHighLevelChangeBindTips = {
    ID = "TrinketHighLevelChangeBindTips",
    Type = 2,
    Title = "TipsType_TrinketHighLevelChangeBindTips_Title|修改结合确认",
    Desc = "TipsType_TrinketHighLevelChangeBindTips_Desc|确认修改结合？\n\n<color=#9BA3A2><size=30>所选素材中含有 +12 密契部件。</size></color>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc|确认"
  },
  TrinketHighLevelBatchUnbindTips = {
    ID = "TrinketHighLevelBatchUnbindTips",
    Type = 2,
    Title = "TipsType_TrinketHighLevelBatchUnbindTips_Title|析离确认",
    Desc = "TipsType_TrinketHighLevelBatchUnbindTips_Desc|是否析离所有密契？\n\n<color=#9BA3A2><size=30>所选素材中含有 +12 密契部件。</size></color>",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc|确认"
  },
  TrinketBagFullTips = {
    ID = "TrinketBagFullTips",
    Type = 1,
    Desc = "TipsType_TrinketBagFullTips_Desc|密契背包已满"
  },
  TrinketBindSaveTips = {
    ID = "TrinketBindSaveTips",
    Type = 1,
    Desc = "TipsType_TrinketBindSaveTips_Desc|存在被结合的密契，无法保存为方案！"
  },
  TrinketAutoRefineTips = {
    ID = "TrinketAutoRefineTips",
    Type = 2,
    Title = "TipsType_TrinketAutoRefineTips_Title|自动转录确认",
    Desc = "TipsType_TrinketAutoRefineTips_Desc|至多转录 {s1} 次\n至多消耗",
    BottomDesc = "TipsType_TrinketAutoRefineTips_BottomDesc|（自动转录至一条未锁定属性强度为8时停止。）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_TrinketAutoRefineTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_TrinketAutoRefineTips_RightBtnDesc|确认"
  },
  TrinketAutoRefineExitTips = {
    ID = "TrinketAutoRefineExitTips",
    Type = 1,
    Desc = "TipsType_TrinketAutoRefineExitTips_Desc|正在进行自动转录，无法进行操作。"
  },
  SummonType_17IncompleteSelectionTips = {
    ID = "SummonType_17IncompleteSelectionTips",
    Type = 1,
    Desc = "TipsType_SummonType_17IncompleteSelectionTips_Desc|请先完成所有类型的选择后再尝试吧"
  },
  SummonType_17SelectConfirm = {
    ID = "SummonType_17SelectConfirm",
    Type = 2,
    Title = "TipsType_SummonType_17SelectConfirm_Title|确认选择",
    Desc = "TipsType_SummonType_17SelectConfirm_Desc|确认完成本期指定唤醒体选择？\n确认后，本期选择将无法再次更改。",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_SummonType_17SelectConfirm_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_SummonType_17SelectConfirm_RightBtnDesc|确认"
  },
  AbyssChallengeRevivalTips = {
    ID = "AbyssChallengeRevivalTips",
    Type = 2,
    Title = "TipsType_AbyssChallengeRevivalTips_Title|复活确认",
    Desc = "TipsType_AbyssChallengeRevivalTips_Desc|银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗 {s1} 个应急灵知体，应急灵知体每日 9 点自动获得 1 个）",
    LeftBtn = 1,
    LeftBtnDesc = "TipsType_AbyssChallengeRevivalTips_LeftBtnDesc|取消",
    RightBtn = 2,
    RightBtnDesc = "TipsType_AbyssChallengeRevivalTips_RightBtnDesc|确认"
  }
})
return TipsType
