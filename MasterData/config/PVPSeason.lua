local System = require("System.System")
local readonly = System.readonly
local PVPSeason = readonly({
  [16737] = {
    ID = 16737,
    CnID = "PVP赛季@第1期",
    BaseSortID = 1,
    Name = "PVPSeason_16737_Name|S1：忘却前夜",
    StartTime = 1697662800
  },
  [16524] = {
    ID = 16524,
    CnID = "PVP赛季@第2期",
    BaseSortID = 2,
    Name = "PVPSeason_16524_Name|S2：生命的余影",
    StartTime = 1704920400,
    IsNoRankAward = 1
  },
  [16411] = {
    ID = 16411,
    CnID = "PVP赛季@第3期",
    BaseSortID = 3,
    Name = "PVPSeason_16411_Name|S3：倒错的群星",
    StartTime = 1708549200,
    IsNoRankAward = 1
  },
  [16775] = {
    ID = 16775,
    CnID = "PVP赛季@第4期",
    BaseSortID = 4,
    Name = "PVPSeason_16775_Name|S4：灵魂的牧人",
    StartTime = 1712192400,
    IsNoRankAward = 1
  },
  [16669] = {
    ID = 16669,
    CnID = "PVP赛季@第5期",
    BaseSortID = 5,
    Name = "PVPSeason_16669_Name|S4*：多重疗愈",
    StartTime = 1714179600,
    IsNoRankAward = 1,
    SeasonTaskList = {
      46823,
      46822,
      46821,
      46846
    }
  },
  [16466] = {
    ID = 16466,
    CnID = "PVP赛季@第6期",
    BaseSortID = 6,
    Name = "PVPSeason_16466_Name|S5：欲海翻波",
    StartTime = 1715994000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      46854,
      46852,
      46853,
      46850
    }
  },
  [16353] = {
    ID = 16353,
    CnID = "PVP赛季@第7期",
    BaseSortID = 7,
    Name = "PVPSeason_16353_Name|S6：沉渊之祀",
    StartTime = 1718586000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      49246,
      49248,
      49247,
      49245
    }
  },
  [16489] = {
    ID = 16489,
    CnID = "PVP赛季@第8期",
    BaseSortID = 8,
    Name = "PVPSeason_16489_Name|S7：玫瑰的栖居",
    StartTime = 1721005200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      49241,
      49242,
      49243,
      49244
    }
  },
  [16382] = {
    ID = 16382,
    CnID = "PVP赛季@第9期",
    BaseSortID = 9,
    Name = "PVPSeason_16382_Name|S8：名侦探手册",
    StartTime = 1723424400,
    IsNoRankAward = 1,
    SeasonTaskList = {
      54546,
      54557,
      54549,
      54548
    }
  },
  [16760] = {
    ID = 16760,
    CnID = "PVP赛季@第10期",
    BaseSortID = 10,
    Name = "PVPSeason_16760_Name|S9：无形交响",
    StartTime = 1725843600,
    IsNoRankAward = 1,
    SeasonTaskList = {
      54555,
      54553,
      54554,
      54556
    }
  },
  [16746] = {
    ID = 16746,
    CnID = "PVP赛季@第11期",
    BaseSortID = 11,
    Name = "PVPSeason_16746_Name|S10：雪山消融之时",
    StartTime = 1728262800,
    IsNoRankAward = 1,
    SeasonTaskList = {
      54542,
      54544,
      54543,
      54545
    }
  },
  [16506] = {
    ID = 16506,
    CnID = "PVP赛季@第12期",
    BaseSortID = 12,
    Name = "PVPSeason_16506_Name|S11：终末的交响",
    StartTime = 1730682000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      54550,
      54551,
      54552,
      54547
    }
  },
  [16609] = {
    ID = 16609,
    CnID = "PVP赛季@第13期",
    BaseSortID = 13,
    Name = "PVPSeason_16609_Name|S12：亘古痴愚之梦",
    StartTime = 1733101200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      68860,
      68862,
      68861,
      68863
    }
  },
  [16590] = {
    ID = 16590,
    CnID = "PVP赛季@第14期",
    BaseSortID = 14,
    Name = "PVPSeason_16590_Name|S13：未竟轮回之志",
    StartTime = 1735520400,
    IsNoRankAward = 1,
    SeasonTaskList = {
      68866,
      68864,
      68865,
      68867
    }
  },
  [16685] = {
    ID = 16685,
    CnID = "PVP赛季@第15期",
    BaseSortID = 15,
    Name = "PVPSeason_16685_Name|S14：毁损灰雾之都",
    StartTime = 1739149200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      73585,
      73587,
      73586,
      73584
    }
  },
  [16442] = {
    ID = 16442,
    CnID = "PVP赛季@第16期",
    BaseSortID = 16,
    Name = "PVPSeason_16442_Name|S15：频段异声",
    StartTime = 1741568400,
    IsNoRankAward = 1,
    SeasonTaskList = {
      77675,
      77676,
      77677,
      77674
    }
  },
  [16547] = {
    ID = 16547,
    CnID = "PVP赛季@第17期",
    BaseSortID = 17,
    Name = "PVPSeason_16547_Name|S16：窥视灵魂之旅",
    StartTime = 1743987600,
    IsNoRankAward = 1,
    SeasonTaskList = {
      80436,
      80435,
      80434,
      80433
    }
  },
  [16750] = {
    ID = 16750,
    CnID = "PVP赛季@第18期",
    BaseSortID = 18,
    Name = "PVPSeason_16750_Name|S17：于暴雨中摇曳",
    StartTime = 1746406800,
    IsNoRankAward = 1,
    SeasonTaskList = {
      84325,
      84323,
      84324,
      84326
    }
  },
  [16508] = {
    ID = 16508,
    CnID = "PVP赛季@第19期",
    BaseSortID = 19,
    Name = "PVPSeason_16508_Name|S18：镜像囚徒",
    StartTime = 1748826000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      90039,
      90037,
      90036,
      90038
    }
  },
  [16385] = {
    ID = 16385,
    CnID = "PVP赛季@第20期",
    BaseSortID = 20,
    Name = "PVPSeason_16385_Name|S19：伟大的征服",
    StartTime = 1751245200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      91436,
      91437,
      91438,
      91439
    }
  },
  [16628] = {
    ID = 16628,
    CnID = "PVP赛季@第21期",
    BaseSortID = 21,
    Name = "PVPSeason_16628_Name|S20：王邸的夜宴",
    StartTime = 1753059600,
    IsNoRankAward = 1,
    SeasonTaskList = {
      96336,
      96334,
      96335,
      96333
    }
  },
  [16587] = {
    ID = 16587,
    CnID = "PVP赛季@第22期",
    BaseSortID = 22,
    Name = "PVPSeason_16587_Name|S21：不朽极昼",
    StartTime = 1755478800,
    IsNoRankAward = 1,
    SeasonTaskList = {
      98350,
      98348,
      98349,
      98347
    }
  },
  [16488] = {
    ID = 16488,
    CnID = "PVP赛季@第23期",
    BaseSortID = 23,
    Name = "PVPSeason_16488_Name|S22：畸世绘",
    StartTime = 1757293200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      100331,
      100334,
      100333,
      100332
    }
  },
  [16449] = {
    ID = 16449,
    CnID = "PVP赛季@第24期",
    BaseSortID = 24,
    Name = "PVPSeason_16449_Name|S23：如果一切如常",
    StartTime = 1759712400,
    IsNoRankAward = 1,
    SeasonTaskList = {
      116794,
      116793,
      116795,
      116796
    }
  },
  [16716] = {
    ID = 16716,
    CnID = "PVP赛季@第25期",
    BaseSortID = 25,
    Name = "PVPSeason_16716_Name|S24：极昼的终夜",
    StartTime = 1760922000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      117304,
      117306,
      117305,
      117307
    }
  },
  [16648] = {
    ID = 16648,
    CnID = "PVP赛季@第26期",
    BaseSortID = 26,
    Name = "PVPSeason_16648_Name|S25：永世虚妄巡礼",
    StartTime = 1763341200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      120969,
      120966,
      120967,
      120968
    }
  },
  [16553] = {
    ID = 16553,
    CnID = "PVP赛季@第27期",
    BaseSortID = 27,
    Name = "PVPSeason_16553_Name|S26：孽宴狂欲",
    StartTime = 1765760400,
    IsNoRankAward = 1,
    SeasonTaskList = {
      123491,
      123488,
      123489,
      123490
    }
  },
  [16504] = {
    ID = 16504,
    CnID = "PVP赛季@第28期",
    BaseSortID = 28,
    Name = "PVPSeason_16504_Name|S27：雾境的燔礼",
    StartTime = 1766970000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      124216,
      124214,
      124217,
      124215
    }
  },
  [16743] = {
    ID = 16743,
    CnID = "PVP赛季@第29期",
    BaseSortID = 29,
    Name = "PVPSeason_16743_Name|S28：海城旧闻",
    StartTime = 1769389200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      125502,
      125503,
      125500,
      125501
    }
  },
  [16458] = {
    ID = 16458,
    CnID = "PVP赛季@第30期",
    BaseSortID = 30,
    Name = "PVPSeason_16458_Name|S29：疾驰的欢愉专列",
    StartTime = 1771808400,
    IsNoRankAward = 1,
    SeasonTaskList = {
      127074,
      127072,
      127073,
      127071
    }
  },
  [16665] = {
    ID = 16665,
    CnID = "PVP赛季@第31期",
    BaseSortID = 31,
    Name = "PVPSeason_16665_Name|S30：默斯克斯的呼唤",
    StartTime = 1773018000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      130557,
      130555,
      130558,
      130556
    }
  },
  [16710] = {
    ID = 16710,
    CnID = "PVP赛季@第32期",
    BaseSortID = 32,
    Name = "PVPSeason_16710_Name|S31：钩吻葬盛",
    StartTime = 1775437200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      132457,
      132455,
      132456,
      132454
    }
  },
  [145221] = {
    ID = 145221,
    CnID = "PVP赛季@第33期（已废弃）",
    BaseSortID = 33,
    Name = "PVPSeason_145221_Name|已废弃",
    StartTime = 1776646800,
    IsNoRankAward = 1,
    SeasonTaskList = {
      46823,
      46822,
      46821,
      46846
    }
  },
  [145222] = {
    ID = 145222,
    CnID = "PVP赛季@第34期（已废弃）",
    BaseSortID = 34,
    Name = "PVPSeason_145222_Name|已废弃",
    StartTime = 1779066000,
    IsNoRankAward = 1,
    SeasonTaskList = {
      46854,
      46852,
      46853,
      46850
    }
  },
  [145220] = {
    ID = 145220,
    CnID = "PVP赛季@第35期（已废弃）",
    BaseSortID = 35,
    Name = "PVPSeason_145220_Name|已废弃",
    StartTime = 1781485200,
    IsNoRankAward = 1,
    SeasonTaskList = {
      46823,
      46822,
      46821,
      46846
    }
  }
})
return PVPSeason
