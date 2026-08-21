module("game.activityStrengthTask.manager.ActivityStrengthTaskConst", Class.impl())

AwardState = {
    Nomal = 0, --未解锁
    Recive = 1, --已解锁未领取
    Recived = 2, --已领取
}

CelebrationTaskState = {
    Nomal = 1, --未解锁
    Recive = 0, --已解锁未领取
    Recived = 2, --已领取
}

return _M
