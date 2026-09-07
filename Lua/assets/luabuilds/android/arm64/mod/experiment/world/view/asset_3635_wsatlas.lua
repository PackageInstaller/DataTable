local WSAtlas = class("WSAtlas", import("...BaseEntity"))

WSAtlas.Fields = {
	tfCamera = "userdata",
	atlas = "table",
	staticEntranceDic = "table",
	transform = "userdata",
	onClickColor = "function",
	tfMapSelect = "userdata",
	defaultSprite = "userdata",
	tfEntity = "userdata",
	cmPointer = "userdata",
	addSprite = "userdata",
	tfSpriteScene = "userdata",
	tfMapScene = "userdata",
	tfActiveMark = "userdata",
	selectEntrance = "table"
}
WSAtlas.Listeners = {
	onUpdatePressingAward = "OnUpdatePressingAward",
	onUpdateActiveEntrance = "OnUpdateActiveEntrance",
	onUpdateProgress = "OnUpdateProgress"
}
WSAtlas.spriteBaseSize = Vector2(2048, 1347)

function WSAtlas:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSAtlas:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:RemoveAtlasListener()
	self:UpdateStaticMark()
	self:ActiveSelect(self.selectEntrance, false)

	if self.tfActiveMark then
		self:DestroyActiveMark()
	end

	eachChild(self.tfMapScene:Find("lock_layer"), function(arg_3_0)
		self:RemoveExtraMarkPrefab(arg_3_0)

		return
	end)
	self:ReturnScene()
	self:Clear()

	return
end

function WSAtlas:Init()
	self.staticEntranceDic = {}

	return
end

function WSAtlas:UpdateAtlas(arg_5_1)
	if self.atlas ~= arg_5_1 then
		self:RemoveAtlasListener()

		self.atlas = arg_5_1

		self:AddAtlasListener()
		self:UpdateModelMask()
		self:OnUpdateActiveEntrance(nil, nil, self.atlas:GetActiveEntrance())
		self:OnUpdatePressingAward()
	end

	return
end

function WSAtlas:AddAtlasListener()
	if self.atlas then
		self.atlas:AddListener(WorldAtlas.EventUpdateProgress, self.onUpdateProgress)
		self.atlas:AddListener(WorldAtlas.EventUpdateActiveEntrance, self.onUpdateActiveEntrance)
		self.atlas:AddListener(WorldAtlas.EventAddPressingEntrance, self.onUpdatePressingAward)
	end

	return
end

function WSAtlas:RemoveAtlasListener()
	if self.atlas then
		self.atlas:RemoveListener(WorldAtlas.EventUpdateProgress, self.onUpdateProgress)
		self.atlas:RemoveListener(WorldAtlas.EventUpdateActiveEntrance, self.onUpdateActiveEntrance)
		self.atlas:RemoveListener(WorldAtlas.EventAddPressingEntrance, self.onUpdatePressingAward)
	end

	return
end

function WSAtlas:LoadScene(arg_8_1)
	assert(false, "overwrite by subclass")

	return
end

function WSAtlas:ReturnScene()
	assert(false, "overwrite by subclass")

	return
end

function WSAtlas:ShowOrHide(arg_10_1)
	setActive(self.transform, arg_10_1)

	return
end

function WSAtlas:GetMapScreenPos(arg_11_1)
	return self.cmPointer:GetMapScreenPos(arg_11_1)
end

function WSAtlas:UpdateSelect(arg_12_1)
	self:ActiveSelect(self.selectEntrance, false)
	self:ActiveSelect(arg_12_1, true)

	return
end

function WSAtlas:ActiveSelect(arg_13_1, arg_13_2)
	self.selectEntrance = arg_13_2 and arg_13_1 or nil

	if not arg_13_1 or self.staticEntranceDic[arg_13_1.id] then
		return
	end

	if arg_13_1:HasPort() then
		-- block empty
	else
		setActive(self.tfMapSelect:Find("A" .. arg_13_1:GetColormaskUniqueID() .. "_2"), arg_13_2)
	end

	return
end

function WSAtlas:ActiveStatic(arg_14_1, arg_14_2)
	self.staticEntranceDic[arg_14_1.id] = arg_14_2

	if arg_14_1 == self.selectEntrance then
		return
	end

	if arg_14_1:HasPort() then
		-- block empty
	else
		local var_14_0 = self.tfMapSelect:Find("A" .. arg_14_1:GetColormaskUniqueID() .. "_2")

		LeanTween.cancel(go(var_14_0))

		local var_14_1 = var_14_0:GetComponent("SpriteRenderer").color

		var_14_1.a = arg_14_2 and 0 or 1
		var_14_0:GetComponent("SpriteRenderer").color = var_14_1

		if arg_14_2 then
			setActive(var_14_0, true)
			LeanTween.alpha(go(var_14_0), 0.75, 1):setFrom(0):setLoopPingPong()
		else
			setActive(var_14_0, self.selectEntrance == arg_14_1)
		end
	end

	return
end

WSAtlas.pressingMaskColor = Color.New(0.027450980392156862, 0.27450980392156865, 0.5490196078431373, 0.5019607843137255)
WSAtlas.openMaskColor = Color.New(0, 0, 0, 0)
WSAtlas.lockMaskColor = Color.New(0, 0, 0, 0.4)

