local CaptureEntityBase = class("CaptureEntityBase")

function CaptureEntityBase:GetType()
	return CaptureGameConst.EntityType.Unknow
end

function CaptureEntityBase:Ctor(arg_2_1)
	self.params_ = arg_2_1

	self:InitEntotyObj()

	self.entity = Capture.Runtime.CaptureEntity.New()

	if not isNil(self.gameObject_) then
		self.entity.obj = self.gameObject_
	end

	self.entity.entityType = self:GetType()

	self:Init()
	self:InitComponents()
	CaptureGameMgr:GetGameContext():InsertEntity(self.entity)
end

function CaptureEntityBase:InitGameObject()
	return nil
end

function CaptureEntityBase:InitEntotyObj()
	self.gameObject_ = self:InitGameObject()

	if not isNil(self.gameObject_) then
		self.transform_ = self.gameObject_.transform
	end
end

function CaptureEntityBase:InitComponents()
	return
end

function CaptureEntityBase:Init()
	return
end

function CaptureEntityBase:GetId()
	return self.entity.Identify
end

function CaptureEntityBase:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil
	self.entity = nil
end

return CaptureEntityBase
