-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillIFragmentItem.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillIFragmentItem", package.seeall)

local M = class("AchievementSkillIFragmentItem", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._animation = goutil.addComponentOnce(self._mainGo, ComponentType.Animation)
	self._canvasGroup = goutil.addComponentOnce(self._mainGo, ComponentType.CanvasGroup)
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "imgIcon")
	self._txtName = goutil.findChildTextComponent(self._mainGo, "txtName")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "click"))
	self._selectGo = goutil.findChild(self._mainGo, "select")
	self._txtNum = goutil.findChildTextComponent(self._mainGo, "txtNum")
	self._imgProgress = goutil.findChildImageComponent(self._mainGo, "sliderDi/fill")
	self._redPoint = goutil.findChild(self._mainGo, "red_point")

	self:_bindEvents()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClickSelf()
	ViewMgr.instance:open(ViewName.AchievementSkill, self._data)
end

function M:showSelect(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:playOpenAni()
	self._animation:Stop()
	self._animation:Play("achievement_list_item_open")
end

function M:updateData(data, index)
	self._cellIndex = index
	self._data = data

	local skillMo = self._data:getSkillMo()

	self._txtNum.text = string.format("<color=#c5c5c5>Lv.</color>%s", skillMo:getLevel())

	local moNext = AchievementModel.instance:getSkillLevelMo(skillMo:getId(), skillMo:getLevel(), true)
	local curExp = skillMo:getSkillExp()
	local needExp = skillMo:getSkillExpNeed()

	if moNext then
		needExp = moNext:getSkillExpNeed()
		self._imgProgress.fillAmount = curExp / needExp
	else
		self._txtNum.text = string.format("<color=#c5c5c5>Lv.</color>%s Max", skillMo:getLevel())
		self._imgProgress.fillAmount = needExp / needExp
	end

	self._txtName.text = self._data:getName()

	IconLoader.setSprite(self._imgIcon, IconType.AchievementSkill, self._data:getIcon())

	local redKey = string.format("%d_%d", GameEnum.RedPointEnum.Achievement, self._data:getId())

	RedDotModel.instance:createDotView({
		dotNode = self._redPoint,
		keyList = {
			redKey
		}
	})
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

return M