function WSAtlas:UpdateModelMask()
	for iter_15_0, iter_15_1 in pairs(self.atlas.entranceDic) do
		self:UpdateEntranceMask(iter_15_1)
	end

	return
end

function WSAtlas:UpdateEntranceMask(arg_16_1)
	if arg_16_1:HasPort() then
		-- block empty
	else
		local var_16_0 = self.tfMapScene:Find("lock_layer/A" .. arg_16_1:GetColormaskUniqueID()):GetComponent("SpriteRenderer")

		if arg_16_1:IsPressing() then
			var_16_0.color = WSAtlas.pressingMaskColor
			var_16_0.material = self.addSprite
		elseif self.atlas.transportDic[arg_16_1.id] and arg_16_1:IsOpen() then
			var_16_0.color = WSAtlas.openMaskColor
			var_16_0.material = self.defaultSprite
		else
			var_16_0.color = WSAtlas.lockMaskColor
			var_16_0.material = self.defaultSprite
		end
	end

	return
end

function WSAtlas:SetSairenMarkActive(arg_17_1, arg_17_2)
	self:DoUpdatExtraMark(arg_17_1, "dsj_srgr", arg_17_2, function(arg_18_0)
		if arg_17_2 then
			arg_18_0:GetComponent("SpriteRenderer").sprite = arg_17_1:GetComponent("SpriteRenderer").sprite
		end

		return
	end)

	return
end

function WSAtlas:OnUpdateProgress(arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0 in pairs(arg_19_3) do
		self:UpdateEntranceMask((self.atlas:GetEntrance(iter_19_0)))
	end

	self:UpdateCenterEffectDisplay()

	return
end

function WSAtlas:BuildActiveMark()
	self.tfActiveMark = tf(GameObject.New())
	self.tfActiveMark.gameObject.layer = Layer.UI
	self.tfActiveMark.name = "active_mark"

	self.tfActiveMark:SetParent(self.tfSpriteScene, false)
	setActive(self.tfActiveMark, false)

	return
end

function WSAtlas:DestroyActiveMark()
	self:RemoveExtraMarkPrefab(self.tfActiveMark)
	Destroy(self.tfActiveMark)

	return
end

function WSAtlas:LoadExtraMarkPrefab(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = PoolMgr.GetInstance()

	var_22_0:GetPrefab("world/mark/" .. arg_22_2, arg_22_2, true, function(arg_23_0)
		if IsNil(arg_22_1) then
			var_22_0:ReturnPrefab("world/mark/" .. arg_22_2, arg_22_2, arg_23_0, true)
		else
			arg_23_0.name = arg_22_2

			tf(arg_23_0):SetParent(arg_22_1, false)
			setActive(arg_23_0, true)
			existCall(arg_22_3, tf(arg_23_0))
		end

		return
	end)

	return
end

function WSAtlas:RemoveExtraMarkPrefab(arg_24_1)
	local var_24_0 = PoolMgr.GetInstance()

	eachChild(arg_24_1, function(arg_25_0)
		var_24_0:ReturnPrefab("world/mark/" .. arg_25_0.name, arg_25_0.name, go(arg_25_0), true)

		return
	end)

	return
end

function WSAtlas:DoUpdatExtraMark(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_1:Find(arg_26_2)

	if var_26_0 then
		setActive(var_26_0, arg_26_3)
		existCall(arg_26_4, var_26_0)
	elseif arg_26_3 then
		self:LoadExtraMarkPrefab(arg_26_1, arg_26_2, arg_26_4)
	end

	return
end

function WSAtlas:OnUpdateActiveEntrance(arg_27_1, arg_27_2, arg_27_3)
	if arg_27_3 then
		self.tfActiveMark.localPosition = WorldConst.CalcModelPosition(arg_27_3, self.spriteBaseSize)
	end

	setActive(self.tfActiveMark, arg_27_3)

	return
end

function WSAtlas:UpdateStaticMark(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(self.staticEntranceDic) do
		self:ActiveStatic(self.atlas:GetEntrance(iter_28_0), false)
	end

	for iter_28_2, iter_28_3 in pairs(arg_28_1 or {}) do
		if iter_28_3 then
			self:ActiveStatic(self.atlas:GetEntrance(iter_28_2), true)
		end
	end

	return
end

function WSAtlas:OnUpdatePressingAward(arg_29_1, arg_29_2, arg_29_3)
	arg_29_3 = arg_29_3 or self.atlas.transportDic

	for iter_29_0, iter_29_1 in pairs(arg_29_3) do
		if iter_29_1 then
			self:UpdateEntranceMask(self.atlas:GetEntrance(iter_29_0))
		end
	end

	return
end

function WSAtlas:UpdateCenterEffectDisplay()
	local var_30_0 = nowWorld():CheckAreaUnlock(5)

	setActive(self.tfEntity:Find("decolation_layer/DSJ_xuanwo"), not var_30_0)
	setActive(self.tfEntity:Find("decolation_layer/DSJ_xuanwo_jianhua"), var_30_0)

	return
end

return WSAtlas
