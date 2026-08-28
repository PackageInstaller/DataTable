
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type Engine.Lib.KTool
local KTool         = CS.Engine.Lib.KTool
local LineRenderer                   = CS.UnityEngine.LineRenderer
local Material                       = CS.UnityEngine.Material
--endregion

--region define
local TextureId = CS.UnityEngine.Shader.PropertyToID("_MainTex")
local SetActive = CfUtils.SetActive
local LineRendererType = typeof(LineRenderer)
local MaterialType = typeof(Material)
--endregion

---@class ClubGVGLinesControl
local ClubGVGLinesControl = Class('ClubGVGLinesControl')

function ClubGVGLinesControl:__init()

end


function ClubGVGLinesControl:__delete()

end


function ClubGVGLinesControl:Awake()
    self.LineRoot       = self.controller.transform
    self.Line           = self.LineRoot:Find("Line")
    local lineGo        = self.Line.gameObject
    local lineRenderer  = KTool.GetComponent(lineGo, LineRendererType)
    self._lineRenders   = {lineRenderer}
    self._lineMaterials = {lineRenderer.material}

end


-- function ClubGVGLinesControl:Start()
-- end


function ClubGVGLinesControl:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 

function ClubGVGLinesControl:Init(density)
    self._density = density

end



--endregion 


--region logic 

---@param lines {startPos:Vector3, endPos:Vector3}
function ClubGVGLinesControl:FreshLines(lines)
    local dataCount = #lines
    local childCount = self.LineRoot.childCount
    local forTimes = math.max(childCount, dataCount)
    for i = 1, forTimes do
        local data = lines[i]
        local lineRenderer = self._lineRenders[i]
        local isExist = isNotNull(lineRenderer)
        if data then
            local material = self._lineMaterials[i]
            if not isExist then
                local lineGo = self.LineRoot.gameObject:AddChild(self.Line.gameObject)
                lineRenderer = KTool.GetComponent(lineGo, LineRendererType)
                material     = lineRenderer.material
                table.insert(self._lineMaterials, material)
                table.insert(self._lineRenders, lineRenderer)
            end

            local startPos, endPos = SafeUnpack(data)
            self:UpdateLine(lineRenderer, material, startPos, endPos)
            SetActive(lineRenderer, true)

        elseif isExist then
            SetActive(lineRenderer, false)

        end
    end
    
end

function ClubGVGLinesControl:UpdateLine(lineRenderer, material, startPos, endPos)
    lineRenderer:SetPosition(0, startPos)
    lineRenderer:SetPosition(1, endPos)

    local lineLen = (endPos - startPos).magnitude
    local tiling = Vector2.New(lineLen * self._density, 1)
    material:SetTextureScale(TextureId, tiling)

end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGLinesControl
