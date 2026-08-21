block = {}

--vo
block.BlockAreaConfigVo = require("game/block/manager/vo/BlockAreaConfigVo")
block.BlockDupConfigVo = require("game/block/manager/vo/BlockDupConfigVo")
block.BlockRewardConfigVo = require("game/block/manager/vo/BlockRewardConfigVo")
block.BlockGridConfigVo = require("game/block/manager/vo/BlockGridConfigVo")

----UI
block.BlockDupPanel = "game/block/view/BlockDupPanel"
block.BlockSceneUI = "game/block/view/BlockSceneUI"
block.BlockSettlementPanel = "game/block/view/BlockSettlementPanel"
block.BlockStageMainUI = "game/block/view/BlockStageMainUI"
block.BlockStarAwardView = "game/block/view/BlockStarAwardView"
block.BlockTeachingView = "game/block/view/BlockTeachingView"
block.BlockRankPanel = "game/block/view/BlockRankPanel"

block.BlockStarAwardItem = require("game/block/view/item/BlockStarAwardItem")
block.BlockGridItem = require("game/block/view/item/BlockGridItem")
block.BlockRankItem = require("game/block/view/item/BlockRankItem")


--管理器
block.BlockManager = require("game/block/manager/BlockManager").new()
block.BlockController = require("game/block/controller/BlockController").new(block.BlockManager)

local module = {block.BlockController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
