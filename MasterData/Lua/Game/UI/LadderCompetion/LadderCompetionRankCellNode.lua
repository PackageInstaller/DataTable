-------------------------------------------------------------------------------
-- 天梯竞技 - 排行榜界面 - 列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-12 11:09:50
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/LadderCompetion/LadderCompetionRankDialog.prefab > name: Cell
---@class LadderCompetionRankCellNode
---@field Env                           	LadderCompetionRankCellNode             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field animRoot                      	UnityEngine.RectTransform               
---@field ImgMyself                     	UnityEngine.RectTransform               
---@field BtnDetails                    	UnityEngine.RectTransform               
---@field ImgSegment                    	UnityEngine.RectTransform               
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               
---@field TextScore                     	UnityEngine.RectTransform               
---@field TextLevel                     	UnityEngine.RectTransform
---@field TextRanking2                     	UnityEngine.RectTransform
---@field TextName                      	UnityEngine.RectTransform               
---@field ImgRank2                      	UnityEngine.RectTransform               
---@field ImgRank                       	UnityEngine.RectTransform               
---@field TextRanking                   	UnityEngine.RectTransform               
---@field StarGroup                     	UnityEngine.RectTransform               
---@field Imgbg                         	UnityEngine.RectTransform               
local LadderCompetionRankCellNode = Class('LadderCompetionRankCellNode')


function LadderCompetionRankCellNode:__init()
    ---@type CommonPlayerHeadNode
    self.commonPlayerHeadNodeLua_ = nil
    self.myselfPlayerId_          = 0
end


function LadderCompetionRankCellNode:__delete()
    self.commonPlayerHeadNodeLua_ = nil
    self.myselfPlayerId_          = nil
end


function LadderCompetionRankCellNode:Awake()
    self.myselfPlayerId_          = checkInt(GameUtils.GetPlayerId())
    self.commonPlayerHeadNodeLua_ = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, 'Game.Behaviours.CommonPlayerHeadNode')
    SetButtonAction(self.BtnDetails, Bind(self, self.OnClickDetailsButtonHandler_))
    self:PlayAnimByHide()
end


function LadderCompetionRankCellNode:Start()
end


function LadderCompetionRankCellNode:OnDestroy()
    self.controller = nil  -- luabehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function LadderCompetionRankCellNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
function LadderCompetionRankCellNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


function LadderCompetionRankCellNode:GetCellData()
    return checkTable(self.cellData_)
end
function LadderCompetionRankCellNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


function LadderCompetionRankCellNode:IsMyRank()
    return self.isMyRank_ == true
end
function LadderCompetionRankCellNode:SetMyRank(isMyRank)
    self.isMyRank_ = isMyRank == true
end


-------------------------------------------------
-- public

function LadderCompetionRankCellNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Hide')
end


function LadderCompetionRankCellNode:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Idle')
end


function LadderCompetionRankCellNode:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, 'UI_Common_List_Cell_Show')
end


-------------------------------------------------
-- private

function LadderCompetionRankCellNode:RefreshData_()
    ---@type LadderRankPlayerDojo
    local cellData = self:GetCellData()

    -- update name / level / score / ranking
    CfUtils.FillText(self.TextName, cellData.name)
    CfUtils.FillText(self.TextLevel, string.format('Lv.%s', tostring(cellData.level)))
    CfUtils.FillText(self.TextScore, cellData.score)
    CfUtils.FillText(self.TextRanking, cellData.ranking)

    local rankNum  = checkInt(cellData.ranking)
    local rankCode = math.min(rankNum, 4)
    CfUtils.SetUISwitchText(self.Txtranking, rankCode)
    CfUtils.SetUISwitchImage(self.ImgRank, rankCode)
    CfUtils.SetUISwitchImage(self.ImgRank2, rankCode)
    CfUtils.SetActive(self.ImgRank2, true)

    -- update myRank
    if self:IsMyRank() then
        local rankPercentage = checkInt(cellData.rankPercentage)
        CfUtils.SetActive(self.TextRanking2, rankPercentage > 0)
        if rankPercentage > 0 then
            CfUtils.FillText(self.TextRanking2, localize('未进入_num_%', {_num_ = rankPercentage}))
        else
            local hasRank = rankNum > 0
            CfUtils.SetActive(self.TxtNo, not hasRank)
            CfUtils.SetActive(self.ImgRank, hasRank)
            CfUtils.SetActive(self.TextRanking, hasRank)
        end
    else
        local isTipsMe = checkInt(cellData.playerId) == self.myselfPlayerId_
        CfUtils.SetActive(self.ImgMyself, isTipsMe)
    end

    -- update headNode
    self.commonPlayerHeadNodeLua_:FreshAvatarFrame(cellData.avatar, cellData.avatarFrame)
    self.commonPlayerHeadNodeLua_:SetCallBack(function()
        if self:IsMyRank() then
            -- UIModule.OpenDialog({ id = Constants.UITypeIds.PlayerNewMainDialog, parameters = { openType = 1 } },
            --  { { id = Constants.UITypeIds.LadderStruggleMainDialog } })
        else
            if checkInt(cellData.playerId) > 0 then  -- 机器人不能点
                -- GameUtils.ShowPlayerInfo(self.data.playerId, {{ id = Constants.UITypeIds.UITrailStageHome}})

                -- 直接进入 他人的 个人信息界面2D版 
                GameUtils.ShowPlayerInfo( cellData.playerId, 
                    {  
                        { id = Constants.UITypeIds.LadderCompetionMainDialog},
                        { id = Constants.UITypeIds.LadderCompetionRankDialog},
                    } 
                )
                -- 下方为旧方案, 暂被替代:
                -- GameUtils.ShowCommonPlayerHeadOption(self.CommonPlayerHeadNode.gameObject, Constants.PlayerHeadOptionType.Common,{
                --     playerId    = cellData.playerId,
                --     name        = cellData.name,
                --     level       = cellData.level,
                --     avatar      = cellData.avatar,
                --     avatarFrame = cellData.avatarFrame,
                --     exclude = {
                --         { id = Constants.UITypeIds.LadderCompetionMainDialog},
                --         { id = Constants.UITypeIds.LadderCompetionRankDialog},
                --     }
                -- })
            end
        end
    end)

    -- update icon
    local ladderCompetionUtils = import("Game.UI.LadderCompetion.LadderCompetionUtils")
    local gradeVo = ladderCompetionUtils.GetGradeVo(cellData.segment, cellData.subSegment)
    CfUtils.FillImage(self.ImgSegment, gradeVo.icon)
    
    local starCount = checkNumber(cellData.subSegment)
    for i = 1, 5 do
        local child = self.StarGroup.transform:GetChild(i - 1)
        if i <= starCount then
            CfUtils.SetActive(child, true)
        else
            CfUtils.SetActive(child, false)
        end
    end
end


-------------------------------------------------
-- handler

function LadderCompetionRankCellNode:OnClickDetailsButtonHandler_()
    ---@type LadderRankPlayerDojo
    local cellData = self:GetCellData()
    GameUtils.ShowCommonTeamsTipsBoard(self.BtnDetails, {
        {
            cardInfo    = cellData.lastCards, 
            combatValue = cellData.combatValue,
            teamTitle   = localize('模拟作战'),
        }
    }, nil, Constants.SpecialQuestId.LadderId, cellData.name)
end


return LadderCompetionRankCellNode
