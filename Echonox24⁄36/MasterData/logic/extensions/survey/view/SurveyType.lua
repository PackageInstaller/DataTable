-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/SurveyType.lua

module("logic.extensions.survey.view.SurveyType", package.seeall)

local M = class("SurveyType", ViewComponent)

function M:setPos(pos)
	self._pos = pos
end

function M:setChoice(obj, name, isMulti, imgName, hasOther, index, bindInput, bindBtn)
	local txtName = goutil.findChildTextComponent(obj, "lay/txtName")
	local imgIcon = goutil.findChildImageComponent(obj, "lay/icon")
	local txtElse = goutil.findChild(obj, "lay/txtName/else"):GetComponent(UIComponentType.InputField)
	local txtElseAdapter = Astral.InputFieldAdapter.Get(txtElse.gameObject)
	local txtNameClick = Astral.UIClickTrigger.Get(goutil.findChild(obj, "lay"))
	local signalGo = goutil.findChild(obj, "singleTog"):GetComponent(UIComponentType.SpaceXToggle)
	local multiGo = goutil.findChild(obj, "multiTog"):GetComponent(UIComponentType.SpaceXToggle)
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	if ans then
		if not isMulti and ans.selection[1] == index then
			signalGo.IsOn = true
		elseif isMulti then
			multiGo.IsOn = ans.selection[index] or false
		end

		if hasOther and ans.textContent then
			txtElse.text = ans.textContent
		end
	end

	txtElseAdapter:AddOnEndEdit(function()
		self:_dealElse(txtElse.text)
	end, nil)
	signalGo:AddListener(function(_, isOn)
		if isOn then
			self:_dealSingle(index)
		end
	end, nil)
	multiGo:AddListener(function(_, isOn)
		self:_dealMulti(index, isOn, txtElse.text)
	end, nil)
	goutil.setActive(multiGo.gameObject, isMulti)
	goutil.setActive(signalGo.gameObject, not isMulti)
	goutil.setActive(imgIcon.gameObject, imgName)
	goutil.setActive(txtElse.gameObject, hasOther)

	txtName.text = name

	if signalGo.gameObject.activeSelf then
		txtNameClick:AddClickListener(function()
			signalGo.IsOn = true
		end, self)
	else
		txtNameClick:AddClickListener(function()
			multiGo.IsOn = not multiGo.IsOn
		end, self)
	end

	table.insert(bindInput, txtElseAdapter)
	table.insert(bindBtn, txtNameClick)

	if imgName then
		IconLoader.setSprite(imgIcon, IconType.Survey, imgName)
	end
end

function M:_dealElse(text)
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	ans = ans or {
		selection = {}
	}
	ans.textContent = text

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_dealSingle(index)
	local ans = {
		selection = {}
	}

	ans.selection = {
		index
	}

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_dealMulti(index, isOn, text)
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	ans = ans or {
		selection = {}
	}
	ans.selection[index] = isOn

	if isOn and text ~= "" then
		ans.content = text
	end

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_dealMatrix(index, pos)
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	ans = ans or {
		selection = {}
	}
	ans.selection[index] = pos

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_dealStar(pos, num)
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	ans = ans or {
		selection = {}
	}
	ans.selection[pos] = num

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:setMatrixChoice(obj, name, imgName, num, index)
	local txtName = goutil.findChildTextComponent(obj, "txtName")
	local imgIcon = goutil.findChildImageComponent(obj, "icon")
	local togGroup = goutil.findChild(obj, "togGroup")

	if imgName then
		IconLoader.setSprite(imgIcon, IconType.Survey, imgName)
	end

	if name then
		txtName.text = name
	end

	goutil.setActive(txtName.gameObject, name)
	goutil.setActive(imgIcon.gameObject, imgName)

	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	for i = 1, 6 do
		local tog = goutil.findChild(togGroup, "tog" .. i):GetComponent(UIComponentType.SpaceXToggle)

		if ans and i == ans.selection[index] then
			tog.IsOn = true
		end

		tog:AddListener(function(_, isOn)
			if isOn then
				self:_dealMatrix(index, i)
			end
		end, nil)
		goutil.setActive(tog.gameObject, i <= num)
	end
end

function M:setStar(obj, name, imgName, index, bindBtn)
	local txtName = goutil.findChildTextComponent(obj, "txtName")
	local imgIcon = goutil.findChildImageComponent(obj, "icon")

	if imgName then
		IconLoader.setSprite(imgIcon, IconType.Survey, imgName)
	end

	if name then
		txtName.text = name
	end

	goutil.setActive(txtName.gameObject, name)
	goutil.setActive(imgIcon.gameObject, imgName)

	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	for i = 1, 5 do
		local btn = UIComponentType.ButtonAdapter(goutil.findChild(obj, "btnStar" .. i))

		btn:AddClickListener(function()
			self:_dealStar(index, i)
			self:_refreshStar(obj, i)
		end, nil)
		table.insert(bindBtn, btn)
	end

	if ans and ans.selection[index] then
		self:_refreshStar(obj, ans.selection[index])
	end
end

function M:initStarAns(maxCount)
	local ans = SurveyModel.instance:getSubAnswer(self._pos)

	if not ans then
		ans = {
			selection = {}
		}

		for i = 1, maxCount do
			ans.selection[i] = 0
		end
	end

	SurveyModel.instance:setSubAnswer(self._pos, ans)
end

function M:_refreshStar(obj, num)
	for i = 1, 5 do
		local btn = goutil.findChild(obj, "btnStar" .. i .. "/star")

		goutil.setActive(btn, i <= num)
	end
end

function M:getContent(cfg)
	if not cfg then
		return
	end

	local attrs = {}

	for word in string.gmatch(cfg, "%[(.-)%]") do
		table.insert(attrs, word)
	end

	for i, v in pairs(attrs) do
		local k = string.split(v, "|")

		attrs[i] = k
	end

	return attrs
end

return M
