-- 建造小游戏等级枚举，用于区分不同等级的掉落/叠放物件
drop.DropType = {
    Level1 = 1,
    Level2 = 2,
    Level3 = 3,
    Level4 = 4,
    Level5 = 5,
    Level6 = 6,
    Level7 = 7,
    Level8 = 8,
    Level9 = 9,
    Level10 = 10,
}

-- 碰撞分组枚举，用于定义物件自身分组和可交互的目标分组
drop.DropGroup = {
    --不参与
    None = 0,
    --墙
    Wall = 1,
    --最高线
    Top = 2,

    --球
    StaticBall = 10,
    --移动的球
    MoveBall = 11,
    --地面
    Groud = 12,
}

drop.Id ={
    MoveWorldId = 99999,
}