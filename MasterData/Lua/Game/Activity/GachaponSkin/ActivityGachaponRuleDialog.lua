--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinMember.prefab > name: GachaponSkinMember
---@class ActivityGachaponRuleDialog
---@field Env                           	ActivityGachaponRuleDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ReferenceGroup                	UnityEngine.RectTransform               
---@field Line10                        	UnityEngine.RectTransform               
---@field Line9                         	UnityEngine.RectTransform               
---@field Line8                         	UnityEngine.RectTransform               
---@field Line7                         	UnityEngine.RectTransform               
---@field Line6                         	UnityEngine.RectTransform               
---@field Line5                         	UnityEngine.RectTransform               
---@field Line4                         	UnityEngine.RectTransform               
---@field Line3                         	UnityEngine.RectTransform               
---@field Line2                         	UnityEngine.RectTransform               
---@field Line1                         	UnityEngine.RectTransform               
---@field CloseEmpty                    	UnityEngine.RectTransform               
---@field ButtonClose                   	UnityEngine.UI.Button                   
---@field ScrollBar                     	UnityEngine.RectTransform               
---@field EnsuranceMain                 	UnityEngine.RectTransform               
---@field EnsuranceTitle                	UnityEngine.UI.Text                     
---@field MemberGroup                   	UnityEngine.RectTransform               
---@field Ensurance                     	UnityEngine.RectTransform               
local ActivityGachaponRuleDialog = Class('ActivityGachaponRuleDialog')
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

function ActivityGachaponRuleDialog:__init()
    self.probability = nil
    self.ruleId = 1111
end


function ActivityGachaponRuleDialog:__delete()
    self.probability = nil
    self.ruleId = nil
    if self.co  then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
end


function ActivityGachaponRuleDialog:Awake()
    SetButtonAction(self.CloseEmpty , function ()
        UIModule.CloseDialog(self.controller)
    end)
    SetButtonAction(self.ButtonClose , function ()
        UIModule.CloseDialog(self.controller)
    end)
end



function ActivityGachaponRuleDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.ruleId = initParams.ruleId
        local interface = Interfaces.ActivitySkinCallProbability
        if isSet(initParams,"type") then
            interface = Interfaces.ActivitySkinTreasureProbability
        end
        GameUtils.Request(interface , {activityUuid = initParams.activityUuid } ,function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            self.probability = response.data.probability
            KTool.SetActive(self.ReferenceGroup.gameObject ,true)
            self:InitRuleText()
            self:InitCell()
        end)
        
    end)
end


function ActivityGachaponRuleDialog:InitRuleText()
    local row = CfUtils.GetCfLine(AutoIds.IdSetting12, self.ruleId)

    if isNotNull(row) then
        local text = parse_localizeText(row, "descr", true, "")
        CfUtils.FillText(self.EnsuranceMain , text)
    end
end



function ActivityGachaponRuleDialog:InitCell()
    self.co = cs_coroutine.start(function()
        for i =1 , 10 do
            ---@type UnityEngine.RectTransform               
            local Line =  self["Line" .. i] 
            local transform = Line.transform 
            KTool.SetActive(Line , true)
            local GoodNode = transform:Find("GoodNode")
            ---@type GoodNodeMB
            local Env = CfUtils.GetLuaScr(GoodNode.gameObject , "Game.Behaviours.GoodNodeMB")
            local reward = self.probability[i].rewards[1]
            Env:Reload({  
                goodsId =  reward.goodsId,
                id = reward.goodsId,
                isShowNo = true , 
                text = "x" .. reward.num 
            })
            Env:SetClickButtonAction(function(goodsId)
                local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
                if isTable(goodsVo) then
                    GameUtils.ShowCommonTipsBoard(GoodNode.gameObject, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
                end
            end)
            for j =1 , 10 do
                local Text =  transform:Find("Text" .. j)
                CfUtils.FillText(Text , self.probability[i].probability[j] .. "%")
            end
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))
        end
    end)
   
end

function ActivityGachaponRuleDialog:OnFinalize()
    return CoWaitDo(function()
       
        self.controller = nil --删除lua层引⽤用到的c#对象
        
        self:Delete()
    end)
end


return ActivityGachaponRuleDialog
