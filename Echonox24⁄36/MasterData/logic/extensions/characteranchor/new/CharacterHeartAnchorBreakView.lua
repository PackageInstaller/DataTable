-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/new/CharacterHeartAnchorBreakView.lua

module("logic.extensions.characteranchor.new.CharacterHeartAnchorBreakView", package.seeall)

local M = class("CharacterHeartAnchorBreakView", ViewComponent)

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)

	self._btnReturn1 = self:getBtn("title_view_-878360263")
	self._btnHome1 = self:getBtn("title_view_1398742689")
	self._btnExplain = self:getBtn("0&title_view_-636449388")
	self._txtReturn = self:getText("title_view_-788888785")
	self._txtReturn.text = lang("tip_tacit_entry_breaklv")
	self._imgBg = UIComponentType.ImageBigBG(self:getGo("heart_anchor_view_935866869"))

	goutil.setActive(self:getGo("heart_anchor_view_1219108196"), false)

	self._canvasGroupQualityRoot = self:getUIComponent("heart_anchor_view_35533236", ComponentType.CanvasGroup)
	self._goQualityEffectLst = {
		[GameEnum.QualityEnum.S] = {
			self:getGo("heart_anchor_view_-498790968"),
			self:getGo("heart_anchor_view_91658299")
		},
		[GameEnum.QualityEnum.A] = {
			self:getGo("heart_anchor_view_-385094711"),
			self:getGo("heart_anchor_view_1278892891")
		},
		[GameEnum.QualityEnum.B] = {
			self:getGo("heart_anchor_view_-1293641507"),
			self:getGo("heart_anchor_view_-593492182")
		},
		[GameEnum.QualityEnum.C] = {
			self:getGo("heart_anchor_view_-661061075"),
			self:getGo("heart_anchor_view_-1536745791")
		}
	}

	local goRoleCombat = goutil.findChild(self.mainGO, "role_combat").gameObject

	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(goRoleCombat, RoleCombatCell)
	self._canvasGroupRoleCombat = goutil.addComponentOnce(goRoleCombat, ComponentType.CanvasGroup)
	self._panelRoot = self:getUIComponent("heart_anchor_view_-1136902813", UIComponentType.RectTransform)

	local goCourse = self:getResInstance(ResName.CharacterSystem_heart_anchor_course_view)

	goutil.addChildToParent(goCourse, self._panelRoot)

	self._viewCourse = Astral.SimpleLuaComponentContainer.Add(goCourse, CharacterHeartAnchorBreakSubViewCourse)
end

function M:destroyUI()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
end

function M:bindEvents()
	self._btnReturn1:AddClickListener(self._onClickBack, self)
	self._btnHome1:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function M:unbindEvents()
	self._btnReturn1:RemoveClickListener()
	self._btnHome1:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function M:onEnter(reasonType)
	self:setEvent(true)
	self:updateHeroInfo()
	self._viewCourse:onEnter(not self._viewPresentor:getIsBackOpen())
	self:refreshView()
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)
	self._viewCourse:onExit(isNormalClose)
end

function M:onExitFinished()
	self._imgBg:ClearImage()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleGainItemChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleGainItemChange, self)
	end
end

function M:_handleGainItemChange(e, params)
	self._viewCourse:refreshItemCost()
end

function M:_onClickBack()
	self:back()
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return nil
	end

	local data = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	return data
end

function M:refreshView()
	local bgView = "gm_bg_0001.jpg"
	local bgSubViewCourse = "fm_dec_0001"

	self._imgBg:SetImage(GameUrl.getCharacterHeroAnchorBg(bgView), nil, self)
	self._viewCourse:setBg(GameUrl.getCharacterHeroAnchorBg(bgSubViewCourse))
end

function M:updateHeroInfo()
	local heroData = self:getCurHeroData()

	self._roleCombatCell:updateHeroData(heroData)

	local quality = heroData:getQuality()

	for _quality, goLst in pairs(self._goQualityEffectLst) do
		local show = _quality == quality

		for _, _go in ipairs(goLst or {}) do
			goutil.setActive(_go, show)
		end
	end
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.GuideID.Anchor
	})
end

return M
