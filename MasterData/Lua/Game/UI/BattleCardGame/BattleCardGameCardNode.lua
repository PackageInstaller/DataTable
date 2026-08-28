-------------------------------------------------------------------------------
-- 和风战牌 - 基础卡牌节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-13 11:03:24
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerBattle/PokerCardNode.prefab > name: PokerCardNode
---@class BattleCardGameCardNode
---@field Env                           	BattleCardGameCardNode                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field DebugTxt                      	UnityEngine.RectTransform               	@ 1    调试文本
---@field CardFaceRoot                  	UnityEngine.RectTransform               	@ 2    牌面根节点
---@field LeftBarImg                    	UnityEngine.RectTransform               	@ 3    左侧条图片
---@field FrameImg1                     	UnityEngine.RectTransform               	@ 4    卡牌框图片1
---@field FrameImg2                     	UnityEngine.RectTransform               	@ 5    卡牌框图片2
---@field FrameBgImg                    	UnityEngine.RectTransform               	@ 6    卡牌框背景
---@field RoleInsideImg                 	UnityEngine.RectTransform               	@ 7    角色内部图片
---@field RoleOutsideImg                	UnityEngine.RectTransform               	@ 8    角色外部图片
---@field CardStarIcon                  	UnityEngine.RectTransform               	@ 9    卡牌星级图标
---@field CardTypeIcon                  	UnityEngine.RectTransform               	@ 10   卡牌类型图标
---@field AttrImgUp                     	UnityEngine.RectTransform               	@ 11   属性值图片-上
---@field AttrImgDown                   	UnityEngine.RectTransform               	@ 12   属性值图片-下
---@field AttrImgRight                  	UnityEngine.RectTransform               	@ 13   属性值图片-右
---@field AttrImgLeft                   	UnityEngine.RectTransform               	@ 14   属性值图片-左
---@field PublicEyesIcon                	UnityEngine.RectTransform               	@ 15   明牌模式图标
---@field AdvancedUIFX                  	UnityEngine.RectTransform               	@ 16   高级卡特效
---@field CardBackImg                   	UnityEngine.RectTransform               	@ 17   卡背图片
---@field CardBgLayer                   	UnityEngine.RectTransform               	@ 18   卡牌背景层
---@field CardDrawLayer                 	UnityEngine.RectTransform               	@ 19   卡牌形象层
---@field CardInfoLayer                 	UnityEngine.RectTransform               	@ 20   卡牌信息层
---@field CardAttrLayer                 	UnityEngine.RectTransform               	@ 21   卡牌属性层
local BattleCardGameCardNode = Class('BattleCardGameCardNode')


function BattleCardGameCardNode:__init()
    ---@type table<string, integer> @ 基础属性值
    self.baseAttrMap_ = {}
end


function BattleCardGameCardNode:__delete()
    self.baseAttrMap_ = nil
end


function BattleCardGameCardNode:Awake()
    self:SwitchCoverState_()
end


function BattleCardGameCardNode:Start()
end


function BattleCardGameCardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameCardNode:GetBattleCardId()
    return checkInt(self.battleCardId_)
end
function BattleCardGameCardNode:SetBattleCardId(cardId)
    self.battleCardId_ = checkInt(cardId)
    self:UpdateCardInfo_()
end


---@return integer
function BattleCardGameCardNode:GetBattleCardType()
    return checkInt(self.battleCardType_)
end


---@return boolean
function BattleCardGameCardNode:IsBackState()
    return checkBool(self.isBackState_)
end
function BattleCardGameCardNode:SetBackState(isBack)
    self.isBackState_ = checkBool(isBack)
    self:SwitchCoverState_()
end


---@return boolean
function BattleCardGameCardNode:IsFlipBackImg()
    return checkBool(self.isFlipBackImg_)
end
function BattleCardGameCardNode:SetFlipBackImg(isFlip)
    self.isFlipBackImg_ = checkBool(isFlip)
    self.CardBackImg:SetRotationY(self:IsFlipBackImg() and 0 or 180)
end


---@return boolean
function BattleCardGameCardNode:IsRedPlayMode()
    return checkBool(self.isRedPlayMode_)
end
function BattleCardGameCardNode:SetRedPlayMode(isRed)
    self.isRedPlayMode_  = checkBool(isRed)
    self.isBluePlayMode_ = false
    self:UpdatePlayMode_()
end


---@return boolean
function BattleCardGameCardNode:IsBluePlayMode()
    return checkBool(self.isBluePlayMode_)
