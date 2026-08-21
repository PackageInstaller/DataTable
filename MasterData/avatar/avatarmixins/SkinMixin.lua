-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\SkinMixin.lua

local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResSeasonSkinShow = require("ClientData/ResSeasonSkinShow")
local ResItem = require("ClientData/ResItem")
local ResClientNotice = require("ClientData/ResClientNotice")
local SkinMixin = {}

function SkinMixin:initSkinMixin(baseData, syncData)
	local skinData = syncData.bag.hero_skin or {}

	self.skinItems = {}
	self.canNewBaseUnlockDic = {}
	self.canNewSkinUnlockDic = {}
	self.unlockNewBase = {}
	self.unlockNewSkin = {}

	self:initSkinData(skinData)
end

function SkinMixin:initSkinData(skinData)
	self.skinData = {}

	for idx, data in ipairs(skinData.data) do
		if data.id then
			local sData = {}

			sData.skin = {}
			sData.base = {}

			if data.skin then
				sData.skin = ClientUtils.getBitsDictFromByteString(data.skin)
			end

			if data.base then
				sData.base = ClientUtils.getBitsDictFromByteString(data.base)
			end

			self.skinData[data.id] = sData
		end
	end

	self:checkReplaceSkinData()

	for heroId, skinDict in pairs(self.skinData) do
		for skinId, _ in pairs(skinDict.skin) do
			if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][skinId] and ResItemHeroSkin[heroId][skinId].itemId then
				table.insert(self.skinItems, BaseObject.GetObject(ResItemHeroSkin[heroId][skinId].itemId))
			end
		end
	end

	self:checkBaseNew()
end

function SkinMixin:checkReplaceHeroWearSkin(heroId, skinId, upgradeSkinId)
	for gid, hero in pairs(self.heroDic) do
		if hero.id == heroId and hero.skin == skinId then
			RPC.skinWear(hero.gid, upgradeSkinId, Const.SKIN_TYPE_SKIN)
		end
	end
end

function SkinMixin:checkReplaceSkinData()
	for heroId, skinDict in pairs(self.skinData) do
		for skinId, _ in pairs(skinDict.skin) do
			if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][skinId] and ResItemHeroSkin[heroId][skinId].upgrade_skin_id then
				local upgradeSkinId = ResItemHeroSkin[heroId][skinId].upgrade_skin_id

				if skinDict.skin[upgradeSkinId] then
					skinDict.skin[skinId] = nil

					self:checkReplaceHeroWearSkin(heroId, skinId, upgradeSkinId)

					for i, v in pairs(self.skinItems) do
						if v.id == ResItemHeroSkin[heroId][skinId].itemId then
							table.remove(self.skinItems, i)

							break
						end
					end
				end
			end
		end
	end
end

function SkinMixin:getSkinDataByHeroId(heroId)
	return self.skinData[heroId] or {}
end

function SkinMixin:hasGetHeroSkin(skinItemId)
	local resData = ResItem[skinItemId] or {}
	local skinData = self.skinData[resData.extend_args1]

	if skinData and skinData.skin and skinData.skin[resData.extend_args2] then
		return true
	else
		return false
	end
end

function SkinMixin:getUpgradeSkinItemIdByUpgradeItemId(itemId)
	local resData = ResItem[itemId] or {}
	local heroId = resData.extend_args1
	local preSkinId = resData.extend_args2

	if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][preSkinId] and ResItemHeroSkin[heroId][preSkinId].upgrade_skin_id then
		local upgradeSkinId = ResItemHeroSkin[heroId][preSkinId].upgrade_skin_id

		if ResItemHeroSkin[heroId][upgradeSkinId] then
			return ResItemHeroSkin[heroId][upgradeSkinId].itemId
		end
	end
end

