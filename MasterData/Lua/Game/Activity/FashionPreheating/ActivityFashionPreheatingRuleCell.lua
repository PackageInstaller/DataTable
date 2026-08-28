local KTool = CS.Engine.Lib.KTool
--- from: Assets/BundleResources/Prefabs/Activity/ActivityNewReleaseMember.prefab > name: RoleCell
---@class ActivityFashionPreheatingRuleCell
---@field Env                           	ActivityFashionPreheatingRuleCell       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextNumber                    	UnityEngine.RectTransform               	@ 0    
---@field TxtTitle                      	UnityEngine.RectTransform               	@ 1    
---@field CommonGoodsListLight          	Engine.Modules.LuaBehaviour             	@ 2    
local ActivityFashionPreheatingRuleCell = Class('ActivityFashionPreheatingRuleCell')


function ActivityFashionPreheatingRuleCell:__init()
end


function ActivityFashionPreheatingRuleCell:__delete()
end


function ActivityFashionPreheatingRuleCell:Awake()
end


function ActivityFashionPreheatingRuleCell:Start()
end

----@param vo FashionPreheatingPoolVo
----@param num number 
function ActivityFashionPreheatingRuleCell:RefreshUI(vo , num)
    local grandReward = vo.grandReward
    if grandReward == 1 then
        CfUtils.FillText(self.TxtTitle, localize("剩余库存：_num_" , {_num_ = vo.stock - num }) )
        KTool.SetActive(self.TxtTitle.gameObject , true)
    else 
        KTool.SetActive(self.TxtTitle.gameObject , false)
    end
    CfUtils.FillText(self.TextNumber  , vo.showProbability / 100 .."%")
    CfUtils.RefreshCommonGoodsListLight(self.CommonGoodsListLight, {
        [1] = {
            goodsId = vo.rewardId,
            num  = vo.rewardNum,
        }
     }) 
end


function ActivityFashionPreheatingRuleCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityFashionPreheatingRuleCell
