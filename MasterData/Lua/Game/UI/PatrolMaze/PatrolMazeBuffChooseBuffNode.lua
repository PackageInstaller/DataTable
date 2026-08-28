-------------------------------------------------------------------------------
-- 夜寻迷宫 - 选择圣物弹窗 - 效果节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-03 17:24:40
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local BuffNodeState = {
    RewardShow = 'Enter',
    SelectShow = 'Select',
    CancelShow = 'Cancel',
    SelectExit = 'Select_Exit',
    CancelExit = 'Cancel_Exit',
}

local BuffNodeAnim = {
    SelectShow = 'BuffChooseDialog_Select',
    CancelShow = 'BuffChooseDialog_Cancel',
    SelectExit = 'BuffChooseDialog_Exit1',
    CancelExit = 'BuffChooseDialog_Exit2',
    RewardShow = 'BuffChooseDialog_Enter',
}

local DisplayMemberMax = 4


--- from: Assets/BundleResources/Prefabs/Patrol/BuffChooseNode130201.prefab > name: BuffChooseNode130201
---@class PatrolMazeBuffChooseBuffNode
---@field Env                           	PatrolMazeBuffChooseBuffNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 1    动画根节点
---@field SelectBtn                     	UnityEngine.RectTransform               	@ 2    选择按钮
---@field TitleTxt                      	UnityEngine.RectTransform               	@ 3    标题文本
---@field SubTitleTxt                   	UnityEngine.RectTransform               	@ 4    子标题文本
---@field DescrTxt                      	UnityEngine.RectTransform               	@ 5    描述文本
---@field IconImg                       	UnityEngine.RectTransform               	@ 6    图标图片
---@field FrameImg                      	UnityEngine.RectTransform               	@ 7    底框图片
---@field BgImg                         	UnityEngine.RectTransform               	@ 8    背景图片
---@field QualityUIFX                   	UnityEngine.RectTransform               	@ 9    品质特效
---@field UnknownUIFX                   	UnityEngine.RectTransform               	@ 10   (不用控制)
---@field RecommendNode                 	UnityEngine.RectTransform               	@ 11   推荐选择节点
---@field MemberDisplayNode             	UnityEngine.RectTransform               	@ 12   适用卡牌 根节点
---@field MemberDisplayEmptyNode        	UnityEngine.RectTransform               	@ 13   适用卡牌 空节点
---@field MemberDisplayListNode         	UnityEngine.RectTransform               	@ 14   适用卡牌 列表节点
---@field MemberDisplayMembersNode      	UnityEngine.RectTransform               	@ 15   适用卡牌 成员节点
local PatrolMazeBuffChooseBuffNode = Class('PatrolMazeBuffChooseBuffNode')


function PatrolMazeBuffChooseBuffNode:__init()
    ---@type UITeamMembersNode @ 适用阵容节点
    self.displayMembersNode_ = nil
end


function PatrolMazeBuffChooseBuffNode:__delete()
    self.displayMembersNode_ = nil
end


function PatrolMazeBuffChooseBuffNode:Awake()
    self.displayMembersNode_  = CfUtils.GetLuaScr(self.MemberDisplayMembersNode, Constants.UILuaTablePath.TeamMembersNode)
    SetButtonAction(self.controller, Bind(self, self.OnClickBuffNodeHandler_))
    SetButtonAction(self.SelectBtn, Bind(self, self.OnClickBuffSelectButtonHandler_))
end


function PatrolMazeBuffChooseBuffNode:Start()
end


function PatrolMazeBuffChooseBuffNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeBuffChooseBuffNode:GetBuffIndex()
    return checkInt(self.buffIndex_)
end
function PatrolMazeBuffChooseBuffNode:SetBuffIndex(buffIndex)
    self.buffIndex_ = checkInt(buffIndex)
end


---@return boolean
function PatrolMazeBuffChooseBuffNode:IsRelicBuff()
    return checkBool(self.isRelicBuff_)
end
function PatrolMazeBuffChooseBuffNode:SetRelicBuff(isRelicBuff)
    self.isRelicBuff_ = checkBool(isRelicBuff)
end


---@return PatrolMazeAreaDojo
function PatrolMazeBuffChooseBuffNode:GetMapAreaDojo()
    return self.mapAreaDojo_
end
function PatrolMazeBuffChooseBuffNode:SetMapAreaDojo(mapAreaDojo)
    self.mapAreaDojo_ = mapAreaDojo
end


---@return boolean
function PatrolMazeBuffChooseBuffNode:GetShowBuffId()
    return checkInt(self.showBuffId_)
end
function PatrolMazeBuffChooseBuffNode:SetShowBuffId(showBuffId)
    self.showBuffId_ = checkInt(showBuffId)
    self:UpdateShowBuffInfo_()
end


---@return fun(buffIndex:integer):void
function PatrolMazeBuffChooseBuffNode:GetClickNodeCb()
    return self.clickNodeCb_
end
function PatrolMazeBuffChooseBuffNode:SetClickNodeCb(callback)
    self.clickNodeCb_ = callback
end


---@return fun(buffIndex:integer):void
function PatrolMazeBuffChooseBuffNode:GetSelectNodeCb()
    return self.selectNodeCb_
end
function PatrolMazeBuffChooseBuffNode:SetSelectNodeCb(callback)
    self.selectNodeCb_ = callback
end


-------------------------------------------------
-- public

