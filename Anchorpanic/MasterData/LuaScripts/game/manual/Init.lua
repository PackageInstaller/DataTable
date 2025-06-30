manual = {}

require("game/manual/manualBase/manager/ManualConst")
manual.ManualMonsterConfigVo = require('game/manual/manualBase/manager/vo/ManualMonsterConfigVo')
manual.ManualMonsterConfigTypeVo = require('game/manual/manualBase/manager/vo/ManualMonsterConfigTypeVo')
manual.ManualManager = require('game/manual/manualBase/manager/ManualManager').new()
manual.ManualController = require('game/manual/manualBase/controller/ManualController').new(manual.ManualManager)

manual.ManualPanel = require('game/manual/manualBase/view/ManualPanel')
manual.ManualMonsterBaseView = require('game/manual/manualBase/view/ManualMonsterBaseView')
manual.ManualMonsterInfoView = require('game/manual/manualBase/view/ManualMonsterInfoView')
manual.ManualItem = require('game/manual/manualBase/view/item/ManualItem')
manual.ManualMonsterPanel = require('game/manual/manualBase/view/ManualMonsterPanel')
manual.ManualMonsterItem = require('game/manual/manualBase/view/item/ManualMonsterItem')
--战员
manual.ManualHeroView = require('game/manual/manualHero/view/ManualHeroView')
manual.ManualHeroPanel = require('game/manual/manualHero/view/ManualHeroPanel')
manual.ManualHeroVo = require('game/manual/manualHero/manager/vo/ManualHeroVo')
manual.ManualHeroItem = require('game/manual/manualHero/view/item/ManualHeroItem')
manual.ManualHeroConst = require('game/manual/manualHero/manager/ManualHeroConst')
manual.ManualHeroManager = require('game/manual/manualHero/manager/ManualHeroManager').new()
manual.ManualHeroController = require('game/manual/manualHero/controller/ManualHeroController').new(manual.ManualHeroManager)
--图鉴-故事
manual.ManualStoryView = require('game/manual/manualStory/view/ManualStoryView')
manual.ManualStoryVo = require('game/manual/manualStory/manager/vo/ManualStoryVo')
manual.ManualStoryListView = require('game/manual/manualStory/view/ManualStoryListView')
manual.ManualStoryInfoView = require('game/manual/manualStory/view/ManualStoryInfoView')
manual.ManualStoryConst = require('game/manual/manualStory/manager/ManualStoryConst')
manual.ManualStoryDialogueVo = require('game/manual/manualStory/manager/vo/ManualStoryDialogueVo')
manual.ManualStoryManager = require('game/manual/manualStory/manager/ManualStoryManager').new()
manual.ManualStoryController = require('game/manual/manualStory/controller/ManualStoryController').new(manual.ManualStoryManager)
--图鉴-世界观
manual.ManualWorldView = require('game/manual/manualWorld/view/ManualWorldView')
manual.ManualWorldVo = require('game/manual/manualWorld/manager/vo/ManualWorldVo')
manual.ManualWorldTabView = require('game/manual/manualWorld/view/ManualWorldTabView')
manual.ManualWorldConst = require('game/manual/manualWorld/manager/ManualWorldConst')
manual.ManualWorldUnlockVo = require('game/manual/manualWorld/manager/vo/ManualWorldUnlockVo')
manual.ManualWorldManager = require('game/manual/manualWorld/manager/ManualWorldManager').new()
manual.ManualWorldController = require('game/manual/manualWorld/controller/ManualWorldController').new(manual.ManualWorldManager)
--图鉴-音乐
manual.ManualMusicView = require('game/manual/manualMusic/view/ManualMusicView')
manual.ManualMusicVo = require('game/manual/manualMusic/manager/vo/ManualMusicVo')
manual.ManualMusicConst = require('game/manual/manualMusic/manager/ManualMusicConst')
manual.ManualMusicManager = require('game/manual/manualMusic/manager/ManualMusicManager').new()
manual.ManualMusicController = require('game/manual/manualMusic/controller/ManualMusicController').new(manual.ManualMusicManager)
--图鉴-手环
manual.ManualBracelesTabView = require('game/manual/manualBraceles/view/ManualBracelesTabView')
manual.ManualBracelesTabSubView = require('game/manual/manualBraceles/view/ManualBracelesTabSubView')
manual.ManualBracelesItem = require('game/manual/manualBraceles/view/item/ManualBracelesItem')
manual.ManualBracelesInfoView = require('game/manual/manualBraceles/view/ManualBracelesInfoView')
--图鉴-模组
manual.ManualModulePanel = require('game/manual/manualModule/view/ManualModulePanel')
manual.ManualModuleManager = require('game/manual/manualModule/manager/ManualModuleManager')
manual.ManualModuleItem = require('game/manual/manualModule/view/item/ManualModuleItem')
manual.ManualModuleInfoView = require('game/manual/manualModule/view/ManualModuleInfoView')

--图集-时装

manual.ManualFashionTabView = require('game/manual/manualFashion/view/ManualFashionTabView')
manual.ManualFashionTabSubView = require('game/manual/manualFashion/view/ManualFashionTabSubView')
manual.ManualFashionItem = require('game/manual/manualFashion/view/item/ManualFashionItem')
manual.ManualFashionManager = require('game/manual/manualFashion/manager/ManualFashionManager').new()
manual.ManualFashionController = require('game/manual/manualFashion/controller/ManualFashionController').new(manual.ManualFashionManager)

local module = { manual.ManualController, manual.ManualStoryController, manual.ManualWorldController, manual.ManualMusicController,manual.ManualFashionController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]