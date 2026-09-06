-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessItemSeat.lua

module("logic.extensions.autochess.view.AutochessItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local AutochessItemSeat = class("AutochessItemSeat", ItemSeat)

function AutochessItemSeat.AddOnce(go)
	local component = AutochessItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, AutochessItemSeat)

	return component
end

function AutochessItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, AutochessItemSeat))
end

function AutochessItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, AutochessItemSeat)
end

function AutochessItemSeat:onExit()
	AutochessItemSeat.super.onExit(self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function AutochessItemSeat:ctor(target)
	NotifyDispatcher.extend(self)

	self.lastRace = -1
	self._character = nil
	self.petId = -1
	self._posId = 0
	self._tempPetId = -1
	self._order = 0
	self._isHiding = false
	self._isForbid = false
	self._target = target

	local Nego_Left = self._target.transform.parent.parent
	local index = string.sub(self._target.name, -1)

	self._index = checknumber(index)

	local pathLayerUI = "layerUI/item" .. index
	local layerBgGo = goutil.findChild(self._target, "bg")
	local layerUIGo = goutil.findChild(Nego_Left, pathLayerUI)

	self._layerBgGo = layerBgGo
	self._ImgC_Forbid = goutil.findChild(layerBgGo, "ImgC_Forbid"):GetComponent("UIImageSpriteChange")
	self._ImgC_ForbidImage = self._ImgC_Forbid:GetComponent(goutil.Type_UIImage)
	self._necessary = goutil.findChild(layerBgGo, "necessary")
	self._forbid = goutil.findChild(layerBgGo, "forbid")
	self._restrainTxt = goutil.findChildTextComponent(layerBgGo, "Text")
	self._Nego_Character = goutil.findChild(self._target, "Nego_Character")
	self._layerUI = layerUIGo
	self._imageGo = goutil.findChild(layerUIGo, "bg")
	self._ImgC_Info = goutil.findChild(layerUIGo, "ImgC_Info"):GetComponent("UIImageSpriteChange")
	self._Btn_Summon = goutil.findChild(layerUIGo, "Btn_Summon")
	self._txtLv = goutil.findChild(layerUIGo, "txtLv"):GetComponent(goutil.Type_UIText)
	self._txtAtkType = goutil.findChild(layerUIGo, "txtAtkType"):GetComponent(goutil.Type_UIText)
	self._ImgC_Title = goutil.findChildComponent(layerUIGo, "ImgC_Title", "UIImageSpriteChange")
	self._txtTitle = goutil.findChildComponent(layerUIGo, "txtTitle", goutil.Type_UIText)

	if self._txtTitle then
		self._txtTitle.gameObject:SetActive(false)
	end

	if self._ImgC_Title then
		self._ImgC_Title.gameObject:SetActive(false)
	end

	self._starConGo = goutil.findChild(self._target, "star")
	self._starGos = {}

	for i = 1, AutochessController.MaxStarNum do
		self._starGos[i] = goutil.findChild(self._starConGo, "stars/star" .. i)
	end
end

function AutochessItemSeat:setStar()
	self._view = view

	local petId = self:GetData()

	for i, v in ipairs(self._starGos) do
		goutil.setActive(v, false)
	end

	local hasPet = petId and petId > 0
	local star = 0

	if hasPet then
		local creepsCfg = AutochessConfig.instance:getCreepsCfg(petId)
		local petInfoList = AutochessModel.instance:getPetInfoList()

		star = petInfoList[creepsCfg.raceId] or 0

		for i, v in ipairs(self._starGos) do
			goutil.setActive(v, i <= star)
		end
	end

	goutil.setActive(self._starConGo, hasPet and star > 0)
end

function AutochessItemSeat:playUpEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	local effName = "20230728/zizouqi/fx_ui_zizouqi_jiaoseshengji.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self._view, effName, nil, 0, 0, false)

	self._effectHandler:setParent(self._target.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)

	self._effectHandler.hideEffWhileNotOnTop = false

	self._effectHandler:setSortingOrder(201)
end

return AutochessItemSeat
