-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/music/HandbookMusicEntryView.lua

module("logic.extensions.playerinfo.view.handbook.music.HandbookMusicEntryView", package.seeall)

local M = class("HandbookMusicEntryView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.Music
end

function M:buildUI()
	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._goZhiZhenStop = self:getGo("handbook_music_view_58709981")
	self._goZhiZhenPlay = self:getGo("handbook_music_view_493320744")
	self._loopList = LoopListHelper.New(self:getGo("handbook_music_view_-1023549144"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._txtName = self:getText("handbook_music_view_-1464840443")
	self._txtProcessTimeNow = self:getText("handbook_music_view_-163001938")
	self._txtProcessTimeMax = self:getText("handbook_music_view_-1388997039")
	self._sliderProcess = UIComponentType.SliderAdapter(self:getGo("handbook_music_view_-1807218172"))
	self._btnPre = self:getBtn("handbook_music_view_-2122826427")
	self._btnNext = self:getBtn("handbook_music_view_-60331051")
	self._togglePlay = self:getUIComponent("handbook_music_view_-489763121", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	self._btnReturn = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._txtName = nil
	self._txtProcessTimeNow = nil
	self._txtProcessTimeMax = nil
	self._sliderProcess = nil
	self._btnPre = nil
	self._btnNext = nil
	self._togglePlay = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._togglePlay:AddListener(self._onTogglePlay, self)
	self._sliderProcess:AddOnValueChanged(self._onMusicSliderValChanged, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._togglePlay:RemoveListener()
	self._sliderProcess:RemoveOnValueChanged()
end

function M:onEnter()
	self._playerControl = false
	self._currentBgmId = CriwareAudioPlayer.instance:getCurrentBgmId()

	self._togglePlay:ForceSetOn(false)

	self._musicId2Cell = {}
	self._musicId2Index = {}
	self._txtName.text = ""
	self._txtProcessTimeNow.text = self:_formatMusicTime(0)
	self._txtProcessTimeMax.text = self:_formatMusicTime(0)

	self._sliderProcess:SetValue(0)
	self:refreshLst()
end

function M:onExit()
	self._musicId2Cell = nil
	self._musicId2Index = nil

	self:setLastCell(nil)
	self:_playMusic(false)

	if self._currentBgmId and self._currentBgmId > 0 then
		CriwareAudioFacade.instance:stopBgm()
		CriwareAudioFacade.instance:playBgmInnerById(self._currentBgmId)
	end

	self._currentBgmId = nil

	self._loopList:ClearCells()

	self._musicGroup = nil
	self._isOn = nil
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickPre()
	if not self:getLastMusicId() then
		return
	end

	local curIndex = self:getCurPlayingMusicIndex()

	if not curIndex then
		return
	end

	local finalMusicId = -1

	while curIndex > 1 do
		curIndex = curIndex - 1

		local musicId = self._musicGroup[curIndex].id

		if GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Music, musicId) then
			finalMusicId = musicId

			break
		end
	end

	if finalMusicId > 0 then
		self._loopList:MoveToItemIndex(curIndex)
		self:onCellClick(self._musicId2Cell[finalMusicId])
	end
end

function M:_onClickNext()
	if not self:getLastMusicId() then
		return
	end

	local curIndex = self:getCurPlayingMusicIndex()

	if not curIndex then
		return
	end

	local finalMusicId = -1

	while curIndex < #self._musicGroup do
		curIndex = curIndex + 1

		local musicId = self._musicGroup[curIndex].id

		if GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Music, musicId) then
			finalMusicId = musicId

			break
		end
	end

	if finalMusicId > 0 then
		self._loopList:MoveToItemIndex(curIndex)
		self:onCellClick(self._musicId2Cell[finalMusicId])
	end
end

function M:_onTogglePlay(toggle, isOn)
	if self._isOn ~= nil and self._isOn == isOn then
		return
	end

	self._isOn = isOn

	if self:getCurPlayMusicId() then
		if isOn then
			self:_releasePlayerControlSlider()
		else
			CriwareAudioFacade.instance:stopBgm()
			self:tweenNumberControl(false)
		end

		goutil.setActive(self._goZhiZhenPlay, isOn)
		goutil.setActive(self._goZhiZhenStop, not isOn)

		return
	end

	if not self:getLastMusicId() then
		self._togglePlay:ForceSetOn(false)

		return
	end

	self:_playMusic(isOn, self:getLastMusicId())
end

function M:_playMusic(play, musicId)
	goutil.setActive(self._goZhiZhenPlay, play)
	goutil.setActive(self._goZhiZhenStop, not play)

	if play then
		if self:getCurPlayMusicId() and self:getCurPlayMusicId() == musicId then
			printWarn("播放失败，就是当前", self:getCurPlayMusicId())

			return
		end

		self:setCurPlayMusicId(musicId)

		local bgmRes = self:getMusicResId(musicId)

		if bgmRes then
			self:setPlayingProcess(nil)

			self._sliderVal = nil

			CriwareAudioFacade.instance:stopBgm()
			CriwareAudioFacade.instance:PlayBgmInnerBgName(bgmRes)

			self._totalTime = CriwareAudioFacade.instance:getCueTotalTimeByName(bgmRes)
			self._txtProcessTimeMax.text = self:_formatMusicTime(self._totalTime)

			self:tweenNumberControl(true, self._totalTime)
		end
	else
		if self:getCurPlayMusicId() then
			CriwareAudioFacade.instance:stopBgm()
			self:tweenNumberControl(false)
		end

		self._sliderVal = nil
		self._playerControl = false

		self:setPlayingProcess(nil)
		self:setCurPlayMusicId(nil)

		self._txtProcessTimeNow.text = self:_formatMusicTime(0)
	end
end

function M:tweenNumberControl(create, time)
	if self._isLerping then
		self._tweenProcess:Kill(false)

		self._tweenProcess = nil
	end

	self._isLerping = false

	if create then
		self._isLerping = true
		self._tweenProcess = TweenNumberUtils.FloatToWithGetter(1, time, self.getPlayingProcess, function(handler, val)
			self:refreshMusicPlayingInfo(val)
		end, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(function()
			self:refreshMusicPlayingInfo(1)
			CriwareAudioFacade.instance:stopBgm()
			self:setCurPlayMusicId(nil)

			self._txtProcessTimeNow.text = self:_formatMusicTime(self._totalTime)

			self._togglePlay:ForceSetOn(false)
		end, self)
	end
end

function M:_onMusicSliderValChanged(val)
	if self:getCurPlayMusicId() then
		val = self:duelProcessNum(val)

		local playingProcess = self:getPlayingProcess()

		if val ~= playingProcess then
			if not self._playerControl and math.abs(math.floor(val * 10000) - math.floor(playingProcess * 10000)) > 1 then
				self._playerControl = true
			end

			if self._playerControl then
				removetimer(self._releasePlayerControlSlider, self)
				settimer(0.5, self._releasePlayerControlSlider, self, false)
			end
		end

		self._txtProcessTimeNow.text = self:_formatMusicTime(self._totalTime * val)
	else
		if self._sliderVal and self._sliderVal == val then
			return
		end

		self._sliderVal = val

		self._sliderProcess:SetValue(0)
	end
end

function M:_releasePlayerControlSlider()
	local val = self._sliderProcess:GetValue()
	local curTime = self._totalTime * val

	printWarn(string.format("<color=#45e6f9>Try control slider to [%s] totalTime[%s]</color>", val, self._totalTime))

	local cueName = self:getMusicResId(self:getCurPlayMusicId())

	CriwareAudioFacade.instance:stopBgm()
	CriwareAudioFacade.instance:setStartTimeByName(cueName, curTime)
	CriwareAudioFacade.instance:PlayBgmInnerBgName(cueName)

	val = self:duelProcessNum(val)

	self:setPlayingProcess(val)

	self._playerControl = false

	self:tweenNumberControl(true, self._totalTime - curTime)
end

function M:getMusicResId(musicId)
	local index = self._musicId2Index[musicId]
	local data = self._musicGroup[index]

	if data then
		return data.res
	end

	return nil
end

function M:getCurPlayMusicId()
	return self._curPlayMusicId
end

function M:setCurPlayMusicId(musicId)
	self._curPlayMusicId = musicId
end

function M:getCurPlayingMusicIndex()
	local curMusicId = self:getCurPlayMusicId()

	if curMusicId then
		return self._musicId2Index[curMusicId]
	end

	return nil
end

function M:onCellClick(cell)
	if cell:getIsLock() then
		FloatWordMgr.instance:show(lang("tip_handbook_music_1"))

		return
	end

	if self:getLastMusicId() and self:getLastMusicId() == cell:getId() then
		return
	end

	if self:getLastCell() then
		self:getLastCell():setIsSelected(false)
	end

	cell:setIsSelected(true)
	self:_playMusic(false)
	self._togglePlay:ForceSetOn(false)
	self:setLastCell(cell)
	self:refreshMusicInfo(cell:getId())
	self:setPlayingProcess(0)
	self._sliderProcess:SetValue(0)
	self._togglePlay:ForceSetOn(true)
end

function M:getLastCell()
	return self._musicId2Cell[self:getLastMusicId()]
end

function M:setLastCell(cell)
	self._lastMusicId = cell and cell:getId() or nil
end

function M:getLastMusicId()
	return self._lastMusicId
end

function M:refreshMusicInfo(cfgGalleryMusicId)
	if cfgGalleryMusicId then
		local index = self._musicId2Index[cfgGalleryMusicId]
		local cfg = self._musicGroup[index]

		self._txtName.text = cfg.name
	else
		self._txtName.text = ""
	end

	self:refreshMusicPlayingInfo(0)
end

function M:refreshMusicPlayingInfo(process)
	process = process or 0

	local totalTime = self._totalTime

	totalTime = totalTime or 1

	local nowTime = totalTime * process

	process = self:duelProcessNum(process)

	local step = 0.5 / totalTime

	if not self._playerControl and step <= process - self:getPlayingProcess() then
		self._txtProcessTimeNow.text = self:_formatMusicTime(nowTime)

		self:setPlayingProcess(process)
		self._sliderProcess:SetValue(process)
	end
end

function M:getPlayingProcess()
	return self._curPlayingProcess or 0
end

function M:setPlayingProcess(val)
	self._curPlayingProcess = val
end

function M:duelProcessNum(val)
	return math.floor(val * 10000) * 0.0001
end

function M:_formatMusicTime(time)
	local sec = time % 60
	local min = math.floor(time / 60)

	return string.format("%02d:%02d", min, sec)
end

function M:refreshLst()
	self._musicGroup = {}

	local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryMusic)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			table.insert(self._musicGroup, cfg)
		end
	end

	if #self._musicGroup > 0 then
		table.sort(self._musicGroup, function(cfgA, cfgB)
			return cfgA.sortType > cfgB.sortType
		end)
	end

	self._loopList:SetListItemCount(#self._musicGroup, true)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._musicGroup[curIndex]
	local item = self._loopList:NewListViewItem("handbook_music_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookMusicItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookMusicItemCell)
	end

	shower:setHandler(self)
	shower:setData(data)

	local showSelect = self:getLastMusicId() and self:getLastMusicId() == data.id

	shower:setIsSelected(showSelect)

	self._musicId2Cell[data.id] = shower
	self._musicId2Index[data.id] = curIndex

	return item
end

return M
