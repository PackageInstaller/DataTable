-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleBanPlayer.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleBanPlayer", package.seeall)

local CampScuffleBanPlayer = class("CampScuffleBanPlayer")

function CampScuffleBanPlayer:ctor(isLeft)
	self._scufflePetCardList = {}
	self._isLeft = isLeft
end

function CampScuffleBanPlayer:buildUI(parent, cell)
	self.mainGO = parent
	self._cellGo = cell
	self._myHead = goutil.findChild(self.mainGO, "head")
	self._myTxtRank = goutil.findChildTextComponent(self.mainGO, "txtRank")
	self._myTxtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._myTxtAreaName = goutil.findChildTextComponent(self.mainGO, "txtArea")
	self._myLevelIcon = goutil.findChild(self.mainGO, "grade/icon")
	self._myLevelName = goutil.findChildTextComponent(self.mainGO, "grade/txt")
	self._content = goutil.findChild(self.mainGO, "tableview/Viewport/Content")
end

function CampScuffleBanPlayer:destroyUI()
	self.mainGO = nil
	self._cellGo = nil
end

function CampScuffleBanPlayer:onExit()
	self:_removeCardList()
	self:_removeHead()
end

function CampScuffleBanPlayer:setPlayerInfo(isSelf)
	if isSelf then
		self._myTxtRank.text = "排名 " .. CampScuffleModel.instance:getMyRank()
		self._myTxtName.text = RoleModel.instance:getUserName()
		self._myTxtAreaName.text = RoleModel.instance:getAreaName()

		HeadItemController.instance:setMyHeadCell(self._myHead)

		local cfg = CampScuffleController.instance:getCurLevelCfg()

		if cfg then
			uGuiUtil.setSpriteToImage(self._myLevelIcon, uGuiUtil.SpriteType.BigBg, string.format(CampScuffleModel.LevelPath, cfg.icon))

			self._myLevelName.text = cfg.levelName
		end
	else
		local rank = CampScuffleModel.instance:getEnemyRank()

		if checknumber(rank) < 0 then
			rank = lang("未上榜")
		end

		self._myTxtRank.text = "排名 " .. rank
		self._myTxtName.text = CampScuffleModel.instance:getEnemyName()
		self._myTxtAreaName.text = CampScuffleModel.instance:getEnemyAreaName()

		HeadItemController.instance:setHeadCellByInfo(self._myHead, CampScuffleModel.instance:getEnemyHeadInfo())

		local cfg = CampGameConfig.instance:getLevelCfgByScore(CampScuffleModel.instance:getEnemyScore())

		if cfg then
			uGuiUtil.setSpriteToImage(self._myLevelIcon, uGuiUtil.SpriteType.BigBg, string.format(CampScuffleModel.LevelPath, cfg.icon))

			self._myLevelName.text = cfg.levelName
		end
	end
end

function CampScuffleBanPlayer:_removeLevelIcon()
	local levelIcon = Framework.ImageBigBG.Get(self._myLevelIcon)

	levelIcon:ClearImage()
end

function CampScuffleBanPlayer:_removeHead()
	MaterialMgr.resetAll(self._myHead)
end

function CampScuffleBanPlayer:initCardList(creepsIdList)
	self:_removeCardList()
	self:addCardList(creepsIdList)
end

function CampScuffleBanPlayer:addCardList(addList)
	local count = #self._scufflePetCardList
	local internalTime = 0.3

	for index, id in ipairs(addList) do
		local go = goutil.cloneAndSetParent(self._cellGo, self._content.transform, "petCard" .. index)

		go:SetActive(true)

		local scufflePetCard = GameUtil.AddLuaOnce(go, CampScufflePetCard)

		scufflePetCard:buildUI(go)
		scufflePetCard:init(index + count, id, internalTime, self._isLeft)

		internalTime = internalTime + 0.3

		table.insert(self._scufflePetCardList, scufflePetCard)
	end
end

function CampScuffleBanPlayer:_removeCardList()
	for i, v in ipairs(self._scufflePetCardList) do
		v:onReset()
	end

	table.clear(self._scufflePetCardList)
	goutil.clearChildren(self._content)
end

return CampScuffleBanPlayer
