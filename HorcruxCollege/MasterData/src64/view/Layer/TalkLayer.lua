TalkLayer = class("TalkLayer", function()
	return cc.NodeGrid:create()
end)

local audio_manager = require("controller.audio_manager")

require("view.Sprite.ConfirmDialogSprite")

local RichTextPro = require("view.Sprite.RichTextPro")
local file_check_manager = require("controller.filedownloader.file_check_manager")
local Utility = require("common.Utility")
local conversation_data = require("data.conversation_data")
local model_data = require("data.model_data")
local var_0_6 = {
	Scale = 3,
	Position = 1,
	Rotation = 2,
	Opacity = 4
}
local var_0_8 = {
	FREE = 1,
	FINISH = 4,
	STOP = 3,
	RUNNING = 2
}
local var_0_9 = {
	moveScene = 10,
	blackScene = 9,
	zoomPlayer = 13,
	nextScene = 7,
	movePlayer = 14,
	colorScene = 8,
	zoomScene = 11,
	shockPlayer = 12,
	shockScene = 6,
	splashScene = 5
}
local var_0_10 = {
	RIGHT = 1,
	LEFT_MIDDLE = 2,
	LEFT = 0,
	RIGHT_MIDDLE = 3
}
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = {
	"blackScene",
	"shockScene",
	"splashScene",
	"colorScene",
	"zoomScene",
	"moveScene",
	"nextScene"
}
local var_0_13 = {
	{
		index = 1,
		name = "shockPlayer",
		setEffect = function(self, arg_2_1, arg_2_2)
			local var_2_0 = arg_2_1[2]
			local var_2_1 = arg_2_1[3]

			self:stopAllActions()

			if arg_2_1[4] == 2 then
				arg_2_2:openSchedulerOnce(function()
					local var_3_0 = {}

					for iter_3_0 = 1, 1 do
						var_3_0[iter_3_0] = cc.Sequence:create(cc.MoveBy:create(0.15, cc.p(var_2_0 * 10 / iter_3_0, var_2_1 * 10 / iter_3_0)), cc.MoveBy:create(0.15, cc.p(-(var_2_0 * 10 / iter_3_0), -(var_2_1 * 10 / iter_3_0))), cc.MoveBy:create(0.15, cc.p(-(var_2_0 * 10 / iter_3_0), -(var_2_1 * 10 / iter_3_0))), cc.MoveBy:create(0.15, cc.p(var_2_0 * 10 / iter_3_0, var_2_1 * 10 / iter_3_0)))
					end

					if self then
						self:runAction(cc.RepeatForever:create(cc.Sequence:create(var_3_0[1]:clone())))
					end
				end, 0.3)
			else
				local var_2_2 = {}

				for iter_2_0 = 1, 3 do
					var_2_2[iter_2_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(arg_2_1[2] * 10 / iter_2_0, arg_2_1[3] * 10 / iter_2_0)), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(-(arg_2_1[2] * 10 / iter_2_0), -(arg_2_1[3] * 10 / iter_2_0))), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(-(arg_2_1[2] * 10 / iter_2_0), -(arg_2_1[3] * 10 / iter_2_0))), cc.MoveBy:create(0.05 / (iter_2_0 * iter_2_0), cc.p(arg_2_1[2] * 10 / iter_2_0, arg_2_1[3] * 10 / iter_2_0)))
				end

				self:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), var_2_2[1]:clone(), var_2_2[2]:clone(), var_2_2[3]:clone()))
			end
		end
	},
	{
		index = 2,
		name = "zoomPlayer",
		setEffect = function(self, arg_4_1, arg_4_2)
			self:runAction(cc.ScaleTo:create(arg_4_1[1], arg_4_1[2], arg_4_1[3]):clone())
		end
	},
	{
		index = 3,
		name = "movePlayer",
		setEffect = function(self, arg_5_1, arg_5_2)
			self:runAction(cc.MoveTo:create(tonumber(arg_5_1[1]), cc.p(tonumber(arg_5_1[2]) + arg_5_2.ScreenWidth / 2, tonumber(arg_5_1[3]) + arg_5_2.ScreenHeight / 2)):clone())
		end
	}
}
local var_0_14 = {
	"spine/ui/bubble/1",
	"spine/ui/bubble/2",
	"spine/ui/bubble/3",
	"spine/ui/bubble/4",
	"spine/ui/bubble/5",
	"spine/ui/bubble/6",
	"spine/ui/bubble/7",
	"spine/ui/bubble/8",
	"spine/ui/bubble/newbubble/ai",
	"spine/ui/bubble/newbubble/danu",
	"spine/ui/bubble/newbubble/feng",
	"spine/ui/bubble/newbubble/gongji",
	"spine/ui/bubble/newbubble/hua",
	"spine/ui/bubble/newbubble/manzu",
	"spine/ui/bubble/newbubble/qian",
	"spine/ui/bubble/newbubble/qingzhu",
	"spine/ui/bubble/newbubble/shan",
	"spine/ui/bubble/newbubble/shouji",
	"spine/ui/bubble/newbubble/touxiang",
	"spine/ui/bubble/newbubble/wuya",
	"spine/ui/bubble/newbubble/xue",
	"spine/ui/bubble/newbubble/xvli",
	"spine/ui/bubble/newbubble/yue",
	"spine/ui/bubble/newbubble/yv"
}
local var_0_15 = {
	"spine/ui/bubble/attack",
	"spine/ui/bubble/treat",
	"spine/ui/bubble/memory",
	nil,
	"spine/ui/bubble/awake",
	"spine/ui/bubble/Speedline"
}
local var_0_16 = {
	Output = 3,
	Input = 2,
	Once = 1
}
local var_0_17 = {
	Treat = 2,
	Memory = 3,
	Attack = 1,
	Hitted = 4,
	SpeedLine = 6,
	Awake = 5
}
local var_0_18 = {
	Output = 3,
	Input = 2,
	Once = 1
}
local var_0_19 = "public/talk/new_yourenkuang.png"
local var_0_20 = {
	Myself = 1,
	Narrator = 3,
	Student = 2,
	Prompts = 4
}
local var_0_21

function TalkLayer.loadConversationSaveTable(arg_6_0)
	arg_6_0.ConversationSaveTable = require("data.conversation_talkeditor_data")
end

function TalkLayer:ctor(...)
	self.scheduler = cc.Director:getInstance():getScheduler()
	self.ScreenWidth = self.talkEditorMode == true and 640 or GameDisplay.width
	self.ScreenHeight = self.talkEditorMode == true and 1388 or GameDisplay.height + GameDisplay.fix_y

	self:loadConversationSaveTable()
	self:onLoad()
	self:init(...)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "enter" then
			if self.talkEditorMode == false then
				KeyCodeManager:setCurTalkLayer(self)
			end

			self:recordCurBGM()
		elseif arg_8_0 == "exit" then
			if self.talkEditorMode == false then
				KeyCodeManager:clearTalkLayer(false)
			end

			audio_manager:stopAllRoleSound()

			if self.talkInfo.curClassitionInfo.id == 3102002 then
				audio_manager:resumebackgroundMusic()
			end

			self:resumeCurBGM()

			if self.updateSchedule then
				self.scheduler:unscheduleScriptEntry(self.updateSchedule)
			end

			if self.usualScheduler1 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler1)
			end

			if self.usualScheduler2 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler2)
			end

			if self.usualScheduler3 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler3)
			end

			if self.usualScheduler4 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler4)
			end

			if self.usualScheduler5 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler5)
			end
		end
	end)
	self:openUpdate()
end

function TalkLayer:onLoad()
	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TalkLayer.json" or "TalkLayer.ExportJson")

	self:addChild(self.root)

	self.uiNode = self.root:getChildByName("ui")
	self.btn_review = self.uiNode:getChildByName("btn_review")
	self.btn_skip = self.uiNode:getChildByName("btn_skip")
	self.btn_autoplay = self.uiNode:getChildByName("btn_autoplay")
	self.autoPlayImageNode1 = self.btn_autoplay:getChildByName("animation_1")
	self.autoPlayImageNode2 = self.btn_autoplay:getChildByName("animation_2")
	self.panelNode = self.root:getChildByName("panel")
	self.effectPanelNode = self.panelNode:getChildByName("effectPanel")

	self.effectPanelNode:setTouchEnabled(false)
	self.effectPanelNode:getChildByName("bg"):setTouchEnabled(false)

	self.reviewPanelNode = self.panelNode:getChildByName("reviewPanel")
	self.mySelectPanelNode = self.panelNode:getChildByName("mySelectPanel")
	self.dialogPanelNode = self.panelNode:getChildByName("dialogPanel")
	self.LeftPlayer = self.panelNode:getChildByName("leftPlayer")
	self.LeftPlayerExpression = self.LeftPlayer:getChildByName("expression")
	self.RightPlayer = self.panelNode:getChildByName("rightPlayer")
	self.RightPlayerExpression = self.RightPlayer:getChildByName("expression")
	self.bgNode = self.panelNode:getChildByName("bg")
	self.bgPos = cc.p(0, 0)
	self.bgPos.x, self.bgPos.y = self.bgNode:getPosition()
	self.effectPanelLabelNode = cc.Label:createWithTTF("", FONT_DES, 36)

	self.effectPanelLabelNode:setAnchorPoint(cc.p(0, 1))
	self.effectPanelLabelNode:setMaxLineWidth(540)
	self.effectPanelLabelNode:setPosition(cc.p(50, 700 + GameDisplay.fix_y))
	self.effectPanelNode:addChild(self.effectPanelLabelNode)

	self.reviewPanelCellNode = self.reviewPanelNode:getChildByName("listView_cell")
	self.reviewPanelListViewNode = self.reviewPanelNode:getChildByName("listView")

	self.reviewPanelCellNode:removeFromParent()
	self.reviewPanelCellNode:retain()
	self.reviewPanelListViewNode:removeFromParent()
	self.reviewPanelListViewNode:retain()

	self.btnSelect1 = self.mySelectPanelNode:getChildByName("btn_select_1")
	self.btnSelect2 = self.mySelectPanelNode:getChildByName("btn_select_2")
	self.select = {
		self.btnSelect1,
		self.btnSelect2
	}
	self.wordBgPositionX, self.wordBgPositionY = self.dialogPanelNode:getPosition()
	self.speakerNameNode = self.dialogPanelNode:getChildByName("name")
	self.dialogPanelBgNode = self.dialogPanelNode:getChildByName("bg")

	self.dialogPanelBgNode:setPositionX(self.ScreenWidth / 2)

	self.nameDiNode = self.dialogPanelNode:getChildByName("nameBg")
	self.btn_next = self.dialogPanelNode:getChildByName("btn_next")

	self.btn_next:setVisible(false)
	self.btn_next:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(609, 84 - (self.ScreenHeight * 0.18 - 204))), cc.DelayTime:create(0.2), cc.MoveTo:create(0.2, cc.p(609, 84 - (self.ScreenHeight * 0.18 - 204) + 12.5))))))

	self.nextSceneImageNode = self.panelNode:getChildByName("nextScenePanel")

	self.nextSceneImageNode:loadTexture("mainScenebg/talk_next_scene.png")
	self.nextSceneImageNode:setAnchorPoint(cc.p(0.5, 0.5))
	self:registerEventCallback()
