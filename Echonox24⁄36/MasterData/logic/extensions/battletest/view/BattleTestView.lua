-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battletest/view/BattleTestView.lua

module("logic.extensions.battletest.view.BattleTestView", package.seeall)

local BattleTestView = class("BattleTestView", ViewComponent)
local json = require("cjson")
local kCacheKey = "__BattleTestView__"

SAVE_DIRECTION = "Assets/GameAssets/shared/battle/"
DEFAULT_DIRECTION = "battle/"

local DEFAULT_PREFIX = "skill_"

function BattleTestView:buildUI()
	self._campViewList = {}
	self._btnStart = self:getBtnByPath("Controls/btnStart")
	self._btnReturn = self:getBtnByPath("Controls/btnReturn")
	self._btnSave = self:getBtnByPath("Controls/btnSave")
	self._btnLoad = self:getBtnByPath("Controls/btnLoad")
	self._txtName = self:getInputByPath("Controls/fileName")
	self._dropdownConfig = self:getGoByPath("Controls/dropdownConfig"):GetComponent(UIComponentType.DropdownApapter)
	self._inputSceneCode = self:getInputByPath("Controls/inputFieldSceneCode")
	self._txtExtInfo = goutil.findChildTextComponent(self.mainGO, "Other/txtInfo")
	self._dropdownClick = Astral.UIClickTrigger.Get(self:getGoByPath("Controls/dropdownConfig"))

	local templateGO = goutil.findChild(self.mainGO, "Templates")

	goutil.setActive(templateGO, false)
	table.insert(self._campViewList, BattleTestCampView.New(self:getGoByPath("CampsA"), templateGO))
	table.insert(self._campViewList, BattleTestCampView.New(self:getGoByPath("CampsB"), templateGO))
	self:_executeCampViewFunction("buildUI")
	MonsterConfig.instance:loadLevelMonsterConfig(111111)
end

function BattleTestView:destroyUI()
	self:_executeCampViewFunction("destroyUI")

	self._campViewList = nil
	self._btnStart = nil
	self._btnReturn = nil
	self._btnSave = nil
	self._btnLoad = nil
	self._txtExtInfo = nil
	self._dropdownConfig = nil
end

function BattleTestView:bindEvents()
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnLoad:AddClickListener(self._onClickLoad, self)
	self._dropdownConfig:AddListener(self._onClickConfig, self)
	self._dropdownClick:AddClickDownListener(self._dropdownConfigInit, self)
end

function BattleTestView:unbindEvents()
	self._btnStart:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnLoad:RemoveClickListener()
	self._dropdownConfig:RemoveClickListener()
	self._dropdownClick:RemoveClickDownListener()
end

function BattleTestView:onEnter()
	self:_showExtInfo()
	self._inputSceneCode:SetText(BattleTestUtil.DefaultMapCode)

	local dataStr = Astral.LocalStorage.Instance:GetString(kCacheKey, nil)

	self:_parseCampDataListString(dataStr)
	self:_reload()
end

function BattleTestView:_reload()
	local namePath = Astral.FileUtils.Instance:FullPathForFile("battle/name.txt")
	local www = UnityEngine.WWW.New(namePath)

	while not www.isDone do
		-- block empty
	end

	self._data = json.decode(www.text)

	self:_dropdownConfigInit()
end

function BattleTestView:_onClickStart()
	local campDataList = self:_buildCampDataList()

	if not campDataList then
		FloatWordMgr.instance:show("current config contains errors!")

		return
	end

	Astral.LocalStorage.Instance:SetString(kCacheKey, json.encode(campDataList))
	BattleTestUtil.enterBattleTest(campDataList)
	self:close()
end

