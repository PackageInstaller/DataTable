-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleTableUtil.lua

module("logic.battle.util.BattleTableUtil", package.seeall)

local BattleTableUtil = {}
local tempSb = StringBuffer.New()
local kTempListCache = {}
local kTempListCapacity = 20

function BattleTableUtil.getTempList()
	return table.remove(kTempListCache) or {}
end

function BattleTableUtil.releaseTempList(tempList)
	if #kTempListCache < kTempListCapacity then
		BattleTableUtil.clearTable(tempList)
		table.insert(kTempListCache, tempList)
	end
end

function BattleTableUtil.clearTable(table)
	for k, _ in pairs(table) do
		table[k] = nil
	end
end

function BattleTableUtil.clearReusableTable(table)
	for k, v in pairs(table) do
		v:returnSelf()

		table[k] = nil
	end
end

function BattleTableUtil.clearGameobjectTable(table)
	for k, v in pairs(table) do
		goutil.destroy(v)

		table[k] = nil
	end
end

function BattleTableUtil.clearCommands(table)
	for k, v in pairs(table) do
		v:clear(true)

		table[k] = nil
	end
end

function BattleTableUtil.reverse(table)
	local lastIndex = #table
	local loopCount = math.floor(lastIndex / 2)
	local tempValue

	for i = 1, loopCount do
		tempValue = table[i]
		table[i] = table[lastIndex]
		table[lastIndex] = tempValue
		lastIndex = lastIndex - 1
	end

	return table
end

function BattleTableUtil.passList(dest, src)
	BattleTableUtil.insertto(dest, src)
	BattleTableUtil.clearTable(src)
end

function BattleTableUtil.insertto(dest, src, begin)
	if src and #src > 0 then
		table.insertto(dest, src, begin)
	end
end

function BattleTableUtil.insertfrommap(dest, src)
	for _, v in pairs(src) do
		table.insert(dest, v)
	end
end

function BattleTableUtil.insertfrommapkey(dest, src)
	for k, v in pairs(src) do
		if v then
			table.insert(dest, k)
		end
	end
end

function BattleTableUtil.insertunique(dest, value)
	if table.indexof(dest, value) then
		return
	end

	table.insert(dest, value)
end

function BattleTableUtil.removebyvalue(list, comparableValue)
	for i = #list, 1, -1 do
		if list[i]:equals(comparableValue) then
			return table.remove(list, i)
		end
	end

	return false
end

function BattleTableUtil.subArray(array, fromIndex, count)
	if fromIndex then
		while fromIndex > 1 do
			fromIndex = fromIndex - 1

			table.remove(array, 1)
		end
	end

	if count then
		while count < #array do
			table.remove(array)
		end
	end
end

function BattleTableUtil.arrayToString(array)
	local sb = tempSb

	sb:append("[")

	for _, v in pairs(array) do
		if TypeUtil.isTable(v) then
			sb:append(v:toString()):append(",")
		else
			sb:append(tostring(v)):append(",")
		end
	end

	sb:append("]")

	local result = sb:toString()

	sb:clear()

	return result
end

return BattleTableUtil