end

function TalkLayer:registerEventCallback()
	local function var_10_0()
		self:runAction(cc.RemoveSelf:create(true))

		if self.finishCallBack then
			self.finishCallBack(self.talkInfo.curClassitionInfo.classId)

			self.finishCallBack = nil
		end

		if AnalyticManager then
			AnalyticManager.clickStory({
				look_story_type = "talkSkip",
				storyid = self.talkInfo.curClassitionInfo.classId
			})
		end
	end

	local function var_10_1()
		self.confirmPanel = ConfirmDialogSprite:create("", L_SKIP_EVENT, {
			surecallback = function()
				var_10_0()
			end,
			cancelcallback = function()
				return
			end,
			parenttype = self.parenttype
		}, nil, nil, function()
			self.isInSkip = false
			self.confirmPanel = nil
		end)

		self:addChild(self.confirmPanel, 999)
	end

	self.panelNode:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getIsAutoPlay() == false and self:getIsCanNextStep() then
			self:dealWithNextShow()
		elseif self:getIsNeedWaitPrintText() == true then
			self:dealWithNextShow()
			self:setIsCanNextStep(true)
			self:setIsNeedWaitPrintText(false)
		end
	end)
	self.btn_review:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.lastTalkStatus = self:getCurTalkStatus()

		self:setCurTalkStatus(var_0_8.STOP)
		self:reviewConversation()

		if AnalyticManager then
			AnalyticManager.clickStory({
				look_story_type = "clickPlayback",
				storyid = self.talkInfo.curClassitionInfo.classId
			})
		end
	end)
	self.btn_skip:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isInSkip = true

		var_10_1()

		if AnalyticManager then
			AnalyticManager.clickStory({
				look_story_type = "clickSkip",
				storyid = self.talkInfo.curClassitionInfo.classId
			})
		end
	end)
	self.btn_autoplay:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:setIsAutoPlay(not self:getIsAutoPlay())

		if AnalyticManager then
			AnalyticManager.clickAuto({
				id = self.talkInfo.curClassitionInfo.classId
			})
		end
	end)
end

function TalkLayer:initInfo()
	self.usualSchedulerTable = {}

	self:setCurTalkStatus(nil)
	self:setIsNeedWaitPrintText(nil)
	self:setIsNeedWaitPlaySounds(nil)
	self:setIsNeedWaitPlayEffect(nil)
end

function TalkLayer:init(...)
	local var_21_0 = {
		...
	}
	local var_21_1 = var_21_0[1] or 1

	self.nobackground = var_21_0[2]
	self.talktype = var_21_0[3]
	self.stroryName = var_21_0[4] or ""
	self.finishCallBack = var_21_0[5]
	self.parenttype = var_21_0[6]
	self.msgconfig = var_21_0[7]

	self:initInfo()

	self.initPostion = cc.p(self.ScreenWidth / 2, self.ScreenHeight / 2)

	if not self.parenttype then
		self.initPostion = cc.p(self.ScreenWidth / 2, self.ScreenHeight / 2 - GameDisplay.fix_y)
	end

	self:initTalkInfo(var_21_1)

	if type(self.changeCurPageNum) == "function" then
		self.changeCurPageNum(self, self)
	end

	self:initPanel()
	self:fullScreen()
	self.TalkEditorModeFullScreen(self, self)

	return true
end

function TalkLayer.TalkEditorModeFullScreen(arg_22_0)
	return
end

function TalkLayer.recordCurBGM(arg_23_0)
	var_0_21 = audio_manager.activeBGM or nil
end

function TalkLayer:resumeCurBGM()
	if var_0_21 == nil then
		return
	end

	if self:isTalkEditorMode() then
		return
	end

	audio_manager:playbackgroundMusic(var_0_21, true)
end

function TalkLayer:playSceneEffect()
	local var_25_0 = self.talkInfo.curClassitionInfo
	local var_25_1 = self.talkInfo.curNodeInfo

	if self.talkInfo.curClassitionInfo.isHaved ~= true then
		return
	end

	local var_25_2 = 0
	local var_25_3 = {}

	var_25_3[1] = 0.5
	var_25_3[2] = 0.2722222222222222
	var_25_3[3] = 0
	var_25_3[4] = 0.5
	var_25_3[5] = 1
	var_25_3[6] = 1
	var_25_3[7] = 0

	for iter_25_0 = 1, #var_0_12 do
		if self.talkInfo.curClassitionInfo[var_0_12[iter_25_0]] ~= nil and type(self.talkInfo.curClassitionInfo[var_0_12[iter_25_0]]) == "table" then
			var_25_3[iter_25_0] = tonumber(self.talkInfo.curClassitionInfo[var_0_12[iter_25_0]][1])
		end
	end

	local var_25_4 = {
		function()
			self.effectPanelNode:setBackGroundColor(cc.c3b(0, 0, 0))
			self.effectPanelNode:setBackGroundColorOpacity(255)
			self.effectPanelNode:setOpacity(0)
			self.effectPanelNode:setVisible(true)
			self.effectPanelNode:runAction(cc.Sequence:create(cc.FadeIn:create(var_25_3[1] / 2), (cc.FadeOut:create(var_25_3[1] / 2))))
		end,
		function()
			local var_27_0 = 2
			local var_27_1 = 5
			local var_27_2 = var_25_0.shockScene

			if var_25_0.shockScene ~= nil then
				var_27_0 = var_27_2[2] and tonumber(var_27_2[2]) or 2
				var_27_1 = var_27_2[3] and tonumber(var_27_2[3]) or 5
			end

			if var_25_0.dialogType == var_0_20.Prompts then
				if var_25_1.mainPlayerNode then
					var_25_1.mainPlayerNode:setPositionX(100000)
				end

				self.btn_review:setVisible(false)
			end

			local var_27_3 = {}

			for iter_27_0 = 1, 3 do
				var_27_3[iter_27_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_27_0 * iter_27_0), cc.p(var_27_0 * 10 / iter_27_0, var_27_1 * 10 / iter_27_0)), cc.MoveBy:create(0.05 / (iter_27_0 * iter_27_0), cc.p(-(var_27_0 * 10 / iter_27_0), -(var_27_1 * 10 / iter_27_0))), cc.MoveBy:create(0.05 / (iter_27_0 * iter_27_0), cc.p(-(var_27_0 * 10 / iter_27_0), -(var_27_1 * 10 / iter_27_0))), cc.MoveBy:create(0.05 / (iter_27_0 * iter_27_0), cc.p(var_27_0 * 10 / iter_27_0, var_27_1 * 10 / iter_27_0)))
			end

			self:runAction(cc.Sequence:create(var_27_3[1], var_27_3[2], var_27_3[3]))
		end,
		function()
			self.effectPanelNode:setBackGroundColor(cc.c3b(255, 255, 255))
			self.effectPanelNode:setBackGroundColorOpacity(255)
			self.effectPanelNode:setOpacity(255)
			self.effectPanelNode:runAction(cc.Sequence:create(cc.Blink:create(var_25_3[3], var_25_0.splashScene[2] or 3), cc.DelayTime:create(0.3), (cc.FadeOut:create(0.3))))
		end,
		function()
			self.panel_access = ccui.Layout:create()

			self.panel_access:setContentSize(cc.size(self.ScreenWidth, GameDisplay.getScreenSize().height + GameDisplay.statusbar_height))
			self.panel_access:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)

			if var_25_0.colorScene[2] == "black" then
				self.panel_access:setBackGroundColor(cc.c3b(0, 0, 0))
			else
				self.panel_access:setBackGroundColor(cc.c3b(255, 255, 255))
			end

			self.panel_access:setAnchorPoint(cc.p(0.5, 0.5))
			self.panel_access:setPosition(cc.p(self.panel_access:getContentSize().width / 2, self.panel_access:getContentSize().height / 2))
			self.root:addChild(self.panel_access, 10)
			self.panel_access:runAction(cc.Sequence:create((cc.FadeOut:create(var_25_3[4]))))
		end,
		function()
			local var_30_0 = 0.5
			local var_30_1 = 1

			if var_25_0.zoomScene ~= nil then
				var_30_0 = tonumber(var_25_0.zoomScene[2]) or 0.5
				var_30_1 = tonumber(var_25_0.zoomScene[3]) or 1
			end

			if not self.bgNode then
				return
			end

			local var_30_2 = var_25_3[5]

			self.btn_skip:setVisible(false)
			self.btn_autoplay:setVisible(false)
			self.bgNode:setScale(var_30_0)
			self.bgNode:runAction((cc.ScaleTo:create(var_30_2, var_30_1)))
		end,
		function()
			local var_31_0 = 0
			local var_31_1 = 0

			if var_25_0.moveScene ~= nil then
				var_31_0 = tonumber(var_25_0.moveScene[2]) or 0
				var_31_1 = tonumber(var_25_0.moveScene[3]) or 0
			end

			if not self.bgNode then
				return
			end

			local var_31_2 = var_25_3[6]

			self.btn_skip:setVisible(false)
			self.btn_autoplay:setVisible(false)

			local var_31_3, var_31_4 = self.bgNode:getPosition()

			self.bgNode:runAction((cc.MoveTo:create(var_31_2, (cc.p(var_31_3 + var_31_0, var_31_4 + var_31_1)))))
		end,
		function()
			if self.nextSceneImageNode == nil then
				return
			end

			local var_32_0 = 1

			if var_25_0.nextScene ~= nil then
				var_32_0 = tonumber(var_25_0.nextScene[1])
			end

			local var_32_1 = var_25_3[7]
			local var_32_2 = self.nextSceneImageNode:getContentSize().width
			local var_32_3 = cc.p(self.ScreenWidth / 2, self.ScreenHeight / 2)

			if var_32_0 == 1 then
				self.nextSceneImageNode:setPosition((cc.p(2.5 * self.ScreenWidth + var_32_2 / 2, self.ScreenHeight / 2)))
				self.nextSceneImageNode:setVisible(true)
				self.nextSceneImageNode:runAction(cc.Sequence:create(cc.DelayTime:create(2), (cc.MoveTo:create(var_32_1, var_32_3))))
			else
				self.nextSceneImageNode:setVisible(true)
				self.nextSceneImageNode:setPosition(var_32_3)
				self.nextSceneImageNode:runAction(cc.Sequence:create(cc.MoveTo:create(var_32_1, (cc.p(-var_32_2 / 2 - self.ScreenWidth - self.ScreenWidth, self.ScreenHeight / 2))), cc.CallFunc:create(function()
					return
				end)))
			end
		end
	}
	local var_25_5 = false

	for iter_25_1 = 1, #var_0_12 do
		if type(self.talkInfo.curClassitionInfo[var_0_12[iter_25_1]]) == "table" and type(var_25_4[iter_25_1]) == "function" then
			var_25_5 = true

			var_25_4[iter_25_1]()

			if var_25_2 < var_25_3[iter_25_1] then
				var_25_2 = var_25_3[iter_25_1]
			end
		end
	end

	if var_25_5 == true then
		self.isNeedWaitPlaySceneEffect = true

		if self.usualScheduler1 then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler1)
		end

		self.usualScheduler1 = self.scheduler:scheduleScriptFunc(function(arg_34_0)
			if self.usualScheduler1 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler1)
			end

			self.isNeedWaitPlaySceneEffect = false
		end, var_25_2, false)
	else
		self.isNeedWaitPlaySceneEffect = false
	end

	if self.usualScheduler2 then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler2)
	end

	self.usualScheduler2 = self.scheduler:scheduleScriptFunc(function(arg_35_0)
		if self.usualScheduler2 then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler2)
		end

		if self.showConversationPlayer then
			self:showConversationPlayer()
		end
	end, 0, false)
