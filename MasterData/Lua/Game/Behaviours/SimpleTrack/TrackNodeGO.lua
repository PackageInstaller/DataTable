---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28
---@class TrackNodeGO



local TrackNodeGO = Class('TrackNodeGO')
local KTool = CS.Engine.Lib.KTool
local SpriteRenderer = CS.UnityEngine.SpriteRenderer
local SphereCollider = CS.UnityEngine.SphereCollider
local ParticleSystem = CS.UnityEngine.ParticleSystem



---@param id_ integer
function TrackNodeGO:__init( id_, gameObj_ )
    --printInfo("   ~~~~~~~ TrackNodeGO:__init() ~~~~~~~")
    assert( type(id_) == "number" )
    self.id = id_
    self.isBFSChecked = false
    self.nextTrackNodeGO = nil -- TrackNodeGO
    self.othTrackNodes = {} -- Dic<TrackNodeGO, 1> val:随便写个数, 充当 HaseSet<TrackNodeGO> 
    self.gameObj = gameObj_ -- GameObject, 方便查找
    self.pos = gameObj_.transform.position -- Vector3, 方便查找
    self.renderer = KTool.GetComponent(self.gameObj, typeof(SpriteRenderer))
    self.collider = KTool.GetComponent(self.gameObj, typeof(SphereCollider))


    self.fxGameObjects = {} -- 一些特效 gameObjects
    local psComps = self.gameObj.transform:GetComponentsInChildren(typeof(ParticleSystem),true) -- 包含自己
    for i=0, psComps.Length-1 do 
        local ps = psComps[i]
        if ps.name ~= self.gameObj.name then 
            table.insert( self.fxGameObjects, ps.gameObject )
        end
    end

    self:Hide()

end


function TrackNodeGO:__delete()
    --printInfo("   ~~~~~~~ TrackNodeGO:__delete() ~~~~~~~")
    self.id = nil
    self.isBFSChecked = nil
    self.nextTrackNodeGO = nil
    self.othTrackNodes = nil
end




---@param oth TrackNodeGO
---@return void
function TrackNodeGO:AddOthTrackNode( oth ) 
    if isNull( self.othTrackNodes[oth] ) then -- 不存在
        --printInfo("添加 oth TrackNodeGO")
        self.othTrackNodes[oth] = 1
    end 
end


---@param a TrackNodeGO
---@param b TrackNodeGO
function TrackNodeGO.Connect( a, b ) 
    a:AddOthTrackNode(b)
    b:AddOthTrackNode(a)
end


function TrackNodeGO:Display() 
    self.renderer.enabled = true
    self.collider.enabled = true

    for _,fxGO in pairs(self.fxGameObjects) do 
        KTool.SetActive( fxGO, true )
    end
end


function TrackNodeGO:Hide() 
    self.renderer.enabled = false
    self.collider.enabled = false

    for _,fxGO in pairs(self.fxGameObjects) do 
        KTool.SetActive( fxGO, false )
    end
end


function TrackNodeGO:IsVisible()
    return self.renderer.enabled
end


-- debug
function TrackNodeGO:PrintInfo() 
    local s = "trackNodeGO:"
    .. "\n    id = " .. self.id 
    .. "\n    nextTrackNodeGO = " .. ( isNull(self.nextTrackNodeGO) and "nil" or tostring(self.nextTrackNodeGO.id) )
    .. "\n    othTrackNodes:  "
    for oth,j in pairs(self.othTrackNodes) do 
        s = s .. tostring(oth.id) .. ", "
    end
    s = s .. "\n"
    printInfo(s)
    return s
end


---@param s string
---@return integer
function TrackNodeGO.StringToTrackNodeID( s ) 
    -- 加 0.5f 后再 floor, 避免浮点数波动;
    return math.floor(tonumber(s) * 10.0 + 0.5) -- floor() 能返回整数
end



return TrackNodeGO
