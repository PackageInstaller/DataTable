

--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainDialog12001801.prefab > name: CatLifeDisplay
---@class ParkourGameHp
---@field Env                           	ParkourGameHp                           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field HpNode                        	UnityEngine.RectTransform               	@ 0    
local ParkourGameHp = Class("ParkourGameHp")


--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Vector3 = CS.UnityEngine.Vector3
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Quaternion = CS.UnityEngine.Quaternion
local Canvas = CS.UnityEngine.Canvas
local Animator = CS.UnityEngine.Animator
local GameObject = CS.UnityEngine.GameObject




---@class ParkourGameHp.InputData
---@field maxHp number
---@field hp number
---@field loseHpEventName string
---@field animationName string

function ParkourGameHp:__init()
    self.hpNodes = {}
end

function ParkourGameHp:__delete()
    self.controller = nil
end

function ParkourGameHp:Awake()
end

---@param inData ParkourGameHp.InputData
function ParkourGameHp:RefreshData(inData)
    --printError("ParkourGameHp RefreshData")
    self.inData = inData
    self:RegisterEvent()
    self:RefreshUI()
end

function ParkourGameHp:RefreshUI()
    for i = 1, checkInt(self.inData.hp) do
        if isNull(self.hpNodes[i]) then
            self.hpNodes[i] = GameObject.Instantiate(self.HpNode.gameObject, self.HpNode.parent)
            self.hpNodes[i].name = "HP_" .. tostring(i)
        end
        self.hpNodes[i]:SetActive(true)
        local alive = self.hpNodes[i].transform:Find("Alive")
        local dead = self.hpNodes[i].transform:Find("Dead")
        CfUtils.SetActive(alive.gameObject, true)
        CfUtils.SetActive(dead.gameObject, false)
    end
end

function ParkourGameHp:RegisterEvent()
    if self.events then
        CfUtils.EventsUndecorated(self.events)
    end
    
    self.events = CfUtils.EventsDecorated({
        [self.inData.loseHpEventName] = Bind(self, self.LoseHp)
    })
end

function ParkourGameHp:SetHp(hp)
    hp = checkInt(hp)
    self.inData.hp = hp
    self:RefreshUI()
end

function ParkourGameHp:LoseHp(hp)
    --print("hp" .. tostring(hp) .. "; type = " .. type(hp))
    hp = checkInt(hp)
    self.inData.hp = hp
    local preHp = hp+1
    local hpNode = self.hpNodes[preHp]

    if isNull(hpNode) then 
        --[[
        -- 暂时没查出来为什么...
        printError("hpNode is null; preHp = " .. tostring(preHp) .. "; name = " .. tostring(self.inData.hpName)  )
        printError("hpNodes num = " .. tostring(table.count(self.hpNodes)))
        for i,e in pairs(self.hpNodes) do 
            printError("i:"..tostring(i).."; node:"..tostring(e))
        end 
        ]]--
    else 
        CfUtils.PlayAnimation(hpNode, self.inData.animationName)
    end 
end

function ParkourGameHp:OnDestroy()
    --printError("ParkourGameHp OnDestroy")
    --self.hpNodes = nil
    if self.events then
        CfUtils.EventsUndecorated(self.events)
    end
end

return ParkourGameHp