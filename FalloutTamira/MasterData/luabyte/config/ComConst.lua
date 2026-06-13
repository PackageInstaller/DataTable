local ComConst = {}

--通讯类型  1=全部 2=文字 3=语音 4=图片 5-远程指挥
local FilterTabType = {
    All = 1,
    Text = 2,
    Voice = 3,
    Pic = 4,
    Battle = 5
}

local FilterTab = {
    ALL = {
        Index = FilterTabType.All,
        labels = "全部"
    },
    TEXT = {
        Index = FilterTabType.Text,
        labels = "文字"
    },
    VOICE = {
        Index = FilterTabType.Voice,
        labels = "语音"
    },
    PIC = {
        Index = FilterTabType.Pic,
        labels = "图片"
    },
    BATTLE = {
        Index = FilterTabType.Battle,
        labels = "远程指挥"
    }
}

local Type = {
    Text = 1,
    Voice = 2,
    Video = 3,
    Pic = 4,
    Battle = 5,
    Line = 6
}

local ChatType = {
    All = 0,
    Private = 1,
    Group = 2,
    Offical = 3
}

local ChatTypeTab = {
    ALL = {
        Index = ChatType.All,
        labels = "全部"
    },
    PRIVATE = {
        Index = ChatType.Private,
        labels = "私聊"
    },
    GROUP = {
        Index = ChatType.Group,
        labels = "群聊"
    },
    OFFICAL = {
        Index = ChatType.Offical,
        labels = "公衆號"
    },
}

local Speaker = {
    Role = 1,
    Caption = 2
}

local BtnColor = {
    Red = {r = 255, g = 0, b = 0, a = 255},
    Yellow = {r = 255, g = 183, b = 0, a = 255},
    Green = {r = 87, g = 255, b = 0, a = 255}
}

local EasyTouch = {
    Pinch = 1,
    TouchUp2 = 2,
}

local ComRename = "ComRename_"
local ComTime = "ComTime_"

ComConst.FilterTabType = FilterTabType
ComConst.FilterTab = FilterTab
ComConst.Type = Type
ComConst.ChatType = ChatType
ComConst.ChatTypeTab = ChatTypeTab
ComConst.Speaker = Speaker
ComConst.BtnColor = BtnColor
ComConst.ComRename = ComRename
ComConst.ComTime = ComTime
ComConst.EasyTouch = EasyTouch

return ComConst
