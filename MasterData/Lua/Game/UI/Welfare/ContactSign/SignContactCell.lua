local KTool = CS.Engine.Lib.KTool
--- from: Assets/BundleResources/Prefabs/DailyCheck/DailyCheck3.prefab > name: Cell
---@class SignContactCell
---@field Env                           	SignContactCell                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GoodNode                      	Engine.Modules.LuaBehaviour             	@ 0    
---@field ImgPoint                      	UnityEngine.RectTransform               	@ 1    
---@field redPoint                      	UnityEngine.RectTransform               	@ 2    
---@field TextDate                      	UnityEngine.RectTransform               	@ 3    
---@field UIFX_GetEffectGlow            	UnityEngine.RectTransform               	@ 4    
local SignContactCell = Class('SignContactCell')


function SignContactCell:__init()
end


function SignContactCell:__delete()
    
    
end


function SignContactCell:Awake()
end

---@param status Constants.GetStatus
function SignContactCell:RefreshUI(data , totalDay  , cb )

    local rewardId =  data.rewards[1].goodsId 
    local rewardNum =  data.rewards[1].num 
    local times =  data.day 
    local hasDrawn = checkInt(data.hasDrawn) 
    ---@type GoodNodeMB
    local ENV =  self.GoodNode.Env
    if isNull(self.GoodNode.Env) then
        self.GoodNode:Init()
        ENV = self.GoodNode.Env
    end
    ENV:Reload({
        goodsId = rewardId , 
        isShowNo = true , 
        text = "x" .. rewardNum
    })    
    if checkInt(data.day) <= totalDay and hasDrawn < 1 then
        KTool.SetActive(self.UIFX_GetEffectGlow , true) 
        KTool.SetActive(self.redPoint , true)
    else 
        KTool.SetActive(self.redPoint , false) 
        KTool.SetActive(self.UIFX_GetEffectGlow , false) 
    end
    CfUtils.FillText(self.TextDate , localize("_num_天" ,{_num_ = times}))
    if hasDrawn == 1 then
        ENV:SetSanXingGainShow(true)
        ENV:SetMarkGrayAlpha(true , 0.6)
    else 
        ENV:SetSanXingGainShow(false)
        ENV:SetMarkGrayAlpha(false ,1)
    end
    

    ENV:SetClickButtonAction(function(goodsId)
        if (hasDrawn == 1) or  checkInt(data.day) > totalDay   then
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(rewardId)
            GameUtils.ShowCommonTipsBoard(ENV.controller.gameObject, vo.name, vo.desc, vo.quality, vo.id, true)   
            return          
        end
        
        cb(data.day)
    end)
end


function SignContactCell:Start()

end


function SignContactCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return SignContactCell
