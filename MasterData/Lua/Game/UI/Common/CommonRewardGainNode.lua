
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define
local ReverseScaleType = typeof(CS.Game.Native.Common.ReverseScale)
local V2Center         = Vector2.New(0.5, 0.5)
--endregion

--- from: Assets/BundleResources/Prefabs/Common/CommonRewardGainNode.prefab
---@class CommonRewardGainNode
---@field Env                           	CommonRewardGainNode                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field NewText                       	UnityEngine.RectTransform               
---@field GoodNodeStub                  	Engine.Modules.LuaStub     @ 通用道具节点存根 与 GoodNode 二选一          
---@field GoodNode                  	    UnityEngine.RectTransform  @ 通用道具节点 与 GoodNodeStub 二选一
---@field CommonSmallCatBallNodeStub    	Engine.Modules.LuaStub     @ 通用猫球节点存根 与 CatBallNode 二选一          
---@field CatBallNode                    	UnityEngine.RectTransform  @ 通用猫球节点 与 CommonSmallCatBallNodeStub 二选一          
local CommonRewardGainNode = Class('CommonRewardGainNode')

function CommonRewardGainNode:__init()
    self.GoodNode    = nil
    ---@type GoodNodeMB
    self.GoodNodeEnv = nil
    self.CatBallNode = nil
    ---@type CommonSmallCatBallNode
    self.CatBallEnv = nil
end


function CommonRewardGainNode:__delete()

end


function CommonRewardGainNode:Awake()
end


function CommonRewardGainNode:Start()
end


function CommonRewardGainNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region show 

function CommonRewardGainNode:OnShow(goodsTable, num, rewardShowType)
    self._rewardShowType = rewardShowType
    if rewardShowType == Constants.RewardShowType.GoodNode then
        self:ShowGoodNode(goodsTable, num)
    elseif rewardShowType == Constants.RewardShowType.CatBallNode then
        self:ShowCatBallNode(goodsTable, num)
    end
end

function CommonRewardGainNode:ImmediateShow(dojo, rewardShowType)
    if rewardShowType == Constants.RewardShowType.GoodNode then
        self:ImmediateShowGoodNode(dojo)
    elseif rewardShowType == Constants.RewardShowType.CatBallNode then
    end 
end

function CommonRewardGainNode:ShowEffect(...)
    local rewardShowType = self._rewardShowType
    if rewardShowType == Constants.RewardShowType.GoodNode then
        self:ShowGoodNodeEffect(...)
    elseif rewardShowType == Constants.RewardShowType.CatBallNode then

    end
end

function CommonRewardGainNode:ShowCovertEffect(...)
    local rewardShowType = self._rewardShowType
    if rewardShowType == Constants.RewardShowType.GoodNode then
        self:ShowGoodNodeCovertEffect(...)
    elseif rewardShowType == Constants.RewardShowType.CatBallNode then
        self:ShowCatBallNodeCovertEffect(...)
    end
end

--endregion 

--region good Node
function CommonRewardGainNode:ShowGoodNode(goodsTable, num)
    if isNotNull(self.CatBallNode) then
        KTool.SetActive(self.CatBallNode.gameObject, false)
    end

    if isNotNull(self.GoodNode) then
        KTool.SetActive(self.GoodNode.gameObject, true)
    elseif isNotNull(self.GoodNodeStub) then
        self.GoodNode = self.GoodNodeStub:InstantiatePrefab("GoodNode")
        KTool.SetActive(self.GoodNode.gameObject, true)
        self.GoodNode.pivot = V2Center
        KTool.ResetLocalTransform(self.GoodNode)

        ---存在该节点将 父节点的缩放丢到该节点上
        ---@type Game.Native.Common.ReverseScale
        local reScaleComp = KTool.GetComponent(self.GoodNode.gameObject, ReverseScaleType)
        if isNotNull(reScaleComp) then
            reScaleComp.scale = self.GoodNodeStub.transform.localScale.x
            reScaleComp:ResetScale()
            self.GoodNodeStub.transform.localScale = Vector3.one
        end
        self._reScaleComp = reScaleComp

    end

    local go = self.controller.gameObject

    local goodTrans = self.GoodNode
    local newText   = self.NewText
    ---@type GoodNodeMB
    local goodNodeMB = self:GetGoodNodeEnv()
    if not isNull(goodNodeMB) then
        local isCatBall = isSet(goodsTable, "catId")

        local goodsId = goodsTable.goodsId
        if isCatBall then
            --- TODO 处理猫球为道具形式时
            CfUtils.SetActive(newText, false)
        else
            goodNodeMB:SetClickButtonAction(function(goodsId, uId)
                GameUtils.ShowResultTips(go, goodsId, uId, goodsTable.idAreaType, goodsTable.showText)
            end)

            
            local idType = GoodsUtils.GetIdType(goodsId)
            if idType == Constants.IDType.CharacterCard then
                local isNew = true
                ---是卡牌的情况下才显示new的逻辑
                if isSet(goodsTable, "convertGoods") and isSet(goodsTable.convertGoods, "goodsId") then
                    isNew = false
                end
                if not isNull(newText) then
                    CfUtils.SetActive(newText, isNew)
                end
            else
                CfUtils.SetActive(newText, false)
            end
        end

        local id
        if isSet(goodsTable, "playerItemId") then
            id = goodsTable.playerItemId
        end
        if not IsNull(num) then
            goodNodeMB:Reload({ goodsId = goodsId, idAreaType = goodsTable.idAreaType, id = id, isShowNo = true, text = string.format('x%s', FormatCurrencyNum(num)), dojo = goodsTable.playerEquipment or goodsTable.playerCard, data = goodsTable })
        else
            goodNodeMB:Reload({ goodsId = goodsId, idAreaType = goodsTable.idAreaType, id = id, text = num, dojo = goodsTable.playerEquipment or goodsTable.playerCard, data = goodsTable })
        end

        if not isCatBall then
            self:FillFishInfo(go, goodsTable)
        end
    end

