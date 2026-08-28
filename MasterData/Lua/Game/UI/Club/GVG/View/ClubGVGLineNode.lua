
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local XLuaUtils = CS.Engine.Lib.XLuaUtils
--endregion

--region define
local Density         = 3.35
local MoveSpeed       = 0.04
local MoveSpeedVector = Vector2.New(MoveSpeed, 0)
local TextureId       = CS.UnityEngine.Shader.PropertyToID("_MainTex")
local SetActive = CfUtils.SetActive
local SelfClubColor       = XLuaUtils.HexToColor("#63f6ff")
local EnemyClubColor      = XLuaUtils.HexToColor("#ff9ad1")


--endregion

--- from:  > name: Line
---@class ClubGVGLineNode
---@field Env                           	ClubGVGLineNode                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Line                          	UnityEngine.LineRenderer                	@ 0    
---@field Claw                          	UnityEngine.SpriteRenderer              	@ 1    
---@field Head                          	UnityEngine.Transform                   	@ 2    
---@field Woman                         	UnityEngine.Transform                   	@ 3    
---@field Man                           	UnityEngine.Transform                   	@ 4    
local ClubGVGLineNode = Class('ClubGVGLineNode')

function ClubGVGLineNode:__init()

end


function ClubGVGLineNode:__delete()

end


function ClubGVGLineNode:Awake()
    self.ClawTrans = self.Claw.transform
    self._offset = Vector2.New(0, 0)

    self.Head.localScale = Vector3.New(0.6, 0.6, 1)
    self.Woman.localScale = Vector3.New(0.7, 0.7, 1)
    self.Man.localScale = Vector3.New(0.7, 0.7, 1)
end


-- function ClubGVGLineNode:Start()
-- end


function ClubGVGLineNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---Fresh
---@param startPos Vector3 行军起始点
---@param endPos Vector3 行军终点点
---@param isSelfClub boolean 是否是自己工会成员
---@param gender number | nil  1 表示男 2表示女 nil 表示不是本人

function ClubGVGLineNode:Fresh(startPos, endPos, isSelfClub, gender, endTime, curSeconds, totalSeconds)
    SetActive(self.controller, true)

    self._endTime = endTime
    local color = isSelfClub and SelfClubColor or EnemyClubColor

    local lineRenderer = self.Line
    lineRenderer:SetPosition(0, startPos)
    lineRenderer:SetPosition(1, endPos)

    lineRenderer.startColor = color
    lineRenderer.endColor = color

    local lineLen = (endPos - startPos).magnitude
    local tiling = Vector2.New(lineLen * Density, 1)
    local material = self:GetMaterial()
    material:SetTextureScale(TextureId, tiling)
    
    -- self._offset = Vector2.New(0, 0)

    local isSelf = gender ~= nil
    SetActive(self.Head, isSelf)
    SetActive(self.Claw, not isSelf)
    if isSelf then
        SetActive(self.Woman, gender == 2)
        SetActive(self.Man, gender == 1)
        
    else
        self.Claw.color = color
        self.ClawTrans.up = endPos - startPos
    end

    local leftSeconds = endTime - curSeconds
    local moveNode = isSelf and self.Head or self.ClawTrans
    self._moveNode = moveNode
    self._startPos, self._endPos = startPos, endPos
    self._endTime = endTime
    self._totalSeconds = totalSeconds

    self:UpdateBySeconds(curSeconds)

end

function ClubGVGLineNode:UpdatePosition()
    self._offset = self._offset - MoveSpeedVector
    local material = self:GetMaterial()
    material:SetTextureOffset(TextureId, self._offset)
end

function ClubGVGLineNode:UpdateBySeconds(curSeconds)
    local endTime = self._endTime
    local startPos, endPos = self._startPos, self._endPos
    local totalSeconds = self._totalSeconds
    local leftSeconds = endTime - curSeconds
    local moveNode = self._moveNode
    local pos = Vector3.Lerp(startPos, endPos, (totalSeconds - leftSeconds) / totalSeconds)
    moveNode.position = pos


end

function ClubGVGLineNode:Reset()
    SetActive(self.controller, false)
    self._offset = Vector2.New(0, 0)
end

--endregion 


--region get/set 

function ClubGVGLineNode:GetMaterial()
   if isNull(self._material) then
        self._material = self.Line.material
   end 
   return self._material
end

---endregion 


--region handler 


---endregion 


return ClubGVGLineNode