end
function BattleCardGameCardNode:SetBluePlayMode(isBlue)
    self.isBluePlayMode_ = checkBool(isBlue)
    self.isRedPlayMode_  = false
    self:UpdatePlayMode_()
end


---@return boolean
function BattleCardGameCardNode:IsShowPublicEye()
    return checkBool(self.isShowPublicEye_)
end
function BattleCardGameCardNode:SetShowPublicEye(isShow)
    self.isShowPublicEye_ = checkBool(isShow)
    CfUtils.SetActive(self.PublicEyesIcon, self:IsShowPublicEye())
end


---@return table<string, integer>
function BattleCardGameCardNode:GetBaseAttrMap()
    return checkTable(self.baseAttrMap_)
end


---@return table<string, integer>
function BattleCardGameCardNode:GetCustomAttrMap()
    return checkTable(self.customAttrMap_)
end
function BattleCardGameCardNode:SetCustomAttrMap(attrMap)
    self.customAttrMap_ = {}
    for attrIndex, attrNum in pairs(checkTable(attrMap)) do
        self.customAttrMap_[tostring(attrIndex)] = self:SafeChangeCardAttr_(attrNum)
    end
    self:UpdateAttrValues_()
end


-------------------------------------------------
-- public

---@param extraParams table
function BattleCardGameCardNode:ParseExtraParams(extraParams)
    self:SetBackState(extraParams.isBack)
    self:SetRedPlayMode(extraParams.isRed)
    self:SetBluePlayMode(extraParams.isBlue)
    self:SetCustomAttrMap(extraParams.attrMap)
end


-------------------------------------------------
-- private

function BattleCardGameCardNode:UpdateCardInfo_()
    local battleCardId = self:GetBattleCardId()
    local cardInfoVo   = BattleCardGameUtils.GetCardInfoVo(battleCardId)
    local isValidCard  = next(cardInfoVo) ~= nil

    -- reset status
    CfUtils.SetUISwitchImage(self.FrameImg1, 1)
    CfUtils.SetUISwitchImage(self.LeftBarImg, 1)
    CfUtils.SetActive(self.AdvancedUIFX, false)
    CfUtils.SetActive(self.CardBgLayer, isValidCard)
    CfUtils.SetActive(self.CardAttrLayer, isValidCard)
    CfUtils.SetActive(self.CardInfoLayer, isValidCard)
    CfUtils.SetActive(self.CardDrawLayer, isValidCard)
    CfUtils.SetActive(self.DebugTxt, not isValidCard)
    if not isValidCard then
        CfUtils.FillText(self.DebugTxt, battleCardId)
        return
    end
    
    -- 星级信息
    CfUtils.SetUISwitchImage(self.LeftBarImg, cardInfoVo.cardStar)
    self:UpdatePlayMode_()
    
    -- 卡牌形象
    local isAdvanced = cardInfoVo:IsAdvanced()
    CfUtils.SetActive(self.RoleOutsideImg, isAdvanced)
    if isAdvanced then
        CfUtils.FillImage(self.RoleInsideImg, cardInfoVo.drawPath)
        CfUtils.FillImage(self.RoleOutsideImg, cardInfoVo.drawPath2)
    else
        CfUtils.FillImage(self.RoleInsideImg, cardInfoVo.drawPath)
    end

    -- 星级图标、种类图标、是否显示特效
    self.battleCardType_ = cardInfoVo.cardKind
    CfUtils.SetActive(self.CardTypeIcon, cardInfoVo.cardKind > 0)
    CfUtils.SetUISwitchImage(self.CardTypeIcon, cardInfoVo.cardKind)
    CfUtils.SetUISwitchImage(self.CardStarIcon, cardInfoVo.cardStar)
    CfUtils.SetActive(self.AdvancedUIFX, cardInfoVo:IsEffected())

    -- 属性值
    self.baseAttrMap_ = {
        [tostring(BattleCardGameUtils.CardAttrIndex.TOP)]    = cardInfoVo:GetAttrTop(),
        [tostring(BattleCardGameUtils.CardAttrIndex.LEFT)]   = cardInfoVo:GetAttrLeft(),
        [tostring(BattleCardGameUtils.CardAttrIndex.RIGHT)]  = cardInfoVo:GetAttrRight(),
        [tostring(BattleCardGameUtils.CardAttrIndex.BOTTOM)] = cardInfoVo:GetAttrBottom(),
    }
    self:UpdateAttrValues_()
