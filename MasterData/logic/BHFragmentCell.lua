-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/view/BHFragmentCell.lua

module("logic.extensions.brotherhood.view.BHFragmentCell", package.seeall)

local BHFragmentCell = class("BHFragmentCell")

function BHFragmentCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._icon = goutil.findChild(go, "icon")

	BeginDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
		self:_onBeginDrag(_go, eventData)
	end)
	EndDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
		self:_onEndDrag(_go, eventData)
	end)
	DragHandler.Get(go):AddLuaHandler(function(_go, eventData)
		self:_onDrag(_go, eventData)
	end)

	local btn = Framework.ButtonAdapter.Get(go)

	btn:AddClickListener(function()
		self:_onClick()
	end)
end

function BHFragmentCell:init(data)
	self._data = data
	self.mainGO.name = "cell_" .. data.fragmentsId

	uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.resource))
end

function BHFragmentCell:reset()
	if self._icon then
		uGuiUtil.clearImage(self._icon)
	end
end

function BHFragmentCell:_onClick()
	local desc = BrotherHoodConfig.instance:getDescByFragmentId(self._data.plotPlan, self._data.fragmentsId)
	local worldPos = self.mainGO.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local screenPos = uiCamera:WorldToScreenPoint(worldPos)
	local offset = {
		-120,
		-120
	}

	CommonTipsMgr.instance:showTips(desc, screenPos, offset)
end

function BHFragmentCell:_onBeginDrag(go, eventData)
	BrotherHoodController.instance:localNotify(BrotherHoodController.BeginDrag, go, eventData, self._data)
end

function BHFragmentCell:_onDrag(go, eventData)
	BrotherHoodController.instance:localNotify(BrotherHoodController.Drag, go, eventData, self._data)
end

function BHFragmentCell:_onEndDrag(go, eventData)
	BrotherHoodController.instance:localNotify(BrotherHoodController.EndDrag, go, eventData, self._data)
end

return BHFragmentCell
