-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/camera/CameraTarget.lua

module("frameworkext.camera.CameraTarget", package.seeall)

local CameraTarget = class("CameraTarget")

function CameraTarget.Get(go)
	return Framework.LuaComponentContainer.Add(go, CameraTarget)
end

function CameraTarget:ctor(container)
	self._go = container.gameObject
	self._ctrls = {}
	self._activeCtrls = {}
end

function CameraTarget:Awake()
	self._camera = self._go:GetComponent("Camera")
	self._cameraTrs = self._go.transform

	CameraTargetMgr.instance:addTarget(self)
end

function CameraTarget:OnDestroy()
	CameraTargetMgr.instance:removeTarget(self)

	self._go = nil
	self._camera = nil
	self._cameraTrs = nil

	self:removeAllCtrls()

	self._ctrls = nil
	self._activeCtrls = nil
end

function CameraTarget:getGO()
	return self._go
end

function CameraTarget:getCamera()
	return self._camera
end

function CameraTarget:getCameraTrs()
	return self._cameraTrs
end

function CameraTarget:addCtrl(ctrlComp)
	local ctrl = ctrlComp.New(self)
	local group = ctrl:getGroup()
	local ctrlList = self._ctrls[group]

	if not ctrlList then
		ctrlList = {}
		self._ctrls[group] = ctrlList
	end

	table.insert(ctrlList, ctrl)

	return ctrl
end

function CameraTarget:removeCtrl(ctrl)
	local group = ctrl:getGroup()
	local ctrlList = self._ctrls[group]

	if ctrlList then
		table.remove(ctrlList, ctrl)
		ctrl:onDestroy()
	end
end

function CameraTarget:removeAllCtrls()
	for k, v in pairs(self._ctrls) do
		local len = #v

		for i = 1, len do
			v[i]:onDestroy()
		end
	end

	self._ctrls = {}
	self._activeCtrls = {}
end

function CameraTarget:removeGroupCtrls(group)
	local ctrlList = self._ctrls[group]

	if ctrlList then
		local curActiveCtrl = self._activeCtrls[group]

		if curActiveCtrl then
			curActiveCtrl:onInactive()
		end

		local len = #ctrlList

		for i = 1, len do
			ctrlList[i]:onDestroy()
		end

		self._ctrls[group] = nil
		self._activeCtrls[group] = nil
	end
end

function CameraTarget:setActive(ctrl)
	local group = ctrl:getGroup()
	local curActiveCtrl = self._activeCtrls[group]

	if curActiveCtrl == ctrl then
		return
	end

	if curActiveCtrl then
		curActiveCtrl:onInactive()
	end

	self._activeCtrls[group] = ctrl

	ctrl:onActive()
end

function CameraTarget:getActiveCtrl(group)
	return self._activeCtrls[group]
end

function CameraTarget:setInactive(ctrl)
	local group = ctrl:getGroup()
	local curActiveCtrl = self._activeCtrls[group]

	if curActiveCtrl == ctrl then
		curActiveCtrl:onInactive()

		self._activeCtrls[group] = nil
	end
end

function CameraTarget:setGroupInactive(group)
	local group = ctrl:getGroup()
	local curActiveCtrl = self._activeCtrls[group]

	if curActiveCtrl then
		curActiveCtrl:onInactive()

		self._activeCtrls[group] = nil
	end
end

function CameraTarget:setAllInactive()
	for k, v in pairs(self._activeCtrls) do
		v:onInactive()
	end

	self._activeCtrls = {}
end

return CameraTarget
