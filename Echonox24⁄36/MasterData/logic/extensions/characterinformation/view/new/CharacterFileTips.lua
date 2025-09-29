-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterFileTips.lua

module("logic.extensions.characterinformation.view.new.CharacterFileTips", package.seeall)

local M = class("CharacterFileTips", ViewComponent)
local infoType = CharacterInfoEnum.UnlockTyp

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._imgCarrer = self:getImage("role_file_tips_copy_26914274")
	self._imgRoleIcon = self:getImage("role_file_tips_copy_-2064620292")
	self._txtDepartment = self:getUIComponent("role_file_tips_copy_1012020691", UIComponentType.TextMeshProUGUI)
	self._txtInfo = {
		[infoType.Name] = self:getUIComponent("role_file_tips_copy_2132348993", UIComponentType.TextMeshProUGUI),
		[infoType.OrganName] = self:getUIComponent("role_file_tips_copy_-1597596143", UIComponentType.TextMeshProUGUI),
		[infoType.Height] = self:getUIComponent("role_file_tips_copy_-1734325840", UIComponentType.TextMeshProUGUI),
		[infoType.Weight] = self:getUIComponent("role_file_tips_copy_-730206977", UIComponentType.TextMeshProUGUI),
		[infoType.Birth] = self:getUIComponent("role_file_tips_copy_1460374666", UIComponentType.TextMeshProUGUI),
		[infoType.Ability] = self:getUIComponent("role_file_tips_copy_-196616865", UIComponentType.TextMeshProUGUI),
		[infoType.Area] = self:getUIComponent("role_file_tips_copy_641736034", UIComponentType.TextMeshProUGUI),
		[infoType.BaseInfo] = self:getUIComponent("role_file_tips_copy_77974126", UIComponentType.TextMeshProUGUI)
	}
	self._txtGetTime = self:getUIComponent("role_file_tips_copy_225855983", UIComponentType.TextMeshProUGUI)
	self._txtActionTime = self:getUIComponent("role_file_tips_copy_1205391327", UIComponentType.TextMeshProUGUI)
	self._txtSpFileLst = {
		[infoType.SpFile1] = {
			go = self:getGo("role_file_tips_copy_1368877684"),
			txtTitle = self:getUIComponent("role_file_tips_copy_2079205461", UIComponentType.TextMeshProUGUI),
			txt = self:getUIComponent("role_file_tips_copy_-1826772701", UIComponentType.TextMeshProUGUI)
		},
		[infoType.SpFile2] = {
			go = self:getGo("role_file_tips_copy_-1162534469"),
			txtTitle = self:getUIComponent("role_file_tips_copy_-1149834649", UIComponentType.TextMeshProUGUI),
			txt = self:getUIComponent("role_file_tips_copy_175706615", UIComponentType.TextMeshProUGUI)
		},
		[infoType.SpFile3] = {
			go = self:getGo("role_file_tips_copy_-1066633584"),
			txtTitle = self:getUIComponent("role_file_tips_copy_-457352700", UIComponentType.TextMeshProUGUI),
			txt = self:getUIComponent("role_file_tips_copy_-433867869", UIComponentType.TextMeshProUGUI)
		}
	}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonType)
	self:setEvent(true)
	self:_blockKey(false)

	local info = self:getFirstParam()

	self._heroId = info.heroId

	printWarn("heroId:", self._heroId)

	local heroData = self:getHeroDataLeatest()

	if not heroData then
		self:close()

		return
	end

	self:refreshView()
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	self:setEvent(false)

	self._pastInfoContent = nil

	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = nil
end

function M:onExitFinished()
	return
end

function M:_blockKey(block)
	self._canvasGroup.interactable = not block
end

function M:setEvent(add)
	if add then
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	settimer(1, function()
		self:_setNewRead()
	end, self, false)
end

function M:getHeroDataLeatest()
	return HeroDepotModel.instance:getHeroInfoByID(self._heroId)
end

function M:getInfoStr(pastId, isLock)
	if not self._pastInfoContent then
		local heroData = self:getHeroDataLeatest()
		local heroId = heroData:getId()
		local characterInfoCo = heroData:getCharacterInfoCo()
		local organizationCO = heroData:getOrganizationCO()
		local weight = string.format("%skg", CharacterInformationModel.instance:getHeroWeight(heroId))
		local birthdayStr = characterInfoCo.birthday or ""

		if string.match(birthdayStr, "#") then
			local arrSingleStep = string.split(birthdayStr, "#")

			birthdayStr = string.format(lang("tip_month_day"), arrSingleStep[1], arrSingleStep[2])
		end

		local base = "<line-indent=19%>"

		self._pastInfoContent = {
			[infoType.Name] = {
				normal = heroData:getName()
			},
			[infoType.OrganName] = {
				normal = organizationCO and organizationCO.name or ""
			},
			[infoType.Height] = {
				normal = characterInfoCo and characterInfoCo.hight or ""
			},
			[infoType.Weight] = {
				normal = weight
			},
			[infoType.Birth] = {
				normal = birthdayStr
			},
			[infoType.Ability] = {
				normal = characterInfoCo and characterInfoCo.ability or ""
			},
			[infoType.Area] = {
				normal = characterInfoCo and characterInfoCo.state or ""
			},
			[infoType.BaseInfo] = {
				normal = characterInfoCo and string.format("%s%s", base, characterInfoCo.baseInfo) or ""
			}
		}

		for _, val in pairs(self._pastInfoContent) do
			val.normal = StringUtil.replaceTMPBlackBlock(val.normal, "#000000")
		end

		for i = infoType.Name, infoType.BaseInfo do
			local normalStr = self._pastInfoContent[i].normal
			local lockStr = string.nilorempty(normalStr) and "XXX" or normalStr

			lockStr = StringUtil.randomReplaceTMPToBlackBlock(lockStr, "#000000")
			self._pastInfoContent[i].lock = lockStr
		end

		for i = infoType.SpFile1, infoType.SpFile3 do
			local key = string.format("spfile%s", i - 100)
			local show = false

			if characterInfoCo and characterInfoCo[key] then
				show = true
			end

			if show then
				self._pastInfoContent[i] = {
					titleLock = StringUtil.replaceTMPBlackBlock(characterInfoCo[key][1].title, "#000000"),
					contentLock = StringUtil.replaceTMPBlackBlock(characterInfoCo[key][1].content, "#000000"),
					titleNormal = characterInfoCo[key][2].title,
					contentNormal = characterInfoCo[key][2].content
				}
			end
		end
	end

	local data = self._pastInfoContent[pastId]

	if data then
		if isLock then
			if pastId >= infoType.SpFile1 then
				return data.titleLock, data.contentLock
			else
				return data.lock
			end
		elseif pastId >= infoType.SpFile1 then
			return data.titleNormal, data.contentNormal
		else
			return data.normal
		end
	end

	return nil
