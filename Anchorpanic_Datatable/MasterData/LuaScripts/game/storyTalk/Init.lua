storyTalk = {}

require("game/storyTalk/manager/StoryTalkConst")
require("game/storyTalk/manager/StoryModelConst")
storyTalk.StoryDataRo = require('rodata/StoryDataRo')
storyTalk.StoryPrefabRo = require('rodata/StoryPrefabRo')

storyTalk.StoryEditorView = require("game/storyTalk/view/StoryEditorView")

storyTalk.StoryTalkSceneView = "game/storyTalk/view/StoryTalkSceneView"
storyTalk.StoryTalkSpineView = "game/storyTalk/view/StoryTalkSpineView"
storyTalk.StoryTalk2DView = "game/storyTalk/view/StoryTalk2DView"
storyTalk.StoryTalk2DLiveView = "game/storyTalk/view/StoryTalk2DLiveView"

storyTalk.StoryMsgCell = require("game/storyTalk/item/StoryMsgCell")

storyTalk.StoryTalkHistoryView = require("game/storyTalk/view/StoryTalkHistoryView")
storyTalk.StoryTalkOptionView = require("game/storyTalk/view/StoryTalkOptionView")
storyTalk.StoryTalkNarratorView = require("game/storyTalk/view/StoryTalkNarratorView")
storyTalk.StoryTalkPanel = "game/storyTalk/view/StoryTalkPanel"
storyTalk.RegisterView = require("game/storyTalk/view/RegisterView")
storyTalk.QualityChooseView = require("game/storyTalk/view/QualityChooseView")
storyTalk.StoryScrollView = require("game/storyTalk/view/StoryScrollView")



-- storyTalk.StoryPlayMaker = require("game/storyTalk/manager/StoryPlayMaker").new()
storyTalk.StoryTalkManager = require("game/storyTalk/manager/StoryTalkManager").new()
storyTalk.StoryTalkCondition = require("game/storyTalk/manager/StoryTalkCondition").new()

local _sc = require("game/storyTalk/controller/StoryTalkController").new(storyTalk.StoryTalkManager)

local _module = { _sc }

return _module

--[[ 替换语言包自动生成，请勿修改！
]]
