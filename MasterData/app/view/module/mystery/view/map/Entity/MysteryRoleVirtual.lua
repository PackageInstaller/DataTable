local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local MysteryRoleVirtual = class("MysteryRoleVirtual", (require("app.core.ksmap.entity.MapVisualKnight")))

function MysteryRoleVirtual:ctor(arg_1_1, arg_1_2)
	self._resID = arg_1_1
	self._bindId = arg_1_2

	MysteryRoleVirtual.super.ctor(self, arg_1_1)
end

function MysteryRoleVirtual:_onRoleVirtualClick()
	return
end

function MysteryRoleVirtual:_doInitBillboard()
	self._hitRect.width = 80
	self._hitRect.height = 150
	self._hitRect.x = -40
	self._hitRect.y = 0
	self.m_billboard = cc.Node:create()

	self:addChild(self.m_billboard)
	self.m_billboard:setPosition(0, self._hitRect.height)

	self.m_nameTxt = cc.Label:createWithSystemFont("", "", 18)

	self.m_nameTxt:setTextColor(cc.c3b(242, 242, 242))
	self.m_nameTxt:setWidth(116)
	self.m_nameTxt:setAnchorPoint(0.5, 0.5)
	self.m_nameTxt:setAlignment(1)
	self.m_nameTxt:setPosition(0, 60)
	self.m_billboard:addChild(self.m_nameTxt)

	self.m_nameBg = display.newSprite("ui_cocos/mystery/bg_lz_black.png", {
		scale9 = true,
		capInsets = cc.rect(5, 5, 2, 2)
	})

	self.m_nameBg:setAnchorPoint(0.5, 0.5)
	self.m_nameBg:setPosition(0, 60)
	self.m_nameBg:setOpacity(204)
	self.m_nameBg:setContentSize(116, 52)
	self.m_nameBg:setLocalZOrder(-1)
	self.m_billboard:addChild(self.m_nameBg)

	self.m_signImg = cc.Sprite:create("ui_cocos/mystery/pic_symj_zhandou1.png")

	self.m_signImg:setAnchorPoint(0.5, 0.5)
	self.m_signImg:setPosition(-76, 60)
	self.m_billboard:addChild(self.m_signImg)

	self.m_limitCondTxt = ccui.Text:create("", FONT_PATH, 16)

	self.m_limitCondTxt:setAnchorPoint(0.5, 0.5)
	self.m_limitCondTxt:setPosition(0, 20)
	self.m_limitCondTxt:setTextColor(g.core.common.Color.A7)
	self.m_limitCondTxt:enableOutline(g.core.common.Color.A1, 1)
	self.m_billboard:addChild(self.m_limitCondTxt)
	self.m_limitCondTxt:setVisible(false)
	self.m_billboard:setVisible(false)
	self.m_signImg:setVisible(false)
	self:setSignIconPath()
	self:setLimitCondText()
end

function MysteryRoleVirtual:setBillboardScale(arg_4_1)
	self.m_billboard:setScale(arg_4_1)
end

function MysteryRoleVirtual:setRoleAction(arg_5_1, arg_5_2)
	self._realVisual:setAnimation(0, arg_5_1, arg_5_2)
end

function MysteryRoleVirtual:setBillBoardVisible(arg_6_1)
	self.m_billboard:setVisible(arg_6_1)
end

function MysteryRoleVirtual:setSignIconPath()
	if self._bindId == g.core.model.User:getId() then
		return
	end

	if self._bindId then
		if self.m_signImg then
			self.m_signImg:setVisible(true)

			local var_7_0 = var_0_0:getChapterDataById((var_0_0:getCurChapterId())):getStageInfoByBindId(self._bindId)

			if var_7_0 then
				if var_7_0.type == 1 then
					self.m_signImg:setTexture("ui_cocos/mystery/pic_symj_zhandou" .. var_7_0.quality .. ".png")
				elseif var_7_0.type == 2 then
					self.m_signImg:setTexture("ui_cocos/mystery/pic_symj_zhandou4_boss.png")
				elseif var_7_0.type == 4 then
					self.m_signImg:setTexture("ui_cocos/mystery/pic_symj_zhuxian.png")
				end
			else
				self.m_signImg:setVisible(false)
			end
		end
	elseif self.m_signImg then
		self.m_signImg:setVisible(false)
	end
end

function MysteryRoleVirtual:setLimitCondText()
	if self._bindId and self.m_limitCondTxt then
		self.m_limitCondTxt:setVisible(true)

		local var_8_0 = var_0_0:getChapterDataById((var_0_0:getCurChapterId()))
		local var_8_1 = var_8_0:getStageInfoByBindId(self._bindId)

		if var_8_1 and var_8_1.type == var_0_1.MAP_ITEM_TYPE.ELITE_MONSTER then
			self.m_limitCondTxt:setVisible(true)
			self.m_limitCondTxt:setString(g.core.lang:get(423001, {
				level = var_8_0:getChapterConfig().open_level
			}))
		else
			self.m_limitCondTxt:setVisible(false)
		end
	end
end

function MysteryRoleVirtual:showChatBubble(arg_9_1, arg_9_2, arg_9_3)
	self:onBubbleFinish()

	local var_9_0 = fgui.UIPackage:createObject("mystery", "MysteryTalkBubble")

	self._talkBubble = var_9_0

	local var_9_1 = var_9_0:displayObject()

	var_9_1:setPosition(0, 270)
	self:addChild(var_9_1)
	var_9_0:retain()
	var_9_0:initTalkBubble(arg_9_1, arg_9_2)
	var_9_0:newScheduleOnce(handler(self, self.onBubbleFinish), g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MYSTERY_BUBBLE_TIME).parameter)
end

function MysteryRoleVirtual:onBubbleFinish()
	if self._talkBubble then
		self._talkBubble:displayObject():removeFromParent()

		self._talkBubble = nil
	end
end

return MysteryRoleVirtual
