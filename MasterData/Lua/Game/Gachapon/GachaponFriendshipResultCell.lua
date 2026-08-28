-------------------------------------------------------------------------------
-- 海外抽卡 - 友情卡池结果界面 - 结果节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-22 20:57:24
-------------------------------------------------------------------------------

local cardConfMgr   = CardConfMgr:GetInstance()
local goodsConfMgr  = GoodsConfMgr:GetInstance()

--- from: Assets/BundleResources/Prefabs/Gachapon/GachaponFriendshipTreasureboxNode.prefab > name: GachaponFriendshipTreasureboxNode
---@class GachaponFriendshipResultCell
---@field Env                           	GachaponFriendshipResultCell            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.RectTransform               	@ 0    根节点
---@field GoodsListLight                	UnityEngine.RectTransform               	@ 1    道具节点
---@field CardHeadNode                  	UnityEngine.RectTransform               	@ 2    卡牌头像-根节点
---@field CardQualityImg1               	UnityEngine.RectTransform               	@ 3    卡牌头像 品质图片1
---@field CardQualityImg2               	UnityEngine.RectTransform               	@ 4    卡牌头像 品质图片2
---@field CardHeadImg                   	UnityEngine.RectTransform               	@ 5    卡牌头像 形象图片
---@field CardCareerShadow              	UnityEngine.RectTransform               	@ 6    卡牌头像 职业阴影图
---@field CardCareerImg                 	UnityEngine.RectTransform               	@ 7    卡牌头像 职业图标
---@field NewMarkImg                    	UnityEngine.RectTransform               	@ 8    新获得标记图
---@field ConvertGoodsImg               	UnityEngine.RectTransform               	@ 9    转换道具图标
---@field GoodsNumTxt                   	UnityEngine.RectTransform               	@ 10   道具数量文本
---@field GoodsNumImg                   	UnityEngine.RectTransform               	@ 11   道具数量图标
---@field GoodsQualityUIFX              	UnityEngine.RectTransform               	@ 12   道具品质特效
local GachaponFriendshipResultCell = Class('GachaponFriendshipResultCell')


function GachaponFriendshipResultCell:__init()
end


function GachaponFriendshipResultCell:__delete()
end


function GachaponFriendshipResultCell:Awake()
    SetButtonAction(self.CardHeadNode, Bind(self, self.OnClickCardHeadHandler_))
end


function GachaponFriendshipResultCell:Start()
end


function GachaponFriendshipResultCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function GachaponFriendshipResultCell:GetResultIndex()
    return self.resultIndex_
end
function GachaponFriendshipResultCell:SetResultIndex(index)
    self.resultIndex_ = checkInt(index)
end


---@return table
function GachaponFriendshipResultCell:GetResultData()
    return checkTable(self.resultData_)
end
function GachaponFriendshipResultCell:SetResultData(resultData)
    self.resultData_ = checkTable(resultData)
    self:UpdateResultInfo_()
end


---@return fun(luaIndex:integer):void
function GachaponFriendshipResultCell:GetClickCardHeadCb()
    return self.clickCardHeadCb_
end
function GachaponFriendshipResultCell:SetClickCardHeadCb(callback)
    self.clickCardHeadCb_ = callback
end


-------------------------------------------------
-- private

function GachaponFriendshipResultCell:UpdateResultInfo_()
    local resultData      = self:GetResultData()
    local resultGoodsId   = checkInt(resultData.goodsId)
    local resultGoodsNum  = checkInt(resultData.num)
    local resultGoodsType = GoodsUtils.GetIdType(resultGoodsId)
    CfUtils.SetActive(self.GoodsNumTxt, false)
    CfUtils.SetActive(self.GoodsNumImg, false)

    local resultGoodsVo = goodsConfMgr:GetGoodsVoById(resultGoodsId)
    CfUtils.SetUISwitchParticleSystem(self.GoodsQualityUIFX, resultGoodsVo.quality - 1) -- 因为1是个空白位

    ------------------------------------------------- [card]
    if resultGoodsType == Constants.IDType.CharacterCard then
        CfUtils.SetActive(self.GoodsListLight, false)
        CfUtils.SetActive(self.CardHeadNode, true)

        ---@type CardVo
        local cardVo = cardConfMgr:GetCardByRefId(resultGoodsId) or {}

        local cardRare = checkInt(cardVo.rare)
        CfUtils.SetUISwitchImage(self.CardQualityImg1, cardRare)
        CfUtils.SetUISwitchImage(self.CardQualityImg2, cardRare)

        CfUtils.SetUISwitchImage(self.CardCareerImg, cardVo.career)
        CfUtils.SetUISwitchImage(self.CardCareerShadow, cardVo.attributeType)

        ---@type CardSkinVo
        local skinVo = cardConfMgr:GetCardSkinBySkinId(cardVo.defaultSkin) or {}
        CfUtils.FillImage(self.CardHeadImg, skinVo.cardHeadList)

        -- update convert
        local convertGoods = checkTable(resultData.convertGoods)
        if next(convertGoods) ~= nil then
            local goodsIconPath = goodsConfMgr:GetPhotoPathById(convertGoods.goodsId)
            CfUtils.FillImage(self.ConvertGoodsImg, goodsIconPath)
            CfUtils.SetActive(self.ConvertGoodsImg, true)
            CfUtils.SetActive(self.GoodsNumTxt, true)
            CfUtils.SetActive(self.GoodsNumImg, true)
            CfUtils.FillText(self.GoodsNumTxt, string.fmt('x%1', tostring(convertGoods.num)))
        else
            CfUtils.SetActive(self.ConvertGoodsImg, false)
        end

    ------------------------------------------------- [goods]
    else
        CfUtils.SetActive(self.GoodsListLight, true)
        CfUtils.SetActive(self.CardHeadNode, false)

        ---@type CommonGoodsListLight @ 道具奖励列表
        local goodsRewardsList = CfUtils.GetLuaScr(self.GoodsListLight, Constants.UILuaTablePath.ComGoodsList2)
        goodsRewardsList:FreshBaseUI({resultData}, nil, nil, nil, nil, nil, true)
    end

    -- update newMark
    local isNewState = resultData.playerCard ~= nil
    CfUtils.SetActive(self.NewMarkImg, isNewState)
end


-------------------------------------------------
-- handler

function GachaponFriendshipResultCell:OnClickCardHeadHandler_()
    if self:GetClickCardHeadCb() then
        self:GetClickCardHeadCb()(self:GetResultIndex())
    end
end


return GachaponFriendshipResultCell
