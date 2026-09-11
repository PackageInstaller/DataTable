require("library/Oop/Class")
require("library/Oop/Functions")

LazyLoad = import("game.LazyLoad"):GetInstance()

require("library/redux/lib/deepClone")
import("manager.windowBar.WindowBarDef")
require("game/includeMod")
require("game/ConfigHelper")

OutSourcingToLuaBridge = require("support/OutSourcingToLuaBridge")
BattleController = import("game.battle.BattleController")
BattleTools = import("game.battle.BattleTools")
BaseHeroDataTemplate = import("game.data.heroDataTemplate.BaseHeroDataTemplate")
DefalutHeroDataTemplate = import("game.data.heroDataTemplate.DefalutHeroDataTemplate")
TemplateHeroDataTemplate = import("game.data.heroDataTemplate.TemplateHeroDataTemplate")
BattleStageData = require("game.data.BattleStageData").GetInstance()

BattleStageData:Init()

TempHeroData = require("game.data.TempHeroData").GetInstance()

TempHeroData:Init()

EquipData = require("game.data.EquipData").GetInstance()

EquipData:Init()

DormData = require("game.data.DormData").GetInstance()

DormData:Init()

HeroData = require("game.data.HeroData").GetInstance()

HeroData:Init()