end

function CommonRewardGainNode:FillFishInfo(go, dojo)
    if not dojo then
        return
    end
    local idType = GoodsUtils.GetIdType(dojo.goodsId)

    local isFish = idType == Constants.IDType.GoodsFish
    local fishRatingGo = go.gameObject.transform:Find("FishRating")
    CfUtils.SetActive(fishRatingGo, isFish)

    --鱼部分
    if isFish and fishRatingGo then
        local FishingUtils = import('Game.UI.Fishing.FishingUtils')
        CfUtils.FillText(fishRatingGo.transform:Find("TextGrade"), FishingUtils.GetFishRareNameByRare(dojo.rating))
        CfUtils.SetUISwitchImage(fishRatingGo.transform:Find("ImgIcon"), FishingUtils.GetFishRareNameByRare(dojo.rating) == "S" and 2 or 1)
    end
end

---ShowGoodNodeEffect
---显示道具节点特效
---@param goodsId number
function CommonRewardGainNode:ShowGoodNodeEffect(goodsId)
    ---@type GoodNodeMB
    local env = self:GetGoodNodeEnv()
    if isNull(env) then return end
    env:ShowEffect(goodsId)
end

function CommonRewardGainNode:ShowGoodNodeCovertEffect(goodsTable)
    ---@type GoodNodeMB
    local env = self:GetGoodNodeEnv()
    if isNull(env) then return end
    local convertGoods = goodsTable.convertGoods
    env:Reload({ goodsId = convertGoods.goodsId, isShowNo = true, text = string.format('x%s', FormatCurrencyNum(convertGoods.num)), dojo = goodsTable.playerEquipment, data = goodsTable })
    env:ShowCommonConvertEffect()
    self:FillFishInfo(self.controller.gameObject, goodsTable)
end

function CommonRewardGainNode:ImmediateShowGoodNode(dojo)
    ---@type GoodNodeMB
    local goodNodeMB = self:GetGoodNodeEnv()
    if isNull(goodNodeMB) then return end
    if isSet(dojo, "convertGoods") and isSet(dojo.convertGoods, "goodsId") then
        ---@type UnityEngine.CanvasGroup
        --local canvasGroup = KTool.GetOrAddComponent(self.GoodFatherRoot.gameObject, typeof(CanvasGroup))
        --canvasGroup.alpha = 1
        local convertGoods = dojo.convertGoods
        if not isNull(goodNodeMB) then
            goodNodeMB:ShowEffect(convertGoods.goodsId)
            goodNodeMB:Reload({ goodsId = convertGoods.goodsId, isShowNo = true, text = string.format('x%s', FormatCurrencyNum(convertGoods.num)), dojo = dojo.playerEquipment })
        end
    else
        if not isNull(goodNodeMB) then
            local id
            if isSet(dojo, "playerItemId") then
                id = dojo.playerItemId
            end
            goodNodeMB:ShowEffect(dojo.goodsId)
            goodNodeMB:Reload({ goodsId = dojo.goodsId, id = id, isShowNo = true, text = string.format('x%s', FormatCurrencyNum(dojo.num)), dojo = dojo.playerEquipment, data = dojo })
            self:FillFishInfo(self.controller.gameObject, dojo)
        end
    end
end

function CommonRewardGainNode:ResetScale()
    ---@type Game.Native.Common.ReverseScale
    local comp = self._reScaleComp
    if isNull(comp) then return end
    comp:ResetScale()
end

--endregion 

--region cat ball

---ShowCatBallNode
---@param catBallEntity CatBallEntity
function CommonRewardGainNode:ShowCatBallNode(catBallEntity)
    if isNotNull(self.GoodNode) then
        KTool.SetActive(self.GoodNode.gameObject, false)
    end

    if isNotNull(self.CatBallNode) then
        KTool.SetActive(self.CatBallNode.gameObject, true)
    else
        self.CatBallNode = self.CommonSmallCatBallNodeStub:InstantiatePrefab("CatBallNode")
        -- KTool.CopyTransformToTarget(self.CommonSmallCatBallNodeStub.transform, self.CatBallNode)
        KTool.SetActive(self.CatBallNode.gameObject, true)
        self.CatBallNode.pivot = V2Center
        KTool.ResetLocalTransform(self.CatBallNode)
    end

    ---@type CommonSmallCatBallNode
    local env = self:GetCatBallEnv()
    if isNull(env) then return end
    
    env:FreshGoodUI(catBallEntity)

end

function CommonRewardGainNode:ShowCatBallNodeCovertEffect()
    ---@type CommonSmallCatBallNode
    local env = self:GetCatBallEnv()
    if isNull(env) then return end
    env:PlayAnimationSplit()
end
--endregion 



--region get/set 

---
---GetGoodNodeEnv
---@return GoodNodeMB
function CommonRewardGainNode:GetGoodNodeEnv()
    if isNull(self.GoodNodeEnv) then
        self.GoodNodeEnv = CfUtils.GetLuaScr(self.GoodNode, Constants.UILuaTablePath.GoodNodeMB)
    end
    return self.GoodNodeEnv
end

---
---GetCatBallEnv
---@return CommonSmallCatBallNode
function CommonRewardGainNode:GetCatBallEnv()
    if isNull(self.CatBallEnv) then
        self.CatBallEnv = CfUtils.GetLuaScr(self.CatBallNode, "Game.CatBall.CommonSmallCatBallNode")
    end
    return self.CatBallEnv
end

---endregion 


--region handler 


---endregion 


return CommonRewardGainNode
