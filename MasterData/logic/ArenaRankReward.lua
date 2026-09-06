-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaRankReward.lua

module("logic.extensions.arena.view.ArenaRankReward", package.seeall)

local ArenaRankReward = class("ArenaRankReward")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaRankReward.AddOnce(go)
	local component = ArenaRankReward.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaRankReward)

	return component
end

function ArenaRankReward.Remove(go)
	LuaComponentContainer.Remove(go, ArenaRankReward)
end

function ArenaRankReward.Get(go)
	return (LuaComponentContainer.Get(go, ArenaRankReward))
end

function ArenaRankReward:ctor(container)
	self._container = container
	self._content = goutil.findChild(self._container, "Scrl/Viewport/Content")
	self._Pnl_Base = goutil.findChild(self._container, "Pnl_Base")
	self._cell = goutil.findChild(self._container, "Pnl_Base/Cell")
	self._initCells = false
	self._cells = {}
	self._eliteBase = goutil.clone(self._Pnl_Base)
end

function ArenaRankReward:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ArenaGainAchieve, self._onGainAchieve, self)
end

function ArenaRankReward:onElite(cells, base)
	if self._initCells then
		return
	end

	self._initCells = true

	local posX, posY = 100, -20
	local height = 115

	base.gameObject:SetActive(true)

	local cfgs = ArenaConfig.instance:getArenaTopGroupCfgs()
	local count = 0

	for i, v in ipairs(cfgs) do
		if v.achieveGroupPrize ~= "" then
			count = count + 1

			local cell = goutil.clone(self._cell)

			cell.gameObject:SetActive(true)
			goutil.addChildToParent(cell, base)

			cell.transform.localPosition = Vector3.New(posX, -20 - (count - 1) * height, 0)
			cells[count] = cell
		end
	end

	goutil.addChildToParent(base, self._content)

	local rt = base.gameObject:GetComponent("RectTransform")

	rt.sizeDelta = Vector2.New(740, 20 + count * height + 20)

	local img_Bg = goutil.findChild(base, "Cell/ImgBg")

	rt = img_Bg.gameObject:GetComponent("RectTransform")
	rt.sizeDelta = Vector2.New(740, 20 + count * height + 10)
end

function ArenaRankReward:onRefreshInfo(achieveInfo)
	self:onElite(self._cells, self._eliteBase)

	local cfgs = ArenaConfig.instance:getArenaTopGroupCfgs()
	local sortList = {}
	local gainBit = achieveInfo.gainBit
	local canGetList = {}
	local isGetList = {}

	for i, v in ipairs(cfgs) do
		if achieveInfo.maxTopGroupId > 0 and v.topGroupId >= achieveInfo.maxTopGroupId then
			local num2 = bit.lshift(1, v.topGroupId)
			local flag = bit.band(gainBit, num2) > 0

			if flag then
				table.insert(isGetList, v)
			else
				table.insert(canGetList, v)
			end
		else
			table.insert(sortList, v)
		end
	end

	table.sort(sortList, function(a, b)
		return a.topGroupId < b.topGroupId
	end)
	table.sort(isGetList, function(a, b)
		return a.topGroupId > b.topGroupId
	end)

	for i, v in ipairs(canGetList) do
		table.insert(sortList, 1, v)
	end

	for i, v in ipairs(isGetList) do
		table.insert(sortList, v)
	end

	local first_can_get_id = 0
	local find_first_can_get_id = false

	for index, v in ipairs(sortList) do
		local go = self._cells[index]

		if go then
			ArenaRankCell.AddOnce(go):initCell(v, index)

			local ret_can_get = ArenaRankCell.AddOnce(go):refreshCell(achieveInfo)

			if not find_first_can_get_id and ret_can_get then
				first_can_get_id = index
				find_first_can_get_id = true
			end
		else
			printError("arena error self._cells[index] nil index = ", index)
		end
	end

	if not find_first_can_get_id then
		first_can_get_id = 1
	end

	local allLen = #sortList

	if first_can_get_id ~= 0 then
		if allLen - first_can_get_id <= 3 then
			first_can_get_id = allLen - 3
		end

		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, (first_can_get_id - 1) * 115, 0)
	end
end

function ArenaRankReward:_onGainAchieve(result)
	ArenaAgent.instance:sendGetAchievePrizeInfoReq()
end

function ArenaRankReward:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ArenaGainAchieve, self._onGainAchieve, self)

	for k, go in pairs(self._cells) do
		if go then
			ArenaRankCell.AddOnce(go):onExit()
		end
	end
end

function ArenaRankReward:OnDestroy()
	return
end

return ArenaRankReward