end

function TalkLayer:playPlayerEffect()
	local var_36_0 = false
	local var_36_1 = 0

	for iter_36_0 = 1, #var_0_13 do
		if self.talkInfo.curClassitionInfo[var_0_13[iter_36_0].name] then
			var_36_0 = true
			var_36_1 = math.max(var_36_1, self.talkInfo.curClassitionInfo[var_0_13[iter_36_0].name][1])

			var_0_13[iter_36_0].setEffect(self.talkInfo.curNodeInfo.mainPlayerNode, self.talkInfo.curClassitionInfo[var_0_13[iter_36_0].name], self)
		end
	end

	if var_36_0 == true then
		self.isNeedWaitPlayPlayerEffect = true

		if self.usualScheduler3 then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler3)
		end

		self.usualScheduler3 = self.scheduler:scheduleScriptFunc(function(arg_37_0)
			if self.usualScheduler3 then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler3)
			end

			self.isNeedWaitPlayPlayerEffect = false
		end, var_36_1, false)
	else
		self.isNeedWaitPlayPlayerEffect = false
	end
end

function TalkLayer:showConversationPlayer()
	local var_38_0 = self.talkInfo.curClassitionInfo
	local var_38_1 = self.talkInfo.curNodeInfo

	local function var_38_2()
		self.music_obj = nil

		if var_38_0.playerLinesDubbing then
			if not self.talkedTbl["sound/role_voice/" .. var_38_0.playerLinesDubbing] then
				self.talkedTbl["sound/role_voice/" .. var_38_0.playerLinesDubbing] = "sound/role_voice/" .. var_38_0.playerLinesDubbing

				audio_manager:playPlayerSoundTalkLayer("sound/role_voice/" .. var_38_0.playerLinesDubbing, false, nil, nil, function(arg_40_0)
					self.music_obj = arg_40_0
				end)
			end

			if self.talkInfo.curClassitionInfo.id == 3102002 then
				audio_manager:stopbackgroundMusic()
			end
		else
			self:setIsNeedWaitPlaySounds(false)
		end
	end

	local function var_38_3()
		local var_45_0
		local var_45_1 = 0

		if var_38_0.playerBubble == nil then
			return
		else
			var_45_0 = tonumber(var_38_0.playerBubble)
			var_45_1 = tonumber(var_38_0.Bubble_ActionType) or 1
		end

		local var_45_2 = var_38_1.mainPlayerNode:getChildByName("spineAni")

		if var_45_2 ~= nil then
			var_45_2:removeFromParent()
		end

		local var_45_3

		if var_45_0 == nil or var_45_0 < 1 and var_45_0 > #var_0_14 then
			do return end

			var_45_3 = global_getSpine
		end

		local var_45_4 = var_45_3(var_0_14[var_45_0], "animation", var_45_1 == 2)

		var_45_4:setName("spineAni")
		var_38_1.mainPlayerNode:addChild(var_45_4)
		self:setNodeProperty(var_45_4, var_38_0, "Bubble")
	end

	local function var_38_4()
		if var_38_0.soundEffect == nil then
			return
		end

		audio_manager:playeffectMusic("sound/" .. var_38_0.soundEffect, false)
	end

	local function var_38_5()
		local var_47_0 = var_0_18.Once
		local var_47_1 = var_0_19
		local var_47_2 = var_38_0.dialogEffect and string_split(var_38_0.dialogEffect, "=")

		if var_47_2 ~= nil then
			var_47_0 = tonumber(var_47_2[1]) or var_0_18.Once
			var_47_1 = tonumber(var_47_2[2]) or var_0_19
		else
			var_47_0 = var_0_18.Once
			var_47_1 = var_0_19
		end

		self.dialogPanelNode:stopAllActions()

		if var_47_0 == var_0_18.Once then
			if L_EXPLORETALK_SHOWNAME.Show_Name[2] == var_38_0.playerName then
				self.nameDiNode:setVisible(false)
			else
				self.nameDiNode:setVisible(true)
			end

			self.dialogPanelNode:setPosition(cc.p(self.wordBgPositionX, self.wordBgPositionY))
			self.dialogPanelBgNode:loadTexture(var_47_1, var_0_11)
		elseif var_47_0 == var_0_18.Input then
			self.dialogPanelNode:runAction((cc.Sequence:create(cc.FadeOut:create(0.1), cc.CallFunc:create(function()
				if L_EXPLORETALK_SHOWNAME.Show_Name[2] == var_38_0.playerName then
					self.nameDiNode:setVisible(false)
				else
					self.nameDiNode:setVisible(true)
				end

				self.dialogPanelNode:setPosition(cc.p(self.wordBgPositionX + self.ScreenWidth, self.wordBgPositionY))
				self.dialogPanelBgNode:loadTexture(var_47_1, var_0_11)
			end), cc.FadeIn:create(0), cc.MoveTo:create(0.5, cc.p(self.wordBgPositionX, self.wordBgPositionY)))))
		else
			self.dialogPanelNode:runAction((cc.Sequence:create(cc.CallFunc:create(function()
				if L_EXPLORETALK_SHOWNAME.Show_Name[2] == var_38_0.playerName then
					self.nameDiNode:setVisible(false)
				else
					self.nameDiNode:setVisible(true)
				end

				self.dialogPanelNode:setPosition(cc.p(self.wordBgPositionX, self.wordBgPositionY))
				self.dialogPanelBgNode:loadTexture(var_47_1, var_0_11)
			end), cc.MoveTo:create(0.5, cc.p(self.wordBgPositionX - self.ScreenWidth, self.wordBgPositionY)))))
		end
	end

	local function var_38_6()
		if self.panelNode:getChildByName("sEffect") then
			self.panelNode:getChildByName("sEffect"):removeFromParent()
		end

		local var_50_0 = var_0_17.Attack
		local var_50_1 = var_0_16.Once
		local var_50_2 = var_38_0.specialEffect and string_split(var_38_0.specialEffect, "=")

		if var_50_2 ~= nil then
			var_50_0 = tonumber(var_50_2[1]) or var_0_17.Attack
			var_50_1 = tonumber(var_50_2[2]) or var_0_16.Once
		else
			return
		end

		local var_50_4

		if var_0_15[var_50_0] and var_50_1 == var_0_16.Once then
			var_50_4 = global_getSpine(var_0_15[var_50_0], "animation", false, function(arg_52_0)
				arg_52_0:setVisible(false)
			end)

			var_50_4:setName("sEffect")
			self.panelNode:addChild(var_50_4, 99)
		elseif var_0_15[var_50_0] and var_50_1 == var_0_16.Input then
			var_50_4 = global_getSpine(var_0_15[var_50_0], "animation", true)

			var_50_4:setName("sEffect")
			self.panelNode:addChild(var_50_4, 99)
		elseif var_0_15[var_50_0] and var_50_1 == var_0_16.Output then
			-- block empty
		end

		if var_50_4 then
			var_50_4:setPosition(self.ScreenWidth / 2, self.ScreenHeight / 2)
		end
	end

	local function var_38_7()
		local var_53_0 = ""

		if var_38_0.dialogType == var_0_20.Student then
			var_53_0 = var_38_0.playerName

			self.nameDiNode:setVisible(true)
		elseif var_38_0.dialogType == var_0_20.Myself then
			var_53_0 = var_38_0.playerName

			self.nameDiNode:setVisible(true)
		else
			var_53_0 = ""

			self.nameDiNode:setVisible(false)
		end

		self.speakerNameNode:stopAllActions()
		self.speakerNameNode:setOpacity(0)
		self.speakerNameNode:setString(var_53_0)
		self.speakerNameNode:setVisible(true)
		self.speakerNameNode:runAction(cc.FadeIn:create(0.3))
	end

	self.btn_skip:setVisible(true)
	self.btn_autoplay:setVisible(true)

	if var_38_0.dialogType ~= var_0_20.Prompts then
		self.dialogPanelNode:setVisible(true)
	end

	if var_38_0.dialogType == var_0_20.Prompts then
		self.btn_skip:setVisible(false)
		self.btn_autoplay:setVisible(false)
		;(function()
			local var_41_0 = self.talkInfo.curClassitionInfo

			if self.talkInfo.curClassitionInfo.playerLines == nil then
				return
			end

			local var_41_1 = string.len(self.talkInfo.curClassitionInfo.playerLines)

			self:setIsNeedWaitPrintText(true)
			self.effectPanelNode:setBackGroundColor(cc.c3b(0, 0, 0))
			self.effectPanelNode:setBackGroundColorOpacity(255)
			self.effectPanelNode:setOpacity(255)
			self.effectPanelNode:runAction(cc.Sequence:create(cc.FadeIn:create(0.1), cc.ActionFloat:create(var_41_1 * 0.04 / 3, 0, var_41_1, function(arg_42_0)
				arg_42_0 = math.min(var_41_1, arg_42_0 + 1)

				self.effectPanelLabelNode:setString((utfsub(var_41_0.playerLines, arg_42_0)))

				if arg_42_0 >= var_41_1 then
					self:setIsNeedWaitPrintText(false)
				end
			end)))
			self.effectPanelNode:setVisible(true)
			self.effectPanelNode:setTouchEnabled(false)
		end)()
	else
		(function()
			self.btn_next:setVisible(false)

			local var_43_0 = var_38_0.playerLines or ""

			if self.dialogPanelNode:getChildByName("richTextWord") then
				self.dialogPanelNode:getChildByName("richTextWord"):removeFromParent()
			end

			local var_43_1 = RichTextPro:create()

			var_43_1:setMaxWidth(560)
			var_43_1:setSize(28)
			var_43_1:setLineSpace(0)
			var_43_1:setplayAni(1)

			if not string.find(var_43_0, "^%b<>.+%b<>$") then
				var_43_0 = table.concat({
					"<p>",
					var_43_0,
					"</p>"
				})
			end

			self:setIsNeedWaitPrintText(true)
			var_43_1:setText(var_43_0, function()
				self:setIsNeedWaitPrintText(false)

				if not self:getIsAutoPlay() then
					self.btn_next:setVisible(true)
				end

				self:triggerNextCallback()
			end, true)
			var_43_1:setPosition(cc.p(40, 220))
			var_43_1:setName("richTextWord")
			self.dialogPanelNode:addChild(var_43_1, 100000)
		end)()
	end

	var_38_2()
	var_38_5()
	var_38_6()
	var_38_7()
	var_38_4()
	var_38_3()
	self:playPlayerShowUp(function()
		if self.playPlayerEffect and type(self.playPlayerEffect) == "function" then
			self:playPlayerEffect()
		end
	end)
	self:dealMyConservation(var_38_0)
