local t = {
  ["com.bb.aos.3000monthcard1"] = {
    DailyAwardId = 900021,
    Desc = "*有效期持续30天\n累计可获得300楔石和3000楔石碎片",
    DropId = 11005,
    Duration = 30,
    ExpireMailId = 2,
    Limit = 180,
    Name = "月卡-补给包",
    NormalAwardGroupId = 90001,
    SDKDesc = "月卡-补给包",
    ShowPrice = 30,
    SpineId = 101,
    Tips = "【月卡补给包介绍】\n1.购买一次月卡-补给包，会立即获得300楔石与持续30天的月卡生效时间\n2.月卡生效期间，每日可领取90铂金币（每日凌晨5点更新）\n3.若当前月卡尚未生效，则购买月卡后会立即获得今日月卡奖励；此后月卡生效期间每天可在每日签到处获得今日月卡奖励\n\n【注意事项】\n1.当月卡剩余天数≤150天，可累计购买月卡补给包，总生效时间将延长\n2.当月卡剩余天数>150天，将不可再进行购买月卡\n3.玩家在月卡生效期间如因未登陆而未领取的奖励，将不会返还",
    Type = 1,
    sdkkey = {
      "tc.bb.3000monthcard1",
      "com.bb.aos.3000monthcard1",
      "com.bb.ios.3000monthcard1"
    }
  },
  ["com.bb.ios.3000monthcard1"] = nil,
  ["tc.bb.3000monthcard1"] = nil
}
t["com.bb.ios.3000monthcard1"] = t["com.bb.aos.3000monthcard1"]
t["tc.bb.3000monthcard1"] = t["com.bb.aos.3000monthcard1"]
return t
