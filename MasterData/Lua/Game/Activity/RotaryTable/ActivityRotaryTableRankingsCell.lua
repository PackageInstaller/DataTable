-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 排行榜列表项
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-23 22:54:26
-------------------------------------------------------------------------------

---@type PlayerComponent
local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)

--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRankingsDialog.prefab
---@class ActivityRotaryTableRankingsCell
---@field Env                           	ActivityRotaryTableRankingsCell      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextLevel                     	UnityEngine.RectTransform               
---@field TextRanking                   	UnityEngine.RectTransform               
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               
---@field TextScore                     	UnityEngine.RectTransform               
---@field TextName                      	UnityEngine.RectTransform               
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               
---@field TextRanking2                  	UnityEngine.RectTransform               
---@field NotEnterNode                  	UnityEngine.RectTransform               
---@field TxtNo                         	UnityEngine.RectTransform               
---@field ImgRank                       	UnityEngine.RectTransform               
---@field Imgbg                         	UnityEngine.RectTransform               
local ActivityRotaryTableRankingsCell = Class('ActivityRotaryTableRankingsCell')


function ActivityRotaryTableRankingsCell:__init()
    ---@type CommonPlayerHeadNode
    self.headNodeEnv_    = nil
    self.myselfPlayerId_ = 0
end


function ActivityRotaryTableRankingsCell:__delete()
    self.headNodeEnv_    = nil
    self.myselfPlayerId_ = nil
end


function ActivityRotaryTableRankingsCell:Awake()
    self.myselfPlayerId_ = checkInt(playerComponent:GetPlayerDojo().playerId)
    self.headNodeEnv_    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, 'Game.Behaviours.CommonPlayerHeadNode')
end


function ActivityRotaryTableRankingsCell:Start()
end


function ActivityRotaryTableRankingsCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

-------------------------------------------------
-- get / set

function ActivityRotaryTableRankingsCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
function ActivityRotaryTableRankingsCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ActivityRotaryTablePlayerDojo
function ActivityRotaryTableRankingsCell:GetCellData()
    return checkTable(self.cellData_)
end
function ActivityRotaryTableRankingsCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


function ActivityRotaryTableRankingsCell:IsMyRank()
    return self.isMyRank_ == true
end
function ActivityRotaryTableRankingsCell:SetMyRank(isMyRank)
    self.isMyRank_ = isMyRank == true
end


-------------------------------------------------
-- private

function ActivityRotaryTableRankingsCell:RefreshData_()
    ---@type ActivityRotaryTablePlayerDojo
    local cellData = self:GetCellData()

    -- update name / level / score / ranking
    CfUtils.FillText(self.TextName, cellData.name)
    CfUtils.FillText(self.TextLevel, string.format('Lv.%s', tostring(cellData.level)))
    CfUtils.FillText(self.TextScore, checkInt(cellData.score))
    CfUtils.FillText(self.TextRanking, checkInt(cellData.rank))

    local rankNum  = checkInt(cellData.rank)
    local rankCode = math.min(rankNum, 4)
    CfUtils.SetUISwitchImage(self.ImgRank, rankCode)
    CfUtils.SetUISwitchImage(self.ImgRank2, rankCode)
    CfUtils.SetUISwitchText(self.TextRanking, rankCode)
    CfUtils.SetActive(self.ImgRank2, true)

    -- update myRank
    if self:IsMyRank() then
        local hasRank = rankNum > 0
        CfUtils.SetActive(self.TxtNo, not hasRank)
        CfUtils.SetActive(self.ImgRank, hasRank)
        CfUtils.SetActive(self.TextRanking, hasRank)
    else
        local isTipsMe = checkInt(cellData.playerId) == self.myselfPlayerId_
        CfUtils.SetActive(self.ImgMyself, isTipsMe)
    end

    -- update headNode
    self.headNodeEnv_:FreshAvatarFrame(cellData.avatar, cellData.avatarFrame)

    -- update icon
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(cellData.goodsId)
    CfUtils.FillImage(self.ImgGoodsIcon, goodsVo.photoPath)
end


return ActivityRotaryTableRankingsCell
