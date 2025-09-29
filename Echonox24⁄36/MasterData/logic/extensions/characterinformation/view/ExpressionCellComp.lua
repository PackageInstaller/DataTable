-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/ExpressionCellComp.lua

module("logic.extensions.characterinformation.view.ExpressionCellComp", package.seeall)

local M = class("ExpressionCellComp", CellBaseComponent)
local kExpressionIconPath = {
	"expression1_1",
	"expression2_1",
	"expression3_1",
	"expression6_1",
	"expression4_1",
	"expression5_1"
}
local kExpressionIconPath2 = {
	"expression1_2",
	"expression2_2",
	"expression3_2",
	"expression6_2",
	"expression4_2",
	"expression5_2"
}
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:getGo()
	return self._go
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._animation = registry:findUIElement("role_other_item_1021131058", ComponentType.Animation)
	self._expressionIconImg = registry:findUIElement("role_other_item_250018589", UIComponentType.Image)
	self._expressionSelectIconImg = registry:findUIElement("role_other_item_copy_510846932", UIComponentType.Image)
	self._selectObj = registry:findUIElement("role_other_item_copy_185752990")
	self._unlockGo = registry:findUIElement("role_other_item_copy_-27309615")
	self._lockPanelGo = registry:findUIElement("role_other_item_-224568606")
	self._useMarkGo = registry:findUIElement("role_other_item_853306420")
	self._lockTxt = registry:findUIElement("role_other_item_1230130446", UIComponentType.Text)
	self._lockFaceTxt = registry:findUIElement("role_other_item_copy_-1821373874", UIComponentType.Text)
	self._faceTxt = registry:findUIElement("role_other_item_1611802402", UIComponentType.Text)

	local selectBtn = registry:findUIElement("role_other_item_copy_233168744")

	self._btnSelect = registry:findUIElement("role_other_item_copy_233168744", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)

	self._btnUse = registry:findUIElement("role_other_item_743127603", UIComponentType.ButtonAdapter)

	self._btnUse:AddClickListener(self._clickUse, self)

	self._canvasGroup = goutil.addComponentOnce(self:getGo(), ComponentType.CanvasGroup)
end

function M:_clickSelect()
	if not self._isUnlock then
		return
	end

	if self._selectFaceId == self._faceCO.expressionID then
		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, "select", self._faceCO.expressionID, self._curIndex)
	end
end

function M:_clickUse()
	if not self._isUnlock then
		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, "use", self._faceCO.expressionID, self._curIndex)
	end
end

function M:updateData(data, ownHero, index)
	self._curIndex = index
	self._faceCO = data.faceCO
	self._heroId = data.heroId
	self._ownHero = ownHero

	self:_refreshView()
end

function M:getIndex()
	return self._curIndex
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setUseAndSelectFaceId(useId, selectId)
	self._useFaceId = useId
	self._selectFaceId = selectId
end

function M:_refreshView()
	self._faceTxt.text = self._faceCO.expressionName
	self._lockFaceTxt.text = self._faceCO.expressionName

	local path1 = kExpressionIconPath[self._faceCO.expressionID] or kExpressionIconPath[6]
	local path2 = kExpressionIconPath2[self._faceCO.expressionID] or kExpressionIconPath2[6]

	IconLoader.setSprite(self._expressionIconImg, IconType.DynSpriteAtlas_CharacterSystem, path1)
	IconLoader.setSprite(self._expressionSelectIconImg, IconType.DynSpriteAtlas_CharacterSystem, path2)

	local isCanUnlock = true

	if self._faceCO.expressionID == 1 then
		-- block empty
	else
		local unlockCO
		local expressionID = self._faceCO.expressionID > 9 and 9 or self._faceCO.expressionID
		local universallyUnlockCO = PastInfoConfig.instance:getUniversallyUnlockConfig(expressionID + 2000)

		if not universallyUnlockCO then
			printError("找不到通用解锁信息", "表情id", self._faceCO.expressionID)

			return
		end

		local condition = unlockCO ~= nil and unlockCO.condition or universallyUnlockCO.condition

		condition = condition or {}

		local heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)
		local heroTacit = heroData and heroData:getTacit() or 0
		local heroPowerLv = heroData and heroData:getPowerLv() or 0
		local heroLv = heroData and heroData:getLevel() or 0

		for i, v in ipairs(condition) do
			if v.type == "tacitLv" then
				self._lockTxt.text = string.format("%d解锁", v.value)

				if heroTacit < v.value then
					isCanUnlock = false

					break
				end
			end

			if v.type == "powerLv" then
				self._lockTxt.text = string.format("亲和度%d解锁", v.value)

				if heroPowerLv < v.value then
					isCanUnlock = false

					break
				end
			end

			if v.type == "heroLv" then
				self._lockTxt.text = string.format("等级达到%d解锁", v.value)

				if heroLv < v.value then
					isCanUnlock = false

					break
				end
			end
		end
	end

	self._isUnlock = isCanUnlock

	if self._isUnlock then
		goutil.setActive(self._useMarkGo, self._useFaceId == self._faceCO.expressionID)
		goutil.setActive(self._lockPanelGo, false)
		goutil.setActive(self._unlockGo, true)
	else
		goutil.setActive(self._unlockGo, false)
		goutil.setActive(self._useMarkGo, false)
		goutil.setActive(self._lockPanelGo, true)
		goutil.setActive(self._btnUse.gameObject, false)
	end

	goutil.setActive(self._selectObj, self._selectFaceId == self._faceCO.expressionID)
	goutil.setActive(self._expressionSelectIconImg.gameObject, self._selectFaceId == self._faceCO.expressionID)

	if self._ownHero then
		goutil.setActive(self._btnUse.gameObject, self._selectFaceId == self._faceCO.expressionID and self._useFaceId ~= self._faceCO.expressionID)
	else
		goutil.setActive(self._btnUse.gameObject, false)
	end
end

function M:OnDestroy()
	self._btnSelect:RemoveClickListener()
	self._btnUse:RemoveClickListener()
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:playOpenAni()
	self._animation:Stop()
	self._animation:Play("role_other_item_open")
end

function M:playAniByName(aniName)
	self._animation:Stop()
	self._animation:Play(aniName)
end

function M:StopAni()
	self._animation:Stop()
end

function M:fixAni()
	self._animation:Stop()
	self._animation:Play("role_other_item_default")
end

return M
