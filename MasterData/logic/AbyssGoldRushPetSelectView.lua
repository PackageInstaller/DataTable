-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushPetSelectView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushPetSelectView", package.seeall)

local AbyssGoldRushPetSelectView = class("AbyssGoldRushPetSelectView", ViewComponent)

function AbyssGoldRushPetSelectView:ctor()
	AbyssGoldRushPetSelectView.super.ctor(self)
end

function AbyssGoldRushPetSelectView:unbindEvents()
	AbyssGoldRushPetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function AbyssGoldRushPetSelectView:bindEvents()
	AbyssGoldRushPetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function AbyssGoldRushPetSelectView:buildUI()
	AbyssGoldRushPetSelectView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnSure = self:getGo("btn")
	self._txtCount = self:getTxt("txtCount")
end

function AbyssGoldRushPetSelectView:onExit()
	AbyssGoldRushPetSelectView.super.onExit(self)
end

function AbyssGoldRushPetSelectView:onEnter()
	AbyssGoldRushPetSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushPushStepRes, self._PM_AbyssGoldRushPushStepRes, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)

	if not AbyssGoldRushGameModel.instance:isInGame() then
		self:close()

		return
	end

	self._recommondType = nil
	self._selectPetMap = {}

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	self._maxSelectCount = 0

	if gameInfo.baseInfo.curStepId == 1 then
		local stepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, gameInfo.baseInfo.curStepId)
		local roundCfg = AbyssGoldRushConfig.instance:getRoundCfg(self._activityId, stepCfg.petBoxRound)

		self._maxSelectCount = roundCfg.selectPetCount

		self:_refreshView()
	else
		self:close()

		return
	end
end

function AbyssGoldRushPetSelectView:_refreshView()
	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	if gameInfo then
		local supportPetTypeMap = {}

		for i, v in ipairs(gameInfo.petsCanSelect or {}) do
			local petCfg = AbyssGoldRushConfig.instance:getSupportPet(v.creepsId)

			for j, id in ipairs(petCfg.petGroupIds or {}) do
				supportPetTypeMap[id] = checknumber(supportPetTypeMap[id]) + 1

				if self._recommondType == nil then
					self._recommondType = id
				elseif self._recommondType ~= id and checknumber(supportPetTypeMap[self._recommondType]) < supportPetTypeMap[id] then
					self._recommondType = id
				end
			end
		end

		local petList = {}

		for i, v in ipairs(gameInfo.petsCanSelect or {}) do
			local petCfg = AbyssGoldRushConfig.instance:getSupportPet(v.creepsId)
			local isRecommondType = false

			for j, id in ipairs(petCfg.petGroupIds or {}) do
				if checknumber(self._recommondType) == id then
					isRecommondType = true

					break
				end
			end

			table.insert(petList, {
				data = v,
				index = i,
				isRecommondType = isRecommondType
			})
		end

		table.sort(petList, function(a, b)
			if a.isRecommondType ~= b.isRecommondType then
				return a.isRecommondType
			end

			return a.index < b.index
		end)

		local sortPetsCanSelect = {}

		for i, v in ipairs(petList) do
			table.insert(sortPetsCanSelect, v.data)
		end

		self._tableList:reloadData(sortPetsCanSelect)
	end

	local selectCount = table.nums(self._selectPetMap)

	self._txtCount.text = langPara("选择：<color=#fef2bd>%s</color>/%s", selectCount, self._maxSelectCount)
end

