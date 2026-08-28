-------------------------------------------------------------------------------
-- 社团 - 更换形象界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-21 19:36:54
-------------------------------------------------------------------------------

local EasyTouch   = CS.HedgehogTeam.EasyTouch.EasyTouch
local cardConfMgr = CardConfMgr:GetInstance()
---@type CardComponent
local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

local CardGridCellPath = 'Game.Main.UISwitchCellNode'
local CardGridCellName = 'Cell'

--- from: Assets/BundleResources/Prefabs/Cultivate/UIHomeRoleChangeDialog.prefab > name: OverseaClubHallChangeCatDialog
---@class UIOverseaClubHallChangeCatDialog
---@field Env                           	UIOverseaClubHallChangeCatDialog        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field GiftBtn                       	UnityEngine.RectTransform               	@ 1    送礼按钮
---@field GiftBg                        	UnityEngine.RectTransform               	@ 2    送礼背景
---@field TransBtn                      	UnityEngine.RectTransform               	@ 3    切换按钮
---@field favFrameImg                   	UnityEngine.RectTransform               	@ 4    好感度 底框图片
---@field favNumberTxt                  	UnityEngine.RectTransform               	@ 5    好感度 等级文本
---@field favNameTxt                    	UnityEngine.RectTransform               	@ 6    好感度 名字文本
---@field favLevelAnimUIFX              	UnityEngine.RectTransform               	@ 7    好感度 升级特效
---@field CancelBtn                     	UnityEngine.RectTransform               	@ 8    取消按钮
---@field ConfirmBtn                    	UnityEngine.RectTransform               	@ 9    确认按钮
---@field CardGridView                  	SuperScrollView.LoopGridView            	@ 10   卡牌网格视图
---@field ComFilterNode                 	UnityEngine.RectTransform               	@ 11   筛选过滤节点
local UIOverseaClubHallChangeCatDialog = Class('UIOverseaClubHallChangeCatDialog')


function UIOverseaClubHallChangeCatDialog:__init()
    ---@type UICommonFilterMB @ 筛选过滤器
    self.cardFilterEnv_ = nil

    ---@type CardDojo[] @ 全部的卡片数据
    self.allCardDojoList_ = {}

    ---@type integer @ 之前的 看板形象id
    self.oldSignboardId_ = 0

    ---@type integer @ 最新的 看板形象id
    self.newSignboardId_ = 0

    ---@type fun(signboardId:integer):void
    self.setCatCallback_ = nil

    ---@type fun():void
    self.closeCallback_ = nil
end


function UIOverseaClubHallChangeCatDialog:__delete()
    self.cardFilterEnv_   = nil
    self.allCardDojoList_ = nil
    self.oldSignboardId_  = nil
    self.newSignboardId_  = nil
    self.setCatCallback_  = nil
    self.closeCallback_   = nil
end


function UIOverseaClubHallChangeCatDialog:Awake()
    self.cardFilterEnv_ = CfUtils.GetLuaScr(self.ComFilterNode, Constants.UILuaTablePath.ComFilterMB)
    SetButtonAction(self.CancelBtn, Bind(self, self.OnClickCancelButtonHandler_))
    SetButtonAction(self.ConfirmBtn, Bind(self, self.OnClickConfirmButtonHandler_))
    SetGridViewAction(self.CardGridView, Bind(self, self.OnUpdateCardGridCellHandler_))
end


function UIOverseaClubHallChangeCatDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams     = self.controller.Argument.parameters or {}
        self.closeCallback_  = initParams.closeCb
        self.setCatCallback_ = initParams.setCatCb
        
        -- init signboardId
        local myselfDojo     = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
        self.oldSignboardId_ = myselfDojo.clubSignboarId
        self.newSignboardId_ = self.oldSignboardId_
        
        -- load all cardDojo
        self.allCardDojoList_ = {}
        for _, cardDojo in pairs(cardComp:GetAllCardTable()) do
            local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(cardDojo.cardSkin)
            if cardSkinVo then
                local cardRoleVo = cardConfMgr:GetCardByRefId(cardSkinVo.roleId)
                if cardRoleVo and cardRoleVo.signboard == 1 then
                    table.insert(self.allCardDojoList_, cardDojo)
                end
            end
        end
        
        -- init cardFilterEnv
        self.cardFilterEnv_:SetCallback(self.allCardDojoList_, function(data)
            if data then
                self:SetCardDojoList(data)
            end
        end)
        self.cardFilterEnv_:RestoreState(Constants.UICacheDataKeys.UICultivateEntryFilterState, function(data)
            if isNull(data) then
                self:SetCardDojoList(CardUtils.SortCardBySortType(self.allCardDojoList_, Constants.SortType.Quality, true))
            else
                self:SetCardDojoList(data)
            end
        end)
        
        -- init views
        CfUtils.SetActive(self.GiftBg, false)
        CfUtils.SetActive(self.GiftBtn, false)
        CfUtils.SetActive(self.TransBtn, false)
        -- EasyTouch.instance.allowUIDetection = false
    end)
