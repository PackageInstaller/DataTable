---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarTrackRewardPopup.prefab > name: Cell
---@class OverseaClubCatCarTapCell
---@field Env                           	OverseaClubCatCarTapCell                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgNor                        	UnityEngine.RectTransform               	@ 0    
---@field TxtTabName                    	UnityEngine.RectTransform               	@ 1    
---@field ImgGrade                      	UnityEngine.RectTransform               	@ 2    
---@field ImgSelect                     	UnityEngine.RectTransform               	@ 3    
---@field TxtTabNameSelect              	UnityEngine.RectTransform               	@ 4    
---@field ImgGradeSelect                	UnityEngine.RectTransform               	@ 5    
local OverseaClubCatCarTapCell = Class("OverseaClubCatCarTapCell",import("Game.Behaviours.CommonTabToggleUpCell"))

---@class OverseaClubCatCarTapCell.InputData
---@field text string
---@field grade number
---@field func function

function OverseaClubCatCarTapCell:__init()
    self.controller = nil
end

function OverseaClubCatCarTapCell:__delete()
    self.controller = nil
end

function OverseaClubCatCarTapCell:Awake()
    SetButtonAction(self.controller.gameObject, function()
        if type(self.__callback) == 'function' then
            self.__callback()
        end
    end)
end

---@param data OverseaClubCatCarTapCell.InputData
function OverseaClubCatCarTapCell:FreshBaseUI(data)
    --CfUtils.FillText(self.TxtTabName, data.text)
    --CfUtils.FillText(self.TxtTabNameSelect, data.text)
    --local img = 
    --CfUtils.FillImage(self.ImgGrade, OverseaClubCatCarUtils:GetGradeImgName_1(data.grade))
    CfUtils.SetUISwitchImage(self.ImgGrade,data.grade)
    --CfUtils.FillImage(self.ImgGradeSelect, OverseaClubCatCarUtils:GetGradeImgName_1(data.grade))
    CfUtils.SetUISwitchImage(self.ImgGradeSelect,data.grade)
end

function OverseaClubCatCarTapCell:FreshSelectStatus(isSelected)
    CfUtils.SetActive(self.ImgSelect, isSelected)
    CfUtils.SetActive(self.ImgNor, not isSelected)
end

return OverseaClubCatCarTapCell