end

function TalkLayer.setNodeProperty(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	if arg_55_1 == nil or arg_55_2 == nil then
		return
	end

	local var_55_0 = {
		"Position",
		"Rotation",
		"Scale",
		"Opacity"
	}

	if arg_55_4 == nil then
		for iter_55_0, iter_55_1 in pairs(var_55_0) do
			if arg_55_2[arg_55_3 .. "_" .. iter_55_1] then
				if iter_55_0 == 1 then
					local var_55_1 = string_split(arg_55_2[arg_55_3 .. "_" .. iter_55_1], "=")

					arg_55_1:setPosition(cc.p(tonumber(var_55_1[1]) or 0, tonumber(var_55_1[2]) or 0))
				elseif iter_55_0 == 2 then
					arg_55_1:setRotation(tonumber(arg_55_2[arg_55_3 .. "_" .. iter_55_1]) or 0)
				elseif iter_55_0 == 3 then
					arg_55_1:setScale(tonumber(arg_55_2[arg_55_3 .. "_" .. iter_55_1]) or 1)
				elseif iter_55_0 == 4 then
					arg_55_1:setCascadeOpacityEnabled(true)
					arg_55_1:setOpacity(tonumber(arg_55_2[arg_55_3 .. "_" .. iter_55_1]) or 255)
				end
			end
		end
	else
		local var_55_3 = arg_55_3 .. "_" .. var_55_0[arg_55_4]

		if arg_55_2[arg_55_3 .. "_" .. var_55_0[arg_55_4]] then
			if arg_55_4 == 1 then
				local var_55_4 = string_split(arg_55_2[var_55_3], "=")

				arg_55_1:setPosition(cc.p(tonumber(var_55_4[1]) or 0, tonumber(var_55_4[2]) or 0))
			elseif arg_55_4 == 2 then
				arg_55_1:setRotation(tonumber(arg_55_2[var_55_3]) or 0)
			elseif arg_55_4 == 3 then
				arg_55_1:setScale(tonumber(arg_55_2[var_55_3]) or 1)
			elseif arg_55_4 == 4 then
				arg_55_1:setCascadeOpacityEnabled(true)
				arg_55_1:setOpacity(tonumber(arg_55_2[var_55_3]) or 255)
			end
		end
	end
end

function TalkLayer:playPlayerShowUp(arg_56_1)
	if self.LeftPlayer.targetPos then
		self.LeftPlayer:setPosition(self.LeftPlayer.targetPos)
		self.LeftPlayer:stopAllActions()

		self.LeftPlayer.targetPos = nil
	end

	if self.RightPlayer.targetPos then
		self.RightPlayer:setPosition(self.RightPlayer.targetPos)
		self.RightPlayer:stopAllActions()

		self.RightPlayer.targetPos = nil
	end

	local var_56_0 = 0
	local var_56_1 = self.talkInfo.curClassitionInfo
	local var_56_2 = self.talkInfo.curNodeInfo
	local var_56_3 = cloneconf(self.talkInfo.lastPlayerInfo)
	local var_56_4 = 0
	local var_56_5 = 0

	if self.talkInfo.curClassitionInfo.Player_Position then
		posArray = string_split(var_56_1.Player_Position, "=")
		var_56_4 = tonumber(posArray[1])
		var_56_5 = tonumber(posArray[2])
	end

	if var_56_1.playerPosType > var_0_10.RIGHT then
		if var_56_1.playerPosType == var_0_10.LEFT_MIDDLE then
			var_56_3[1].playerPosType = var_0_10.LEFT_MIDDLE
			var_56_3[1].playerStartPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
			var_56_3[1].playerStayPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
			var_56_3[1].playerEndPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		elseif var_56_1.playerPosType == var_0_10.RIGHT_MIDDLE then
			var_56_3[2].playerPosType = var_0_10.RIGHT_MIDDLE
			var_56_3[2].playerStartPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
			var_56_3[2].playerStayPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
			var_56_3[2].playerEndPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		end
	else
		var_56_3[1].playerPosType = var_0_10.LEFT
		var_56_3[1].playerStartPos = cc.p(self.ScreenWidth / 2 - self.ScreenWidth + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		var_56_3[1].playerStayPos = cc.p(200 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		var_56_3[1].playerEndPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		var_56_3[2].playerPosType = var_0_10.RIGHT
		var_56_3[2].playerStartPos = cc.p(self.ScreenWidth / 2 + self.ScreenWidth + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		var_56_3[2].playerStayPos = cc.p(440 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
		var_56_3[2].playerEndPos = cc.p(self.ScreenWidth / 2 + var_56_4, 550 + (self.ScreenHeight - 1136) / 2 + var_56_5)
	end

	local function var_56_6()
		local var_57_2 = var_56_1.playerId
		local var_57_3 = var_56_1.playerExpression

		if var_56_1.playerId then
			if not model_data[var_57_2] or not model_data[var_57_2].role_image then
				print(string.format("modelid = %d not exist", var_57_2))
			end

			local var_57_4 = "role/" .. model_data[var_57_2].role_image .. ".png"

			if var_57_3 ~= nil and model_data[var_57_2][var_57_3] then
				var_56_2.mainPlayerExpresiionNode:loadTexture("expression/" .. model_data[var_57_2][var_57_3] .. ".png")
				var_56_2.mainPlayerExpresiionNode:setVisible(true)
			else
				var_56_2.mainPlayerExpresiionNode:setVisible(false)
			end

			var_56_2.mainPlayerNode:loadTexture(var_57_4)
			self:setNodeProperty(var_56_2.mainPlayerNode, var_56_1, "Player", var_0_6.Rotation)
			self:setNodeProperty(var_56_2.mainPlayerNode, var_56_1, "Player", var_0_6.Scale)
			self:setNodeProperty(var_56_2.mainPlayerNode, var_56_1, "Player", var_0_6.Opacity)
			var_56_2.mainPlayerNode:setVisible(true)

			local var_57_5 = var_56_2.mainPlayerNode:getContentSize()

			var_56_2.mainPlayerExpresiionNode:setPosition(var_57_5.width / 2, var_57_5.height / 2)
		else
			var_56_2.mainPlayerNode:setVisible(false)
		end
	end

	local var_56_7 = cc.FadeIn:create(0)
	local var_56_8 = cc.FadeOut:create(0)

	if var_56_1.dialogType == var_0_20.Prompts or var_56_1.dialogType == var_0_20.Narrator then
		for iter_56_0 = 1, #var_56_3 do
			local var_56_9 = var_56_3[iter_56_0]
			local var_56_11

			if var_56_3[iter_56_0].playerPosType == var_0_10.LEFT then
				var_56_11 = self.LeftPlayer
				var_56_9.playerStartPos = cc.p(math.min(var_56_9.playerStartPos.x, -self.LeftPlayer:getContentSize().width / 2), var_56_9.playerStartPos.y)
			elseif var_56_3[iter_56_0].playerPosType == var_0_10.RIGHT then
				var_56_11 = self.RightPlayer
				var_56_9.playerStartPos = cc.p(math.max(var_56_9.playerStartPos.x, self.ScreenWidth + self.RightPlayer:getContentSize().width / 2), var_56_9.playerStartPos.y)
			elseif var_56_3[iter_56_0].playerPosType == var_0_10.LEFT_MIDDLE then
				var_56_11 = self.LeftPlayer
			elseif var_56_3[iter_56_0].playerPosType == var_0_10.RIGHT_MIDDLE then
				var_56_11 = self.RightPlayer
			end

			local var_56_12 = cc.MoveTo:create(0.1, var_56_9.playerStartPos)
			local var_56_13 = cc.MoveTo:create(0.3, var_56_9.playerStayPos)
			local var_56_14 = cc.MoveTo:create(0.3, var_56_9.playerEndPos)

			if var_56_0 < 0.1 then
				var_56_0 = 0.1
			end

			var_56_11:runAction((cc.Sequence:create(var_56_8:clone(), var_56_12:clone(), cc.CallFunc:create(function()
				var_56_11.targetPos = nil
			end), var_56_7:clone())))

			var_56_11.targetPos = var_56_9.playerStartPos
		end
	else
		for iter_56_1 = 1, #var_56_3 do
			local var_56_15 = var_56_3[iter_56_1]
			local var_56_16 = var_56_3[iter_56_1].playerPosType
			local var_56_17 = var_56_3[iter_56_1].playerId
			local var_56_18

			if var_56_3[iter_56_1].playerPosType == var_0_10.LEFT then
				var_56_18 = self.LeftPlayer
				var_56_15.playerStartPos = cc.p(math.min(var_56_15.playerStartPos.x, -self.LeftPlayer:getContentSize().width / 2), var_56_15.playerStartPos.y)
			elseif var_56_16 == var_0_10.RIGHT then
				var_56_18 = self.RightPlayer
				var_56_15.playerStartPos = cc.p(math.max(var_56_15.playerStartPos.x, self.ScreenWidth + self.RightPlayer:getContentSize().width / 2), var_56_15.playerStartPos.y)
			elseif var_56_16 == var_0_10.LEFT_MIDDLE then
				var_56_18 = self.LeftPlayer
			elseif var_56_16 == var_0_10.RIGHT_MIDDLE then
				var_56_18 = self.RightPlayer
			end

			local var_56_19 = cc.MoveTo:create(0.1, var_56_15.playerStartPos)
			local var_56_20 = cc.MoveTo:create(0.3, var_56_15.playerStayPos)
			local var_56_21 = cc.MoveTo:create(0.3, var_56_15.playerEndPos)

			if var_56_1.isStay == 1 and var_56_16 == var_56_1.playerPosType then
				if var_56_1.playerId ~= var_56_17 then
					if var_56_0 < 0.4 then
						var_56_0 = 0.4
					end

					var_56_18:runAction((cc.Sequence:create(var_56_8:clone(), var_56_19:clone(), var_56_7:clone(), cc.CallFunc:create(function()
						var_56_6()

						if var_56_16 == var_0_10.LEFT or var_56_16 == var_0_10.LEFT_MIDDLE then
							self.LeftPlayer:setLocalZOrder(1)
							self.RightPlayer:setLocalZOrder(0)
						else
							self.LeftPlayer:setLocalZOrder(0)
							self.RightPlayer:setLocalZOrder(1)
						end
					end), var_56_20:clone(), cc.CallFunc:create(function()
						var_56_18.targetPos = nil
					end))))

					var_56_18.targetPos = var_56_15.playerStayPos
				else
					if var_56_0 < 0.4 then
						var_56_0 = 0.4
					end

					var_56_18:runAction((cc.Sequence:create(var_56_8:clone(), var_56_19:clone(), var_56_7:clone(), var_56_20:clone(), cc.CallFunc:create(function()
						var_56_18.targetPos = nil
					end))))

					var_56_18.targetPos = var_56_15.playerStayPos
				end
			elseif var_56_1.isStay == 0 and var_56_16 == var_56_1.playerPosType then
				if var_56_1.playerId ~= var_56_17 then
					if var_56_0 < 0.4 then
						var_56_0 = 0.4
					end

					var_56_18:runAction((cc.Sequence:create(var_56_8:clone(), var_56_19:clone(), var_56_7:clone(), cc.CallFunc:create(function()
						var_56_6()

						if var_56_16 == var_0_10.LEFT or var_56_16 == var_0_10.LEFT_MIDDLE then
							self.LeftPlayer:setLocalZOrder(1)
							self.RightPlayer:setLocalZOrder(0)
						else
							self.RightPlayer:setLocalZOrder(1)
							self.LeftPlayer:setLocalZOrder(0)
						end
					end), var_56_21:clone(), cc.CallFunc:create(function()
						var_56_18.targetPos = nil
					end))))

					var_56_18.targetPos = var_56_15.playerEndPos
				else
					var_56_6()
				end
			elseif var_56_1.isStay == 1 and var_56_16 ~= var_56_1.playerPosType then
				if var_56_0 < 0.3 then
					var_56_0 = 0.3
				end

				var_56_18:runAction((cc.Sequence:create(var_56_20:clone(), cc.CallFunc:create(function()
					var_56_18.targetPos = nil
				end))))

				var_56_18.targetPos = var_56_15.playerStayPos
			elseif var_56_1.isStay == 0 and var_56_16 ~= var_56_1.playerPosType then
				if var_56_0 < 0.1 then
					var_56_0 = 0.1
				end

				var_56_18:runAction((cc.Sequence:create(var_56_8:clone(), var_56_19:clone(), var_56_7:clone(), cc.CallFunc:create(function()
					var_56_18.targetPos = nil
				end))))

				var_56_18.targetPos = var_56_15.playerStartPos
			end
		end
	end

	var_56_3[1].playerId = nil
	var_56_3[2].playerId = nil

	if var_56_1.dialogType == var_0_20.Prompts or var_56_1.dialogType == var_0_20.Narrator then
		-- block empty
	elseif var_56_1.playerPosType == var_0_10.LEFT or var_56_1.playerPosType == var_0_10.LEFT_MIDDLE then
		var_56_3[1].playerId = var_56_1.playerId
	elseif var_56_1.playerPosType == var_0_10.RIGHT or var_56_1.playerPosType == var_0_10.RIGHT_MIDDLE then
		var_56_3[2].playerId = var_56_1.playerId
	end

	self.talkInfo.lastPlayerInfo = cloneconf(var_56_3)

	if self.usualScheduler4 then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler4)
	end

	self.usualScheduler4 = self.scheduler:scheduleScriptFunc(function(arg_66_0)
		if self.playerShowUpScheduler then
			directorScheduler:unscheduleScriptEntry(self.playerShowUpScheduler)
		end

		if self.usualScheduler4 then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler4)
		end

		if type(arg_56_1) == "function" then
			arg_56_1()
		end
	end, var_56_0, false)
end

function TalkLayer:getRolePosTbl(arg_68_1, arg_68_2, arg_68_3)
	local var_68_2 = GameDisplay.fix_y

	if not self.parenttype then
		var_68_2 = var_68_2 - GameDisplay.fix_y
	end

	local var_68_3 = {
		left = {
			inPos = {
				x = arg_68_1.x + arg_68_2.mid.x,
				y = arg_68_1.y + arg_68_2.mid.y + var_68_2
			},
			outPos = {
				x = -402,
				y = arg_68_1.y + arg_68_2.mid.y + var_68_2
			}
		},
		right = {
			inPos = {
				x = arg_68_1.x + arg_68_2.mid.x,
				y = arg_68_1.y + arg_68_2.mid.y + var_68_2
			},
			outPos = {
				x = 1033,
				y = arg_68_1.y + arg_68_2.mid.y + var_68_2
			}
		}
	}
	local var_68_4 = {
		left = {
			inPos = {
				x = arg_68_1.x - 200 + arg_68_2.left.x,
				y = arg_68_1.y + arg_68_2.left.y + var_68_2
			},
			outPos = {
				x = -402,
				y = arg_68_1.y + arg_68_2.left.y + var_68_2
			}
		},
		right = {
			inPos = {
				x = arg_68_1.x + 200 + arg_68_2.right.x,
				y = arg_68_1.y + arg_68_2.right.y + var_68_2
			},
			outPos = {
				x = 1033,
				y = arg_68_1.y + arg_68_2.right.y + var_68_2
			}
		}
	}

	if arg_68_3 and model_data[arg_68_3] and model_data[arg_68_3].is_big_role_image then
		local var_68_5 = self.ScreenHeight / 2

		if not self.parenttype then
			var_68_5 = var_68_5 - GameDisplay.fix_y
		end

		var_68_3 = {
			left = {
				inPos = {
					x = arg_68_1.x + arg_68_2.mid.x,
					y = var_68_5
				},
				outPos = {
					x = -402,
					y = var_68_5
				}
			},
			right = {
				inPos = {
					x = arg_68_1.x + arg_68_2.mid.x,
					y = var_68_5
				},
				outPos = {
					x = 1033,
					y = var_68_5
				}
			}
		}
		var_68_4 = {
			left = {
				inPos = {
					x = arg_68_1.x - 200 + arg_68_2.left.x,
					y = var_68_5
				},
				outPos = {
					x = -402,
					y = var_68_5
				}
			},
			right = {
				inPos = {
					x = arg_68_1.x + 200 + arg_68_2.right.x,
					y = var_68_5
				},
				outPos = {
					x = 1033,
					y = var_68_5
				}
			}
		}
	else
		local var_68_6 = self.ScreenHeight / 2

		if not self.parenttype then
			var_68_6 = var_68_6 - GameDisplay.fix_y
		end

		var_68_3 = {
			left = {
				inPos = {
					x = arg_68_1.x + arg_68_2.mid.x,
					y = var_68_6 + arg_68_2.mid.y
				},
				outPos = {
					x = -402,
					y = var_68_6 + arg_68_2.mid.y
				}
			},
			right = {
				inPos = {
					x = arg_68_1.x + arg_68_2.mid.x,
					y = var_68_6 + arg_68_2.mid.y
				},
				outPos = {
					x = 1033,
					y = var_68_6 + arg_68_2.mid.y
				}
			}
		}
		var_68_4 = {
			left = {
				inPos = {
					x = arg_68_1.x - 200 + arg_68_2.left.x,
					y = var_68_6 + arg_68_2.left.y
				},
				outPos = {
					x = -402,
					y = var_68_6 + arg_68_2.left.y
				}
			},
			right = {
				inPos = {
					x = arg_68_1.x + 200 + arg_68_2.right.x,
					y = var_68_6 + arg_68_2.right.y
				},
				outPos = {
					x = 1033,
					y = var_68_6 + arg_68_2.right.y
				}
			}
		}
	end

	return var_68_3, var_68_4
end

function TalkLayer:dealMyConservation(arg_69_1)
	local function var_69_0(arg_70_0, arg_70_1)
		if arg_70_0:getChildByName("richTextWord") then
			arg_70_0:getChildByName("richTextWord"):removeFromParent()
		end

		local var_70_0 = RichTextPro:create()

		var_70_0:setMaxWidth(560)
		var_70_0:setSize(28)
		var_70_0:setLineSpace(0)

		if not string.find(arg_70_1, "^%b<>.+%b<>$") then
			arg_70_1 = table.concat({
				"<p>",
				arg_70_1,
				"</p>"
			})
		end

		var_70_0:setText(arg_70_1, nil, true)

		local var_70_1, var_70_2 = var_70_0:getContentSize()

		arg_70_0:setScale9Enabled(true)
		arg_70_0:setCapInsets(cc.rect(0, 52, 626, 10))
		arg_70_0:setContentSize(cc.size(arg_70_0:getContentSize().width, 114 + var_70_2 - 41))
		var_70_0:setPosition(cc.p(313 - var_70_1 / 2, 75 + var_70_2 - 41))
		var_70_0:setName("richTextWord")
		arg_70_0:addChild(var_70_0, 100000)

		return (var_70_2 - 41) / 41
	end

	local var_69_1 = {}

	if arg_69_1.Lines1 ~= nil then
		table.insert(var_69_1, arg_69_1.Lines1)
	end

	if arg_69_1.Lines2 ~= nil then
		table.insert(var_69_1, arg_69_1.Lines2)
	end

	if next(var_69_1) and #var_69_1 == 1 then
		self.btnSelect1:setVisible(true)
		self.btnSelect1:setPosition(cc.p(self.ScreenWidth / 2, 568 + GameDisplay.fix_y))
		self.btnSelect2:setVisible(false)
		var_69_0(self.btnSelect1, var_69_1[1])
		self.btnSelect1:addTouchEventListener(function(arg_71_0, arg_71_1)
			if arg_71_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_69_1.nextClassId1 then
				self:dealSelectBtn(arg_69_1.nextClassId1, var_69_1[1])
			else
				self:setCurTalkStatus(var_0_8.FREE)
			end
		end)

		self.isMyConvervation = true
	elseif next(var_69_1) and #var_69_1 > 1 then
		for iter_69_0 = 1, #var_69_1 do
			self.select[iter_69_0]:setVisible(true)

			local var_69_2 = var_69_0(self.select[iter_69_0], var_69_1[iter_69_0])

			if iter_69_0 == 1 then
				self.btnSelect1:setPosition(cc.p(self.ScreenWidth / 2, 708 + GameDisplay.fix_y + var_69_2 * 15))
			else
				self.btnSelect2:setPosition(cc.p(self.ScreenWidth / 2, 538 + GameDisplay.fix_y - var_69_2 * 15))
			end

			self.select[iter_69_0]:addTouchEventListener(function(arg_72_0, arg_72_1)
				if arg_72_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_69_1["nextClassId" .. iter_69_0] then
					self:dealSelectBtn(arg_69_1["nextClassId" .. iter_69_0], var_69_1[iter_69_0])
				else
					self:setCurTalkStatus(var_0_8.FREE)
				end
			end)
		end

		self.isMyConvervation = true
	else
		self.isMyConvervation = false
	end
end

function TalkLayer:dealSelectBtn(arg_73_1, arg_73_2)
	table.insert(self.talkInfo.curReviewinfo, {
		showName = L_EXPLORETALK_ME,
		dec = arg_73_2
	})

	if AnalyticManager then
		AnalyticManager.clickStory({
			look_story_type = "finishTalk",
			storyid = self.talkInfo.curClassitionInfo.classId
		})
	end

	self:initTalkInfo(arg_73_1, true)
	self:setCurTalkStatus(var_0_8.FREE)
	self:dealWithNextShow()
end

function TalkLayer:openOrcloseAuto(arg_74_1)
	local function var_74_0(arg_75_0)
		self.autoPlayImageNode1:setVisible(arg_75_0)
		self.autoPlayImageNode2:setVisible(not arg_75_0)
	end

	if arg_74_1 then
		self.btn_autoplay:loadTextures("public/talk/new_auto_dong.png", nil, nil, var_0_11)
		self.btn_autoplay:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			var_74_0(false)
		end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			var_74_0(true)
		end))))
	else
		self.btn_autoplay:stopAllActions()
		self.btn_autoplay:loadTextures("public/talk/new_auto.png", nil, nil, var_0_11)
		self.autoPlayImageNode1:setVisible(false)
		self.autoPlayImageNode2:setVisible(false)
	end
