local PrivacyLayer = class("PrivacyLayer", function()
	return ccui.Layout:create()
end)

function PrivacyLayer:create(arg_2_1, arg_2_2)
	local var_2_0 = PrivacyLayer.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function PrivacyLayer:init(arg_3_1, arg_3_2)
	self:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:setTouchEnabled(true)

	local var_3_0 = cc.Sprite:create("update/bg_privacy.png")

	var_3_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:addChild(var_3_0)

	self.bg = var_3_0
	self.agreehandler = arg_3_1
	self.denyhandler = arg_3_2

	self:initInfo()
	self:initButtons()
	self.bg:setOpacity(0)
	self:onEnter()
end

function PrivacyLayer:initInfo()
	local var_4_1 = require("view.Sprite.RichTextPro"):create()

	var_4_1:setMaxWidth(500)
	var_4_1:setFontName("fonts/yanwenzi.ttf")
	var_4_1:setSize(23)
	var_4_1:setLineSpace(0)
	var_4_1:setText(string.format("<p><span style=color: rgb(255,255,255);>%s</span><div underline=1,#ff0000><strong>%s</strong></div><span style=color: rgb(255,255,255);>%s</span>", "华为联运游戏服务为您提供游戏初始化、登录登出、实名认证、防沉迷、优惠券及公告服务。", "当您运行本服务时，为满足相关法律法规政策及相关主管部门的需求，确保用户身份真实性，实现反欺诈等风险控制、保障系统和服务安全，您需要进行实名认证。我们会在获得您的同意或您主动提供的情况下，收集您的实名身份信息（可能包括姓名、身份证号、手机号码）。您应知悉，实名身份信息属于敏感信息，请您谨慎考虑是否提供。我们亦会高度对待和谨慎处理您的实名身份信息（包括高强度加密保护等）。", "本服务需要获取华为账号、设备、网络、应用信息，以及您主动上传的数据并且信息存储时间不超过五年或在您注销华为账号后自动删除。您的游戏数据将根据华为联运游戏服务隐私声明进行处理，有关数据处理的更多信息，请参阅"), nil, true)
	var_4_1:setAnchorPoint(cc.p(0, 1))
	var_4_1:setPosition(cc.p(80, self.bg:getContentSize().height - 130))
	self.bg:addChild(var_4_1)

	local var_4_2, var_4_3 = var_4_1:getContentSize()
	local var_4_4 = ccui.Text:create("关于华为联运游戏服务与隐私的声明", "fonts/yanwenzi.ttf", 23)

	var_4_4:setColor(cc.c3b(100, 100, 255))
	var_4_4:setAnchorPoint(cc.p(0, 0.5))
	var_4_4:setPosition(cc.p(self.bg:getContentSize().width / 2 - 210, self.bg:getContentSize().height - 150 - var_4_3))
	var_4_4:setTouchEnabled(true)
	var_4_4:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		DeviceManager.openURL("https://privacy.consumer.huawei.com/legal/jogs/privacy-statement.htm?code=CN&branchid=2&language=zh_Hans_CN")
	end)
	self.bg:addChild(var_4_4)

	local var_4_5 = cc.Label:createWithTTF("您可前往华为应用市场或游戏中心“设置”>“联运服务”，查看该隐私声明。", "fonts/yanwenzi.ttf", 23)

	var_4_5:setAnchorPoint(cc.p(0, 1))
	var_4_5:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_4_5:setMaxLineWidth(500)
	var_4_5:setPosition(cc.p(self.bg:getContentSize().width / 2 - 245, self.bg:getContentSize().height - 180 - var_4_3))
	self.bg:addChild(var_4_5)

	local var_4_6 = ccui.Button:create("mainScenebg/login/privacy/mark_frame.png", "mainScenebg/login/privacy/mark_frame.png", "mainScenebg/login/privacy/mark_frame.png")

	var_4_6:setPosition(cc.p(self.bg:getContentSize().width / 2 - 230, self.bg:getContentSize().height - 145 - var_4_3))
	self.bg:addChild(var_4_6)

	local var_4_7 = cc.Sprite:create("mainScenebg/login/privacy/mark.png")

	var_4_7:setPosition(cc.p(var_4_6:getContentSize().width / 2, var_4_6:getContentSize().height / 2))
	var_4_6:addChild(var_4_7)
	var_4_7:setName("mark")
	var_4_7:setVisible(cc.UserDefault:getInstance():getBoolForKey("agreehuaweiprivacy", false))
	var_4_6:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_6_0:getChildByName("mark"):setVisible(not arg_6_0:getChildByName("mark"):isVisible())
	end)

	self.checkMark = var_4_6
end

function PrivacyLayer:initButtons()
	self.btnSure = ccui.Button:create("update/btn_privacy_sure.png", nil, "update/btn_privacy_sure.png")

	self.btnSure:setPosition(cc.p(self.bg:getContentSize().width / 2 + 125, 80))
	self.bg:addChild(self.btnSure)
	self.btnSure:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.checkMark:getChildByName("mark"):isVisible() then
			global_ShowBlockWords("请先同意隐私声明")

			return
		end

		self:onAgree()
	end)

	self.btnRefuse = ccui.Button:create("update/btn_privacy_refuse.png", nil, "update/btn_privacy_refuse.png")

	self.btnRefuse:setPosition(cc.p(self.bg:getContentSize().width / 2 - 125, 80))
	self.bg:addChild(self.btnRefuse)
	self.btnRefuse:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onDeny()
	end)
end

function PrivacyLayer:onEnter()
	self.bg:runAction(cc.FadeIn:create(0.5))
end

function PrivacyLayer:onExit()
	self.bg:runAction(cc.FadeOut:create(0.5))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
end

function PrivacyLayer:onAgree()
	cc.UserDefault:getInstance():setBoolForKey("agreehuaweiprivacy", true)
	self:onExit()
	self.agreehandler()
end

function PrivacyLayer:onDeny()
	cc.UserDefault:getInstance():setBoolForKey("agreehuaweiprivacy", false)
	self:onExit()
	self.denyhandler()
end

return PrivacyLayer
