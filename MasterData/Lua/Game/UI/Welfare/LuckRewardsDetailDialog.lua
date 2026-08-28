local GameObject = CS.UnityEngine.GameObject        
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ResidentEvent/ResidentLuckyRewardPopup.prefab > name: ResidentLuckyRewardPopup
---@class LuckRewardsDetailDialog
---@field Env                           	LuckRewardsDetailDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CommonRewardNode              	UnityEngine.RectTransform               
---@field SuperRewardNode               	UnityEngine.RectTransform               
---@field BtnClose                      	UnityEngine.RectTransform               
---@field TxtNum                        	UnityEngine.RectTransform               
---@field CommonUITitleNode2            	Engine.Modules.LuaBehaviour     
local UIModule = CS.Engine.UI.UIModule
local LuckRewardsDetailDialog = Class('LuckRewardsDetailDialog')


function LuckRewardsDetailDialog:__init()
    self.currentData = {}
end


function LuckRewardsDetailDialog:__delete()
    self.currentData = nil
end


function LuckRewardsDetailDialog:Awake()
    CfUtils.SetAddSortingOrder(self.controller ,100)
    SetButtonAction(self.BtnClose , function ()
        UIModule.BackDialog()
    end)
end


function LuckRewardsDetailDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.currentData = initParams.currentData
        self:InitSuperGoodNode()
        self:InitCommonGoodNode()
        self:InitText()
    end)
end
function LuckRewardsDetailDialog:InitText()
    local rewardNum = 0 
    local count = 0 
    for k, v in pairs(self.currentData) do
        
        for kk, vv in pairs(v) do
            count = count +1
            if vv.isRewards then
                rewardNum =  rewardNum + 1
            end
        end
    end
    CfUtils.FillText(self.TxtNum ,localize("剩余:_num1_/_num2_",{_num1_ = count -rewardNum   , _num2_ =count}) ) 
end
function LuckRewardsDetailDialog:InitSuperGoodNode()
    for i =1 , 3 do
        local SuperRewardNode = GameObject.Instantiate(self.SuperRewardNode , self.SuperRewardNode.transform.parent) 
        local GoodNode = SuperRewardNode.transform:Find("GoodNode")
        ---@type GoodNodeMB
        local scr = CfUtils.GetLuaScr(GoodNode, "Game.Behaviours.GoodNodeMB")
        KTool.SetActive(SuperRewardNode,true)
        local vo = self.currentData[tostring(i)][1].vo
        scr:Reload({
            goodsId = vo.rewards.goodsId,
            isShowNo = true,
            text = "x" .. vo.rewards.goodsNum
        })
        if self.currentData[tostring(i)][1].isRewards then
            scr:SetSanXingGainShow(true)    
        end
        local goodsVo =  GoodsConfMgr:GetInstance():GetGoodsVoById(vo.rewards.goodsId)
        scr:SetClickButtonAction(function ()
            local goodsVo  = GoodsConfMgr:GetInstance():GetGoodsVoById(vo.rewards.goodsId)
            GameUtils.ShowCommonTipsBoard(SuperRewardNode, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id, true) 
        end)
    end
end
function LuckRewardsDetailDialog:InitCommonGoodNode()
    for i = 4 , 5 do
        for k, v in pairs(self.currentData[tostring(i)]) do
            local CommonRewardNode = GameObject.Instantiate(self.CommonRewardNode , self.CommonRewardNode.transform.parent) 
            ---@type GoodNodeMB
            KTool.SetActive(CommonRewardNode,true)
            local GoodNode = CommonRewardNode.transform:Find("GoodNode")
            local scr = CfUtils.GetLuaScr(GoodNode, "Game.Behaviours.GoodNodeMB")
            local vo = v.vo
            scr:Reload({
                goodsId = vo.rewards.goodsId,
                isShowNo = true,
                text = "x" .. vo.rewards.goodsNum
            })
            local goodsVo =  GoodsConfMgr:GetInstance():GetGoodsVoById(vo.rewards.goodsId)
            scr:SetClickButtonAction(function ()
                local goodsVo  = GoodsConfMgr:GetInstance():GetGoodsVoById(vo.rewards.goodsId)
                GameUtils.ShowCommonTipsBoard(CommonRewardNode, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id, true) 
            end)
            if v.isRewards then
                scr:SetSanXingGainShow(true)    
            end
        end 
    end
end


function LuckRewardsDetailDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return LuckRewardsDetailDialog