end

function TalkLayer:endTalk()
	self:setIsNeedWaitPrintText(true)

	self.endpanel = ccui.Layout:create()

	self.endpanel:setContentSize(cc.size(self.ScreenWidth, GameDisplay.getScreenSize().height + GameDisplay.statusbar_height))

	if self.parenttype == 1 then
		self.endpanel:setPositionY(self.endpanel:getPositionY() - GameDisplay.fix_y)
	end

	self.endpanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.endpanel:setBackGroundColor(cc.c3b(0, 0, 0))
	self.endpanel:setBackGroundColorOpacity(255)
	self:addChild(self.endpanel, 10000000)
	self.endpanel:setOpacity(0)
	self.endpanel:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(function()
		self:runAction(cc.RemoveSelf:create(true))

		if self.finishCallBack then
			self.finishCallBack(self.talkInfo.curClassitionInfo.classId)

			self.finishCallBack = nil
		end

		if AnalyticManager then
			AnalyticManager.clickStory({
				look_story_type = "finishTalk",
				storyid = self.talkInfo.curClassitionInfo.classId
			})
		end
	end)))
end

function TalkLayer:triggerNextCallback()
	local var_80_0 = {}

	while self.talkInfo.curTalkTable[self.talkInfo.curClassitionInfo.curPageNum]["event_type_" .. 1] do
		table.insert(var_80_0, {
			type = self.talkInfo.curTalkTable[self.talkInfo.curClassitionInfo.curPageNum]["event_type_" .. 1],
			value = self.talkInfo.curTalkTable[self.talkInfo.curClassitionInfo.curPageNum]["event_reward_" .. 1]
		})
	end

	if self.msgconfig and type(self.msgconfig.nextCallback) == "function" then
		self.msgconfig.nextCallback(self.talkInfo.curTalkTable[self.talkInfo.curClassitionInfo.curPageNum].id)
	end