function BattleTestView:_dropdownConfigInit()
	self._optionList = {}

	for i, v in pairs(self._data) do
		table.insert(self._optionList, i)
	end

	self._optionList = SpaceXFileUtil.SortByGBK(self._optionList)

	self._dropdownConfig.dropdown:ClearOptions()

	local t = UnityEngine.UI.Dropdown.OptionData.New("None")

	self._dropdownConfig.dropdown.options:Add(t)

	for i, v in ipairs(self._optionList) do
		local t = UnityEngine.UI.Dropdown.OptionData.New(v)

		self._dropdownConfig.dropdown.options:Add(t)
	end

	self._dropdownConfig.dropdown.value = -1
end

function BattleTestView:_onClickConfig()
	local index = self._dropdownConfig.dropdown.value

	if index == 0 then
		return
	end

	local name = DEFAULT_DIRECTION .. SpaceXFileUtil.GetMD5(self._optionList[index]) .. ".txt"
	local namePath = Astral.FileUtils.Instance:FullPathForFile(name)
	local www = UnityEngine.WWW.New(namePath)

	while not www.isDone do
		-- block empty
	end

	self:_parseCampDataListString(www.text)
end

function BattleTestView:_onResLoadedConfig()
	local conText = self._resource:GetTextAsset()

	self:_parseCampDataListString(conText.text)
end

function BattleTestView:_buildCampDataList()
	local campDataList = {}

	campDataList.sceneCode = checkint(self._inputSceneCode:GetText())

	for _, campView in pairs(self._campViewList) do
		local campData = campView:getCampData()

		table.insert(campDataList, campData)

		if campView:isCampDataEmpty(campData) then
			if enableErrorLog then
				printError("BattleTestView::config is empty!")
			end

			return
		end
	end

	return campDataList
end

function BattleTestView:_parseCampDataListString(stringContent)
	if not string.nilorempty(stringContent) then
		local campDataList = json.decode(stringContent)

		if campDataList then
			for index, campView in pairs(self._campViewList) do
				campView:setCampData(campDataList[tostring(index)])
			end

			self._inputSceneCode:SetText(campDataList.sceneCode)
		elseif enableErrorLog then
			printError("decode config failed!")
		end
	end
end

function BattleTestView:_onClickReturn()
	HacktoolMo.instance:setOpenBattle(false)
	self:close()
end

function BattleTestView:_onClickSave()
	local campDataList = self:_buildCampDataList()

	if not campDataList then
		FloatWordMgr.instance:show("save file failed!")

		return
	end

	local name = self._txtName:GetText()

	if name == "" then
		FloatWordMgr.instance:show("请输入文件名")

		return
	end

	if not Astral.OSDef.isEditor then
		return
	end

	local stringContent = json.encode(campDataList)
	local md5 = SpaceXFileUtil.GetMD5(name)

	Astral.FileUtils.Instance:CheckDirExists(SAVE_DIRECTION)
	SpaceXFileUtil.SaveFile(SAVE_DIRECTION .. md5 .. ".txt", stringContent)
	printInfo(name .. " 已保存到路径： " .. SAVE_DIRECTION .. md5 .. ".txt")

	for i, v in pairs(self._optionList) do
		if v == name then
			FloatWordMgr.instance:show("文件名重复，已覆盖")

			return
		end
	end

	SpaceXFileUtil.AppendName(SAVE_DIRECTION .. "name.txt", name, md5)
	FloatWordMgr.instance:show("写入成功")
	self:_reload()
end

function BattleTestView:_onClickLoad()
	local stringContent = EditorFileUtils.OpenFile(SAVE_DIRECTION)

	if string.nilorempty(stringContent) then
		FloatWordMgr.instance:show("open file failed!")

		return
	end

	self:_parseCampDataListString(stringContent)
end

function BattleTestView:_executeCampViewFunction(functionName)
	for _, campView in pairs(self._campViewList) do
		campView[functionName](campView)
	end
end

function BattleTestView:_showExtInfo()
	local sb = StringBuffer.New()

	sb:append(string.format("HDR:%s", tostring(CineCameraUtils.isSupportHDR())))
	sb:appendLine()

	self._txtExtInfo.text = sb:toString()
end

return BattleTestView
