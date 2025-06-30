subPack = {}
subPack.SubDownLoadItem = require('game/subPack/view/item/SubDownLoadItem')
subPack.SubDownLoadPanel = require('game/subPack/view/SubDownLoadPanel')
subPack.SubDownLoadAwardPreviewPanel = require('game/subPack/view/SubDownLoadAwardPreviewPanel')
subPack.SubDownLoadManager = require('game/subPack/manager/SubDownLoadManager').new()
subPack.SubDownLoadController = require('game/subPack/controller/SubDownLoadController').new(subPack.SubDownLoadManager)
local module = { subPack.SubDownLoadController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]