end

function TalkLayer:showConversationScene()
	local var_81_0 = self.talkInfo.curClassitionInfo
	local var_81_1 = self.talkInfo.curClassitionInfo.dialogType

	self.bgNode:stopAllActions()
	self.bgNode:setVisible(self.nobackground == nil)

	if var_81_0.background ~= nil and var_81_1 ~= var_0_20.Prompts then
		local var_81_3 = "mainScenebg/" .. var_81_0.background .. ".jpg"

		self.bgNode:loadTexture((cc.FileUtils:getInstance():isFileExist("mainScenebg/" .. var_81_0.background .. ".jpg") or file_check_manager:isFileHaveDownloadInfo(var_81_3)) and var_81_3)

		local var_81_5 = cc.p(0, 0)

		if var_81_0.Background_Position then
			addArray = string_split(var_81_0.Background_Position, "=")
			var_81_5.x = tonumber(addArray[1])
			var_81_5.y = tonumber(addArray[2])
		end

		self.bgNode:setPosition((cc.p(self.bgPos.x + var_81_5.x, self.bgPos.y + var_81_5.y + (self.ScreenHeight - 1136) / 2)))
		self:setNodeProperty(self.bgNode, var_81_0, "Background")
	else
		self.bgNode:setVisible(false)
	end

	self.effectPanelNode:stopAllActions()
	self.nextSceneImageNode:stopAllActions()
	self.mySelectPanelNode:stopAllActions()
	self.dialogPanelNode:stopAllActions()
	self.speakerNameNode:stopAllActions()
	self.btn_next:setVisible(false)
	audio_manager:stopAllRoleSound()

	if var_81_0.bgm ~= nil then
		if self.lastbgm == nil or self.lastbgm ~= var_81_0.bgm then
			audio_manager:playbackgroundMusic("sound/" .. var_81_0.bgm, true)

			self.lastbgm = var_81_0.bgm
		end
	else
		audio_manager:stopbackgroundMusic()

		self.lastbgm = nil
	end

	if var_81_1 == var_0_20.Prompts then
		self.btn_review:setVisible(false)
		self.btn_skip:setVisible(false)
		self.btn_autoplay:setVisible(false)
		self.mySelectPanelNode:setVisible(false)
		self.effectPanelNode:setVisible(true)
		self.effectPanelLabelNode:setVisible(true)
		self.effectPanelLabelNode:setString("")
		self.nextSceneImageNode:setVisible(false)
		self.dialogPanelNode:setVisible(false)
		self.speakerNameNode:setVisible(false)
		self.nameDiNode:setVisible(false)
		self.LeftPlayer:setOpacity(0)
		self.RightPlayer:setOpacity(0)
		self:playSceneEffect()
	elseif var_81_1 == var_0_20.Myself then
		self.btn_review:setVisible(true)
		self.btn_skip:setVisible(true)
		self.btn_autoplay:setVisible(false)
		self.mySelectPanelNode:setVisible(true)
		self.effectPanelNode:setVisible(false)
		self.effectPanelLabelNode:setVisible(false)
		self.nextSceneImageNode:setVisible(false)
		self.dialogPanelNode:setVisible(true)
		self.speakerNameNode:setVisible(true)
		self.nameDiNode:setVisible(true)
		self.LeftPlayer:setOpacity(255)
		self.RightPlayer:setOpacity(255)
		self:playSceneEffect()
	elseif var_81_1 == var_0_20.Narrator then
		self.btn_review:setVisible(true)
		self.btn_skip:setVisible(true)
		self.btn_autoplay:setVisible(true)
		self.mySelectPanelNode:setVisible(false)
		self.effectPanelNode:setVisible(false)
		self.effectPanelLabelNode:setVisible(false)
		self.nextSceneImageNode:setVisible(false)
		self.dialogPanelNode:setVisible(false)
		self.speakerNameNode:setVisible(true)
		self.nameDiNode:setVisible(true)
		self.LeftPlayer:setOpacity(255)
		self.RightPlayer:setOpacity(255)
		self:playSceneEffect()
	elseif var_81_1 == var_0_20.Student then
		self.btn_review:setVisible(true)
		self.mySelectPanelNode:setVisible(false)
		self.effectPanelNode:setVisible(false)
		self.effectPanelLabelNode:setVisible(false)
		self.nextSceneImageNode:setVisible(false)
		self.LeftPlayer:setOpacity(255)
		self.RightPlayer:setOpacity(255)
		self:playSceneEffect()
	end
end

function TalkLayer.setCurTalkStatus(arg_82_0, arg_82_1)
	arg_82_0.curTalkStatus = arg_82_1
end

function TalkLayer:getCurTalkStatus()
	return self.curTalkStatus
end

function TalkLayer.setIsCanNextStep(arg_84_0, arg_84_1)
	arg_84_0.isCanNextStep = arg_84_1
end

function TalkLayer:getIsCanNextStep()
	return self.isCanNextStep
end

function TalkLayer.setIsNeedWaitPrintText(arg_86_0, arg_86_1)
	arg_86_0.isNeedWaitPrintText = arg_86_1
end

function TalkLayer:getIsNeedWaitPrintText()
	return self.isNeedWaitPrintText
end

function TalkLayer.setIsNeedWaitPlaySounds(arg_88_0, arg_88_1)
	arg_88_0.isNeedWaitPlaySounds = arg_88_1
end

function TalkLayer:getIsNeedWaitPlaySounds()
	return self.isNeedWaitPlaySounds
end

function TalkLayer.setIsNeedWaitPlayEffect(arg_90_0, arg_90_1)
	arg_90_0.isNeedWaitPlayEffect = arg_90_1
end

function TalkLayer:getIsNeedWaitPlayEffect()
	return self.isNeedWaitPlayEffect
end

function TalkLayer:ShowNext()
	local var_92_0 = {
		showName = self.talkInfo.curClassitionInfo.playerName
	}

	var_92_0.dec = self.talkInfo.curClassitionInfo.playerLines or ""

	table.insert(self.talkInfo.curReviewinfo, var_92_0)
	self:showConversationScene()
end

function TalkLayer:showAll()
	if self.talkInfo.curClassitionInfo.dialogType == var_0_20.Prompts then
		self.effectPanelLabelNode:setString(self.talkInfo.curClassitionInfo.playerLines)
		self.effectPanelNode:stopAllActions()
		self:setIsNeedWaitPrintText(false)
	else
		local var_93_0 = self.talkInfo.curClassitionInfo.playerLines

		if not self.talkInfo.curClassitionInfo.playerLines then
			return
		end

		if self.dialogPanelNode:getChildByName("richTextWord") then
			self.dialogPanelNode:getChildByName("richTextWord"):removeFromParent()
		end

		local var_93_1 = RichTextPro:create()

		var_93_1:setMaxWidth(560)
		var_93_1:setSize(28)
		var_93_1:setLineSpace(0)

		if not string.find(var_93_0, "^%b<>.+%b<>$") then
			var_93_0 = table.concat({
				"<p>",
				var_93_0,
				"</p>"
			})
		end

		var_93_1:setText(var_93_0, nil, true)
		var_93_1:setPosition(cc.p(40, 220))
		var_93_1:setName("richTextWord")
		self.dialogPanelNode:addChild(var_93_1, 100000)
		self:setIsNeedWaitPrintText(false)

		if not self:getIsAutoPlay() then
			self.btn_next:setVisible(true)
		end
	end
end

