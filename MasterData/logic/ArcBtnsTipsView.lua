-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/arcbtnstips/ArcBtnsTipsView.lua

module("logic.extensions.common.instruction.view.arcbtnstips.ArcBtnsTipsView", package.seeall)

local ArcBtnsTipsView = class("ArcBtnsTipsView", ViewComponent)
local posListGroup = {
	{
		{
			{
				154,
				0
			}
		},
		{
			{
				131,
				57
			},
			{
				151,
				-24
			}
		},
		{
			{
				106,
				81
			},
			{
				151,
				13
			},
			{
				145,
				-71
			}
		},
		{
			{
				87,
				99
			},
			{
				141,
				42
			},
			{
				152,
				-32
			},
			{
				127,
				-106
			}
		},
		{
			{
				43,
				118
			},
			{
				106,
				82
			},
			{
				149,
				24
			},
			{
				149,
				-51
			},
			{
				128,
				-177
			}
		}
	},
	{
		{
			{
				-124,
				0
			}
		},
		{
			{
				-124,
				45
			},
			{
				-124,
				-45
			}
		},
		{
			{
				-124,
				75
			},
			{
				-124,
				0
			},
			{
				-124,
				-75
			}
		},
		{
			{
				-124,
				112.5
			},
			{
				-124,
				37.5
			},
			{
				-124,
				-37.5
			},
			{
				-124,
				-112.5
			}
		},
		{
			{
				-124,
				150
			},
			{
				-124,
				75
			},
			{
				-124,
				0
			},
			{
				-124,
				-75
			},
			{
				-124,
				-150
			}
		}
	}
}

function ArcBtnsTipsView:buildUI()
	ArcBtnsTipsView.super.buildUI(self)

	self._content = goutil.findChild(self.mainGO, "content")
	self._box = goutil.findChild(self.mainGO, "box")
	self._adjustPosition = self._box:GetComponent("UIAdjustPosition")
	self._btnCol = goutil.findChild(self._content, "btnCol")
	self._btnCell = goutil.findChild(self._content, "btnCol/btnCell")
	self._btnView = goutil.findChild(self._content, "btnCol/btnView")
	self._customInput = UICustomInput.Get(self.mainGO)

	GameUtil.SetActive(self._btnCell, false)
end

function ArcBtnsTipsView:bindEvents()
	ArcBtnsTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ArcBtnsTipsView:unbindEvents()
	ArcBtnsTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function ArcBtnsTipsView:onEnter()
	ArcBtnsTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._dataListGroups = params[1] or {}

	local pos, sizeDelta = params[2], params[3]

	self._adjustPosition:AdjustScreenPosition(pos, 0, 0)

	for groupId, dataList in ipairs(self._dataListGroups) do
		for _, data in ipairs(dataList) do
			data.name = data.name or ""
			data.redIdList = data.redIdList or {}
			data.callBack = data.callBack or nil
			data.params = data.params or {}
		end
	end

	self:_onSetUI()
	self:_onUpdateUI()
end

function ArcBtnsTipsView:onExit()
	ArcBtnsTipsView.super.onExit(self)
	self._arcBtnsCtrl:clear()
	self:_clearAllBtnCell()
end

function ArcBtnsTipsView:destroyUI()
	self._customInput = nil
	self._arcBtnsCtrl = nil
end

function ArcBtnsTipsView:_onSetUI()
	return
end

function ArcBtnsTipsView:_onUpdateUI()
	self:_updateAllBtnCell()
end

function ArcBtnsTipsView:_updateAllBtnCell()
	local parentTran = self._btnView.transform
	local children = GameUtil.getChildren(parentTran)
	local childIdx = 0
	local goListGroups = {}

	for groupId, dataList in ipairs(self._dataListGroups) do
		goListGroups[groupId] = {}

		for index, data in ipairs(dataList) do
			childIdx = childIdx + 1

			if not children[childIdx] then
				local mainGo = goutil.cloneAndSetParent(self._btnCell, parentTran)
				local txtName = goutil.findChildTextComponent(mainGo, "txtName")
				local redPoint = goutil.findChild(mainGo, "redPoint")
				local data = data

				table.insert(goListGroups[groupId], mainGo)

				mainGo.name = string.format("%s_%s_%s", self._btnCell.name, groupId, index)

				local pos = posListGroup[groupId][#dataList][index]

				if pos == nil then
					printError("意图增添的按钮超过位置预设数量")
				else
					GameUtil.setLocalPos(mainGo, pos[1], pos[2], 0)
				end

				txtName.text = data.name

				RedPointController.instance:unregRedPoint(redPoint)

				if #data.redIdList == 0 then
					GameUtil.SetActive(redPoint, false)
				else
					RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdList))
				end

				GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickBtnCell, self, cell, data))
			end
		end
	end

	for idx = 0, parentTran.childCount - 1 do
		local go = parentTran:GetChild(idx)

		GameUtil.SetActive(go, false)
	end

	if self._arcBtnsCtrl then
		self._arcBtnsCtrl:setGoListGroups(goListGroups)
	else
		self._arcBtnsCtrl = ArcBtnsCtrl.create(goListGroups)
	end

	self._arcBtnsCtrl:regPlayCallBack(GameUtil.handler(self._beforePlayCallBack, self), GameUtil.handler(self._finishPlayCallBack, self))
	self._arcBtnsCtrl:regPlayGroupCallBack(GameUtil.handler(self._beforePlayGroupCallBack, self), GameUtil.handler(self._finishPlayGroupCallBack, self))
	self._arcBtnsCtrl:play(true)
end

function ArcBtnsTipsView:_clearAllBtnCell()
	local parentTran = self._btnView.transform

	for idx = 0, parentTran.childCount - 1 do
		local mainGo = parentTran:GetChild(idx)
		local redPoint = goutil.findChild(mainGo, "redPoint")

		GameUtil.rmClickHandler(mainGo)
		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function ArcBtnsTipsView:_onClickBtnCell(cell, data)
	GameUtil.callBack(data.callBack, unpack(data.params))
	self:_onCustomInputCallback(false)
end

function ArcBtnsTipsView:_beforePlayCallBack(groupIdList)
	for _, gropuId in ipairs(groupIdList) do
		-- block empty
	end
end

function ArcBtnsTipsView:_finishPlayCallBack(groupIdList)
	for _, gropuId in ipairs(groupIdList) do
		-- block empty
	end
end

function ArcBtnsTipsView:_beforePlayGroupCallBack(groupId)
	return
end

function ArcBtnsTipsView:_finishPlayGroupCallBack(groupId)
	return
end

function ArcBtnsTipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

return ArcBtnsTipsView
