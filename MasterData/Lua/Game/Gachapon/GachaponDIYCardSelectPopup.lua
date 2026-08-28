-------------------------------------------------------------------------------
-- 抽卡 - 海外自选卡池弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-09 21:27:23
-------------------------------------------------------------------------------

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Gachapon/GachaponDIYCardSelectPopup.prefab
---@class GachaponDIYCardSelectPopup
---@field Env                           	GachaponDIYCardSelectPopup              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ImgBlack                      	UnityEngine.RectTransform               
---@field ButtonClose                   	UnityEngine.RectTransform               
---@field CardHead5                     	UnityEngine.RectTransform               
---@field BtnCard5                      	UnityEngine.RectTransform               
---@field CardHead4                     	UnityEngine.RectTransform               
---@field BtnCard4                      	UnityEngine.RectTransform               
---@field CardHead3                     	UnityEngine.RectTransform               
---@field BtnCard3                      	UnityEngine.RectTransform               
---@field CardHead2                     	UnityEngine.RectTransform               
---@field BtnCard2                      	UnityEngine.RectTransform               
---@field CardHead1                     	UnityEngine.RectTransform               
---@field BtnCard1                      	UnityEngine.RectTransform               
---@field Root                          	UnityEngine.RectTransform               
local GachaponDIYCardSelectPopup = Class('GachaponDIYCardSelectPopup')


function GachaponDIYCardSelectPopup:__init()
    ---@type UnityEngine.RectTransform[]
    self.cardHeadRtList_ = {}
    ---@type CardHeadNode[]
    self.cardHeadEnvList_ = {}
    ---@type table<string, CardDojo>
    self.cardDojoMap_ = {}
    ---@type GachaponDojo
    self.gachaponPoolDojo_ = nil
    ---@type fun():void
    self.closeCallback_ = nil
end


function GachaponDIYCardSelectPopup:__delete()
    self.cardHeadRtList_  = nil
    self.cardHeadEnvList_ = nil
    self.closeCallback_   = nil
    self.cardDojoMap_     = nil
    self.controller       = nil
end


function GachaponDIYCardSelectPopup:Awake()
    SetButtonAction(self.ImgBlack, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ButtonClose, Bind(self, self.OnClickCloseButtonHandler_))

    for cardIndex = 1, 5 do
        local cardBtnRT   = self['BtnCard' .. cardIndex]
        local cardHeadRT  = self['CardHead' .. cardIndex]
        local cardHeadEnv = CfUtils.GetLuaScr(cardHeadRT, Constants.UIBattlingLuaTablePath.CardHeadNode)
        SetButtonAction(cardBtnRT, Bind(self, self.OnClickCardHeadNodeHandler_, cardIndex))
        self.cardHeadRtList_[cardIndex]  = cardHeadRT
        self.cardHeadEnvList_[cardIndex] = cardHeadEnv
    end
end


function GachaponDIYCardSelectPopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.closeCallback_    = initParams.closeCB
        self.gachaponPoolDojo_ = initParams.poolDojo
        self:SetCardLimitNum(checkInt(initParams.limitNum))
        self:SetCardDojoList(checkTable(initParams.cardDojos))
        self:SetSelectIdList(checkTable(initParams.selectIds))
    end)
end


function GachaponDIYCardSelectPopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@type integer
function GachaponDIYCardSelectPopup:GetCardLimitNum()
    return checkInt(self.cardLimitNum_)
end
function GachaponDIYCardSelectPopup:SetCardLimitNum(limitNum)
    self.cardLimitNum_ = checkInt(limitNum)
end


---@return CardDojo[]
function GachaponDIYCardSelectPopup:GetCardDojoList()
    return checkTable(self.cardDojoList_)
end
function GachaponDIYCardSelectPopup:SetCardDojoList(cardDojoList)
    self.cardDojoList_ = checkTable(cardDojoList)
    self:UpdateCardDojoMap_()
end


function GachaponDIYCardSelectPopup:GetSelectIdList()
    return checkTable(self.selectIdList_)
end
function GachaponDIYCardSelectPopup:SetSelectIdList(cardIdList)
    self.selectIdList_ = checkTable(cardIdList)
    CfUtils.SetActive(self.ButtonClose, #self:GetSelectIdList() > 0)
    self:UpdateAllCardHead_()
end


-------------------------------------------------
-- public

function GachaponDIYCardSelectPopup:Close()
    if self.closeCallback_ then
        self.closeCallback_(self:GetSelectIdList())
    end
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function GachaponDIYCardSelectPopup:UpdateCardDojoMap_()
    self.cardDojoMap_ = {}
    for _, cardDojo in ipairs(self:GetCardDojoList()) do
        self.cardDojoMap_[tostring(cardDojo.cardId)] = cardDojo
    end
end


function GachaponDIYCardSelectPopup:UpdateAllCardHead_()
    for cardIndex, cardHeadEnv in ipairs(self.cardHeadEnvList_) do
        local cardId     = checkInt(self:GetSelectIdList()[cardIndex])
        local cardDojo   = self.cardDojoMap_[tostring(cardId)]
        local cardHeadRt = self.cardHeadRtList_[cardIndex]
        CfUtils.SetActive(cardHeadRt, cardDojo ~= nil)
        if cardDojo then
            cardHeadEnv:FreshNode(cardDojo, false, cardIndex)
            cardHeadEnv:SetRookieStatus(true)
        end
    end
end


-------------------------------------------------
-- handler

function GachaponDIYCardSelectPopup:OnClickCloseButtonHandler_()
    if #self:GetSelectIdList() <= 0 then
        return
    end
    self:Close()
end


function GachaponDIYCardSelectPopup:OnClickCardHeadNodeHandler_(cardIndex)
    CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamCardChoose, {
        chooseCardStatu = Constants.ChooseCardStatus.Custom,
        customCardDojos = self:GetCardDojoList(),
        customSelectIds = self:GetSelectIdList(),
        customLeastNum  = self:GetCardLimitNum(),
        customLimitNum  = self:GetCardLimitNum(),
        ---@param newSelectIds string[]
        confirmCb = function(newSelectIds)
            local selectIds = checkTable(newSelectIds)
            local isChanged = false
            if #selectIds == self:GetSelectIdList() then
                for cardIndex, cardId in ipairs(self:GetSelectIdList()) do
                    if checkInt(selectIds[cardIndex]) ~= checkInt(cardId) then
                        isChanged = true
                        break
                    end
                end
            else
                isChanged = true
            end
            if isChanged then
                local gachaponPoolId = checkInt(self.gachaponPoolDojo_.poolId)
                local activityData   = checkTable(self.gachaponPoolDojo_.activity)
                local activityUuid   = checkInt(activityData.activityUuid)
                local cardsString    = table.concat(selectIds, ',')
                local requestData    = {
                    poolId       = gachaponPoolId,
                    activityUuid = activityUuid,
                    cards        = cardsString
                }
                -- request choose cards
                GameUtils.Request(Interfaces.CALL_OVERSEA_CHOOSE_CARDS, requestData, function(request, response)
                    if checkNumber(response.errCode) == 0 then
                        self:SetSelectIdList(selectIds)
                        self:Close()
                    end
                end)
            end
        end
    })
end


return GachaponDIYCardSelectPopup
