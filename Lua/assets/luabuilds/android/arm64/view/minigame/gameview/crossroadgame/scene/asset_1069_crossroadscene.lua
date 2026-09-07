local CrossRoadScene = class("CrossRoadScene")

function CrossRoadScene:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._TF = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self._sceneMask = self._TF:Find("sceneMask")
	self._tpl = self._TF:Find("tpl")

	function self._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		self:onEventHandle(arg_2_0, arg_2_1, arg_2_2)

		return
	end

	self._gameRunningData = CrossRoadRunningData.New(self._tpl, self._sceneMask, self._gameVo)
	self._carMgr = CrossRoadCarMgr.New(self._sceneMask, self._gameRunningData, self._eventCallback)
	self._playerMgr = CrossRoadPlayerMgr.New(self._tpl, self._gameRunningData, self._eventCallback)
	self._roleMgr = CrossRoadRoleMgr.New(self._tpl, self._gameRunningData, self._eventCallback)
	self._itemMgr = CrossRoadItemMgr.New(self._tpl, self._gameRunningData, self._eventCallback)
	self._colliderMgr = CrossRoadColliderMgr.New(self._gameRunningData, self._eventCallback, self._playerMgr)

	self:ShowContainer(false)

	return
end

function CrossRoadScene:onEventHandle(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == CrossRoadGameConst.GET_SCORE then
		self._event:emit(SimpleMGEvent.ADD_SCORE, {
			score = arg_3_2[1]
		})
	elseif arg_3_1 == CrossRoadGameConst.HIT_ROLER then
		self._event:emit(CrossRoadGameView.SUB_LIFE)
	elseif arg_3_1 == CrossRoadGameConst.NEW_ROUND then
		if arg_3_2 > 0 then
			self._itemMgr:MakeHongcha()
		end
	elseif arg_3_1 == CrossRoadGameConst.MAKE_BING_MIAN then
		self._itemMgr:MakeBingMain(arg_3_2)
	elseif arg_3_1 == CrossRoadGameConst.MAKE_XUAN_WO then
		self._itemMgr:MakeXuanWo(arg_3_2)
	elseif arg_3_1 == CrossRoadGameConst.GET_HONGCHA then
		self._event:emit(CrossRoadGameView.ADD_LIFE)
		self._itemMgr:ClearHongcha()
	elseif arg_3_1 == CrossRoadGameConst.ADD_ROLE then
		self._gameVo:AddRoleCnt()
	elseif arg_3_1 == CrossRoadGameConst.DISPOSE_BIN then
		self._itemMgr:DisposeItemByIndex(arg_3_2)
	end

	return
end

function CrossRoadScene:Prepare()
	self._carMgr:Prepare()
	self._playerMgr:Prepare()
	self._roleMgr:Prepare()
	setActive(self._gameRunningData:GetHongChaTpl(), false)

	return
end

function CrossRoadScene:Start()
	self:ShowContainer(true)

	return
end

function CrossRoadScene:Step()
	local var_6_0 = self._gameVo:GetDeltaTime()

	self._gameRunningData:SetJoyData((self._gameVo:GetJoyStickData()))
	self._itemMgr:Step(var_6_0)
	self._carMgr:Step(var_6_0)
	self._playerMgr:Step(var_6_0)
	self._roleMgr:Step(var_6_0)
	self._colliderMgr:Step(var_6_0)

	return
end

function CrossRoadScene:Clear()
	self._gameRunningData:Clear()
	self._carMgr:Clear()
	self._playerMgr:Clear()
	self._roleMgr:Clear()
	self._colliderMgr:Clear()
	self._itemMgr:Clear()

	return
end

function CrossRoadScene:Dispose()
	self._gameRunningData:Dispose()

	self._gameRunningData = nil

	return
end

function CrossRoadScene:Stop()
	return
end

function CrossRoadScene:ShowContainer(arg_10_1)
	SetActive(self._sceneMask, arg_10_1)

	return
end

return CrossRoadScene