function AbyssGoldRushPetSelectView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "mask/con")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local cover = goutil.findChild(go, "cover")
	local goAttr = goutil.findChild(cover, "layout/Nego_Attr/Img_attr")
	local attrIcon = goAttr:GetComponent("UIImageSpriteChange")
	local goJob = goutil.findChild(cover, "layout/Nego_Job/ImgC_Job")
	local ImgC_Job = goJob:GetComponent("UIImageSpriteChange")
	local Nego_Job1 = goutil.findChild(cover, "layout/Nego_Job1")
	local goJob1ImgC = goutil.findChild(cover, "layout/Nego_Job1/ImgC_Job")
	local ImgC_Job1 = goJob1ImgC:GetComponent("UIImageSpriteChange")
	local txtLv = goutil.findChildTextComponent(cover, "txtLvl")
	local buff = goutil.findChild(go, "buff")
	local tagRecommendGo = goutil.findChild(go, "tagRecommend")
	local btnPetInfo = goutil.findChild(go, "btnInfo")
	local petCfg = AbyssGoldRushConfig.instance:getSupportPet(data.creepsId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCfg.raceId))

	uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	txtLv.text = petCfg.lv

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petCfg.raceId)

	race = race % 10

	local targetValue = race - 1

	if attrIcon then
		attrIcon:SetState(targetValue)
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petCfg.raceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petCfg.raceId)

	if ImgC_Job then
		ImgC_Job:SetState(firstJobIdx - 1)
		GameUtil.SetActive(Nego_Job1, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(Nego_Job1, true)
			ImgC_Job1:SetState(secondJobIdx - 1 - 20)
		end
	end

	GameUtil.SetActive(tagSelect, self._selectPetMap[data.creepsId] == true)
	GameUtil.addClickHandler(petCon, function()
		self:_onSelectPet(data.creepsId)
	end)
	uGuiUtil.clearImage(buff)

	if data.withBuff == true then
		GameUtil.SetActive(buff, true)
		uGuiUtil.setSpriteToImage(buff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(petCfg.buffRes))
	else
		GameUtil.SetActive(buff, false)
	end

	local isRecommondType = false

	for i, v in ipairs(petCfg.petGroupIds or {}) do
		if checknumber(self._recommondType) == v then
			isRecommondType = true
		end
	end

	GameUtil.SetActive(tagRecommendGo, isRecommondType)
	GameUtil.addClickHandler(btnPetInfo, function()
		local co = MaterialMgr.getMatCfg(MatType.Pet, petCfg.raceId)
		local petMo = {
			_curZdl = 0,
			raceId = petCfg.raceId,
			level = co.maxLv,
			name = co.name,
			curFaceId = petCfg.raceId
		}

		petMo.awakenLv = CharacterConfig.instance:getMaxAwaken(petCfg.raceId)

		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function AbyssGoldRushPetSelectView:_clearPetCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "mask/con")
	local btnPetInfo = goutil.findChild(go, "btnInfo")

	uGuiUtil.clearImage(petCon)
	GameUtil.rmClickHandler(petCon)
	GameUtil.rmClickHandler(btnPetInfo)
end

function AbyssGoldRushPetSelectView:_onSelectPet(creepsId)
	if self._selectPetMap[creepsId] == true then
		self._selectPetMap[creepsId] = nil
	elseif table.nums(self._selectPetMap) >= self._maxSelectCount then
		FloatWordMgr.instance:show(lang("已达可选上限"))
	else
		self._selectPetMap[creepsId] = true
	end

	self:_refreshView()
end

function AbyssGoldRushPetSelectView:_onClickSure()
	local creepIds = {}

	for creepsId, v in pairs(self._selectPetMap) do
		if v == true then
			table.insert(creepIds, creepsId)
		end
	end

	if #creepIds <= 0 then
		FloatWordMgr.instance:show(lang("请选择精灵"))

		return
	end

	AbyssGoldRushGameController.instance:selectPet(self._activityId, 2, creepIds)
end

function AbyssGoldRushPetSelectView:_PM_AbyssGoldRushPushStepRes()
	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
	local curStepId = gameInfo.baseInfo.curStepId

	if curStepId == 1 then
		self:_refreshView()

		return
	elseif curStepId == 2 then
		AbyssGoldRushGameController.instance:openMissionView(self._activityId)

		return
	else
		self:close()

		return
	end
end

return AbyssGoldRushPetSelectView
