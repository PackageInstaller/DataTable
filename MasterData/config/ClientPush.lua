local System = require("System.System")
local readonly = System.readonly
local ClientPush = readonly({
  [18731] = {
    ID = 18731,
    CnID = "推送@体力满",
    BaseSortID = 1,
    Title = "ClientPush_18731_Title|灵啡肽补充完毕",
    Body = "ClientPush_18731_Body|灵啡肽已补充完毕，继续您的调查之旅吧。",
    Trigger = "EnergyFull",
    Interval = 3
  },
  [18736] = {
    ID = 18736,
    CnID = "推送@委派任务完成",
    BaseSortID = 2,
    Title = "ClientPush_18736_Title|派遣任务完成",
    Body = "ClientPush_18736_Body|有已完成的派遣任务，尽快查验任务成果吧。",
    Trigger = "TaskFinish",
    Interval = 3
  },
  [18734] = {
    ID = 18734,
    CnID = "推送@资源可领取",
    BaseSortID = 3,
    Title = "ClientPush_18734_Title|资源可领取",
    Body = "ClientPush_18734_Body|研究中心有资源准备完毕了，快来领取吧。",
    Trigger = "ResourceCollect",
    Interval = 3
  },
  [18735] = {
    ID = 18735,
    CnID = "推送@离线24个小时",
    BaseSortID = 4,
    Title = "ClientPush_18735_Title|弥萨格通信",
    Body = "ClientPush_18735_Body|守密人，一切都好吗？大家在等着你传来的好消息。",
    Trigger = "OfflineXHours",
    TriggerArgs = {24}
  },
  [18733] = {
    ID = 18733,
    CnID = "推送@离线48个小时",
    BaseSortID = 5,
    Title = "ClientPush_18733_Title|弥萨格通信",
    Body = "ClientPush_18733_Body|守密人，任务执行得还顺利吗？拉蒙娜已经做好了启程的准备，正在等待你加入下一次调查。",
    Trigger = "OfflineXHours",
    TriggerArgs = {48}
  },
  [18732] = {
    ID = 18732,
    CnID = "推送@离线72个小时",
    BaseSortID = 6,
    Title = "ClientPush_18732_Title|弥萨格通信",
    Body = "ClientPush_18732_Body|守密人，你已经很久没回弥萨格报到了，大家都很想见到你。",
    Trigger = "OfflineXHours",
    TriggerArgs = {72}
  }
})
return ClientPush