--- 播放 奖励展示动画
---@return boolean
function PatrolMazeBuffChooseBuffNode:PlayRewardShowAnim()
    local animState = BuffNodeState.RewardShow
    local animName  = BuffNodeAnim.RewardShow
    local animTime  = CfUtils.GetAnimatorTime(self.AnimRoot, animName)
    CfUtils.PlayAnimator(self.AnimRoot, animState)
    return animTime
end


--- 播放 选择退出动画
---@param isSelect boolean
---@return integer
function PatrolMazeBuffChooseBuffNode:PlaySelectExitAnim(isSelect)
    local animState = isSelect and BuffNodeState.SelectExit or BuffNodeState.CancelExit
    local animName  = isSelect and BuffNodeAnim.SelectExit or BuffNodeAnim.CancelExit
    local animTime  = CfUtils.GetAnimatorTime(self.AnimRoot, animName)
    CfUtils.PlayAnimator(self.AnimRoot, animState)
    CfUtils.SetActive(self.SelectBtn, false)
    return animTime
end


---@param isSelect boolean
function PatrolMazeBuffChooseBuffNode:UpdateSelectState(isSelect)
    local isSelect  = checkBool(isSelect)
    local animState = isSelect and BuffNodeState.SelectShow or BuffNodeState.CancelShow
    CfUtils.SetActive(self.SelectBtn, isSelect)
    CfUtils.SetActive(self.UnknownUIFX, false)
    CfUtils.PlayAnimator(self.AnimRoot, animState)
end    


-------------------------------------------------
-- private

function PatrolMazeBuffChooseBuffNode:UpdateShowBuffInfo_()
    ---@type PatrolMazeRelicVo | PatrolMazeCurseVo
    local showBuffVo = {}
    if self:IsRelicBuff() then
        showBuffVo = PatrolMazeUtils.GetMazeRelicVo(self:GetShowBuffId())
    else
        showBuffVo = PatrolMazeUtils.GetMazeCurseVo(self:GetShowBuffId())
    end

    local buffName = tostring(showBuffVo.name)
    CfUtils.FillText(self.TitleTxt, buffName)

    local buffTagId = checkInt(showBuffVo.lableId)
    if buffTagId > 0 then
        local buffTagVo = PatrolMazeUtils.GetMazeRelicTagVo(buffTagId)
        CfUtils.FillText(self.SubTitleTxt, tostring(buffTagVo.tagTxt))
        CfUtils.SetActive(self.SubTitleTxt, true)
    else
        CfUtils.SetActive(self.SubTitleTxt, false)
    end

    local buffDescr = tostring(showBuffVo.descr)
    CfUtils.FillText(self.DescrTxt, buffDescr)

    local buffIconPath = checkString(showBuffVo.iconPath)
    CfUtils.FillImage(self.IconImg, buffIconPath)

    local buffQuality = checkInt(showBuffVo.quality)
    CfUtils.SetUISwitchImage(self.BgImg, buffQuality)
    CfUtils.SetUISwitchText(self.TitleTxt, buffQuality)
    CfUtils.SetUISwitchText(self.SubTitleTxt, buffQuality)
    CfUtils.SetUISwitchImage(self.FrameImg, buffQuality)
    CfUtils.SetActive(self.QualityUIFX, buffQuality >= Constants.RareType.SSR)

    local isRecommand = false
    if self:GetMapAreaDojo() then
        isRecommand = self:GetMapAreaDojo().recommandRelicMap[self:GetShowBuffId()]
    end
    CfUtils.SetActive(self.RecommendNode, isRecommand)

    -- 适用卡牌信息
    local cardIdMap = checkTable(showBuffVo.cardIdMap)
    if next(cardIdMap) ~= nil and self:GetMapAreaDojo() then
        CfUtils.SetActive(self.MemberDisplayNode, true)

        local memberDataList = {}
        for _, mazeCardDojo in ipairs(self:GetMapAreaDojo().mazeCardDojoList) do
            if cardIdMap[mazeCardDojo.cardId] and #memberDataList < DisplayMemberMax then
                local memberData = {
                    cardId  = mazeCardDojo.cardId,
                    clickCb = function()
                    end
                }
                table.insert(memberDataList, memberData)
            end
        end

        if #memberDataList > 0 then
            CfUtils.SetActive(self.MemberDisplayListNode, true)
            CfUtils.SetActive(self.MemberDisplayEmptyNode, false)
            self.displayMembersNode_:ResetCells()
            self.displayMembersNode_:RefreshCardBase(memberDataList, 0.3)
        else
            CfUtils.SetActive(self.MemberDisplayListNode, false)
            CfUtils.SetActive(self.MemberDisplayEmptyNode, true)
        end
    else
        CfUtils.SetActive(self.MemberDisplayNode, false)
    end

    -- update state
    self:UpdateSelectState(false)
end


-------------------------------------------------
-- handler

function PatrolMazeBuffChooseBuffNode:OnClickBuffNodeHandler_()
    if self:GetClickNodeCb() then
        self:GetClickNodeCb()(self:GetBuffIndex())
    end
end


function PatrolMazeBuffChooseBuffNode:OnClickBuffSelectButtonHandler_()
    if self:GetSelectNodeCb() then
        self:GetSelectNodeCb()(self:GetBuffIndex())
    end
end


return PatrolMazeBuffChooseBuffNode
