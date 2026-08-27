local WCEntityClassDic = {}
local eEntityShowCat = require("Game.WarChess.eWarChessEnum").eEntityShowCat
WCEntityClassDic[eEntityShowCat.common] = require("Game.WarChess.Data.WarChessEntityData")
WCEntityClassDic[eEntityShowCat.box] = require("Game.WarChess.Data.SpecificEntityData.WCEntityDataBox")
WCEntityClassDic[eEntityShowCat.treash] = require("Game.WarChess.Data.SpecificEntityData.WCEntityDataTreashBox")
return WCEntityClassDic
