--- from: Assets/BundleResources/Prefabs/CustomTrain/CustomTrainMainDialog_State.prefab > name: CustomTrainMainDialog_State
---@class CustomTrainNode
---@field Env                           	CustomTrainNode                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgState                      	UnityEngine.RectTransform               	@ 0    
---@field Power                         	UnityEngine.RectTransform               	@ 1    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 2    
---@field TxtTitle                      	UnityEngine.RectTransform               	@ 3    
---@field Select                        	UnityEngine.RectTransform               	@ 4    
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 5    
local CustomTrainNode = Class('CustomTrainNode')


function CustomTrainNode:__init()
end


function CustomTrainNode:__delete()
end


function CustomTrainNode:Awake()

end


function CustomTrainNode:RefreshUI(name , battlePoint , callback , index)
    SetButtonAction(self.AnimRoot.gameObject , function ()
        callback(index)
    end )
    local battlePoints =  string.split(battlePoint , ";")
    CfUtils.FillText(self.TxtTitle , name)
    if isNull(battlePoints[2]) or string.isEmpty(battlePoints[2]) then
        CfUtils.FillText(self.TxtNum ,battlePoints[1])
    else 
        CfUtils.FillText(self.TxtNum ,battlePoints[1] .. "-" .. battlePoints[2])
    end
end

function CustomTrainNode:SetSelect(isSelect)
    CfUtils.SetActive(self.Select , isSelect) 
    CfUtils.SetUISwitchImage(self.ImgState , isSelect and  2 or 1)
end

function CustomTrainNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return CustomTrainNode