function TalkLayer:initTalkInfo(arg_94_1, arg_94_2)
	if arg_94_2 ~= true then
		self.talkInfo = {}
		self.talkInfo.curReviewinfo = {}
		self.talkInfo.curNodeInfo = {}
	end

	if AnalyticManager then
		AnalyticManager.clickStory({
			look_story_type = "enterTalk",
			storyid = arg_94_1
		})
	end

	self.talkInfo.curClassitionInfo = {
		isHaved = false,
		totalPageNum = 0,
		curPageNum = 0,
		classId = arg_94_1
	}
	self.talkedTbl = {}
	self.talkInfo.curTalkTable = {}

	local var_94_0 = self.talkInfo.curTalkTable

	for iter_94_0, iter_94_1 in pairs(self.ConversationSaveTable) do
		if iter_94_1.classId == arg_94_1 then
			table.insert(var_94_0, iter_94_1)
		end
	end

	if next(var_94_0) == nil then
		for iter_94_2, iter_94_3 in pairs(conversation_data) do
			if iter_94_3.classification == arg_94_1 then
				local var_94_1 = var_0_20.Student

				if iter_94_3.dec_1 then
					var_94_1 = var_0_20.Myself
				elseif iter_94_3.showName == "旁白" then
					var_94_1 = var_0_20.Narrator
				end

				if iter_94_3.vioceover == 1 then
					var_94_1 = var_0_20.Prompts
				end

				local var_94_2 = var_94_0
				local var_94_3 = {
					index = iter_94_3.id
				}

				if iter_94_3.speaker == "R" then
					var_94_3.playerPosType = var_0_10.RIGHT or var_0_10.LEFT
				end

				var_94_3.playerExpression = iter_94_3.expression
				var_94_3.isSkip = iter_94_3.skip == 1 and 1 or 0
				var_94_3.background = iter_94_3.background
				var_94_3.dialogType = var_94_1
				var_94_3.classId = arg_94_1
				var_94_3.isStay = iter_94_3.stay or 0
				var_94_3.playerLines = iter_94_3.dec
				var_94_3.playerId = iter_94_3.icon
				var_94_3.playerName = iter_94_3.showName
				var_94_3.playerLinesDubbing = iter_94_3.music
				var_94_3.Lines1 = iter_94_3.dec_1
				var_94_3.Lines2 = iter_94_3.dec_2
				var_94_3.nextClassId1 = iter_94_3.next_classification_1
				var_94_3.nextClassId2 = iter_94_3.next_classification_2
				var_94_3.playerBubble = iter_94_3.playerBubble
				var_94_3.Bubble_ActionType = iter_94_3.Bubble_ActionType
				var_94_3.specialEffect = iter_94_3.specialEffect
				var_94_3.shockScene = iter_94_3.shock_screen and "0.5=2=5"
				var_94_3.splashScene = iter_94_3.splash_screen and string.format("%f", iter_94_3.splash_screen_time)
				var_94_3.blackScene = iter_94_3.black_screen and iter_94_3.black_screen_time
				var_94_3.shockPlayer = iter_94_3.shake_role and "2=5"
				var_94_3.movePlayer = iter_94_3.move_role and string.format("%f=%d=%d", iter_94_3.move_role_time, iter_94_3.move_role_pos_x, iter_94_3.move_role_pos_y)

				if iter_94_3.offset_x ~= nil and iter_94_3.offset_y ~= nil then
					var_94_3.Player_Position = iter_94_3.offset_x .. "=" .. iter_94_3.offset_y or "0=0"
				end

				table.insert(var_94_2, var_94_3)
			end
		end
	end

	self.talkInfo.curClassitionInfo.totalPageNum = #var_94_0
	self.talkInfo.curClassitionInfo.isHaved = true

	table.sort(var_94_0, function(arg_95_0, arg_95_1)
		return arg_95_0.index < arg_95_1.index
	end)
	self:setCurTalkTableDefaultValue(var_94_0)

	self.talkInfo.lastPlayerInfo = {}

	table.insert(self.talkInfo.lastPlayerInfo, {
		playerPosType = var_0_10.LEFT,
		playerStartPos = cc.p(self.ScreenWidth / 2 - self.ScreenWidth, 550 + (self.ScreenHeight - 1136) / 2),
		playerStayPos = cc.p(200, 550 + (self.ScreenHeight - 1136) / 2),
		playerEndPos = cc.p(self.ScreenWidth / 2, 550 + (self.ScreenHeight - 1136) / 2)
	})
	table.insert(self.talkInfo.lastPlayerInfo, {
		playerPosType = var_0_10.RIGHT,
		playerStartPos = cc.p(self.ScreenWidth / 2 + self.ScreenWidth, 550 + (self.ScreenHeight - 1136) / 2),
		playerStayPos = cc.p(self.ScreenWidth - 200, 550 + (self.ScreenHeight - 1136) / 2),
		playerEndPos = cc.p(self.ScreenWidth / 2, 550 + (self.ScreenHeight - 1136) / 2)
	})
end

function TalkLayer.setCurTalkTableDefaultValue(arg_96_0, arg_96_1)
	if arg_96_1 == nil then
		return
	end

	for iter_96_0, iter_96_1 in pairs(arg_96_1) do
		if iter_96_1.Bubble_Position == nil then
			iter_96_1.Bubble_Position = "300=900"
		end
	end
end

function TalkLayer:setIsAutoPlay(arg_97_1)
	self.isAutoPlay = arg_97_1

	RoleDefault:getInstance():setBoolForKey("talkplayerisauto", arg_97_1)
	self:openOrcloseAuto(arg_97_1)
end

function TalkLayer:getIsAutoPlay()
	return self.isAutoPlay
end

function TalkLayer:checkIsCanNextShow()
	return self.talkInfo.curClassitionInfo.curPageNum + 1 <= self.talkInfo.curClassitionInfo.totalPageNum
end

function TalkLayer:dealWithNextShow()
	local var_100_0 = self:checkIsCanNextShow()

	if self:getCurTalkStatus() == var_0_8.FREE and var_100_0 == true then
		self:setCurTalkStatus(var_0_8.RUNNING)

		self.talkInfo.curClassitionInfo.curPageNum = self.talkInfo.curClassitionInfo.curPageNum + 1

		self:initCurClassionInfo()
		self:ShowNext()
	elseif self:getCurTalkStatus() == var_0_8.FREE and var_100_0 == false then
		self:setCurTalkStatus(var_0_8.FINISH)
		self:endTalk()
	elseif self:getCurTalkStatus() == var_0_8.RUNNING and var_100_0 == true then
		self:showAll()
		self:setCurTalkStatus(var_0_8.FREE)
	elseif self:getCurTalkStatus() == var_0_8.STOP then
		-- block empty
	end
end

function TalkLayer:initPanel()
	self:setIsAutoPlay(RoleDefault:getInstance():getBoolForKey("talkplayerisauto", false))
	self.bgNode:setVisible(false)
	self.LeftPlayer:setVisible(false)
	self.RightPlayer:setVisible(false)
	self.dialogPanelNode:setVisible(false)
	self.effectPanelNode:setVisible(false)
	self.mySelectPanelNode:setVisible(false)
	self.reviewPanelNode:setVisible(false)
	self.btn_skip:setVisible(false)
	self.btn_review:setVisible(false)
	self.btn_autoplay:setVisible(false)
	self:setCurTalkStatus(var_0_8.RUNNING)

	self.talkInfo.curClassitionInfo.curPageNum = self.talkInfo.curClassitionInfo.curPageNum + 1

	self:initCurClassionInfo()
	self:ShowNext()
end

function TalkLayer.isTalkEditorMode(arg_102_0)
	return false
end

function TalkLayer:popsurewindow()
	if self:isTalkEditorMode() then
		return
	end

	if self.isInSkip then
		if self.confirmPanel then
			self.isInSkip = false

			self.confirmPanel:removeFromParent()

			self.confirmPanel = nil
		end

		return
	end

	self.isInSkip = true

	local var_103_0 = self.talkInfo.curClassitionInfo.classId

	require("view.Sprite.ConfirmDialogSprite")

	local function var_103_1()
		self:runAction(cc.RemoveSelf:create(true))

		if self.finishCallBack then
			self.finishCallBack(var_103_0)

			self.finishCallBack = nil
		end

		if AnalyticManager then
			AnalyticManager.clickStory({
				look_story_type = "talkSkip",
				storyid = var_103_0
			})
		end
	end

	self.confirmPanel = ConfirmDialogSprite:create("", L_SKIP_EVENT, {
		surecallback = function()
			var_103_1()
		end,
		parenttype = self.parenttype
	}, nil, nil, function()
		self.isInSkip = false

		self.confirmPanel:removeFromParent()

		self.confirmPanel = nil
	end)

	self:addChild(self.confirmPanel, 999)
end

function TalkLayer.initCurTalkPropertyInfo(arg_107_0, arg_107_1, arg_107_2)
	for iter_107_0, iter_107_1 in pairs(arg_107_1) do
		if iter_107_1 == "" then
			arg_107_2[iter_107_0] = nil
		elseif var_0_9[iter_107_0] == var_0_9.splashScene then
			local var_107_0 = string_split(iter_107_1, "=")
			local var_107_1 = {}

			var_107_1[1] = tonumber(var_107_0[1]) or 0
			var_107_1[2] = tonumber(var_107_0[2]) or 5
			arg_107_2[iter_107_0] = var_107_1
		elseif var_0_9[iter_107_0] == var_0_9.shockScene then
			local var_107_2 = string_split(iter_107_1, "=")

			if var_107_2 == nil then
				var_107_2 = {
					0.2722222222222222,
					2,
					5
				}
			end

			local var_107_3 = {
				0.2722222222222222
			}

			var_107_3[2] = tonumber(var_107_2[1] or 2)
			var_107_3[3] = tonumber(var_107_2[2] or 5)
			arg_107_2[iter_107_0] = var_107_3
		elseif var_0_9[iter_107_0] == var_0_9.nextScene then
			local var_107_4 = string_split(iter_107_1, "=")

			if var_107_4 == nil then
				var_107_4 = {
					0,
					1
				}
			end

			local var_107_5 = {}

			var_107_5[1] = tonumber(var_107_4[1] or 0)
			var_107_5[2] = tonumber(var_107_4[2] or 1)
			arg_107_2[iter_107_0] = var_107_5
		elseif var_0_9[iter_107_0] == var_0_9.colorScene then
			local var_107_6 = string_split(iter_107_1, "=")

			if var_107_6 == nil then
				var_107_6 = {
					0.5,
					"black"
				}
			end

			local var_107_7 = {}

			var_107_7[1] = tonumber(var_107_6[1] or 0.5)
			var_107_7[2] = var_107_6[2] or "black"
			arg_107_2[iter_107_0] = var_107_7
		elseif var_0_9[iter_107_0] == var_0_9.blackScene then
			arg_107_2[iter_107_0] = {
				tonumber(iter_107_1 or 0.5)
			}
		elseif var_0_9[iter_107_0] == var_0_9.moveScene then
			local var_107_8 = string_split(iter_107_1, "=")

			if var_107_8 == nil then
				var_107_8 = {
					1,
					0,
					0
				}
			end

			local var_107_9 = {}

			var_107_9[1] = tonumber(var_107_8[1] or 1)
			var_107_9[2] = tonumber(var_107_8[2] or 0)
			var_107_9[3] = tonumber(var_107_8[3] or 0)
			arg_107_2[iter_107_0] = var_107_9
		elseif var_0_9[iter_107_0] == var_0_9.zoomScene then
			local var_107_10 = string_split(iter_107_1, "=")

			if var_107_10 == nil then
				var_107_10 = {
					1,
					0.5,
					1
				}
			end

			local var_107_11 = {}

			var_107_11[1] = tonumber(var_107_10[1] or 1)
			var_107_11[2] = tonumber(var_107_10[2] or 0.5)
			var_107_11[3] = tonumber(var_107_10[3] or 1)
			arg_107_2[iter_107_0] = var_107_11
		elseif var_0_9[iter_107_0] == var_0_9.shockPlayer then
			local var_107_12 = string_split(iter_107_1, "=")

			if var_107_12 == nil then
				var_107_12 = {
					0.2722222222222222,
					2,
					5,
					1
				}
			end

			local var_107_13 = {
				0.2722222222222222
			}

			var_107_13[2] = tonumber(var_107_12[1] or 2)
			var_107_13[3] = tonumber(var_107_12[2] or 5)
			var_107_13[4] = tonumber(var_107_12[3] or 1)
			arg_107_2[iter_107_0] = var_107_13
		elseif var_0_9[iter_107_0] == var_0_9.zoomPlayer then
			local var_107_14 = string_split(iter_107_1, "=")

			if var_107_14 == nil then
				var_107_14 = {
					1,
					0.5,
					1
				}
			end

			local var_107_15 = {}

			var_107_15[1] = tonumber(var_107_14[1] or 1)
			var_107_15[2] = tonumber(var_107_14[2] or 0.5)
			var_107_15[3] = tonumber(var_107_14[3] or 1)
			arg_107_2[iter_107_0] = var_107_15
		elseif var_0_9[iter_107_0] == var_0_9.movePlayer then
			local var_107_16 = string_split(iter_107_1, "=")

			if var_107_16 == nil then
				var_107_16 = {
					1,
					0,
					0
				}
			end

			local var_107_17 = {}

			var_107_17[1] = tonumber(var_107_16[1] or 1)
			var_107_17[2] = tonumber(var_107_16[2] or 0)
			var_107_17[3] = tonumber(var_107_16[3] or 0)
			arg_107_2[iter_107_0] = var_107_17
		else
			arg_107_2[iter_107_0] = iter_107_1
		end
	end
