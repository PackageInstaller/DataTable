-------------------------------------------------------------------------------
-- 夜寻迷宫 - 卡牌回血弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-16 11:20:24
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local MemberNodePath = 'Game.UI.FightTeam.UITeamMembersNode.UITeamMemberNode'
local HpAnimTweenId  = 'PatrolMazeCardsRecoveryPopup_HpAnimTweenId'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolRecoveryPopup130201.prefab > name: PatrolRecoveryPopup130201
---@class PatrolMazeCardsRecoveryPopup
---@field Env                           	PatrolMazeCardsRecoveryPopup            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field MemberCellNode                	UnityEngine.RectTransform               @ 头像节点
---@field MemberGroupNode               	UnityEngine.RectTransform               @ 头像根节点
---@field DescrTxt                      	UnityEngine.RectTransform               @ 描述文本
---@field AnimNode                      	UnityEngine.RectTransform               @ 动画节点
---@field RootNode                      	UnityEngine.RectTransform               @ 根节点
local PatrolMazeCardsRecoveryPopup = Class('PatrolMazeCardsRecoveryPopup')


function PatrolMazeCardsRecoveryPopup:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type table[] @ 卡牌的回血数据
    self.cureDatas_ = {}

    ---@type table[]
    self.memberNodeList_ = {}
end


function PatrolMazeCardsRecoveryPopup:__delete()
    self.mapAreaDojo_    = nil
    self.cureDatas_      = nil
    self.memberNodeList_ = nil
end


function PatrolMazeCardsRecoveryPopup:Awake()
end


function PatrolMazeCardsRecoveryPopup:Start()
end


function PatrolMazeCardsRecoveryPopup:OnDestroy()
    CS.DG.Tweening.DOTween.Kill(HpAnimTweenId)
    self.controller = nil --删除lua层引⽤用到的c#对象
    self:Delete()
end


-------------------------------------------------
-- public

---@param initParams table
function PatrolMazeCardsRecoveryPopup:RefreshUI(initParams)
    local mapAreaId   = checkInt(initParams.mapAreaId)
    self.mapAreaDojo_ = patrolMazeComp:GetHomeDojo():GetAreaDojo(mapAreaId)
    self.cureDatas_   = checkTable(initParams.cureDatas)
    
    self:UpdateRecoverDescr_()
    self:UpdateCardHeadList_()
end


function PatrolMazeCardsRecoveryPopup:CheckAnimatorPlayComplete()
    -- 等待入场动画
    ---@type UnityEngine.Animation
    local animation = self.AnimNode:GetComponent(typeof(CS.UnityEngine.Animation))
    while animation.isPlaying do
        CoYield()
    end

    -- 打开头像的加血特效
    for _, memberNodeData in ipairs(self.memberNodeList_) do
        CfUtils.SetActive(memberNodeData.childNode:Find('UIFX_Props/UIFX_UIFX_BloodReturn'), true)
        CfUtils.SetActive(memberNodeData.childNode:Find('UIFX_Props/UIFX_UIFX_BloodReturn/UIFX_Upgrade/Glow'), false)
        CfUtils.SetActive(memberNodeData.childNode:Find('UIFX_Props/UIFX_UIFX_BloodReturn/UIFX_Upgrade/Glow2'), false)
    end

    -- 更新头像血量
    local hpAnimTime  = 0.5
    local hpAnimTween = CfUtils.DoTween(hpAnimTime, function(value)
        for cardIndex, _ in ipairs(self.memberNodeList_) do
            self:UpdateCardHpEnergy_(cardIndex, value)
        end
    end)
    hpAnimTween.stringId = HpAnimTweenId
    CoYield(hpAnimTime)
end


-------------------------------------------------
-- private

function PatrolMazeCardsRecoveryPopup:UpdateRecoverDescr_()
    CfUtils.FillText(self.DescrTxt, PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.HP_RECOVER_DESCR))
end


function PatrolMazeCardsRecoveryPopup:UpdateCardHeadList_()
    self.memberNodeList_ = {}

    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.MemberGroupNode, self.MemberCellNode, #self.cureDatas_, function(luaIndex, childNode)
        childNode.name = 'Cell' .. luaIndex

        local cardCureData = checkTable(self.cureDatas_[luaIndex])
        local mazeCardDojo = self.mapAreaDojo_:GetMazeCard(cardCureData.mazeCardId)

        ---@type UITeamMemberNode
        local teamMemberNode = CfUtils.GetLuaScr(childNode:Find('UITeamMemberNode'), MemberNodePath)
        teamMemberNode:FillCardBase(mazeCardDojo.cardDojo, nil, nil, {showStar = true})
        self.memberNodeList_[luaIndex] = {
            childNode  = childNode,
            memberNode = teamMemberNode,
        }
        
        self:UpdateCardHpEnergy_(luaIndex, 0)
    end)
end


---@param cardIndex integer
---@param updateProgress number
function PatrolMazeCardsRecoveryPopup:UpdateCardHpEnergy_(cardIndex, updateProgress)
    ---@type UITeamMemberNode
    local teamMemberNode = self.memberNodeList_[cardIndex].memberNode
    local cardCureData   = checkTable(self.cureDatas_[cardIndex])
    local oldHpPercent   = checkNumber(cardCureData.oldHpPercent)
    local newHpPercent   = checkNumber(cardCureData.newHpPercent)
    local hpOffsetNum    = newHpPercent - oldHpPercent
    local hpProgressNum  = hpOffsetNum * updateProgress

    teamMemberNode:FillHpEnergy({
        hpPercent    = oldHpPercent + hpProgressNum,
        hpPercentAdd = hpOffsetNum - hpProgressNum,
    })
end


return PatrolMazeCardsRecoveryPopup
