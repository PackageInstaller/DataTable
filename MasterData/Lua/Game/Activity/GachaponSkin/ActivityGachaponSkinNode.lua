
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local KTool = CS.Engine.Lib.KTool

---@class ActivityGachaponSkinNode
---@field Env                           	ActivityGachaponSkinNode                  
---@field GoodeNodeEnv                    	GoodNodeMB
local ActivityGachaponSkinNode = Class('ActivityGachaponSkinNode')
function ActivityGachaponSkinNode:__init()
    self.GoodData = nil
end


function ActivityGachaponSkinNode:__delete()
    self.GoodeNodeEnv = nil
    self.GoodData = nil
end


function ActivityGachaponSkinNode:Awake()
    local GoodNode = self.controller.transform:Find("GoodNode")
    if isNotNull(GoodNode) then
        local Env =  CfUtils.GetLuaScr(GoodNode, "Game.Behaviours.GoodNodeMB")
        self.GoodeNodeEnv = Env    
    end
    local GetName = "UIFX_GachaponSkin_Good_Get"
    local Node = self.controller.transform:Find(GetName)
    if isNotNull(Node) then
        self.UIFX_GachaponSkin_Good_Get = Node
    end
end

function ActivityGachaponSkinNode:RefreshData(data)
    self.GoodData = data
    local isGet = self:IsGet()
    local goodData = data.rewards[1]
    if isGet then
        KTool.SetActive(self.UIFX_GachaponSkin_Good_Get.gameObject , true)  
        CfUtils.PlayAnimation(self.controller.gameObject ,"GachaponSkinEntry_GoodItem_Get_Loop")   
    else    
        KTool.SetActive(self.UIFX_GachaponSkin_Good_Get.gameObject , false)  
    end 
    -- 刷新数据
    self.GoodeNodeEnv:Reload({
        id = goodData.goodsId,
        goodsId = goodData.goodsId,
        isShowNo = true , 
        text ="x" .. goodData.num 
    })
    self.GoodeNodeEnv:SetClickButtonAction(function(goodsId)
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if isTable(vo) then
            local goodsType = GoodsUtils.GetIdType(goodsId)
            if goodsType == Constants.IDType.CardSkin then
                CfUtils.DialogOpen(Constants.UITypeIds.CommonStylePreView, {skinId = goodsId}, {
                    {id = CS.Engine.UI.UIModule.CurrentScreen:LastDialog().Argument.id}, 
                    {id = Constants.UITypeIds.UIHomeView}
                }, true)
            else
                GameUtils.ShowCommonTipsBoard(self.controller.gameObject, vo.name, vo.desc, vo.quality, vo.id)
            end
        end
    end)
    if #data.rewards > 1 then
        for  i = #data.rewards, 2 , -1 do 
            local CommonPlayerHeadNode = self.controller.transform:Find("CommonPlayerHeadNode" .. i - 1)
            local goodsId = data.rewards[i].goodsId
            if isNotNull(CommonPlayerHeadNode) then
                ---@type CommonPlayerHeadNode
                local Env =  CfUtils.GetLuaScr(CommonPlayerHeadNode, "Game.Behaviours.CommonPlayerHeadNode")
                Env:FreshFrame(goodsId,true)
                Env:SetCallBack(function()
                    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
                    if isTable(vo) then
                        local goodsType = GoodsUtils.GetIdType(goodsId)
                        if goodsType == Constants.IDType.CardSkin then
                            CfUtils.DialogOpen(Constants.UITypeIds.CommonStylePreView, {skinId = goodsId}, {
                                {id = CS.Engine.UI.UIModule.CurrentScreen:LastDialog().Argument.id}, 
                                {id = Constants.UITypeIds.UIHomeView}
                            }, true)
                        else
                            GameUtils.ShowCommonTipsBoard(self.controller.gameObject, vo.name, vo.desc, vo.quality, vo.id)
                        end
                    end
                end)
            end
            
        end         
    end

end
-- 奖励是否获取
function ActivityGachaponSkinNode:IsGet()
    --TODO 更具传进来的数据做判断
    return self.GoodData.isGet
end

function ActivityGachaponSkinNode:PlayGetting()
    KTool.SetActive(self.UIFX_GachaponSkin_Good_Get.gameObject , true)  
    CfUtils.PlayAnimation(self.controller.gameObject ,"GachaponSkinEntry_GoodItem_Getting")  
end



function ActivityGachaponSkinNode:Start()

end



function ActivityGachaponSkinNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end
return ActivityGachaponSkinNode
