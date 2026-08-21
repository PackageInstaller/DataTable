bird = {}

require("game/bird/manager/BirdConst")
bird.BirdRunGameVo = require("game/bird/manager/vo/BirdRunGameVo")
bird.BirdTaskDataVo = require("game/bird/manager/vo/BirdTaskDataVo")

bird.BirdTaskItem = require("game/bird/view/item/BirdTaskItem")

bird.BirdRankPanel = require("game/bird/view/BirdRankPanel")
bird.BirdRankItem = require("game/bird/view/item/BirdRankItem")


bird.BirdStarDataVo = require("game/bird/manager/vo/BirdStarDataVo")
bird.BirdDupDataVo = require("game/bird/manager/vo/BirdDupDataVo")
bird.BirdStarRwardConfigVo = require("game/bird/manager/vo/BirdStarRwardConfigVo")
bird.BirdEventListVo = require("game/bird/manager/vo/BirdEventListVo")
bird.BirdGameDataVo = require("game/bird/manager/vo/BirdGameDataVo")
bird.BirdItemDataVo = require("game/bird/manager/vo/BirdItemDataVo")

bird.BirdGamePanel = require("game/bird/view/BirdGamePanel")
bird.BirdTaskPanel = require("game/bird/view/BirdTaskPanel")

bird.BirdStarAwardItem = require("game/bird/view/item/BirdStarAwardItem")

bird.BirdTipsView = require("game/bird/view/BirdTipsView")

bird.BirdStartView = require("game/bird/view/BirdStartView")
bird.BirdStageMainUI = require("game/bird/view/BirdStageMainUI")
bird.BirdStarAwardView = require("game/bird/view/BirdStarAwardView")
bird.BirdDupPanel = require("game/bird/view/BirdDupPanel")
bird.BirdSettlePanel = require("game/bird/view/BirdSettlePanel")

bird.BirdManager = require("game/bird/manager/BirdManager").new()

bird.BirdWorldVo = require("game/bird/manager/vo/BirdWorldVo")
bird.BirdGameWorld = require("game/bird/manager/BirdGameWorld").new()
bird.BirdController = require("game/bird/controller/BirdController").new(bird.BirdManager)
local module = {bird.BirdController}
return module