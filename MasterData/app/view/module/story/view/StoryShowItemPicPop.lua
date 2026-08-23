local var_0_0 = g.core.const.ConstMgr
local StoryShowItemPicPop = class("StoryShowItemPicPop", require("app.fairyGUI.story.UI_StoryShowItemPicPop"), function()
	return fgui.GComponent:create({
		resName = "StoryShowItemPicPop",
		pkgPath = "ui/story/story",
		isFullScreen = true,
		pkgName = "story"
	}, ...)
end)

function StoryShowItemPicPop:ctor(arg_2_1)
	self:showAtCenter()

	self._data = arg_2_1.stepData or {}
	self._itemPath = arg_2_1.itemPath
	self._endCallBack = arg_2_1.endFunc
	self._effectName = self._data.effectName
	self._animName = self._data.animName
	self._picName = self._data.picName or ""
	self._isOpen = true

	self:addClickListener(handler(self, self._onCloseSelf))
	self:_updateUniteTokenInfo()
end

function StoryShowItemPicPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_AUTO_END_NOTICE, handler(self, self._autoCloseWhenStoryEnd), self)

	if self.m_itemLoader then
		self.m_itemLoader:setURL(self._itemPath)
	end

	self:_addSpineEffect()
end

function StoryShowItemPicPop:_onCloseSelf()
	if self._isOpen then
		g.core.module.ModuleManager:popComponent()
	end

	self._isOpen = false

	if self._endCallBack then
		self._endCallBack()
	end
end

function StoryShowItemPicPop:onUnload()
	self._isOpen = false
end

function StoryShowItemPicPop:_autoCloseWhenStoryEnd()
	local var_6_0 = self

	if self and self._isOpen then
		self:newScheduleOnce(function()
			if var_6_0 and var_6_0._isOpen then
				var_6_0._isOpen = false

				g.core.module.ModuleManager:onlyPopSelfByDisplay(var_6_0)
			end
		end, 0)
	end
end

function StoryShowItemPicPop:_addSpineEffect()
	if self._effectName and self._effectName ~= "" and self.m_effPlaceHolder then
		self.m_effPlaceHolder:addEffectSpine({
			remove = false,
			isLoop = true,
			name = self._effectName,
			anim = (self._animName and self._animName ~= "" or nil) and self._animName
		})
	end
end

function StoryShowItemPicPop:_updateUniteTokenInfo()
	if not var_0_0.StoryConst.UNITE_TOKEN_PIC_ID["PIC_" .. self._picName] then
		return
	end

	self.m_showTokenInfoController:setSelectedIndex(1)

	local var_9_0 = g.core.config.unite_token_info.get(var_0_0.StoryConst.UNITE_TOKEN_PIC_ID["PIC_" .. self._picName])

	self.m_nameTxt:setText(var_9_0.name)
	self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURL(var_9_0.quality))

	local DrawUniteToken = require("app.view.common.DrawUniteToken")

	if DrawUniteToken:showSpineEnable(var_0_0.StoryConst.UNITE_TOKEN_PIC_ID["PIC_" .. self._picName]) then
		self.m_spineNode:removeChildren()
		self.m_spineNode:addChild((DrawUniteToken.new({
			loop = true,
			advId = var_9_0.advance_id,
			anim = var_0_0.SpineConst.UniteTokenAni.IDLE
		})))
		self.m_itemLoader:setVisible(false)
	end
end

return StoryShowItemPicPop
