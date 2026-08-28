-------------------------------------------------------------------------------
-- 和风战牌 - 入口界面 - 关卡列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-22 10:34:44
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerEntryNode.prefab > name: ActivityJapanesePokerEntryNode
---@class BattleCardGameEntryQuestCell
---@field Env                           	BattleCardGameEntryQuestCell            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimNode                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field RoleHeadImage                 	UnityEngine.RectTransform               	@ 2    角色头像节点
---@field RoleNameBtn                   	UnityEngine.RectTransform               	@ 3    角色名字按钮
---@field RoleNameTxt                   	UnityEngine.RectTransform               	@ 4    角色名字文本
---@field LockMaskNode                  	UnityEngine.RectTransform               	@ 5    锁定遮罩节点
---@field LockDescrTxt                  	UnityEngine.RectTransform               	@ 6    锁定描述文本
---@field RewardCradsRoot               	UnityEngine.RectTransform               	@ 7    奖励卡片父节点
---@field RewardCardCell                	UnityEngine.RectTransform               	@ 8    奖励卡片子节点
---@field EnterQuestBtn                 	UnityEngine.RectTransform               	@ 9    进入关卡按钮
local BattleCardGameEntryQuestCell = Class('BattleCardGameEntryQuestCell')


function BattleCardGameEntryQuestCell:__init()
end


function BattleCardGameEntryQuestCell:__delete()
end


function BattleCardGameEntryQuestCell:Awake()
    SetButtonAction(self.RoleNameBtn, Bind(self, self.OnClickRoleNameButtonHandler_))
    SetButtonAction(self.EnterQuestBtn, Bind(self, self.OnClickEnterQuestButtonHandler_))
    self:PlayAnimByHide()
end


function BattleCardGameEntryQuestCell:Start()
end


function BattleCardGameEntryQuestCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameEntryQuestCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function BattleCardGameEntryQuestCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return BattleCardGameEntryDialog.QuestCellData
function BattleCardGameEntryQuestCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData BattleCardGameEntryDialog.QuestCellData
function BattleCardGameEntryQuestCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function BattleCardGameEntryQuestCell:GetClickRoleDetailCB()
    return self.clickRoleDetailCallback_
end
---@param callback fun(luaIndex:integer):void
function BattleCardGameEntryQuestCell:SetClickRoleDetailCB(callback)
    self.clickRoleDetailCallback_ = callback
end


---@return fun(luaIndex:integer):void
function BattleCardGameEntryQuestCell:GetClickEnterQuestCB()
    return self.clickEnterQuestCallback_
end
---@param callback fun(luaIndex:integer):void
function BattleCardGameEntryQuestCell:SetClickEnterQuestCB(callback)
    self.clickEnterQuestCallback_ = callback
end


-------------------------------------------------
-- public

function BattleCardGameEntryQuestCell:PlayAnimByHide()
    CfUtils.PlayAnimation(self.AnimRoot, 'UI_Common_List_Cell_Hide')
end


function BattleCardGameEntryQuestCell:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.AnimRoot, 'UI_Common_List_Cell_Idle')
end


function BattleCardGameEntryQuestCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.AnimRoot, delayIndex)
end


-------------------------------------------------
-- private

function BattleCardGameEntryQuestCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type BattleCardGameNpcQuestVo
    local questVo   = checkTable(cellData.questVo)
    local npcCardId = checkInt(questVo.npcDrawId)
    local iconPath  = parse_pathNameByData(string.fmt('18:card_icon_%1_1', npcCardId))
    CfUtils.FillText(self.RoleNameTxt, string.fmt('%1 %2', questVo.npcTitle, questVo.npcName))
    CfUtils.SetActive(self.RoleHeadImage, npcCardId > 0)
    if npcCardId > 0 then
        CfUtils.FillImage(self.RoleHeadImage, iconPath)
    end

    -- update status
    local isUnlock = checkBool(cellData.isUnlock)
    CfUtils.SetActive(self.RoleNameBtn, isUnlock)
    CfUtils.SetActive(self.LockMaskNode, not isUnlock)
    CfUtils.FillText(self.LockDescrTxt, localize('收集_num_张卡片解锁', {_num_ = checkInt(questVo.unlockCount)}))
    
    local isClean   = checkBool(cellData.isClean)
    local showCards = checkTable(questVo.showCards)
    -- update all cardNode
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.RewardCradsRoot, self.RewardCardCell, #showCards, function(luaIndex, childNode)
        childNode.name = 'Cell' .. luaIndex
        local battleCardId  = checkInt(showCards[luaIndex])
        local hasBattleCard = battleCardGameComp:GetHomeDojo():HasCardId(battleCardId)
        BattleCardGameUtils.UpcateBattleCardNode(childNode:Find('PokerCardNode'), battleCardId)
        SetButtonAction(childNode:Find('PokerCardNode'), Bind(self, self.OnClicRewardBattleCardHandler_, luaIndex))
        CfUtils.SetActive(childNode:Find('ImgGet'), hasBattleCard)
    end)
end


-------------------------------------------------
-- handler

function BattleCardGameEntryQuestCell:OnClickRoleNameButtonHandler_()
    if self:GetClickRoleDetailCB() then
        self:GetClickRoleDetailCB()(self:GetLuaIndex())
    end
end


function BattleCardGameEntryQuestCell:OnClickEnterQuestButtonHandler_()
    if self:GetClickEnterQuestCB() then
        self:GetClickEnterQuestCB()(self:GetLuaIndex())
    end
end


function BattleCardGameEntryQuestCell:OnClicRewardBattleCardHandler_(rewardIndex)
    if self:GetClickEnterQuestCB() then
        self:GetClickEnterQuestCB()(self:GetLuaIndex())
    end
end


return BattleCardGameEntryQuestCell
