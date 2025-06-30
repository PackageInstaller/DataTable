bulletin = {}

bulletin.BulletinPanel = "game/bulletin/view/BulletinPanel"
bulletin.BulletinInfoPanel = "game/bulletin/view/BulletinInfoPanel"
bulletin.BulletinVo = require("game/bulletin/manager/vo/BulletinVo")
bulletin.BulletinConst = require("game/bulletin/manager/BulletinConst")
bulletin.BulletinManager = require("game/bulletin/manager/BulletinManager").new()

local _c = require("game/bulletin/controller/BulletinController").new(bulletin.BulletinManager)

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