end


--- 更新卡面的模式（红方模式、蓝方模式、正常正常）
function BattleCardGameCardNode:UpdatePlayMode_()
    local battleCardId = self:GetBattleCardId()
    local cardInfoVo   = BattleCardGameUtils.GetCardInfoVo(battleCardId)
    local isValidCard  = next(cardInfoVo) ~= nil
    if not isValidCard then return end

    local frameStatus = cardInfoVo.cardStar
    if self:IsBluePlayMode() then
        frameStatus = 7
    elseif self:IsRedPlayMode() then
        frameStatus = 8
    end
    CfUtils.SetUISwitchImage(self.FrameImg1, frameStatus)  -- 1-6 = star, 7=blue, 8=red
    CfUtils.SetUISwitchImage(self.FrameBgImg, frameStatus)  -- 1-6 = star, 7=blue, 8=red
end


--- 切换封面状态（正面显示、背面显示）
function BattleCardGameCardNode:SwitchCoverState_()
    local isBackState = self:IsBackState()
    CfUtils.SetActive(self.CardBackImg, isBackState)
    CfUtils.SetActive(self.CardFaceRoot, not isBackState)
end


--- 更新卡牌属性值
function BattleCardGameCardNode:UpdateAttrValues_()
    local battleCardId = self:GetBattleCardId()
    local cardInfoVo   = BattleCardGameUtils.GetCardInfoVo(battleCardId)
    local isValidCard  = next(cardInfoVo) ~= nil
    if not isValidCard then return end

    local baseAttrMap    = self:GetBaseAttrMap()
    local baseAttrTop    = checkInt(baseAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.TOP)])
    local baseAttrLeft   = checkInt(baseAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.LEFT)])
    local baseAttrRight  = checkInt(baseAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.RIGHT)])
    local baseAttrBottom = checkInt(baseAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.BOTTOM)])
    
    local customAttrMap    = self:GetCustomAttrMap()
    local customAttrTop    = checkInt(customAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.TOP)])
    local customAttrLeft   = checkInt(customAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.LEFT)])
    local customAttrRight  = checkInt(customAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.RIGHT)])
    local customAttrBottom = checkInt(customAttrMap[tostring(BattleCardGameUtils.CardAttrIndex.BOTTOM)])

    local resultAttrTop    = customAttrTop > 0 and customAttrTop or baseAttrTop
    local resultAttrLeft   = customAttrLeft > 0 and customAttrLeft or baseAttrLeft
    local resultAttrRight  = customAttrRight > 0 and customAttrRight or baseAttrRight
    local resultAttrBottom = customAttrBottom > 0 and customAttrBottom or baseAttrBottom

    -- update attr image
    CfUtils.FillImage(self.AttrImgUp, BattleCardGameUtils.GetAttrNumIconPath(resultAttrTop), true)
    CfUtils.FillImage(self.AttrImgLeft, BattleCardGameUtils.GetAttrNumIconPath(resultAttrLeft), true)
    CfUtils.FillImage(self.AttrImgRight, BattleCardGameUtils.GetAttrNumIconPath(resultAttrRight), true)
    CfUtils.FillImage(self.AttrImgDown, BattleCardGameUtils.GetAttrNumIconPath(resultAttrBottom), true)
    CfUtils.SetUISwitchImage(self.AttrImgUp, resultAttrTop ~= baseAttrTop and 2 or 1)
    CfUtils.SetUISwitchImage(self.AttrImgLeft, resultAttrLeft ~= baseAttrLeft and 2 or 1)
    CfUtils.SetUISwitchImage(self.AttrImgRight, resultAttrRight ~= baseAttrRight and 2 or 1)
    CfUtils.SetUISwitchImage(self.AttrImgDown, resultAttrBottom ~= baseAttrBottom and 2 or 1)
end


--- 安全设置卡牌属性值
---@param attrNum integer @ 当前值
---@return integer @ 结果值
function BattleCardGameCardNode:SafeChangeCardAttr_(attrNum)
    local CARD_ATTR_MIN = BattleCardGameUtils.PlayDefines.CARD_ATTR_MIN
    local CARD_ATTR_MAX = BattleCardGameUtils.PlayDefines.CARD_ATTR_MAX
    return math.max(CARD_ATTR_MIN, math.min(checkInt(attrNum), CARD_ATTR_MAX))
end


return BattleCardGameCardNode
