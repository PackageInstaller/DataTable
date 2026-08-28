
--region global define
local CS     = CS
local Bind   = Bind
local import = import
local isNull = isNull
local CfUtils = CfUtils
local SetButtonAction = SetButtonAction
--endregion

--region import
---@type CatBallUtils
local CatBallUtils              = import("Game.CatBall.CatBallUtils")
---@type Engine.Lib.KTool
local KTool                     = CS.Engine.Lib.KTool
--endregion

--region define
local StarGroupEnvPath          = "Game.CardProgression.Common.CardProgressionStarGroupNode"
local SkillAndAttributeEnvPath  = "Game.CatBall.CatBallChooseCardsSkillAndAttributeNode"

--endregion

       
--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballCultivateDialog.prefab > name: StarupPanel
---@class CatBallCultivateStarUpPanel
---@field Env                           	CatBallCultivateStarUpPanel             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field Max                           	UnityEngine.RectTransform               
---@field LockTextDesc                  	UnityEngine.UI.Text                     
---@field Lock                          	UnityEngine.RectTransform               
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field GoodNode                      	UnityEngine.RectTransform               
---@field redPoint                      	UnityEngine.RectTransform               
---@field CanStarUp                     	UnityEngine.RectTransform               
---@field Status                        	UnityEngine.RectTransform               
---@field SkillAndAttributeNode         	UnityEngine.RectTransform               
---@field StarLevelNode                 	UnityEngine.RectTransform               
local CatBallCultivateStarUpPanel = Class('CatBallCultivateStarUpPanel')

function CatBallCultivateStarUpPanel:__init()

end


function CatBallCultivateStarUpPanel:__delete()

end


-- function CatBallCultivateStarUpPanel:Awake()
-- end


function CatBallCultivateStarUpPanel:Start()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
end


function CatBallCultivateStarUpPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param dojo CatEggDojo
---@param parentEnv CatBallCultivateDialog
function CatBallCultivateStarUpPanel:FreshUI(dojo, parentEnv)
    self._parentEnv = parentEnv
    ---@type CatBallVo
    local vo = CatBallUtils.GetCatBallVo(dojo.catId)
    self._dojo = dojo
    self._vo = vo
    
    local star = dojo.star
    self._star = star
    self._nextStar = math.min(star + 1, vo.starMax)
    self._maxStar  = vo.starMax

    self:FreshStarUI()
end

function CatBallCultivateStarUpPanel:FreshStarUI(customNextStar)
    self:FreshStarNodes(customNextStar) 
    self:FreshSkillAndAttribute(customNextStar)
    self:FreshBottomUI(customNextStar)
end

function CatBallCultivateStarUpPanel:FreshStarNodes(customNextStar)
    ---@type CardProgressionStarGroupNode
    local env = self:GetStarGroupEnv()
    if isNull(env) then return end
    env:SetCallback(Bind(self, self.OnClickStarNodeAction))
    env:FreshUI(self._star, self._nextStar, self._maxStar, true, false, customNextStar)
end

function CatBallCultivateStarUpPanel:FreshSkillAndAttribute(customNextStar)
    local env = self:GetSkillAndAttributeEnv()
    if isNull(env) then return end
    env:FreshUI(self._dojo, customNextStar or self._nextStar, true) 

end

function CatBallCultivateStarUpPanel:FreshBottomUI(customNextStar)
    local isMaxStar = self._star >= self._maxStar
    KTool.SetActive(self.Max.gameObject, isMaxStar)
    local isLock = customNextStar ~= nil and not isMaxStar
    KTool.SetActive(self.Lock.gameObject, isLock)
    local isCanUp = customNextStar == nil and not isMaxStar
    KTool.SetActive(self.CanStarUp.gameObject, customNextStar == nil and not isMaxStar)

    if isCanUp then
        local star = self._nextStar
        ---@type CatBallUpStarVo
        local starVo = CatBallUtils.GetCatBallUpStarVo(self._dojo.catId, star)
        local goodsConsume = table.takeFirst(starVo.consumeKinds)
        local goodsId = goodsConsume.goodsId
        local goodsNum = goodsConsume.goodsNum
        CfUtils.RefeshGoodGo(self.GoodNode, goodsId, GoodsUtils.GetGoodsText(goodsId, goodsNum, 1), 0.55, nil, function()
            GameUtils.ShowCommonGoodsTipsBoard(self.GoodNode, goodsId, true)
        end)

        local consumeGold = table.takeFirst(starVo.consumes)
        KTool.SetActive(self.CommonBtnConsumePop.gameObject, consumeGold ~= nil)
        if consumeGold ~= nil then
            UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, consumeGold.goodsId, consumeGold.goodsNum)
        end

        KTool.SetActive(self.redPoint.gameObject, CatBallUtils.GetRedPointShowStateByDojo(self._dojo))
    end
