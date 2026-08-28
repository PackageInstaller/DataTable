---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarTimeTableNode.prefab > name: OverseaClubCatCarTimeTableNode
---@class OverseaClubCatCarTimeTableNode
---@field Env                           	OverseaClubCatCarTimeTableNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtDate                       	UnityEngine.RectTransform               	@ 0    
---@field TextNumber                    	UnityEngine.RectTransform               	@ 1    
---@field StatusUnknown                 	UnityEngine.RectTransform               	@ 2    
---@field StatusFinish                  	UnityEngine.RectTransform               	@ 3    
---@field TxtPoint                      	UnityEngine.RectTransform               	@ 4    
---@field StatusMiss                    	UnityEngine.RectTransform               	@ 5    
---@field StatusDrawPrize               	UnityEngine.RectTransform               	@ 6    
---@field StatusBoss                    	UnityEngine.RectTransform               	@ 7    
---@field Today                         	UnityEngine.RectTransform               	@ 8    
local OverseaClubCatCarTimeTableNode = Class("OverseaClubCatCarTimeTableNode")

---@class OverseaClubCatCarTimeTableNode.InputData
---@field date string
---@field number string
---@field status number 1:dice 2:boss 3:drawPrize
---@field point number
---@field today number 1:小于今天 2:等于今天 3:大于今天


function OverseaClubCatCarTimeTableNode:__init()
    self.controller = nil
end

function OverseaClubCatCarTimeTableNode:__delete()
    self.controller = nil
end

function OverseaClubCatCarTimeTableNode:Awake()
end

---@param inData OverseaClubCatCarTimeTableNode.InputData
function OverseaClubCatCarTimeTableNode:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarTimeTableNode:RefreshUI()
    CfUtils.FillText(self.TxtDate, self.inData.date)
    CfUtils.FillText(self.TextNumber, self.inData.number)
    --dice
    CfUtils.SetActive(self.StatusUnknown, self.inData.status == 1 and self.inData.today >2)
    CfUtils.SetActive(self.StatusFinish, self.inData.status == 1 and  self.inData.today == 2 or (self.inData.today == 1 and self.inData.point > 0))
    CfUtils.SetActive(self.StatusMiss, self.inData.status == 1 and  self.inData.today == 1 and self.inData.point == 0)
    
    CfUtils.SetActive(self.StatusDrawPrize, self.inData.status == 3)
    CfUtils.SetActive(self.StatusBoss, self.inData.status == 2)
    CfUtils.SetActive(self.Today, self.inData.today == 2)
    CfUtils.FillText(self.TxtPoint, self.inData.point)
    local txtNumberState = 1
    if self.inData.today > 1 then
        txtNumberState = 1
    elseif self.inData.point == 0 and self.inData.status == 1 then
        txtNumberState = 3
    else
        txtNumberState = 2
    end
    CfUtils.SetUISwitchText(self.TextNumber, txtNumberState)
end

return OverseaClubCatCarTimeTableNode