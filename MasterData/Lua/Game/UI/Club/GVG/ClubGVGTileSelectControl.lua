--region import
---@type ClubGVGUtils
local ClubGVGUtils = import("Game.UI.Club.GVG.ClubGVGUtils")
local Vector3Int = CS.UnityEngine.Vector3Int
--endregion

--region defines
local GVGConstants     = ClubGVGUtils.Constants

local Vector3IntIns = Vector3Int.zero

local RecordNeighborId = {}
local RecordActivePos  = {}

-- local ClearTable
--endregion

---@class ClubGVGTileSelectControl
local ClubGVGTileSelectControl = Class('ClubGVGTileSelectControl')


function ClubGVGTileSelectControl:__init()

end


function ClubGVGTileSelectControl:__delete()

end

---@param buildingTileMap UnityEngine.Tilemaps.Tilemap
---@param selectTileMap UnityEngine.Tilemaps.Tilemap
---@param mainCamera UnityEngine.Camera
---@param mgr ClubGVGMgr
function ClubGVGTileSelectControl:Init(buildingTileMap, selectTileMap, mainCamera, mgr, selectTileBase)
    self._mgr = mgr
    self._buildingTileMap = buildingTileMap
    self._selectTileMap = selectTileMap
    self._selectTileBase = selectTileBase

    local clubId2Building = mgr:GetClubId2Building()
    -- local buildingId2TileData = mgr:GetBuildId2TileData()
    -- local selfClubId = mgr:GetClubId()

    -- self._clubId2Color = {}
    -- local enemyColorId = 1
    -- local GetEnemyColorId = function()
    --     enemyColorId = enemyColorId + 1
    --     return enemyColorId
    -- end
    -- for clubId, buildingId2buildingInfo in pairs(clubId2Building) do
    --     if clubId > 0 then
    --         local colorId = selfClubId == clubId and 1 or GetEnemyColorId()
    --         local vo = ClubGVGUtils.GetClubGVGTileColorVo(colorId)
    --         if vo then
    --             local color = vo:GetColor()
    --             self._clubId2Color[clubId] = color
    --             for buildingId, info in pairs(buildingId2buildingInfo) do
    --                 self:DrawSelectColor(buildingId, clubId)
        
    --             end
                
    --         end
    --     end
        
    -- end
    
      for clubId, buildingId2buildingInfo in pairs(clubId2Building) do
        if clubId > 0 then
            for buildingId, info in pairs(buildingId2buildingInfo) do
                self:DrawSelectColor(buildingId, clubId)
    
            end
        end
        
    end
end

function ClubGVGTileSelectControl:DrawSelectColor(buildingId, clubId)
    clubId     = checkNumber(clubId)
    buildingId = checkNumber(buildingId)
    local isOwnClubId = clubId > 0
    local color = ClubGVGUtils.GetClubColor(clubId)
    local mgr = self._mgr
    local buildingId2TileData = mgr:GetBuildId2TileData()
    local buildingId2BuildingInfo = mgr:GetBuildId2BuildInfo()
    local tileData = buildingId2TileData[buildingId]
    local neighborIds = tileData.buildingNeighborIds.container

    local selectTileBase = isOwnClubId and self._selectTileBase or nil

    local buildingTileMap = self._buildingTileMap
    ClubGVGUtils.ClearTable(RecordNeighborId)
    ClubGVGUtils.ClearTable(RecordActivePos)
    for neighborIdIndex, neighborId in pairs(neighborIds) do
        if RecordNeighborId[neighborId] == nil then
            RecordNeighborId[neighborId] = true
            -- print("neighborId", neighborId)
            local info = buildingId2BuildingInfo[neighborId]
            local buildingNeighbors = tileData.buildingNeighbors
            local path = buildingNeighbors[neighborIdIndex]
    
            local container = path.container
            ---绘制非建筑节点
            for i = 2, #container - 1, 1 do
                local cellPos = container[i]
                local x, y = checkNumber(cellPos.x), checkNumber(cellPos.y)
                Vector3IntIns:Set(x, y)
                
                local worldPos = buildingTileMap:CellToWorld(Vector3IntIns)
                local cell = mgr:GetSelectTileMapCellByWorldPos(worldPos, self._selectTileMap)
                if checkNumber(info.clubId) == clubId then
                    RecordActivePos[x]    = RecordActivePos[x] or {}
                    RecordActivePos[x][y] = true
                    ClubGVGUtils.SetTileColor(self._selectTileMap, cell, color, selectTileBase, isOwnClubId)        
                elseif RecordActivePos[x] == nil or RecordActivePos[x][y] == nil then
                    ClubGVGUtils.SetTileColor(self._selectTileMap, cell, nil, nil, false)        
                end
            end
        end
        
    end

    ---绘制建筑物节点
    local worldPos = mgr:GetBuildingWorldPos(buildingId, self._buildingTileMap)
    local cell = mgr:GetSelectTileMapCellByWorldPos(worldPos, self._selectTileMap)
    ClubGVGUtils.SetTileColor(self._selectTileMap, cell, color, selectTileBase, isOwnClubId)        
    
end

return ClubGVGTileSelectControl