end

--endregion 


--region get/set 

---GetSkillAndAttributeEnv
---@return CardProgressionStarGroupNode
function CatBallCultivateStarUpPanel:GetStarGroupEnv()
    if isNull(self._starGroupEnv) then
        self._starGroupEnv = CfUtils.GetLuaScr(self.StarLevelNode.gameObject, StarGroupEnvPath)
    end
    return self._starGroupEnv
end

---GetSkillAndAttributeEnv
---@return CatBallChooseCardsSkillAndAttributeNode
function CatBallCultivateStarUpPanel:GetSkillAndAttributeEnv()
    if isNull(self._skillAndAttributeEnv) then
        self._skillAndAttributeEnv = CfUtils.GetLuaScr(self.SkillAndAttributeNode, SkillAndAttributeEnvPath)
    end
    return self._skillAndAttributeEnv
end

---endregion 


--region handler 

function CatBallCultivateStarUpPanel:OnClickStarNodeAction(customNextStar)
    if customNextStar < self._nextStar then
        return
    end
    local star
    if customNextStar ~= self._nextStar then
        star = customNextStar
    end
    self:FreshStarUI(star)
end

function CatBallCultivateStarUpPanel:OnClickBtnAction()
    -- if true then
    --     -- GoodsUtils.DrawRewards(realConsumes)
    --     local playerCatId = self._dojo.id
    --     local star = self._nextStar
    --     ---@type CatEggComponent
    --     local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    --     ---@type CatEggDojo
    --     local dojo = eggComponent:UpdateCatStarUp(playerCatId, star)

    --     self:FreshUI(dojo)
    --     -- Events.Broadcast("")
    --     CfUtils.DialogOpen(Constants.UITypeIds.CatBallCultivateStarUpSuccess, {dojo = dojo}, nil, true)

        
    --     return
    -- end
    
    local star = self._nextStar
    ---@type CatBallUpStarVo
    local starVo = CatBallUtils.GetCatBallUpStarVo(self._dojo.catId, star)
    
    local totalConsumes = {}
    table.link(totalConsumes, starVo.consumeKinds)
    table.link(totalConsumes, starVo.consumes)
    local realConsumes, errorTip = GoodsUtils.CheckGoodConsume(totalConsumes)
    if errorTip then
        GameUtils.Toast(errorTip)
        return
    end

    local playerCatId = self._dojo.id
    local interface = Interfaces.OverseaCatBallStarUp
    local requestData = {id = playerCatId}
    GameUtils.Request(interface, requestData, function(request, response)
        if checkNumber(response.errCode) == 0 then
            if isNotNull(self._parentEnv) then
                self._parentEnv:PlayStarAni()
            end

            local data = response.data
            
            GoodsUtils.DrawRewards(realConsumes)

            local star = checkNumber(data.star)
            ---@type CatEggComponent
            local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
            ---@type CatEggDojo
            local dojo = eggComponent:UpdateCatStarUp(playerCatId, star)

            if isNotNull(self._parentEnv) then
                self._parentEnv:UpdateRedPointShowState()
            end

            self:FreshUI(dojo, self._parentEnv)

            CfUtils.DialogOpen(Constants.UITypeIds.CatBallCultivateStarUpSuccess, {dojo = dojo}, nil, true)

            
        end
        
    end)

end

---endregion 


return CatBallCultivateStarUpPanel
