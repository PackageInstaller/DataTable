
local MeshRenderer = CS.UnityEngine.MeshRenderer
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool

local FrostedGlassForward = Class("FrostedGlassForward")

function FrostedGlassForward:__init()
	self.material = nil
	self.meshRenderer = nil
end

function FrostedGlassForward:__delete()
	self.material = nil
	self.meshRenderer = nil
end

function FrostedGlassForward:Awake()
	self.meshRenderer = self.controller.gameObject:GetComponent(typeof(MeshRenderer))
	if self.meshRenderer ~= nil then
		self.material = self.meshRenderer.sharedMaterial
	end
end

function FrostedGlassForward:Start()
	-- 绑定 Update() 函数:
    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = function(behaviourAction)
            self:Update()
        end
    end
end

function FrostedGlassForward:Update()
    if self.material ~= nil then
		self.material:SetVector("_Direction",CS.UnityEngine.Vector4(-self.controller.gameObject.transform.right.x,-self.controller.gameObject.transform.right.y,-self.controller.gameObject.transform.right.z,1))
	end
end

function FrostedGlassForward:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
end


return FrostedGlassForward