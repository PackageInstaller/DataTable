-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/model/BaseListModel.lua

module("frameworkext.lmvc.model.BaseListModel", package.seeall)

local BaseListModel = class("BaseListModel", BaseModel)

function BaseListModel:ctor()
	self._moList = {}
	self._moDict = {}
	self._idCounter = 0
	self._listDataProvider = DataProvider.New()
end

function BaseListModel:onInit()
	return
end

function BaseListModel:onReset()
	self:clear()
end

function BaseListModel:setDataBinder(binder)
	self._binder = binder
end

function BaseListModel:getListDataProvider()
	return self._listDataProvider
end

function BaseListModel:getMoDict()
	return self._moDict
end

function BaseListModel:getMoById(id)
	return self._moDict[id]
end

function BaseListModel:getMoList()
	return self._moList
end

function BaseListModel:getMoCount()
	return #self._moList
end

function BaseListModel:getMoIndex(mo)
	return table.indexof(self._moList, mo)
end

function BaseListModel:getMoByIndex(index)
	local mo
	local count = #self._moList

	return (index >= 1 and index <= count or nil) and self._moList[index]
end

function BaseListModel:sortMoList(sortFunc)
	table.sort(self._moList, sortFunc)
	self._listDataProvider:onUpdateData()
end

function BaseListModel:isEmpty()
	return #self._moList == 0
end

function BaseListModel:addMoList(moList)
	local len = #moList
	local mo

	for i = 1, len do
		table.insert(self._moList, moList[i])

		if not moList[i].id then
			self._idCounter = self._idCounter + 1
			moList[i].id = self._idCounter
		end

		self._moDict[moList[i].id] = moList[i]
	end

	self._listDataProvider:onUpdateData()
end

function BaseListModel:setMoList(moList)
	self._moList = {}
	self._moDict = {}

	self:addMoList(moList)
	self._listDataProvider:onUpdateData()
end

function BaseListModel:addMoAt(mo, index)
	local count = #self._moList

	if not index or index > count + 1 then
		index = count + 1
	elseif index < 1 then
		index = 1
	end

	table.insert(self._moList, index, mo)

	if not mo.id then
		self._idCounter = self._idCounter + 1
		mo.id = self._idCounter
	end

	self._moDict[mo.id] = mo

	self._listDataProvider:onUpdateData()

	return mo
end

function BaseListModel:addMo(mo)
	return self:addMoAt(mo)
end

function BaseListModel:clear()
	self._moList = {}
	self._moDict = {}

	self._listDataProvider:onUpdateData()
end

function BaseListModel:removeAt(index)
	if not index or index < 1 then
		return nil
	end

	if index > #self._moList then
		return nil
	end

	local mo = table.remove(self._moList, index)

	if mo then
		self._moDict[mo.id] = nil
	end

	self._listDataProvider:onUpdateData()

	return mo
end

function BaseListModel:removeMo(mo)
	local index = table.indexof(self._moList, mo)

	if index then
		return self:removeAt(index)
	end

	return nil
end

function BaseListModel:removeMoById(id)
	local mo = self._moDict[id]

	if mo then
		self:removeMo(mo)
	end

	return mo
end

return BaseListModel
