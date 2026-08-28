


---@class LuaSnowEffectHelper
---@field SnowMaterial                      	UnityEngine.Material @雪锟侥诧拷锟斤拷锟斤拷
local SnowEffectHelper = Class('SnowEffectHelper')




------------ import ------------
local GameObject = CS.UnityEngine.GameObject
local LayerMask = CS.UnityEngine.LayerMask
local MeshFilter = CS.UnityEngine.MeshFilter
local MeshRenderer = CS.UnityEngine.MeshRenderer
local SnowEffect = CS.SnowEffect
local Math = CS.System.Math
local Mathf = CS.UnityEngine.Mathf
local Time = CS.UnityEngine.Time
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Object = CS.UnityEngine.Object
------------ import ------------



function SnowEffectHelper:__init()
	printInfo("   ~~~~~~~ SnowEffectHelper:__init() ~~~~~~~")
end

function SnowEffectHelper:__delete()
	printInfo("   ~~~~~~~ SnowEffectHelper:__delete() ~~~~~~~")
end

function SnowEffectHelper:Awake()
    -- local SDKService = import('Game.Entry.SDKService')
    -- local sdkService = SDKService:GetInstance()
    -- local isEnabled = sdkService:IsSDKShowCommunity()
	---@type SnowEffectHelper
	local snowEffectHelper = CfUtils.GetOrAddComponent(self.controller.gameObject, typeof(CS.SnowEffectHelper))
	self.SnowMaterial = snowEffectHelper.SnowMaterial
    KTool.SetActive(self.controller.gameObject, true);
    printInfo("   ~~~~~~~ SnowEffectHelper:Awake() ~~~~~~~")
end

function SnowEffectHelper:OnDestroy()
	local behaviourAction = KTool.GetComponent(self.controller.gameObject, typeof(BehaviourAction))
	if behaviourAction then
		behaviourAction.UpdateAction = nil
	end
    if (not isNull(self.SnowMaterial)) then
		Object.Destroy(self.SnowMaterial)
	end
	if (not isNull(self.snowObject)) then
		Object.Destroy(self.snowObject)
	end
	self.controller = nil --删锟斤拷lua锟斤拷锟斤拷锟矫碉拷锟斤拷c#锟斤拷锟斤拷 锟斤拷锟津不伙拷锟斤拷锟絚# gc锟斤拷锟秸碉拷锟斤拷锟斤拷
    self:Delete()
end

function SnowEffectHelper:OnEnable()
	printInfo("   ~~~~~~~ SnowEffectHelper:OnEnable() ~~~~~~~")
	if isNull(self.SnowMaterial) then
		return
	end

	printInfo("   ~~~~~~~ SnowEffectHelper:OnEnable2() ~~~~~~~")
	local parentTrans = self.controller.transform.parent
	self.snowObject = parentTrans:Find("Snow")
	--GameObject.Find("Snow")
	if isNull(self.snowObject) then
		self.snowObject = CfUtils.GameObjectCreate("Snow", parentTrans.gameObject, false)
		--GameObject("Snow")
		self.snowObject.layer = LayerMask.NameToLayer("scene")
		KTool.GetOrAddComponent(self.snowObject, typeof(MeshFilter))
		self.snowMeshRender = KTool.GetOrAddComponent(self.snowObject, typeof(MeshRenderer))
		self.snowMeshRender.material = self.SnowMaterial
		self.snowEffect = KTool.GetOrAddComponent(self.snowObject,typeof(SnowEffect))
	else
		self.snowObject = self.snowObject.gameObject
		self.snowMeshRender = KTool.GetOrAddComponent(self.snowObject, typeof(MeshRenderer))
		self.snowMeshRender.enabled = true;
		self.snowEffect = KTool.GetOrAddComponent(self.snowObject,typeof(SnowEffect))
	end
	if (not isNull(self.snowEffect)) then
		self.snowEffect.Range = 9.75
		self.snowEffect.SnowNum = 2000
		self.snowEffect.SnowSize = 0.02
		self.snowEffect.Distance = 2
		self.snowEffect.Noise = 1.11
		self.MaxSnowNum = 2000
		self.TiggerTime = 1
		self.fadeInTime = 0
		self.fadeOutTime = 2
		self.duration = 9999
		self.startTime = Time.time
	end
end

function SnowEffectHelper:Start()
	--self:OnEnable()
	printInfo("   ~~~~~~~ SnowEffectHelper:Start() ~~~~~~~")
	KTool.SetActive(self.controller.gameObject, true);
    -- ==============================
    -- 锟斤拷 Update() 锟斤拷锟斤拷:
    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = function(behaviourAction)
            self:Update()
        end
    end
end

function  SnowEffectHelper:Update()
	if isNull(self.snowEffect) then
		return
	end
	local currentTime = Math.Max(0, Time.time - self.startTime - self.TiggerTime)
	
	if  currentTime < self.fadeInTime then
        local num = self.MaxSnowNum * currentTime / self.fadeInTime
        if self.snowEffect.SnowNum ~= num then
            self.snowEffect.SnowNum = num
        end
    elseif currentTime < self.fadeInTime + self.duration then
        if self.snowEffect.SnowNum ~= self.MaxSnowNum then
            self.snowEffect.SnowNum = self.MaxSnowNum
        end
    else
        local num = self.MaxSnowNum * (1 - (currentTime - self.fadeInTime - self.duration) / self.fadeOutTime)
        if num < 0 then
            self.snowMeshRender.enabled = false
            self.controller.enabled = false
        else
            if self.snowEffect.SnowNum ~= num then
                self.snowEffect.SnowNum = num
            end
        end
    end
end


return SnowEffectHelper
