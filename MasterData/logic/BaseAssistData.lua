-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/BaseAssistData.lua

module("logic.extensions.xiaonuoassistant.view.data.BaseAssistData", package.seeall)

local BaseAssistData = class("BaseAssistData")

function BaseAssistData:ctor(funcIndex)
	self._funcIndex = funcIndex
	self._tabIndex = XiaoNuoAssistantController.instance:getTabIdByFuncEnum(funcIndex)
	self._cfg = XiaoNuoAssistantConfig.instance:getStrCfg(self._funcIndex)
	self._assistCellData = {}
end

function BaseAssistData:init()
	return
end

function BaseAssistData:getTag()
	return self._funcIndex
end

function BaseAssistData:getFuncIndex()
	return self._funcIndex
end

function BaseAssistData:getTabIndex()
	return self._tabIndex
end

function BaseAssistData:getCfg()
	return self._cfg
end

function BaseAssistData:getName()
	return self._cfg.name
end

function BaseAssistData:getAssistCellData()
	return self._assistCellData
end

function BaseAssistData:setSelectAll(isOn)
	return
end

function BaseAssistData:isSelectAll()
	return
end

function BaseAssistData:isSelectAny()
	return self:getOpenData()
end

function BaseAssistData:getSendCallbackList()
	return
end

function BaseAssistData:getReqParams()
	return
end

function BaseAssistData:getSendMo()
	local sendMo = XiaoNuoSendMo.New()

	sendMo.funcEnum = self:getFuncIndex()

	return sendMo
end

function BaseAssistData:setOpenData(isOpen)
	XiaoNuoAssistLocalDataModel.instance:setOpenData(self._funcIndex, isOpen)
end

function BaseAssistData:getOpenData()
	return XiaoNuoAssistLocalDataModel.instance:getOpenData(self._funcIndex)
end

function BaseAssistData:setCellSelect(index, isSelect)
	XiaoNuoAssistLocalDataModel.instance:setCellSelect(self._funcIndex, index, isSelect)
end

function BaseAssistData:getCellSelect(index)
	index = checknumber(index)

	return XiaoNuoAssistLocalDataModel.instance:getCellSelect(self._funcIndex, index)
end

function BaseAssistData:setCellData(key, value)
	XiaoNuoAssistLocalDataModel.instance:setCellData(self._funcIndex, key, value)
end

function BaseAssistData:getCellData(key)
	return XiaoNuoAssistLocalDataModel.instance:getCellData(self._funcIndex, key)
end

function BaseAssistData:getCellDataToNumber(key)
	local num = self:getCellData(key)

	return checknumber(num)
end

return BaseAssistData
