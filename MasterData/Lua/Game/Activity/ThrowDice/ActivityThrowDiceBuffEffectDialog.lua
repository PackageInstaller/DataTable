--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyBuffChooseDialog140004.prefab > name: ActivityMonopolyBuffChooseDialog140004
---@class ActivityThrowDiceBuffEffectDialog
---@field Env                           	ActivityThrowDiceBuffEffectDialog       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BuffNode                      	UnityEngine.RectTransform               	@ 0    
---@field BuffNodeRoot                  	UnityEngine.RectTransform               	@ 1    
---@field GetRewardNode                 	UnityEngine.RectTransform               	@ 2    
---@field ChooseBuffTitle               	UnityEngine.RectTransform               	@ 3    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 4    
---@field TextDesc                      	UnityEngine.RectTransform               	@ 5    
local ActivityThrowDiceBuffEffectDialog = Class('ActivityThrowDiceBuffEffectDialog')

local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
function ActivityThrowDiceBuffEffectDialog:__init()
    self.isSelected = true 
    self.triggerBuffs = nil
    self.activityUuid = nil

end


function ActivityThrowDiceBuffEffectDialog:__delete()
    self.isSelected = nil
    self.triggerBuffs = nil
    self.activityUuid = nil
end


function ActivityThrowDiceBuffEffectDialog:Awake()
    
end


function ActivityThrowDiceBuffEffectDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams    = self.controller.Argument.parameters or {}
        local triggerBuffs  = initParams.triggerBuffs
        self.isSelected = #triggerBuffs > 1
        self.triggerBuffs = triggerBuffs
        self.activityUuid = initParams.activityUuid
        self:RefreshUI()
    end)
end

function ActivityThrowDiceBuffEffectDialog:RefreshUI()
    local transform = self.BuffNode.parent.transform
    for i = 1, #self.triggerBuffs do
        local buffNode =  transform:Find("BuffNode_" .. self.triggerBuffs[i])
        if isNull(buffNode) then
            buffNode = CfUtils.InstantiateGo(self.BuffNode.gameObject , self.BuffNode.parent.gameObject , false)    
            buffNode.gameObject.name = "BuffNode_" .. self.triggerBuffs[i]
            KTool.SetActive(buffNode , true)
        end
        ---@type ActivityThrowDiceBuffEffectNode
        local ActivityThrowDiceBuffEffectNode = CfUtils.GetLuaScr(buffNode ,"Game.Activity.ThrowDice.ActivityThrowDiceBuffEffectNode")
        ActivityThrowDiceBuffEffectNode:RefreshUI(self.triggerBuffs[i] , self.isSelected , function (buffId)
            if self.isSelected then
                GameUtils.Request(Interfaces.ActivityEvolveRoadBuffChoose , {activityUuid = self.activityUuid ,  buffId = buffId} ,function ()
                    Events.Broadcast("ActivityThrowDiceBuffEffect" , {buffId = buffId})    
                    UIModule.CloseDialog(self.controller)
                end)
            end
        end)
    end  
    
    KTool.SetActive(self.BtnClose , not self.isSelected)
    KTool.SetActive(self.TextDesc , self.isSelected)
    
end



function ActivityThrowDiceBuffEffectDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end



return ActivityThrowDiceBuffEffectDialog