end


function UIOverseaClubHallChangeCatDialog:OnFinalize()
    return CoWaitDo(function()
        -- EasyTouch.instance.allowUIDetection = true
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function UIOverseaClubHallChangeCatDialog:OnBackAction()
    if self.oldSignboardId_ ~= self.newSignboardId_ then
        -- reset model
        if self.setCatCallback_ then
            self.setCatCallback_(self.oldSignboardId_)
        end
    end
    if self.closeCallback_ then
        self.closeCallback_()
    end
end


-------------------------------------------------
-- get / set

---@return CardDojo[]
function UIOverseaClubHallChangeCatDialog:GetCardDojoList()
    return checkTable(self.cardDojoList_)
end
function UIOverseaClubHallChangeCatDialog:SetCardDojoList(cardDojoList)
    self.cardDojoList_ = checkTable(cardDojoList)
    self:UpdateCardGridView_()
end


---@return integer
function UIOverseaClubHallChangeCatDialog:GetSelectIndex()
    return checkInt(self.selectIndex_)
end
function UIOverseaClubHallChangeCatDialog:SetSelectIndex(selectIndex)
    local oldSelectIndex = self:GetSelectIndex()
    self.selectIndex_ = checkInt(selectIndex)
    self:SwitchSelectIndex_(oldSelectIndex, self.selectIndex_)
end


---@return integer
function UIOverseaClubHallChangeCatDialog:GetPreviewIndex()
    return checkInt(self.previewIndex_)
end
function UIOverseaClubHallChangeCatDialog:SetPreviewIndex(previewIndex)
    local oldPreviewIndex = self:GetPreviewIndex()
    self.previewIndex_ = checkInt(previewIndex)
    self:SwitchPrivewIndex_(oldPreviewIndex, self.previewIndex_)
end


-------------------------------------------------
-- public

function UIOverseaClubHallChangeCatDialog:Close()
    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogBack()
end


--- 获取 卡牌的最高好感度等级
---@param cardId integer
---@return integer
function UIOverseaClubHallChangeCatDialog:GetCardFavLevelMax(cardId)
    local maxLevel = 0
    for _, id in ipairs(cardConfMgr:GetFavorableExpRewardIdGroup(cardId)) do
        local vo = cardConfMgr:GetFavorableExpRewardVo(id)
        if vo ~= nil then
            maxLevel = math.max(maxLevel, vo.level)
        end
    end
    return maxLevel
end


-------------------------------------------------
-- private

function UIOverseaClubHallChangeCatDialog:UpdateCardGridView_()
    -- reset select index
    self:SetSelectIndex(0)

    -- reset preview index
    for cardIndex, cardDojo in ipairs(self:GetCardDojoList()) do
        if self.newSignboardId_ == cardDojo.cardId then
            self:SetPreviewIndex(cardIndex)
            break
        end
    end
    
    -- reload card gridView
    local gridDataLength = #self:GetCardDojoList()
    GameUtils.ReloadData(self.CardGridView, gridDataLength)
end


function UIOverseaClubHallChangeCatDialog:SwitchSelectIndex_(oldSelectIndex, newSelectIndex)
    local oldCellNode = self.CardGridView:GetShownItemByItemIndex(oldSelectIndex - 1)
    local newCellNode = self.CardGridView:GetShownItemByItemIndex(newSelectIndex - 1)
    -- unselect old
    if isNotNull(oldCellNode) then
        ---@type UISwitchCellNode
        local oldCellEnv = CfUtils.GetLuaScr(oldCellNode, CardGridCellPath)
        oldCellEnv:UpdateSelected(false)
    end
    -- selected new
    if isNotNull(newCellNode) then
        ---@type UISwitchCellNode
        local oldCellEnv = CfUtils.GetLuaScr(newCellNode, CardGridCellPath)
        oldCellEnv:UpdateSelected(true)
    end
end


function UIOverseaClubHallChangeCatDialog:SwitchPrivewIndex_(oldPreviewIndex, newPreviewIndex)
    local oldCellNode = self.CardGridView:GetShownItemByItemIndex(oldPreviewIndex - 1)
    local newCellNode = self.CardGridView:GetShownItemByItemIndex(newPreviewIndex - 1)
    -- unselect old
    if isNotNull(oldCellNode) then
        ---@type UISwitchCellNode
        local oldCellEnv = CfUtils.GetLuaScr(oldCellNode, CardGridCellPath)
        oldCellEnv:UpdateDisplayed(false)
    end
    -- selected new
    if isNotNull(newCellNode) then
        ---@type UISwitchCellNode
        local oldCellEnv = CfUtils.GetLuaScr(newCellNode, CardGridCellPath)
        oldCellEnv:UpdateDisplayed(true)
    end
    -- update infos
    if newPreviewIndex > 0 then
        self:UpdateCardFavInfo_()
        self:UpdateClubCatModel_()
    end
end


--- 更新 卡牌好感度信息
function UIOverseaClubHallChangeCatDialog:UpdateCardFavInfo_()
    local cardDojo   = self:GetCardDojoList()[self:GetPreviewIndex()]
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(cardDojo.cardSkin)
    local cardRoleVo = cardConfMgr:GetCardByRefId(cardSkinVo.roleId)

    -- update cardName
    CfUtils.FillText(self.favNameTxt, cardSkinVo.name)

    -- update favLevel
    local cardFavLevel  = checkInt(cardDojo.favorabilityLevel)
    local favMaxLevel   = self:GetCardFavLevelMax(cardRoleVo.refId)
    local isFavLevelMax = cardFavLevel >= favMaxLevel
    CfUtils.FillText(self.favNumberTxt, cardFavLevel)
    CfUtils.SetActive(self.favLevelAnimUIFX, isFavLevelMax)
    CfUtils.SetUISwitchImage(self.favFrameImg, isFavLevelMax and 2 or 1)
end


-- 更新 看板卡牌猫形象
function UIOverseaClubHallChangeCatDialog:UpdateClubCatModel_()
    local cardDojo = self:GetCardDojoList()[self:GetPreviewIndex()]
    if self.newSignboardId_ == cardDojo.cardId then
        return
    end

    self.newSignboardId_ = cardDojo.cardId
    if self.setCatCallback_ then
        self.setCatCallback_(self.newSignboardId_)
    end
end


-------------------------------------------------
-- handler

---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopGridViewItem
function UIOverseaClubHallChangeCatDialog:OnUpdateCardGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(CardGridCellName)
    local cardDojo = self:GetCardDojoList()[luaIndex]
    ---@type UISwitchCellNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, CardGridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetPosition(luaIndex)
        cellEnv:SetCardDojo(cardDojo)
        cellEnv:UpdateSelected(self:GetSelectIndex() == luaIndex)
        cellEnv:UpdateDisplayed(self:GetPreviewIndex() == luaIndex)
        cellEnv:UpdateSignboard(self.oldSignboardId_ == cardDojo.cardId)
        cellEnv:SetClickAction(Bind(self, self.OnClickCardGridCellHandler_))
    end
    return cellNode
end


---@param cardDojo CardDojo
---@param luaIndex number
function UIOverseaClubHallChangeCatDialog:OnClickCardGridCellHandler_(cardDojo, luaIndex)
    if self:GetSelectIndex() ~= luaIndex then
        self:SetSelectIndex(luaIndex)
        self:SetPreviewIndex(luaIndex)
    end
end


function UIOverseaClubHallChangeCatDialog:OnClickCancelButtonHandler_()
    if self.oldSignboardId_ ~= self.newSignboardId_ then
        -- reset model
        if self.setCatCallback_ then
            self.setCatCallback_(self.oldSignboardId_)
        end
    end
    self:Close()
end


function UIOverseaClubHallChangeCatDialog:OnClickConfirmButtonHandler_()
    -- 没有变化直接关闭
    if self.oldSignboardId_ == self.newSignboardId_ then
        self:Close()
        return
    end

    local cardDojo   = self:GetCardDojoList()[self:GetPreviewIndex()]
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(cardDojo.cardSkin)
    local cardRoleVo = cardConfMgr:GetCardByRefId(cardSkinVo.roleId)
    if checkInt(cardDojo.favorabilityLevel) < cardRoleVo.mainCat then
        GameUtils.Toast(localize('好感度达到_level_级解锁', { _level_ = cardRoleVo.mainCat }))
        return
    end

    local requestData = {playerCardId = cardDojo.id}
    GameUtils.Request(Interfaces.OverseaClubSetSignboard, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- save clubSignboarId
            local myselfDojo = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
            myselfDojo.clubSignboarId = self.newSignboardId_

            -- update clubSignboarId
            self.oldSignboardId_ = self.newSignboardId_

            GameUtils.Toast(localize('保存成功'))
            self:Close()
        end
    end)
end


return UIOverseaClubHallChangeCatDialog
