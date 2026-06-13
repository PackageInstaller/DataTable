local StoryConst = {}

local EmojiPath = "UI/SpritePics/emoji/ui_emoji_icon_"

local StoryType = {
    Dialogue = 1,
    CreateRole = 2,
    Timeline = 3,
    Background = 4,
    Sam = 5,
    -- Gift = 6,
    Interact = 7,
    Video = 8,
    Effect = 9,
    RoleIntro = 10, -- 人物介绍
    HeadTalk = 11,  -- 小头像对话
}

local ResponseType = {
    None = 0,
    Selection = 1,
    RoleEffect = 2,
    BgEffect = 3,
    -- Luna = 4,    -- 已删除功能
    RoleMagnifier = 5,
    AnimSeries = 6,
    AnimParallel = 7,
    AnimSwipe = 8,
    Gift = 9,
    AnimAuto = 10, --未用
    Video = 11,
    Fire = 12,     --指挥官开枪
}

local TriggerType = { PreWar = 1, AfterWar = 2, Story = 3 }
local TypeParam = { Repeatable = 1, Unrepeatable = 2 }
local Effect = { Off = 0, On = 1 }
local Color = {
    WhiteZero = { r = 1, g = 1, b = 1, a = 0 },
    WhiteOpacity = { r = 1, g = 1, b = 1, a = 0.82 },
    BlueOpacity = { r = 0.42, g = 0.62, b = 0.9, a = 0.82 }
}

local AnimName = { AnimTrigger = "AnimTrigger", InteractTrigger = "Trigger01" }
local FlipType = { None = 0, Clockwise = 1, AntiClockwise = 2 }
local Highlight = { Off = 0, On = 1 }

local Shake = {
    Off = 0,
    Screen = 1,
    ScreenLoop = 2,
    ScreenLR = 3,
    ScreenLRLoop = 4,
    ScreenTB = 5,
    ScreenTBLoop = 6,
    RoleShake = 7,
    Dialogue = 8
}

local RoleShakeType = {
    Role = 1,
    RoleLoop = 2,
    RoleLR = 3,
    RoleLRLoop = 4,
    RoleTB = 5,
    RoleTBLoop = 6
}

local FastSpeed = { 2, 4, 8, 16 }

local SkipWay = {
    Off = 0,
    On = 1,
}

local IsVideoLoop = {
    Off = 0,
    On = 1
}

local CharLimit = 35

local SelectState = { Sunna = 1, Meunier = 2, Normal = 3, Fire = 4 }

StoryConst.EmojiPath = EmojiPath
StoryConst.StoryType = StoryType
StoryConst.ResponseType = ResponseType
StoryConst.TriggerType = TriggerType
StoryConst.TypeParam = TypeParam
StoryConst.Effect = Effect
StoryConst.Color = Color
StoryConst.AnimName = AnimName
StoryConst.FlipType = FlipType
StoryConst.Highlight = Highlight
StoryConst.Shake = Shake
StoryConst.RoleShakeType = RoleShakeType
StoryConst.FastSpeed = FastSpeed
StoryConst.SkipWay = SkipWay
StoryConst.IsVideoLoop = IsVideoLoop
StoryConst.SelectState = SelectState
StoryConst.CharLimit = CharLimit

return StoryConst