end

function M:refreshView()
	local heroData = self:getHeroDataLeatest()
	local heroId = heroData:getId()
	local characterCo = heroData:getCharacterCo()
	local characterInfoCo = heroData:getCharacterInfoCo()
	local organizationCO = heroData:getOrganizationCO()

	self._newIds = CharacterInformationModel.instance:getNewPastInfoLst(heroId, false)

	if #self._newIds > 0 then
		if Astral.OSDef.isEditor then
			printWarn("有new")
			TableUtil.dump(self._newIds)
		end

		self:_blockKey(true)
	end

	if characterCo then
		IconLoader.setSprite(self._imgCarrer, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[characterCo.camp])

		local modelCO = ModelConfig.instance:getModelConfig(characterCo.modelId)

		IconLoader.setSprite(self._imgRoleIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end

	self._txtDepartment.text = organizationCO and organizationCO.name or ""
	self._txtGetTime.text = self:_gainTimeToStr(heroData:getGainHeroTime())
	self._txtActionTime.text = heroData:getPveWinTimes()

	for keyStr, valInt in pairs(infoType) do
		if self._txtInfo[valInt] then
			local unLock = CharacterInformationModel.instance:getUnlockPastInfo(heroId, valInt)
			local isNew = CharacterInformationModel.instance:getIsNewPastInfo(heroId, valInt)

			self._txtInfo[valInt].text = self:getInfoStr(valInt, not unLock or isNew)

			if self._txtInfo[valInt].transform.childCount > 0 then
				local _cg = goutil.addComponentOnce(self._txtInfo[valInt].transform:GetChild(0).gameObject, ComponentType.CanvasGroup)

				_cg.alpha = 1
			end
		end
	end

	for pastId, comps in pairs(self._txtSpFileLst) do
		local unLock = CharacterInformationModel.instance:getUnlockPastInfo(heroId, pastId)
		local isNew = CharacterInformationModel.instance:getIsNewPastInfo(heroId, pastId)
		local title, content = self:getInfoStr(pastId, not unLock or isNew)

		goutil.setActive(comps.go, title)

		if title then
			comps.txtTitle.text = title
			comps.txt.text = content

			if comps.txt.transform.childCount > 0 then
				for i = 0, comps.txt.transform.childCount - 1 do
					local _cg = goutil.addComponentOnce(comps.txt.transform:GetChild(i).gameObject, ComponentType.CanvasGroup)

					_cg.alpha = 1
				end
			end

			if comps.txtTitle.transform.childCount > 0 then
				for i = 0, comps.txtTitle.transform.childCount - 1 do
					local _cg = goutil.addComponentOnce(comps.txtTitle.transform:GetChild(i).gameObject, ComponentType.CanvasGroup)

					_cg.alpha = 1
				end
			end
		end
	end
end

function M:_gainTimeToStr(itemDataGainTimeStamp)
	local ts = math.floor(itemDataGainTimeStamp / 1000)
	local str = ServerTime.formatTimeServerLook(ts, "%Y-%m-%d %H:%M:%S")

	return str
end

function M:_setNewRead()
	if #self._newIds > 0 then
		self._cacheTweenLst = {}

		for _, tweener in ipairs(self._cacheTweenLst or {}) do
			if tweener then
				tweener:Kill(false)
			end
		end

		for _, _id in ipairs(self._newIds) do
			if _id >= infoType.SpFile1 then
				local comps = self._txtSpFileLst[_id]
				local title, content = self:getInfoStr(_id, false)

				self:_blackBlockFadeAni(comps.txtTitle, title)
				self:_blackBlockFadeAni(comps.txt, content)
			else
				local txt = self._txtInfo[_id]

				self:_blackBlockFadeAni(txt, self:getInfoStr(_id, false))
			end
		end

		settimer(0.4, function()
			self:_blockKey(false)
		end, self, false)
		CharacterInformationModel.instance:setReadPastInfoIds(self._heroId, self._newIds)
	end
end

function M:_blackBlockFadeAni(txt, finalStr)
	if not txt then
		return
	end

	if txt.transform.childCount > 0 then
		for i = 0, txt.transform.childCount - 1 do
			local go = txt.transform:GetChild(i).gameObject

			if string.match(go.name, "TMP") then
				local _cg = goutil.addComponentOnce(txt.transform:GetChild(i).gameObject, ComponentType.CanvasGroup)

				if _cg then
					local tween = _cg:DOFade(0, 0.2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
						txt.text = finalStr

						_cg:DOFade(1, 0.2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
					end, self)

					table.insert(self._cacheTweenLst, tween)
				end
			end
		end
	else
		txt.text = finalStr
	end
end

return M