end

function TalkLayer:initCurClassionInfo()
	self.talkInfo.curClassitionInfo = {
		playerLines = "",
		classId = self.talkInfo.curClassitionInfo.classId,
		totalPageNum = self.talkInfo.curClassitionInfo.totalPageNum,
		curPageNum = math.clamp(self.talkInfo.curClassitionInfo.curPageNum, 1, self.talkInfo.curClassitionInfo.totalPageNum),
		isHaved = self.talkInfo.curClassitionInfo.isHaved,
		playerId = self.talkInfo.curClassitionInfo.playerId
	}

	self:initCurTalkPropertyInfo(self.talkInfo.curTalkTable[self.talkInfo.curClassitionInfo.curPageNum], self.talkInfo.curClassitionInfo)

	if self.talkEditorMode == true and type(self.loadDataFromEditorCache) == "function" then
		self:loadDataFromEditorCache(self.talkInfo.curClassitionInfo, self.talkInfo.curClassitionInfo.curPageNum)
	end

	if self.talkInfo.curClassitionInfo.playerPosType == var_0_10.LEFT or self.talkInfo.curClassitionInfo.playerPosType == var_0_10.LEFT_MIDDLE then
		self.talkInfo.curNodeInfo.mainPlayerNode = self.LeftPlayer
		self.talkInfo.curNodeInfo.mainPlayerExpresiionNode = self.LeftPlayerExpression
	else
		self.talkInfo.curNodeInfo.mainPlayerNode = self.RightPlayer
		self.talkInfo.curNodeInfo.mainPlayerExpresiionNode = self.RightPlayerExpression
	end

	self:setIsNeedWaitPrintText(true)
	self:setIsNeedWaitPlaySounds(true)
	self:setIsNeedWaitPlayEffect(true)

	self.isNeedWaitPlaySceneEffect = true
	self.isNeedWaitPlayPlayerEffect = true
	self.isMyConvervation = false
end

function TalkLayer:reviewConversation()
	local var_109_1 = self.reviewPanelListViewNode:clone()

	var_109_1:setVisible(true)
	var_109_1:setContentSize(cc.size(self.ScreenWidth, GameDisplay.getScreenSize().height + GameDisplay.statusbar_height))

	if self.parenttype == 1 then
		var_109_1:setPositionY(var_109_1:getPositionY())
	end

	local var_109_2 = self.reviewPanelCellNode:clone()

	var_109_2:setContentSize(cc.size(640, 66))
	var_109_1:pushBackCustomItem(var_109_2)

	local var_109_3 = self.talkInfo.curReviewinfo

	for iter_109_0 = 1, #self.talkInfo.curReviewinfo do
		local var_109_4 = self.reviewPanelCellNode:clone()

		var_109_4:setVisible(true)

		local var_109_5 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_109_5:setAnchorPoint(cc.p(0, 0))

		if var_109_3[iter_109_0].showName then
			var_109_5:setString(var_109_3[iter_109_0].showName .. ":" or playermodel.nickname .. ":" or L_EXPLORETALK_SHOWNAME.Show_Name[2] .. ":")
		else
			var_109_5:setString(L_EXPLORETALK_SHOWNAME.Show_Name[2] .. ":")
		end

		if var_109_5:getString() == L_EXPLORETALK_ME .. ":" then
			var_109_5:setString(L_MONITOR .. ":")
		end

		var_109_4:addChild(var_109_5)

		local var_109_7 = var_109_3[iter_109_0].dec
		local var_109_8 = require("view.Sprite.RichTextPro"):create()

		var_109_8:setMaxWidth(540 - var_109_5:getContentSize().width)
		var_109_8:setSize(24)
		var_109_8:setLineSpace(0)

		if not string.find(var_109_7, "^%b<>.+%b<>$") then
			var_109_7 = table.concat({
				"<p>",
				var_109_7,
				"</p>"
			})
		end

		var_109_8:setText(var_109_7, nil, true)
		var_109_8:setPosition(cc.p(40, 200))
		var_109_4:addChild(var_109_8, 100000)

		local var_109_9 = var_109_8:getContentHeight()

		var_109_5:setPosition(cc.p(50, var_109_9 - 3 - GameDisplay.fix_y - GameDisplay.fix_y))
		var_109_8:setPosition(cc.p(var_109_5:getPositionX() + var_109_5:getContentSize().width, var_109_5:getPositionY() + 24 + 4))
		var_109_4:setContentSize(cc.size(640, var_109_9 + var_109_5:getContentSize().height))
		var_109_1:pushBackCustomItem(var_109_4)
	end

	var_109_1:pushBackCustomItem(self.reviewPanelCellNode)
	self:addChild(var_109_1)
	var_109_1:addTouchEventListener(function(arg_110_0, arg_110_1)
		if arg_110_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_110_0:getTouchBeganPosition().y - arg_110_0:getTouchEndPosition().y) < 10 then
			var_109_1:runAction(cc.RemoveSelf:create())
			self:setCurTalkStatus(self.lastTalkStatus)
		end
	end)
end

function TalkLayer:fullScreen(arg_111_1)
	self.root:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.uiNode:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.panelNode:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.dialogPanelNode:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.effectPanelNode:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.effectPanelNode:getChildByName("bg"):setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.reviewPanelNode:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.mySelectPanelNode:setContentSize(cc.size(self.ScreenWidth, self.ScreenHeight))
	self.nextSceneImageNode:ignoreContentAdaptWithSize(true)
	self.nextSceneImageNode:setTouchEnabled(false)

	local var_111_0 = self.uiNode:getChildren()

	if var_111_0 then
		for iter_111_0, iter_111_1 in pairs(var_111_0) do
			if iter_111_1:getName() ~= "btn_autoplay" then
				iter_111_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_111_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

				iter_111_1:setPositionY(iter_111_1.full_posY)
			else
				iter_111_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, iter_111_1:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

				iter_111_1:setPositionY(iter_111_1.full_posY)
			end
		end
	end
end

function TalkLayer.create(arg_112_0, ...)
	local var_112_0 = TalkLayer.new(...)

	var_112_0:runAction(cc.Sequence:create((cc.FadeIn:create(0.3))))

	return var_112_0
end

function TalkLayer:openUpdate()
	if self.updateSchedule then
		self.scheduler:unscheduleScriptEntry(self.updateSchedule)
	end

	self.updateSchedule = self.scheduler:scheduleScriptFunc(function(arg_114_0)
		self:update(arg_114_0)
	end, 0, false)
end

function TalkLayer:openSchedulerOnce(arg_115_1, arg_115_2)
	if self.unusalSchedule then
		self.scheduler:unscheduleScriptEntry(self.unusalSchedule)
	end

	self.unusalSchedule = self.scheduler:scheduleScriptFunc(function(arg_116_0)
		if self.unusalSchedule then
			self.scheduler:unscheduleScriptEntry(self.unusalSchedule)
		end

		if arg_115_1 then
			arg_115_1()
		end
	end, arg_115_2, false)
end

function TalkLayer:update(arg_117_1)
	if self:getCurTalkStatus() == var_0_8.FREE then
		if self:getIsAutoPlay() == true and self:getIsCanNextStep() then
			self:dealWithNextShow()
		end
	elseif self:getCurTalkStatus() == var_0_8.RUNNING then
		if self.isNeedWaitPlaySceneEffect == false and self.isNeedWaitPlayPlayerEffect == false then
			self:setIsNeedWaitPlayEffect(false)
		else
			self:setIsNeedWaitPlayEffect(true)
		end

		if self.music_obj and self.music_obj:isFinished() == false then
			self:setIsNeedWaitPlaySounds(true)
		else
			self:setIsNeedWaitPlaySounds(false)
		end

		if self:getIsAutoPlay() == false then
			if self:getIsNeedWaitPrintText() == false and self:getIsNeedWaitPlayEffect() == false and self.isMyConvervation == false then
				self:setIsCanNextStep(true)
				self:setCurTalkStatus(var_0_8.FREE)
			else
				self:setIsCanNextStep(false)
			end
		elseif self:getIsNeedWaitPrintText() == false and self:getIsNeedWaitPlaySounds() == false and self:getIsNeedWaitPlayEffect() == false and self.isMyConvervation == false then
			(function()
				if self.usualScheduler5 then
					self.scheduler:unscheduleScriptEntry(self.usualScheduler5)
				end

				self.usualScheduler5 = self.scheduler:scheduleScriptFunc(function(arg_119_0)
					if self.usualScheduler5 then
						self.scheduler:unscheduleScriptEntry(self.usualScheduler5)
					end

					self:setIsCanNextStep(true)
				end, 1, false)
			end)()
			self:setCurTalkStatus(var_0_8.FREE)
		else
			self:setIsCanNextStep(false)
		end
	end
end
