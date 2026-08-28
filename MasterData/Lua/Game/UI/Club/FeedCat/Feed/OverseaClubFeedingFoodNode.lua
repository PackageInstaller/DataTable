---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")


--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingFoodPopup.prefab > name: Cell
---@class OverseaClubFeedingFoodNode
---@field Env                           	OverseaClubFeedingFoodNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field NotEnough                     	UnityEngine.RectTransform               	@ 0    
---@field ImgFavorite                   	UnityEngine.RectTransform               	@ 1    
---@field GoodNode                      	UnityEngine.RectTransform               	@ 2    
local OverseaClubFeedingFoodNode = Class("OverseaClubFeedingFoodNode")

---@class OverseaClubFeedingFoodNode.InputData
---@field foodData ClubFeedCatFoodVo
---@field isLike boolean
---@field select boolean
---@field isSpecial boolean

function OverseaClubFeedingFoodNode:__init()
    self.controller = nil
end

function OverseaClubFeedingFoodNode:__delete()
    self.controller = nil
end

function OverseaClubFeedingFoodNode:Awake()
end

---@param inData OverseaClubFeedingFoodNode.InputData
function OverseaClubFeedingFoodNode:RefreshData(inData,cb)
    self.inData = inData
    self.clickCallback = cb
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingFoodNode:RefreshUI()
    CfUtils.SetActive(self.NotEnough, self.inData.select)
    CfUtils.SetActive(self.ImgFavorite, self.inData.isLike)
    CfUtils.RefeshGoodGo2(self.GoodNode, self.inData.foodData.id, GoodsUtils.GetThingNo(self.inData.foodData.id),nil,nil,Bind(self,self.OnClick))
end

function OverseaClubFeedingFoodNode:OnClick()
    local ownNum = GoodsUtils.GetThingNo(self.inData.foodData.id)
    --if ownNum == 0 or self.inData.select == true then
    --    if self.inData.isSpecial then
    --        CfUtils.DialogOpen(Constants.UITypeIds.UICommonBuyItemDialog, {
    --            goodsId = self.inData.foodData.id,
    --            consumeGoodsId = Utils.GetParamValue(Utils.ParamsId.BuySpecialFoodItemId),
    --            consumeNum = Utils.GetParamValue(Utils.ParamsId.BuySpecialFoodCost),
    --            maxBuyNum = 99,
    --            buyCb = function(num)
    --                Mgr.Server:ReqBuySpecialFood(num,function()
    --                    self:RefreshUI()
    --                end)
    --            end
    --        })
    --    else
    --        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(self.inData.foodData.id)
    --        if isTable(vo) then
    --            GameUtils.ShowCommonGoodsTipsBoard(self.controller.gameObject, self.inData.foodData.id, true)
    --        end    
    --    end
    --else
    --    if self.clickCallback then
    --        self.clickCallback()
    --    end
    --end

    if ownNum == 0 and checkBool(self.inData.isSpecial) then
        CfUtils.DialogOpen(Constants.UITypeIds.UICommonBuyItemDialog, {
            goodsId = self.inData.foodData.id,
            consumeGoodsId = Utils.GetParamValue(Utils.ParamsId.BuySpecialFoodItemId),
            consumeNum = Utils.GetParamValue(Utils.ParamsId.BuySpecialFoodCost),
            maxBuyNum = 99,
            buyCb = function(num)
                Mgr.Server:ReqBuySpecialFood(num, function()
                    self:RefreshUI()
                end)
            end
        })
    else
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(self.inData.foodData.id)
        if isTable(vo) then
            GameUtils.ShowCommonGoodsTipsBoard(self.controller.gameObject, self.inData.foodData.id, true)
        end
    end

    if self.inData.select == false then
        if self.clickCallback then
            self.clickCallback()
        end    
    end
end

function OverseaClubFeedingFoodNode:Select(flag)
    self.inData.select = flag
    self:RefreshUI()
end

return OverseaClubFeedingFoodNode