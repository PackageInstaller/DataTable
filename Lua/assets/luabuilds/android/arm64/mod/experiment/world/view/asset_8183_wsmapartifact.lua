local WSMapArtifact = class("WSMapArtifact", import("...BaseEntity"))

WSMapArtifact.Fields = {
	theme = "table",
	prefab = "string",
	transform = "userdata",
	attachment = "table",
	moduleTF = "userdata",
	item_info = "table"
}

function WSMapArtifact:Build()
	self.transform = GetOrAddComponent(GameObject.New(), "RectTransform")
	self.transform.name = "model"

	return
end

function WSMapArtifact:Dispose()
	self:Unload()
	Destroy(self.transform)
	self:Clear()

	return
end

function WSMapArtifact:Setup(arg_3_1, arg_3_2, arg_3_3)
	assert(not self.item_info)

	self.item_info = arg_3_1
	self.theme = arg_3_2
	self.attachment = arg_3_3

	self:Load()

	return
end

function WSMapArtifact:Load()
	local var_4_0 = self.item_info[3]

	self.prefab = self.item_info[3]

	local var_4_1 = PoolMgr.GetInstance()

	var_4_1:GetPrefab(WorldConst.ResChapterPrefab .. self.item_info[3], self.item_info[3], true, function(arg_5_0)
		if self.prefab then
			self.moduleTF = tf(arg_5_0)

			self.moduleTF:SetParent(self.transform, false)
			self:Init()
		else
			var_4_1:ReturnPrefab(WorldConst.ResChapterPrefab .. var_4_0, var_4_0, arg_5_0)
		end

		return
	end)

	return
end

function WSMapArtifact:Unload()
	if self.prefab and self.moduleTF then
		PoolMgr.GetInstance():ReturnPrefab(WorldConst.ResChapterPrefab .. self.prefab, self.prefab, self.moduleTF.gameObject, true)
	end

	self.prefab = nil
	self.moduleTF = nil

	return
end

function WSMapArtifact:Init()
	local var_7_0 = self.moduleTF:GetComponent(typeof(UnityEngine.UI.Graphic))

	if not IsNil(var_7_0) then
		var_7_0.raycastTarget = false
	end

	for iter_7_0, iter_7_1 in ipairs((self.moduleTF:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true):ToTable())) do
		iter_7_1.raycastTarget = false
	end

	local var_7_1 = Vector2.zero
	local var_7_2 = Vector3.one
	local var_7_3 = Vector3.zero

	if self.attachment then
		var_7_1 = self.attachment:GetDeviation()
		var_7_2 = self.attachment:GetScale()
		var_7_3 = self.attachment:GetMillor() and Vector3(0, 180, 0) or Vector3.zero
	else
		var_7_1 = Vector2(self.item_info[4], self.item_info[5])
	end

	self.transform.anchoredPosition = var_7_1
	self.transform.localScale = var_7_2
	self.transform.localEulerAngles = var_7_3

	return
end

return WSMapArtifact
