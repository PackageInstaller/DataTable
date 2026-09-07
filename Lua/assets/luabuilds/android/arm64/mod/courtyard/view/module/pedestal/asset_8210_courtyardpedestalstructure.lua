local CourtYardPedestalStructure = class("CourtYardPedestalStructure")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function CourtYardPedestalStructure:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.parent = arg_1_1
	self.asset = nil
	self.level = 0
	self.isDirty = false
	self.state = var_0_1

	return
end

function CourtYardPedestalStructure:GetRect()
	return self.parent:GetView():GetRect()
end

function CourtYardPedestalStructure:IsEditModeOrIsVisit()
	return self.parent:GetController():IsEditModeOrIsVisit()
end

function CourtYardPedestalStructure:IsEmpty()
	return self.state == var_0_1
end

function CourtYardPedestalStructure:IsLoading()
	return self.state == var_0_2
end

function CourtYardPedestalStructure:IsLoaded()
	return self.state == var_0_4
end

function CourtYardPedestalStructure:IsExit()
	return self.state == var_0_5
end

function CourtYardPedestalStructure:IsDirty()
	return self.state == var_0_3
end

function CourtYardPedestalStructure:Update(arg_9_1)
	self:UpdateLevel(arg_9_1)

	if self:IsEmpty() then
		self:Load()
	elseif self:IsLoading() then
		self:SetDirty()
	elseif self:IsLoaded() then
		self:ReLoad()
	end

	return
end

function CourtYardPedestalStructure:UpdateLevel(arg_10_1)
	if self.level ~= arg_10_1 then
		self.isDirty = true
	end

	self.level = arg_10_1

	return
end

function CourtYardPedestalStructure:Load(arg_11_1)
	self.state = var_0_2

	ResourceMgr.Inst:getAssetAsync(self:GetAssetPath(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		if self:IsExit() or IsNil(arg_12_0) then
			return
		end

		if self:IsDirty() then
			self:ReLoad()

			return
		end

		if arg_11_1 then
			arg_11_1()
		end

		self.state = var_0_4

		local var_12_0 = Object.Instantiate(arg_12_0, self:GetParent())

		self:OnLoaded(var_12_0)

		self.asset = var_12_0

		return
	end), true, true)

	return
end

function CourtYardPedestalStructure:GetParent()
	return self.parent._tf
end

function CourtYardPedestalStructure:SetDirty()
	if self.isDirty then
		self.state = var_0_3
	end

	return
end

function CourtYardPedestalStructure:ReLoad()
	self:Load(function()
		self:Unload()

		return
	end)

	return
end

function CourtYardPedestalStructure:Unload()
	if not IsNil(self.asset) then
		Object.Destroy(self.asset)
	end

	self.asset = nil
	self.state = var_0_1

	return
end

function CourtYardPedestalStructure:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Unload()

	self.state = var_0_5

	return
end

function CourtYardPedestalStructure:OnLoaded()
	return
end

function CourtYardPedestalStructure:GetAssetPath()
	assert(false, "overwrite me !!!")

	return
end

return CourtYardPedestalStructure