function SkinMixin:hasGetHeroUpgradeSkinByUpgradeItemId(itemId)
	local resData = ResItem[itemId] or {}
	local heroId = resData.extend_args1
	local preSkinId = resData.extend_args2

	if heroId and preSkinId and self.skinData[heroId] and self.skinData[heroId].skin then
		local skins = self.skinData[heroId].skin

		if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][preSkinId] and ResItemHeroSkin[heroId][preSkinId].upgrade_skin_id then
			local upgradeSkinId = ResItemHeroSkin[heroId][preSkinId].upgrade_skin_id

			if skins[upgradeSkinId] then
				return true
			end
		end
	end
end

function SkinMixin:hasGetSkinByHeroAndSkinId(heroId, skinId)
	if heroId and skinId and self.skinData[heroId] and self.skinData[heroId].skin then
		local skins = self.skinData[heroId].skin

		if skins[skinId] then
			return true
		end

		if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][skinId] and ResItemHeroSkin[heroId][skinId].upgrade_skin_id then
			local upgradeSkinId = ResItemHeroSkin[heroId][skinId].upgrade_skin_id

			if skins[upgradeSkinId] then
				return true
			end
		end
	end

	return false
end

function SkinMixin:checkHasUpgradeSkinAndGet(heroId, skinId)
	if ResItemHeroSkin[heroId] and ResItemHeroSkin[heroId][skinId] and ResItemHeroSkin[heroId][skinId].upgrade_skin_id then
		local upgradeSkinId = ResItemHeroSkin[heroId][skinId].upgrade_skin_id

		if self.skinData[heroId] and self.skinData[heroId].skin then
			local skins = self.skinData[heroId].skin

			if skins[upgradeSkinId] then
				return true
			end
		end
	end

	return false
end

function SkinMixin:onSkinWearResp(heroGid, id, type)
	local hero = CurAvatar.heroDic[heroGid]

	if hero then
		if type == Const.SKIN_TYPE_SKIN then
			hero:setSkin(id)
		elseif type == Const.SKIN_TYPE_BASE then
			hero:setBase(id)
		end
	end

	local ui = UIManager.getUI("heroMainDlg", nil, false)

	if ui then
		ui:refreshSkinPanel(true)
	end
end

function SkinMixin:onSkinAddNotify(resid, id, type)
	if not self.skinData[resid] then
		local sData = {}

		sData.skin = {}
		sData.base = {}
		self.skinData[resid] = sData
	end

	if type == Const.SKIN_TYPE_SKIN then
		self.skinData[resid].skin[id] = true
		self.unlockNewSkin[resid] = id

		local needShow = true

		if ResItemHeroSkin[resid] and ResItemHeroSkin[resid][id] and ResItemHeroSkin[resid][id].itemId and ResSeasonSkinShow[ResItemHeroSkin[resid][id].itemId] then
			local ui = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

			if ui and ui:getVisible() then
				needShow = false
			end
		end

		if needShow then
			self:showSkinGetNewDlg(resid, id)
		end

		self:checkReplaceSkinData()
		self:checkBagRedHintOpen()

		if ResItemHeroSkin[resid] and ResItemHeroSkin[resid][id] and ResItemHeroSkin[resid][id].itemId then
			table.insert(self.skinItems, BaseObject.GetObject(ResItemHeroSkin[resid][id].itemId))
			self:onCollectAchieveProgressNotify(Const.CRYSTAL_TYPE_SKIN, ResItemHeroSkin[resid][id].itemId, 1, {})
		end

		self:onSkinCheckNew()
	elseif type == Const.SKIN_TYPE_BASE then
		self.unlockNewBase[resid] = id
		self.skinData[resid].base[id] = true

		local ui = UIManager.getUI("getBaseBox", true)

		ui:onGetSkin(resid, id)
	end
end

function SkinMixin:onSkinUnlockResp(hero_gid, id)
	local hero = CurAvatar.heroDic[hero_gid]

	if hero then
		local heroId = hero.id

		if not self.skinData[heroId] then
			local sData = {}

			sData.skin = {}
			sData.base = {}
			self.skinData[heroId] = sData
		end

		self.skinData[heroId].base[id] = true

		self:onSkinCheckNew()
	end
end

function SkinMixin:showSkinGetNewDlg(heroId, skinId)
	local getNewSkinDlg = UIManager.tryHideUI("getNewSkinDlg")

	getNewSkinDlg = getNewSkinDlg or UIManager.getUI("getNewSkinDlg", true)

	getNewSkinDlg:addOneSkin(heroId, skinId)
end

function SkinMixin:onSkinCheckNew()
	self:checkSkinNew()
	self:checkBaseNew()
	self:checkSeasonRelicRedDot()

	local ui = UIManager.getUI("heroMainDlg", nil, false)

	if ui then
		ui:refreshSkinPanel()
	end
end

function SkinMixin:checkBaseNew()
	local hasNew = false
	local heroBaseHasNew

	for i, newBase in pairs(self.unlockNewBase) do
		heroBaseHasNew = true
	end

	for heroId, heroBase in pairs(ResItemHeroBase) do
		local svrBaseData = self.skinData[heroId] and self.skinData[heroId].base or nil
		local hero = CurAvatar:getBestHeroByRid(heroId, "star")
		local heroHasNew = false

		if hero then
			if heroBaseHasNew and self.unlockNewBase[heroId] then
				heroHasNew = true
				hasNew = true
			else
				for id, data in ipairs(heroBase) do
					local limitstar = data.unlock_star

					if limitstar <= hero.star and (not svrBaseData or not svrBaseData[id]) then
						hasNew = hasNew or true
						heroHasNew = true

						break
					end
				end
			end

			self.canNewBaseUnlockDic[hero.gid] = heroHasNew
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_BASE, hasNew)
end

function SkinMixin:checkSkinNew()
	local hasNew = false

	for heroId, newSkin in pairs(self.unlockNewSkin) do
		local geted = CurAvatar.handBookHeroDic[heroId] ~= nil
		local isSkinNew = false

		if geted then
			hasNew = true
			isSkinNew = true
		end

		local hero = CurAvatar:getBestHeroByRid(heroId, "star")

		if hero then
			self.canNewSkinUnlockDic[hero.gid] = isSkinNew
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_HERO_SKIN, hasNew)
end

function SkinMixin:onSkinRepeatNotify(res_id, id, type)
	if type == Const.SKIN_TYPE_SKIN then
		local config = ResItemHeroSkin[res_id] and ResItemHeroSkin[res_id][id]

		if config then
			local item = BaseObject.GetObject(Const.MONEY_ID_SKIN_COIN, config.back_num)

			local function openCb()
				MsgManager.notice(utils.format(ResClientNotice[776].notice, item.name, item.num))
			end

			local function func()
				coroutine.wait(1)
				self:showCommonBonus(Const.LISTATTR_USETYPE_COMMON, {}, {
					{
						id = item.id,
						num = item.num
					}
				}, {}, {}, {}, {}, "", nil, openCb)
			end

			local co = coroutine.create(func)

			coroutine.resume(co)
		end
	elseif type == Const.SKIN_TYPE_BASE then
		local config = ResItemHeroBase[res_id] and ResItemHeroBase[res_id][id]

		if config then
			local item = BaseObject.GetObject(Const.MONEY_ID_SKIN_COIN, config.back_num)

			local function openCb()
				MsgManager.notice(utils.format(ResClientNotice[776].notice, item.name, item.num))
			end

			local function func()
				coroutine.wait(1)
				self:showCommonBonus(Const.LISTATTR_USETYPE_COMMON, {}, {
					{
						id = item.id,
						num = item.num
					}
				}, {}, {}, {}, {}, "", nil, openCb)
			end

			local co = coroutine.create(func)

			coroutine.resume(co)
		end
	end
end

return SkinMixin
